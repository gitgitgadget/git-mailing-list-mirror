Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9C81C433FE
	for <git@archiver.kernel.org>; Thu, 17 Mar 2022 18:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237182AbiCQSKP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Mar 2022 14:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237145AbiCQSKO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Mar 2022 14:10:14 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A61162B6
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id a1so7099549wrh.10
        for <git@vger.kernel.org>; Thu, 17 Mar 2022 11:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rgu8zNsuzk0cMtndlG8lbYMfo7qxbFWDF94knNtZgOI=;
        b=Pl4hm2sxIO//8jsEzRcTB7bwWum4hRAl49EhNd50Wo2SrKSSbLaJD0rFpVe93iNSmE
         zfO8aT0SYa9bJYGgWqdvHhutY0TVlbI1ZCX01/kCEukceT9D5au3P1B4P5gTsKCkO6Pv
         eS26co5y980iEDoOOnigDcPdi72E035JMFVL/gJ5QFyR6eYtfMtlhMJ3/dzpj4r+U/5n
         /MFkyY8MEYWrlfzELVEy3B78jUC9UrO5gPp/1MeZkFfBXAKt3jceYoYHkO+XMHdcX63O
         70a7Dv4DAEIcoVkspnPLPVVjRi8AbbNeEy50QhAGbDowNfycjmHZ99lvNReqLOKYaP3B
         praw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rgu8zNsuzk0cMtndlG8lbYMfo7qxbFWDF94knNtZgOI=;
        b=TyWc1bM9mmWzhM48MJtWqdkN+H7Uodu1ABdhLpo7g4hNMa+wlRgIZeEvdibyGCZ99d
         +J6qgMR7tO6lzhXg/j+mEMma6HpEFbOXzWro8RFI16tYU7RCQqOCdJeziDovKm4YgI6a
         16fL2VvaQitDUrZ/U1JqfPKWoxbh1V97DA54a3pJ25hTAOzuSYTTBMROON8upnTTZlnX
         YvxDHrtyE4jDXQDEyHTiQ2P3hDdQbU4Rc4IfyhaSgJw94KgSZ2FeCdeiRncfQLRpUGkf
         nnfjwUE++LeCXesraYmEsTuTSsubh0d1np6tadMefJ/0PbmsOfO+qh54+gf3/tivX5um
         3Q8g==
X-Gm-Message-State: AOAM530h+oOZY/dkU1DvaYJaiOcNsH3NQ9nJlLLBBsVzjaiNlqoSdJHY
        B9K/E253jO7gjI5YE3YghO0atOY3PpmMgA==
X-Google-Smtp-Source: ABdhPJy0Am/sHrWNv9udBRZ4X+ieg2IXYF5/tmJq1yPQrCwVjCFrONUD+5liYKg/khzEr0teLxU4nw==
X-Received: by 2002:adf:f201:0:b0:1ed:c254:c1a2 with SMTP id p1-20020adff201000000b001edc254c1a2mr5110596wro.106.1647540535588;
        Thu, 17 Mar 2022 11:08:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d5988000000b00203d5f1f3e4sm4756253wri.105.2022.03.17.11.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 11:08:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/8] reflog.c: indent argument lists
Date:   Thu, 17 Mar 2022 19:08:33 +0100
Message-Id: <patch-1.8-5069b3fd0ff-20220317T180439Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1384.g7d2906948a1
In-Reply-To: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20220317T180439Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reflog.c was lib-ified in 7d3d226e700 (reflog: libify delete
reflog function and helpers, 2022-03-02) these previously "static"
functions were made non-"static", but the argument lists were not
correspondingly indented according to our usual coding style. Let's do
that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 reflog.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/reflog.c b/reflog.c
index 333fd8708fe..82e5a935117 100644
--- a/reflog.c
+++ b/reflog.c
@@ -240,8 +240,8 @@ static int unreachable(struct expire_reflog_policy_cb *cb, struct commit *commit
  * Return true iff the specified reflog entry should be expired.
  */
 int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
-				    const char *email, timestamp_t timestamp, int tz,
-				    const char *message, void *cb_data)
+			     const char *email, timestamp_t timestamp, int tz,
+			     const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit *old_commit, *new_commit;
@@ -273,10 +273,10 @@ int should_expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
 }
 
 int should_expire_reflog_ent_verbose(struct object_id *ooid,
-					    struct object_id *noid,
-					    const char *email,
-					    timestamp_t timestamp, int tz,
-					    const char *message, void *cb_data)
+				     struct object_id *noid,
+				     const char *email,
+				     timestamp_t timestamp, int tz,
+				     const char *message, void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
 	int expire;
@@ -323,8 +323,8 @@ static int is_head(const char *refname)
 }
 
 void reflog_expiry_prepare(const char *refname,
-				  const struct object_id *oid,
-				  void *cb_data)
+			   const struct object_id *oid,
+			   void *cb_data)
 {
 	struct expire_reflog_policy_cb *cb = cb_data;
 	struct commit_list *elem;
@@ -377,8 +377,8 @@ void reflog_expiry_cleanup(void *cb_data)
 }
 
 int count_reflog_ent(struct object_id *ooid, struct object_id *noid,
-		const char *email, timestamp_t timestamp, int tz,
-		const char *message, void *cb_data)
+		     const char *email, timestamp_t timestamp, int tz,
+		     const char *message, void *cb_data)
 {
 	struct cmd_reflog_expire_cb *cb = cb_data;
 	if (!cb->expire_total || timestamp < cb->expire_total)
-- 
2.35.1.1384.g7d2906948a1

