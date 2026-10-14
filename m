Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4326F4756CA
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 07:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791961461; cv=none; b=iUvYwfBBChzyIizwwEocAihnwk7wdIwDqN6VYQJkxihnvxrjF1aIiR93fdbnJh9PAg8cxlp7/a8OXAMdqjdty9VTTuAXOALQ8HWbGBvbHDE4KfkGxE0vRqOE1YJPb7x+5Eac0nVJ1fFgLMn5a03FfTc66xrRVF6lJNly0yIG6YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791961461; c=relaxed/simple;
	bh=eYq8shnzL+FPl0zKkczPDhs2ODzcKEhVTaoOY0bOLnc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=hB2m20xCPnTCOi7wI1qElCRwn8u5EjM6j0i4nHgT6wmd+B44LxWCtovteWjR40h5awB/aKrei0g0sqwFfUbntYDH+xkpbCukBBXZ3i4FkI9RCje9M+dwl4yMfAKOSkX8Mwmpn71AbqXLDMjBVJX8rRV7B8xu+/zv0pudEVBSkYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pemWC/2C; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pemWC/2C"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-872024e2b4eso1471650b3a.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 00:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791961460; x=1792566260; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+ER3CVJawjyw/obHz+IGHlV4yiJ9HUb0k/H7oqCWUd0=;
        b=pemWC/2Ckg1meROQA+WsQ1GSsIXdIoQP70U12jHvXreKOkC09/4CgqlhwxeZ42rCDE
         AdH+A2GTU8XzDrs3W0ChJvQGv5X5mCrlPgsBLATuReyi5dfT361qioxYnEaLTy1QN2JI
         rmwm7L9eCXFKwtPom9/AQGELbLYX220rITlGsXV9+7i0x880eox1uIhum93iY61MJZW4
         5sqbmqJPfb0rO3IVm5OlO7JIbMsP/5riGUvLVzWSfkBmHfWVXzxw8RUZwPOpRbIM+QcW
         YMJfu1qLAPy5jwWEl1IS0IPpFWgIywgTR5EX5vYf1tARa6x8Op/wN23f1E/t3gjelSgm
         9XLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791961460; x=1792566260;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ER3CVJawjyw/obHz+IGHlV4yiJ9HUb0k/H7oqCWUd0=;
        b=mZ0NTtevmeQhx/4LvutEHAWKKuALTzilMHCizKXHgtpVVQniq/kuGFsenpj8AIZjsQ
         vnyIj+hw93vd8sLV4YxGtN46lskFeegxFklI/tKGLOhVMoCXiPzNl1WKbxyIAYu71RIN
         StlVUCTsEVVNfrMrDUvikxRbdEbTa/KigfeDaPIfn3iPNgbkBq4iKdctB3yk+RGQmf+u
         OygOxPsCh1RZ/PMrrRiTXBvhy7OxbEYNQy41YNpP7RVym7Ow109rBkGxec/f7KgnfpAz
         Z5hX0OjYOwQ+s60djW+bSBRY7Z9fj/36/nJQxvh32M9DHmQYf1lHrccwMIfED1iBX5ZV
         Ljgg==
X-Gm-Message-State: AFq9FYLnlsLCHHmn+UgOhcbNGVCHU55xuu3RrLm+qvoKA7kC+a9heqyp
	gOOG+Wey4PLCKt1vgqAltu0BG+V5XQnJpdAU5e0oe5c+95/GGs9QizhK+LKnGg==
X-Gm-Gg: AYBFou3vgc/QCfbJ2vGSf4S0QdiudNj/qvaoUIx2fGi0fICB+3stt3svbhhYn5X60kT
	BHQ1SAX8uWYrdw1dMnqwwQdH47WbDIhx14CFkJOvyD0XoREZJJuizXh3xFBrbKwe9yPBXG2fKx2
	xfBe+2w/ChxtqflrnXi5mP0ktiFuwjqd1h4NTNpVJosOOipG3u+/M4n6npnofqpjW0HYM+neqTV
	tbPIP0uKHNmB9+4jP4eABVlhwdyKs1jN61JKdQ/OEijBdj0DmktuncAeHsIGciviCqj8WqYfVk2
	55TZIlokZcDfqot1d5v0vKms5vXcUwZn81HeOIYXKx9e9L3ZR42a9JfsgVt2jH0Ch3plvWyC5gh
	yiJeZb0h6PWhDpOWXaLBK4Xj0hRJeazYReSpuZHvYHvYEBQliWMSyqtLDHrWAsmyTtxxfqe5cKC
	UUgj9MTZFf2cWps3kqt6SMY7Gadn969qtAgJSkFGwQ+jcR2V9SKZARBosfjt57hnc/Bvbr/EB1N
	FE=
X-Received: by 2002:a05:6a00:189c:b0:888:85a:626c with SMTP id d2e1a72fcca58-897c3efe279mr10968360b3a.8.1791961459619;
        Wed, 14 Oct 2026 00:04:19 -0700 (PDT)
Received: from [127.0.0.1] ([52.159.140.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d805095c9sm715190b3a.51.2026.10.14.00.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 00:04:18 -0700 (PDT)
Message-Id: <50382bce7e13f318aaac4ab9c1b2a0f79ca3be68.1791961452.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
References: <pull.2412.git.git.1789829246437.gitgitgadget@gmail.com>
	<pull.2412.v9.git.git.1791961452.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 14 Oct 2026 07:04:09 +0000
Subject: [PATCH v9 2/5] fetch: extract collect_upstream_from_remote() helper
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
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When a fetch has no refspec to work from, we fall back to guessing
what to fetch: the remote's configured fetch refspec if there is one,
and separately, whether the current branch's upstream lives on this
remote. The latter is independent of the former on purpose: a narrow
refspec (for example from "git remote add -t") can leave the current
branch's own upstream uncovered, and we still need to be able to fetch
it.

That "does this branch build on this remote" check was inlined for
just the current branch. Move it into its own function,
collect_upstream_from_remote(), so the same logic can be reused for
branches other than just the current one.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/fetch.c | 23 ++++++++++++++---------
 remote.c        | 15 +++++++++++++++
 remote.h        |  9 +++++++++
 3 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index c1c65c7528..2eb58195a2 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1963,7 +1963,8 @@ static int do_fetch(struct transport *transport,
 	if (rs->nr) {
 		refspec_ref_prefixes(rs, &transport_ls_refs_options.ref_prefixes);
 	} else {
-		struct branch *branch = branch_get(NULL);
+		struct string_list tracked = STRING_LIST_INIT_DUP;
+		struct string_list_item *item;
 
 		if (transport->remote->fetch.nr) {
 			refspec_ref_prefixes(&transport->remote->fetch,
@@ -1971,14 +1972,18 @@ static int do_fetch(struct transport *transport,
 			if (follow_remote_head != FOLLOW_REMOTE_NEVER)
 				do_set_head = 1;
 		}
-		if (branch && branch_has_merge_config(branch) &&
-		    !strcmp(branch->remote_name, transport->remote->name)) {
-			int i;
-			for (i = 0; i < branch->merge_nr; i++) {
-				strvec_push(&transport_ls_refs_options.ref_prefixes,
-					    branch->merge[i]->src);
-			}
-		}
+
+		/*
+		 * The configured refspec may not cover the current
+		 * branch's upstream (e.g. a narrowed -t refspec), so
+		 * make sure we can still fetch it regardless.
+		 */
+		collect_upstream_from_remote(the_repository, &tracked,
+					      transport->remote, NULL);
+		for_each_string_list_item(item, &tracked)
+			strvec_push(&transport_ls_refs_options.ref_prefixes,
+				    item->string);
+		string_list_clear(&tracked, 0);
 
 		/*
 		 * If there are no refs specified to fetch, then we just
diff --git a/remote.c b/remote.c
index 99a086ea5a..5e980625b8 100644
--- a/remote.c
+++ b/remote.c
@@ -1884,6 +1884,21 @@ int branch_merge_matches(struct branch *branch,
 	return refname_match(branch->merge[i]->src, refname);
 }
 
+void collect_upstream_from_remote(struct repository *repo,
+				   struct string_list *tracked,
+				   struct remote *remote,
+				   const char *refname)
+{
+	struct branch *branch = repo_branch_get(repo, refname);
+
+	if (!branch_has_merge_config(branch) ||
+	    strcmp(branch->remote_name, remote->name))
+		return;
+
+	for (int i = 0; i < branch->merge_nr; i++)
+		string_list_insert(tracked, branch->merge[i]->src);
+}
+
 __attribute__((format (printf,2,3)))
 static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
diff --git a/remote.h b/remote.h
index ac485a584d..7c86c529b6 100644
--- a/remote.h
+++ b/remote.h
@@ -359,6 +359,15 @@ int branch_has_merge_config(struct branch *branch);
 
 int branch_merge_matches(struct branch *, int n, const char *);
 
+/*
+ * If refname's branch builds on remote, add its upstream on remote to
+ * tracked. A NULL refname means the current branch.
+ */
+void collect_upstream_from_remote(struct repository *repo,
+				   struct string_list *tracked,
+				   struct remote *remote,
+				   const char *refname);
+
 /* list of the remote in a group as configured */
 struct remote_group_data {
 	const char *name;
-- 
gitgitgadget

