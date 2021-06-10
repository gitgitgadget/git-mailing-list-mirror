Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64028C47094
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40C6F613D0
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 17:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhFJRiH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 13:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhFJRiA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 13:38:00 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86D43C061574
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 10:35:55 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id u7-20020a6345470000b02902211e79e4c1so252734pgk.18
        for <git@vger.kernel.org>; Thu, 10 Jun 2021 10:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=kWCum8+R5X7aFiGUltRP+KkPG9xmITm8ctbyykhxCMo=;
        b=EIQl47Rn9KViruvvYvyqUsYhEExUpb+EFAd/hlgm8uU2OgSlMJMIBmKubQpxqEbmdB
         dbLnal9yBreB2cSXFNNh7wIW4BWlA3rd7a5cLK7b7BQ5tCvYA3ggSKx2Nih7+WukGWpy
         T+r/ML3YvvpVBR3I/KwBlq3CL2vfzHbwSVpUqljytmPoZq+Mg7RlluQVjgqcz3LF7sAe
         h3rnSlRvJpU6ZSPQodYlyV13M5ONfRCYJY0+McinYYMhIkMr0LkIm8aMqpLScPDOIdVe
         YTgHtz7kbaoh8Fam1qVCSp3khGDpnd1LRbuLVDa6LKC3nCfusZOKhGyTDLnSDGhLM086
         BIvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=kWCum8+R5X7aFiGUltRP+KkPG9xmITm8ctbyykhxCMo=;
        b=ZHMduorA6J61BLFtGlHbJhoHSG1Dx6ndlQWA4v6D7rZlaveyeLItzPGV57UiAZvQDP
         UWeGLEW9pFFMJ8dfiZoipNz2Jpdc/7opdg3w9j9DHs2zmIDGkcy4vasmBAJdbjaT5TjX
         yZ7IprgqOvOSx1Brzx8XEO2GRHAIVx86zyZEcBLVhEeBThfDSw7IW/V6C9rerS0euHXN
         Na89YUpzsEVSc78DTNsoKZvGioDqL85P1w+tLSNA0OA9DFSr6Mqy3IimK0ZKrnaUfdm4
         p42p8cLM+1V3jLQRx2QHz98EUSriPne3sxAdTmUH50p606FoqI6ev2W7dxO5KWwo0d/h
         0xLQ==
X-Gm-Message-State: AOAM533ZOzjjYDEtNfh1leC2mRSTImRoH0Kp1UhTa3hO06QMAg6qdkLO
        n78nBI7p9qrKND+K5Nya56TpBolm2bdfU63Rp8z6OdDrvfbCh4ZX8IM01rZ+gRR16C0W5HjiLWA
        ItjRo8961Z6Bb6AyaYrmGOqoyX9YE5x9m3/ciCWma5f/9l5/4IG1XafcENj9r1OmVtn6YoO6kZY
        MG
X-Google-Smtp-Source: ABdhPJxqmdk6FHFL61B4F/ldrHvYWemyo5FO+GqihJGXia90NHtj5j+ryTGtIZxS62cmgNYG8Xh/qeTdCXA6NKWNVlsQ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:ce02:: with SMTP id
 f2mr4408899pju.45.1623346554484; Thu, 10 Jun 2021 10:35:54 -0700 (PDT)
Date:   Thu, 10 Jun 2021 10:35:43 -0700
In-Reply-To: <cover.1623345496.git.jonathantanmy@google.com>
Message-Id: <a6d73662b1908e3fcb7243bf30bc128e1c4440c0.1623345496.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1622580781.git.jonathantanmy@google.com> <cover.1623345496.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
Subject: [PATCH v3 5/5] promisor-remote: teach lazy-fetch in any repo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        newren@gmail.com, emilyshaffer@google.com, gitster@pobox.com
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

Besides that, there is some code that uses the wrapper functions
like has_promisor_remote(). Those will need to be checked to see if they
could support the non-wrapper functions instead (and thus support any
repository, not just the_repository).

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 Makefile                      |  1 +
 object-file.c                 |  7 ++----
 promisor-remote.c             |  9 ++++----
 t/helper/test-partial-clone.c | 43 +++++++++++++++++++++++++++++++++++
 t/helper/test-tool.c          |  1 +
 t/helper/test-tool.h          |  1 +
 t/t0410-partial-clone.sh      | 23 +++++++++++++++++++
 7 files changed, 76 insertions(+), 9 deletions(-)
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
index 1e00e16b0f..c088dcbff3 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -10,7 +10,8 @@ struct promisor_remote_config {
 	struct promisor_remote **promisors_tail;
 };
 
-static int fetch_objects(const char *remote_name,
+static int fetch_objects(struct repository *repo,
+			 const char *remote_name,
 			 const struct object_id *oids,
 			 int oid_nr)
 {
@@ -20,6 +21,8 @@ static int fetch_objects(const char *remote_name,
 
 	child.git_cmd = 1;
 	child.in = -1;
+	if (repo != the_repository)
+		prepare_other_repo_env(&child.env_array, repo->gitdir);
 	strvec_pushl(&child.args, "-c", "fetch.negotiationAlgorithm=noop",
 		     "fetch", remote_name, "--no-tags",
 		     "--no-write-fetch-head", "--recurse-submodules=no",
@@ -240,10 +243,8 @@ int promisor_remote_get_direct(struct repository *repo,
 
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
index 0000000000..3f102cfddd
--- /dev/null
+++ b/t/helper/test-partial-clone.c
@@ -0,0 +1,43 @@
+#include "cache.h"
+#include "test-tool.h"
+#include "repository.h"
+#include "object-store.h"
+
+/*
+ * Prints the size of the object corresponding to the given hash in a specific
+ * gitdir. This is similar to "git -C gitdir cat-file -s", except that this
+ * exercises the code that accesses the object of an arbitrary repository that
+ * is not the_repository. ("git -C gitdir" makes it so that the_repository is
+ * the one in gitdir.)
+ */
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
+	setup_git_directory();
+
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
index 584a039b85..a211a66c67 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -604,6 +604,29 @@ test_expect_success 'do not fetch when checking existence of tree we construct o
 	git -C repo cherry-pick side1
 '
 
+test_expect_success 'lazy-fetch when accessing object not in the_repository' '
+	rm -rf full partial.git &&
+	test_create_repo full &&
+	test_commit -C full create-a-file file.txt &&
+
+	test_config -C full uploadpack.allowfilter 1 &&
+	test_config -C full uploadpack.allowanysha1inwant 1 &&
+	git clone --filter=blob:none --bare "file://$(pwd)/full" partial.git &&
+	FILE_HASH=$(git -C full rev-parse HEAD:file.txt) &&
+
+	# Sanity check that the file is missing
+	git -C partial.git rev-list --objects --missing=print HEAD >out &&
+	grep "[?]$FILE_HASH" out &&
+
+	git -C full cat-file -s "$FILE_HASH" >expect &&
+	test-tool partial-clone object-info partial.git "$FILE_HASH" >actual &&
+	test_cmp expect actual &&
+
+	# Sanity check that the file is now present
+	git -C partial.git rev-list --objects --missing=print HEAD >out &&
+	! grep "[?]$FILE_HASH" out
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.32.0.rc1.229.g3e70b5a671-goog

