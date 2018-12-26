Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2638B211B9
	for <e@80x24.org>; Wed, 26 Dec 2018 22:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbeLZWWo (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Dec 2018 17:22:44 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45416 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727586AbeLZWWn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Dec 2018 17:22:43 -0500
Received: by mail-wr1-f67.google.com with SMTP id t6so16704448wrr.12
        for <git@vger.kernel.org>; Wed, 26 Dec 2018 14:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jPSlYQotye62lEwDdmfXXuOMGaXKuyGssVwPGvOMDsI=;
        b=IIQtF5+geYsxl5dt5rya4PW/8ps35G6pMI77+q5rMpDEWCaCYZKS5d9tp5rCm3FBSC
         REnFT2kxcXIISk8VNHiDtzMgotX/cO0N20ctxqvh0egGMbfNBB7Wuf1CjJ+x7UdkdwFV
         sm8zfUUCVtRGREbrVWdU72Fd6LlMnBhMWPvueuuto2E+Uqq/g/Y3jxM09lfEiEE2xrCe
         Yx3+Cba63aJA9mNYrK6tnrssoy22tyg0togDOThY81yYhH4Mv6GNXj1MAu+Q62SRxPGR
         akZganor34a4flcSycjQGYUYXEqhMNLQZ3JQoOECSxe3uYmARr76JXHXn1xAK6o34mOT
         +VOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jPSlYQotye62lEwDdmfXXuOMGaXKuyGssVwPGvOMDsI=;
        b=fJNpxGRyVeG3FHtBIunVdGPR9xFAsY6Sa3YdsQreAD5KwInIvWEmGLorma289W2uBm
         OmxM47bNa4WEUPoW9Qj5/NhSKInQ9Sf8L4e7Dp0w7gxodqwfnXknWHDw43iPXF/Gp/Ju
         FkSM3N5w7zAv3tlnyuYLpl45Ndc8ki2CUPDw5KR9G8LwX5wHsGMek/pBwS3PvgUcwF64
         +oi4wlKqnosoVcwe+E+pg74ojXutQzzvAZ7mXK/Liaq3C2MpgKTJS5w9Pf4AUgvLWkTT
         u8z24zgtpdp1GUSU423XagEXIpYxlHfK4lC7KTQKB7l/T+9tJu9TM9ahIWTVJ9zk0B0O
         0S0w==
X-Gm-Message-State: AJcUukcXapoMPOkCWpBhidXTSUKKKq3G+s2stWdO+s4RAaKAO6E4f9Tw
        luunEJsIX+yNSP123n34cW8=
X-Google-Smtp-Source: ALg8bN62fd+tAVcNeqDNryX7WqkIxs1wUrzqx3PBaMNRJ4EurUolamLgOR3l1tlfMin54dgta4LRyA==
X-Received: by 2002:adf:dd06:: with SMTP id a6mr20928327wrm.2.1545862961008;
        Wed, 26 Dec 2018 14:22:41 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t5sm27986566wmd.15.2018.12.26.14.22.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Dec 2018 14:22:40 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Erin Dahlgren <eedahlgren@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2] Simplify handling of setup_git_directory_gently() failure cases.
References: <1544722211-13370-1-git-send-email-eedahlgren@gmail.com>
        <1544922308-740-1-git-send-email-eedahlgren@gmail.com>
        <20181218175418.GB31070@sigill.intra.peff.net>
        <CAP_Smy14j4WK-mkqdKTKue=j7YoNjfaZVCBA-7S8xwNqX2rKhQ@mail.gmail.com>
        <20181219155928.GE14802@sigill.intra.peff.net>
Date:   Wed, 26 Dec 2018 14:22:39 -0800
In-Reply-To: <20181219155928.GE14802@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 19 Dec 2018 10:59:28 -0500")
Message-ID: <xmqqftukq66o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 18, 2018 at 12:54:02PM -0800, Erin Dahlgren wrote:
> ...
>> GIT_DIR_HIT_MOUNT_POINT. I'm not sure how important of a guarantee it
>> is, but we should respect what's documented.
>
> Yeah, agreed.
>
> Another benefit of avoiding the early return is that we hit the cleanup
> code at the end of the function. That saves us having to release "dir"
> here. I assume we don't have to care about "gitdir" in these cases, but
> hitting the cleanup code means we don't even have to think about it.
>
> Over in:
>
>   https://public-inbox.org/git/20181219154853.GC14802@sigill.intra.peff.net/
>
> I suggested adding more cleanup to that block, too (though I _think_ in
> these cases it would also be a noop, it's again nice to not have to
> worry about it).
>
>> Side note: One of the secondary goals of my patch was to make it
>> really obvious that neither the GIT_DIR_HIT_CEILING nor the
>> GIT_DIR_HIT_MOUNT_POINT case can get us into the block protected by
>> (startup_info->have_repository || getenv(GIT_DIR_ENVIRONMENT)). With
>> your suggestion (and it's a fair one) I don't think that's feasible
>> without more significant refactoring. Should I just settle with a
>> comment that explains this?
>
> Yeah, I think a comment would probably be sufficient. Though we could
> also perhaps make the two cases (i.e., we found a repo or not) more
> clear. Something like:
>
>   if (!*nongit_ok || !*nongit_ok) {

WTH is (A || A)?

> 	startup_info->have_repository = 1;
> 	startup_info->prefix = prefix;
> 	if (prefix) ...etc...
>   } else {
> 	start_info->have_repository = 0;
> 	startup_info->prefix = NULL;
> 	setenv(GIT_PREFIX_ENVIRONMENT, "", 1);
>   }
>
> That may introduce some slight repetition, but I think it's probably
> clearer to deal with the cases separately (and it saves earlier code
> from make-work like setting prefix=NULL when there's no repo).

Sounds good.

Thanks both.
