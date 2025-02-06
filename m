Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106E522541D
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828690; cv=none; b=Zrm8XiXsOh4SN9c4awhcnZffzvjpqbIg5MRpqclYCQ7PbjKvRs6znVabD68dVDRB0niruv6g3AzasQFyOVBcSXQ0mA4TwUWjEOQ0IsWV92GYmDXrxGJ3t2H43TT1ZvFuWLvZKwHcIdyTaxVcPukn/0xSHVNIA3BMB9dyaAnDwmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828690; c=relaxed/simple;
	bh=jLEdGZkhkbdWpSgNH+ZSjO1jGeQTsOignvSRW3qXP9Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O33qNpUUC3M+J5By+i5hfR//Exjpq4PYPhrof3DM7fGE6z80j8az+7deZ725FdHlHW8k2mLTyocfyLG2IEINUjOcCzEsU/A1FrFodKtALwW4OicscHviOKjHqSN7t5FoVCS8U8gJIxwyypTIFnieqfvgqDp4FjG8KtkEu1IuVmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ONs5wYsJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lLnoYhQ2; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ONs5wYsJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lLnoYhQ2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 1E1D4138020B
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 02:58:08 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 06 Feb 2025 02:58:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828688;
	 x=1738915088; bh=LWAzIAf9AxWMZE/jNjjsQDhD3YVzjC/XRE+Yhv32EAo=; b=
	ONs5wYsJKabEDko+hOD1npJv9/H1Joglu0L9Wr8R3tJIYMJ2g0UknhBRPJZjwwxm
	IiyFCVgDSAj8nRi+AmUywwfv/bS9oCA9kp7q3Tfe4vAjOn1gEpS8BSj1VClHyYV6
	y5ynh7lJT9rPcA7PoNGWm96fmb6Yj84lSu1t+THUlx+DnJ5J46u6aGhJWdlcJ8GK
	VGEORsJrWIm9dzZcmT3P7rMQ+kg1ynX+p7EyJYxXDNfwZffy0ZrGX1sWhBlMblib
	f7mSNNtdfzCkyZC025SW6l8n0O2jMQuE611R68bv42vAJSS3Gei0N+lYqxDxqsHD
	3GjzIStYLoLrsafAa71BAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828688; x=
	1738915088; bh=LWAzIAf9AxWMZE/jNjjsQDhD3YVzjC/XRE+Yhv32EAo=; b=l
	LnoYhQ2YUZLY3B+jTu10Fw118ZshzTMTdZAYaGD0wJohxxxkvHiOkoyHZ/IgORuH
	4En45PanQzo8REoorK/c8fjKqa7vVH2vm3ntrcgFP5etHOqV24OtTEU/wPd08wBQ
	43VxTVcR3gULgydWxW7oCMkLodaOfMBPp5pAitneEDLtdau0M5ILK+dY48Rs7Qea
	9UCClW8R2/ckbY3u1APlUYnPAtC6reLT2cjGKa0L1DIJx6C92076J/EdmzIrR3SL
	4m/o2YUfJeTPtccImBprT7ZCvemaFdlV6MAU0cfIL9FuoeKR55czXdKFJnPOybmw
	ByMdw6GWkKrLBZrBha1qQ==
X-ME-Sender: <xms:j2ukZwyhKC0CICXGILt6hgZ5E6IFY3U7Wx9DwiHSKO0ROQQxA8LQMA>
    <xme:j2ukZ0R2A-JQweX2oSrmxazIdBEhKsTUD9mIG9lU6p1_DUw6gxuWHp67p5G3B48Bw
    e0Odg_lQax3AQd66A>
X-ME-Received: <xmr:j2ukZyXLyk2UbLNBudc155KrYh8cmlHGOvWFacIzugH2KLPu5fiQ4tsaw31A3HzLliEgM7kMBYBPLVFmcx_Lxy9N1fYcjZ_4yc8-dojggycr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:j2ukZ-go2_Ky4hqO_SHTo1gOBsovofB8D78EZS6M-pSxewyjzOGLdw>
    <xmx:kGukZyCfNHA95TGdGwiMjC8z8QXcl-GrasC2TrgQFxfFdJddkwidRw>
    <xmx:kGukZ_Icxf__6i9s7Doqh20yQEnrk15kkZJ-86Glv52Lrg1rNdoEhQ>
    <xmx:kGukZ5BQpPzobE93MHn4doFGH1vj7LDd5qEPEJ9O3HUb7wK1cC9X-w>
    <xmx:kGukZz5ph4m07ULqkmCXvXCFfOAgFGSJS5HfVdlLRMj3TueLZVE6FWbU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 6 Feb 2025 02:58:07 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 74eff9cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 6 Feb 2025 07:58:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:58:00 +0100
Subject: [PATCH 04/16] submodule: refactor `submodule_to_gitdir()` to
 accept a repo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-b4-pks-path-drop-the-repository-v1-4-4e77f0313206@pks.im>
References: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
In-Reply-To: <20250206-b4-pks-path-drop-the-repository-v1-0-4e77f0313206@pks.im>
To: git@vger.kernel.org
Cc: 
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
index be75808acc..d918d0409e 100644
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

