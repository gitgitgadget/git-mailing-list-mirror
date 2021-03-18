Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3895DC433E6
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:59:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0694A64F59
	for <git@archiver.kernel.org>; Thu, 18 Mar 2021 21:59:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233258AbhCRV7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Mar 2021 17:59:03 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54444 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbhCRV6g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Mar 2021 17:58:36 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90291B3F4B;
        Thu, 18 Mar 2021 17:58:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eLSECJ0HXiY4+uiS3TWh2f42sLo=; b=lI/XZz
        BELHC23kCwH6DzoZuvoGFhZT/Y+5VLvCOr0ta7KeTK7BU45K5CIJKgbzlzgr7sch
        xNFgJESCVeFoOd0E5EVhau0F6Uxeh8UVJe/wy8Q2LMqIutwEeavklOsekZ6XVp07
        WwJ7h0iBNken7HxOSq9AIn/mPlgAijMetGL50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k6vwiqBnAC1UdbWn+pfz2vjuGul8tx4o
        qaWNQY6D12pXlIJbTwee/2Tw691N2i59dUDV6YHfSVWR7doDTSYZT3Um5zEOYwwU
        FOYBS3SukkweRMe4/T0AfAMuOvzYJbSAOOmjiLA4gJorLNuyIJ9NWF6uzq7MRLGR
        ZTTFXvFT5cQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86C05B3F49;
        Thu, 18 Mar 2021 17:58:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id ED743B3F48;
        Thu, 18 Mar 2021 17:58:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RESEND PATCH 0/3] git-completion.bash: improvements to
 _git_stash()
References: <cover.1615855962.git.liu.denton@gmail.com>
        <cover.1616060793.git.liu.denton@gmail.com>
Date:   Thu, 18 Mar 2021 14:58:34 -0700
In-Reply-To: <cover.1616060793.git.liu.denton@gmail.com> (Denton Liu's message
        of "Thu, 18 Mar 2021 02:46:53 -0700")
Message-ID: <xmqqv99oqg39.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 16129344-8835-11EB-AA6A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> This series modernises the _git_stash() completion handler by letting it
> take advantage of __gitcomp_builtin(). Also, it fixes a bug with how it
> offers completions when arguments are provided to the main git command.
>
> Denton Liu (3):
>   git-completion.bash: extract from else in _git_stash()
>   git-completion.bash: fix `git <args>... stash branch` bug
>   git-completion.bash: use __gitcomp_builtin() in _git_stash()
>
>  contrib/completion/git-completion.bash | 103 +++++++++++++------------
>  1 file changed, 52 insertions(+), 51 deletions(-)

Hmph, this comflicts with your own "stash show --include-untracked
and --only-untracked" completion patch d3c7bf73bdb67, it seems.  How
ready is that topic for 'master'?

