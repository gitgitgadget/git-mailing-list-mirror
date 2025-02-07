Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E291DE4CD
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738926218; cv=none; b=iACZQ9mcWghUpjWhfoVfDEHou8j+nnXoJhj6EyS39ONazcabsVioa6bHvv/0QQoEbGmMFmkH2QxP8+4ZF3n7dsY4X++B+PYlkkcs6Lvel5QOGvcwVIdjF04/8EQVLc1Lvy6JRVZwALfkZc4s9wUqhSkfBxYtePM2D1IHXbuUIWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738926218; c=relaxed/simple;
	bh=6uIRRnfv0GRzIe3oYm5MhHcsBq96JYRlRrOGALCc3ho=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QtZ5kjJeP60khqiL0zkDGerKNWPZz9SkwT4EhQLiOKmzYLYS/Jf4u2Fpl1YcUgqwK1P4BzA9fqf1foH4RJp6M2E3UI+EKQe+wSlkKaeqBGp+1WBLECDtOMSaJivpRyUgzLoyWiUBljCHF90Gxaxumh2CVljAQCk9PZ/zgx3T/BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A+r3iA4H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AKgWkYDp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A+r3iA4H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AKgWkYDp"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 35B06114016D;
	Fri,  7 Feb 2025 06:03:35 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 07 Feb 2025 06:03:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738926215;
	 x=1739012615; bh=NNDYvZ+qW4z1ReT+5yjQCacO6o2TO3yyu7Jk7AQIcSQ=; b=
	A+r3iA4HZEy9OKIZ5k0VjCZ1ZiYaLrEAol48ysy1V5r6cs6IvFOZKpL79twvdxQe
	gBOesit/RC7/gjSyRaXUXZ6+H5WfVCVd2t6YkOuGQ9aLlfA+4xeSDMiN7puu+UK0
	U17or3afpgcXZUttMhd34TQ0sex1A8XzS663WkLq5mORldSNeay5z8AMg6G93OS8
	JgAbcdvD8e/g3m9NYXgcdtl2nt4jg30tnAFuGpl8tVuRoLSshKT/9sVQ7zGV8tF7
	iuuRVQaEHnpXXZROL9AVnS8/zgoqzaXaGpchn7R1hEQX5RbxS9C+3muxnJpOQSSs
	NU5gW8Bl6LIqfCHcBN0ObA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738926215; x=
	1739012615; bh=NNDYvZ+qW4z1ReT+5yjQCacO6o2TO3yyu7Jk7AQIcSQ=; b=A
	KgWkYDprnL6keZe9nQvFWOnsJgUDuqJ9eRIZJj4FqlRS7a4gt7LPFQkzauzOF/ea
	N9i9/pdK18W7cC1z1KUICr9e7HXamet6QksstsbHQoqISy4xhjJYtfhycJ8/6tq2
	pWPegZl2Ny/3Ag3K0q6YAxbdpSg6QILLIu4B39diqdGFE/sRv4MIFHWlCoDlqQUS
	YXn6Sl7Fkja16Wz9y6X8kVJ5ip7owq8tLFeLcQLPv6GxQwG9w8M44q1so41ZKpiy
	z+6LioxZPH5z8sD3sD2bnGz8BGk46F0Rh56mFsXwjdkhkmhiKVLF/iytxSlRxG+/
	BbH5MFdtjFGPCqLY8IUnA==
X-ME-Sender: <xms:h-ilZ2Ou05_4CpMeOi54j2peIXjmmx_jG1Qa7T6Y-AtA2e4Lgln9Cw>
    <xme:h-ilZ09OCCHcmP5Mv48wCEm2NlImr9Od2Nrp3OXAZjjXQ6JIj13af8qgxoFVfv5SK
    1Nae4vHVUIGlj-2ng>
X-ME-Received: <xmr:h-ilZ9SpGDE9qriXtqDlXGUM54XzDDFykp04I4DHdqd7w9IGmRvs4PbaQXTLPghGBWS1G8plnpWBl37uxTOmW7gbVUw8-LMAWxe_akQm0NcI2nu2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:h-ilZ2szaLy9rijPKdApNnUrz9HT4T6UJ4W2bDCAuz406KsyHePDdA>
    <xmx:h-ilZ-fKd0OIDjrnKGYn2Vw6RC3Z5yvgHdJXi08CPGk7PLfA1mD2Uw>
    <xmx:h-ilZ62KJzp2jXvabp8vYI60G1I-lxni-60y2pSy89s8ux40WA67dQ>
    <xmx:h-ilZy8Lh5n5PIsalBH9lRaChUGG-UytmbAD8mQHJvP9xWkW3aZTlA>
    <xmx:h-ilZ-6443G9GSk0joYH6MFX4dEWbxH6NAsMWN6hq8g2w2iCkSlijHem>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:03:34 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec14744a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:03:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Feb 2025 12:03:29 +0100
Subject: [PATCH v2 04/16] submodule: refactor `submodule_to_gitdir()` to
 accept a repo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250207-b4-pks-path-drop-the-repository-v2-4-13cad3c11b8a@pks.im>
References: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
In-Reply-To: <20250207-b4-pks-path-drop-the-repository-v2-0-13cad3c11b8a@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, shejialuo <shejialuo@gmail.com>
X-Mailer: b4 0.14.2

The `submodule_to_gitdir()` function implicitly uses `the_repository` to
resolve submodule paths. Refactor the function to instead accept a repo
as parameter to remove the dependency on global state.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/submodule--helper.c |  2 +-
 path.c                      |  2 +-
 refs.c                      |  2 +-
 submodule.c                 | 11 ++++++-----
 submodule.h                 |  3 ++-
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f9b970f8a6..3a64f7e605 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1301,7 +1301,7 @@ static void sync_submodule(const char *path, const char *prefix,
 	remote_key = xstrfmt("remote.%s.url", default_remote);
 	free(default_remote);
 
-	submodule_to_gitdir(&sb, path);
+	submodule_to_gitdir(the_repository, &sb, path);
 	strbuf_addstr(&sb, "/config");
 
 	if (git_config_set_in_file_gently(sb.buf, remote_key, NULL, sub_origin_url))
diff --git a/path.c b/path.c
index 499116dd1e..a7fa42162e 100644
--- a/path.c
+++ b/path.c
@@ -567,7 +567,7 @@ static int do_submodule_path(struct strbuf *buf, const char *path,
 	struct strbuf git_submodule_dir = STRBUF_INIT;
 	int ret;
 
-	ret = submodule_to_gitdir(&git_submodule_dir, path);
+	ret = submodule_to_gitdir(the_repository, &git_submodule_dir, path);
 	if (ret)
 		goto cleanup;
 
diff --git a/refs.c b/refs.c
index daf6a84205..e1293e53aa 100644
--- a/refs.c
+++ b/refs.c
@@ -2146,7 +2146,7 @@ struct ref_store *repo_get_submodule_ref_store(struct repository *repo,
 	if (!is_nonbare_repository_dir(&submodule_sb))
 		goto done;
 
-	if (submodule_to_gitdir(&submodule_sb, submodule))
+	if (submodule_to_gitdir(repo, &submodule_sb, submodule))
 		goto done;
 
 	subrepo = xmalloc(sizeof(*subrepo));
diff --git a/submodule.c b/submodule.c
index 211ead54a0..0530e8cf24 100644
--- a/submodule.c
+++ b/submodule.c
@@ -536,7 +536,8 @@ static struct repository *open_submodule(const char *path)
 	struct strbuf sb = STRBUF_INIT;
 	struct repository *out = xmalloc(sizeof(*out));
 
-	if (submodule_to_gitdir(&sb, path) || repo_init(out, sb.buf, NULL)) {
+	if (submodule_to_gitdir(the_repository, &sb, path) ||
+	    repo_init(out, sb.buf, NULL)) {
 		strbuf_release(&sb);
 		free(out);
 		return NULL;
@@ -2572,7 +2573,8 @@ int get_superproject_working_tree(struct strbuf *buf)
  * Put the gitdir for a submodule (given relative to the main
  * repository worktree) into `buf`, or return -1 on error.
  */
-int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
+int submodule_to_gitdir(struct repository *repo,
+			struct strbuf *buf, const char *submodule)
 {
 	const struct submodule *sub;
 	const char *git_dir;
@@ -2592,14 +2594,13 @@ int submodule_to_gitdir(struct strbuf *buf, const char *submodule)
 		strbuf_addstr(buf, git_dir);
 	}
 	if (!is_git_directory(buf->buf)) {
-		sub = submodule_from_path(the_repository, null_oid(),
-					  submodule);
+		sub = submodule_from_path(repo, null_oid(), submodule);
 		if (!sub) {
 			ret = -1;
 			goto cleanup;
 		}
 		strbuf_reset(buf);
-		submodule_name_to_gitdir(buf, the_repository, sub->name);
+		submodule_name_to_gitdir(buf, repo, sub->name);
 	}
 
 cleanup:
diff --git a/submodule.h b/submodule.h
index 4deb1b5f84..db980c1d08 100644
--- a/submodule.h
+++ b/submodule.h
@@ -136,7 +136,8 @@ int push_unpushed_submodules(struct repository *r,
  * path of that submodule in 'buf'. Return -1 on error or when the
  * submodule is not initialized.
  */
-int submodule_to_gitdir(struct strbuf *buf, const char *submodule);
+int submodule_to_gitdir(struct repository *repo,
+			struct strbuf *buf, const char *submodule);
 
 /*
  * Given a submodule name, create a path to where the submodule's gitdir lives

-- 
2.48.1.538.gc4cfc42d60.dirty

