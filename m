Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EEA143C7A
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712597902; cv=none; b=nY9cIpiNV56XIzREJDZQMkgJvwMs0usMA8yCcNmbjNOcs1RyScL/uXakk4d7sezOqJD8umZGY3M4oFb45TF8Ty6H7Ixr2r4Tba1ol2lrZaMH5WBoCFIIc371ZvLsVHy4xOnBgL/7lAIzsLNTu1YytZR+WvxTfkA3eUEFrJT9kjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712597902; c=relaxed/simple;
	bh=/nhm+s7f1P1m28C0DtHBDHCUpkO1tSWGgxiTbAdHXdc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=iv9GzbxB95oiRhvObPpu8vvnGKewUXUftl6jpo40SrN2YfJ/NqZuZa8/jKCC3Xd130ACZahR6m0C8GkBYjC9Ec6hMl2sapo+L0FwTUoQ5qS4Fr4pUHXvRby+Q4ijOL7dijjiUjwGLHnpQsXTTyuqh1DVSmGx0CTGTwrwAvOZoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jCrb9AKa; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jCrb9AKa"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4168a5d7564so4873445e9.3
        for <git@vger.kernel.org>; Mon, 08 Apr 2024 10:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712597898; x=1713202698; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PRkSSHBQX/w3a87xkqplaj0Azw+bUkiUbKAG4NbSjQ=;
        b=jCrb9AKaNPHtT2malmVfq/0OyKmBIkuGeFqlqQLRYomir6sWLOkvtBTseG4kxKnK4O
         h2ZWiLxjG47Iyigro2Pa60e3dIGyVOwtithQ9vb9uiRp6oh32sIUFwTA47PCHBIARiXe
         38k4er8FpryBNqX4+61qiUn4rKRQ+LCZNRlhmTMLOHwZ/hBS/pFOrk8smFbyhnRIz5Ui
         SDHJyZrAM30a/JBWaHjvkKtPhe7No0BmNrKsM0TRlke37EGrbqTiVNl54EyYnbiHpK8W
         8oE2XL/pVhw7yb0a03OEQEdD76ZCaNAYLIMKAjfWLWnRXsnlT2lmg8CUHaTN7gqhElN/
         vy+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712597898; x=1713202698;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0PRkSSHBQX/w3a87xkqplaj0Azw+bUkiUbKAG4NbSjQ=;
        b=u9FwZObQ78wUoIPs9tq9DVUhoKkaFdWvDb6lVaflbsIPncKr7pc8nOdIG1jLNwo/zw
         wOKOhlSnjay94yB4E9IwTbv01s0ySnTL1IK/UFGdR+OnE571mPvgTrjnP/sFpHHxQC/N
         8Ey2kQU/tAXxBFj2mqEX41ReUogvHdfCLpcu4ZYDVO4UYn/I5AdsKbTdcVRuRkoS61At
         3dgKu/XO3ldiDrxdM6s2pxLtwvSlS1Hnia7Yeat6yZmSWJqdJ2OT8LiwezSuIkEneWC1
         H0U2UkG1wn40AFmnsYzeD0C7vQ8ZCsXsqc5ZZe5BAdrBQmR0xVOqGcKB2wPkwLUPfpYg
         gikQ==
X-Gm-Message-State: AOJu0YxJ0AQaUEuJu8WpjMEr1ZY/YsuTnw3WlKWvDXrF/ng5uZYuFS4o
	zY6LGA5HjtmiFFmtjlAlPVxVzr++TyhyUiHNMi6uZDLjqkTFeXYspx1YUJfy
X-Google-Smtp-Source: AGHT+IELd8JdCK/KOYTukSeNXpt1f7FuIWE2kBW2zJhpeA1c4uQ51+S+qyA1mqiFGrylE5wrbRX8XA==
X-Received: by 2002:a05:600c:4fc2:b0:414:8e02:e432 with SMTP id o2-20020a05600c4fc200b004148e02e432mr8176143wmq.7.1712597898151;
        Mon, 08 Apr 2024 10:38:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b0041668162b45sm5194429wms.26.2024.04.08.10.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 10:38:17 -0700 (PDT)
Message-Id: <a9e6644327a04f1d309eca812ace9c4159781353.1712597893.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
References: <pull.1684.git.git.1709592718743.gitgitgadget@gmail.com>
	<pull.1684.v2.git.git.1712597893.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 08 Apr 2024 17:38:13 +0000
Subject: [PATCH v2 3/3] show-ref: add --symbolic-name option
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

For reftable development, it would be handy to have a tool to provide
the direct value of any ref whether it be a symbolic ref or not.
Currently there is git-symbolic-ref, which only works for symbolic refs,
and git-rev-parse, which will resolve the ref. Let's teach show-ref a
--symbolic-name option that will cause git-show-ref(1) to print out the
value symbolic references points to.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-show-ref.txt | 21 ++++++++++++++++++-
 builtin/show-ref.c             | 38 ++++++++++++++++++++++++----------
 refs.c                         |  6 ++++++
 refs.h                         |  2 +-
 t/t1403-show-ref.sh            | 20 ++++++++++++++++++
 5 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index ba757470059..9627b34b37f 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git show-ref' [--head] [-d | --dereference]
 	     [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags]
-	     [--heads] [--] [<pattern>...]
+	     [--heads] [--symbolic-name] [--] [<pattern>...]
 'git show-ref' --verify [-q | --quiet] [-d | --dereference]
 	     [-s | --hash[=<n>]] [--abbrev[=<n>]]
 	     [--] [<ref>...]
@@ -58,6 +58,11 @@ OPTIONS
 	Dereference tags into object IDs as well. They will be shown with `^{}`
 	appended.
 
+--symbolic-name::
+
+	Print out the value the reference points to without dereferencing. This
+	is useful to know the reference that a symbolic ref is pointing to.
+
 -s::
 --hash[=<n>]::
 
@@ -146,6 +151,20 @@ $ git show-ref --heads --hash
 ...
 -----------------------------------------------------------------------------
 
+When using `--symbolic-name`, the output is in the format:
+
+-----------
+<oid> SP <ref> SP <symbolic-name>
+-----------
+
+For example,
+
+-----------------------------------------------------------------------------
+$ git show-ref --symbolic-name
+b75428bae1d090f60bdd4b67185f814bc8f0819d refs/heads/SYMBOLIC_REF ref:refs/heads/main
+...
+-----------------------------------------------------------------------------
+
 EXAMPLES
 --------
 
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index 1c15421e600..1d681505eac 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -12,7 +12,7 @@
 static const char * const show_ref_usage[] = {
 	N_("git show-ref [--head] [-d | --dereference]\n"
 	   "             [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags]\n"
-	   "             [--heads] [--] [<pattern>...]"),
+	   "             [--heads] [--symbolic-name] [--] [<pattern>...]"),
 	N_("git show-ref --verify [-q | --quiet] [-d | --dereference]\n"
 	   "             [-s | --hash[=<n>]] [--abbrev[=<n>]]\n"
 	   "             [--] [<ref>...]"),
@@ -26,10 +26,13 @@ struct show_one_options {
 	int hash_only;
 	int abbrev;
 	int deref_tags;
+	int symbolic_name;
 };
 
 static void show_one(const struct show_one_options *opts,
-		     const char *refname, const struct object_id *oid)
+		     const char *refname,
+		     const char *referent,
+		     const struct object_id *oid, const int is_symref)
 {
 	const char *hex;
 	struct object_id peeled;
@@ -44,7 +47,9 @@ static void show_one(const struct show_one_options *opts,
 	hex = repo_find_unique_abbrev(the_repository, oid, opts->abbrev);
 	if (opts->hash_only)
 		printf("%s\n", hex);
-	else
+	else if (opts->symbolic_name & is_symref) {
+		printf("%s %s ref:%s\n", hex, refname, referent);
+	} else
 		printf("%s %s\n", hex, refname);
 
 	if (!opts->deref_tags)
@@ -63,8 +68,11 @@ struct show_ref_data {
 	int show_head;
 };
 
-static int show_ref(const char *refname, const struct object_id *oid,
-		    int flag UNUSED, void *cbdata)
+static int show_ref_referent(struct repository *repo UNUSED,
+			     const char *refname,
+			     const char *referent,
+			     const struct object_id *oid,
+			     int flag, void *cbdata)
 {
 	struct show_ref_data *data = cbdata;
 
@@ -91,11 +99,17 @@ static int show_ref(const char *refname, const struct object_id *oid,
 match:
 	data->found_match++;
 
-	show_one(data->show_one_opts, refname, oid);
+	show_one(data->show_one_opts, refname, referent, oid, flag & REF_ISSYMREF);
 
 	return 0;
 }
 
+static int show_ref(const char *refname, const struct object_id *oid,
+		    int flag, void *cbdata)
+{
+	return show_ref_referent(NULL, refname, NULL, oid, flag, cbdata);
+}
+
 static int add_existing(const char *refname,
 			const struct object_id *oid UNUSED,
 			int flag UNUSED, void *cbdata)
@@ -171,10 +185,11 @@ static int cmd_show_ref__verify(const struct show_one_options *show_one_opts,
 
 	while (*refs) {
 		struct object_id oid;
+		int flags = 0;
 
 		if ((starts_with(*refs, "refs/") || refname_is_safe(*refs)) &&
-		    !read_ref(*refs, &oid)) {
-			show_one(show_one_opts, *refs, &oid);
+		    !read_ref_full(*refs, 0, &oid, &flags)) {
+			show_one(show_one_opts, *refs, NULL, &oid, flags & REF_ISSYMREF);
 		}
 		else if (!show_one_opts->quiet)
 			die("'%s' - not a valid ref", *refs);
@@ -208,11 +223,11 @@ static int cmd_show_ref__patterns(const struct patterns_options *opts,
 		head_ref(show_ref, &show_ref_data);
 	if (opts->heads_only || opts->tags_only) {
 		if (opts->heads_only)
-			for_each_fullref_in("refs/heads/", show_ref, &show_ref_data);
+			for_each_ref_all("refs/heads/", show_ref_referent, &show_ref_data);
 		if (opts->tags_only)
-			for_each_fullref_in("refs/tags/", show_ref, &show_ref_data);
+			for_each_ref_all("refs/tags/", show_ref_referent, &show_ref_data);
 	} else {
-		for_each_ref(show_ref, &show_ref_data);
+		for_each_ref_all("", show_ref_referent, &show_ref_data);
 	}
 	if (!show_ref_data.found_match)
 		return 1;
@@ -289,6 +304,7 @@ int cmd_show_ref(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "tags", &patterns_opts.tags_only, N_("only show tags (can be combined with heads)")),
 		OPT_BOOL(0, "heads", &patterns_opts.heads_only, N_("only show heads (can be combined with tags)")),
 		OPT_BOOL(0, "exists", &exists, N_("check for reference existence without resolving")),
+		OPT_BOOL(0, "symbolic-name", &show_one_opts.symbolic_name, N_("print out symbolic reference values")),
 		OPT_BOOL(0, "verify", &verify, N_("stricter reference checking, "
 			    "requires exact ref path")),
 		OPT_HIDDEN_BOOL('h', NULL, &patterns_opts.show_head,
diff --git a/refs.c b/refs.c
index 77ae38ea214..9488ad9594d 100644
--- a/refs.c
+++ b/refs.c
@@ -1734,6 +1734,12 @@ int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_dat
 				    DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
+int for_each_ref_all(const char *prefix, each_repo_ref_fn fn, void *cb_data)
+{
+	return do_for_each_repo_ref(the_repository, prefix, fn, 0,
+				    0, cb_data);
+}
+
 int for_each_namespaced_ref(const char **exclude_patterns,
 			    each_ref_fn fn, void *cb_data)
 {
diff --git a/refs.h b/refs.h
index 23e5aaba2e9..54b459375be 100644
--- a/refs.h
+++ b/refs.h
@@ -337,7 +337,6 @@ int refs_for_each_branch_ref(struct ref_store *refs,
 			     each_ref_fn fn, void *cb_data);
 int refs_for_each_remote_ref(struct ref_store *refs,
 			     each_ref_fn fn, void *cb_data);
-
 /* just iterates the head ref. */
 int head_ref(each_ref_fn fn, void *cb_data);
 
@@ -381,6 +380,7 @@ int for_each_tag_ref(each_ref_fn fn, void *cb_data);
 int for_each_branch_ref(each_ref_fn fn, void *cb_data);
 int for_each_remote_ref(each_ref_fn fn, void *cb_data);
 int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data);
+int for_each_ref_all(const char *prefix, each_repo_ref_fn fn, void *cb_data);
 
 /* iterates all refs that match the specified glob pattern. */
 int for_each_glob_ref(each_ref_fn fn, const char *pattern, void *cb_data);
diff --git a/t/t1403-show-ref.sh b/t/t1403-show-ref.sh
index 33fb7a38fff..0aebe709dca 100755
--- a/t/t1403-show-ref.sh
+++ b/t/t1403-show-ref.sh
@@ -286,4 +286,24 @@ test_expect_success '--exists with existing special ref' '
 	git show-ref --exists FETCH_HEAD
 '
 
+test_expect_success '--symbolic-name with a non symbolic ref' '
+	commit_oid=$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME) &&
+	cat >expect <<-EOF &&
+	$commit_oid refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+	EOF
+	git show-ref --symbolic-name refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--symbolic-name with symbolic ref' '
+	test_when_finished "git symbolic-ref -d refs/heads/SYMBOLIC_REF_A" &&
+	commit_oid=$(git rev-parse refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME) &&
+	cat >expect <<-EOF &&
+	$commit_oid refs/heads/SYMBOLIC_REF_A ref:refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+	EOF
+	git symbolic-ref refs/heads/SYMBOLIC_REF_A refs/heads/$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME &&
+	git show-ref --symbolic-name SYMBOLIC_REF_A >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
