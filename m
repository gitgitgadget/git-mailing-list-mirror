Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB103D3305
	for <git@vger.kernel.org>; Mon, 18 May 2026 09:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096689; cv=none; b=i4nzwfZesaujcAVDCDRdZ6h92p7pCMQyinEt6q2OPhRSKIVfIDLe8xOq3/pcT7FNvLtqqBCtarsEF8lrsPve+iZWjhiY1cXgMNVFhA5eAWfMmKUSx+6OdTY6se539IVZcoIqdtqlwsgf/elkhuWSnH5ztzUR4U8szL7h7G8AFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096689; c=relaxed/simple;
	bh=tu4MGp1QaLNrB5qZbS+W8e0rQOUUbHvRh6tLu1P69ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FXxtWCt8Xqn0KbeV5qhBi6Ig4+0GIYGkuzbLJUAM5qSbz5+5mjzE4tehZQDm9KWOqlaeMBj4rdGLGPu6eDq0vhDQW6WN5NhgFD69BvbVx2VsP1koMtuJDAUBgIMf3f3MBSpYmzmu/za61ipEMlQQG+wXqqjL8mC/EejWc1kl0ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cKMIGC2x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vMvw3qW+; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cKMIGC2x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vMvw3qW+"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id E5F041D00121;
	Mon, 18 May 2026 05:31:26 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 18 May 2026 05:31:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779096686;
	 x=1779183086; bh=BqcPC+GAVam3mwGKkBDciKICECz5OQ37tzvbZguzOQg=; b=
	cKMIGC2xyqlUYhHOjt3+XHWnzBTd6Zsa9Izf/AEQ9FPqZsMUcgUzd25Nkn8jT5we
	pzFz409ZOpCDzPT+kj5Ch1aPaBX+0USS9+mlrC+bIH3b+IkAxHFQe/JIZIueOyyx
	eQtxGHHGWHb2aFcUd40m++/b+EY2fAZQUZ4wxshwc921ulphv1BLUsJTw7IyOB0Y
	dAVPMQXgOROL+dn3Wb9v43ZMAyjRIgC2w3rY9Wtn5nCpKO1ELRZAakpHwdnXPmUG
	jdWgjnge3fd+sWEZGOOQZebMAjY6SazxZnWddlVLw4ulaOzfQXncMX9/a9Bl2z8T
	1jQ8BDKMUerHw7uOSGl5ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779096686; x=
	1779183086; bh=BqcPC+GAVam3mwGKkBDciKICECz5OQ37tzvbZguzOQg=; b=v
	Mvw3qW+JirsZMiQy50nKM8KFC8i2etXNc2Onyk62pCMbkOjyNBlPlzCSvxM7GGPh
	9H0JPE5b6fIF+AH7drXrfH5glFc4tUFJheDv8OSSYDroA0gaucIlDJXsMUxG5dtM
	wQp4V4NCPPPF5DejcT4ROlrd4ObW6rfZ8NLzoYKj4l9TURmV2u84N2ypyRw/rm9Q
	htlZLTSICfpfrraCxvGTcwqg+uTrHFsuFSgcztZswfOWZ/h4/RUrNLJ4w09zkTF7
	BaEEyldusAO39qpQFEssa7VQdGwfmX1Te53ItGFOWduXZPwKGwdO88uD9FdWFn2X
	on4zDwvsrOegOq11CgPbw==
X-ME-Sender: <xms:btwKaiSVWzIp_v1dStLmos3Acw9CKEAuuBJFYNL1QkVVmqeOLKgTlQ>
    <xme:btwKajRrPxHkWKBtv5XdYgUtl4X0hk0wFGYvDUF7FCsQzRgRqOgOrWRgqRQTl03tP
    z_7xOcsO3StsaJMTqZDmpI58_tJ_LGj6YA8l6wihi68y9MyhTtxkK0>
X-ME-Received: <xmr:btwKamSH4sMY1RAo2aqiz7vhE66x_yeXpuUrkWolMMO7kU71Fjx6VBY0FvD8REDheizd1Zo5-fgkhX1-FqCOfjKvb_oboVX29DY1hO8EUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddufeekheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtrghtsehmrghlohhnrdguvghvpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:btwKao46Xar5JSYe76-FfhV7FIJH-FnuWUjfnmnLQVlTZM_mEl-iyw>
    <xmx:btwKai3cMW_HY-xFQGROsiW5GdwUm2mwf5pt0ATYffGPsgTNr77wAw>
    <xmx:btwKajB1wHnlqKYw8IWd3Z1B2YM51Yxg79lY-CPd_wZXxOJhCHMqIQ>
    <xmx:btwKatNG7F-XN-tVqa5MuEp_e4rMvr-V6r3vrss_ThRwSnC4915vtg>
    <xmx:btwKaolFYotlQul_7tmmn5UlzQXIF_bncK7C3HoZ8JYnm6IWsr28-KHK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 May 2026 05:31:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 70628a2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 18 May 2026 09:31:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 18 May 2026 11:30:59 +0200
Subject: [PATCH v2 08/18] setup: stop using `the_repository` in
 `enter_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-pks-setup-wo-the-repository-v2-8-6933c0f1d568@pks.im>
References: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
In-Reply-To: <20260518-pks-setup-wo-the-repository-v2-0-6933c0f1d568@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Elijah Newren <newren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Tian Yuchen <cat@malon.dev>
X-Mailer: b4 0.15.2

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
index f0771590a7..322d178c92 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -2643,7 +2643,7 @@ int cmd_receive_pack(int argc,
 
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
index 759aba4e2c..cb479cd91a 100644
--- a/setup.c
+++ b/setup.c
@@ -1765,7 +1765,7 @@ enum discovery_result discover_git_directory_reason(struct strbuf *commondir,
 	return result;
 }
 
-const char *enter_repo(const char *path, unsigned flags)
+const char *enter_repo(struct repository *repo, const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
 	static struct strbuf used_path = STRBUF_INIT;
@@ -1838,7 +1838,7 @@ const char *enter_repo(const char *path, unsigned flags)
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
2.54.0.771.g3ed373ac14.dirty

