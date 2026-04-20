Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9B0388368
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 08:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776673393; cv=none; b=ZFUYYxU6bTgLn4Tk4wHJTsIlnGVhTe6New8wTjD4h2lzoPwk0geYQC9ms7yiCwuLbT5QrJ8wnRvJBQ+xhDmT7dgVUwK2CcU1T0PMq78tvcnEvuicXxbuJ78TTsrBRux7oi4n5r/Y1X6Fi6EA5gOPM1c24izTjLhmZuzy8hTACgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776673393; c=relaxed/simple;
	bh=7fYHB322gYZ12Bykb8OxzCQf4bYU+1Or836MnenJrl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=A6mMeVeT8JDmIHqrF08M+GnIN9xGIFgcMyKhttjJY7onjl90dXbDSGL3XW/+dDOTwuFsIAkhDBK2c64fvUHPpgEB1xcHQPERqwCCirh4emWzn9/+GJXhMihFym8sJ9XqbE7JjwEffU3RAk44JYiUJzOksPTcz3osY8dnDBnjos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JO5X5BaP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dB4BmVAk; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JO5X5BaP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dB4BmVAk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D96A71400114;
	Mon, 20 Apr 2026 04:23:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 20 Apr 2026 04:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776673389;
	 x=1776759789; bh=dV5VTmvRTVEAkM4po3xntaSBwE129Wx099eDSUl8IqQ=; b=
	JO5X5BaP5RW0iNFbqGN5uBtluk8FkL7itQWtmIaZ2f6g/rU7fvenU1EdLCFGBAb9
	NEfHpT79X28tYZMgDt1Yk5OFEf3nw1C53THgVjg8cLiN6uke00DVRuNnrYZnEKUs
	uHHzJLyZY2NpHO6FPZIWHsslUlaNS3xIobuJ7i9uJhmDO6x2tPlGoN32HhRSw867
	a3G6X8ThB4/aZWCe8JVL+SVYb1Wz7+alwGP/n6AGvggExbM3jbPpcPL2XqPG1Al5
	wxVLFvZ8n1Wo8Mh7rxTSdv57/Ao4thscYtbsR1maQjb5gKKFJcTdz0j70gTSlkzP
	iPbLMbY8F9iAOmGDiELhKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776673389; x=
	1776759789; bh=dV5VTmvRTVEAkM4po3xntaSBwE129Wx099eDSUl8IqQ=; b=d
	B4BmVAkZQF5ucbuicdkHoCDZz/kKnspnTLfS8uzhSLScbl1s0+p1pQhOYY3DWcu7
	ApngbFnq14Am5SLYEqAWe/X0ufiQS/LCe0WtomZatUIOunIkMfM+WXZt1yWNJn+L
	Q3dTiz3L63cFTwSa1sxe3+6xr58/GYu0ppPGBqpj42JVhcbpQ9u0oJLybpVg+1lR
	obVgVqW1xPK0nIB5lo7IGNwxtMuSV38ITwK7arJkZ7J1wCtrqWGrG0u38bVUOFf+
	2r4XCmVbkXOpsOo/xRawJCCYLZtRK/qAYvwgw2ZimBEKqS+hY8H/x0LCEWp4FROj
	WMBR9xfm4k2X8wwDGLFgw==
X-ME-Sender: <xms:beLladRKDo4CCSuF-eg2WS6GS6UU5DWUxIm9MzGVG5DhnkG2GxJkaQ>
    <xme:beLladwU74mx95gNxyUDHkEp9hAgrikCJED4Xba0uex-isxRJL0z5T4kB8HlfUoBn
    4vICInje2ZjHk6C_Gg1uSURQH5Q22Q3Ud1Ewun_nbi9obMyrW1ZxA>
X-ME-Received: <xmr:beLlaX2XQ_hW20x1rulp6UgRJq6e8sv8S-Rnc-zMRzmvlsIPCjRIzemPSATfhRt6IQNYZvdlvhMG1VOeHChmunZHu9bFQc8yJTiodJHdLHnl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehkedtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrud
    ekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:beLlaT7cPVUqe-q8n5QmuG0m6Jw5ru415ALVixB29iFpqZoReROr6g>
    <xmx:beLlaSWwn1nFc4RFzN7NGNexnIs30GAlFBvEHt49ndpH6hXDlBynPw>
    <xmx:beLlaaCL8WfNgXR8vxBApneUB-qRxDyUOTAea_0W9IE095nvaDIBGA>
    <xmx:beLlaZ5GtUSnZ5nO0UozRcS6E4QXR8NeL84r4o7-XAZwkjr-NYiGmg>
    <xmx:beLlafUb49JUHnHTv846bAiGgX5SiBHmLnCrpiK9jfrzUUmbXlHmM2Xg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 04:23:08 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0918de51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 08:23:08 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 20 Apr 2026 10:22:38 +0200
Subject: [PATCH 08/18] setup: stop using `the_repository` in `enter_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-pks-setup-wo-the-repository-v1-8-f4a81c4988e8@pks.im>
References: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
In-Reply-To: <20260420-pks-setup-wo-the-repository-v1-0-f4a81c4988e8@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.1

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
2.54.0.rc2.529.gd9106f7525.dirty

