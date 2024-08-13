Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AB717C7CA
	for <git@vger.kernel.org>; Tue, 13 Aug 2024 09:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723540405; cv=none; b=ZwHfIhFaCO9B7aDUQJafErbOVYdDauFZzjLxGMRXTTAFnUxmvDiQYJSCEd8erFYi7ulT4XqDewFPowrkrzRea+53eGIOufDuzWF1pxQoS8bYpltLb30lL4/3GbABT5+S4wS3Ibp5YIV21apiallD3hqwEjsq4IzsdOyNkd7nxEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723540405; c=relaxed/simple;
	bh=KZ1JrdbvsgRTo49Dn6byy63cMfHyrITqzuXt3eisQkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+quQ9ijjVOy46qkNNegPdorjwVxYxdk/3w6cWDn2jbBGqpeOsS9R99+HLilf/x7oyuV7AD53Ooy4/txrLkh7bisgo/Yob2vq4ZaEjV9+bA66zcCChd6QXV91m/8mYzL33hYNXAULKpGR2m0wj18dSH+NEUaHk6hP1Uf99+4dOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BFRoZtKS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XwxbO5s6; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BFRoZtKS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XwxbO5s6"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 29D62138FBA9;
	Tue, 13 Aug 2024 05:13:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 13 Aug 2024 05:13:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723540403; x=1723626803; bh=Wvof6QhJ4i
	k3v/hMXbSPJmemQOiJiInu0GlWaHo5PPo=; b=BFRoZtKSDb8daMw3S23CP7vuGE
	7qzLbWo7EZ1OJlxena7zF0ILZVxGgwfxOgBuCU072z2ROCpQ1hkK6LfABGZrtDZ+
	Y4FCavNpKiJ0UZ23oei1+NoChEW+UPpee8XnPGJvsqviFR7cdsMRV/eORZm2HlbM
	idfrNWG195xjbjd4Lctedoq+PwswFeX1Gk8kypjcJ7+1PU4l6dHuagRhJ05J8p9g
	kRM658BM1jsJnuGCM950eUXQKmK5oFftVMz2vUE7mmtwnMzDjb7TrxsKEyARFMoW
	PVHyWjHIM4Fq6z0Mf2ehSmrFGdU+NZXYtKFeud2H4l6dPYG90LkytYKOs+Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723540403; x=1723626803; bh=Wvof6QhJ4ik3v/hMXbSPJmemQOiJ
	iInu0GlWaHo5PPo=; b=XwxbO5s6WJ7bYH9lAREgu4ty5eyTWkLp8o8nctr9MgVg
	+vVICiROsqpRqgP0hpSHAnsD+eF9EX7RIyGUeFJj4w4ifBAQHmvQSgdYpO61RJ+l
	qm/dXv+VhFqmY0ok1Ltqb9wHN02pEBDZEO5LydfRCmVdXBvP7v+dA/99kgKqLjZS
	jHklHGQXrx4Tv7yWT6mTxHgznN9KBeluB793G86L3p25727ws2QdSKEkqWE0L0rg
	3ZJgO+Lo4Dj+FdHq1bwjbdbA7M5xoOvQJjb2L4+y2ZN9DhKP9uh4+QWCwquj7xUB
	KARFOWU5ue2Qr6Ra0qMKvmKxj9kEBx+63ZLPPUUwzA==
X-ME-Sender: <xms:syO7ZljnTKrXx-TX3gg08LzSgDyL51mBn3wL6hQT18jczMy6e31W3A>
    <xme:syO7ZqCsrXcXUdbZTL7tVFbXm6BK0ubowjNJmLocCI00Bq6NMi7yJLr8PeEk7LVwt
    xH8gdWCMIDDILBPQg>
X-ME-Received: <xmr:syO7ZlGY6tjY0oDXW-PX7AJTwgwRafeYHcLAB7k4Mx6dOV3ZSRNt6vBoHs3Kq6G-CLYi7UXWRy6XXGM-6RIETxb414vdKOSFiB_brTSmpfWoBA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtvddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:syO7ZqQMSw6EilJoCLXbheBNCCmSRrnXlnaRWMagqBM38D8ze1m4yg>
    <xmx:syO7Zix-w55hWWTnLv-2X2EX4BkT3eEk4XGo0bHl5HIABxNm0A_uyw>
    <xmx:syO7Zg7dDjaZxPASFPF_27wnqBXuKhr9iJaBfygrt0QePgyhP0W3Bw>
    <xmx:syO7ZnxEdL6tTL6H7GaSifm3_JSmnHF8CNbd5G4x7ck-QSt6AxCVUg>
    <xmx:syO7Zm-W5L2SBbhMw9M2qZebZkKXxRt3KJCQW4gQpWivSqBcYrunuZuP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Aug 2024 05:13:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fed6a4da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Aug 2024 09:13:05 +0000 (UTC)
Date: Tue, 13 Aug 2024 11:13:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 01/20] path: expose `do_git_path()` as `repo_git_pathv()`
Message-ID: <d0f5f2b17f2514cfb4b96761bcc9d677dc168752.1723540226.git.ps@pks.im>
References: <cover.1723013714.git.ps@pks.im>
 <cover.1723540226.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723540226.git.ps@pks.im>

We're about to move functions of the "path" subsytem that do not use a
`struct repository` into "path.h" as static inlined functions. This will
require us to call `do_git_path()`, which is internal to "path.c".

Expose the function as `repo_git_pathv()` to prepare for the change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 path.c | 20 ++++++++++----------
 path.h |  8 ++++++++
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/path.c b/path.c
index 19f7684f38..71f1cb4dfb 100644
--- a/path.c
+++ b/path.c
@@ -417,9 +417,9 @@ static void strbuf_worktree_gitdir(struct strbuf *buf,
 		strbuf_git_common_path(buf, repo, "worktrees/%s", wt->id);
 }
 
-static void do_git_path(const struct repository *repo,
-			const struct worktree *wt, struct strbuf *buf,
-			const char *fmt, va_list args)
+void repo_git_pathv(const struct repository *repo,
+		    const struct worktree *wt, struct strbuf *buf,
+		    const char *fmt, va_list args)
 {
 	int gitdir_len;
 	strbuf_worktree_gitdir(buf, repo, wt);
@@ -438,7 +438,7 @@ char *repo_git_path(const struct repository *repo,
 	struct strbuf path = STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(repo, NULL, &path, fmt, args);
+	repo_git_pathv(repo, NULL, &path, fmt, args);
 	va_end(args);
 	return strbuf_detach(&path, NULL);
 }
@@ -449,7 +449,7 @@ void strbuf_repo_git_path(struct strbuf *sb,
 {
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(repo, NULL, sb, fmt, args);
+	repo_git_pathv(repo, NULL, sb, fmt, args);
 	va_end(args);
 }
 
@@ -458,7 +458,7 @@ char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
 	va_list args;
 	strbuf_reset(buf);
 	va_start(args, fmt);
-	do_git_path(the_repository, NULL, buf, fmt, args);
+	repo_git_pathv(the_repository, NULL, buf, fmt, args);
 	va_end(args);
 	return buf->buf;
 }
@@ -467,7 +467,7 @@ void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
 {
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(the_repository, NULL, sb, fmt, args);
+	repo_git_pathv(the_repository, NULL, sb, fmt, args);
 	va_end(args);
 }
 
@@ -476,7 +476,7 @@ const char *git_path(const char *fmt, ...)
 	struct strbuf *pathname = get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(the_repository, NULL, pathname, fmt, args);
+	repo_git_pathv(the_repository, NULL, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
@@ -486,7 +486,7 @@ char *git_pathdup(const char *fmt, ...)
 	struct strbuf path = STRBUF_INIT;
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(the_repository, NULL, &path, fmt, args);
+	repo_git_pathv(the_repository, NULL, &path, fmt, args);
 	va_end(args);
 	return strbuf_detach(&path, NULL);
 }
@@ -517,7 +517,7 @@ const char *worktree_git_path(const struct worktree *wt, const char *fmt, ...)
 	struct strbuf *pathname = get_pathname();
 	va_list args;
 	va_start(args, fmt);
-	do_git_path(the_repository, wt, pathname, fmt, args);
+	repo_git_pathv(the_repository, wt, pathname, fmt, args);
 	va_end(args);
 	return pathname->buf;
 }
diff --git a/path.h b/path.h
index a6f0b70692..94e7030f0b 100644
--- a/path.h
+++ b/path.h
@@ -66,6 +66,14 @@ char *repo_git_path(const struct repository *repo,
 		    const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
 
+/*
+ * Print a path into the git directory of repository `repo` into the provided
+ * buffer.
+ */
+void repo_git_pathv(const struct repository *repo,
+		    const struct worktree *wt, struct strbuf *buf,
+		    const char *fmt, va_list args);
+
 /*
  * Construct a path into the git directory of repository `repo` and append it
  * to the provided buffer `sb`.
-- 
2.46.0.46.g406f326d27.dirty

