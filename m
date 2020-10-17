Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE9CDC433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA822072D
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 07:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFU1V7tn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437521AbgJQHzt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 03:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411023AbgJQHzt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 03:55:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9146BC061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:55:49 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id u3so2754035pjr.3
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 00:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xNkRt1+/ycdySecTb0NR/2o+fpI7izDYlwU6ugisrP4=;
        b=AFU1V7tnBzKvMDATZfLbwkP/9bMqlJRnuFMarbELHJXMr3gYp45Ltv89pfwpcR0HCn
         fJbafZxqi2+LqhKJB3NIEFROqxxtYz+Vv04PAqthYASEjsXD1a+Gv40TeVR/dm4q2Mc4
         teYguzqU4YZk4eYIhARGyiqeRpqgtrEFJ05k4OW2XPzfKARVGXximu9XNmXSTLc4EfZm
         N7RTLG8Bf71kgkXPzJqXB+Xg39AwWGxP9B36lgha8oK6vwIp+zXXM0rG+zwR/Kf40GfZ
         6xtjdWwWUmFlxrzi4zn37ZTbn6uVd/iPD2SJHaB8jCz8+M3DGYvDXxtCAWLK7kXHp2BR
         dCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xNkRt1+/ycdySecTb0NR/2o+fpI7izDYlwU6ugisrP4=;
        b=UEVBuJWU9rr8fNszap3G1YwqsQhKr6uoS94xSRWdDyxOr6zef5Qea5wZCs5cvFCT8s
         wdAEh9y2D7U+3kTLBacyHQBfJVrRfE2X+y3xUEpfA4WXUnRDqlOv5ckrVzLoWDOvVH0L
         AQRqxYVFFbP1KO0uZfd5pChaaL52b3PB6N9a2yQOBxni5NiJkXbkn4Yi92Dfng2ZV0v7
         ekQhf4EQ8luhojekGIEwfA+9oZIHtaIvjjKjWidSu4Vq8cW9q2EQ9BfnVsjV5qcm5s7p
         MqD+JkDPdSNAktREOdzrRDtNqKJQDyObj5fz4wpXt8L7cN06cwwaQCF6Jgmu/04bnOKl
         4Qiw==
X-Gm-Message-State: AOAM530FeE+xGTOUNQNN9dAYONiCbMR3J8W9k5S2I9WNf1Va5WrdwtyS
        tMvJCzqJX/fxQCQ0AKY42tmf+Qh70HVN5Nzq
X-Google-Smtp-Source: ABdhPJyKN/LcFPqBUf2Ock+pCAdC1hBxd641o16s7/WXvv+U9HgE77brY5K1NcDJb3yLKd3bvjxdDQ==
X-Received: by 2002:a17:902:7102:b029:d3:ef48:e51e with SMTP id a2-20020a1709027102b02900d3ef48e51emr7667337pll.72.1602921348607;
        Sat, 17 Oct 2020 00:55:48 -0700 (PDT)
Received: from localhost.localdomain ([106.201.2.128])
        by smtp.gmail.com with ESMTPSA id t2sm4994162pji.12.2020.10.17.00.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 00:55:48 -0700 (PDT)
From:   Charvi Mendiratta <charvi077@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        sunshine@sunshineco.com, Charvi Mendiratta <charvi077@gmail.com>
Subject: [PATCH v2 0/5][Outreachy] modernizing the test scripts  
Date:   Sat, 17 Oct 2020 13:24:50 +0530
Message-Id: <20201017075455.9660-1-charvi077@gmail.com>
X-Mailer: git-send-email 2.29.0.rc1
In-Reply-To: <20201015175709.20121-1-charvi077@gmail.com>
References: <20201015175709.20121-1-charvi077@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks to Junio and Christian for corrections required in previous patch series, I have updated them in this patch series. I have updated the author name and sign-offs on all the patches, and also corrected the mistakes in cover letter and commit message of patch. 

This patch series :
 -modernize the three test scripts : t7101, t7201 and t7102.
 - cleans up with 5 types of changes in all the three scripts.
   1. Converting the old style test format to new one
   2. Removing blankspaces in test bodies
   3. Removing whitespaces after the redirect operator, according to
      CodingGuidelines 
   4. Using git -C instead of cd
   5. Placing all commands in separate lines


Charvi Mendiratta (5):
  t7101,t7102,t7201: modernize test formatting
  t7102,t7201: remove unnecessary blank spaces in test body
  t7102,t7201: remove whitespace after redirect operator
  t7201: avoid using cd outside of subshells
  t7201: place each command in its own line

 t/t7101-reset-empty-subdirs.sh |  66 ++++++++++-----------
 t/t7102-reset.sh               |  63 ++++++++------------
 t/t7201-co.sh                  | 102 +++++++++++++--------------------
 3 files changed, 96 insertions(+), 135 deletions(-)

-- 
2.29.0.rc1

