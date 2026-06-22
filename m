Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B7238F639
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782116939; cv=none; b=UpCGMYJZLHoAjdr6G2LXYYDHhJeG6o0jVM1APaY3jq3DwlmkJzBd+4y0iKkmXz5gbBnOKT0Gt7eNMzOQUCSzxlpQZR9OcJikLoywNJoggk4E1nlpmIxWv2dHhKGgB18D3C8vaMueCYTPATmtTqk5QVp5FRAjGP2bjUw8QFU6NNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782116939; c=relaxed/simple;
	bh=TCHfZhzlcL6Xdn4e/fTZvDSqB9OVbT6BE+m4SsDT6Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EE5q9cezWgO6cmm3D2aJ45LPKgDdcqbslclG/aLzAKokniCnd8MDhujIjTM/c8zED7p4NvUMBjnRf6AJfq7gpLs2xkgtLt2rYbCzyVEQ6i96755Lw23J/IiiVqBxsxnSjcNvGxGb1zWL0e2YFDTsadiMjgAwLb4v5fvly5RD2As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KiEuksVT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PcrA9o6W; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KiEuksVT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PcrA9o6W"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B5427A018E;
	Mon, 22 Jun 2026 04:28:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 22 Jun 2026 04:28:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782116930;
	 x=1782203330; bh=RB51U7Us9vJiK1y6fkknwOUChhrVWjCAWU4RWBb42EQ=; b=
	KiEuksVTS09jOLptcNx7zKkOQWBC9pBBY9dUl32UK9d4CFc5OSfkJcxKv0yH/hu1
	Rj79juna/jLO4YqKP/7YkLQVypnkC92qlKnJf1ETObUZGVjlhtL/4GV3wV4JaiHx
	QioyH8ImuywSafqZnAMhI8+9C3l8DcmMHPV0rnjpq0ZeNJEJFyQoQ+S+8LWpadTD
	7uyoExAgI8AlfFpYficwuWVb5eAR92hzVCBIgc9TUMme7ucFgnzkCXwtxDG9szIW
	eOh3BEHltqbDUp4R3i+tVG1bPJrqCXCgqfi8YNNBqyyrxVu98HtTia+Z6neIHuQY
	VVcPiflQXaYcJi5d3Magzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782116930; x=
	1782203330; bh=RB51U7Us9vJiK1y6fkknwOUChhrVWjCAWU4RWBb42EQ=; b=P
	crA9o6Wd4lTJzwZ3nNgwIH1jii0UuPEp3pMT+lJkmf+UTD3sPEuy5DqkhYIhIOIv
	0pyUHuP7ubImzIk8LI9D1z7gmEMUDPpz/r20cAE0gv/7KXZO1haZyIeef+iiE6AN
	H/LkBTTcW0EZ6MUxHhXjAG+EwuM8OcVlpsRAq3828PPtWw15w69YQ0brXCgnbr2/
	s/zATnI3tQUWh1utcrPd8tFxiVg9AhZNv6GiKS6tEJbzt0Q49cqFe0ieRuc3MnVf
	Uz/1R0er1sgGFcQp0EWLvzYBEtDTa2UgDIGLp4W7tCfFwC/3sAdrDdKyxJ6DQwFN
	Nycn7fG5VHVjOQCQYiSYQ==
X-ME-Sender: <xms:QvI4ahJz7oYXqjrXsHj9gm5RPg-6neHofU2Xkom73dqhi0RYC2K2Xw>
    <xme:QvI4akLrr8KuGSZ6WGUX2_-Tu0kXNc13L4IzmzQBUWjBfp8bJHRd_9J0cEMDnwmKS
    xVuh_fWhiOdpHvIaC0Pia8dMM4B5sJMpXs59gOAb28piq0WeTvMwQ>
X-ME-Received: <xmr:QvI4auuEBn0sirOFVWxgxJ07g69RvHRIj_7BCAAZmFn3tdoT32iC-F3GXXcqxhHUsWBMqnrK9DlyHKiP4kw6Jc_3XQjENK_vaVphCCMElQ>
X-ME-Proxy-Cause: dmFkZTFGuvhk19wP1nIdECGxwx3gbsw2ufEFYPW/bcryZRaeS0zP3zRO2BkgCLVXG+HRAu
    eDSJo9XC9+oh3Bg4ZRtWUyrhjPNmJp3YOJHUnxHZF9fRZrG2CDlLXQ1vIYWsZ6wE8vVEag
    zy9G92nuZEbjKcNWm4jg58++glxCpMiBCJ8FdiujUMh3AT0f9M3NX3x4YMlYXDCGdPE5Jo
    sF+G7mjGMycHN/Ao7CZBomtDY3FTUdRjzmq4savyltQeIxi4PefUj35UFTgtSExhYooKOd
    zIHDBAiAvQ1kUkDPooo/KXMo5cdMPFyZNxi4JoyhlbXctSkAgq/pHTp6e/bmoS79cQ0AcY
    d6at32U08YkYeuON3Vqj7H1fjce4fnMWGNLleGMGLMUXmb9J+EmA6f9Z1vZWPnSu1quoAg
    Prz6ZkCWVxvoXKlCRUIJ+wzw/2WRPG6RnrKttpWpr90yCc4iD9hP915c+S0jyGlbALevSe
    ZM5TnBhYYic//1qOQkCau68+XPPt4c7B/0aoCBjb7SDHigzyKJBsb4Ms7T6plWYF+QzyEV
    Dn+MXTq3nQ9oNr1shD7cqcdllzSUTN5I6XnwNHip8J2VXnxQwB9y5FrKNhNARdwlfPifDw
    RUoqC0gud78zB+hJar0Z4/9T32giQnxS1cNrKoizyYFXMT3XVx8WT1aHpx8A
X-ME-Proxy: <xmx:QvI4ahTI9UJsgfZkwZl9sWhghh8Bg4EnMYb2VDF3DJaoOIItMobZBA>
    <xmx:QvI4akNeGcwaCUwiHTzcGgeVQ5Cdg819Rq4SRDvPINCL6BbjLbIk8A>
    <xmx:QvI4amai1_8RQziFq0urP7ddM2LXFb5IwinpmsnGM4Ka_NiCslrgww>
    <xmx:QvI4auzcqlwua0RbWpiv0b41xPixVNTApTzFmBT3gs9ItWR_adMtOw>
    <xmx:QvI4akzMwg6vd-ybp4pU1mqKR_uzTlrMzQMMRZygP4hVEVYHT1wpI3bg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jun 2026 04:28:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fe99c17e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jun 2026 08:28:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 22 Jun 2026 10:28:30 +0200
Subject: [PATCH v5 08/11] refs/files: lazy-load configuration to fix
 chicken-and-egg
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-8-018475013dbc@pks.im>
References: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
In-Reply-To: <20260622-b4-pks-refs-avoid-chdir-notify-reparent-v5-0-018475013dbc@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
 Justin Tobler <jltobler@gmail.com>
X-Mailer: b4 0.15.2

When initializing the "files" reference backend we read the repository's
config to parse "core.preferSymlinkRefs" and "core.logAllRefUpdates".
This results in a chicken-and-egg problem though, because parsing the
configuration may require us to have access to the reference store
already when an "onbranch" condition exists.

Luckily, all the configuration that we honor only relates to writing
references. Consequently, we don't strictly need that configuration to
be readily available at initialization time, and we can easiliy defer
parsing it to a later point in time.

Implement this fix and add tests that verify that we can indeed properly
parse these config knobs via an "onbranch" condition.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c        | 37 ++++++++++++++++++++++++++-----------
 t/t0600-reffiles-backend.sh | 21 +++++++++++++++++++++
 2 files changed, 47 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 79fb6735e1..d0f379dcd6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -84,12 +84,14 @@ struct files_ref_store {
 	unsigned int store_flags;
 
 	char *gitcommondir;
-	enum log_refs_config log_all_ref_updates;
-	int prefer_symlink_refs;
-
 	struct ref_cache *loose;
-
 	struct ref_store *packed_ref_store;
+
+	struct files_ref_store_write_options {
+		enum log_refs_config log_all_ref_updates;
+		int prefer_symlink_refs;
+		bool initialized;
+	} write_opts_lazy_loaded;
 };
 
 static void clear_loose_ref_cache(struct files_ref_store *refs)
@@ -121,17 +123,31 @@ static int files_ref_store_config(const char *var, const char *value,
 				  const struct config_context *ctx UNUSED,
 				  void *payload)
 {
-	struct files_ref_store *refs = payload;
+	struct files_ref_store_write_options *opts = payload;
 
 	if (!strcmp(var, "core.prefersymlinkrefs")) {
-		refs->prefer_symlink_refs = git_config_bool(var, value);
+		opts->prefer_symlink_refs = git_config_bool(var, value);
 	} else if (!strcmp(var, "core.logallrefupdates")) {
-		refs->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
+		opts->log_all_ref_updates = refs_parse_log_all_ref_updates_config(value);
 	}
 
 	return 0;
 }
 
+static const struct files_ref_store_write_options *files_ref_store_write_options(struct files_ref_store *refs)
+{
+	struct files_ref_store_write_options *opts = &refs->write_opts_lazy_loaded;
+
+	if (opts->initialized)
+		return opts;
+
+	opts->log_all_ref_updates = LOG_REFS_UNSET;
+	repo_config(refs->base.repo, files_ref_store_config, opts);
+
+	opts->initialized = true;
+	return opts;
+}
+
 /*
  * Create a new submodule ref cache and add it to the internal
  * set of caches.
@@ -156,9 +172,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
 	refs->store_flags = opts->access_flags;
-	refs->log_all_ref_updates = LOG_REFS_UNSET;
 
-	repo_config(repo, files_ref_store_config, refs);
 	chdir_notify_register(NULL, files_ref_store_reparent, refs);
 
 	strbuf_release(&refdir);
@@ -1890,7 +1904,7 @@ static int log_ref_setup(struct files_ref_store *refs,
 			 const char *refname, int force_create,
 			 int *logfd, struct strbuf *err)
 {
-	enum log_refs_config log_refs_cfg = refs->log_all_ref_updates;
+	enum log_refs_config log_refs_cfg = files_ref_store_write_options(refs)->log_all_ref_updates;
 	struct strbuf logfile_sb = STRBUF_INIT;
 	char *logfile;
 
@@ -3301,6 +3315,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, 0, "ref_transaction_finish");
+	const struct files_ref_store_write_options *write_opts = files_ref_store_write_options(refs);
 	size_t i;
 	int ret = 0;
 	struct strbuf sb = STRBUF_INIT;
@@ -3340,7 +3355,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 		 * We try creating a symlink, if that succeeds we continue to the
 		 * next update. If not, we try and create a regular symref.
 		 */
-		if (update->new_target && refs->prefer_symlink_refs)
+		if (update->new_target && write_opts->prefer_symlink_refs)
 			/*
 			 * By using the `NOT_CONSTANT()` trick, we can avoid
 			 * errors by `clang`'s `-Wunreachable` logic that would
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 74bfa2e9ba..bbbf6fa422 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -519,4 +519,25 @@ test_expect_success 'symref transaction supports false symlink config' '
 	test_cmp expect actual
 '
 
+test_expect_success SYMLINKS,!MINGW,!WITH_BREAKING_CHANGES 'core.preferSymlinkRefs can be set up via onbranch condition' '
+	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD" &&
+	test_when_finished "rm -f .git/include" &&
+	git update-ref refs/heads/new @ &&
+	cat >.git/include <<-\EOF &&
+	[core]
+		preferSymlinkRefs = true
+	EOF
+	test_config includeIf.onbranch:"$(git branch --show-current)".path \
+		"$(pwd)/.git/include" &&
+	cat >stdin <<-EOF &&
+	start
+	symref-create TEST_SYMREF_HEAD refs/heads/new
+	prepare
+	commit
+	EOF
+	git update-ref --no-deref --stdin <stdin &&
+	test_path_is_symlink .git/TEST_SYMREF_HEAD &&
+	test "$(test_readlink .git/TEST_SYMREF_HEAD)" = refs/heads/new
+'
+
 test_done

-- 
2.55.0.rc1.745.g43192e7977.dirty

