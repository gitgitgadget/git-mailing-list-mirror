Return-Path: <SRS0=ZaJ6=7X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A1EC433E1
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BC692074B
	for <git@archiver.kernel.org>; Wed, 10 Jun 2020 20:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eeEVpeJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgFJU5k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Jun 2020 16:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgFJU5h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jun 2020 16:57:37 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19622C03E96B
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:35 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id 59so2824058qvb.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2020 13:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Y8gRH2lltkFpOVffTabrMfsJCTsHK1b368s9swmXu+o=;
        b=eeEVpeJZWirUZQnJTftS+PearnzfaVVmOBJG34AikxGv27X/0RckyH8+/0ELdkjPP2
         vEzYaUtPIqLHvymP/4I7dFVivafJ0aXps+TH+Gst/OnbUKaH0twB0D69wu/aZbhZZXDx
         AcabJbrKDpaa2HAl+ZqEButwVKb7hNHKajfqs+WU2ewRH1IXggKLIcgxwG0Gk1egeCFm
         y+C2MC5lbS1CQI3KWkLnLqk0jZt16RIoMBFoQhoy9aY22UWt5yQadKwfOhkknOEZPLwY
         yewFrXAvv5iUjT0qUUp1hxWZXaoQgzpxMS2TopkF31gzkDD3Yb5c8T8Q9f/mWa5bTTXN
         rE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Y8gRH2lltkFpOVffTabrMfsJCTsHK1b368s9swmXu+o=;
        b=Zt79OOdPpUkwriucDMeoE11nlHuI4tu6JrnuWON8v6A7aMfHfu4TDXBHi5mrr7trpU
         0cQJ4Cnif17d8VTNtjERpCsBbvq/1PIC88xnnEhd2/mu7S6tudGRKq9CQnj3Q86k5QBo
         Nz52cTDfjqRvDtdCXh3ZXnnubI4720bfQbfPObmhFXaXK5HaAZVzSax3Mu6TgMsTQ17G
         vj6lxshuQDfSryU/f4kkODzn/ZkVETl5zBThVlkZrhjP3xj2OrBzsgaxIjax7OQfojSR
         Hrskdbfgw0Fx6XAjbyToyzvuz8u+vjq19XtBz6cfo6nWogVWNtfjuOHAoclUeEWFQHau
         aQ6Q==
X-Gm-Message-State: AOAM530EgAPMZXXloSuRnSM8P3jXza+52cqdaELLih0yBDm6TNREaUwl
        GiujU5+zIVhk6+e4bQkMajv35zJ/RI6m73RRahOdfNsC/jgvy8adNIR2aFUzhWa7mkZkhHa1+iT
        a+5ZS35NLQ/hxdl4bdZiz2mtdfbyNoljCXBxZycUSarHl0ZWNAWtanA462xBRa8bFHZq9lgw3oa
        pM
X-Google-Smtp-Source: ABdhPJwIxinAaVbtpU/cZUw3P+g/ETdaNOlRij9MnDDBPOaq58cZYSsHfLII8davniEp1L9qMR8nmXuJCXuQYmk71IDo
X-Received: by 2002:a0c:90e3:: with SMTP id p90mr4714509qvp.24.1591822654190;
 Wed, 10 Jun 2020 13:57:34 -0700 (PDT)
Date:   Wed, 10 Jun 2020 13:57:18 -0700
In-Reply-To: <cover.1591821067.git.jonathantanmy@google.com>
Message-Id: <a4a7ed512b251fb16f0b2400fac8c0c5cc14aa75.1591821067.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1590789428.git.jonathantanmy@google.com> <cover.1591821067.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v2 4/9] http-fetch: support fetching packfiles by URL
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach http-fetch the ability to download packfiles directly, given a
URL, and to verify them.

The http_pack_request suite has been augmented with a function that
takes a URL directly. With this function, the hash is only used to
determine the name of the temporary file.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Documentation/git-http-fetch.txt |  9 ++++-
 http-fetch.c                     | 63 +++++++++++++++++++++++++++-----
 http.c                           | 28 ++++++++++----
 http.h                           | 11 ++++++
 t/t5550-http-fetch-dumb.sh       | 30 +++++++++++++++
 5 files changed, 123 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 666b042679..4deb4893f5 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -9,7 +9,7 @@ git-http-fetch - Download from a remote Git repository via HTTP
 SYNOPSIS
 --------
 [verse]
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin] <commit> <url>
+'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin | --packfile=<hash> | <commit>] <url>
 
 DESCRIPTION
 -----------
@@ -40,6 +40,13 @@ commit-id::
 
 		<commit-id>['\t'<filename-as-in--w>]
 
+--packfile=<hash>::
+	Instead of a commit id on the command line (which is not expected in
+	this case), 'git http-fetch' fetches the packfile directly at the given
+	URL and uses index-pack to generate corresponding .idx and .keep files.
+	The hash is used to determine the name of the temporary file and is
+	arbitrary. The output of index-pack is printed to stdout.
+
 --recover::
 	Verify that everything reachable from target is fetched.  Used after
 	an earlier fetch is interrupted.
diff --git a/http-fetch.c b/http-fetch.c
index e538174bde..1df376e745 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -5,7 +5,7 @@
 #include "walker.h"
 
 static const char http_fetch_usage[] = "git http-fetch "
-"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin] commit-id url";
+"[-c] [-t] [-a] [-v] [--recover] [-w ref] [--stdin | --packfile=hash | commit-id] url";
 
 static int fetch_using_walker(const char *raw_url, int get_verbosely,
 			      int get_recover, int commits, char **commit_id,
@@ -43,6 +43,37 @@ static int fetch_using_walker(const char *raw_url, int get_verbosely,
 	return rc;
 }
 
+static void fetch_single_packfile(struct object_id *packfile_hash,
+				  const char *url) {
+	struct http_pack_request *preq;
+	struct slot_results results;
+	int ret;
+
+	http_init(NULL, url, 0);
+
+	preq = new_direct_http_pack_request(packfile_hash->hash, xstrdup(url));
+	if (preq == NULL)
+		die("couldn't create http pack request");
+	preq->slot->results = &results;
+	preq->generate_keep = 1;
+
+	if (start_active_slot(preq->slot)) {
+		run_active_slot(preq->slot);
+		if (results.curl_result != CURLE_OK) {
+			die("Unable to get pack file %s\n%s", preq->url,
+			    curl_errorstr);
+		}
+	} else {
+		die("Unable to start request");
+	}
+
+	if ((ret = finish_http_pack_request(preq)))
+		die("finish_http_pack_request gave result %d", ret);
+
+	release_http_pack_request(preq);
+	http_cleanup();
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	int commits_on_stdin = 0;
@@ -52,8 +83,12 @@ int cmd_main(int argc, const char **argv)
 	int arg = 1;
 	int get_verbosely = 0;
 	int get_recover = 0;
+	int packfile = 0;
+	struct object_id packfile_hash;
 
 	while (arg < argc && argv[arg][0] == '-') {
+		const char *p;
+
 		if (argv[arg][1] == 't') {
 		} else if (argv[arg][1] == 'c') {
 		} else if (argv[arg][1] == 'a') {
@@ -68,25 +103,33 @@ int cmd_main(int argc, const char **argv)
 			get_recover = 1;
 		} else if (!strcmp(argv[arg], "--stdin")) {
 			commits_on_stdin = 1;
+		} else if (skip_prefix(argv[arg], "--packfile=", &p)) {
+			const char *end;
+
+			packfile = 1;
+			if (parse_oid_hex(p, &packfile_hash, &end) || *end)
+				die(_("argument to --packfile must be a valid hash (got '%s')"), p);
 		}
 		arg++;
 	}
-	if (argc != arg + 2 - commits_on_stdin)
+	if (argc != arg + 2 - (commits_on_stdin || packfile))
 		usage(http_fetch_usage);
-	if (commits_on_stdin) {
-		commits = walker_targets_stdin(&commit_id, &write_ref);
-	} else {
-		commit_id = (char **) &argv[arg++];
-		commits = 1;
-	}
 
 	setup_git_directory();
 
 	git_config(git_default_config, NULL);
 
-	if (!argv[arg])
-		BUG("must have one arg remaining");
+	if (packfile) {
+		fetch_single_packfile(&packfile_hash, argv[arg]);
+		return 0;
+	}
 
+	if (commits_on_stdin) {
+		commits = walker_targets_stdin(&commit_id, &write_ref);
+	} else {
+		commit_id = (char **) &argv[arg++];
+		commits = 1;
+	}
 	return fetch_using_walker(argv[arg], get_verbosely, get_recover,
 				  commits, commit_id, write_ref,
 				  commits_on_stdin);
diff --git a/http.c b/http.c
index 4f6e1fb018..3aa0fa9fe6 100644
--- a/http.c
+++ b/http.c
@@ -2281,7 +2281,13 @@ int finish_http_pack_request(struct http_pack_request *preq)
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
@@ -2307,19 +2313,27 @@ void http_install_packfile(struct packed_git *p,
 }
 
 struct http_pack_request *new_http_pack_request(
-	const unsigned char *packed_git_hash, const char *base_url)
+	const unsigned char *packed_git_hash, const char *base_url) {
+
+	struct strbuf buf = STRBUF_INIT;
+
+	end_url_with_slash(&buf, base_url);
+	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
+		hash_to_hex(packed_git_hash));
+	return new_direct_http_pack_request(packed_git_hash,
+					    strbuf_detach(&buf, NULL));
+}
+
+struct http_pack_request *new_direct_http_pack_request(
+	const unsigned char *packed_git_hash, char *url)
 {
 	off_t prev_posn = 0;
-	struct strbuf buf = STRBUF_INIT;
 	struct http_pack_request *preq;
 
 	preq = xcalloc(1, sizeof(*preq));
 	strbuf_init(&preq->tmpfile, 0);
 
-	end_url_with_slash(&buf, base_url);
-	strbuf_addf(&buf, "objects/pack/pack-%s.pack",
-		hash_to_hex(packed_git_hash));
-	preq->url = strbuf_detach(&buf, NULL);
+	preq->url = url;
 
 	strbuf_addf(&preq->tmpfile, "%s.temp", sha1_pack_name(packed_git_hash));
 	preq->packfile = fopen(preq->tmpfile.buf, "a");
diff --git a/http.h b/http.h
index bbc6b070f1..dc49c60165 100644
--- a/http.h
+++ b/http.h
@@ -216,6 +216,15 @@ int http_get_info_packs(const char *base_url,
 
 struct http_pack_request {
 	char *url;
+
+	/*
+	 * If this is true, finish_http_pack_request() will pass "--keep" to
+	 * index-pack, resulting in the creation of a keep file, and will not
+	 * suppress its stdout (that is, the "keep\t<hash>\n" line will be
+	 * printed to stdout).
+	 */
+	unsigned generate_keep : 1;
+
 	FILE *packfile;
 	struct strbuf tmpfile;
 	struct active_request_slot *slot;
@@ -223,6 +232,8 @@ struct http_pack_request {
 
 struct http_pack_request *new_http_pack_request(
 	const unsigned char *packed_git_hash, const char *base_url);
+struct http_pack_request *new_direct_http_pack_request(
+	const unsigned char *packed_git_hash, char *url);
 int finish_http_pack_request(struct http_pack_request *preq);
 void release_http_pack_request(struct http_pack_request *preq);
 
diff --git a/t/t5550-http-fetch-dumb.sh b/t/t5550-http-fetch-dumb.sh
index 50485300eb..ca2e8af022 100755
--- a/t/t5550-http-fetch-dumb.sh
+++ b/t/t5550-http-fetch-dumb.sh
@@ -199,6 +199,28 @@ test_expect_success 'fetch packed objects' '
 	git clone $HTTPD_URL/dumb/repo_pack.git
 '
 
+test_expect_success 'http-fetch --packfile' '
+	# Arbitrary hash. Use rev-parse so that we get one of the correct
+	# length.
+	ARBITRARY=$(git -C "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git rev-parse HEAD) &&
+
+	git init packfileclient &&
+	p=$(cd "$HTTPD_DOCUMENT_ROOT_PATH"/repo_pack.git && ls objects/pack/pack-*.pack) &&
+	git -C packfileclient http-fetch --packfile=$ARBITRARY "$HTTPD_URL"/dumb/repo_pack.git/$p >out &&
+
+	grep "^keep.[0-9a-f]\{16,\}$" out &&
+	cut -c6- out >packhash &&
+
+	# Ensure that the expected files are generated
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
@@ -214,6 +236,14 @@ test_expect_success 'fetch notices corrupt pack' '
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
2.27.0.278.ge193c7cf3a9-goog

