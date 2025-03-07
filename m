Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D08E194C78
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 15:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741362528; cv=none; b=B+uUaJrAbhLwcMPUHS3BC0BoRNk4NdugzqVmhIM0XQqUXKilKQv8XfE3pNyWv5Z4Z4adAgVaVGfNQ6dKqdSGsVIbR8Ed2gP0bRTFlGq1EaldwQyCeuVpUA5km/xd5knJVfTKqB1VCUFjURyJYULVB0YVhH2naq8IZQp3UgU26vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741362528; c=relaxed/simple;
	bh=FXavj6SuMPsir2ALulDIh53QPSxD/0S+5YokMkzFRjo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lx/mM2sdBbDJksEaQzA8uFqjtmYsJyhD8d2A6Uyj+iCQcTYQG0FQCmgRpOwUHlGWvxftl2czBCyO3IFpbHX3MyM584spLObd6RW89Q+Q27oN+pqpOais35Tt/yECPHCbzSfnxR9T09PQBrs5Nfm4OsAaPVSRAp4oHd3B28Cv+G0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cbf1nw7y; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cbf1nw7y"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5e0813bd105so3296832a12.1
        for <git@vger.kernel.org>; Fri, 07 Mar 2025 07:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741362524; x=1741967324; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o7FHUVb7xP8d80Y3X2sdMzv1vb1ZsB+MMmKgglvEc6Q=;
        b=cbf1nw7yi75W2xmLsuLkIAa80ADB1QNFO2/r1lK8i5eBew8QWEAidMWHbIaCj4cZui
         6ycwGCAvhGUxV3VqjKT7ahLAORq51dFZduvA7Zoxt5y4WSAc5p5vuK5gyhR2zuyAkRP/
         dYPia62AmbxlsUARfECnH8lzof61L5ZR7bjvEe7qLSt7mnA4MPnlhxFhl2cqz3v7pmsz
         IMVuOuwPNoHEcJ9R5KYT4YhrbelRbCKf3SY1A5woFt0B51HBpNAoz0vK7cPslpQUVH3c
         n5rWEE3vT1GkAPJ0eAM/DtV7WAH46JAR4FMs6/lb4U7VmscekAhvTliiTGRLrHxfNDey
         gg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741362524; x=1741967324;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o7FHUVb7xP8d80Y3X2sdMzv1vb1ZsB+MMmKgglvEc6Q=;
        b=rAAUyvaPnxKN1WMGdoB1iJjYtNQjC6aOp9J7c7bwENQc30sF3OexABDXX9SPLuvFUt
         6Xd8RIHuXvfxiDWF8oxflxaoXUA/cyYHZvby3JOHwxfQKBgIbr4M0ipFNCr65zgtr7b+
         E3AmlU/LllQKRevOW+SGtTvE9zHAoqKcJornzbxclpxNKRnhu9PyO6uHuWEwAD4hP/Sx
         ypDi+yENZxVW+9GZ1eqVyrdZIc52oaYuWDjdRz9+AFn+Ai95sfEHaX3S0agbQjs+forY
         Pre1DXimhM6YtRIixEgWGLs6OuKiJ7CFD7nL7D8VNop/wHTmSgTdcDqR91bShGKo+zOg
         Qgyg==
X-Gm-Message-State: AOJu0Yy61j4rxM8lb5SPb2JQdQFm3FuuYY1AvC424AfuQtiY3j9/D9/0
	3RStpTtRHlnUZK7/snMJCixMOHV5LHHQC7TiQiIDm9Bv/gRJ4e1rLOwxuQ==
X-Gm-Gg: ASbGncvwPwIVnNHQekRHDIqQAbY1xercUCyc9yjwcOL8o8KXGHOr8eCPYrtcDTu3o0b
	2KlspP/HN0yRK9Xort/BJDcfuiRJ11yQA7pNK2sUBmCdgdL+eBMF5QZ31EuRv6cdAiDhDA7GAOB
	SP4BhvydSFRIgVvMD1YwfGs75zIqOoIFH3FaMgSdnla87FNICJIkbd9tLybhT3EVMNYApCc9TSS
	lKpzDHBvUEqv6yEQfour3EQE2r4zzQVlW93gY359aXdE79eUFtMVZfzFS/ExW55YpZWiIRsndeB
	UmHCgRY1BEi2hyU6DpmFjBL5GFe5nkQGFneT3iwF0lUJ9w==
X-Google-Smtp-Source: AGHT+IFaTHe5Pd8UCQY2+yD5fVEKRvxkOYIYkqIfQHUnxBvoAi/zz+0ioPW7iu87yip5WxMg+1Gbig==
X-Received: by 2002:a05:6402:4011:b0:5e5:e836:71f3 with SMTP id 4fb4d7f45d1cf-5e5e836730fmr3252271a12.29.1741362524052;
        Fri, 07 Mar 2025 07:48:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c768fa17sm2659871a12.72.2025.03.07.07.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:48:43 -0800 (PST)
Message-Id: <9f73e54224d55b40faeb5d68ebd7ff0c13d69c7b.1741362522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
References: <pull.1875.git.1741362522.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 07 Mar 2025 15:48:40 +0000
Subject: [PATCH 1/3] merge-ort: add new merge_ort_generic() function
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

merge-recursive.[ch] have three entry points:
  * merge_trees()
  * merge_recursive()
  * merge_recursive_generic()
merge-ort*.[ch] only has equivalents for the first two.  Add an
equivalent for the final entry point, so we can switch callers to
use it and remove merge-recursive.[ch].

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort-wrappers.c | 64 ++++++++++++++++++++++++++++++++++++++++++++
 merge-ort-wrappers.h | 12 +++++++++
 merge-ort.c          | 17 ++++++++----
 merge-ort.h          |  5 ++++
 4 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/merge-ort-wrappers.c b/merge-ort-wrappers.c
index d6f61359965..62834c30e9e 100644
--- a/merge-ort-wrappers.c
+++ b/merge-ort-wrappers.c
@@ -1,9 +1,13 @@
 #include "git-compat-util.h"
 #include "gettext.h"
 #include "hash.h"
+#include "hex.h"
+#include "lockfile.h"
 #include "merge-ort.h"
 #include "merge-ort-wrappers.h"
 #include "read-cache-ll.h"
+#include "repository.h"
+#include "tag.h"
 #include "tree.h"
 
 #include "commit.h"
@@ -64,3 +68,63 @@ int merge_ort_recursive(struct merge_options *opt,
 
 	return tmp.clean;
 }
+
+static struct commit *get_ref(struct repository *repo,
+			      const struct object_id *oid,
+			      const char *name)
+{
+	struct object *object;
+
+	object = deref_tag(repo, parse_object(repo, oid),
+			   name, strlen(name));
+	if (!object)
+		return NULL;
+	if (object->type == OBJ_TREE)
+		return make_virtual_commit(repo, (struct tree*)object, name);
+	if (object->type != OBJ_COMMIT)
+		return NULL;
+	if (repo_parse_commit(repo, (struct commit *)object))
+		return NULL;
+	return (struct commit *)object;
+}
+
+int merge_ort_generic(struct merge_options *opt,
+		      const struct object_id *head,
+		      const struct object_id *merge,
+		      int num_merge_bases,
+		      const struct object_id *merge_bases,
+		      struct commit **result)
+{
+	int clean;
+	struct lock_file lock = LOCK_INIT;
+	struct commit *head_commit = get_ref(opt->repo, head, opt->branch1);
+	struct commit *next_commit = get_ref(opt->repo, merge, opt->branch2);
+	struct commit_list *ca = NULL;
+
+	if (merge_bases) {
+		int i;
+		for (i = 0; i < num_merge_bases; ++i) {
+			struct commit *base;
+			if (!(base = get_ref(opt->repo, &merge_bases[i],
+					     oid_to_hex(&merge_bases[i]))))
+				return error(_("Could not parse object '%s'"),
+					     oid_to_hex(&merge_bases[i]));
+			commit_list_insert(base, &ca);
+		}
+	}
+
+	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
+	clean = merge_ort_recursive(opt, head_commit, next_commit, ca,
+				    result);
+	free_commit_list(ca);
+	if (clean < 0) {
+		rollback_lock_file(&lock);
+		return clean;
+	}
+
+	if (write_locked_index(opt->repo->index, &lock,
+			       COMMIT_LOCK | SKIP_IF_UNCHANGED))
+		return error(_("Unable to write index."));
+
+	return clean ? 0 : 1;
+}
diff --git a/merge-ort-wrappers.h b/merge-ort-wrappers.h
index 90af1f69c55..aeffa1c87b4 100644
--- a/merge-ort-wrappers.h
+++ b/merge-ort-wrappers.h
@@ -22,4 +22,16 @@ int merge_ort_recursive(struct merge_options *opt,
 			const struct commit_list *ancestors,
 			struct commit **result);
 
+/*
+ * rename-detecting three-way merge.  num_merge_bases must be at least 1.
+ * Recursive ancestor consolidation will be performed if num_merge_bases > 1.
+ * Wrapper mimicking the old merge_recursive_generic() function.
+ */
+int merge_ort_generic(struct merge_options *opt,
+		      const struct object_id *head,
+		      const struct object_id *merge,
+		      int num_merge_bases,
+		      const struct object_id *merge_bases,
+		      struct commit **result);
+
 #endif
diff --git a/merge-ort.c b/merge-ort.c
index 46e78c3ffa6..b4ff24403a1 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -4878,9 +4878,9 @@ static inline void set_commit_tree(struct commit *c, struct tree *t)
 	c->maybe_tree = t;
 }
 
-static struct commit *make_virtual_commit(struct repository *repo,
-					  struct tree *tree,
-					  const char *comment)
+struct commit *make_virtual_commit(struct repository *repo,
+				   struct tree *tree,
+				   const char *comment)
 {
 	struct commit *commit = alloc_commit_node(repo);
 
@@ -5186,6 +5186,8 @@ static void merge_ort_internal(struct merge_options *opt,
 		ancestor_name = "empty tree";
 	} else if (merge_bases) {
 		ancestor_name = "merged common ancestors";
+	} else if (opt->ancestor) {
+		ancestor_name = opt->ancestor;
 	} else {
 		strbuf_add_unique_abbrev(&merge_base_abbrev,
 					 &merged_merge_bases->object.oid,
@@ -5275,8 +5277,13 @@ void merge_incore_recursive(struct merge_options *opt,
 {
 	trace2_region_enter("merge", "incore_recursive", opt->repo);
 
-	/* We set the ancestor label based on the merge_bases */
-	assert(opt->ancestor == NULL);
+	/*
+	 * We set the ancestor label based on the merge_bases...but we
+	 * allow one exception through so that builtin/am can override
+	 * with its constructed fake ancestor.
+	 */
+	assert(opt->ancestor == NULL ||
+	       (merge_bases && !merge_bases->next));
 
 	trace2_region_enter("merge", "merge_start", opt->repo);
 	merge_start(opt, result);
diff --git a/merge-ort.h b/merge-ort.h
index 82f2b3222d2..b63bc5424e7 100644
--- a/merge-ort.h
+++ b/merge-ort.h
@@ -44,6 +44,11 @@ struct merge_result {
 	unsigned _properly_initialized;
 };
 
+/* Mostly internal function also used by merge-ort-wrappers.c */
+struct commit *make_virtual_commit(struct repository *repo,
+				   struct tree *tree,
+				   const char *comment);
+
 /*
  * rename-detecting three-way merge with recursive ancestor consolidation.
  * working tree and index are untouched.
-- 
gitgitgadget

