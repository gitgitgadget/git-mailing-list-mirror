Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236AF1F453
	for <e@80x24.org>; Wed, 26 Sep 2018 19:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbeI0BqL (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 21:46:11 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38179 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbeI0BqL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 21:46:11 -0400
Received: by mail-wr1-f65.google.com with SMTP id j8-v6so123277wrw.5
        for <git@vger.kernel.org>; Wed, 26 Sep 2018 12:31:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dmB6qWWI17boId/b/2VknAe5rBDqWxbCjtAk5crlXA8=;
        b=t/ASRhPeyQ5Trb4yXklSWaJ5Y+M/c0Q/Tr4u9DVLO0GIETem1cSLt3sW89h+uC11HV
         Wa1BgeFApllSMG1sTQGFEvxCsH1ionMKBWOuE/7dgN8YM7mo1rpvBRrLqkItszAh5re/
         Yivj/V2HAdGFY0NzBgs2b1fTtKXv6m7XwrVw+ThzNiDIS+NtocjSwwlheILBHqPmr6UK
         b8ri4MhqeMYoZuyhxLTsUzsKYkD5cKOh/uWQkx1zWew8Jxh5RGV+EwGR6Xn/mSHyU7n+
         CcZs+GNkWPWeql5ZT4xCRxCi4MUXjnpOxYp0U4aqtOlA65po+rlwbtspMq7e4EI6rz1O
         GfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dmB6qWWI17boId/b/2VknAe5rBDqWxbCjtAk5crlXA8=;
        b=L/RamSRWIhfl0OZkOMkDlcVU86SRvJYB3iXvosYSd7ybvOuNEXiQC6qYfErAAnTBDk
         IOR1yZKDWK5gjk09LMPtqq0fascLtC9NQddDJHxfFb83bfaBphrSII1NO4uK/PyyM0iy
         o3q2XZFGh1SEfumO2yTmkmP8syaMei62gxXSvNrSHCmUAuzSBkEt7cAkJ1noPwqLq8K2
         nVbWaQJeDF2Aklrmee5oSl6DlXKXxg4GbnZrRyIhK6ZfJbbaEM9dz9NiVXALpovE/YSI
         UHmvJpnHXwnAspibS9oLgyFeX2GtIhHG4SWK3yPr9oe37O+PwYDmtIIaqLFIvH2VeAmz
         JP8w==
X-Gm-Message-State: ABuFfojp2Rh7giFe/lQFTgebHwCdmYy5sWxBKhXW1fe2PPXwkSekM9Py
        eR02cXBvWA/9PtYT7c5jVHg=
X-Google-Smtp-Source: ACcGV62SD9WLOdiQ3vqGlGRnV6U/xo/WoyzEEsvRY1hYe4LYm/I0NwWm5htbfpwXYqaP/y0Cw76V/g==
X-Received: by 2002:adf:9e06:: with SMTP id u6-v6mr6067511wre.51.1537990300563;
        Wed, 26 Sep 2018 12:31:40 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a203-v6sm180839wmh.31.2018.09.26.12.31.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 26 Sep 2018 12:31:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Rasmus Villemoes <rv@rasmusvillemoes.dk>, git@vger.kernel.org
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
        <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com>
        <20180926184914.GC30680@sigill.intra.peff.net>
Date:   Wed, 26 Sep 2018 12:31:39 -0700
In-Reply-To: <20180926184914.GC30680@sigill.intra.peff.net> (Jeff King's
        message of "Wed, 26 Sep 2018 14:49:15 -0400")
Message-ID: <xmqqy3bojbs4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> When you have "[alias] cp = cherry-pick -n", "git cp --help" should
>> not do "git help cherry-pick".  Only a single word that exactly
>> matches a git command should get this treatment.
>
> I'm not sure I agree. A plausible scenario (under the rules I gave
> above) is:
>
>   $ git cp -h
>   'cp' is aliased to 'cherry-pick -n'
>   usage: git cherry-pick ...

With that additional rule, I can buy "it is fine for 'git cp --help'
to completely ignore -n and behave as if 'git help cherry-pick' was
given", I think.  People already expect "git cp --help" to give the
alias expansion, so to them any change will be a regression any way
we cut it---but I think this is the least bad approach.

>   $ git cp --help
>
> I.e., you already know the "-n" part, and now you want to dig further.

One very good thing about the "make '--help' go directly to the
manpage, while teaching '-h' to report also alias expansion" is that
people already expect "-h" is more concise than "--help".  The
current output from "git cp --help" violates that expectation, and
the change you suggest rectifies it.

> Of course one could just type "git cherry-pick --help" since you also
> know that, too.

Yeah, but that is not an argument.  The user aliased cp because
cherry-pick was quite a mouthful and do not want to type "git
cherry-pick --help" in the first place.
