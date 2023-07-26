Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18B1FEB64DD
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 03:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjGZDFS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Jul 2023 23:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjGZDFP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2023 23:05:15 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077F41BF8
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:07 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-316feb137a7so5697662f8f.1
        for <git@vger.kernel.org>; Tue, 25 Jul 2023 20:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690340705; x=1690945505;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IbgEM1HQh+zxc0NneZWWB9vEKt28mfOkzWftFKcSRCg=;
        b=TWokkl11Di5dpHp4RVdGNNbW2sNiLzGqpKrVT+bRnKFjdwrDhXwHDc34XhJs+ofHXJ
         7jrySwcn8AqH8RVRlszkBcZQ8VS+lzVkGBcEw68hK/xeWjMkWpP2pMjKQCAnVwwJn8Hf
         GvJOp0dj+vDsiJ/cxLd2tDU7awtZKzh+Z+peL1pL10JYIEgiVcYj1VISQ7DikdRmkm73
         3Tp13F0nELGoz99UhhHpYfd0YGVgZnMI5hinPyMvwtQtjIBwrCxjikw4UUUgEdkgmtWY
         4aTfZbdK7Cd7dSsWK6d958ywQxxRoTP+3+LBtCkKQqsi+279ZHymlk//fV3FSsdpIKtr
         DYgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690340705; x=1690945505;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IbgEM1HQh+zxc0NneZWWB9vEKt28mfOkzWftFKcSRCg=;
        b=VR/JqC2dC/9G9qFF+5TZNhh8dieWqXAb64djJUHidMuuVdIsaIQFUC7AtaG9gLIFh6
         ljouwYk6/RQcLdv31r5K9dh6IFCUeUe/P/zdAfXzw4SRCNY+Ta0ivDtFr3f1sGv778Nj
         LZ7oBPXIPmGpJDY5OAvyE5OXMa8k5s8Vb6iwYmO4GsRs7rZp1HYNAxUCFgh/z7+ODwtA
         nhJD462FmyDgzBnD4UduvJfozgPmq/rN2GAxYAXn/7kEJRvrGYaSU6Gmx+yWqsTGkKdK
         aLAX81SIKR/J762LIWEfm6Wthf4oMFqi+/phU+GcpAe2YWTOpdkMrP5fUBhyr88oZAAV
         xqrQ==
X-Gm-Message-State: ABy/qLZ4tHGFmJEtTKf8MmNMDWPvW+B3z2Qv6VYaHh9spiXZLlhEDoPj
        nPMxoSaqaPzfoPBfhf8O8cItzP3l6kA=
X-Google-Smtp-Source: APBJJlElB1C+KNQs7cc5LGsvoZazcITCcmiQNhItW78N21xB7IGqR1HCrAlVf0PmjCeN4B0Qh2Eqvg==
X-Received: by 2002:a5d:444f:0:b0:30f:d218:584a with SMTP id x15-20020a5d444f000000b0030fd218584amr371559wrr.23.1690340705284;
        Tue, 25 Jul 2023 20:05:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d4ecb000000b003144b50034esm18170926wrv.110.2023.07.25.20.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 20:05:04 -0700 (PDT)
Message-ID: <f8f96a79b92b050ce3938905ce8a19fddf9cc025.1690340701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
References: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
        <pull.1556.v3.git.1690340701.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 26 Jul 2023 03:05:00 +0000
Subject: [PATCH v3 4/5] SubmittingPatches: emphasize need to communicate
 non-default starting points
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The phrase

    and unless it targets the `master` branch (which is the default),
    mark your patches as such.

is tightly packed with several things happening in just two lines of
text. It also feels like it is not that important because of the terse
treatment. This is a problem because (1) it has the potential to confuse
new contributors, and (2) it may be glossed over for those skimming the
docs.

Emphasize and elaborate on this guidance by promoting it to its own
separate paragraph.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f1d1446764b..40467372c0d 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -318,9 +318,12 @@ or include any extra files which do not relate to what your patch
 is trying to achieve. Make sure to review
 your patch after generating it, to ensure accuracy.  Before
 sending out, please make sure it cleanly applies to the starting point you
-have chosen in the "Choose a starting point" section,
-and unless it targets the `master` branch (which is the default),
-mark your patches as such.
+have chosen in the "Choose a starting point" section.
+
+NOTE: From the perspective of those reviewing your patch, the `master`
+branch is the default expected starting point.  So if you have chosen a
+different starting point, please communicate this choice in your cover
+letter.
 
 
 [[send-patches]]
-- 
gitgitgadget

