Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E1D21F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:32:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeBFAc5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:32:57 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:39805 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeBFAc4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:32:56 -0500
Received: by mail-pg0-f67.google.com with SMTP id w17so187321pgv.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fLeGzNL+CtwcWuPAWioEbMcbjLPV6ps8cgjM+wHUieY=;
        b=HusVmQ9dQh7L4kBwSHMSz3uqH80HzSfBbhZePyaGKsQ5NvHJ7jRw5T0DXcrTQWEoab
         hwaiE8dnlvdz9785VwwkEzH9XhvVriE5S7lN+h//Np8emeBAtUVvKm2unU11PW40tEoV
         mYdzpLZYakXpJ1cLv4zktnS7pqwNBRsg/HFsBXje0V8eEU7QbZlwTUhHinnHGjsOmZMu
         gWE2HP9pRpE9ZG6pJrzzb0b7stcyZwx9izGAvKC529iZVwuyPiTVuNdVN6NhcuHfuopR
         Jw+a9rc+GHJcjhscnrdz7CPb9AcrTbpgEgnFITIbD/WP029mJu8i+y+W3Y/xfS6jEEqQ
         raCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fLeGzNL+CtwcWuPAWioEbMcbjLPV6ps8cgjM+wHUieY=;
        b=VJcwr4BSbej2qF32+y/sY4kEsTPaNhLl2r5qo5sRR/lo18LZgLsjhY4WejrWd7xYvz
         Luq1o+qgEgXpgWCdipXud9/g0/JFbZESMGASC7pJ1/8IHqFoNZgnKLPKH/Yq2IvpGo0a
         w27oerhnVvX1AIZN90WA1e2h5YNBBdS/PngA6FHqjzHsrsdTZCk6EDY+BoKYZG2RQqk7
         CSrTburzlx5GKGkvcDI5UmaQhRmc9S+pjcGYcj0qHRXVyRFFeuO/NJcSc4Jn29WOtSQx
         h08vKHjU2Ddbwet1h94SYLkPUfwa6pzSFdcKirGdXx8DurgrRv/WAYh24hRCkwZfCtlv
         na6w==
X-Gm-Message-State: APf1xPDbVUNpKGM010aa0XJ2hE51fTevQa3tVUUik2gsLQ3vsxrwYcY4
        FVUE2WB9SP/N+0L5EK9kHyW7Kd6YKWc=
X-Google-Smtp-Source: AH8x226eaBVa00tUInvsvL5sWrOneKGC41vDjuSqtZA1fDKmi7DxQ8asKpXH2OjCQX10jMsgjG+Tyg==
X-Received: by 10.98.17.154 with SMTP id 26mr581437pfr.112.1517877174526;
        Mon, 05 Feb 2018 16:32:54 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id h64sm590872pfh.28.2018.02.05.16.32.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:32:54 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 193/194] submodule: Reorder open_submodule function
Date:   Mon,  5 Feb 2018 16:17:48 -0800
Message-Id: <20180206001749.218943-95-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the next patch we'll need open_submodule in another function, so
move it up.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/submodule.c b/submodule.c
index 022e366940..6b6c5a6710 100644
--- a/submodule.c
+++ b/submodule.c
@@ -481,6 +481,33 @@ void prepare_submodule_repo_env(struct argv_array *out)
 			 DEFAULT_GIT_DIR_ENVIRONMENT);
 }
 
+/*
+ * Initialize 'out' based on the provided submodule path.
+ *
+ * Unlike repo_submodule_init, this tolerates submodules not present
+ * in .gitmodules. NEEDSWORK: The repo_submodule_init behavior is
+ * preferrable. This function exists only to preserve historical behavior.
+ *
+ * Returns 0 on success, -1 when the submodule is not present.
+ */
+static int open_submodule(struct repository *out, const char *path)
+{
+	struct strbuf sb = STRBUF_INIT;
+
+	if (submodule_to_gitdir(&sb, path))
+		return -1;
+
+	if (repo_init(out, sb.buf, NULL)) {
+		strbuf_release(&sb);
+		return -1;
+	}
+
+	out->submodule_prefix = xstrdup(path);
+
+	strbuf_release(&sb);
+	return 0;
+}
+
 /* Helper function to display the submodule header line prior to the full
  * summary output. If it can locate the submodule objects directory it will
  * attempt to lookup both the left and right commits and put them into the
@@ -839,33 +866,6 @@ static int check_has_commit(const struct object_id *oid, void *data)
 	}
 }
 
-/*
- * Initialize 'out' based on the provided submodule path.
- *
- * Unlike repo_submodule_init, this tolerates submodules not present
- * in .gitmodules. NEEDSWORK: The repo_submodule_init behavior is
- * preferrable. This function exists only to preserve historical behavior.
- *
- * Returns 0 on success, -1 when the submodule is not present.
- */
-static int open_submodule(struct repository *out, const char *path)
-{
-	struct strbuf sb = STRBUF_INIT;
-
-	if (submodule_to_gitdir(&sb, path))
-		return -1;
-
-	if (repo_init(out, sb.buf, NULL)) {
-		strbuf_release(&sb);
-		return -1;
-	}
-
-	out->submodule_prefix = xstrdup(path);
-
-	strbuf_release(&sb);
-	return 0;
-}
-
 static int submodule_has_commits(const char *path, struct oid_array *commits)
 {
 	struct repository sub;
-- 
2.15.1.433.g936d1b9894.dirty

