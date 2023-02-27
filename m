Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1938FC7EE23
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 15:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjB0P2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 10:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjB0P2e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 10:28:34 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A11579741
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:27 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id l1so3596672wry.12
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 07:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJhOI5pH2/X7Uqaz8J/86RgsSNzaLLs6qLmjlPTEmeM=;
        b=UHZ2WyhoU2m5Kd8QQxE6UFNIETlU5q4FTS0ubuZmZ/2F3daMy7NzHQMzD5Yr7mMOpC
         bgc/HezmvOfJS/gR0c6udC+Xn4ZRrfidYyJ+1XowQpqOZYLtbJegjBbnNdNO2HiubxQ5
         Lawxm0sAgFGto2ySDh2liFU4tG29xen9oiQwTxIbT5rebE9ICJcsMyvPWGDV4qRZFvoe
         XdQ+0ABIXdV+0jP5XyAcgIpdTzCLadwO0sdmVATSgMHw1275gBTMvuAMKUeCNT0MFGli
         keslyK1Sgb4CKMRl99JUgp/E1QoDTxH/VknPDJMOXMN/a4Y25kHHsyVQKy8aGovPay6S
         0fmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJhOI5pH2/X7Uqaz8J/86RgsSNzaLLs6qLmjlPTEmeM=;
        b=WY6w5nXvY5m75B03UiL96vwCDNxsV2QWL6PqK8ub6moVsMtfkTlCzIclrHK1lzAdPI
         v8iJV9Dhc4UUaeVpi2TFJfry2BFklS2s41FLiBzkLFUGc+LJ+dMW5ohdv4hWEe3IfH/t
         vYtSEdRcmIhiwhXmoxFVRug3UHosnI9wc6o/cQ2PrSXsP9AhOqryQcohcR8R2BSZEY//
         YDXhQaEhm5Tp7wskl4RtFhXzH/oa1sE5jM4wsn9nWxeDKWGS6HHiDzqfdWbZ54cXd2PM
         DYKsMhblg2b0EQ/s8JK5PQeZ62Mhln3WlczMw7K2B8QSqTPOqQPc1156QhJ42hqgb0ja
         RUtg==
X-Gm-Message-State: AO0yUKVbtumxqBGtOv+Rxz+6hmMhT6LWC4lgYZhFzVT2bvwZoFumCMf0
        7H/Yw3HecGgf9GOkz2/+a6l5BVJ3WhM=
X-Google-Smtp-Source: AK7set9s8b9pEsyn51Zdk4wjcLonj6HVo+dhmxVAcNXrEoMIrSrYdkHS7xWh+oRtg//wh85HQCdPbA==
X-Received: by 2002:a5d:534f:0:b0:2c7:145c:68f2 with SMTP id t15-20020a5d534f000000b002c7145c68f2mr14343695wrv.58.1677511705824;
        Mon, 27 Feb 2023 07:28:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2-20020adff802000000b002c706c754fesm7440298wrp.32.2023.02.27.07.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 07:28:25 -0800 (PST)
Message-Id: <12344400fa04d279de269785f62ba988e589a9f9.1677511700.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
References: <pull.1149.v2.git.1677291960.gitgitgadget@gmail.com>
        <pull.1149.v3.git.1677511700.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Feb 2023 15:28:12 +0000
Subject: [PATCH v3 05/13] dir: mark output only fields of dir_struct as such
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

While at it, also group these fields together for convenience.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/dir.h b/dir.h
index 2196e12630c..e8106e1ecac 100644
--- a/dir.h
+++ b/dir.h
@@ -212,12 +212,6 @@ struct untracked_cache {
  */
 struct dir_struct {
 
-	/* The number of members in `entries[]` array. */
-	int nr;
-
-	/* The number of members in `ignored[]` array. */
-	int ignored_nr;
-
 	/* bit-field of options */
 	enum {
 
@@ -282,14 +276,20 @@ struct dir_struct {
 		DIR_SKIP_NESTED_GIT = 1<<9
 	} flags;
 
+	/* The number of members in `entries[]` array. */
+	int nr; /* output only */
+
+	/* The number of members in `ignored[]` array. */
+	int ignored_nr; /* output only */
+
 	/* An array of `struct dir_entry`, each element of which describes a path. */
-	struct dir_entry **entries;
+	struct dir_entry **entries; /* output only */
 
 	/**
 	 * used for ignored paths with the `DIR_SHOW_IGNORED_TOO` and
 	 * `DIR_COLLECT_IGNORED` flags.
 	 */
-	struct dir_entry **ignored;
+	struct dir_entry **ignored; /* output only */
 
 	/* Enable/update untracked file cache if set */
 	struct untracked_cache *untracked;
-- 
gitgitgadget

