Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D763C6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 08:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiITIZ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiITIZS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 04:25:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B5965557
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:23:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso1115172wmr.3
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 01:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=w98ayTfiOelGTSb248qoEl8t0T22TZDz6ldsyPa8uf0=;
        b=W1VflUwi8Xjf7ADkdS0UDUXdZW951Our4u4n7LP/BKbOqMenRzJf9gxE6O0BZ9dIFo
         /UfSoNjqd6kEiFgQfPOu77cDUsTVZOhfV3XkfyW4VqaTHrpoNsENmAazCCbe5IZJjiL/
         8HKGSnvnU5hvbAVeG/5zDq8c1LpJGLmUiRy/VfDQFDBew82Z94x5le2qZ9Az1czJm6Bf
         ee/3G9pa5jyxGV5DwlgQr+quUb6Cjm8MIbtvg/lOT2Y3XcdRsODM9yKd+XBJuHpa1A2a
         eMzAm2+gF/sQcYx48+Siz5EtIgWA5LkF0Nn7mwtVOUwTx/HTRUdtrAXuZ89sTwXJGVBh
         iDkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w98ayTfiOelGTSb248qoEl8t0T22TZDz6ldsyPa8uf0=;
        b=EzPPLbekhDbTD8m3BGPwbFUb44x5TySJC9EZZwoS9r7nLAaiNY9Z4O1PLW9LMVOUUR
         6hFv8elOohDduUjc2PygtzM8mIyA+NBdYBAEwPN53z7kEVVrAnTD7WC0yIITEf8rNawu
         bM/UWjdFNUXXAYpbxhu5bT+63BOp7suygybgnPcU0HxOSvX6/9PrMwfDqVhCANq1WWNi
         kzfM+I+u04UWpLUBPNWfbJju+bQEjKCOdU3qz3gVZQVOtpXIHCKtfBytUWxdlw2eI+Cb
         BWjS273TAytCR9JnrRMKEUKYFI4CBY9ibq9Egc2MWR8+CvrFH/KVjjgrUYKKoJM88Ltl
         dcdQ==
X-Gm-Message-State: ACrzQf1pTkUpdzD6S/T1a7Yiogr1qzaPOaqSjcEKiaIUiM9nXguURF7V
        MQcL2hkXkD7n7J1WYAJuu4tyzOVQ/QQ=
X-Google-Smtp-Source: AMsMyM7i+9xRhbhblH7bYiQSyI6WjVa+1yn4PJLERJW8A79lV91L/oCo/sX3SbC6zuKRDLIADrMf6A==
X-Received: by 2002:a05:600c:198d:b0:3b4:b6b6:6fa with SMTP id t13-20020a05600c198d00b003b4b6b606famr1466683wmq.110.1663662171303;
        Tue, 20 Sep 2022 01:22:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b003b332a7bf15sm17482312wmq.7.2022.09.20.01.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 01:22:50 -0700 (PDT)
Message-Id: <0013476266e05aebd41e455b3d6305e8ec347a9e.1663662167.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v6.git.git.1663662167.gitgitgadget@gmail.com>
References: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
        <pull.1301.v6.git.git.1663662167.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 08:22:45 +0000
Subject: [PATCH v6 3/5] hiderefs: hornor hide flags in wire protocol V2
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

Previously hiderefs configurations can not protect the private data
of hiding refs in wire protocol V2, for example, an `ALL_FLAGS` flag
will be used to clear all the objects before handling the fetch requests.

Hornor the hide flags by removing the `HIDDEN_REFS` flag from the
`ALL_FLAGS` and make sure all the refs will check its hidden flags
before sending the pack to client, especially during stateless RPC.
And if there are refs with `HIDDEN_REF_FORCE` flag, use `check_non_tip`
to protect the private data of force-hidden refs.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
---
 ls-refs.c     |  2 +-
 refs.c        | 20 ++++++++++++++++++++
 refs.h        |  4 ++++
 upload-pack.c | 11 +++++++++--
 4 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/ls-refs.c b/ls-refs.c
index 98e69373c84..b5cb1316d38 100644
--- a/ls-refs.c
+++ b/ls-refs.c
@@ -84,7 +84,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 
 	strbuf_reset(&data->buf);
 
-	if (ref_is_hidden(refname_nons, refname))
+	if (mark_our_ref(refname_nons, refname, oid))
 		return 0;
 
 	if (!ref_match(&data->prefixes, refname_nons))
diff --git a/refs.c b/refs.c
index 5a9079fd4c4..847f7c003e6 100644
--- a/refs.c
+++ b/refs.c
@@ -1659,6 +1659,25 @@ int ref_is_hidden(const char *refname, const char *refname_full)
  */
 #define HIDDEN_REF_FORCE	(1u << 20)
 
+/* Use this variable to record existing object hidden flags */
+static unsigned int objects_hidden_flags;
+
+/* Return non-zero if need to batch check hidden refs, otherwise 0 */
+int need_check_hidden_refs(void)
+{
+	if (!objects_hidden_flags)
+		return 1;
+	return 0;
+}
+
+/* Return non-zero if some ref is force hidden, otherwise 0 */
+int has_force_hidden_refs(void)
+{
+	if (objects_hidden_flags & HIDDEN_REF_FORCE)
+		return 1;
+	return 0;
+}
+
 static unsigned int ref_hidden_flag(const char *refname, const char *refname_full)
 {
 	if (ref_hidden_check(refname, refname_full, 1))
@@ -1681,6 +1700,7 @@ int mark_our_ref(const char *refname, const char *refname_full,
 	o = lookup_unknown_object(the_repository, oid);
 	flag = ref_hidden_flag(refname, refname_full);
 	o->flags |= flag;
+	objects_hidden_flags |= flag;
 
 	if (flag & OUR_REF)
 		return 0;
diff --git a/refs.h b/refs.h
index 2feabfe35c4..8deb36a95cc 100644
--- a/refs.h
+++ b/refs.h
@@ -822,6 +822,10 @@ int ref_is_hidden(const char *, const char *);
 /* return non-zero if the ref is hidden, otherwise 0 */
 int mark_our_ref(const char *refname, const char *refname_full,
 		 const struct object_id *oid);
+/* return non-zero if need to batch check hidden refs, otherwise 0 */
+int need_check_hidden_refs(void);
+/* return non-zero if some ref is force hidden, otherwise 0 */
+int has_force_hidden_refs(void);
 
 enum ref_type {
 	REF_TYPE_PER_WORKTREE,	  /* refs inside refs/ but not shared       */
diff --git a/upload-pack.c b/upload-pack.c
index a8ca5d1c26e..a9a24399d8e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -39,8 +39,8 @@
 #define CLIENT_SHALLOW	(1u << 18)
 #define HIDDEN_REF	(1u << 19)
 
-#define ALL_FLAGS (THEY_HAVE | OUR_REF | WANTED | COMMON_KNOWN | SHALLOW | \
-		NOT_SHALLOW | CLIENT_SHALLOW | HIDDEN_REF)
+#define ALL_FLAGS (THEY_HAVE |WANTED | COMMON_KNOWN | SHALLOW | \
+		NOT_SHALLOW | CLIENT_SHALLOW)
 
 /* Enum for allowed unadvertised object request (UOR) */
 enum allow_uor {
@@ -1726,6 +1726,13 @@ int upload_pack_v2(struct repository *r, struct packet_reader *request)
 				state = FETCH_DONE;
 			break;
 		case FETCH_SEND_PACK:
+			if (need_check_hidden_refs()) {
+				head_ref_namespaced(check_ref, NULL);
+				for_each_namespaced_ref(check_ref, NULL);
+			}
+			if (has_force_hidden_refs())
+				check_non_tip(&data);
+
 			send_wanted_ref_info(&data);
 			send_shallow_info(&data);
 
-- 
gitgitgadget

