Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B39320248
	for <e@80x24.org>; Fri,  8 Mar 2019 21:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbfCHVzp (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Mar 2019 16:55:45 -0500
Received: from mail-qt1-f201.google.com ([209.85.160.201]:36257 "EHLO
        mail-qt1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbfCHVzo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Mar 2019 16:55:44 -0500
Received: by mail-qt1-f201.google.com with SMTP id p5so20062885qtp.3
        for <git@vger.kernel.org>; Fri, 08 Mar 2019 13:55:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7hf/jccunXFQPYR8hPqt7wb9FpCZ2kN06SvU1xLvP6E=;
        b=Sx+gjT9iB/C2nPOa+wxLFcJv0kqUf3g5fNypZMo5+DI1VH3acMH4KWJJRdNAgyVUut
         VjbElpXte5jxt9EZTRf+JTs2fnbZi/ttDQZc/yRi6lOJDfe790Pc+9XKUXs88FeVAr7f
         N51tHfDqgcRtqVhPaJjYlFKLN5rbtWAz8iYYXJMATQbDN8nK/hKolcF42qP/DawcBn/A
         hfbeDGoUa9DX3eBIyCTCbl//+Rkhimjm0rOxhglIgzYfGaNnGs/N9BwITvV02+TFyhE6
         HrJH8lxuP8xTWyNNSmz57IMjQt2GO7qAhaURK+AFK0JnDCrcqDR7BXJPgpz24gPYtzMN
         XFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7hf/jccunXFQPYR8hPqt7wb9FpCZ2kN06SvU1xLvP6E=;
        b=PCdpwJ0vaMUhkjbPcSsCYl1dUtvMKlbtNK85ZWSfs9Sh0iHKUcQCaxMeji1TMJDEYu
         Lr6ALnewQSkJthFbnOJQt91/LlwgPmI8b0kgnZTR0+hBYwbsjEv2pSpxQqqBauUG+c4v
         q3kuH9pdDKF/YPIQB0nWmYAZu7/Vj9jrmhk5McSBXpPL8Cgkwir9JpbnTe+VH89tqOx/
         wNviVqUgAUSiHQ2VGEAMyLZVzJxdQWjgILCr7n7MM4Vv9NsTj0mRQsB/mIrgEDDqA3bd
         RWGMhnvkv5Ijyr+hnkI04ajUjkedXhaFhSJCZNKVRnj8f/qFwOaISCmS76vzY+cGQFCU
         Acbg==
X-Gm-Message-State: APjAAAURroox3pMrqMpXLYTumwqWBeOD4RotqByZqDKOQ9bpcgL1zTiC
        MK8miMU7c32PCyQHMme3PtKaAtxCbS0ijmiDKwLu
X-Google-Smtp-Source: APXvYqwQpFXIBGpBUcNrUFCgCeoyeLCGLEcKlSs/Bcwa7QFAzKZY2sPVhVuVMpO08ZIqR8GR7ouMuHzsQRpHme/XCKg8
X-Received: by 2002:ac8:2539:: with SMTP id 54mr11287052qtm.45.1552082142921;
 Fri, 08 Mar 2019 13:55:42 -0800 (PST)
Date:   Fri,  8 Mar 2019 13:55:15 -0800
In-Reply-To: <cover.1552073690.git.jonathantanmy@google.com>
Message-Id: <02373f6afe0c3c93728ff2be21dc26de9b82e0d1.1552073690.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1550963965.git.jonathantanmy@google.com> <cover.1552073690.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: [PATCH v2 3/8] http-fetch: support fetching packfiles by URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     avarab@gmail.com, git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach http-fetch the ability to download packfiles directly, given a
URL, and to verify them.

The http_pack_request suite of functions have been modified to support a
NULL target. When target is NULL, the given URL is downloaded directly
instead of being treated as the root of a repository.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-http-fetch.txt |  8 +++-
 http-fetch.c                     | 64 +++++++++++++++++++++++++-------
 http.c                           | 49 +++++++++++++++++-------
 http.h                           | 19 ++++++++--
 t/t5550-http-fetch-dumb.sh       | 25 +++++++++++++
 5 files changed, 135 insertions(+), 30 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 666b042679..8357359a9b 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -9,7 +9,7 @@ git-http-fetch - Download from a remote Git repository via HTTP
 SYNOPSIS
 --------
 [verse]
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
+'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin | --packfile | <commit>] <url>
 
 DESCRIPTION
 -----------
@@ -40,6 +40,12 @@ commit-id::
 
 		<commit-id>['\t'<filename-as-in--w>]
 
+--packfile::
+	Instead of a commit id on the command line (which is not expected in
+	this case), 'git http-fetch' fetches the packfile directly at the given
+	URL and uses index-pack to generate corresponding .idx and .keep files.
+	The output of index-pack is printed to stdout.
+
 --recover::
 	Verify that everything reachable from target is fetched.  Used after
 	an earlier fetch is interrupted.
diff --git a/http-fetch.c b/http-fetch.c
index a32ac118d9..a9764d6f96 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -5,7 +5,7 @@
 #include "walker.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
-"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
+"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile | commit-id] url";
 
 int cmd_main(int argc, const char **argv)
 {
@@ -19,6 +19,7 @@ int cmd_main(int argc, const char **argv)
 	int rc = 0;
 	int get_verbosely = 0;
 	int get_recover = 0;
+	int packfile = 0;
 
 	while (arg < argc && argv[arg][0] == '-') {
 		if (argv[arg][1] == 't') {
@@ -35,43 +36,80 @@ int cmd_main(int argc, const char **argv)
 			get_recover = 1;
 		} else if (!strcmp(argv[arg], "--stdin")) {
 			commits_on_stdin = 1;
+		} else if (!strcmp(argv[arg], "--packfile")) {
+			packfile = 1;
 		}
 		arg++;
 	}
-	if (argc != arg + 2 - commits_on_stdin)
+	if (argc != arg + 2 - (commits_on_stdin || packfile))
 		usage(http_fetch_usage);
 	if (commits_on_stdin) {
 		commits = walker_targets_stdin(&commit_id, &write_ref);
+	} else if (packfile) {
+		/* URL will be set later */
 	} else {
 		commit_id = (char **) &argv[arg++];
 		commits = 1;
 	}
 
-	if (argv[arg])
-		str_end_url_with_slash(argv[arg], &url);
+	if (packfile) {
+		url = xstrdup(argv[arg]);
+	} else {
+		if (argv[arg])
+			str_end_url_with_slash(argv[arg], &url);
+	}
 
 	setup_git_directory();
 
 	git_config(git_default_config, NULL);
 
 	http_init(NULL, url, 0);
-	walker = get_http_walker(url);
-	walker->get_verbosely = get_verbosely;
-	walker->get_recover = get_recover;
 
-	rc = walker_fetch(walker, commits, commit_id, write_ref, url);
+	if (packfile) {
+		struct http_pack_request *preq;
+		struct slot_results results;
+		int ret;
+
+		preq = new_http_pack_request(NULL, url);
+		if (preq == NULL)
+			die("couldn't create http pack request");
+		preq->slot->results = &results;
+		preq->generate_keep = 1;
+
+		if (start_active_slot(preq->slot)) {
+			run_active_slot(preq->slot);
+			if (results.curl_result != CURLE_OK) {
+				die("Unable to get pack file %s\n%s", preq->url,
+				    curl_errorstr);
+			}
+		} else {
+			die("Unable to start request");
+		}
+
+		if ((ret = finish_http_pack_request(preq)))
+			die("finish_http_pack_request gave result %d", ret);
+		release_http_pack_request(preq);
+		rc = 0;
+	} else {
+		walker = get_http_walker(url);
+		walker->get_verbosely = get_verbosely;
+		walker->get_recover = get_recover;
+
+		rc = walker_fetch(walker, commits, commit_id, write_ref, url);
 
-	if (commits_on_stdin)
-		walker_targets_free(commits, commit_id, write_ref);
+		if (commits_on_stdin)
+			walker_targets_free(commits, commit_id, write_ref);
 
-	if (walker->corrupt_object_found) {
-		fprintf(stderr,
+		if (walker->corrupt_object_found) {
+			fprintf(stderr,
 "Some loose object were found to be corrupt, but they might be just\n"
 "a false '404 Not Found' error message sent with incorrect HTTP\n"
 "status code.  Suggest running 'git fsck'.\n");
+		}
+
+		walker_free(walker);
 	}
 
-	walker_free(walker);
 	http_cleanup();
 
 	free(url);
diff --git a/http.c b/http.c
index 34f82af87c..b372e61520 100644
--- a/http.c
+++ b/http.c
@@ -2208,15 +2208,18 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	int tmpfile_fd;
 	int ret = 0;
 
-	close_pack_index(p);
+	if (p)
+		close_pack_index(p);
 
 	fclose(preq->packfile);
 	preq->packfile = NULL;
 
-	lst = preq->lst;
-	while (*lst != p)
-		lst = &((*lst)->next);
-	*lst = (*lst)->next;
+	if (p) {
+		lst = preq->lst;
+		while (*lst != p)
+			lst = &((*lst)->next);
+		*lst = (*lst)->next;
+	}
 
 	tmpfile_fd = xopen(preq->tmpfile.buf, O_RDONLY);
 
@@ -2224,14 +2227,21 @@ int finish_http_pack_request(struct http_pack_request *preq)
 	argv_array_push(&ip.args, "--stdin");
 	ip.git_cmd = 1;
 	ip.in = tmpfile_fd;
-	ip.no_stdout = 1;
+	if (preq->generate_keep) {
+		argv_array_pushf(&ip.args, "--keep=git %"PRIuMAX,
+				 (uintmax_t)getpid());
+		ip.out = 0;
+	} else {
+		ip.no_stdout = 1;
+	}
 
 	if (run_command(&ip)) {
 		ret = -1;
 		goto cleanup;
 	}
 
-	install_packed_git(the_repository, p);
+	if (p)
+		install_packed_git(the_repository, p);
 cleanup:
 	close(tmpfile_fd);
 	unlink(preq->tmpfile.buf);
@@ -2249,12 +2259,24 @@ struct http_pack_request *new_http_pack_request(
 	strbuf_init(&preq->tmpfile, 0);
 	preq->target = target;
 
-	end_url_with_slash(&buf, base_url);
-	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
-		sha1_to_hex(target->sha1));
-	preq->url = strbuf_detach(&buf, NULL);
+	if (target) {
+		end_url_with_slash(&buf, base_url);
+		strbuf_addf(&buf, "objects/pack/pack-%s.pack",
+			sha1_to_hex(target->sha1));
+		preq->url = strbuf_detach(&buf, NULL);
+	} else {
+		preq->url = xstrdup(base_url);
+	}
+
+	if (target) {
+		strbuf_addf(&preq->tmpfile, "%s.temp",
+			    sha1_pack_name(target->sha1));
+	} else {
+		strbuf_addf(&preq->tmpfile, "%s/pack/pack-", get_object_directory());
+		strbuf_addstr_urlencode(&preq->tmpfile, base_url, 1);
+		strbuf_addstr(&preq->tmpfile, ".temp");
+	}
 
-	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(target->sha1));
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
 	if (!preq->packfile) {
 		error("Unable to open local file %s for pack",
@@ -2278,7 +2300,8 @@ struct http_pack_request *new_http_pack_request(
 		if (http_is_verbose)
 			fprintf(stderr,
 				"Resuming fetch of pack %s at byte %"PRIuMAX"\n",
-				sha1_to_hex(target->sha1), (uintmax_t)prev_posn);
+				target ? sha1_to_hex(target->sha1) : base_url,
+				(uintmax_t)prev_posn);
 		http_opt_request_remainder(preq->slot->curl, prev_posn);
 	}
 
diff --git a/http.h b/http.h
index ded1edcca4..8f63c76e09 100644
--- a/http.h
+++ b/http.h
@@ -210,12 +210,21 @@ struct http_pack_request {
 	struct active_request_slot *slot;
 
 	/*
-	 * After calling new_http_pack_request(), point lst to the head of the
+	 * After calling new_http_pack_request(), if fetching a pack that
+	 * http_get_info_packs() told us about, point lst to the head of the
 	 * pack list that target is in. finish_http_pack_request() will remove
 	 * target from lst and call install_packed_git() on target.
 	 */
 	struct packed_git **lst;
 
+	/*
+	 * If this is true, finish_http_pack_request() will pass "--keep" to
+	 * index-pack, resulting in the creation of a keep file, and will not
+	 * suppress its stdout (that is, the "keep\t<hash>\n" line will be
+	 * printed to stdout).
+	 */
+	unsigned generate_keep : 1;
+
 	/*
 	 * State managed by functions in http.c.
 	 */
@@ -224,8 +233,12 @@ struct http_pack_request {
 };
 
 /*
- * target must be an element in a pack list obtained from
- * http_get_info_packs().
+ * If fetching a pack that http_get_info_packs() told us about, set target to
+ * an element in a pack list obtained from http_get_info_packs(). The actual
+ * URL fetched will be base_url followed by a suffix with the hash of the pack.
+ *
+ * Otherwise, set target to NULL. The actual URL fetched will be base_url
+ * itself.
  */
 extern struct http_pack_request *new_http_pack_request(
 	struct packed_git *target, const char *base_url);
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 6d7d88ccc9..84235fd6d4 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -199,6 +199,23 @@ test_expect_success 'fetch packed objects' '
 	git clone $HTTPD_URL/dumb/repo_pack.git
 '
 
+test_expect_success 'http-fetch --packfile' '
+	git init packfileclient &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git && ls objects/pack/pack-*.pack) &&
+	git -C packfileclient http-fetch --packfile "$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
+
+	# Ensure that the expected files are generated
+	grep "^keep.[0-9a-f]\{16,\}$" out &&
+	cut -c6- out >packhash &&
+	test -e "packfileclient/.git/objects/pack/pack-$(cat packhash).pack" &&
+	test -e "packfileclient/.git/objects/pack/pack-$(cat packhash).idx" &&
+	test -e "packfileclient/.git/objects/pack/pack-$(cat packhash).keep" &&
+
+	# Ensure that it has the HEAD of repo_pack, at least
+	HASH=$(git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git rev-parse HEAD) &&
+	git -C packfileclient cat-file -e "$HASH"
+'
+
 test_expect_success 'fetch notices corrupt pack' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
@@ -214,6 +231,14 @@ test_expect_success 'fetch notices corrupt pack' '
 	)
 '
 
+test_expect_success 'http-fetch --packfile with corrupt pack' '
+	rm -rf packfileclient &&
+	git init packfileclient &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad1.git && ls objects/pack/pack-*.pack) &&
+	test_must_fail git -C packfileclient http-fetch --packfile \
+		"$HTTPD_URL"/dumb/repo_bad1.git/$p
+'
+
 test_expect_success 'fetch notices corrupt idx' '
 	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
 	(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
-- 
2.19.0.271.gfe8321ec05.dirty

