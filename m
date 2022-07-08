Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D08DC433EF
	for <git@archiver.kernel.org>; Fri,  8 Jul 2022 14:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237865AbiGHOUh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 10:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237660AbiGHOUg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 10:20:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44255222A6
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 07:20:33 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id bk26so15691633wrb.11
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 07:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0/tIwmeiVUIwGm3nNtFylTF8maWaPmz0dqEq6vCg++I=;
        b=EAD735qOYTtMlf4VGFXZWlJtC7i8Guw90H+sZBQDIrWba8QJIp9M7o7WGETx41h7Jt
         ZSrmLB1vjiS1xP9Eyr1EzHOyYk869wTRTTBGpUxKx5njPyTC6wrcHeHR/dRXGhQHWUfC
         1ZpRIztekcDIakUy78tNzo31cGkiZmZ9og90tsWDwU7UZ3c22RZ6tn+Vzr8O47ERCz45
         LON2nmTXifY6dQ+pXkD4VboyE98cK1ikBrUD/5vW0p6iIrL6TnGU8yCv4MXBN73XTW6w
         yJ3qzOWmLCys5xrCdeFvZaIW65fIMVl+7p9Hrh0/eBMW0p6OUpZzWrydqUBjWm4HV144
         z9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0/tIwmeiVUIwGm3nNtFylTF8maWaPmz0dqEq6vCg++I=;
        b=4/OirGC3H/A5wcqerh8boyJ9hM/loWSRfT/rvJ7RmQmQtx6Qo82GUaQGDk+N03+XkB
         D6uAnDg+JaGtP6dbSE+tHqaXRhzY34oIob5nE9pClsLzz5t8s6kM0uXWLQU1h6kpftd+
         EKIMRkFfXAHvEhnd9Dovd0lgFheTfXEaYa/kcbEYxdYmNVzUUQ3mpXs2jLzp6TjA3QNg
         dLCekhxYHB9drEQMntmEyZiIxaZbhzcjyC/FaF8zdOTCR6FUh8+XF/kdAk9oh9QbUcUi
         Sl3eR1qMXfI6J0DavawV27tQrEcFPmClmyhJT/OqkgOYnwIkrWrdwy1nmmt+hxYTe3Ad
         FcPw==
X-Gm-Message-State: AJIora8ypj9f80PQPA8ikhML9N2CFukzkaeBDjDVIORsrLOjq2LorDtw
        DTqPlriWmzzBP9TVzGz7dBQWSgyHdkA=
X-Google-Smtp-Source: AGRyM1tSfsMDmJBB5CHNFxeJyWjZNYGTY45w6Z2SDNBBhUy/U92Eos/hmopkLQ4QC9F9yBkN0l8New==
X-Received: by 2002:adf:d215:0:b0:21d:7333:9627 with SMTP id j21-20020adfd215000000b0021d73339627mr3427061wrh.526.1657290031365;
        Fri, 08 Jul 2022 07:20:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0021b9585276dsm40393924wrr.101.2022.07.08.07.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 07:20:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/7] xdiff: use standard alloc macros, share them via git-shared-util.h
Date:   Fri,  8 Jul 2022 16:20:12 +0200
Message-Id: <cover-0.7-00000000000-20220708T140354Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.913.g189dca38629
In-Reply-To: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
References: <b34dcb93-df73-f5de-3c7c-7ab6c3250afe@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is on top of
https://lore.kernel.org/git/pull.1272.git.1656516334.gitgitgadget@gmail.com/;
and shows that we can factor our the allocation macros used in cache.h
and git-compat-util.h instead of defining replacements for them and
alloc_nr() in xdiff/*.

The journy towards doing so is slightly longer, but I think worth
doing, since...

On Fri, Jul 08 2022, Phillip Wood wrote:

> On 07/07/2022 12:17, Ævar Arnfjörð Bjarmason wrote:

>> I don't think it's more readable to carry code in-tree that's
>> unreachable except when combined with code out-of-tree. I.e. this series
>> leaves us with the equivalent of:
>>      ptr = xmalloc(...);
>>          if (!ptr)
>>              /* unreachable in git.git ... */
>> I don't think it's more readable to have code that rather trivial
>> analysis will show goes against the "__attribute__((noreturn))" we're
>> placing on our die() function.
>
> We're already in this situation. The code in xdiff is written to
> handle allocation failures and we use an allocation function that dies
> instead. This patch series does nothing to alter that situation.
>[...]
>> That just seems inviting a segfault or undefined/untested behavior
>> (whether in the sense of "undefined by C" or "untested by git.git's
>> codebase logic"). Everything around xmalloc() now assumes "never returns
>> NULL", and you want to:
>>   * Make it return NULL when combined with out-of-tree-code
>
> No I do not want to alter the behavior of xmalloc() at all, that is
> why this series does not alter the behavior of xmalloc()
> [...]
> I think there is an argument that we should change our xdiff wrapper
> to use malloc() rather than xmalloc() so we're able to test the error
> handling. That then begs the question as to how we actually get the
> allocation functions to fail when they're being tested. I also think
> that is an orthogonal change that could happen with or without this
> patch series.

I think part of what I was claiming upthread I was just confused
about. I.e. yes we do use xdl_malloc() defined as xmalloc() already,
what *is* true (and I didn't make this clear) was that your proposed
series cements that further in place.

But as 6/7 here notes 36c83197249 (xdiff: use xmalloc/xrealloc,
2019-04-11) left us with that state of affairs for expediency, but as
we're really close to just "properly lib-ifying" xdiff I think we
should just do that. At the time of 36c83197249 we had ~20 calls to
xdl_malloc(), after your series we were at ~1/2 of that (including a
callers that 36c83197249 explicitly punted on).

This larger series is something we can do later, but I'm submitting it
as a non-RFC in case there's consensus to pick it up on top. The sum
of the two would be smaller if they were squashed together, but I
haven't done that here.

The 1/7 is an amendmend I suggested to 47be28e51e6 (Merge branch
'pw/xdiff-alloc-fail', 2022-03-09), since it was modifying some of the
same lines of code...

Ævar Arnfjörð Bjarmason (7):
  xdiff: simplify freeing patterns around xdl_free_env()
  git-shared-util.h: move "shared" allocation utilities here
  git-shared-util.h: add G*() versions of *ALLOC_*()
  xdiff: use G[C]ALLOC_ARRAY(), not XDL_CALLOC_ARRAY()
  xdiff: use GALLOC_GROW(), not XDL_ALLOC_GROW()
  xdiff: remove xdl_malloc() wrapper, use malloc(), not xmalloc()
  xdiff: remove xdl_free(), use free() instead

 cache.h            |  75 -----------------------------
 git-compat-util.h  |  28 ++---------
 git-shared-util.h  | 115 +++++++++++++++++++++++++++++++++++++++++++++
 xdiff/xdiff.h      |   5 --
 xdiff/xdiffi.c     |  47 ++++++++----------
 xdiff/xhistogram.c |  15 +++---
 xdiff/xmacros.h    |  23 ---------
 xdiff/xmerge.c     |  57 ++++++++++++----------
 xdiff/xpatience.c  |  14 +++---
 xdiff/xprepare.c   |  60 +++++++++++++----------
 xdiff/xutils.c     |  33 ++++---------
 xdiff/xutils.h     |   2 -
 12 files changed, 234 insertions(+), 240 deletions(-)
 create mode 100644 git-shared-util.h

-- 
2.37.0.913.g189dca38629

