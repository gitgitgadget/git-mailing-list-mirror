Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FFF304BCB
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 18:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765303889; cv=none; b=NZOHNa17QHblwbS6VA4nQNThSxTcfBvLRKLZZPyLVOSLoBPijlk7sBESJywo4t1VvySyrf6dE+vcYDYRFvndQiizdJAHSz8mT3d9D2RI2VuVGS+ynQPEQm/hp5YFeoYTGNE6wDwC3pM29bhWDypywMmwSRi3K2mRA/0J9Ryn64U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765303889; c=relaxed/simple;
	bh=6PLrIJ2U5115I1VHD+JKsHThljsEeeLWg91+VoXOq0M=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=IvZWNtISOGkYxElFMvgx5R9bdD+AiM8CD+Idi8orl1XB3RMsDelZ7ZAcNZIaw9qE3SzrbT98XFgr4yC/EV70LgE+XfBn+xylYjfh+QExoS6ri9RrulCH+z8CEY3+kjAdP0Hu3oZEFaOLPMcMgkZysbADyOaLyyJo8yxBansUtT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XVEg9bls; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XVEg9bls"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7b22ffa2a88so6019487b3a.1
        for <git@vger.kernel.org>; Tue, 09 Dec 2025 10:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765303885; x=1765908685; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z4ltr9SfZ5GXUTyj2zupY7UBZz9yU6ApGwDIa3Jg9gM=;
        b=XVEg9blsu4BGYbpOCIEez8zvuQ+En2PGWgQDs4UTupA8dcGV25DOuPGq2mc4OLRNKm
         87x8ibMSpr4NrLKVKvXOFifQlHdDSXHlZ1pv5rIL7Ey1rMjKFuTmvfSKlzTzTHgQTvGE
         ZVseuOkz6fTC/ecIu+CAZCU8cCBEvIUctO31Qbwr8g23uuB+W1sNsSXTLGOPB0gGmFa1
         amIszCq37XtFhdft3obv80f082JZGKRlLQu4gPqmlv8o6898SyhDAh7dims5X/cLscVg
         Bkk34yp23cJbKv9gCuJaH2ZQGV3kGHjU+/Hn50dYRGl3uXj0vfs/l+VSbImaU25KKDpq
         PY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765303885; x=1765908685;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z4ltr9SfZ5GXUTyj2zupY7UBZz9yU6ApGwDIa3Jg9gM=;
        b=cwbH6usGfkM5qTkF5V5nE2U/tpsKjH+nlh5ctFTwaCuE1M0S+7qWMxTTctVifFiTOW
         PRRLIH3TwtmzTUgxv2tg2QSB03JBcY2UrcBOmr5AiJAstQB6hjgmPItscwRZ8VKam0ja
         01shYdLAfjACCEkKvqkHbKE1JcID+oDVAuvpt1v0hN7xXvMK/bAlyHtreOYd8J79KUWa
         fpSow9AXprC7b2bbsTgS1iwe78tVOmW8obTrhAbiotF6kq1ZYDTnZ+I1nnBppCugy3JJ
         yOWlL67+xN7aOVqH4mPc1tiAqItCn0gNXUoAO93le5BMzlhif90KKBNqKYFuuavmEckd
         wl/Q==
X-Gm-Message-State: AOJu0YwQHX91jvwPN/rp5rw6z1LcyPiwe7q6Cw+A8rX6aTCRWMInTVAr
	2juq4RN96SmiFEtaPlejOb6IWXF/DPDjOANNILtKNImwA4zQNMuLxD6kTx4q0g==
X-Gm-Gg: ASbGncvPUuA2azPotu3z4fKmKqtCcJuAckYiaOfmbO/NmWrAFM0NL0dmkObRiDgzBc/
	pfQnw5lF5T+eeA18UzzIk/+B+RRhZLHmY2+kHGHHUq8QLSweoYdu2yU/SbNPuaWc8o+GLYwfBMf
	oPQNTvUAYFhQD2aQswOcwrxNEYS5awSR5bqxp6kJkk2cek1rCnrO4EQJbZb6SZ4Ijd+KsjCn7dl
	YE0t5yG1o2dily8NqABNJJvykU1H9OVcSe1upEtpZCgUUnQhiwFFQqDDRz2yF8jQfYIT+THf8fy
	FAeY2OpwaTFKyHZwO0FxA1a1ftt+iRfuB91kNpSpgIejVF86Zfwyz2ObYCS6LOGvkki0YiysnsY
	bmGgRf+WMFktECSk7hNzGk+gWmhvRlSfPDUdBWGiWXTwhq9OZXX017bylb4Em+eQMJAiB07rFQ2
	j66CKyD1k4PQbo
X-Google-Smtp-Source: AGHT+IE9dWa70NPC5evy7IwD0hbrC7Dt6IRng45RimAeA2ejds6+7ZNoVepsyFxHIl+hZ2aRAgU9nA==
X-Received: by 2002:a05:7022:1289:b0:11e:3e9:3e96 with SMTP id a92af1059eb24-11e03e943edmr8464023c88.50.1765303884512;
        Tue, 09 Dec 2025 10:11:24 -0800 (PST)
Received: from [127.0.0.1] ([20.168.111.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11df7703bd7sm75639532c88.10.2025.12.09.10.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 10:11:23 -0800 (PST)
Message-Id: <b352a33c90ca67f4ad68df08c0fd155ceeeb167c.1765303880.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
References: <pull.2121.git.git.1765303880.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Samo=20Poga=C4=8Dnik?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 09 Dec 2025 18:11:20 +0000
Subject: [PATCH 2/2] shallow: handling fetch relative-deepen
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>,
    =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

From: =?UTF-8?q?Samo=20Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>

When a shallowed repository gets deepened beyond the beginning of a
merged branch, we may endup with some shallows, that are behind the
reachable ones. Added test 'fetching deepen beyond merged branch'
exposes that behaviour.

On the other hand, it seems that equivalent absolute depth driven
fetches result in all the correct shallows. That led to this proposal,
which unifies absolute and relative deepening in a way that the same
get_shallow_commits() call is used in both cases. The difference is
only that depth is adapted for relative deepening by measuring
equivalent depth of current local shallow commits in the current remote
repo. Thus a new function get_shallows_depth() has been added and the
function get_reachable_list() became redundant / removed.

The get_shallows_depth() function also shares the logic of the
get_shallow_commits() function, but it focuses on counting depth of
each existing shallow commit. The minimum result is stored as
'data->deepen_relative', which is set not to be zero for relative
deepening anyway. That way we can allways summ 'data->deepen_relative'
and 'depth' values, because 'data->deepen_relative' is always 0 in
absolute deepening.

Signed-off-by: Samo Pogačnik <samo_pogacnik@t-2.net>
---
 t/t5500-fetch-pack.sh |  24 +++++++
 upload-pack.c         | 142 +++++++++++++++++++++++-------------------
 2 files changed, 102 insertions(+), 64 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2677cd5faa..d05c45e32b 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -955,6 +955,30 @@ test_expect_success 'fetching deepen' '
 	)
 '
 
+test_expect_success 'fetching deepen beyond merged branch' '
+	test_create_repo shallow-deepen-merged &&
+	(
+		cd shallow-deepen-merged &&
+		git commit --allow-empty -m one &&
+		git commit --allow-empty -m two &&
+		git commit --allow-empty -m three &&
+		git switch -c branch &&
+		git commit --allow-empty -m four &&
+		git commit --allow-empty -m five &&
+		git switch main &&
+		git merge --no-ff branch &&
+		cd - &&
+		git clone --bare --depth 3 "file://$(pwd)/shallow-deepen-merged" deepen.git &&
+		git -C deepen.git fetch origin --deepen=1 &&
+		echo "Shallow:" && cat deepen.git/shallow &&
+		git -C deepen.git rev-list --all >actual &&
+		echo "All rev-lis:" && cat actual &&
+		for commit in $(sed "/^$/d" deepen.git/shallow); do
+			test_grep "$commit" actual || exit 1
+		done
+	)
+'
+
 test_negotiation_algorithm_default () {
 	test_when_finished rm -rf clientv0 clientv2 &&
 	rm -rf server client &&
diff --git a/upload-pack.c b/upload-pack.c
index 2d2b70cbf2..ecd3e7f5ef 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -33,6 +33,7 @@
 #include "json-writer.h"
 #include "strmap.h"
 #include "promisor-remote.h"
+#include "tag.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -704,54 +705,82 @@ error:
 	return -1;
 }
 
-static int get_reachable_list(struct upload_pack_data *data,
-			      struct object_array *reachable)
+define_commit_slab(commit_depth, int *);
+static void free_depth_in_slab(int **ptr)
 {
-	struct child_process cmd = CHILD_PROCESS_INIT;
-	int i;
-	struct object *o;
-	char namebuf[GIT_MAX_HEXSZ + 2]; /* ^ + hash + LF */
-	const unsigned hexsz = the_hash_algo->hexsz;
-	int ret;
-
-	if (do_reachable_revlist(&cmd, &data->shallows, reachable,
-				 data->allow_uor) < 0) {
-		ret = -1;
-		goto out;
-	}
-
-	while ((i = read_in_full(cmd.out, namebuf, hexsz + 1)) == hexsz + 1) {
-		struct object_id oid;
-		const char *p;
-
-		if (parse_oid_hex(namebuf, &oid, &p) || *p != '\n')
-			break;
-
-		o = lookup_object(the_repository, &oid);
-		if (o && o->type == OBJ_COMMIT) {
-			o->flags &= ~TMP_MARK;
+	FREE_AND_NULL(*ptr);
+}
+static void get_shallows_depth(struct upload_pack_data *data)
+{
+	size_t i = 0, j;
+	int cur_depth = 0, cur_depth_shallow = 0;
+	struct object_array stack = OBJECT_ARRAY_INIT;
+	struct commit *commit = NULL;
+	struct commit_graft *graft;
+	struct commit_depth depths;
+	struct object_array *heads = &data->want_obj;
+	struct object_array *shallows = &data->shallows;
+
+	init_commit_depth(&depths);
+	while (commit || i < heads->nr || stack.nr) {
+		struct commit_list *p;
+		if (!commit) {
+			if (i < heads->nr) {
+				int **depth_slot;
+				commit = (struct commit *)
+					deref_tag(the_repository,
+						  heads->objects[i++].item,
+						  NULL, 0);
+				if (!commit || commit->object.type != OBJ_COMMIT) {
+					commit = NULL;
+					continue;
+				}
+				depth_slot = commit_depth_at(&depths, commit);
+				if (!*depth_slot)
+					*depth_slot = xmalloc(sizeof(int));
+				**depth_slot = 0;
+				cur_depth = 0;
+			} else {
+				commit = (struct commit *)
+					object_array_pop(&stack);
+				cur_depth = **commit_depth_at(&depths, commit);
+			}
 		}
-	}
-	for (i = get_max_object_index(the_repository); 0 < i; i--) {
-		o = get_indexed_object(the_repository, i - 1);
-		if (o && o->type == OBJ_COMMIT &&
-		    (o->flags & TMP_MARK)) {
-			add_object_array(o, NULL, reachable);
-				o->flags &= ~TMP_MARK;
+		parse_commit_or_die(commit);
+		cur_depth++;
+		for (j = 0; j < shallows->nr; j++)
+			if (oideq(&commit->object.oid, &shallows->objects[j].item->oid))
+				if ((!cur_depth_shallow) || (cur_depth < cur_depth_shallow))
+					cur_depth_shallow = cur_depth;
+
+		if ((is_repository_shallow(the_repository) && !commit->parents &&
+		     (graft = lookup_commit_graft(the_repository, &commit->object.oid)) != NULL &&
+		     graft->nr_parent < 0)) {
+			commit = NULL;
+			continue;
+		}
+		for (p = commit->parents, commit = NULL; p; p = p->next) {
+			int **depth_slot = commit_depth_at(&depths, p->item);
+			if (!*depth_slot) {
+				*depth_slot = xmalloc(sizeof(int));
+				**depth_slot = cur_depth;
+			} else {
+				if (cur_depth >= **depth_slot)
+					continue;
+				**depth_slot = cur_depth;
+			}
+			if (p->next)
+				add_object_array(&p->item->object,
+						NULL, &stack);
+			else {
+				commit = p->item;
+				cur_depth = **commit_depth_at(&depths, commit);
+			}
 		}
 	}
-	close(cmd.out);
-
-	if (finish_command(&cmd)) {
-		ret = -1;
-		goto out;
-	}
-
-	ret = 0;
-
-out:
-	child_process_clear(&cmd);
-	return ret;
+	deep_clear_commit_depth(&depths, free_depth_in_slab);
+	object_array_clear(&stack);
+	data->deepen_relative = cur_depth_shallow;
 }
 
 static int has_unreachable(struct object_array *src, enum allow_uor allow_uor)
@@ -881,29 +910,14 @@ static void deepen(struct upload_pack_data *data, int depth)
 			struct object *object = data->shallows.objects[i].item;
 			object->flags |= NOT_SHALLOW;
 		}
-	} else if (data->deepen_relative) {
-		struct object_array reachable_shallows = OBJECT_ARRAY_INIT;
-		struct commit_list *result;
-
-		/*
-		 * Checking for reachable shallows requires that our refs be
-		 * marked with OUR_REF.
-		 */
-		refs_head_ref_namespaced(get_main_ref_store(the_repository),
-					 check_ref, data);
-		for_each_namespaced_ref_1(check_ref, data);
-
-		get_reachable_list(data, &reachable_shallows);
-		result = get_shallow_commits(&reachable_shallows,
-					     depth + 1,
-					     SHALLOW, NOT_SHALLOW);
-		send_shallow(data, result);
-		free_commit_list(result);
-		object_array_clear(&reachable_shallows);
 	} else {
 		struct commit_list *result;
 
-		result = get_shallow_commits(&data->want_obj, depth,
+		if (data->deepen_relative)
+			get_shallows_depth(data);
+
+		result = get_shallow_commits(&data->want_obj,
+					     data->deepen_relative + depth,
 					     SHALLOW, NOT_SHALLOW);
 		send_shallow(data, result);
 		free_commit_list(result);
-- 
gitgitgadget
