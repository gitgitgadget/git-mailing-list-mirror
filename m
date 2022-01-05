Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 243D6C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242231AbiAER1u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 12:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiAER1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 12:27:42 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C533C061245
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 09:27:42 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id h23so1579961wrc.1
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 09:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DvALRlYCdTva9ksqtWjdE6MVdFOXX7uWydReXPvBTso=;
        b=FNzxoIsXrz3GqV+k49hVKHq+djXv5X0qcuF86g3nV4x7VpQrsqPDfd+DfT+fxzAiCF
         yzWIJKv9Y05KlgL27hyvMDW7tXGVymP3YW0IrzAuF3a0BPd0WKSCR04Ao8rDamohS2J9
         SjQ+uiqNn3kCQdo3yL2vL854Ku9s3BnGGbTjbOiTIIRuQDm+G5/078cGUvZZvVmv7FYP
         0pWr7vMAa2Qe0Fzhc/PHxLXBAnOFce8lBjGuH7+BGx5pOFKqr0Eprc64pSub9rONJrQY
         yoXCokVMIKhTRTEP3fJkYXGvFCc/rbGaWDOhFjjIcUUcuLmKMNkhtXZ+g/w4PkR3OPlK
         v+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DvALRlYCdTva9ksqtWjdE6MVdFOXX7uWydReXPvBTso=;
        b=DOTxJj7dZ1jUQoUGASyyXcmFKGaZ7n3qmqV8gK/oVxz0bF3qKv+Dri4/WkbSC1ndqd
         ww1x98fTQsJkaAggN/SqDFQcGlEFduiYZ5XIpZ/Sz4BkpPZwTLeARNw6XhhIrs/pOiRA
         iRIW1ffib/XIw2vP4onA9OPWRM9kUsh9i1q5PKvHwu/Hk/hZ/j9fzfgx0Sq1W7HpiwhF
         AQzvp1f1TX68YpUnFrsgpSRym+QTmTzRaVH7zowOrQR8y6WnMocp+EyDQsfs806E5+pI
         bFMOmDMAVnbAR5mPQ7TYXZ42OmMKGWNEyUhT+odgN/6QCygqucIYVx0g9lbhaMOyWXxg
         k//Q==
X-Gm-Message-State: AOAM5316WtjHqrBaQWfDO3+TCTUyanoQdBvEC0fmQ4wdjJugQEu6QnF5
        Up8boGsFtscWIWj537HkqeLXZEjpxoU=
X-Google-Smtp-Source: ABdhPJxTP4dcJM6uoO6GXFjkrs0WprHnj2UJej4qMFUxZu8g4ZrshMEiXYoz0+8FK9SIc7u7E8CVUw==
X-Received: by 2002:a05:6000:1807:: with SMTP id m7mr47308498wrh.191.1641403660911;
        Wed, 05 Jan 2022 09:27:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l10sm3291392wmq.7.2022.01.05.09.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 09:27:40 -0800 (PST)
Message-Id: <c9e95a70d198f5e1c3c02fed1c3c51185a37b1ce.1641403655.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
References: <pull.1114.git.git.1640927044.gitgitgadget@gmail.com>
        <pull.1114.v2.git.git.1641403655.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 17:27:33 +0000
Subject: [PATCH v2 6/8] merge-ort: allow update messages to be written to
 different file stream
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This modifies the new display_update_messages() function to allow
printing to somewhere other than stdout.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 7 ++++---
 merge-ort.h | 3 ++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 3cdef173cd7..86eebf39166 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4198,7 +4198,8 @@ static int record_conflicted_index_entries(struct merge_options *opt)
 }
 
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result)
+				   struct merge_result *result,
+				   FILE *stream)
 {
 	struct merge_options_internal *opti = result->priv;
 	struct hashmap_iter iter;
@@ -4222,7 +4223,7 @@ void merge_display_update_messages(struct merge_options *opt,
 	for (i = 0; i < olist.nr; ++i) {
 		struct strbuf *sb = olist.items[i].util;
 
-		printf("%s", sb->buf);
+		fprintf(stream, "%s", sb->buf);
 	}
 	string_list_clear(&olist, 0);
 
@@ -4272,7 +4273,7 @@ void merge_switch_to_result(struct merge_options *opt,
 	}
 
 	if (display_update_msgs)
-		merge_display_update_messages(opt, result);
+		merge_display_update_messages(opt, result, stdout);
 
 	merge_finalize(opt, result);
 }
diff --git a/merge-ort.h b/merge-ort.h
index 1b93555a60b..55819a57da8 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -76,7 +76,8 @@ void merge_switch_to_result(struct merge_options *opt,
  * so only call this when bypassing merge_switch_to_result().
  */
 void merge_display_update_messages(struct merge_options *opt,
-				   struct merge_result *result);
+				   struct merge_result *result,
+				   FILE *stream);
 
 /* Do needed cleanup when not calling merge_switch_to_result() */
 void merge_finalize(struct merge_options *opt,
-- 
gitgitgadget

