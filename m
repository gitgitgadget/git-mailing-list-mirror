Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA00382F28
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 09:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782379231; cv=none; b=hj98pOfYN/6Xg4JGGaU+rlTg3Zquu7kuqhwGz/XudQ2hHn9ZQDu/GfDC6HwnIu8J1PSLt+ejVlnSS3Z+OYt0uiXXzKpl1nErzD2fVJfaIs6kGaLShBknC0taQFhYY/vMLgVirkUHyOme3nOIeNzPkSvnbgXZc4JH2FJuN77+zag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782379231; c=relaxed/simple;
	bh=Vq+kzkPhUNkiR719xx2PHHWB1ImOUdOgA4oXI87jaEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q6oxWShhXlAtCoQnIuKJaMS2/bmHuExgOdyipKCDD3QjLA4q8/Cb22P9zwgPZFV4E3FQlmcEjoCksZX1VewNrOH6RTSG4PIBCoe9/uxJmE+godvspRrDyBonOLLHzT7/u7oj1ehgntiXI8ICaxBHg4UhHRw0Hofyl66yJJGdXsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W/XjChki; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kFUsSbaL; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W/XjChki";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kFUsSbaL"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BD95C1D0007A;
	Thu, 25 Jun 2026 05:20:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 25 Jun 2026 05:20:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782379229;
	 x=1782465629; bh=tkfkSYC6Ex1F3EkDwKlhnXgKtj9wFUZP+QDHefY9tY4=; b=
	W/XjChki8N6K+j5ad/cR+BqHXKaV8HzfoT5aPPLxlp0/jEfL12q7i16I92+XYGMK
	4tlQFrDi0JZX/nHYMA8EGIB6q/zjDCl2aMqjV2DsQeL83huk1ZVRaWydgm32dqjh
	ymraKrAUW5P24Z1x7REPyc/4lo2RpZx08MWGuiJoRBA83FZRLv8vqezVGNEyLXqh
	IybeEFsdrVBHhNP7aPpdpUScq8aSK2k/srHH/rdyyP/7oi3tXYXc+dR1pSK55IBx
	H4Uxi+y8aKoGTiOr7wuhlxWD5pdbQwbXq/A99Tw6bkXhd8Mhm+iK4I0JbBMlnH9+
	AgJmG7xxfL1TDnfOtwu2sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782379229; x=
	1782465629; bh=tkfkSYC6Ex1F3EkDwKlhnXgKtj9wFUZP+QDHefY9tY4=; b=k
	FUsSbaLWnW0aMWd5dBRWKI/sMmMJZFtjl+ojfk7PqdiJZ0+/1KscCqAFW6aoJJNB
	ut2O0NhXkVUioHP5ugbMrCoIVJ8GdqMK9dngkkXgysUht9APegfhQX1y2svH5k3H
	gzoPUeWguJXre+kTJhtI7CM6kOoy5QQtkkTfBi5G83LFmI1xUUXCkJvvdtm3Yw90
	+fE8w2SaWs1aP1trgl4gKAuXdFxR18dWlPOsjaC46338pnzY1fzKhh77pEp+qPAc
	Zjhi7QqzyvuyyKsipPzou8+GPZ9c9hzbgc2tkEkuaGriNfc+gxCXucAFprYPx+NY
	5yXVsn+7owyzXtc+xI2ig==
X-ME-Sender: <xms:3fI8ahFatsoM_wVievz769KHprt1Ikt0BQEQu276UB9SLfUoo86IEw>
    <xme:3fI8atVfak2LkrWm-Dcuv-PG-Ywf0xTGesJC0ID6CjEYhP7feA4CxW73wpSbhnpwv
    -DZ_B3CAXmUskuLdXl7E7j5DwgU3nLIaJOcQRj9OAWQmpm77eeDu5E>
X-ME-Received: <xmr:3fI8aoI5qgSt4v51IWOX0N-SUHT_NxMrLV4Jy-PXKuFTjPwf3rIMUs2l2-XPh0-ru2enbcVz3sxzjRKA6QrmJANCZaCVrNo52JozceCxlQ>
X-ME-Proxy-Cause: dmFkZTGMHA1OEOFl0e4hEURh9ZN4vsd5q1bhsCQ9u+P05s4JDAeY/wb4NOegEhe1Ptkerz
    l6XDzTpo9rCChOz+94AHfHMeTR/Fq2vGULThLBxvLZoVsRCa/vDoE8G/d7A4FIhZi+GeRd
    vw+2RZrD4Jlt5zROZY9cmhpPItfcI8yNiNl3SkR+RiapoupgTT7yFODOYfJD10FkKTnxuX
    SwFeaZB6F2gBY0sRtYYGbWJbaopXLX88L4XljBFLOFSrZvwrvInbc64oU2JzH1Fjx5hBKx
    34pRgjNn/TpL5lg6DnRLGIuhV/r8sq1NIoGqfFwPosUNm+J/ixcsbK511ozn+gm5MdenkC
    SNJoZcuq1v+mptPVknC4Nu56wHWT9FQmQx4kETJhqSyiSqLwjExA9Qte2JpvIdpxRPEQB7
    oT9TQapDB4djaJ3LAPkmjHO/f2PVY6ecCukKLtZNP+sQcDmW9Cfg5swxsajkh/F/xV0a7s
    eCSbiug7MAZCLLK20YfRKWwNhSwn8aDlIGQFQo/FHlrkZTpewmaH6JM/uMCwx4et1qgBUB
    dYGGCOae+Yve3O7T5Kif9IqI+/8ZkNNiaGVxTW8mYxmsQDoCXgmT27tcESOVZl99NO7TTA
    +/VBO8sjfdSPa1DNFDT0Us5ICx96CC7c9cGKRQyR08yzkXH4YEQt4Go28CSw
X-ME-Proxy: <xmx:3fI8al9WHYVcpXthsvV62jDBgVc7ZUBbynAVKUqUCRR4tlcP4lQ18w>
    <xmx:3fI8ajJW7LemMiCAc-E2tlKTxzLQ2oBFkI0kCrlWYeVGAFKvtjp49g>
    <xmx:3fI8aintv8U0fhIS9WFF75gakenWV0TKHZyNS7acu5D-vQD9VA3ASA>
    <xmx:3fI8avPjgVlrIfZ0jKh1TRFfkgwvfYoBpWXea_ZLvDLhmo1fADibog>
    <xmx:3fI8ajPMK8klR2FPGXqOHbPaB_3wPYzAoQPgpGpVv3jnScYE6ZvKbFpP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Jun 2026 05:20:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d52fd6c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 25 Jun 2026 09:20:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 25 Jun 2026 11:20:06 +0200
Subject: [PATCH v6 08/11] refs/files: lazy-load configuration to fix
 chicken-and-egg
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-8-41fbca3cf5e3@pks.im>
References: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
In-Reply-To: <20260625-b4-pks-refs-avoid-chdir-notify-reparent-v6-0-41fbca3cf5e3@pks.im>
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
 refs/files-backend.c        | 44 +++++++++++++++++++++++++++++++++-----------
 t/t0600-reffiles-backend.sh | 21 +++++++++++++++++++++
 2 files changed, 54 insertions(+), 11 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 79fb6735e1..7ffe489f6a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -84,12 +84,21 @@ struct files_ref_store {
 	unsigned int store_flags;
 
 	char *gitcommondir;
-	enum log_refs_config log_all_ref_updates;
-	int prefer_symlink_refs;
-
 	struct ref_cache *loose;
-
 	struct ref_store *packed_ref_store;
+
+	/*
+	 * Options used when writing references. These are parsed from the
+	 * config lazily on first use via `files_ref_store_write_options()` so
+	 * that we don't have to access the configuration when initializing the
+	 * ref store. Do not access these fields directly, but use the accessor
+	 * instead.
+	 */
+	struct files_ref_store_write_options {
+		enum log_refs_config log_all_ref_updates;
+		int prefer_symlink_refs;
+		bool initialized;
+	} write_opts_lazy_loaded;
 };
 
 static void clear_loose_ref_cache(struct files_ref_store *refs)
@@ -121,17 +130,31 @@ static int files_ref_store_config(const char *var, const char *value,
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
@@ -156,9 +179,7 @@ static struct ref_store *files_ref_store_init(struct repository *repo,
 	refs->packed_ref_store =
 		packed_ref_store_init(repo, NULL, refs->gitcommondir, opts);
 	refs->store_flags = opts->access_flags;
-	refs->log_all_ref_updates = LOG_REFS_UNSET;
 
-	repo_config(repo, files_ref_store_config, refs);
 	chdir_notify_register(NULL, files_ref_store_reparent, refs);
 
 	strbuf_release(&refdir);
@@ -1890,7 +1911,7 @@ static int log_ref_setup(struct files_ref_store *refs,
 			 const char *refname, int force_create,
 			 int *logfd, struct strbuf *err)
 {
-	enum log_refs_config log_refs_cfg = refs->log_all_ref_updates;
+	enum log_refs_config log_refs_cfg = files_ref_store_write_options(refs)->log_all_ref_updates;
 	struct strbuf logfile_sb = STRBUF_INIT;
 	char *logfile;
 
@@ -3301,6 +3322,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, 0, "ref_transaction_finish");
+	const struct files_ref_store_write_options *write_opts = files_ref_store_write_options(refs);
 	size_t i;
 	int ret = 0;
 	struct strbuf sb = STRBUF_INIT;
@@ -3340,7 +3362,7 @@ static int files_transaction_finish(struct ref_store *ref_store,
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

