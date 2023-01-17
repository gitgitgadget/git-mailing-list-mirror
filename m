Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9CC2C3DA78
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 21:07:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjAQVHO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 16:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjAQVFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 16:05:18 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4522B485BF
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:28 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id d8-20020a17090a7bc800b00226eb4523ceso14115067pjl.7
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 11:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9UYEXF3G0VPlpyjkNaZnMT3/iXrXxy0ZR2fsd622mrc=;
        b=LQuNnVDBIGOmjWaLV2L1yz1Q5DpXcUKpc3Az8rXXPl069TQEubP9W/xcc/zZq39nqp
         S6sS44fNGLVygaLox7W8QVG0cVwaqWl52nZCfEKy1iiWW/bTt9yLW85zOwBdbm1xv82T
         T52akx3FEYQND41/tTO0/MywShde86dI3dCZ0d/Y3EsuwaTXQqIrunD9sG0WJ75k06+3
         CNNrbngGKXmckg4Pxyv8BTPuLDIuzLE+IpVRkO2dcev/On3S+lAO1sPATCQbZYaODWqt
         1R/eFQFejw4jnzOyeP+GALrBwV1bUPY+9RZd4AeRKpIunejiQryxRPtz3sTYMI4jNDrQ
         /O4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9UYEXF3G0VPlpyjkNaZnMT3/iXrXxy0ZR2fsd622mrc=;
        b=7KRcvF746NLUonLqJopaD0gcl6bCyiU387CRvuojBDdoX6IwkrDQSPOa/CUJz2Oxng
         6L9H9sabSFujpOQAA+oPp6yo/aYrMrwj+Lh1G1XLGF6rOU24XfyhG0c1iWeivx8iLab2
         do0AqxpzRj7i71NuDGVCjgxfKjAoHNMQ9Raq1OPwUjGvEt0bItz4j0kCUrBhDgGRVPVN
         CZuCxhyG9wIcUffvz74jD+xsiN18LWLSvF+TOMSwvP5iJQ6OjaJ/8nv5EG+yS6f2gxqe
         wKVS+ltqeq4BWzUXyH6IDIl1vNJMK10GHqiJH47FEo+lzLLOCUHgpSuVjeThgzl0DUri
         xQDg==
X-Gm-Message-State: AFqh2kp8eqsCs6lsSuRl1wDGwxvq/cKS2wJ23xmJ/g5nhdqMWyIJpAGr
        w8328nJM8DsVL5fJOZL7+hmLeXQj48mP+1BgG3XTfRqcV2mULxLYU265Conecv1XcfZcieJsPB+
        OLUDXrkJYnCfWLTf0aZ2mbLG0xV18I4cTQCvprvJw9AnJtxkaiASB7Gay0SaRnFpehQ==
X-Google-Smtp-Source: AMrXdXt/cpvlTb6EmNhc+xehT08Zv3QlLabSPnv0eFUxlbJZ7bXbm5z3WMskZzcvTZJczbMoSVJLU2dTYyIxNdA=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:8d8e:b0:193:2bec:a3f2 with SMTP
 id v14-20020a1709028d8e00b001932beca3f2mr401425plo.22.1673983888289; Tue, 17
 Jan 2023 11:31:28 -0800 (PST)
Date:   Tue, 17 Jan 2023 19:30:41 +0000
In-Reply-To: <20230104215415.1083526-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230104215415.1083526-1-calvinwan@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230117193041.708692-7-calvinwan@google.com>
Subject: [PATCH v6 6/6] submodule: call parallel code from serial status
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, emilyshaffer@google.com,
        avarab@gmail.com, phillip.wood123@gmail.com, chooglen@google.com,
        newren@gmail.com, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the serial implementation of status inside of
is_submodule_modified since the parallel implementation of status with
one job accomplishes the same task.

Combine parse_status_porcelain and parse_status_porcelain_strbuf since
the only other caller of parse_status_porcelain was in
is_submodule_modified

Signed-off-by: Calvin Wan <calvinwan@google.com>
---
 submodule.c | 146 ++++++++++++++++++----------------------------------
 1 file changed, 51 insertions(+), 95 deletions(-)

diff --git a/submodule.c b/submodule.c
index da95ea1f5e..2009748d9f 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1887,46 +1887,7 @@ int fetch_submodules(struct repository *r,
 	return spf.result;
 }
 
-static int parse_status_porcelain(char *str, size_t len,
-				  unsigned *dirty_submodule,
-				  int ignore_untracked)
-{
-	/* regular untracked files */
-	if (str[0] == '?')
-		*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-	if (str[0] == 'u' ||
-	    str[0] == '1' ||
-	    str[0] == '2') {
-		/* T = line type, XY = status, SSSS = submodule state */
-		if (len < strlen("T XY SSSS"))
-			BUG("invalid status --porcelain=2 line %s",
-			    str);
-
-		if (str[5] == 'S' && str[8] == 'U')
-			/* nested untracked file */
-			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
-
-		if (str[0] == 'u' ||
-		    str[0] == '2' ||
-		    memcmp(str + 5, "S..U", 4))
-			/* other change */
-			*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
-	}
-
-	if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
-	    ((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
-	     ignore_untracked)) {
-		/*
-		* We're not interested in any further information from
-		* the child any more, neither output nor its exit code.
-		*/
-		return 1;
-	}
-	return 0;
-}
-
-static void parse_status_porcelain_strbuf(struct strbuf *buf,
+static void parse_status_porcelain(struct strbuf *buf,
 				   unsigned *dirty_submodule,
 				   int ignore_untracked)
 {
@@ -1936,65 +1897,60 @@ static void parse_status_porcelain_strbuf(struct strbuf *buf,
 	string_list_split(&list, buf->buf, '\n', -1);
 
 	for_each_string_list_item(item, &list) {
-		if (parse_status_porcelain(item->string,
-					   strlen(item->string),
-					   dirty_submodule,
-					   ignore_untracked))
+		char *str = item->string;
+		/* regular untracked files */
+		if (str[0] == '?')
+			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+		if (str[0] == 'u' ||
+		str[0] == '1' ||
+		str[0] == '2') {
+			/* T = line type, XY = status, SSSS = submodule state */
+			if (strlen(str) < strlen("T XY SSSS"))
+				BUG("invalid status --porcelain=2 line %s",
+				str);
+
+			if (str[5] == 'S' && str[8] == 'U')
+				/* nested untracked file */
+				*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
+
+			if (str[0] == 'u' ||
+			str[0] == '2' ||
+			memcmp(str + 5, "S..U", 4))
+				/* other change */
+				*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
+		}
+
+		if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
+		    ((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
+		    ignore_untracked)) {
+			/*
+			* We're not interested in any further information from
+			* the child any more, neither output nor its exit code.
+			*/
 			break;
+		}
 	}
 	string_list_clear(&list, 0);
 }
 
 unsigned is_submodule_modified(const char *path, int ignore_untracked)
 {
-	struct child_process cp = CHILD_PROCESS_INIT;
-	struct strbuf buf = STRBUF_INIT;
-	FILE *fp;
-	unsigned dirty_submodule = 0;
-	const char *git_dir;
-	int ignore_cp_exit_code = 0;
-
-	strbuf_addf(&buf, "%s/.git", path);
-	git_dir = read_gitfile(buf.buf);
-	if (!git_dir)
-		git_dir = buf.buf;
-	if (!is_git_directory(git_dir)) {
-		if (is_directory(git_dir))
-			die(_("'%s' not recognized as a git repository"), git_dir);
-		strbuf_release(&buf);
-		/* The submodule is not checked out, so it is not modified */
-		return 0;
-	}
-	strbuf_reset(&buf);
-
-	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
-	if (ignore_untracked)
-		strvec_push(&cp.args, "-uno");
-
-	prepare_submodule_repo_env(&cp.env);
-	cp.git_cmd = 1;
-	cp.no_stdin = 1;
-	cp.out = -1;
-	cp.dir = path;
-	if (start_command(&cp))
-		die(_("Could not run 'git status --porcelain=2' in submodule %s"), path);
-
-	fp = xfdopen(cp.out, "r");
-	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
-		char *str = buf.buf;
-		const size_t len = buf.len;
-
-		ignore_cp_exit_code = parse_status_porcelain(str, len, &dirty_submodule,
-							     ignore_untracked);
-		if (ignore_cp_exit_code)
-			break;
-	}
-	fclose(fp);
-
-	if (finish_command(&cp) && !ignore_cp_exit_code)
-		die(_("'git status --porcelain=2' failed in submodule %s"), path);
-
-	strbuf_release(&buf);
+	struct submodule_status_util util = {
+		.dirty_submodule = 0,
+		.ignore_untracked = ignore_untracked,
+		.path = path,
+	};
+	struct string_list sub = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
+	int dirty_submodule;
+
+	item = string_list_append(&sub, path);
+	item->util = &util;
+	if (get_submodules_status(&sub, 1))
+		die(_("submodule status failed"));
+	dirty_submodule = util.dirty_submodule;
+	string_list_clear(&sub, 0);
 	return dirty_submodule;
 }
 
@@ -2096,9 +2052,9 @@ static int status_finish(int retvalue, struct strbuf *err,
 		    task->path);
 	}
 
-	parse_status_porcelain_strbuf(&task->out,
-			      &util->dirty_submodule,
-			      util->ignore_untracked);
+	parse_status_porcelain(&task->out,
+			       &util->dirty_submodule,
+			       util->ignore_untracked);
 
 	strbuf_release(&task->out);
 	free(task);
-- 
2.39.0.314.g84b9a713c41-goog

