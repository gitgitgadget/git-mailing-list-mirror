Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4774D3D3D19
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774876687; cv=none; b=iySlTkudpz1ddbGcoKwuk1/SRbX7ERULa+xhckeBvCp8CiturNAbhpGZTxWwfL5dPho9nPLBGh39CDd8Ii1mnSMI7PVrkN+jEEMVqEA/8QgL7wdX2QZxh1kqTI7vtJO1/pRD/tOdOSCo20It6gtCedtJ63B7uEmyGNzdyQ80uTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774876687; c=relaxed/simple;
	bh=rAajzVK5qkie0QCqpuIV7qJTthYgg12P0ZgdcRksL7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8WOpjvLnxyndWQqdamrN2rTx4NWM0ySO5Yz35x5AiVbRi7UKEA5tZtDIXSCNXLbIElD7TielxLXo33nTk8hJ4dTNaQhJ2EHdGMLiHmqtDYyjxCIZN3m9itJAbLGirvlp6jfKK8zrj5/8XO56FplFPNiBcq4rShT6IWryKJJNz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fApHAJ3L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OUqg2aM9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fApHAJ3L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OUqg2aM9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id A9B1F1D00190
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:05 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 30 Mar 2026 09:18:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774876685;
	 x=1774963085; bh=JriZhp8UHptCo+9bsxGAvyUf5u2Ba2M2fufs8pzgLo4=; b=
	fApHAJ3Lk75kjpgVFhqoMaa1Gw+bpl4uFuufFBLuNxq16K5cjyIjaLO5bc2PwwCR
	7/SkFsCAQjTqn8S9COM5J15iawBZbMSHBJvB6tkTAPYg+QyCrQNuL1utu/Bcu3tM
	F/a9xd1bc/Qkewb4Vs+ntoJ9czOu2FGNyWOaR8sKZTpjgv0RbID75OYwcuxUiJrN
	HuZ45kdpsncqchW0zmWKJIRG8Db35qz+NhZRgo3f/epZIpzOK1EOPx9mVGS8Qvdl
	TgsS8sgx1/QQhmD5LoC8rtKH3KNF9DCpdvFnt74IYJGCDrwSiHTlLyut5uVvTX4o
	941wGNi5+xG2DLPMvMkBPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774876685; x=
	1774963085; bh=JriZhp8UHptCo+9bsxGAvyUf5u2Ba2M2fufs8pzgLo4=; b=O
	Uqg2aM9zAJsEEXZMR44Gep+v3o4NEXl8i3uAE3o3DObnVkmv8LW5kr3IcZKAVq/7
	1idQ+4xVhg6pPtzaw1BerE083O6XERmjCdZFBA7xtuPBjXgmhnevOq0Q85rHyWqx
	yJnjwE6u+xy+/EUtdzqAVAF8pX/UKw9UlyG4rlVWbHiTp5zjn15bZaaDYOWuU++n
	8aBN9zFIVd1aEXbWOXoF0VkoBzQsMmPThfMnvTcCAbu2MuEhq4JbAVtHx2aqCOf/
	Ac/0Ibp2D8ExqcWy2IqhB31NO1vKa0xHzGPZ41poysmpDh0VQ7h1YtUr6kZc4qBS
	UVLHbQHyhAImUxN6xxskQ==
X-ME-Sender: <xms:DXjKaU8CEN6mtZHKTjy2fsC3IvTloP2JUG7pUqrL0WXOJUlnpCjM-w>
    <xme:DXjKaToKWDjxQ9eyBSGBVultaWxoESwzx9FT27Ao78GhXANOkwkWah7TZmk5PzDi0
    O4PjaAnKmboyJgBDCV19tLlRNwWsJvylZc8ZTYWY4AgOnnubacYWg>
X-ME-Received: <xmr:DXjKafrhRkwqz0IxVxzrgPLXsqpjts2q_KMSHFqd2ToGy5ErKEyyqcu6iytqDqO7_CwjyyOcj-GaQEmZQ-xlnwbKlVkliZyoX76fnXmmJTkCUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeltdekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:DXjKaZlUIrBMAF4xyc3W_hPQjU4lE25H2hjWjQDedmVaI1QvIMsMpQ>
    <xmx:DXjKaZFw0CLwcL9QHOhxgwmlOOk1yseKgfVRI-oHqB9r8YVTeazbWQ>
    <xmx:DXjKaaogOV07n0uK_Kk1K-dRWMBhhhzj6NDI0BAMphaY2eWjrRhYwQ>
    <xmx:DXjKad6tYpw1h0gsJujAlcVZuIDFoK8yWsyb682w2UDBhidAZ7bc8g>
    <xmx:DXjKaUv8qBRVpp8maN8xStIHzaAh4FP7Uqr569B4lQ_v2jfAkASvUiC9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 30 Mar 2026 09:18:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fd57fdb3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 30 Mar 2026 13:18:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 30 Mar 2026 15:17:30 +0200
Subject: [PATCH 08/18] setup: stop using `the_repository` in `enter_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260330-pks-setup-wo-the-repository-v1-8-0d2e822837aa@pks.im>
References: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
In-Reply-To: <20260330-pks-setup-wo-the-repository-v1-0-0d2e822837aa@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.0

Stop using `the_repository` in `enter_repo()` and instead accept the
repository as a parameter. The injection of `the_repository` is thus
bumped one level higher, where callers now pass it in explicitly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c   | 2 +-
 builtin/upload-archive.c | 2 +-
 builtin/upload-pack.c    | 2 +-
 daemon.c                 | 4 ++--
 http-backend.c           | 2 +-
 setup.c                  | 4 ++--
 setup.h                  | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index e34edff406..c5f73fff35 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2646,7 +2646,7 @@ int cmd_receive_pack(int argc,
 
 	setup_path();
 
-	if (!enter_repo(service_dir, 0))
+	if (!enter_repo(the_repository, service_dir, 0))
 		die("'%s' does not appear to be a git repository", service_dir);
 
 	repo_config(the_repository, receive_pack_config, NULL);
diff --git a/builtin/upload-archive.c b/builtin/upload-archive.c
index 25312bb2a5..718e74b3ac 100644
--- a/builtin/upload-archive.c
+++ b/builtin/upload-archive.c
@@ -31,7 +31,7 @@ int cmd_upload_archive_writer(int argc,
 	if (argc != 2)
 		usage(upload_archive_usage);
 
-	if (!enter_repo(argv[1], 0))
+	if (!enter_repo(the_repository, argv[1], 0))
 		die("'%s' does not appear to be a git repository", argv[1]);
 
 	init_archivers();
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 30498fafea..32831fb879 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -59,7 +59,7 @@ int cmd_upload_pack(int argc,
 
 	if (strict)
 		enter_repo_flags |= ENTER_REPO_STRICT;
-	if (!enter_repo(dir, enter_repo_flags))
+	if (!enter_repo(the_repository, dir, enter_repo_flags))
 		die("'%s' does not appear to be a git repository", dir);
 
 	switch (determine_protocol_version_server()) {
diff --git a/daemon.c b/daemon.c
index 0a7b1aae44..947dd90655 100644
--- a/daemon.c
+++ b/daemon.c
@@ -244,14 +244,14 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 	}
 
 	enter_repo_flags = strict_paths ? ENTER_REPO_STRICT : 0;
-	path = enter_repo(dir, enter_repo_flags);
+	path = enter_repo(the_repository, dir, enter_repo_flags);
 	if (!path && base_path && base_path_relaxed) {
 		/*
 		 * if we fail and base_path_relaxed is enabled, try without
 		 * prefixing the base path
 		 */
 		dir = directory;
-		path = enter_repo(dir, enter_repo_flags);
+		path = enter_repo(the_repository, dir, enter_repo_flags);
 	}
 
 	if (!path) {
diff --git a/http-backend.c b/http-backend.c
index 1a171c5c5a..c7566b1d12 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -809,7 +809,7 @@ int cmd_main(int argc UNUSED, const char **argv UNUSED)
 		not_found(&hdr, "Request not supported: '%s'", dir);
 
 	setup_path();
-	if (!enter_repo(dir, 0))
+	if (!enter_repo(the_repository, dir, 0))
 		not_found(&hdr, "Not a git repository: '%s'", dir);
 	if (!getenv("GIT_HTTP_EXPORT_ALL") &&
 	    access("git-daemon-export-ok", F_OK) )
diff --git a/setup.c b/setup.c
index c6b5b85f3a..dca32addae 100644
--- a/setup.c
+++ b/setup.c
@@ -1756,7 +1756,7 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
-const char *enter_repo(const char *path, unsigned flags)
+const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
 	static struct strbuf used_path = STRBUF_INIT;
@@ -1829,7 +1829,7 @@ const char *enter_repo(const char *path, unsigned flags)
 	}
 
 	if (is_git_directory(".")) {
-		set_git_dir(the_repository, ".", 0);
+		set_git_dir(repo, ".", 0);
 		check_repository_format(NULL);
 		return path;
 	}
diff --git a/setup.h b/setup.h
index 364c2c728a..d0cfdfd44a 100644
--- a/setup.h
+++ b/setup.h
@@ -134,7 +134,7 @@ enum {
  * links.  User relative paths are also returned as they are given,
  * except DWIM suffixing.
  */
-const char *enter_repo(const char *path, unsigned flags);
+const char *enter_repo(struct repository *repo, const char *path, unsigned flags);
 
 const char *setup_git_directory_gently(int *);
 const char *setup_git_directory(void);

-- 
2.53.0.1185.g05d4b7b318.dirty

