Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D7DA1FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 19:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753677AbdBJS77 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 13:59:59 -0500
Received: from mail-pg0-f51.google.com ([74.125.83.51]:34270 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752912AbdBJS76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 13:59:58 -0500
Received: by mail-pg0-f51.google.com with SMTP id 14so12707042pgg.1
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 10:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4lB7106SpM91CU3ZqO9zFbbrQvU6ooz+evr5kWCgPkM=;
        b=INxZgSJSi+WUb4bYpaOIzuN0TyurGwDEX285qlBE+zH7dK1Fjp6H1VrUdQHSFNqKN0
         AbYrBRZJX18GVsl5Uww8FC+gWqTQ9bEtNAWDQax16p+T8RO8hlVXODOduRRNYSam2fYy
         BUmOwTRB1IVW8qtHiWgoh0MwV+rV8niA0e89wHQwXox9UBVB7scqVtpEDAKp/L31m+Da
         SEIQv0FtVi/bOUgWmgzy7glMwY9OeUywUwOAgobImuWLyldpfrQJ7AaaRMh2ZH8zvW2E
         kCg2/WcxHHNhBTtQq6EODuSPCPCJUzmzOMHnWABD7A9+eezvZnP/BSCL/zDEhrO1S5oO
         pcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4lB7106SpM91CU3ZqO9zFbbrQvU6ooz+evr5kWCgPkM=;
        b=K/QvufAK2uTYJGsjksoR1X81r2qHRiWv/SGAiEfeatUEdkKefc1+LW1pxkbE/7c/Xd
         oOegA652pm0fHYskk7xtgz2OMpGUaf6R4wAsdIcUP0O+zJYQ37O+zb+DAN+02qi0VfaJ
         wYZ95AX8uCjLbMZSxqCr5ys7Lh9V0cMWjz5Fz0EBwZLHZrTeOS3pK9If67z9YveVLpPW
         h2/NWzwgGdtjFWa+37FxcdlkB/k/csXHnsOLidcsA/AC9UDNP5e6vsxrcxhkqJeVcw/G
         3l0/N145JDurFmLhzp6kcsL9tEYm6tUziShJGUm7aIfHK5Hcs7+ObBF1AaM2JreU/ODZ
         FkRw==
X-Gm-Message-State: AMke39n1wOtPXQHhRYiAsrfca8+7k5qiC4QBroo5qOITlSRcMiUyHKpH+P5+CR73Ip7I1Q==
X-Received: by 10.99.140.77 with SMTP id q13mr12434550pgn.179.1486753197818;
        Fri, 10 Feb 2017 10:59:57 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8499:2e0a:2c80:2b60])
        by smtp.gmail.com with ESMTPSA id q7sm784550pfb.98.2017.02.10.10.59.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 10 Feb 2017 10:59:57 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Rappazzo <rappazzo@gmail.com>
Subject: Re: [PATCH v2 0/2] Fix bugs in rev-parse's output when run in a subdirectory
References: <50fe3ea3302c40f4c96eaa5a568837e3334f9dc4.1486555851.git.johannes.schindelin@gmx.de>
        <cover.1486740772.git.johannes.schindelin@gmx.de>
Date:   Fri, 10 Feb 2017 10:59:56 -0800
In-Reply-To: <cover.1486740772.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Fri, 10 Feb 2017 16:33:31 +0100 (CET)")
Message-ID: <xmqqk28xlvmb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Johannes Schindelin (1):
>   rev-parse: fix several options when running in a subdirectory
>
> Michael Rappazzo (1):
>   rev-parse tests: add tests executed from a subdirectory
>
>  builtin/rev-parse.c      | 15 +++++++++++----
>  t/t1500-rev-parse.sh     | 28 ++++++++++++++++++++++++++++
>  t/t1700-split-index.sh   | 17 +++++++++++++++++
>  t/t2027-worktree-list.sh | 10 +++++++++-
>  4 files changed, 65 insertions(+), 5 deletions(-)
>
>
> base-commit: 6e3a7b3398559305c7a239a42e447c21a8f39ff8
> Published-As: https://github.com/dscho/git/releases/tag/git-path-in-subdir-v2
> Fetch-It-Via: git fetch https://github.com/dscho/git git-path-in-subdir-v2

Will queue as js/git-path-in-subdir topic forked at 2.12-rc0.

I still think the log message in 2/2 is making a mountain out of
molehill and showing a skewed perception on pros-and-cons in a
design decision, but I won't repeat my review.  I saw a few
correctness issues and pointed them out on the patches.
