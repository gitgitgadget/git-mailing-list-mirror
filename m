Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24FEC43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 15:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E2120726
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 15:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVV/M8s0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726194AbfLOPM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 10:12:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34090 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbfLOPM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 10:12:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id t2so4176200wrr.1
        for <git@vger.kernel.org>; Sun, 15 Dec 2019 07:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pde04vlWgndXIAjEorMvjTqi/6YLcTBlG0lyIQgNFJA=;
        b=oVV/M8s0WEQ++3ZZ2AtZAGGpmtx0AEANMh4b7G9nfjHUXxlBbyvEk9V33Ov5OVW9X3
         5ztDVLGt1pL4Lm2NZhxu6U+5sUMEABcUXMOU8Np6EFlHE8i4elrbwUp+Z+JKxQA/jvt4
         6wlwIrjw0dU8CvxsXVcaodFvnYCuX95D66QkuIYJBbs4ID71/Cuto7DpZenfqalOeeTp
         kQcBm1y6UYhMlMyeDksiJWmbRph0ECcMnQMegyf8fyrW2Fof80skpSXcKnMHoj+8SClV
         FReAAl13l4M7l7K/nRvcNO7eNx2UTQoyd4Lo1553K/Cd0axqksC9b8MjT4ceRx5wHeFS
         Ts7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pde04vlWgndXIAjEorMvjTqi/6YLcTBlG0lyIQgNFJA=;
        b=KM26XMc96B4fr9N9QiRGSP3rVaHMUyJDIU+K3ZdKoIvmIIaKBLMdxDP0B2cr6zr6Zy
         wR0F0tY2Lya54BnARgnQLnb+y/XylY+TZ2yPq9WREfhvVV+jlNGn87Sue941T6Piwfft
         RmdQzLNSWPCE+0v7R25DE5vdN9ATlToM9t+62gJ3IH7M4Q+VvtBcrMubHZBNHgCWMk1P
         nZ/8v+mE475MNCWgqALMFn6znMnfds+ARAMacBEdol8Z/Zi9jy/QTcy5EUB12VDp8apb
         QOT+CkYQo9ImB+k3JEQ/HXfRTTTc06WqD7Cddpp6QLpTwkWQiAzcUSsPYwJw+JSMcMKs
         NNcg==
X-Gm-Message-State: APjAAAVTRsApq+tCImYaMV499B/yC72O/3YVj759m6VrcLVRpznGf7/y
        ecVXayxi8kv72ecQQA2TM08YuvjJ
X-Google-Smtp-Source: APXvYqwiqXLkvJ0Vp55dL/AGm/e2Su924lkzqXO9P+K4m73HuCEGvVi9gLvINLtY+QktWqrqx+0Gtg==
X-Received: by 2002:adf:dd46:: with SMTP id u6mr25816797wrm.13.1576422746217;
        Sun, 15 Dec 2019 07:12:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a5sm17550141wmb.37.2019.12.15.07.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 07:12:25 -0800 (PST)
Message-Id: <pull.482.v2.git.1576422744.gitgitgadget@gmail.com>
In-Reply-To: <pull.482.git.1575517503.gitgitgadget@gmail.com>
References: <pull.482.git.1575517503.gitgitgadget@gmail.com>
From:   "ryenus via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 15 Dec 2019 15:12:23 +0000
Subject: [PATCH v2 0/1] fix-typo: consecutive-word duplications
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes unintentional duplication(s) of words, such as the the, and can
can etc. I also take the chance to make a few wording tweaks to avoid
suspicious duplication(s).

ryenus (1):
  fix-typo: consecutive-word duplications

 Documentation/RelNotes/2.7.3.txt | 2 +-
 Makefile                         | 2 +-
 graph.c                          | 2 +-
 submodule-config.c               | 2 +-
 t/t5314-pack-cycle-detection.sh  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)


base-commit: ad05a3d8e5a6a06443836b5e40434262d992889a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-482%2Fryenus%2Ffix-typo-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-482/ryenus/fix-typo-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/482

Range-diff vs v1:

 1:  abb9e55ad5 ! 1:  3180741259 fix-typo: consecutive-word duplications
     @@ -5,26 +5,14 @@
          Correct unintentional duplication(s) of words, such as "the the",
          and "can can" etc.
      
     -    In certain cases, the repeated words are suspicious but actually ok,
     -    and if some alternative wording exists and might be an improvement,
     -    then the alternative wording is used, for example:
     -    "we didn't do so so far" becomes "we didn't do that so far".
     +    The changes are only applied to cases where it's fixing what is clearly
     +    wrong or prone to misunderstanding, as suggested by the reviewers.
      
     +    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Helped-by: Denton Liu <liu.denton@gmail.com>
     +    Helped-by: Junio C Hamano <gitster@pobox.com>
          Signed-off-by: ryenus <ryenus@gmail.com>
      
     - diff --git a/Documentation/RelNotes/2.13.0.txt b/Documentation/RelNotes/2.13.0.txt
     - --- a/Documentation/RelNotes/2.13.0.txt
     - +++ b/Documentation/RelNotes/2.13.0.txt
     -@@
     - 
     -  * Deletion of a branch "foo/bar" could remove .git/refs/heads/foo
     -    once there no longer is any other branch whose name begins with
     --   "foo/", but we didn't do so so far.  Now we do.
     -+   "foo/", but we didn't do that so far.  Now we do.
     - 
     -  * When "git merge" detects a path that is renamed in one history
     -    while the other history deleted (or modified) it, it now reports
     -
       diff --git a/Documentation/RelNotes/2.7.3.txt b/Documentation/RelNotes/2.7.3.txt
       --- a/Documentation/RelNotes/2.7.3.txt
       +++ b/Documentation/RelNotes/2.7.3.txt
     @@ -51,19 +39,6 @@
       #    no-error:
       #
      
     - diff --git a/convert.c b/convert.c
     - --- a/convert.c
     - +++ b/convert.c
     -@@
     -  *
     -  * This should use the pathname to decide on whether it wants to do some
     -  * more interesting conversions (automatic gzip/unzip, general format
     -- * conversions etc etc), but by default it just does automatic CRLF<->LF
     -+ * conversions etc), but by default it just does automatic CRLF<->LF
     -  * translation when the "text" attribute or "auto_crlf" option is set.
     -  */
     - 
     -
       diff --git a/graph.c b/graph.c
       --- a/graph.c
       +++ b/graph.c

-- 
gitgitgadget
