Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A55C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDBBE60EFF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 20:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbhJHUwe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 16:52:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58042 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbhJHUwb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 16:52:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B5CBEFBC4;
        Fri,  8 Oct 2021 16:50:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=mD3+5ZnxGRrRlSWM3zqXvAQZNBIaJi1F2U9cCOyTwYM=; b=XIsr
        jt/1WmKm3pFv59WTcIxBrGuyGXpAdEzZwFYzayFLKedo2SglWFPATB6C1nkQT3Xm
        LmcWvKsl2km65PyuUBlXn+NESpCvG0+kBKYbjYqm++P7terCZhKovZPK2emviEOl
        7xcZ10EZSTCYo1mtCuC45TiKvckuBGQVfrlpN30=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 420A7EFBC3;
        Fri,  8 Oct 2021 16:50:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8FE07EFBC2;
        Fri,  8 Oct 2021 16:50:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Subject: Re: [PATCH] completion: fix incorrect bash/zsh string equality check
References: <pull.1096.git.git.1633642772432.gitgitgadget@gmail.com>
Date:   Fri, 08 Oct 2021 13:50:33 -0700
Message-ID: <xmqqbl3zjl5y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 623EF1BA-2879-11EC-8133-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com> writes:

>     This fixes an error in contrib/completion/git-completion.bash caused by
>     the incorrect use of == (vs. single =) inside a basic [/test command.
>     Double-equals == should only be used with the extended [[ comparison.

Curious.  

Would it be equally a valid fix to use "=" instead of "==", or would
that change the meaning?  This is a bash-only piece of code, so use
of [[ ... ]] is not technically incorrect, but if the basic [] works
well enough with "=", we should prefer that.

Thanks.

