Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795F146AF2D
	for <git@vger.kernel.org>; Tue, 19 May 2026 09:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184361; cv=none; b=YbK1tC1tMx6oLIQtyYFf8uCe//h7xdE3s0yn2azuL8XcfOaDvlhVKeQ8IOICXyuknodXjqpdyRop94RWQmVHlPqAbAhx35Z0r0DKB5Wa532iYda4Tj01rn3mG/iUYzEvZAuNcrkMgafIZpTMly0n4hSJPLFa9dqx37yXWwett0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184361; c=relaxed/simple;
	bh=tu4MGp1QaLNrB5qZbS+W8e0rQOUUbHvRh6tLu1P69ec=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZcJytzD8bhLJmniKhWwJUi5eZRNp0fidSO8Xi/8CZ/TY+nvyivJOQv0KXo5ROqBGRAC/arkyxJ+SXq0kHQIyUURScW640dZvr3xA/WgUm3UG4LypZgYsB13QtpHvUJhwaGCK0ixKkGyJLX0nmpg2HdPYUNyM1lZR01VWFo8Bo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PR6U03Ek; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YvneM0XW; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PR6U03Ek";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YvneM0XW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2A4C61D000B8;
	Tue, 19 May 2026 05:52:34 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 19 May 2026 05:52:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779184354;
	 x=1779270754; bh=BqcPC+GAVam3mwGKkBDciKICECz5OQ37tzvbZguzOQg=; b=
	PR6U03EkkV/U6GlaBuz2RoMuXehwINEkCWccTyD+oekWUdqimou6QPxRjbrm8Qj6
	Fl/Ea8C+Ze6tzVZO90f9zi/uOxCimsrjdGZMJeTC/oFvbpEjkGVIsD8q0ZzODxU9
	cX9GJo5i92p4jOC0hQB+fhzY41kYuEsdsLe2aGrlxi3gJMYBIGJnieUhgeSoij0N
	EQvX1gtaTzk/mAUSx9kYwIPHz9Vz+kRFZvX7793Yj7DwuUUI2PjHC2VyD4j1F7Zi
	Nr49UFD8uGlGO694fLRywDM5aUijLCGGstNhgvkYLUHWa+hTCVm0xMuZLwC+eJr3
	tVyMeL5hz5389HaJDCSFNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779184354; x=
	1779270754; bh=BqcPC+GAVam3mwGKkBDciKICECz5OQ37tzvbZguzOQg=; b=Y
	vneM0XWQ5iF4GwPrnSKmCD5HHpu4cTR+NAJEHIrG/vgexGVvw7k8zl80T0SGeASq
	AYbuFRbt5WG4gMfdr5RClP95hHeLz+iYf/+emEO8PI/IM5pGbOMINVr715uHUHPH
	I81usY1lpYl/mF2lUIjJWSXjmrcAzmVX548/sayz00wrtSg+xADATL+Hd/UWfIzR
	50mFQGEqgbzinArL5naXFruN3xDLYkJ81ilC22MIP49z7svlGg0+70wQqHlGYeJX
	JUL1MKvnd7v8e3gIGZMTP7TsJSPuMUp+7qkmLMUu+oLfwsBeMnPhsVGlK2AYdFRX
	cz7/N4i19wuP2q1J0WDwQ==
X-ME-Sender: <xms:4TIMasxSDuYsuQLqdadwl0H_85T_jb32RXJsXgHv1pEwuFHSoLMd_Q>
    <xme:4TIManJvuSmJBKoRIqO--BGP9AW2QJfspuzUMvmAptyLRl7djq6e8LnMETOpDrysR
    dscE2iP4QdEjyLHsl63k-VptDzFcPfvfqP6C7pTpP9zLJY8r4iUsg>
X-ME-Received: <xmr:4TIMampyP5rxY1r4VtMHf2XL7-nsT7fEtEKTfiLCn9PzMWvdvA_Z0EVLnpKmx1k8qmSYKerC3eDOtDXFYsAaAIldFUftQJ36ls5njyc2rvs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugedugeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopegtrghtsehmrghloh
    hnrdguvghvpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4TIMamIdKJl3jgDHcUYcsDRn4Yn-TSfa1Q3k2Yxw-iWRUn-35L_fWg>
    <xmx:4TIMarRL6Ic1mkLIRo56PFAEl12LjjDMQ_K1fDsraGhXXWxMPM9d1g>
    <xmx:4TIMaltN2HdfSr1LPc0rloXNDvCOatEyFGr_8wUTWsxHHyPVgjJTXQ>
    <xmx:4TIMasb5teyd28DHM5jsP86FY9VoAZbCCF8rNJWZEYUdvcfXDZPVLg>
    <xmx:4jIMamaEGUYjnWsT9fBzf4zsDFujAKNIe3VY1uCLFyoxDpyRdBYT7ota>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 May 2026 05:52:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10d1a564 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 May 2026 09:52:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 19 May 2026 11:52:12 +0200
Subject: [PATCH v3 08/18] setup: stop using `the_repository` in
 `enter_repo()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260519-pks-setup-wo-the-repository-v3-8-a00d8ea8b07f@pks.im>
References: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
In-Reply-To: <20260519-pks-setup-wo-the-repository-v3-0-a00d8ea8b07f@pks.im>
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

