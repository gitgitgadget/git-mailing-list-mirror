Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E4C00140
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 03:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238802AbiHSDWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 23:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbiHSDWB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 23:22:01 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D95D7D3C
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x19so3095616plc.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 20:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=WeHK+Igph7MQZ6Kmhv2hKyoc7Y8PG/v6/Ri7NEyfNY8=;
        b=JKF+rk24dg27UzQaNPMKUOSw/Ii54i44+zAPUqOTTFd7H+30nXArDrlYcSWPd7brn3
         K4W91M6UmW9WXNJ3XoR7sk8oqj2SSf74qzT+p5Lc2FpGVHVejgD7sd9A/4Hln+b0ysA9
         BheTlwH50fFCWi0ZKmanJgSso0wg8zO9nzhAb+6OdU0+PSng0Pr7sg25+ZFXzSr5BOkC
         4qYS9wSaGi71M56C8sfaWZJWqShdrb0KS1Nm9AdJZiHRHAKrCM+mCtvyfSoOy+w4fZBr
         6GE85EoS5rW1GEiaMd0j2AzuPdP6jqu222UDm1Gw8W7pkJa+KTuhrVJy7IZbtJWPi/AW
         fU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=WeHK+Igph7MQZ6Kmhv2hKyoc7Y8PG/v6/Ri7NEyfNY8=;
        b=Pvpb3taVLUS3mFitvo2ZzjYRDJl6kwr+W2Iep7NQntuv47RIf0Imf24Ve63wM0Q7oN
         Lgcf8yPR3ANzzxopaK6tA3FQKXgyBk3Vo/cJqe9oFEjmJXLlVVkDZ8dirCf4Z2tT6pju
         5rUrJzcTSZ5VKBSCHXHrR1ubNe80Qcox+IILFWL6c3Qn8Dmuzw6Jsijm5tE8zZAQN+mY
         p1KMp6LELlkxxOJS919VkJloG9rXn7krULtOI1QDwghQYLbDAOa1rSlZcAStsRJ/MPzr
         jC401FJDkGBYxwbu1VB/SBrqAcdG9TRsKZbUKKSuriPZXONEvCMqTUs6ZQXS6XOnqj4b
         WtOg==
X-Gm-Message-State: ACgBeo1JRzr2IC2CMPkU2CtKxQG3LQCUTLeNtR8g5rWEyrqA8WCTIfAC
        6ZIKSNxG01PaxlC2Xo4rMizo6r+cPV4=
X-Google-Smtp-Source: AA6agR7AshKc9+6sN4ZGO2gshCQ9uJAXYyG43LVVFrkIOwO18WTGGlYJdvk+Zf8eb/aAP4BEKsOZcQ==
X-Received: by 2002:a17:90b:4f8e:b0:1f4:ed30:d286 with SMTP id qe14-20020a17090b4f8e00b001f4ed30d286mr6349745pjb.66.1660879318982;
        Thu, 18 Aug 2022 20:21:58 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id t3-20020a170902d14300b0016f1319d2a7sm2036995plt.297.2022.08.18.20.21.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Aug 2022 20:21:58 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
        Michael Heemskerk <mheemskerk@atlassian.com>,
        Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v2 7/9] refs: get error message via refs_update_ref_extended()
Date:   Fri, 19 Aug 2022 11:21:45 +0800
Message-Id: <20220819032147.28841-8-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
References: <CANYiYbFw71bX827akAG87RSKOozPk313Hoe573O9dQ65_U6sLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

The last parameter of the function "refs_update_ref()" is an enum
"action_on_err", and we can not use this function to get the error
message. Extend this function to get error message.

We will use the function "refs_update_ref_extended()" to reimplement
the function "files_copy_or_rename_ref()" in later commit.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 refs.c | 50 +++++++++++++++++++++++++-------------------------
 refs.h |  2 +-
 2 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/refs.c b/refs.c
index 15130f09b9..a528473a46 100644
--- a/refs.c
+++ b/refs.c
@@ -1185,11 +1185,29 @@ int refs_update_ref(struct ref_store *refs, const char *msg,
 		    enum action_on_err onerr)
 {
 	struct reflog_info reflog_info;
+	struct strbuf err = STRBUF_INIT;
+	int ret;
 
 	reflog_info.msg = (char *)msg;
 	reflog_info.old_oid = NULL;
-	return refs_update_ref_extended(refs, refname, new_oid, old_oid,
-					flags, &reflog_info, onerr);
+	ret = refs_update_ref_extended(refs, refname, new_oid, old_oid,
+				       flags, &reflog_info, &err);
+	if (ret) {
+		const char *str = _("update_ref failed for ref '%s': %s");
+
+		switch (onerr) {
+		case UPDATE_REFS_MSG_ON_ERR:
+			error(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_DIE_ON_ERR:
+			die(str, refname, err.buf);
+			break;
+		case UPDATE_REFS_QUIET_ON_ERR:
+			break;
+		}
+	}
+	strbuf_release(&err);
+	return ret;
 }
 
 int refs_update_ref_extended(struct ref_store *refs,
@@ -1198,37 +1216,19 @@ int refs_update_ref_extended(struct ref_store *refs,
 			     const struct object_id *old_oid,
 			     unsigned int flags,
 			     const struct reflog_info *reflog_info,
-			     enum action_on_err onerr)
+			     struct strbuf *err)
 {
 	struct ref_transaction *t = NULL;
-	struct strbuf err = STRBUF_INIT;
-	int ret = 0;
 
-	t = ref_store_transaction_begin(refs, &err);
+	t = ref_store_transaction_begin(refs, err);
 	if (!t ||
 	    ref_transaction_update_extended(t, refname, new_oid, old_oid,
-					    flags, reflog_info, &err) ||
-	    ref_transaction_commit(t, &err)) {
-		ret = 1;
+					    flags, reflog_info, err) ||
+	    ref_transaction_commit(t, err)) {
 		ref_transaction_free(t);
-	}
-	if (ret) {
-		const char *str = _("update_ref failed for ref '%s': %s");
-
-		switch (onerr) {
-		case UPDATE_REFS_MSG_ON_ERR:
-			error(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_DIE_ON_ERR:
-			die(str, refname, err.buf);
-			break;
-		case UPDATE_REFS_QUIET_ON_ERR:
-			break;
-		}
-		strbuf_release(&err);
 		return 1;
 	}
-	strbuf_release(&err);
+
 	if (t)
 		ref_transaction_free(t);
 	return 0;
diff --git a/refs.h b/refs.h
index 0f21ba259f..85832c4863 100644
--- a/refs.h
+++ b/refs.h
@@ -825,7 +825,7 @@ int refs_update_ref_extended(struct ref_store *refs,
 			     const struct object_id *old_oid,
 			     unsigned int flags,
 			     const struct reflog_info *reflog_info,
-			     enum action_on_err onerr);
+			     struct strbuf *err);
 int update_ref(const char *msg, const char *refname,
 	       const struct object_id *new_oid, const struct object_id *old_oid,
 	       unsigned int flags, enum action_on_err onerr);
-- 
2.36.1.25.gc87d5ad63a.dirty

