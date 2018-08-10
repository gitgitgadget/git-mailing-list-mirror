Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EF191F405
	for <e@80x24.org>; Fri, 10 Aug 2018 00:10:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeHJChh (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 22:37:37 -0400
Received: from mail-yw1-f73.google.com ([209.85.161.73]:43919 "EHLO
        mail-yw1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbeHJChg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 22:37:36 -0400
Received: by mail-yw1-f73.google.com with SMTP id v6-v6so10461466ywg.10
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 17:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=8dXG0HD1f4EiQ1Y3p2vr8evFNR8dcWvIPXFCKdjJtgg=;
        b=cgwEqGQ5P8HwEgBlB9lUyBT4/RDG/OAx6N7rIe1XOfV7Lvj2yGIj5qKqRgXvpv0Fe3
         F7dxeqcT+GWQ1XBtIOClD0+Iughn8m+TjYHc40wTfjcmh6vMGlAb1qeJet28PnJ8Oj4Z
         EVbqyhZUQvqz9/uT+WbLZBhjh6alAHYLT2bCtjhklSRAsLhZIP571zxvsud1u0eo8/MY
         3kIOnJ8V4VSe+oMqAFntHGbDjW6RbuXpBsFF+s5QWRCBq8uzY7BHvNzrSD/9k10qGOsU
         0OgsVcoRbGz/4fWuCDjBlGcddcVwt9N91JkOiLO7QwzLBLpAnrEeRtHSD7vQEBGvDSj+
         Hyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=8dXG0HD1f4EiQ1Y3p2vr8evFNR8dcWvIPXFCKdjJtgg=;
        b=B/tlzbXN0WQ84ViUyyWTF/1WBAhcHRFhZiCZLohZuhYCv2UewHnJwmHcVrI+pzk0NY
         QvXcMMRPK1ZiN8UBxObh1ijGWCgAkm1HpGZduqpKz5nPw1QtLpfJZBFkjSYk8ek9S91U
         Tocm3RfoSw8blETCOzeRiRZlZ5LkOEgKWmli0EBx5TGhJQyG03k0icdRp/81B3t1t+Ji
         O3lAcjTDTxuSS6Czwna8YvafC2VCd27t2Pddwy7npHWNdVmajU7yQ6UFte4ZhPUqf2QC
         C/djKlwh4xhOfkdW/6S0G3HkKoU/wOg7+96jekTjnfaMQA2vQejqQZijjqZV5MZ+oRBy
         R0hw==
X-Gm-Message-State: AOUpUlFjEgnmFbqXyNwdyfO8o+oWE9k9nlhUiGmtVpwhbU/s8sxXJp3N
        kBbH6nzhnFgmsFQrhIigYgOCygwgHuwI
X-Google-Smtp-Source: AA+uWPwLAVZdp2k0HsGqUWlxBLCUyBrJPmr3Uogow4cI+qFEq7ButdKpd7COr9qHi1Nef7SgXwKYsZjooBGD
X-Received: by 2002:a25:da04:: with SMTP id n4-v6mr1178373ybf.16.1533859820062;
 Thu, 09 Aug 2018 17:10:20 -0700 (PDT)
Date:   Thu,  9 Aug 2018 17:10:08 -0700
In-Reply-To: <20180724003619.185290-1-sbeller@google.com>
Message-Id: <20180810001010.58870-1-sbeller@google.com>
Mime-Version: 1.0
References: <20180724003619.185290-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 0/2] Getting data on different diff algorithms WAS:
 Documentation/diff-options: explain different diff algorithms
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I instrumented range-diff to use different diff algorithms for the patches,
(I chose default-myers and patience) and then run on the same range,
via ./git-range-diff v2.10.0..HEAD v2.10.0..HEAD
and I found 5245 same, 304 slightly different and 4 completely different
patches in that range.

Looking at the interdiff is not very pleasing even when reading it with
coloring and move detection.

Manually looking at them, I found the patience diff easier to review.

Comparing the 'default' diff algorithm to 'minimal', I'll see 
 5491 same, 58 slightly different and 0 completely different patches.
 
Comparing 'default' to 'histogram', I'll see
 5255 same, 294 slightly different and 8 completely different patches.
 
Comparing 'histogram' to 'patience', I'll see 
 5337 same, 212 slightly different and 10 completely different patches.

This is all to just put data out there, on how much difference to expect from
the diff algorithms. I have not yet dug into the quality of the diffs.

Stefan


Stefan Beller (2):
  WIP: range-diff: take extra arguments for different diffs.
  WIP range-diff: print some statistics about the range

 range-diff.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

-- 
2.18.0.597.ga71716f1ad-goog

