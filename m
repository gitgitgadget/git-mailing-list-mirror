Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D4FECAAA1
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 15:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231995AbiIIPGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 11:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiIIPGe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 11:06:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF8D13BC60
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 08:06:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id d2so3276983wrn.1
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 08:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=gKH+uDBlVmFKJIO50p1B6TcRcnRBM1A9OiZ+h0u7f2U=;
        b=NasHWLuHOMEZMpTnGPkwKkEpCdLEA3mLXWfrYoHxiBYyE6qHCRQCTwlcxQt9xcQI4f
         cdmxDwPTCFY+zHHkpUv03xohnrJ7GjSJyUo/zTOL+BblGAo2x5dxJHpGFwnJZG3zagg0
         bMnUOjXPFde6jax22v3ShjdAYv/dAWa89PIjW1lRP7nJepGrncR5mIZ6disWcnbDsKCg
         CaKfU9ayzSNF3uYXK06JCRxpftNXLPLNKkOhI7e+H8JObKRs6HE8e08lzGc4Aw+Zw/4z
         G1DwafhA1yCCQkmt1YiYYOJz+L56aBVuOR8TsGrIpq69UITu/X4TiJrCRC2ePu+AKDKL
         dzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=gKH+uDBlVmFKJIO50p1B6TcRcnRBM1A9OiZ+h0u7f2U=;
        b=WuLqXZ6A5EfGnhTovmN27FsKU0MOJ6sslN1vGMKVn/WxrNhpQs04k0KuI9MQReP7ES
         LQi9e7LJtOG25hnwuNgcuh0uoX4r9SpxaU9yz+3T0qMn+ikIxYJLBbxFrdsDnsmVcG1o
         Imc3rMwQMYYCH8Yyw35pEepibhT4jPVBuQ5YthMS6i2nBIroMI5E0n4TSuEAaiKtAiCU
         M4wKotGe0HtBBz6F1u72R9wOsj2vIBEpwReLRHsXeKRKCP4QcTBubPtsYkfQGj3AusZT
         ddMM+xeHxg8elPK4ClnASf5dBdqUDUy8iAqijWFXfVRPvZEh4zEQ8bsVQRmGxxoyK5Qy
         Uk5Q==
X-Gm-Message-State: ACgBeo2nwD+0Rs/S5DK2sNLyy/FAA73ZGmM2yUqpJXpsysvaLAqVt2Cu
        aGy4+gPLSY6HRINKy4xK+zZJ5u2yzt8=
X-Google-Smtp-Source: AA6agR4ybIRV3tJGwpGOW/G2nCdED7EW+v1A63fb3DrTRB03uHO4DFHw5SnwoizQkX6Of2ZM7DyMuA==
X-Received: by 2002:a05:6000:144d:b0:21f:a4a0:dbfa with SMTP id v13-20020a056000144d00b0021fa4a0dbfamr8309874wrx.701.1662735989886;
        Fri, 09 Sep 2022 08:06:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c17-20020a05600c4a1100b003a61306d79dsm819215wmp.41.2022.09.09.08.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:06:29 -0700 (PDT)
Message-Id: <0df5ecc216d86e9308473a8eb207d33b37fa2aa4.1662735985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
References: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
        <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 15:06:22 +0000
Subject: [PATCH v5 2/5] hiderefs: use new flag to mark force hidden refs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sun Chao <16657101987@163.com>, Sun Chao <sunchao9@huawei.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

If uploadpack.allowTipSHA1InWant or uploadpack.allowReachableSHA1InWant
are set to true, the private commits of hide refs can be fetched by
client. The new hide-refs hook are used to hide our refs and we wish to
hide the private commits either.

Now we have hide-refs hook to hide refs dynamically, a new
flag `HIDDEN_REF_FORCE` is used to mark a ref if hide-refs hook
decide to hide it, and we make sure the wire protocol V1 will reject
to send the private commits of these refs even if
uploadpack.allowTipSHA1InWant or uploadpack.allowReachableSHA1InWant
are set to true.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 refs.c        | 39 +++++++++++++++++++++++++++++++++++++++
 refs.h        |  3 +++
 upload-pack.c | 14 --------------
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/refs.c b/refs.c
index a99734fedcd..3fbdf967bc6 100644
--- a/refs.c
+++ b/refs.c
@@ -1651,6 +1651,45 @@ int ref_is_hidden(const char *refname, const char *refname_full)
 	return 0;
 }
 
+#define OUR_REF		(1u << 12)
+#define HIDDEN_REF	(1u << 19)
+/*
+ * Use this flag to mark a ref that is hided by hide-refs hook, its private
+ * commits (tip or non-tip commits, not reachable by the refs not hided by
+ * hide-refs hook) will be force hidden to the client, which means client can
+ * not fetch such kind of commit even uploadpack.allowTipSHA1InWant or
+ * uploadpack.allowReachableSHA1InWant are set to true
+ */
+#define HIDDEN_REF_FORCE	(1u << 20)
+
+static unsigned int ref_hidden_flag(const char *refname, const char *refname_full)
+{
+	if (ref_hidden_check(refname, refname_full, 1))
+		return HIDDEN_REF_FORCE;
+	else if (ref_hidden_check(refname, refname_full, 0))
+		return HIDDEN_REF;
+	return OUR_REF;
+}
+
+int mark_our_ref(const char *refname, const char *refname_full,
+		 const struct object_id *oid)
+{
+	struct object *o;
+	unsigned int flag;
+
+	if (!oid || is_null_oid(oid)) {
+		return 0;
+	}
+
+	o = lookup_unknown_object(the_repository, oid);
+	flag = ref_hidden_flag(refname, refname_full);
+	o->flags |= flag;
+
+	if (flag & OUR_REF)
+		return 0;
+	return 1;
+}
+
 const char *find_descendant_ref(const char *dirname,
 				const struct string_list *extras,
 				const struct string_list *skip)
diff --git a/refs.h b/refs.h
index d6575b8c2bd..2feabfe35c4 100644
--- a/refs.h
+++ b/refs.h
@@ -819,6 +819,9 @@ int parse_hide_refs_config(const char *var, const char *value, const char *);
  * parameter always points to the full ref name.
  */
 int ref_is_hidden(const char *, const char *);
+/* return non-zero if the ref is hidden, otherwise 0 */
+int mark_our_ref(const char *refname, const char *refname_full,
+		 const struct object_id *oid);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
diff --git a/upload-pack.c b/upload-pack.c
index b217a1f469e..a8ca5d1c26e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1155,20 +1155,6 @@ static void receive_needs(struct upload_pack_data *data,
 		packet_flush(1);
 }
 
-/* return non-zero if the ref is hidden, otherwise 0 */
-static int mark_our_ref(const char *refname, const char *refname_full,
-			const struct object_id *oid)
-{
-	struct object *o = lookup_unknown_object(the_repository, oid);
-
-	if (ref_is_hidden(refname, refname_full)) {
-		o->flags |= HIDDEN_REF;
-		return 1;
-	}
-	o->flags |= OUR_REF;
-	return 0;
-}
-
 static int check_ref(const char *refname_full, const struct object_id *oid,
 		     int flag, void *cb_data)
 {
-- 
gitgitgadget

