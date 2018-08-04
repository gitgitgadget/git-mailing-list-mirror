Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAFC81F597
	for <e@80x24.org>; Sat,  4 Aug 2018 22:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729651AbeHEAUe (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Aug 2018 20:20:34 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:46217 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbeHEAUe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Aug 2018 20:20:34 -0400
Received: by mail-pf1-f194.google.com with SMTP id u24-v6so4992490pfn.13
        for <git@vger.kernel.org>; Sat, 04 Aug 2018 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=kSG4S0DQEmfm05SBPJifnbMAX1DaTtElsPH4pxEzDQo=;
        b=AAnb5ypabIPkSTghlPpeKWlsYhwML0VyK2xBzMrFBHDqpRVJPv33R5IOF5IdhirNH/
         kfLbJUHcejfEoQMVKzOFezwIC3j0RlPWsANEJ063xciZKK3sJJec7jYaajSrYcBl6H/t
         KZWpcJtD4DGcNpmmgp/fqp3Ei9xSFhZZfYbXeWg9MGhb1/alTR2fBsap/rSizlyAkmJB
         pTefnXsMK6kLfecE3eLyxpvXeqTWF2SqtnnHCjl+bsI0aV0XGORgf3LKEcXWDF16Pv6u
         m+ryqKJZu4RRmLYLyvvbzwoF9rA7hXeA6zGnOADyEhHE51y87HNJ1ltaonPlI4JbSiOS
         5JZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kSG4S0DQEmfm05SBPJifnbMAX1DaTtElsPH4pxEzDQo=;
        b=kuE/b3w1Q8eTx5wnYldOF+aNIV9oxtuzZ07zixMP3yt0OOxiPckf1vPJ9MqLTDpXaL
         Wz6gDNVYTUGa5NjJH2CdFo5Z4BUZ1GyqysjeWYBtraOyxdbtQzi+o4XL6iS88mutegdd
         SbGiUTjNPOjBXYHyNzE3WST4XI5P2nZfx8iEbQpLRFOcZvoZz7cyDA3/NljIzjML1lit
         hFX368+scw6vdSr9r7M2qSz7Ob4wT9twNiiCUivcRHCZW5hZevZ7+5nOB3aYmg+3LVWb
         GM3CGFDLd1hL1pr8oW74TjQpVHwB8mFlH4HKSkr43ekDVM+NudY3QHWeOQxXqazEmNXm
         WY9w==
X-Gm-Message-State: AOUpUlF4Hbdx0wlE97zJjeCbyZi3IdBh4VueYcqJMbvmSn+NmUlU6aM3
        LgzdxPtJsx/rqLw2vqS9gz7CXzgZ
X-Google-Smtp-Source: AAOMgpePrEJYh2nEd0cu+ERqQzgTRmF8BImz6C4BhSU8GniGajzX0mZkrPaaSPuHE3D7RNEGZtPyXQ==
X-Received: by 2002:a65:5803:: with SMTP id g3-v6mr9073749pgr.117.1533421103252;
        Sat, 04 Aug 2018 15:18:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id 16-v6sm12159530pfp.6.2018.08.04.15.18.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 15:18:22 -0700 (PDT)
Date:   Sat, 04 Aug 2018 15:18:22 -0700 (PDT)
X-Google-Original-Date: Sat, 04 Aug 2018 22:18:16 GMT
Message-Id: <pull.15.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 0/4] line-log: be more careful when adjusting multiple line ranges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>, Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am a heavy user of git log -L .... In fact, I use the feature where
multiple ranges can be specified extensively, via a not-exactly-trivial
shell script function that takes the currently staged changes (or if none
are staged, the current unstanged changes) and turns them into the
corresponding commit history:

staged_log () { #
        diff="$(git diff --cached -U1)"
        test -n "$diff" ||
        diff="$(git diff -U1)"
        test -n "$diff" ||
        die "No changes"
        eval "git log $(echo "$diff" |
                sed -ne '/^--- a\//{s/^-* a\/\(.*\)/'\''\1'\''/;x}' -e \
                        '/^@@ -/{s/^@@ -\([^, ]*\),\([^ ]*\).*/-L \1,+\2/;G;s/\n/:/g;p}' |
                        tr '\n' ' ')"
}

This is an extremely useful way to look at the history, especially when
trying to fix up a commit deep in a long branch (or a thicket of branches).

Today, however, this method failed me, by greeting me with an assertion.
When I tried to paper over that assertion by joining line ranges that became
adjacent (or overlapping), it still produced a segmentation fault when the
line-log tried to print lines past the file contents.

So I had no choice but to fix this properly.

I still wanted to keep the optimization where multiple line ranges are
joined into a single one (I am convinced that this also affects the output,
where previously multiple hunks would have been displayed, but I ran out of
time to investigate this). This is the 3rd patch. It is not purely an
optimization, as the assertion would still trigger when line ranges could be
joined.

Now, I am fairly certain that the changes are correct, but given my track
record with off-by-one bugs (and once even an off-by-two bug), I would
really appreciate some thorough review of this code, in particular the
second one that is the actual bug fix. I am specifically interested in
reviews from people who know line-log.c pretty well and can tell me whether
the src[i].end > target[j].end is correct, or whether it should actually
have been a >= (I tried to wrap my head around this, but I would feel more
comfortable if a domain expert would analyze this, whistling, and looking
Eric's way).

Cc: Eric Sunshine sunshine@sunshineco.com [sunshine@sunshineco.com]

Johannes Schindelin (4):
  line-log: demonstrate a bug with nearly-overlapping ranges
  line-log: adjust start/end of ranges individually
  line-log: optimize ranges by joining them when possible
  line-log: convert an assertion to a full BUG() call

 line-log.c          | 18 +++++++++++++++---
 t/t4211-line-log.sh | 17 +++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)


base-commit: 1d89318c48d233d52f1db230cf622935ac3c69fa
Published-As: https://github.com/gitgitgadget/git/releases/tags/pr-15%2Fdscho%2Fline-log-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-15/dscho/line-log-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/15
-- 
gitgitgadget
