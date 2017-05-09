Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5388B1FF34
	for <e@80x24.org>; Tue,  9 May 2017 05:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdEIFCm (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 May 2017 01:02:42 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32870 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbdEIFCl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2017 01:02:41 -0400
Received: by mail-pf0-f196.google.com with SMTP id b23so12348209pfc.0
        for <git@vger.kernel.org>; Mon, 08 May 2017 22:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EMNLx7N0oDIeZZ4mAU6vWIrj9gzq2xokmub1kwIqLFw=;
        b=si667IGeioFCITLQQZJsUnIYSE+b7QsmyHY1CD1+NHyKRQVXF44a+zfL07gHGx8FAt
         76fWDYpp3X11zVW0/OEEHjJICSjgSBmOW5gZd9Iqp9VhFAnYyC7yaewaINwLp3DB6uhV
         SaJW2J+d2LbqcJRQeadZ69kJSWhs4GA0c4MILGkDcVlso+/v3HFFJzJl97Ox8BTYER3l
         3AmsLrOqdvQksSVqYrHF1KyQiRwdc30ptuLiAKgjS5B8zbCo04AdSP1+TG2pB1J7DXXR
         Vr3tuqI4IZtMr70dosITeGA13W7HySbrW1s0SsI5qafFnRwXjppU129CrujouVGdqonR
         8O7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EMNLx7N0oDIeZZ4mAU6vWIrj9gzq2xokmub1kwIqLFw=;
        b=t9u3MXmfzTwen724HQfaiII5pp6LSb4XSw9fhlZUNHMp1OiV4qPlJp7Dg7hdhKysnI
         rohJB6izW0RRyO54TpCOVy/dW7B8J+QMCGpg1C2hXDUNa8dEmgtgmW788hmQXggkNekj
         33iTeZjv4am9p8u4WwMMR1QSKEUG5TdlX6atXxPLYQVqGP+HNvEETBd77FrIgEYGQR7v
         cHXptLBopGos7x0UHlePBSUzsCFxxGFTKPDrl7CL4jnXpzzQCljOLPtjk8LzYIhFR7fi
         5Jr/BSlsfSFSfEsb3Bs8gQFPmsOchl8Loxstnc0O20YmrNItFNK/A4kCE0P1UmPXG/oJ
         soQg==
X-Gm-Message-State: AODbwcDoNnAoxfSPRjKdFGbvq4282TgeqDaDN7axQN+3JNJ9kEMcCuWe
        dBa56k9dS0Myag==
X-Received: by 10.98.139.21 with SMTP id j21mr8810706pfe.5.1494306160405;
        Mon, 08 May 2017 22:02:40 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:9133:cf19:b689:27d6])
        by smtp.gmail.com with ESMTPSA id 187sm9826903pgj.66.2017.05.08.22.02.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 May 2017 22:02:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     David Turner <David.Turner@twosigma.com>
Cc:     'Christian Couder' <christian.couder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        =?utf-8?B?Tmd1?= =?utf-8?B?eeG7hW4gVGjDoWkgTmfhu41j?= Duy 
        <pclouds@gmail.com>, "Ben Peart" <benpeart@microsoft.com>
Subject: Re: [PATCH 0/1] Preserve the untracked cache across checkout, reset --hard, etc
References: <cover.1494236457.git.johannes.schindelin@gmx.de>
        <CAP8UFD3qoeQE5ZbFHGLE-_B4rOr3X2m-WPB7rb8QAbZA6zMRxg@mail.gmail.com>
        <2c0be7c0a8ce4f5ea49dfaf3f8511bc0@exmbdft7.ad.twosigma.com>
Date:   Tue, 09 May 2017 14:02:39 +0900
In-Reply-To: <2c0be7c0a8ce4f5ea49dfaf3f8511bc0@exmbdft7.ad.twosigma.com>
        (David Turner's message of "Mon, 8 May 2017 15:58:12 +0000")
Message-ID: <xmqqy3u639n4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

David Turner <David.Turner@twosigma.com> writes:

> Can you actually keep the email address as my Twopensource one?  I want to make sure that Twitter, my employer at the time, gets credit for this work (just as I want to make sure that my current employer, Two Sigma, gets credit for my current work).
>
> Please feel free to add Signed-off-by: David Turner <dturner@twosigma.com> in case that makes tracking easier.
>
> Thanks.
>
> WRT the actual patch, I want to note that past me did not do a
> great job here.  The tests do not correctly check that the
> post-checkout untracked cache is still valid after a checkout.
> For example, let's say that previously, the directory foo was
> entirely untracked (but it contained a file bar), but after the
> checkout, there is a file foo/baz.  Does the untracked cache need
> to get updated?
>
> Unfortunately, the untracked cache is very unlikely to make it to
> the top of my priority list any time soon, so I won't be able to
> correct this test (and, if necessary, correct the code).  But I
> would strongly suggest that the test be improved before this code
> is merged.
>
> Thanks for CCing me.

I will try to find time to tweak what was sent to the list here to
reflect your affiliations better, but marked with DONTMERGE waiting
for the necessary updates you mentioned above, so that this change
is not forgotten.  It may turn out to be that copying from src to
dst like the patch does is all that is needed, or the cache may need
further invalidation when the copying happens, and I haven't got a
good feeling that anybody who are familiar with the codepath vetted
the correctness from seeing the discussion from sidelines (yet).

Thanks.
