Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC26220DD56
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513742; cv=none; b=aOSmaZdHjiO9GyzAXn9wbsGET5l/BN8H23MPhJYUBz4oNCFA31QipRGFU1c043Hbh8gEfyWEekZK7+5qXkvAUcOerco76r2rfXCzsGNY7EtxVHbgtK3UtEfyje8smkoNvoLKM/z+cTD2H/Qrpt/m4kT04HGKepzIKYSTkcylwlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513742; c=relaxed/simple;
	bh=t3rXlukrqj2em5eWQKW5H7YJ5rXDWwY49IjLGu9i9G8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKliVXvSYlbqE73hgTT+jXJNBGC5PW129waZEUbX6gCV7felNo+GY3X7xB3yHU9nHpuko9ideVqVaKM2a4FXXWtf2YRY4NM9HGGMWSDnZGfDqLByXVTRkFCW5hn4GdD0Mn9BbLgrkmO3Oifi9lAITCYt6u5WMZiqncsHyx90sDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z62Zz7Uy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X9x9H5Nx; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z62Zz7Uy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X9x9H5Nx"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D356025400FB
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:39 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 10 Jan 2025 07:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736513739;
	 x=1736600139; bh=t2Jpe0awu+ZIZKWpUqQCnRdosV+xZOpH4iGO/bo3MD0=; b=
	Z62Zz7Uy2cURkv+Q3bHsdJYrfQXSCAYRPZ5Qm7naFleGfIdfueKiZoq+bRdNHVy/
	8uJlOLttoG1oqumC2Mg2kIZ1SGS6kbQmKZkIQZWj6r7pG/uY25ShUXbtMVKuk6ca
	nb07ZxQAxBpVSFSUHEsKSb9JzG5cCi2cqNSQYGqD8iuC5eZVvrEjwR0MMWAyJwHP
	PtQADOsmwlnpfISCqPjK8kc884DVhCvHLJI2KP9fNhL6JZ2FQRZ84ROLUw6rjzBl
	MrMMgxo9ZZuwPxHhGkUS5XwG+bBVcJilYf/hE8n2UuMM4Ha127rBi1Jsz7D+89lT
	lyGPrIw42jiKLsQfjdMQPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736513739; x=
	1736600139; bh=t2Jpe0awu+ZIZKWpUqQCnRdosV+xZOpH4iGO/bo3MD0=; b=X
	9x9H5Nxl+ntM1Jn9geXbmIUTMZM+xuQvvK1TIu+FzVtO1uRl30Y9j86MZM+aruqF
	FDODB6ek2mQYB7NsB+uR6YqKloIZFbYlC9MKVOFbF/EGnwbC7EWjP+kKzNKoSinX
	w9ZtZzBUZkdtccQlbCMXFyFAz/LgiPU1CN80zDxv59gN0yvfwIGAwOCcVOXKmHyr
	SVpnA8ltbPsxKiP+aUElsHCONiadWmfVL8564CUIPsP5RCYBlqKpY8i9/XVhTpef
	0rFJeP8wVBwgVJ/5P8l1kA2hILVu5qaE0Ds7bPt2SfVsOpbBxLQm1vXgMRFMIPVp
	Cz58RopRqKn0l93JVIzoQ==
X-ME-Sender: <xms:yxiBZwF5UbIIseaEyh23SpelZYpIgHvXnbwkTzMoLHfUeAtuEmljVw>
    <xme:yxiBZ5WHSdI9YBnKaUjv8zzn-gCqo8RYg-ontwDcbuJug__exugGD6CeJLSjJXrHN
    VX8Cf4teeVtou3jHg>
X-ME-Received: <xmr:yxiBZ6Lw2sMmgCQUMlDwyH-jPhaw2mnxoaT4YELb6nFcLLRYfFKYkaRleLGvgkuGZL9w8RkFpdEpAkYzHrKDm1R1deBm-Wm2mSGxUTTn-pA_gQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegkedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:yxiBZyFtpa5ADuwtGKs4q73XdgaAsa7aEhxbFj3OYSlzmlrvYkeZGA>
    <xmx:yxiBZ2XhKnGWCp7IqLobUAaGvQGUjvq64HEAFYqkST2BtXTwovofcg>
    <xmx:yxiBZ1NSxZVdoDRJBzlIZpv6tz8mtQGvwI4CqyFE8IcJ14AW2x6D2A>
    <xmx:yxiBZ90wHF6dxsaYYZF7jpp5UwwKaRvKjH9e-frq8h8MNRkKdI_PuQ>
    <xmx:yxiBZ5ebNqLI2m9IFlQJ6vM73uEt4LRyQO0uwvVLc65Sn9FN_rWcggT7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 10 Jan 2025 07:55:38 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4b795d64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 10 Jan 2025 12:55:37 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 10 Jan 2025 13:55:33 +0100
Subject: [PATCH 6/8] compat/zlib: provide stubs for `deflateSetHeader()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-b4-pks-compat-drop-uncompress2-v1-6-965d0022a74d@pks.im>
References: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
In-Reply-To: <20250110-b4-pks-compat-drop-uncompress2-v1-0-965d0022a74d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The function `deflateSetHeader()` has been introduce with zlib v1.2.2.1,
so we don't use it when linking against an older version of it. Refactor
the code to instead provide a central stub via "compat/zlib.h" so that
we can adapt it based on whether or not we use zlib-ng in a subsequent
commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 archive-tar.c        |  4 ----
 compat/zlib-compat.h | 13 +++++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index e7b3489e1e6c826d8128cddb0c5be04042a65cec..0edf13fba7568b3950978a05a2f50299bb9b2f18 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -473,9 +473,7 @@ static const char internal_gzip_command[] = "git archive gzip";
 static int write_tar_filter_archive(const struct archiver *ar,
 				    struct archiver_args *args)
 {
-#if ZLIB_VERNUM >= 0x1221
 	struct gz_header_s gzhead = { .os = 3 }; /* Unix, for reproducibility */
-#endif
 	struct strbuf cmd = STRBUF_INIT;
 	struct child_process filter = CHILD_PROCESS_INIT;
 	int r;
@@ -486,10 +484,8 @@ static int write_tar_filter_archive(const struct archiver *ar,
 	if (!strcmp(ar->filter_command, internal_gzip_command)) {
 		write_block = tgz_write_block;
 		git_deflate_init_gzip(&gzstream, args->compression_level);
-#if ZLIB_VERNUM >= 0x1221
 		if (deflateSetHeader(&gzstream.z, &gzhead) != Z_OK)
 			BUG("deflateSetHeader() called too late");
-#endif
 		gzstream.next_out = outbuf;
 		gzstream.avail_out = sizeof(outbuf);
 
diff --git a/compat/zlib-compat.h b/compat/zlib-compat.h
index 96a08811a98ff7fa057f5682a5303a06cef40cd1..2690bfce41caab2e9af7a09663d620f0ee5136a0 100644
--- a/compat/zlib-compat.h
+++ b/compat/zlib-compat.h
@@ -7,4 +7,17 @@
 # define deflateBound(c,s)  ((s) + (((s) + 7) >> 3) + (((s) + 63) >> 6) + 11)
 #endif
 
+#if ZLIB_VERNUM < 0x1221
+struct gz_header_s {
+	int os;
+};
+
+static int deflateSetHeader(z_streamp strm, struct gz_header_s *head)
+{
+	(void)(strm);
+	(void)(head);
+	return Z_OK;
+}
+#endif
+
 #endif /* COMPAT_ZLIB_H */

-- 
2.48.0.rc2.279.g1de40edade.dirty

