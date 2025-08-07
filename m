Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214C8255F53
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754554217; cv=none; b=qt45TUTopVrILEOMYmRaYnTItD5akAUqx4zmMOA36BMj+Ib7G//wTWH4b/1B47Xw/Z+4MqOARbHCOfLKRa1d2u1PXIm8aQiJMYNTzt9o3Y+UOLjRS+f03Y6ipNuVpmGUgz5xSJO8S6gMNVQXXHqnfhWQm8/+0rHoLu5wwH577XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754554217; c=relaxed/simple;
	bh=J6947lxJPZJ7TrWt71zzTVWHOIx7dt+53FdjRSdV42M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qloxPSCpsOE6l5m5XxeWZtRgA9SxnzdBTiLtNQQCWb8DMnkXv7wgGjWWXngKhbJx+c22yLnseGa5iJgaL94SYzD40uoc4VjP5dZS2Csq0PysJMBP+lxKgOfr53842R6n2Lui/0LyPJQyy6/kCuorXlovPz/Uly/rgDcKiXGGvxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H9WWyk2r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KMMYQm8d; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H9WWyk2r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KMMYQm8d"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5466D1400143;
	Thu,  7 Aug 2025 04:10:15 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 07 Aug 2025 04:10:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754554215;
	 x=1754640615; bh=HKj7YWccqmwAlN0/GvuFGLtI3p3DKvhJkrfriUwT5yE=; b=
	H9WWyk2r4hxN1XJGMxMxOG9oS3OMa/V5BhZT4uxV9WkTiFctr9SUgoEtoazvj5Ek
	uib94XsBEe4xbSWDGgfCPXHjOuCIckxst7vYgTLST+JYaUtsisi8+vAWCPxOAM1f
	jK3V9dk/1uHEXtL8i62pHNjkz+wfxxoxG25OYxufBrouBf5Q1Vo4X0BLfzOB+aTK
	L8ue9WJm0wTRK1crjD3btzoB1LlqNDQbpNAXXw7o645CyD0MmAT/f+qgyfvQmABn
	7VTzn+iKFM7447YogPx+X3qIEXxrMx7am57NmZZsZZ+QmWXth/cHgA9lrknRWyBt
	Zm9z3Da+VXKNbMtxv3TUYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754554215; x=
	1754640615; bh=HKj7YWccqmwAlN0/GvuFGLtI3p3DKvhJkrfriUwT5yE=; b=K
	MMYQm8dAOM7KloVmYzR0CgGcltWlHKm5s8Hmiz3o4aGmxvKSX4rh+sc9vM/4TZ5J
	GvBF0AVwN5WDIIYGIYlIMoV65iSnpINi6ys9jLvBY0Kb4LZyrp5zyI9DmKLqLLEh
	MEq2cU2AeHnOvY8VtcHo4nM7UVwXwFzUs0BvZdFXglJz4P8/2kPpbXYF/3Remynq
	vyO6nXmoftjXgOea9D1wgti7eB0ZwKsWcXlhJK3vfGsiU0Ik15vf0LCkXSxKk6xO
	/HbONMyZWwJ8lkMv6u9Ts35n4kH3ylKI7zQNpPb0mRe6SsCAUHZLjAAcm31ZFGCA
	cCo7uKp2rAIB/mKBSW8fw==
X-ME-Sender: <xms:Zl-UaOxfwkEV94smw1JEeWdyqNZKIL-Rpbx94hAchAVr9deT5OR5Nw>
    <xme:Zl-UaNjn_uudYb6oL5Y5HMb9O34YfN2hw1RKC9KF79Obl62TrDCA5Y5HMJNQ50XF5
    C-Ui2YUG-TElkNBlA>
X-ME-Received: <xmr:Zl-UaJxKv3Pw6tKIidj10W0t7fU4z8La0nxVRTtv6xKlgVSyepLnhS5tALIFsry3SBEGhD4y7l_SUMKeJgblRYg1JTk1YZ0P54-yIvvPAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttg
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Z1-UaAJorJ9mMipKWBGRei1ZvWAXohoel6VrnHPYTPsVCTLyPUXoYQ>
    <xmx:Z1-UaASWQ4rRWJf65ISMUHSkMRjOHVM8gbCtI3qyWzU2_ipbStBF9w>
    <xmx:Z1-UaIqBEcmBI6gciEWgGB8eT0zTH5-09vL1uPr6yRjbqdnnEyHAgg>
    <xmx:Z1-UaFrkPNH1NTHQrpqIPFPgi-ARbWTNE1Fpvm8LyqhxQmQvix5V9Q>
    <xmx:Z1-UaI8acEpjhgbJ43OmpdyhN-vLYtQWC1S1A88i9Bylt3axVnzRbBp0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:10:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e4913ef6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:10:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:09:54 +0200
Subject: [PATCH v2 4/9] odb: simplify calling `link_alt_odb_entry()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-midx-deduplicate-source-info-v2-4-bcffb8fc119c@pks.im>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
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
index 7793816f81..7c28462c41 100644
--- a/odb.c
+++ b/odb.c
@@ -142,8 +142,7 @@ static void read_info_alternates(struct object_database *odb,
 static struct odb_source *link_alt_odb_entry(struct object_database *odb,
 					     const char *entry,
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
 	struct strbuf entry = STRBUF_INIT;
 
 	if (!alt || !*alt)
@@ -239,17 +240,13 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 		return;
 	}
 
-	strbuf_realpath(&objdirbuf, odb->sources->path, 1);
-
 	while (*alt) {
 		alt = parse_alt_odb_entry(alt, sep, &entry);
 		if (!entry.len)
 			continue;
-		link_alt_odb_entry(odb, entry.buf,
-				   relative_base, depth, objdirbuf.buf);
+		link_alt_odb_entry(odb, entry.buf, relative_base, depth);
 	}
 	strbuf_release(&entry);
-	strbuf_release(&objdirbuf);
 }
 
 static void read_info_alternates(struct object_database *odb,
@@ -318,20 +315,12 @@ void odb_add_to_alternates_file(struct object_database *odb,
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
 						const char *reference)
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
-	alternate = link_alt_odb_entry(odb, reference, NULL, 0, objdir);
-
-	free(objdir);
-	return alternate;
+	return link_alt_odb_entry(odb, reference, NULL, 0);
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,

-- 
2.51.0.rc0.215.g125493bb4a.dirty

