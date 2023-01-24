Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CE5C38142
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 14:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234839AbjAXOQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Jan 2023 09:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234315AbjAXOQg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jan 2023 09:16:36 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B51485A2
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:16:32 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j9so13133075qtv.4
        for <git@vger.kernel.org>; Tue, 24 Jan 2023 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJQIML/+X9b3V8r+JvMgcLagaPX3JwpMZSNIOg5llQE=;
        b=SyrLbXoPSIpmItiqEZMiVrzP2q2+o48LdP2CVJvlzS3B4k5ZOPD7cAYDZyfqbq7eaG
         hol1p3xjE5hFKnVYTBLeWcqafphgPjdbqywJzbquywLqtj7vcdwnlUeXHdmgOKFcTrJ3
         F90QQA5aMxQ4CYK7FpO1uazCS5qQPL638C1kKOisqEOKkoX4BSancnHzH74VIDNRx4GH
         mwOV55gBD89ivsyTqY94XoUfotnEKf/WJQEzjohUGHs/qzy8SWEuZp6EN/DRAfw/dLf4
         J7ulpWJXaYWWrZYQepyAuw3oWxuUFh4nAd6LKrpdeYq4HCMCWXbhkM2NVuGrdQx6ee6N
         QaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hJQIML/+X9b3V8r+JvMgcLagaPX3JwpMZSNIOg5llQE=;
        b=b871JwuBo8qpqbF+CkOAwxtniy3H6H5ONpWtvzJhn2R4RUTNDLmh1w6X9ZnKKnGvQV
         kJNj+5UgCFOHLFtUJgj3EXUZ9nOS11n+nwoIC8UGOWtVJj5Ok4XC9HCcKyW+hGTLVKrh
         O0Wi1a4mrufxMRCwsGs2ukijjxKkHCG7qHZdB8D0Q8NlBOuWItEkE7VeeQqpBGT8zcfN
         UADgxegqXpqo5x26WQr75NenfJxy67OnMfR+fOpF4Kzb1tKF2Ad7DjI+PwOpLQfYtFsB
         k7ZSexKWS5/3Mgv+eIgi2DvxP9o4hcqkpOQnSlMKwR7foiqowU4lP9ptdsttJj8rtNCG
         dI8Q==
X-Gm-Message-State: AFqh2kqboSMdrUJxPynOBpz6bOlVT3RT1km9jKOvm3EQzJzcrtfcorYh
        aZvP3iNHH5FDHCRSbXNMcJqw
X-Google-Smtp-Source: AMrXdXs6bY5VoFXoRlxzwJB+oS0F4R1FEmQeryB/5WADbDjWFhtCx4bBXQhL/TkEavdKR3aTA0LbMQ==
X-Received: by 2002:ac8:4cc7:0:b0:3ab:2a7f:83e4 with SMTP id l7-20020ac84cc7000000b003ab2a7f83e4mr37222211qtv.35.1674569791999;
        Tue, 24 Jan 2023 06:16:31 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:70c6:2d77:ae17:eae3? ([2600:1700:e72:80a0:70c6:2d77:ae17:eae3])
        by smtp.gmail.com with ESMTPSA id b10-20020ac812ca000000b003a7f3c4dcdfsm1301697qtj.47.2023.01.24.06.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 06:16:31 -0800 (PST)
Message-ID: <ecc6b167-f5c4-48ce-3973-461d1659ed40@github.com>
Date:   Tue, 24 Jan 2023 09:16:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: [PATCH v2.5 02/11] bundle: verify using connected()
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, me@ttaylorr.com, vdye@github.com,
        avarab@gmail.com, steadmon@google.com, chooglen@google.com
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <pull.1454.v2.git.1674487310.gitgitgadget@gmail.com>
 <b3828725bc8f8887b9b4777a0e3d84224a427f31.1674487310.git.gitgitgadget@gmail.com>
 <xmqqsfg1m8l6.fsf@gitster.g>
 <eae85534-89c9-6eff-69d5-7d4b2be85fb6@github.com>
 <xmqqilgxm2ky.fsf@gitster.g> <xmqqtu0glw81.fsf@gitster.g>
 <771a2993-85bd-0831-0977-24204f84e206@github.com>
In-Reply-To: <771a2993-85bd-0831-0977-24204f84e206@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2023 7:27 AM, Derrick Stolee wrote:

> I'll focus on this area today and see what I can learn and how I
> can approach this problem in a different way.

>  2. Find out how to modify verify_bundle() so it can do the more
>     relaxed connectivity check.

And here is the modification to verify_bundle() to depend on
check_connected() instead. This also improves (in my opinion) the
error reporting from this situation, as seen in the test edits.

Again, this is a placeholder before I re-roll this series into
an inevitable v3, so don't bother applying this patch until then.

Thanks,
-Stolee

--- >8 ---

From 6a3d64761e9691994f9310b9ce2338f49aa72d48 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <derrickstolee@github.com>
Date: Tue, 24 Jan 2023 08:47:00 -0500
Subject: [PATCH v2.5 02/11] bundle: verify using connected()

When Git verifies a bundle to see if it is safe for unbundling, it first
looks to see if the prerequisite commits are in the object store. This
is usually a sufficient filter, and those missing commits are indicated
clearly in the error messages. However, if the commits are present in
the object store, then there could still be issues if those commits are
not reachable from the repository's references. The repository only has
guarantees that its object store is closed under reachability for the
objects that are reachable from references.

Thus, the code in verify_bundle() has previously had the additional
check that all prerequisite commits are reachable from repository
references. This is done via a revision walk from all references,
stopping only if all prerequisite commits are discovered or all commits
are walked. This uses a custom walk to verify_bundle().

This check is more strict than what Git applies even to fetched
pack-files. In the fetch case, Git guarantees that the new references
are closed under reachability by walking from the new references until
walking commits that are reachable from repository refs. This is done
through the well-used check_connected() method.

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
2.39.1.vfs.0.0


