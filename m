Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54F01DF27F
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 06:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775714498; cv=none; b=WQwMHqLALxBWfpsaWYulSGTK7V20rxF1MkmLyEqZ17RR90N1uJOoCfm2lJrpx0FAeXnEm2ACfDQgpkup49bfUfY0MEl8IwJD5cHRX8ZxPQLty2OzeEQgJe0q4h5piY8SxI8YeiqwW+wCWBbSgYqjMzMh7pU5UqNVeYmSJmF/2vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775714498; c=relaxed/simple;
	bh=uET5pxy2zK7aTOfTOU98QUCsvPG0bj30oHySg1hx+ow=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=o/MDX63ovHePf7a2m2rQ+DGMZYSWqQk0WpCw1RTUFFlCCnJ17rPzALbnnl+stip5PD7W3yWOlIiV5nlSa41A3v5Aj5BuQ2j/tIEOWTPzy3aHe+nAGKxPWNSeLJ0d1wU9BoMwWrcaysdN9gEtSm9vsdbnC2AxKApB4MrJiSi43DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TigRPm+v; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TigRPm+v"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2c156c4a9efso501952eec.1
        for <git@vger.kernel.org>; Wed, 08 Apr 2026 23:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775714495; x=1776319295; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FIh2u611WLOKsXYTBXC19FmcovVSGhubEeYU8kNhdDc=;
        b=TigRPm+vxx2y4Vh0DLcb6Dl+0ADblwZgU3qwszEBBP6u9j8vIVgRhi54EwXT0CWHOA
         LrMNmCHw5WSSoIbQ56eAxQAmf98SdAy00xt2IDbFLS+Xp/DlQrVu5pn06zjR6OYeQp3R
         F/V6wZZw4QDmF7/v+mL9dOfJQOMps9E2Zi/3vz5b3X6pmlNOhGL7MRz6tVC4Q+XE3zQ6
         rGVMg+fFsFdo3K2Wk4DUxscVH+KcUkUC7YxzTPU2PqQnMZx6i1FQQCK/D6giP82chnIV
         o1Qd5mZY+wMGresJmS9xFB2908uyQ0qgl7Bzh5PIpa9rDdtpmqtWI1luAwuHYowziky/
         V+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775714495; x=1776319295;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FIh2u611WLOKsXYTBXC19FmcovVSGhubEeYU8kNhdDc=;
        b=sdIz0YGtkRJ9km04niV3gj+dWBxSsSye4BuxgmWuBkdGi7bN5zc96k8ldr26T8oGP3
         Fn0vHnyKwJAyIixOLU9cw3kLiS7mcWlB+K7OdE6p1oi58bh3HIw4w65oqM4eCoecPTnW
         ELfH3A7bjegwEt8BBsB3yVZ0/LRqShGID8dvOX+qaQPG6OeZ/W+YCVWdMpLhm3hf3/xG
         jT6VStCnXH4LeQY9Lj+m+5WdCVIZto1+3yIVLiqryHo+zCG74WJ+F0qRn27eLS9avIJH
         2fbkkaAaTRfVZ0R9ElsgGoqgIA5LIXOtPV3H7q7sVHxsKR60QdR8jBN3sjsG3TN2mVqt
         YRVA==
X-Gm-Message-State: AOJu0YzL4NSzLK6cP4qiELWUks8glutGuS8E0xKzbuY6TCSbMs6rPl0G
	1xJGBOopNYxW+5OIenJDMcfQa/XVPz9k0C8SvJhAzU8aFdR0I6xea9tDUIKKzA==
X-Gm-Gg: AeBDievQPQUvaDlh4mdAa12kvsILZ4+Y3+3oR85dNFL+4Cn70zAqwv4lNmY+HQTlhO8
	KqSRa+qGsVTBgmr8cqis+AboQfWzWcLxvvzEbz3GAQcf3Qidzy8Dc8cd6wGNWQgrerG2EsW8pRj
	dKyuF/T2jaYxiX6StQQoyhSY+XbAUBNw8eRBHHAc4A18skbDd57af0IQApaqBzHUyXN5uYstMr5
	MBzn3EjpmVRxRpncvT2yDT9DBxgbZmPICSheHao2ns9pxqAei6GjZ8c1jQSx8Cjg/MJbp/PqzkW
	eKejjKclVcNS/D/inLRyFB0r7NTyW3TfOsheyiKJCnCbi8sk6XqrpLtj7jJAXQEDPCKHbo8VHBT
	G/l2m0ITbUICuI+hEphhnduXzmU36tNLud23oNq6xg6pPe8J2ACRBXipyFOnCeb8zIaSb4KulFT
	X6ZckIiPlNCb9GczU0zyFL1PBWJg==
X-Received: by 2002:a05:7300:7251:b0:2d4:afb3:7b05 with SMTP id 5a478bee46e88-2d4afb37ea6mr216069eec.31.1775714495088;
        Wed, 08 Apr 2026 23:01:35 -0700 (PDT)
Received: from [127.0.0.1] ([128.24.163.81])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d1e4ad4cc7sm9375856eec.7.2026.04.08.23.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 23:01:34 -0700 (PDT)
Message-Id: <pull.2264.v3.git.git.1775714492944.gitgitgadget@gmail.com>
In-Reply-To: <pull.2264.v2.git.git.1775668134796.gitgitgadget@gmail.com>
References: <pull.2264.v2.git.git.1775668134796.gitgitgadget@gmail.com>
From: "Jayesh Daga via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Apr 2026 06:01:32 +0000
Subject: [PATCH v3] repo: add paths.toplevel to repo info
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
Cc: Derrick Stolee <stolee@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>,
    Jayesh Daga <jayeshdaga99@gmail.com>

From: Jayesh Daga <jayeshdaga99@gmail.com>

repo info currently does not expose the repository's
working tree root, even though this information is
available via `repo_get_work_tree()` and
`git rev-parse --show-toplevel`.

Add a new field `paths.toplevel` to expose this value.

While doing so, document the correspondence between
`git rev-parse` options and `repo info` fields to make
it easier to identify missing or future additions.

For bare repositories, this value is empty, consistent
with other non-applicable fields.

Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com
---
    repo: add paths.toplevel to repo info
    
    repo info currently does not expose the repository's working tree root,
    even though this information is available via repo_get_work_tree().
    
    This makes it harder for scripts to retrieve the repository root through
    a structured interface, often requiring the use of git rev-parse
    --show-toplevel.
    
    Add a new field paths.toplevel to git repo info that returns the working
    tree root. For bare repositories, this value is empty, consistent with
    other non-applicable fields.
    
    This provides a consistent and script-friendly way to query repository
    paths without invoking additional commands.
    
    Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2264%2Fjayesh0104%2Frepo-toplevel-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2264/jayesh0104/repo-toplevel-v3
Pull-Request: https://github.com/git/git/pull/2264

Range-diff vs v2:

 1:  05e34bfe2c ! 1:  8a58b6ce03 repo: add paths.toplevel to repo info
     @@ Commit message
          For bare repositories, this value is empty, consistent
          with other non-applicable fields.
      
     -    Signed-off-by: Jayesh Daga [jayeshdaga99@gmail.com](mailto:jayeshdaga99@gmail.com)
     +    Signed-off-by: Jayesh Daga jayeshdaga99@gmail.com
      
       ## builtin/repo.c ##
      @@ builtin/repo.c: static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
     @@ builtin/repo.c: static int get_layout_bare(struct repository *repo UNUSED, struc
       
      +static int get_paths_toplevel(struct repository *repo, struct strbuf *buf)
      +{
     -+    const char *wt = repo_get_work_tree(repo);
     ++	const char *wt = repo_get_work_tree(repo);
      +
     -+    if (!wt)
     -+	return -1; /* match existing error style */
     ++	if (!wt)
     ++		return -1; /* match existing error style */
      +
     -+    strbuf_addstr(buf, wt);
     -+    return 0;
     ++	strbuf_addstr(buf, wt);
     ++	return 0;
      +}
      +
       static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
       {
       	strbuf_addstr(buf,
     -@@ builtin/repo.c: static const struct repo_info_field repo_info_field[] = {
     +@@ builtin/repo.c: static int get_references_format(struct repository *repo, struct strbuf *buf)
     + 	return 0;
     + }
     + 
     ++/*
     ++ * rev-parse --<opt>        repo info <field>
     ++ *
     ++ * is-bare-repository      layout.bare
     ++ * is-shallow-repository   layout.shallow
     ++ * show-object-format      object.format
     ++ * show-ref-format         references.format
     ++ * show-toplevel           paths.toplevel
     ++ *
     ++ * show-cdup               <missing>
     ++ * show-prefix             <missing>
     ++ *
     ++ * Some <missing> entries may be candidates for future
     ++ * implementation, while others may not be needed.
     ++ */
     ++
     + /* repo_info_field keys must be in lexicographical order */
     + static const struct repo_info_field repo_info_field[] = {
       	{ "layout.bare", get_layout_bare },
       	{ "layout.shallow", get_layout_shallow },
       	{ "object.format", get_object_format },


 builtin/repo.c       | 28 ++++++++++++++++++++++++++++
 t/t1900-repo-info.sh | 16 ++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/builtin/repo.c b/builtin/repo.c
index 71a5c1c29c..8c9afc1150 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -62,6 +62,17 @@ static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
 	return 0;
 }
 
+static int get_paths_toplevel(struct repository *repo, struct strbuf *buf)
+{
+	const char *wt = repo_get_work_tree(repo);
+
+	if (!wt)
+		return -1; /* match existing error style */
+
+	strbuf_addstr(buf, wt);
+	return 0;
+}
+
 static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -82,11 +93,28 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 	return 0;
 }
 
+/*
+ * rev-parse --<opt>        repo info <field>
+ *
+ * is-bare-repository      layout.bare
+ * is-shallow-repository   layout.shallow
+ * show-object-format      object.format
+ * show-ref-format         references.format
+ * show-toplevel           paths.toplevel
+ *
+ * show-cdup               <missing>
+ * show-prefix             <missing>
+ *
+ * Some <missing> entries may be candidates for future
+ * implementation, while others may not be needed.
+ */
+
 /* repo_info_field keys must be in lexicographical order */
 static const struct repo_info_field repo_info_field[] = {
 	{ "layout.bare", get_layout_bare },
 	{ "layout.shallow", get_layout_shallow },
 	{ "object.format", get_object_format },
+	{ "paths.toplevel", get_paths_toplevel },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index 39bb77dda0..470e06e8c2 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -155,4 +155,20 @@ test_expect_success 'git repo info -h shows only repo info usage' '
 	test_grep ! "git repo structure" actual
 '
 
+test_expect_success 'repo info paths.toplevel' '
+    git repo info paths.toplevel >actual &&
+    echo "paths.toplevel=$(git rev-parse --show-toplevel)" >expected &&
+    test_cmp expected actual
+'
+
+test_expect_success 'repo info paths.toplevel (bare repo)' '
+    git init --bare bare.git &&
+    (
+	cd bare.git &&
+	git repo info paths.toplevel >actual &&
+	echo "paths.toplevel=" >expected &&
+	test_cmp expected actual
+    )
+'
+
 test_done

base-commit: 256554692df0685b45e60778b08802b720880c50
-- 
gitgitgadget
