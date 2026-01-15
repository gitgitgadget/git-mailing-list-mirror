Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9576E37417F
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 11:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768475103; cv=none; b=h49H0dlnpwh9Yn1YY1NZ37PRD1U+6/R/RWkxzUVMB0PE23o7D7lG3/3Mp0yhgkP6Ezcp1HJzEnemXWFOq01afJADrrCWAvg+5CNp3OGBJmSRtTTUfbYBWr79/h/o8CUXsB22kV2SEqzS7VwrPNRYURtPedgfxBbl/5pTBMHjhs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768475103; c=relaxed/simple;
	bh=vOAsokY9QKwhRjRkqbmHid1pRXsdRhm4MEN59M4oQtE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=r7zx4kJydyW0hHngl7qbGXii02gWjv2+ZmkUixD3rP4ivJPhlWAL3ts6HStGMRzr+MIki3PGP/o3My6TeADac0UefRR0jHxZJsHXtCPp4s+YbzjsKsrZqGmWA69g6q5ZkZBpkd8wBsmGctbiTSuMhVKBrsFQwJntgat2kt7mGms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LZEahlc9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lTgNsA8T; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LZEahlc9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lTgNsA8T"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id EB4191D000E1
	for <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:00 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 15 Jan 2026 06:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768475100;
	 x=1768561500; bh=krTIngsKU6O2b+ERSdVyA/5UoRXrzVGTr3aPsRAgPZc=; b=
	LZEahlc9XsAVqZBPa3ySCC2tcDvSvpgygqXeukGtr98wqCeufXp1URZUvgP7ajxT
	Ai33qDvAPuQkvX+KufRrIIqeklt/tIj2CUdFXbcy/jrEaZ/YhFhhdl4dYpBYN1pn
	D573KNUX3v5yHlviZ9is55h13xve79IxSztBW1yTjBSKK02l4VMzBPbj+EybVLPB
	iPIUA3qc4CsyO4V0DqDk+lH/wsKr5OcuVEqutOiaR8AlfsCSCwj/VU0e4VSfHIkV
	84YrJRf193GFbf/EjKYQo2fgH0rvp+z1lFwkukUBJvryeyFObGAmoXxe5G6jOZpp
	7Ip8ei2Rlz4XlN4rtJ3fSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768475100; x=
	1768561500; bh=krTIngsKU6O2b+ERSdVyA/5UoRXrzVGTr3aPsRAgPZc=; b=l
	TgNsA8TK2IKfLvosFP4Uy/ip1wTMa5dx9N+EMELbSbSjqaiCW6CpPBlVpCiqEg4m
	GVZpsgZGGfMiJVDpv6HurjlXqfYlYAKcUXQSh/QFD98RTcV+oKlKKW6NnmSCAOSi
	gz+QCqGCl6Zlk90YxAhKXIAhQakpUYbXcigMsOflEYWF1yXz+QEu+Z15O0fhz1xm
	BE+bLM7+915KEXIuuwjcjfvFrKLfQHrfcU6vVjqll02Z9WUtNCCLV++qEU96WdPW
	qGhVK0zWluGc+iiG3O91PX1hVAnpY1IBbyZJimbz6R9GLPn3uwlqJkxMYa48GHUK
	ZFLHi0ofTbPxl0kxGM6tA==
X-ME-Sender: <xms:3Mloacuwkj8Z6vTVaUAjhqz32LzEF0EVoBMTrGRjBpsZPwJWiC-m6w>
    <xme:3MloaQa9D4h8Y6rvcQJExbEHu0BdAPNAVqJDOA3te9T-gIAYr9G-h0NxlE9f4sktR
    YBaC8AWXQSnA0bUujxqvHM15It_99rU_BV1csm91Se5lrGKbIz75Nk>
X-ME-Received: <xmr:3MloadZKMQRg_q-xJCNG_-Gh0-4v_blJu7mFbz-gY9khP1cklUljB3MLg7z5a2ynuvV5NZ14YvGBOk7zdTkdPg-20vJpJmmTsHA5TjcDKDNXZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvdehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:3MloaUWi9guL7oKwqG4ZkAiwO5X7X26lSl2VopwLGvY0q1vAnlzq7w>
    <xmx:3Mloac0KjryhTSd4E5EIXXgclvKTsQy96Svz2LmTB6KX_Ene2PVLEg>
    <xmx:3MloaTa01WIhuyG1vQEJh0XYOfpJXsiorlz5fx8HuTL-voqElXmbYw>
    <xmx:3MloaXpIrRlUu6suZBz66WBUMbl6TPI2HzWNQ8MJFBMR0Xu3zLx1Qg>
    <xmx:3MloafcMHMCc48oMPdF62Jb-WHu44FWeR6zHUTzEcakuYBs-7wNpJZrZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 15 Jan 2026 06:05:00 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1c059e18 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 15 Jan 2026 11:04:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 15 Jan 2026 12:04:31 +0100
Subject: [PATCH 02/14] odb: fix flags parameter to be unsigned
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-pks-odb-for-each-object-v1-2-5418a91d5d99@pks.im>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
In-Reply-To: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The `flags` parameter accepted by various `for_each_object()` functions
is a bitfield of multiple flags. Such parameters are typically unsigned
in the Git codebase, but we use `enum odb_for_each_object_flags` in
some places.

Adapt these function signatures to use the correct type.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 3 ++-
 object-file.h | 3 ++-
 packfile.c    | 4 ++--
 packfile.h    | 4 ++--
 4 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 64e9e239dc..8fa461dd59 100644
--- a/object-file.c
+++ b/object-file.c
@@ -414,7 +414,8 @@ static int parse_loose_header(const char *hdr, struct object_info *oi)
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags)
+				      struct object_info *oi,
+				      unsigned flags)
 {
 	int ret;
 	int fd;
diff --git a/object-file.h b/object-file.h
index 42bb50e10c..2acf19fb91 100644
--- a/object-file.h
+++ b/object-file.h
@@ -47,7 +47,8 @@ void odb_source_loose_reprepare(struct odb_source *source);
 
 int odb_source_loose_read_object_info(struct odb_source *source,
 				      const struct object_id *oid,
-				      struct object_info *oi, int flags);
+				      struct object_info *oi,
+				      unsigned flags);
 
 int odb_source_loose_read_object_stream(struct odb_read_stream **out,
 					struct odb_source *source,
diff --git a/packfile.c b/packfile.c
index b65f0b43f1..79fe64a25b 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2259,7 +2259,7 @@ int has_object_kept_pack(struct repository *r, const struct object_id *oid,
 
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn cb, void *data,
-			    enum odb_for_each_object_flags flags)
+			    unsigned flags)
 {
 	uint32_t i;
 	int r = 0;
@@ -2302,7 +2302,7 @@ int for_each_object_in_pack(struct packed_git *p,
 }
 
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum odb_for_each_object_flags flags)
+			   void *data, unsigned flags)
 {
 	struct odb_source *source;
 	int r = 0;
diff --git a/packfile.h b/packfile.h
index 15551258bd..447c44c4a7 100644
--- a/packfile.h
+++ b/packfile.h
@@ -339,9 +339,9 @@ typedef int each_packed_object_fn(const struct object_id *oid,
 				  void *data);
 int for_each_object_in_pack(struct packed_git *p,
 			    each_packed_object_fn, void *data,
-			    enum odb_for_each_object_flags flags);
+			    unsigned flags);
 int for_each_packed_object(struct repository *repo, each_packed_object_fn cb,
-			   void *data, enum odb_for_each_object_flags flags);
+			   void *data, unsigned flags);
 
 /* A hook to report invalid files in pack directory */
 #define PACKDIR_FILE_PACK 1

-- 
2.52.0.660.gd05f3a8ea5.dirty

