Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDE9C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21EA0613B9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 21:34:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbhFAVgQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 17:36:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbhFAVgO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 17:36:14 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F98DC061756
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 14:34:30 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id br4-20020ad446a40000b029021addf7b587so253539qvb.10
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tt7FKKmCPCKna0aqu5Qfr4MUTHQRmkJubAB3nfPhsLs=;
        b=dQtG1Pyu/W7BoQbnSsUqxO/g4P614D0blaNg1aK3yej37i8SBF/ymWC3T2g/yp+qgk
         okz+7ANcV12aP5E55G3RV/ejW4lQiiTDMNG7MmIPhTvZ/5Y+qc60LP5d5qYL76YXHXkp
         F1bqK1dLMHCiuAcybVOmG8OyMUY6M+KNvzHN4VQcRnIdtqJ/dPhHbMT1JbGEhV8pFWmJ
         xRYHSP3AtOLLBtEAU257t6YBNL/pnTeTjwd+xT0T1RezPoWQp3WPBjaDfbBZQvVM4W1h
         655Cb7twGqcoQJfoVke/UbY76FkdDGBd6mdFjRzhRGZIUdvS3aSG3DbrXAaKP9bpI24F
         NS5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tt7FKKmCPCKna0aqu5Qfr4MUTHQRmkJubAB3nfPhsLs=;
        b=nOqBtUgSM7xGM81NU+6SHtxNBLPiw0NBJo7mfEGnRNpJvB05YAcGGqoAZ2SvjPuaL/
         HTulc095SwMFFDd1hUasWaBFBiTXH9Jzxz/tdbVny5+F08bX8DfCLD/7pZh/yHsdRNak
         J0xQEVwTnCbfRSPgNuZhGaHhTknlvk2p8OMRDkiItAcRxCzvjhulPQdah/fJZffnm0ln
         c26Nb857ti0+Dd77kahkoOdLY/NS8kujpgNwza3YSvEfcynqHoQTfsuNrYhRXjNLRFVJ
         tyyk8AkcYcL9Cb+5Cf+k0nz4TClO0WTKgkfEtwZR8JIgWnIZ8x2Rw2MVnkPH6HNPHGd/
         4oaw==
X-Gm-Message-State: AOAM530sqQJIas0xJCFbsxOf6lUyqzDiejzYMdSL14pIHEF8060A5ihH
        MS7u9UoP9rApzi4xKVUeNEl79sfYxda5e5IWygSsgnNBMM+iPh7xPfAywxN01L1esL6PjReBMkB
        4p3W/WqAndezOuuWR7J2ppFBOPPYxakFYXtixCay57CPIYJHN+/D6xOkLqkEg3TScWlUhMFQNEw
        D9
X-Google-Smtp-Source: ABdhPJwZUOuGyD2+ypkpgyy39j8Lu0ah/7fToQrn3R6DSYB6ybGKeOMen63AtfX6RZRR9FaO/tWpigojcuif3GrlGqEh
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:d790:: with SMTP id
 z16mr24823045qvi.20.1622583269590; Tue, 01 Jun 2021 14:34:29 -0700 (PDT)
Date:   Tue,  1 Jun 2021 14:34:19 -0700
In-Reply-To: <cover.1622580781.git.jonathantanmy@google.com>
Message-Id: <b70a00b9b06e5142bb95891cfc2faa87d708ef0d.1622580781.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
Subject: [PATCH 4/4] promisor-remote: teach lazy-fetch in any repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is one step towards supporting partial clone submodules.

Even after this patch, we will still lack partial clone submodules
support, primarily because a lot of Git code that accesses submodule
objects does so by adding their object stores as alternates, meaning
that any lazy fetches that would occur in the submodule would be done
based on the config of the superproject, not of the submodule. This also
prevents testing of the functionality in this patch by user-facing
commands. So for now, test this mechanism using a test helper.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile                      |  1 +
 object-file.c                 |  7 ++-----
 promisor-remote.c             | 14 +++++++++-----
 t/helper/test-partial-clone.c | 34 ++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c          |  1 +
 t/helper/test-tool.h          |  1 +
 t/t0410-partial-clone.sh      | 24 ++++++++++++++++++++++++
 7 files changed, 72 insertions(+), 10 deletions(-)
 create mode 100644 t/helper/test-partial-clone.c

diff --git a/Makefile b/Makefile
index c3565fc0f8..f6653bcd5e 100644
--- a/Makefile
+++ b/Makefile
@@ -725,6 +725,7 @@ TEST_BUILTINS_OBJS += test-oidmap.o
 TEST_BUILTINS_OBJS += test-online-cpus.o
 TEST_BUILTINS_OBJS += test-parse-options.o
 TEST_BUILTINS_OBJS += test-parse-pathspec-file.o
+TEST_BUILTINS_OBJS += test-partial-clone.o
 TEST_BUILTINS_OBJS += test-path-utils.o
 TEST_BUILTINS_OBJS += test-pcre2-config.o
 TEST_BUILTINS_OBJS += test-pkt-line.o
diff --git a/object-file.c b/object-file.c
index f233b440b2..ebf273e9e7 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1570,15 +1570,12 @@ static int do_oid_object_info_extended(struct repository *r,
 		}
 
 		/* Check if it is a missing object */
-		if (fetch_if_missing && has_promisor_remote() &&
-		    !already_retried && r == the_repository &&
+		if (fetch_if_missing && repo_has_promisor_remote(r) &&
+		    !already_retried &&
 		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
 			/*
 			 * TODO Investigate checking promisor_remote_get_direct()
 			 * TODO return value and stopping on error here.
-			 * TODO Pass a repository struct through
-			 * promisor_remote_get_direct(), such that arbitrary
-			 * repositories work.
 			 */
 			promisor_remote_get_direct(r, real, 1);
 			already_retried = 1;
diff --git a/promisor-remote.c b/promisor-remote.c
index 5819d2cf28..1601f05d79 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -11,7 +11,8 @@ struct promisor_remote_config {
 	struct promisor_remote **promisors_tail;
 };
 
-static int fetch_objects(const char *remote_name,
+static int fetch_objects(struct repository *repo,
+			 const char *remote_name,
 			 const struct object_id *oids,
 			 int oid_nr)
 {
@@ -21,6 +22,11 @@ static int fetch_objects(const char *remote_name,
 
 	child.git_cmd = 1;
 	child.in = -1;
+	if (repo != the_repository) {
+		prepare_other_repo_env(&child.env_array);
+		strvec_pushf(&child.env_array, "%s=%s", GIT_DIR_ENVIRONMENT,
+			     repo->gitdir);
+	}
 	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
@@ -150,7 +156,7 @@ static void promisor_remote_init(struct repository *r)
 		xcalloc(sizeof(*r->promisor_remote_config), 1);
 	config->promisors_tail = &config->promisors;
 
-	git_config(promisor_remote_config, config);
+	repo_config(r, promisor_remote_config, config);
 
 	if (config->repository_format_partial_clone) {
 		struct promisor_remote *o, *previous;
@@ -246,10 +252,8 @@ int promisor_remote_get_direct(struct repository *repo,
 
 	promisor_remote_init(repo);
 
-	if (repo != the_repository)
-		BUG("only the_repository is supported for now");
 	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
-		if (fetch_objects(r->name, remaining_oids, remaining_nr) < 0) {
+		if (fetch_objects(repo, r->name, remaining_oids, remaining_nr) < 0) {
 			if (remaining_nr == 1)
 				continue;
 			remaining_nr = remove_fetched_oids(repo, &remaining_oids,
diff --git a/t/helper/test-partial-clone.c b/t/helper/test-partial-clone.c
new file mode 100644
index 0000000000..e7bc7eb21f
--- /dev/null
+++ b/t/helper/test-partial-clone.c
@@ -0,0 +1,34 @@
+#include "cache.h"
+#include "test-tool.h"
+#include "repository.h"
+#include "object-store.h"
+
+static void object_info(const char *gitdir, const char *oid_hex)
+{
+	struct repository r;
+	struct object_id oid;
+	unsigned long size;
+	struct object_info oi = {.sizep = &size};
+	const char *p;
+
+	if (repo_init(&r, gitdir, NULL))
+		die("could not init repo");
+	if (parse_oid_hex(oid_hex, &oid, &p))
+		die("could not parse oid");
+	if (oid_object_info_extended(&r, &oid, &oi, 0))
+		die("could not obtain object info");
+	printf("%d\n", (int) size);
+}
+
+int cmd__partial_clone(int argc, const char **argv)
+{
+	if (argc < 4)
+		die("too few arguments");
+
+	if (!strcmp(argv[1], "object-info"))
+		object_info(argv[2], argv[3]);
+	else
+		die("invalid argument '%s'", argv[1]);
+
+	return 0;
+}
diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
index c5bd0c6d4c..b21e8f1519 100644
--- a/t/helper/test-tool.c
+++ b/t/helper/test-tool.c
@@ -46,6 +46,7 @@ static struct test_cmd cmds[] = {
 	{ "online-cpus", cmd__online_cpus },
 	{ "parse-options", cmd__parse_options },
 	{ "parse-pathspec-file", cmd__parse_pathspec_file },
+	{ "partial-clone", cmd__partial_clone },
 	{ "path-utils", cmd__path_utils },
 	{ "pcre2-config", cmd__pcre2_config },
 	{ "pkt-line", cmd__pkt_line },
diff --git a/t/helper/test-tool.h b/t/helper/test-tool.h
index e8069a3b22..f845ced4b3 100644
--- a/t/helper/test-tool.h
+++ b/t/helper/test-tool.h
@@ -35,6 +35,7 @@ int cmd__oidmap(int argc, const char **argv);
 int cmd__online_cpus(int argc, const char **argv);
 int cmd__parse_options(int argc, const char **argv);
 int cmd__parse_pathspec_file(int argc, const char** argv);
+int cmd__partial_clone(int argc, const char **argv);
 int cmd__path_utils(int argc, const char **argv);
 int cmd__pcre2_config(int argc, const char **argv);
 int cmd__pkt_line(int argc, const char **argv);
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 584a039b85..e804d267e6 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -604,6 +604,30 @@ test_expect_success 'do not fetch when checking existence of tree we construct o
 	git -C repo cherry-pick side1
 '
 
+test_expect_success 'lazy-fetch when accessing object not in the_repository' '
+	rm -rf full partial.git &&
+	test_create_repo full &&
+	printf 12345 >full/file.txt &&
+	git -C full add file.txt &&
+	git -C full commit -m "first commit" &&
+
+	test_config -C full uploadpack.allowfilter 1 &&
+	test_config -C full uploadpack.allowanysha1inwant 1 &&
+	git clone --filter=blob:none --bare "file://$(pwd)/full" partial.git &&
+	FILE_HASH=$(git hash-object --stdin <full/file.txt) &&
+
+	# Sanity check that the file is missing
+	git -C partial.git rev-list --objects --missing=print HEAD >out &&
+	grep "[?]$FILE_HASH" out &&
+
+	OUT=$(test-tool partial-clone object-info partial.git "$FILE_HASH") &&
+	test "$OUT" -eq 5 &&
+
+	# Sanity check that the file is now present
+	git -C partial.git rev-list --objects --missing=print HEAD >out &&
+	! grep "[?]$FILE_HASH" out
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.32.0.rc0.204.g9fa02ecfa5-goog

