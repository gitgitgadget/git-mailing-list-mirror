Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5E611F597
	for <e@80x24.org>; Fri, 27 Jul 2018 22:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389076AbeG0Xg2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:36:28 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55672 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730850AbeG0Xg2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:36:28 -0400
Received: by mail-wm0-f52.google.com with SMTP id f21-v6so6710490wmc.5
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 15:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iQvz+e8J/D2Yd9Yl0alWhd+RXmeYGIIZqn2zA6EiXQU=;
        b=dUzdc9lPpVFQGi3uQQaZEJpKdzINMNMfX+JFO1m1txQSDurSFvCjpjRtGX8SoMiiTV
         GBMiXo/dRKFHoR2jpmoRd0uilOvevBQSov9MKgaVeJB4dIUJ1e7fDeFsTgomiCCyN3C1
         X37SFd51a61mQ6Aw1iZ9eLk8yiCSRt6r3e+ZbVnzxUHnaFbsjEaRt7VLBSrna3WlLpSH
         rvLLrEkzT44Hru4zF7MRCLQlVapNx1DfmWZ0I3iNFxRpGvzy0v30QeqCOp3O1+oPX8fj
         bmRa9bkIEQX+bumLj3qhMjOKQIRE6mcdjjFENQvqEp7HjhCTJYKATTccidYZi+SlIvXu
         JXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iQvz+e8J/D2Yd9Yl0alWhd+RXmeYGIIZqn2zA6EiXQU=;
        b=kZ9bi8+P/S4pDZE55314Ow7dT/bCiJYak50vnmfpzR+9aUIzSB9mjkWZISRumRMknE
         QJUm4J/6Cn7bgKJcDBCGHK3u72EMUAV/zWjRoPx+FNL14pdGrbGhlsu9sv38M9hZDUfT
         ZDMPTekF9WgC5Pt1qsI4S+O0Bql4Q1WMuBUzfE/JJRNcp/2TGdI7BdIdMZ2ou6nLi/De
         6Ifq23h1CMmD7F9vYI1RuNFlD6eRvSJbVsw1jKYbLKZrKUYkHZz1rpqcIIR+lz+0Jdho
         e7YUuXVMGaodQMNAqQUZAoRzSc/3T+bgx+V2HYGtfKsz+q8HumW04fCB+F/mMoKrt9/X
         3gGg==
X-Gm-Message-State: AOUpUlG+q6yrIjM/WLwsqwwh37RLgaY984CbhT38CFzupYzk8Fy16gpH
        JCb/95CXSWU8e9y6YiagI17qTI93
X-Google-Smtp-Source: AAOMgpc/BwFaIJB2Yr4iBXgkF37fS8oAgUcQEGbav2tDRwUkuzn0wkTXifBIGnXp5msoth9NAhSHFQ==
X-Received: by 2002:a1c:c7c1:: with SMTP id x184-v6mr5719022wmf.134.1532729552005;
        Fri, 27 Jul 2018 15:12:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l14-v6sm7385475wrw.65.2018.07.27.15.12.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 27 Jul 2018 15:12:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Drew Noakes <drew@drewnoakes.com>
Cc:     git@vger.kernel.org
Subject: Re: Multiple consecutive null bytes with log -z --name-only
References: <CAJd66x7ZHn=6AHFRXo5E4MhzEiW98Mpf37JRWv_18U5eYFeVJg@mail.gmail.com>
Date:   Fri, 27 Jul 2018 15:12:30 -0700
In-Reply-To: <CAJd66x7ZHn=6AHFRXo5E4MhzEiW98Mpf37JRWv_18U5eYFeVJg@mail.gmail.com>
        (Drew Noakes's message of "Fri, 27 Jul 2018 21:20:54 +0100")
Message-ID: <xmqq36w4l44x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drew Noakes <drew@drewnoakes.com> writes:

> Passing -z with --name-only causes double nulls.
>
> $ git log -z --pretty=format:"%H" --name-only | grep -obUaP "\x00\x00" | wc
> -l
> 8994
> $ git log -z --pretty=format:"%H" | grep -obUaP "\x00\x00" | wc -l
> 0

With --pretty that tells you to show %H and --name-only that tells
you to show names of paths that were touched by each commit, you'd
need to be able to distinguish commit object name (or whategver you
give --pretty=format to) and each pathname, and because you are
driving "log", you also should be able to see where info for one
commit ends and the next one starts.

So I'd imagine that for a commit that touches N paths, you would get
(one pathname followed by NUL) N times, and then another NUL after
that to let you know that you read all the pathnames for that
commit.

By the way, tools should be reading from "--format=...", not from
"--pretty=format:...".  The --format=... option is for human
consumption and gives LF (or NUL when -z is used) the "separator"
semantics, i.e. when listing things A B and C, we would throw
separator in between but not before the first one (obviously) and
not after the last one.  "--format=..." which is a synonym for
"--pretty=tformat:..." is designed for tool consumption and gives LF
(or NULL when -z i used) the "terminator" semantics, i.e. each item
in the output is followed by terminator, so in addition to LF/NUL
after A and B in the example in this paragraph, you also get one
after C, which is the last item.


	
