Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 576A4C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 17:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbiHJRmi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbiHJRmX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 13:42:23 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0490B84EC6
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 10:42:21 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5639B131B61;
        Wed, 10 Aug 2022 13:42:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=f3FXd/w2Hf24E3gSVM6IzmpQ36ubKAPYEt1mNn
        lcYnA=; b=wAatmdFdDF4hOnOz96wT4uVor1ije3N4y1rVL6La3ao8KQlDI3JO/U
        QLSHTmFT/cWQxZkXtk6G7SIei/JQAfgCSFJaSQESudvHW7NnvZrfRijwkDqA3rV2
        OawDXcSI7Dxc95143pcMq1CEpdtx+8zpKtuurk5W7s8MYTsWXaOxY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 424EC131B5F;
        Wed, 10 Aug 2022 13:42:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9C3B3131B5B;
        Wed, 10 Aug 2022 13:42:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com, tboegi@web.de
Subject: Re: [PATCH v2 1/1] doc add: renormalize is not idempotent for CRCRLF
References: <xmqq5yj6z5rx.fsf@gitster.g>
        <20220810144450.470-1-philipoakley@iee.email>
        <20220810144450.470-2-philipoakley@iee.email>
Date:   Wed, 10 Aug 2022 10:42:18 -0700
In-Reply-To: <20220810144450.470-2-philipoakley@iee.email> (Philip Oakley's
        message of "Wed, 10 Aug 2022 15:44:50 +0100")
Message-ID: <xmqqh72km1vp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8560DC6-18D3-11ED-9A57-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 11eb70f16c..9b37f35654 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -188,7 +188,9 @@ for "git add --no-all <pathspec>...", i.e. ignored removed files.
>  	forcibly add them again to the index.  This is useful after
>  	changing `core.autocrlf` configuration or the `text` attribute
>  	in order to correct files added with wrong CRLF/LF line endings.
> -	This option implies `-u`.
> +	This option implies `-u`. Lone CR characters are untouched, thus
> +	while a CRLF cleans to LF, a CRCRLF sequence is only partially
> +	cleaned to CRLF.

Looks perfetly readable and understandable to me.

Thanks, will replace.  Let's plan to merge it down soonish.


