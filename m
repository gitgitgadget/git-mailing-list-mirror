Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 415632013C
	for <e@80x24.org>; Wed, 15 Feb 2017 00:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbdBOAfX (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 19:35:23 -0500
Received: from mail-it0-f46.google.com ([209.85.214.46]:36138 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751457AbdBOAfU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 19:35:20 -0500
Received: by mail-it0-f46.google.com with SMTP id c7so56118326itd.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 16:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=p0nFcL0QQypePlMP2QPTBihcvK3dsICLYX39DeQQ+zE=;
        b=NXpfF1SWhqFEXUBGCiMINDd7i2z6K6sUBLk5ZQD1sKopottCo1zHkj3g9bUgZjlJz6
         LiNeUBKb5WSh5khsuscCqpoT5uuOF+WZB7iDU/v7vwtoNScYNyNAUyGQ/UOHYfd/iKy1
         k+6sA2aH4VE/8q8180dZAYN2SoqhD/0ddIj0y24Ud+0rd4n0DbgtdXeY6cAaPd/RcL50
         PIw8/2ZV4FH00i2haN34Ri4K8BKPQi9jd9RqF6utbHNLEP+VvVUppZ6PFIs/OjFcc+jt
         EOg1xfN/YIN61a1zI7x4964nlcPe36jX23ZhddF0nHDDXZMFyLFnR5up9AnDjCrEa4kF
         ErsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p0nFcL0QQypePlMP2QPTBihcvK3dsICLYX39DeQQ+zE=;
        b=gUHkTItr6yTCfksTZqzJOO7oox4JBVPtXqKHpDZQsoTEaAaAy+9OCyuFC1FB/f06qE
         nDP3aeqPivdz528p09/yVYtbOME4ZmGZUqgGpFkbY+TBfRkeYjOYgvYN+wucgHpabRwJ
         fAm8J/Lz73oMbdorF+2cEOuyqMBPKSuq7Rrucj1Myf+Oe8+jrf/HenkYZbOxaYHICa29
         8fT8YoxJQSd3dFkUs+QrmOrCGtDJG7qwiJuj5lIyHeBUMqtuuyqnhOr5sMz0x8CgziD7
         ExW0dX0mvgs4NwNuwKscshyB8KkGrsDNP8DPi7l+QA/Hf1aORrJYapV4CLmJjcwQ4rQR
         SEkw==
X-Gm-Message-State: AMke39lwAcUC/LidosOlFI+lrm4JbruyzrQt3eIeVsG496+MGQ2+4WYr5eTHlx74TATnPKCu
X-Received: by 10.99.108.74 with SMTP id h71mr34760572pgc.99.1487118919671;
        Tue, 14 Feb 2017 16:35:19 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:c832:5c94:8ab0:6fa4])
        by smtp.gmail.com with ESMTPSA id b18sm3277834pfd.106.2017.02.14.16.35.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Feb 2017 16:35:19 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        sandals@crustytoothpaste.net, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/14] entry.c: update submodules when interesting
Date:   Tue, 14 Feb 2017 16:34:22 -0800
Message-Id: <20170215003423.20245-14-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc0.16.gd1691994b4.dirty
In-Reply-To: <20170215003423.20245-1-sbeller@google.com>
References: <20170215003423.20245-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/entry.c b/entry.c
index c6eea240b6..bc6295d41a 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,7 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include "submodule.h"
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -203,6 +204,13 @@ static int write_entry(struct cache_entry *ce,
 			return error("cannot create temporary submodule %s", path);
 		if (mkdir(path, 0777) < 0)
 			return error("cannot create submodule directory %s", path);
+		if (is_interesting_submodule(ce))
+				/*
+				 * force=1 is ok for any case as we did a dry
+				 * run before with appropriate force setting
+				 */
+				return submodule_go_from_to(ce->name,
+					NULL, oid_to_hex(&ce->oid), 0, 1);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
@@ -260,6 +268,26 @@ int checkout_entry(struct cache_entry *ce,
 
 	if (!check_path(path.buf, path.len, &st, state->base_dir_len)) {
 		unsigned changed = ce_match_stat(ce, &st, CE_MATCH_IGNORE_VALID|CE_MATCH_IGNORE_SKIP_WORKTREE);
+		/*
+		 * Needs to be checked before !changed returns early,
+		 * as the possibly empty directory was not changed
+		 */
+		if (is_interesting_submodule(ce)) {
+			int err;
+			if (!is_submodule_populated_gently(ce->name, &err)) {
+				struct stat sb;
+				if (lstat(ce->name, &sb))
+					die(_("could not stat file '%s'"), ce->name);
+				if (!(st.st_mode & S_IFDIR))
+					unlink_or_warn(ce->name);
+
+				return submodule_go_from_to(ce->name,
+					NULL, oid_to_hex(&ce->oid), 0, 1);
+			} else
+				return submodule_go_from_to(ce->name,
+					"HEAD", oid_to_hex(&ce->oid), 0, 1);
+		}
+
 		if (!changed)
 			return 0;
 		if (!state->force) {
-- 
2.12.0.rc0.16.gd1691994b4.dirty

