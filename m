Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC0F2E1C6F
	for <git@vger.kernel.org>; Thu, 11 Dec 2025 09:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445427; cv=none; b=MWqBJ7E2S6qrjJIUYEZMTcna+OuUuHwMPzYg4qMQUTqGDXDA527y2Za1dZt4LkTcUFv5YqgPM9UzWBPFAcYsNiWUSOAyW8TQEWrs+1N3dxf4IKCxIcahowK+2Qxy7Z1T9wEkkyKd8bSu1QU0HhuQ3HB/KaOks+0NcTvMhKKspqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445427; c=relaxed/simple;
	bh=yb9Ane3wTfmZjTBBpAOXQvfp1WgBIIMmr/QaoapE2CU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TsApJx3fNI7raGF16e/OmgcBNyeAHj/v6DKmhOhfE0cOwGMWV9DY2ScbmLLfNZwLel3LGg77tM7ghgBHqC0vXRF/KqPp1goip2GsGjC0+ufM4HHZ59sMbpwKcDXDJ3dBuQ+1RH2n76OeZ5+pWJxSGV1nExry5p6B5x+hwZDFrQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NNsOiuaj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c4Ay3Z3x; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NNsOiuaj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c4Ay3Z3x"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 5D1501D0016E;
	Thu, 11 Dec 2025 04:30:25 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 11 Dec 2025 04:30:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1765445425;
	 x=1765531825; bh=uVTYNwcV/gDUAxifNjYMJHxZPBb7cnnYh+XxO7Ntbtg=; b=
	NNsOiuaj20oIw7eBSYknKKsoIqv6UijYAolqRE+/3+rxeW7bAlBcFqmtHeXhyc+U
	u0OXQXDrNwhXFSqUYD2/dZGFWehkP3sb7/le/ED/IeybJtdTZuzdSsaQbaTAT2wu
	oZdBShk1l0BiqLjiKkRv4ec112QgrKX6EzYtugMkgzkHEhbgZSVNB3ubZPVorgp4
	Zj/ZtVWP2hqKoZUYqXl7S+HG2jKH5v8CTlXypzncNbF3NHQ1VXeWrq2Suog9of2p
	7gUBEjb34hbV4XZYsqAPmgShgMh99FJg/FBJ5BTh9W5PKU5GgcKuwMDdt5bCAp9o
	djFudZvh3hsCB/z5o+ZjKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1765445425; x=
	1765531825; bh=uVTYNwcV/gDUAxifNjYMJHxZPBb7cnnYh+XxO7Ntbtg=; b=c
	4Ay3Z3xdOxlVWe5STBjavgHvJMtalpNFl9JmU8IZZWcoxXn14xi03Y8mp70NeaJ8
	9E29fWSF8WgR1vxjFL6I/cmC39dhBCvBvWGQeLeNpcRZqW5o+Mnp93eWJvDqfSTv
	Li3RWmyZGlhVBS+gXuglXumyl73hQzlJTV8uL7B+B12Zo9gKLhQWwbH61k/HfqeG
	YmszMRGq3XHID64FMCKr+uE3f2Uap+1WIjDHdxylooSZ4y0ZOCSIDSee7mv3t/nI
	qLLBRd3uDODsuiaU6ax/m5cnTEjCXrUnYabdz8z556QAlt3r4/gURrMXn0oSQU2f
	AJpDpXVT7ym5RwQOVJMpw==
X-ME-Sender: <xms:MY86aXut3l04Nglk5IbBfoi5h1SnOwcDKo4Voq6jzLytyLoab9BLRA>
    <xme:MY86af5W4lAz8znPCdpriZqWLfy_39o2ruGj1a2G3U2bTSW9TZIdgy9ZRwQgH2SzW
    5Ia4gW-FSW1h_LjbvYesnI301Mc-IpuIqG8y62mmMNRdgl_VrOrCw>
X-ME-Received: <xmr:MY86aYJGLXVWvL8XJZPgdD59cnnrSNNtqcp9yluIWSiw8okvsh1xZ3ZImHtKnlWwkA8lSnsY1pdCJRaNiOYXHaeiqAID6JJTslcp34CsLFEc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshiivgguvghrrd
    guvghvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:MY86af5UQjZh9q1YB84CvK-MUPuhS2jOBrb682F1cKruHOVDMA4X6Q>
    <xmx:MY86abzfI7tfZ92c3RA46EXtvBRE_4pGWhb5y1Yp5GcHtpTyx3-LgQ>
    <xmx:MY86aTasKj2pJvjxKht-FbCy-Uk6hccKtYu2_BU2xJjXwVX0vSuJSg>
    <xmx:MY86adTgfmU2w-eYOkOoXiIDdcqA0yg6jPa1qqsuOcUClAGXO5NmSw>
    <xmx:MY86aSXv7krZJRDVLmI_oWY5MMCzcmV18CrgFNpo_dn6v19fqV6CnDQk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 11 Dec 2025 04:30:24 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b4e1e542 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 11 Dec 2025 09:30:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 11 Dec 2025 10:30:12 +0100
Subject: [PATCH v3 3/8] odb: move computation of normalized objdir into
 `alt_odb_usable()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251211-b4-pks-odb-alternates-via-source-v3-3-00e3f54d07ba@pks.im>
References: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
In-Reply-To: <20251211-b4-pks-odb-alternates-via-source-v3-0-00e3f54d07ba@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.14.3

The function `alt_odb_usable()` receives as input the object database,
the path it's supposed to determine usability for as well as the
normalized path of the main object directory of the repository. The last
part is derived by the function's caller from the object database. As we
already pass the object database to `alt_odb_usable()` it is redundant
information.

Drop the extra parameter and compute the normalized object directory in
the function itself.

While at it, rename the function to `odb_is_source_usable()` to align it
with modern terminology.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/odb.c b/odb.c
index 699bdbffd1..e314f86c3b 100644
--- a/odb.c
+++ b/odb.c
@@ -89,17 +89,20 @@ int odb_mkstemp(struct object_database *odb,
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
-static int alt_odb_usable(struct object_database *o, const char *path,
-			  const char *normalized_objdir)
+static bool odb_is_source_usable(struct object_database *o, const char *path)
 {
 	int r;
+	struct strbuf normalized_objdir = STRBUF_INIT;
+	bool usable = false;
+
+	strbuf_realpath(&normalized_objdir, o->sources->path, 1);
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path)) {
 		error(_("object directory %s does not exist; "
 			"check .git/objects/info/alternates"),
 		      path);
-		return 0;
+		goto out;
 	}
 
 	/*
@@ -116,13 +119,17 @@ static int alt_odb_usable(struct object_database *o, const char *path,
 		kh_value(o->source_by_path, p) = o->sources;
 	}
 
-	if (fspatheq(path, normalized_objdir))
-		return 0;
+	if (fspatheq(path, normalized_objdir.buf))
+		goto out;
 
 	if (kh_get_odb_path_map(o->source_by_path, path) < kh_end(o->source_by_path))
-		return 0;
+		goto out;
+
+	usable = true;
 
-	return 1;
+out:
+	strbuf_release(&normalized_objdir);
+	return usable;
 }
 
 /*
@@ -164,13 +171,10 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 							int depth)
 {
 	struct odb_source *alternate = NULL;
-	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
 	int ret;
 
-	strbuf_realpath(&tmp, odb->sources->path, 1);
-
-	if (!alt_odb_usable(odb, source, tmp.buf))
+	if (!odb_is_source_usable(odb, source))
 		goto error;
 
 	alternate = odb_source_new(odb, source, false);
@@ -188,7 +192,6 @@ static struct odb_source *odb_add_alternate_recursively(struct object_database *
 	read_info_alternates(odb, alternate->path, depth + 1);
 
  error:
-	strbuf_release(&tmp);
 	return alternate;
 }
 

-- 
2.52.0.270.g3f4935d65f.dirty

