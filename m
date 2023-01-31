Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BABC636D3
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 13:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjAaN3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 08:29:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjAaN30 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 08:29:26 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DDA548615
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:25 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so12459176wma.1
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 05:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SEWWW/J6pfqbgcEnSGKk8RmYi0LognbbM6TQuGUEkcE=;
        b=HH9f86Eiird7UcIU90HzM3SkBiVfdtIhGj1lWIrVUztNLL4NO4kb6WqSyuLAckzGXn
         PHdMwvuqETbd9AEl+OlYV/WNZ21TQc/V8B6soWTTfimkGxjN6wvxOzohnYZdHa23+DMY
         pjCzy5lP+tVht6HzJlCPh8wtPWo5VKdmAdclzDg9aLEusKD/zUuadYjYuap1zubLbycX
         +Ye28Xyd+R3+bH7yYuwKIWUZtA/SlZyjgR2nAOlpYjzBioq+AUCVkldMXWppDqViFS45
         p+WBZS/0g+C/99lKK7qy8dnywABPYvIuf/7+A7fw3l5HsMMWcNRpVlVShXP1wt+i5N1K
         ljXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SEWWW/J6pfqbgcEnSGKk8RmYi0LognbbM6TQuGUEkcE=;
        b=zPZ5k5KFChbAhi/zTaSx41Qyt7HneWqlLoiUitttpmAo9d5FoiyPwmDf5LjaLMun8m
         Xox48LKQbaLBPKsmeyIEegMBMKXNGi4pBPZ8cDkTUqM/2B7Sq20AEPudi2VSvXk6uTAV
         wPuFqkIj4CvC0T1Y0P0tVkrXEwVdVeW5md9Az81xNZRbKviflJw0D5/a7k9HJVP0mg97
         cmVi7NqNvuP6W84u/s27ZKw6yzdIPJjt48NtzQ18GLGULiUSsHroKjME8hOYpVwiyqmi
         i/CuoUQcJp7L1jY+L6L+K7NUgn0kDPMjDjNIGMqITbrBbH18WdtcrPmTBL71a05E3Hjn
         vrwA==
X-Gm-Message-State: AO0yUKUO8GFo5s2h3amTC63WgCUUEL3DbtEZSMG3FfzTAH6gzVhnHtLm
        eQP5GaXeo7IFxFvlWSse1uuboJJWdC8=
X-Google-Smtp-Source: AK7set9bpZKMVaFqB/ly8xp1VrloQoQgXWXfsiPLjC2o0BbepMLYKItmdAtnMypX3ZCntY0/ajBnzA==
X-Received: by 2002:a05:600c:4447:b0:3dc:4481:b07 with SMTP id v7-20020a05600c444700b003dc44810b07mr16101827wmn.20.1675171763410;
        Tue, 31 Jan 2023 05:29:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi5-20020a05600c3d8500b003db0bb81b6asm16724085wmb.1.2023.01.31.05.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 05:29:23 -0800 (PST)
Message-Id: <20c29d37f9c1ba1367145331d25dd27f966312cd.1675171759.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
References: <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
        <pull.1454.v3.git.1675171759.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 31 Jan 2023 13:29:10 +0000
Subject: [PATCH v3 02/11] bundle: verify using check_connected()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When Git verifies a bundle to see if it is safe for unbundling, it first
looks to see if the prerequisite commits are in the object store. This
is an easy way to "fail fast" but it is not a sufficient check for
updating refs that guarantee closure under reachability. There could
still be issues if those commits are not reachable from the repository's
references. The repository only has guarantees that its object store is
closed under reachability for the objects that are reachable from
references.

Thus, the code in verify_bundle() has previously had the additional
check that all prerequisite commits are reachable from repository
references. This is done via a revision walk from all references,
stopping only if all prerequisite commits are discovered or all commits
are walked. This uses a custom walk to verify_bundle().

This check is more strict than what Git applies to fetched pack-files.
In the fetch case, Git guarantees that the new references are closed
under reachability by walking from the new references until walking
commits that are reachable from repository refs. This is done through
the well-used check_connected() method.

To better align with the restrictions required by 'git fetch',
reimplement this check in verify_bundle() to use check_connected(). This
also simplifies the code significantly.

The previous change added a test that verified the behavior of 'git
bundle verify' and 'git bundle unbundle' in this case, and the error
messages looked like this:

  error: Could not read <missing-commit>
  fatal: Failed to traverse parents of commit <extant-commit>

However, by changing the revision walk slightly within check_connected()
and using its quiet mode, we can omit those messages. Instead, we get
only this message, tailored to describing the current state of the
repository:

  error: some prerequisite commits exist in the object store,
         but are not connected to the repository's history

(Line break added here for the commit message formatting, only.)

While this message does not include any object IDs, there is no
guarantee that those object IDs would help the user diagnose what is
going on, as they could be separated from the prerequisite commits by
some distance. At minimum, this situation describes the situation in a
more informative way than the previous error messages.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 bundle.c               | 75 ++++++++++++++++--------------------------
 t/t6020-bundle-misc.sh |  8 ++---
 2 files changed, 33 insertions(+), 50 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..76c3a904898 100644
--- a/bundle.c
+++ b/bundle.c
@@ -12,6 +12,7 @@
 #include "refs.h"
 #include "strvec.h"
 #include "list-objects-filter-options.h"
+#include "connected.h"
 
 static const char v2_bundle_signature[] = "# v2 git bundle\n";
 static const char v3_bundle_signature[] = "# v3 git bundle\n";
@@ -187,6 +188,21 @@ static int list_refs(struct string_list *r, int argc, const char **argv)
 /* Remember to update object flag allocation in object.h */
 #define PREREQ_MARK (1u<<16)
 
+struct string_list_iterator {
+	struct string_list *list;
+	size_t cur;
+};
+
+static const struct object_id *iterate_ref_map(void *cb_data)
+{
+	struct string_list_iterator *iter = cb_data;
+
+	if (iter->cur >= iter->list->nr)
+		return NULL;
+
+	return iter->list->items[iter->cur++].util;
+}
+
 int verify_bundle(struct repository *r,
 		  struct bundle_header *header,
 		  enum verify_bundle_flags flags)
@@ -196,26 +212,25 @@ int verify_bundle(struct repository *r,
 	 * to be verbose about the errors
 	 */
 	struct string_list *p = &header->prerequisites;
-	struct rev_info revs = REV_INFO_INIT;
-	const char *argv[] = {NULL, "--all", NULL};
-	struct commit *commit;
-	int i, ret = 0, req_nr;
+	int i, ret = 0;
 	const char *message = _("Repository lacks these prerequisite commits:");
+	struct string_list_iterator iter = {
+		.list = p,
+	};
+	struct check_connected_options opts = {
+		.quiet = 1,
+	};
 
 	if (!r || !r->objects || !r->objects->odb)
 		return error(_("need a repository to verify a bundle"));
 
-	repo_init_revisions(r, &revs, NULL);
 	for (i = 0; i < p->nr; i++) {
 		struct string_list_item *e = p->items + i;
 		const char *name = e->string;
 		struct object_id *oid = e->util;
 		struct object *o = parse_object(r, oid);
-		if (o) {
-			o->flags |= PREREQ_MARK;
-			add_pending_object(&revs, o, name);
+		if (o)
 			continue;
-		}
 		ret++;
 		if (flags & VERIFY_BUNDLE_QUIET)
 			continue;
@@ -223,37 +238,14 @@ int verify_bundle(struct repository *r,
 			error("%s", message);
 		error("%s %s", oid_to_hex(oid), name);
 	}
-	if (revs.pending.nr != p->nr)
+	if (ret)
 		goto cleanup;
-	req_nr = revs.pending.nr;
-	setup_revisions(2, argv, &revs, NULL);
-
-	list_objects_filter_copy(&revs.filter, &header->filter);
-
-	if (prepare_revision_walk(&revs))
-		die(_("revision walk setup failed"));
 
-	i = req_nr;
-	while (i && (commit = get_revision(&revs)))
-		if (commit->object.flags & PREREQ_MARK)
-			i--;
-
-	for (i = 0; i < p->nr; i++) {
-		struct string_list_item *e = p->items + i;
-		const char *name = e->string;
-		const struct object_id *oid = e->util;
-		struct object *o = parse_object(r, oid);
-		assert(o); /* otherwise we'd have returned early */
-		if (o->flags & SHOWN)
-			continue;
-		ret++;
-		if (flags & VERIFY_BUNDLE_QUIET)
-			continue;
-		if (ret == 1)
-			error("%s", message);
-		error("%s %s", oid_to_hex(oid), name);
-	}
+	if ((ret = check_connected(iterate_ref_map, &iter, &opts)))
+		error(_("some prerequisite commits exist in the object store, "
+			"but are not connected to the repository's history"));
 
+	/* TODO: preserve this verbose language. */
 	if (flags & VERIFY_BUNDLE_VERBOSE) {
 		struct string_list *r;
 
@@ -282,15 +274,6 @@ int verify_bundle(struct repository *r,
 				  list_objects_filter_spec(&header->filter));
 	}
 cleanup:
-	/* Clean up objects used, as they will be reused. */
-	for (i = 0; i < p->nr; i++) {
-		struct string_list_item *e = p->items + i;
-		struct object_id *oid = e->util;
-		commit = lookup_commit_reference_gently(r, oid, 1);
-		if (commit)
-			clear_commit_marks(commit, ALL_REV_FLAGS | PREREQ_MARK);
-	}
-	release_revisions(&revs);
 	return ret;
 }
 
diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 38dbbf89155..7d40994991e 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -595,14 +595,14 @@ test_expect_success 'verify catches unreachable, broken prerequisites' '
 		# Verify should fail
 		test_must_fail git bundle verify \
 			../clone-from/tip.bundle 2>err &&
-		grep "Could not read $BAD_OID" err &&
-		grep "Failed to traverse parents of commit $TIP_OID" err &&
+		grep "some prerequisite commits .* are not connected" err &&
+		test_line_count = 1 err &&
 
 		# Unbundling should fail
 		test_must_fail git bundle unbundle \
 			../clone-from/tip.bundle 2>err &&
-		grep "Could not read $BAD_OID" err &&
-		grep "Failed to traverse parents of commit $TIP_OID" err
+		grep "some prerequisite commits .* are not connected" err &&
+		test_line_count = 1 err
 	)
 '
 
-- 
gitgitgadget

