Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8835C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 23:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbiFFXKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 19:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiFFXKF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 19:10:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10BBEC9651
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 16:10:04 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75E84130D7D;
        Mon,  6 Jun 2022 19:10:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LdXOULEQehbdkU+I6YGU/iB+IOtPpV9HNSCr/K
        CbBcE=; b=YpZ02O3dBe1gxQeRmi+/vW1yOXzA7igmtGYqmfwEVOi730IHAUNOdX
        p++lqLJvn3QArbZP/aQk1SFl7YfsdbCxT4qMSueXL4g3Q+yPH1c97ce/1fPhCZe5
        3gsFEekOSpcyTPDuoQg6KaCD7Zs43fGh5SKWeuiQVf8pE7Fo7SjUI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D2798130D7B;
        Mon,  6 Jun 2022 19:10:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E5DBD130D76;
        Mon,  6 Jun 2022 19:09:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com
Subject: Re: [PATCH 2/2] builtin/show-ref.c: limit output with `--count`
References: <cover.1654552560.git.me@ttaylorr.com>
        <3fcf1f555715e925385d37712ffe880bb869741e.1654552560.git.me@ttaylorr.com>
Date:   Mon, 06 Jun 2022 16:09:58 -0700
In-Reply-To: <3fcf1f555715e925385d37712ffe880bb869741e.1654552560.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 6 Jun 2022 17:56:07 -0400")
Message-ID: <xmqqczfl4ce1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9EFBAA6-E5ED-11EC-8916-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> +--count::
> +
> +	Do not print more than `<n>` matching references, or print all
> +	references if `<n>` is 0. Incompatible with `--exclude-existing`
> +	and `--verify`.

I can easily understand why the option being incompatible with
"--verify", but I do not see a reason why this should not work with
"--exclude-existing" from end user's point of view.

I know it is processed in a completely separate code path, but that
does not stop end users from complaining.


