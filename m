Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5555AECAAD3
	for <git@archiver.kernel.org>; Fri,  9 Sep 2022 15:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiIIPGm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Sep 2022 11:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbiIIPGe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2022 11:06:34 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B501398AF
        for <git@vger.kernel.org>; Fri,  9 Sep 2022 08:06:33 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id az6so1606999wmb.4
        for <git@vger.kernel.org>; Fri, 09 Sep 2022 08:06:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=pYCt+GIxlPZabbIqw3S4SCnTIXZpAJVLZCV4Z03hD3Q=;
        b=ToklzmSvJDUwxywLPIwcwyvaXBwscZJwklHc9V17qbWWWIuoSohXGTHC5PdhddsTJ9
         vL6E3PChql2bV7qSU2WuB4u7VTUK5DDAYI696DNUcJ3rfwGcJxUhk42a8rzHKJgD7TrH
         QVSLgp4UuZpF99o7Q0Ar0nlUXtlGtGsnvb74DMnQWNgCYBN0NS9RCUai2EOFK9fuGpyx
         W8j43QoBFwHHTJkTDGyYwXaLboRzHyVhx+v73zIUZhKrP/HHM5BbIbsFfqnXmXOVbeUp
         zNX3lZ/Uq9QIFUh6yKE9zz6Hu564FEpdekZ9G1wOO83dlDZRZoiUVElFBh/P6QgZTSjc
         dRJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pYCt+GIxlPZabbIqw3S4SCnTIXZpAJVLZCV4Z03hD3Q=;
        b=I82FvAD0cog4dj19TDJtF0vkTpPS+zUjJpqQ3cw6H7a0TImNvThbe1UiilPvYjVtk5
         H22180VVluauDvL0IiqYAUsrK0jYo7MhKA1EbKlfLPt8NDcR8H3SA5fpppeD31UhEiaH
         8CI8idPxGXAlFVaynyMM8PCfH70FSlTKNTnl+JXiVBFInlCZyfNGqm9ffHh0ezWLm7DP
         8c+YV5p31lM1XVX8VNyPr9WC/fdSXqnWDTblzmP9NK3EF/tHQSH9iw+n3e8UruT4Utu2
         Gl7ACgpVLeZMP2/PhWaYpCzNLtdjuTbmfIr9WRBAlm+br07JfsdPHCmqURGh6m5kU7qz
         wlLQ==
X-Gm-Message-State: ACgBeo3Wau95s1oR3NdlHcrpKew4z1cYdFmfAFzh8MiGofDUsN9ByBTi
        obXYapQu3q4SLa3e7pEdLdhDwUZObic=
X-Google-Smtp-Source: AA6agR7lLfrdwEE4dV+Y+eT+VQNfMNNQEVgjlNs9TLtOYsCrni2DgDZm6c6d3s8LFU+X79+SVZtWOQ==
X-Received: by 2002:a05:600c:198f:b0:3a6:2482:b2be with SMTP id t15-20020a05600c198f00b003a62482b2bemr5882102wmq.110.1662735991000;
        Fri, 09 Sep 2022 08:06:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c7-20020a05600c0ac700b003a331c6bffdsm908630wmr.47.2022.09.09.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 08:06:30 -0700 (PDT)
Message-Id: <de73f5a6fd92624fd0d8fba082f16e27935227e0.1662735985.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
References: <pull.1301.v4.git.git.1660575688.gitgitgadget@gmail.com>
        <pull.1301.v5.git.git.1662735985.gitgitgadget@gmail.com>
From:   "Sun Chao via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 09 Sep 2022 15:06:23 +0000
Subject: [PATCH v5 3/5] hiderefs: hornor hide flags in wire protocol V2
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

Previously hide refs can not protect private data of hide refs in wire
protocol V2, for example a `ALL_FLAGS` will be used to clear all the
objects before handling the fetch requests.

Hornor the hide flags by removing `HIDDEN_REFS` flag from `ALL_FLAGS`
and make sure all the refs will check its hidden flags before sending pack
to client, especially during stateless rpc. And if there are refs with
`HIDDEN_REF_FORCE` flag, use `check_non_tip` to protect the private date
of force hidden refs.

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
index 3fbdf967bc6..1424de0048e 100644
--- a/refs.c
+++ b/refs.c
@@ -1662,6 +1662,25 @@ int ref_is_hidden(const char *refname, const char *refname_full)
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
@@ -1684,6 +1703,7 @@ int mark_our_ref(const char *refname, const char *refname_full,
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

