Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6038C46467
	for <git@archiver.kernel.org>; Wed,  4 Jan 2023 21:55:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240392AbjADVzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Jan 2023 16:55:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240366AbjADVzB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jan 2023 16:55:01 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84FB51EEEA
        for <git@vger.kernel.org>; Wed,  4 Jan 2023 13:54:51 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id om16-20020a17090b3a9000b002216006cbffso23176717pjb.3
        for <git@vger.kernel.org>; Wed, 04 Jan 2023 13:54:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9/vkAOAnT96FKvWsQTiyEgfPodVet54xzExY6d4HiUs=;
        b=CozFRcG3AVjIKnNyThp0xWnPU8Blif2uOZZUCUs0oWCno8M6PVDheJPSyBf5OxAerE
         L0PBd3ayzmlVEuKt9SsleduCkJuBxKqDr5evzhysP2e3DznLS22W4P72aPdSYA9ZnpfD
         R8ElWybAPHVNVS8obDIQ2pZVZrtsIZSztFJan40+D7dMBcThVco8vTgXHBTtD1Qzc4H+
         Ak6k7LSqYe4rJL54tTiIUq0HeNUHhbBRGwiKcAXXB4QYYjIaWucl2W6ezVuY7MIL7esN
         gQVwOA+cgu7DcWRR5HwwLgyrvyWwV5//XHZtROyEi0VrAC8OjAK+JNoVAwxuuCF1oZe+
         Gwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/vkAOAnT96FKvWsQTiyEgfPodVet54xzExY6d4HiUs=;
        b=2WD2csHMTF4uH8UFiUD2eS0Bc6BbpsQa1gbd7TOmw6+4BZYciqCf4zUzRddfPfmx31
         4mgNuC971EBnEyM2KCK90AIlrDPaXzoOEdzdRawjs75YsTViQm9UL2/2k9nTw64ps6vX
         co66efJCslbp+qUnVwpLnFUHDiEzzy4ShV79AW/XYb5ttV9gz61jhlTge3ojS2FxC3aS
         o2RDBfMNmr91y4xJSgBUWKSSIDWVxudT6MoPtDQAC7pZAiIINsmIMN/C/5/qm/bYqrYb
         kZrAgxKatCNblVmXF9v2saBwDLq4e2qq6YG19qAo2/ASvpBw8/tFbLtHvOe9+AUENB/C
         M46g==
X-Gm-Message-State: AFqh2kppUU1Vqp9B6Wv+vpzglVCN6GhO37/9HEM/MB8sOhkOSL5++75E
        aX/+mkvOXfy/Ksb513dfjvrt1twO0OBbJllC3ddLX8srN6ei5yGwyGY2vczWowYAbMrMGnzJ1Pn
        iyzR/aZM2xJOc/Ietcz6dqEL9izJelQH8cHstIGde2Zn0WBi0XwJiwJ9A92o9URbEfA==
X-Google-Smtp-Source: AMrXdXtbDL72GdrP6ZgJlUO4ARvocrdpKeO19Zty4AmZnOfCtZHSBezcepWwfwl4a9SekGDLGA42cKZFourSjRY=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:f314:b0:192:f1fc:e8b8 with SMTP
 id c20-20020a170902f31400b00192f1fce8b8mr279004ple.37.1672869290989; Wed, 04
 Jan 2023 13:54:50 -0800 (PST)
Date:   Wed,  4 Jan 2023 21:54:15 +0000
In-Reply-To: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20221108184200.2813458-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20230104215415.1083526-7-calvinwan@google.com>
Subject: [PATCH v5 6/6] submodule: call parallel code from serial status
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
 submodule.c | 143 ++++++++++++++++++----------------------------------
 1 file changed, 48 insertions(+), 95 deletions(-)

diff --git a/submodule.c b/submodule.c
index a0ca646d9b..042e26137f 100644
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
@@ -1936,66 +1897,58 @@ static void parse_status_porcelain_strbuf(struct strbuf *buf,
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
+	struct submodule_status_util util = {
+		.dirty_submodule = 0,
+		.ignore_untracked = ignore_untracked,
+		.path = path,
+	};
+	struct string_list sub = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
 
-	strbuf_release(&buf);
-	return dirty_submodule;
+	item = string_list_append(&sub, path);
+	item->util = &util;
+	if (get_submodules_status(&sub, 1))
+		die(_("submodule status failed"));
+	return util.dirty_submodule;
 }
 
 static struct status_task *
@@ -2096,9 +2049,9 @@ static int status_finish(int retvalue, struct strbuf *err,
 		    task->path);
 	}
 
-	parse_status_porcelain_strbuf(&task->out,
-			      &util->dirty_submodule,
-			      util->ignore_untracked);
+	parse_status_porcelain(&task->out,
+			       &util->dirty_submodule,
+			       util->ignore_untracked);
 
 	free(task);
 
-- 
2.39.0.314.g84b9a713c41-goog

