Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE2C188713
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920028; cv=none; b=mknkhzw8cPN9a4zHpElfcSUFQ7rbp2pgs1DNO+Vy9Kom8QRje+H2i8POrQN2zS/ULmzB4fIW8nTwB8uOMA56S9BWsnVWR9q3jF7mtkhegbZ+UON8EmwbITc7VuuXO9dWJeT9t4MGeP6c6NEOq5X+YI7SuiIyrKHDHOf5WpN5yXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920028; c=relaxed/simple;
	bh=akh2UYlXXAWdGpa0Ga32dbkKI4vUtf+vmryiMjryfog=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1jU4KhGT1TCfRtljOh4rolbGqbnp5MDV77q2lW71KBdhb2QUeyiVTwT7YoPcW5QM2jcSy6vU9ieCeJ5R4gsmgNMgI96i25GUBsr+YfBPwDEgBwwXgdiHJYb8+hTSDSCSLDhCGvzKDXN9N21tVSgvS7SAEbK0U0r9pVIrKIMRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LFR4LNA/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UG1u5PcC; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LFR4LNA/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UG1u5PcC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1F04E7A0077;
	Mon, 11 Aug 2025 09:47:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 11 Aug 2025 09:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754920024;
	 x=1755006424; bh=mdIlXs7HTg9OisKeB+65tXLYX5VKSEN+JVQrkMtI5oE=; b=
	LFR4LNA/wEW3JfT3EmzCYhS9oe7xQzQo7iKEs+hznYWmEXDIp6q0g2f/hOjnmMr9
	w2tiR3c1T0dI75WfH6AQ9HD0WHX+1rPRP/VNVlhK5ScKqIOlHFpnIihPR5lk1tDG
	lZUVb1BJSKdQvyOkuxJeXjUpBKurUldErt84nqEo4+QEFQjiTyGjJPREqzte6te+
	rCNc8zzM4gnX0MDELFgXt9dUWN2F647i830SW5ewAq3ivXBqPXfBy+2jBDoPNPwh
	XFwWsqepBL6hh73Ww/l/shs9ZhPdiyuHzXupxJq7hihrmJ9p76kZHeq6SUD7Obkh
	YUgfQAb/nFZFYQjcsH6KUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754920024; x=
	1755006424; bh=mdIlXs7HTg9OisKeB+65tXLYX5VKSEN+JVQrkMtI5oE=; b=U
	G1u5PcCTgfHpzmQGN3XiAx84FFqB5k16GvGz/Szz6Rk7qb8J9n/3PUZezXL+81La
	y8chWj0AgbN3F527X8Q9MT7fDmPrskUSTX++1u+vgIhnkNi7gwzTLMs3+ou3BHXN
	Ht94b0ZjoBw0xOcVUCAQ0M27wDheQfT9O95erpXsAHO6kWh4TeJRULcz7uSdHjfy
	/2mEmE0X8B85X6+ps0oW/OHTbkYK1v78VhNZ+YfP3ErEgszMUbobA9sqL992lO5J
	5fXvm1WDqeK6cviDKqEXhCCnoBy6jW/tVHNZ3LJJhFjEGHNRbv576kZbxxtK3SrV
	uit2nONODOOSQOAH+35RQ==
X-ME-Sender: <xms:WPSZaIyjiJ8OqQLCVoZIQWrEav8CRoiDPFdq58RdSR-2shsAxOEOpw>
    <xme:WPSZaHz9P4BDJmUmsKsb5uXF8VmcGCaB_IwyzXldDWWIMGQW2QPSLShKTJzyGTN97
    SLYZoffPEWdSoUyYA>
X-ME-Received: <xmr:WPSZaAyA7dSz-71BrFaOcqu_hDNcuwgqJecmAZaLciDMQEnmOLny-MFOHGeokyrCcrmIR6cOFR8UkDuGFHSXkfSkybCRmQmqj1zC1qlFHu4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehtohhonhesihhothgtlhdr
    tghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepsh
    htohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:WPSZaBYKULJNUN3RIn2RlrHyNCn60JPGtXPdN1Yu88I0UcV7Cy6y5w>
    <xmx:WPSZaBVpaDmpPOlWlHyv4Wdbt6DDriD2XVb1G81xGp5AHEZ7Vtj0lw>
    <xmx:WPSZaPjjcquwbKNgZBaRervyNMJMXA6aIxNgy6Jtp2oq-trpCl96pA>
    <xmx:WPSZaPshzWjmOQ_RjBghMWxnVhEi9h9EP-eqXw01___uOqq78rb3Ew>
    <xmx:WPSZaJXlZnrohZCNtOmaWF2XVbM_6GvkNP_E8JL1ZNJA5tw0F7-Zoz1l>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:47:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c635dd9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 13:47:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Aug 2025 15:46:45 +0200
Subject: [PATCH v3 05/10] odb: simplify calling `link_alt_odb_entry()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-pks-midx-deduplicate-source-info-v3-5-e442bdf2b4ad@pks.im>
References: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
In-Reply-To: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>, 
 Derrick Stolee <stolee@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Callers of `link_alt_odb_entry()` are expected to pass in three
different paths:

  - The (potentially relative) path of the object directory that we're
    about to add.

  - The base that should be used to resolve a relative object directory
    path.

  - The resolved path to the object database's objects directory.

Juggling those three paths makes the calling convention somewhat hard to
grok at first.

As it turns out, the third parameter is redundant: we always pass in the
resolved path of the object database's primary source, and we already
pass in the database itself. So instead, we can resolve that path in the
function itself.

One downside of this is that one caller of `link_alt_odb_entry()` calls
this function in a loop, so we were able to resolve the directory a
single time, only. But ultimately, we only ever end up with a rather
limited number of alternates anyway, so the extra couple of cycles we
save feels more like a micro optimization.

Refactor the code accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/odb.c b/odb.c
index 0c808bb288..4f884e3b50 100644
--- a/odb.c
+++ b/odb.c
@@ -142,8 +142,7 @@ static void read_info_alternates(struct object_database *odb,
 static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 					     const char *dir,
 					     const char *relative_base,
-					     int depth,
-					     const char *normalized_objdir)
+					     int depth)
 {
 	struct odb_source *alternate = NULL;
 	struct strbuf pathbuf = STRBUF_INIT;
@@ -170,7 +169,10 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
 		strbuf_setlen(&pathbuf, pathbuf.len - 1);
 
-	if (!alt_odb_usable(odb, &pathbuf, normalized_objdir, &pos))
+	strbuf_reset(&tmp);
+	strbuf_realpath(&tmp, odb->sources->path, 1);
+
+	if (!alt_odb_usable(odb, &pathbuf, tmp.buf, &pos))
 		goto error;
 
 	CALLOC_ARRAY(alternate, 1);
@@ -227,7 +229,6 @@ static const char *parse_alt_odb_entry(const char *string,
 static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 				 int sep, const char *relative_base, int depth)
 {
-	struct strbuf objdirbuf = STRBUF_INIT;
 	struct strbuf dir = STRBUF_INIT;
 
 	if (!alt || !*alt)
@@ -239,17 +240,13 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 		return;
 	}
 
-	strbuf_realpath(&objdirbuf, odb->sources->path, 1);
-
 	while (*alt) {
 		alt = parse_alt_odb_entry(alt, sep, &dir);
 		if (!dir.len)
 			continue;
-		link_alt_odb_entry(odb, dir.buf,
-				   relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(odb, dir.buf, relative_base, depth);
 	}
 	strbuf_release(&dir);
-	strbuf_release(&objdirbuf);
 }
 
 static void read_info_alternates(struct object_database *odb,
@@ -317,20 +314,12 @@ void odb_add_to_alternates_file(struct object_database *odb,
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 						const char *dir)
 {
-	struct odb_source *alternate;
-	char *objdir;
-
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
 	odb_prepare_alternates(odb);
-
-	objdir = real_pathdup(odb->sources->path, 1);
-	alternate = link_alt_odb_entry(odb, dir, NULL, 0, objdir);
-
-	free(objdir);
-	return alternate;
+	return link_alt_odb_entry(odb, dir, NULL, 0);
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,

-- 
2.51.0.rc1.163.g2494970778.dirty

