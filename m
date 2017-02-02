Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42E6F1F4E2
	for <e@80x24.org>; Thu,  2 Feb 2017 21:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751934AbdBBVGD (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Feb 2017 16:06:03 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32817 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751903AbdBBVGC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2017 16:06:02 -0500
Received: by mail-pf0-f195.google.com with SMTP id e4so4020pfg.0
        for <git@vger.kernel.org>; Thu, 02 Feb 2017 13:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MYEfIHo9ZkIM1XIMWaHbKB/s+ojE1KnnfAq7vV90uQU=;
        b=pEptTrNbysS5X0WW6vASv+7Tehs2gHQbavm3XK5yGbWldsRUdPSu9aQXDrhiinxp/O
         O4YKNC++XPr1AEgkpwYJcIHkRCfD25KeYPHTpx0CEACiJCUHtDPIBFquPdJ3ohKwNpJN
         SHgeDhdX2lzlY0S7NxbgtXv4mwSvxFUWMlzNAYFAiArOI8cmoep4Imb/Qo9YBxwL5B51
         kUYUKzYGYoVn2KAuyvjofEQiFzKsU5fY9xYiFn6g/UomNc23R7JsNj/EkNzdrGlj09yk
         CtKJBs9nqnunv44dCPFe9siZKnHVAmWUx8GI8+XL7hyo/B/bstsIGpV8RPf8C7udKMB2
         rk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=MYEfIHo9ZkIM1XIMWaHbKB/s+ojE1KnnfAq7vV90uQU=;
        b=GrfBuiv81CyX/tDLfPFHex16VqauSy/ESKCi2f6ykIxUzipg2OIBkDRvi4NWInKJ0p
         YqW0T73rpM36CXkqPofDlAKv4F+eFG/SnEqOMy2CekQ0L8GQ6piSaUN3gWC8RTWH/KuX
         SMjsT3420OyeFYGOdL8EXGMcS8OE9B96c8h2EhSJA+/KvU7G+NbmcvfvLg05PJhPU5li
         W/t1963gNazJqNkEzqUpnDD+FJeXXe/9I1r+oh6q2BDqSTZEiVGz83KfNmPqw+qiz3vf
         482HM5q3sThafONyqNkB/jJvgTkAzCRldnyl4Or4KI1qkKna9IjHB6SGMHxcoiuTqPP7
         +5WQ==
X-Gm-Message-State: AIkVDXIjzC9XSKfjI0mKfvFHHw7pbGNKi75uLwbYha6G2KibpTcL8fmEYNir7u96V3Vmug==
X-Received: by 10.84.233.136 with SMTP id l8mr15708198plk.169.1486069561225;
        Thu, 02 Feb 2017 13:06:01 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:358d:de5e:fbec:baab])
        by smtp.gmail.com with ESMTPSA id b10sm61431437pga.21.2017.02.02.13.05.59
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 02 Feb 2017 13:05:59 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] ls-remote: add "--diff" option to show only refs that differ
References: <alpine.LFD.2.20.1702021143470.21619@i7.lan>
        <xmqqshnws6ma.fsf@gitster.mtv.corp.google.com>
        <CA+55aFw14UXMa6OJ6YLHjy3tzOD+VSNytw6kMpaxFEfyuO2hAw@mail.gmail.com>
Date:   Thu, 02 Feb 2017 13:05:58 -0800
In-Reply-To: <CA+55aFw14UXMa6OJ6YLHjy3tzOD+VSNytw6kMpaxFEfyuO2hAw@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 2 Feb 2017 12:32:45 -0800")
Message-ID: <xmqqfujws3pl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I basically don't see downstream contributor doing ls-remote, it's a
> upstream maintainer command.
>
> But that may be a lack of imagination on my part.

I actually share that perception.  For the "downstream wonders about
the state of the origin" usecase, I would rather recommend "fetch",
either without "-n" (when the downstream does not value the current
state of refs/remotes/*) or with "-n" (when it does for whatever
reason).

>> When one contributor asks you to pull refs/heads/master you want to
>> go and see if it is different from refs/heads/master you have?
>
> No. What happens is that people ask me to do something like
>
>     git pull ..some-target.. tags/for-linus-3
>
> and the pull fails because there is no such tag. That's when I go "ok,
> they screwed up, let's see what they *meant* for me to pull", and I go
> "git ls-remote".

In that context, I fully agree that "--diff --tags" would help.  The
copies of your tags they have there would overwhelm what you are
really looking for in the output from the command.

And if they asked you to pull "for-linus-3" branch, which is buried
in many other branches (perhaps their publishing repository they ask
you to pull from is also serving as their back-up place, and the
local branches they use before coming up with something pull-able
are all there), then "--diff --refs" would still help by culling
tags that originated from you.

> I agree that it's a specialized case, but I also think it's the _main_
> case for ls-remote in the first place (apart from some scripting to
> check for updates or whatever).
>
> But maybe more people use ls-remote than I think they do (and in
> different ways than what I envision).

You and I are not the only folks in the world, but I agree with you
in thinking that "ls-remote" is not something you would use on
'origin' as a downstream contributor or a consumer.  

Another case I can think of that "--diff" would help is when you are
inspecting your own mirror (but that can be seen as a special case
of the "they have copies of yours plus their own", if you think of
your mirror as "them" and the difference is "being stale").
