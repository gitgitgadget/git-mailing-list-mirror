Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41C31F405
	for <e@80x24.org>; Mon, 17 Dec 2018 22:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731936AbeLQWlL (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 17:41:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43534 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbeLQWlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 17:41:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so13934307wrs.10
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 14:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OJIJdNVYTbkpMxJjwk+oc86pN56sgdcljZ13MIhBGIE=;
        b=AKTSvvrVB7kjpHE0F14qLlPA1znA2MzOJcG3V6kXtoht69aVD1gPecdQvBbSPepqDB
         A0LqAtz2w5qTAxxEnR/fAMt7N58v7cfRdKTZhzqYp8v+ApgO11ubRkMRPtwEB279knql
         WJhy1E3f7O9PmzBIZ7W/sflVwz/MFwb5obo7gunIpRKFBDkSi0IL48s9X88Ft5KYMGLw
         mv9Frm0y+sbwW0IoZ5an3lstPmQnrQGbKqmJA2LL2nGlw5YYeK8voFJgIckNdjewLRnq
         EMtBvf0kDiG2C2X0ZbB6dARwA8BHeMuMJc9GxjV8myOfkfvDTN4XwDNjegaNA1OpB745
         W8jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OJIJdNVYTbkpMxJjwk+oc86pN56sgdcljZ13MIhBGIE=;
        b=pQCg/y66uRolcnavnR3TAwI5p1Q1JqpcI5bCjKvdGhZNMotxykqaZByiMliOgZqfKJ
         h2sEnxKQX50o5+difYQMcIlswmiwiMIiSFkNv+xqM1CJ7Xiwb1don8f3jSQE09XQIa0Q
         DZfp459W+4TBve5aMnaO04rj5N2uNzn60DiQRMV5n7CJfAHfrrOdsxt/HCdhrACjLOaM
         hf2B+fBAnr5iyBz+RTlgyFYPfs55XuvCTRKa6upOKOgUD9G76Gmg1ACCq0RDJLJEnPTa
         V9JOYcdVwgABHphps2Y6l/wocMMPq0aPRL0eyZOXcQd0uNyL29qQY4TGGSMuPvoPj/AR
         M4tw==
X-Gm-Message-State: AA+aEWbUpH3DGBGWU1i/IZtQNERhL3T1uVieIF8dKNr5BRkaJG0rpDLC
        hi+JMW9B3Ct52cP9A2ijRh2BEs5FSE0=
X-Google-Smtp-Source: AFSGD/UwQrA2FbmsIrBsWuTqkldvgrMWVmL17G8Sy99k4rv3gvnR8mNA80g8BVbHdUiKufmUC1aSqw==
X-Received: by 2002:a5d:494a:: with SMTP id r10mr12716083wrs.272.1545086467484;
        Mon, 17 Dec 2018 14:41:07 -0800 (PST)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c7sm2208199wre.64.2018.12.17.14.41.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 14:41:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/4] parse_hide_refs_config: handle NULL section
Date:   Mon, 17 Dec 2018 23:40:52 +0100
Message-Id: <20181217224054.4376-3-avarab@gmail.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85
In-Reply-To: <20181213155817.27666-1-avarab@gmail.com>
References: <20181213155817.27666-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

This helper function looks for config in two places: transfer.hiderefs,
or $section.hiderefs, where $section is passed in by the caller (and is
"uploadpack" or "receive", depending on the context).

In preparation for callers which do not even have that context (namely
the "git-serve" command), let's handle a NULL by looking only at
transfer.hiderefs (as opposed to segfaulting).

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index f9936355cda..099e91d9cc0 100644
--- a/refs.c
+++ b/refs.c
@@ -1267,7 +1267,8 @@ int parse_hide_refs_config(const char *var, const char *value, const char *secti
 {
 	const char *key;
 	if (!strcmp("transfer.hiderefs", var) ||
-	    (!parse_config_key(var, section, NULL, NULL, &key) &&
+	    (section &&
+	     !parse_config_key(var, section, NULL, NULL, &key) &&
 	     !strcmp(key, "hiderefs"))) {
 		char *ref;
 		int len;
-- 
2.20.0.405.gbc1bbc6f85

