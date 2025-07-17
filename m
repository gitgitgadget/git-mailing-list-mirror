Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F4020E31B
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728243; cv=none; b=X8iRFu4huuhkXPf2+JQ3a0O90uZGHqc/JAIvRQXVWE3CJe2dH8H4ptBA/6qkTmdxzYBldOSkD6hJo+MxcUzH6CsvQZG2nQS5q7OJmQ5fYZrXSLdOuadq6rI86XrL9JPW3cWLyEIDOjWGc09NtJrWLVrfQWBf2bWUV07XTQHd1Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728243; c=relaxed/simple;
	bh=eKoz7Kps//iEGeI+iFxfLz/VM84RSahfBucwgshjR3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gj8gwyIsJjPIdQQo22t/WEDApQ5Eg0QWlHDSm0U2+zmUu/NLXSWfqrFWwHgG+TX0kJ6M8lhCgcP6BUy6aQDmLDu/Zu3GKu78pD4t9DiwEh9cyq4naJ46xZ9vOV7maNNz/4tkCl7lzKh6Yua+zPKzyyXk1BtCil0q6j/ba+ozO0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xRhXMA5w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fDApsXDs; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xRhXMA5w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fDApsXDs"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 8D0DB1D001A1;
	Thu, 17 Jul 2025 00:57:21 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 00:57:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728241;
	 x=1752814641; bh=qSoJZqoJ7Ut83ZwL2d5KpOuYi06f8xQ8IZ2WZF3ECE8=; b=
	xRhXMA5w0FgD1c76MSN8T0mIAWqqPsu6iIWCPJPJvkhD4WqFdy6VaO4fMNpxM9nW
	Ia5Hl4WkOEuFdJv5j7cSMtV4IfOsUoo//Uv5veAZIMCbevUZvgWTTS8O43Sm/bGE
	2DFXncaw4L0GIoa0e6wRSi4XYoRDNNXIM5AdCFFSpRQiYrZfswO6bgjHIqZ+0alt
	TIFH8axJlFY6E/4acwbtN5AtyJ+w6e30T0Ll122C17eYtjCS0BdFi691eN7SFtmH
	Js3LDB16saPB32mpwwJkEmrV3BfdPMcfUAhCqrHMkTTE2ssR2QTawE5Vgm9DPrwv
	XTLg5YdY+8Lay8Xr4eYfNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728241; x=
	1752814641; bh=qSoJZqoJ7Ut83ZwL2d5KpOuYi06f8xQ8IZ2WZF3ECE8=; b=f
	DApsXDsDrwLgRWwTNz1wH+NCekm+vd2T3J8gwr4q74GNlKR+X2eRaS9eMy62M5eU
	MLQbr44NrhC8pu6y13WpSZZRvIaiPCobFRN1912bXrKGBhtULsriJYIX0aXYB9MG
	Vd8YyHeYXOymvW0kdZv+faYlXNRGc9eeK7XJW2ms9lYJiMI6VHzIRKKrK0zrrbBp
	3WsMUkcoPptOQ3ayECxxEXXLPXRIaNDTXcu8clH9chbmB7fFvpISld4Hh6fC9Ndi
	+nHuCCe63RMVeYa0WFNk52QfQr9jQwhJCh7YjwAxI81INYFynhH7y43BdCR3wYCe
	K+2I18P9ad/XxzOmgro8w==
X-ME-Sender: <xms:sYJ4aNGBrV__-dxzyy56dGgIjHQN0N8VTM5yjEamoup9uGFa9zLKkg>
    <xme:sYJ4aN2eQC10S_ca00fYaIktSz3FhySHwwZuMcrBjAlrrEyIaEIzsaisg8zZFQAnb
    kcCDVlP0DRbBvu0lA>
X-ME-Received: <xmr:sYJ4aFlcm_KQ_0D3oLCgo_IHkr7dfn09UupmkbTgReAQ3pUuq8w0rCmnebRW-QDVej8MHalyGV7bwkUA2z7nBxRwPWPr4s4Aif5bIKfnRj6k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhope
    htohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:sYJ4aN8EQGYsdESsKus3hIp2CHCt6gPhUxZj5-2LrRwSHu4rxMg-Dg>
    <xmx:sYJ4aKrGMvGc-hGRYyPVGovPN7DgyDyXS6pPspDqdHxdAqpRwozd1A>
    <xmx:sYJ4aGmaDDj8afd2sjYzIn0rQu4awMFFBO_VB9F_-y_YOwXpPz6x-w>
    <xmx:sYJ4aBhWVY5JNxeqJHxA9BPXzvdtNYp6DOcBLtYX4A9FSHbmy0_xjQ>
    <xmx:sYJ4aMSp_XAf5FXQB4sQYHb8xA6hfjvhM8FEb8N7NHbUomdu4t2IQQao>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:57:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e1447ccd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:57:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:40 +0200
Subject: [PATCH v2 14/16] object-file: get rid of `the_repository` in
 `read_loose_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-14-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The function `read_loose_object()` takes a path to an object file and
tries to parse it. As such, the function does not depend on any specific
object database but instead acts as an ODB-independent way to read a
specific file. As such, all it needs as input is a repository so that we
can derive repo settings and the hash algorithm.

That repository isn't passed in as a parameter though, as we implicitly
depend on the global `the_repository`. Refactor the function so that we
pass in the repository as a parameter.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 2 +-
 object-file.c  | 9 +++++----
 object-file.h  | 3 ++-
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index f0854ce5d84..e9112d884f0 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -633,7 +633,7 @@ static int fsck_loose(const struct object_id *oid, const char *path,
 	oi.sizep = &size;
 	oi.typep = &type;
 
-	if (read_loose_object(path, oid, &real_oid, &contents, &oi) < 0) {
+	if (read_loose_object(the_repository, path, oid, &real_oid, &contents, &oi) < 0) {
 		if (contents && !oideq(&real_oid, oid))
 			err = error(_("%s: hash-path mismatch, found at: %s"),
 				    oid_to_hex(&real_oid), path);
diff --git a/object-file.c b/object-file.c
index b894379d22c..f7c07acadc9 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1535,7 +1535,8 @@ static int check_stream_oid(git_zstream *stream,
 	return 0;
 }
 
-int read_loose_object(const char *path,
+int read_loose_object(struct repository *repo,
+		      const char *path,
 		      const struct object_id *expected_oid,
 		      struct object_id *real_oid,
 		      void **contents,
@@ -1574,9 +1575,9 @@ int read_loose_object(const char *path,
 	}
 
 	if (*oi->typep == OBJ_BLOB &&
-	    *size > repo_settings_get_big_file_threshold(the_repository)) {
+	    *size > repo_settings_get_big_file_threshold(repo)) {
 		if (check_stream_oid(&stream, hdr, *size, path, expected_oid,
-				     the_repository->hash_algo) < 0)
+				     repo->hash_algo) < 0)
 			goto out_inflate;
 	} else {
 		*contents = unpack_loose_rest(&stream, hdr, *size, expected_oid);
@@ -1584,7 +1585,7 @@ int read_loose_object(const char *path,
 			error(_("unable to unpack contents of %s"), path);
 			goto out_inflate;
 		}
-		hash_object_file(the_repository->hash_algo,
+		hash_object_file(repo->hash_algo,
 				 *contents, *size,
 				 *oi->typep, real_oid);
 		if (!oideq(expected_oid, real_oid))
diff --git a/object-file.h b/object-file.h
index 1b1ab95423d..52f7979267d 100644
--- a/object-file.h
+++ b/object-file.h
@@ -210,7 +210,8 @@ int check_and_freshen_file(const char *fn, int freshen);
  *
  * Returns 0 on success, negative on error (details may be written to stderr).
  */
-int read_loose_object(const char *path,
+int read_loose_object(struct repository *repo,
+		      const char *path,
 		      const struct object_id *expected_oid,
 		      struct object_id *real_oid,
 		      void **contents,

-- 
2.50.1.465.gcb3da1c9e6.dirty

