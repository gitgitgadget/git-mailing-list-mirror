Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E453918DB35
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920021; cv=none; b=EJ5bAnfO1lxfWAoWikA2b4rOn3Jwcf3hWFTde7X44OEx3h9DOkumXWEmTHcylazN2/nWetYDhfyq8xuvcFq2TmcbB7MGHLkjcqCEYnuPleO6QiwIGi9GUC6juFZNxBooqPT4/5UCqvH/VzGmjvgpDybBm8veNuHBOloH90wTK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920021; c=relaxed/simple;
	bh=pFevP/WRep6rfl0zspGiytbEmq0UWGhcNQUNVqEoujk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIOH+CbiWwkM2ykNwh/ckYSsGSvHf7b0rsJjiytXl8jjCyNuX0tyoBqQRGpjL0sU65vgYgh4SMbFd4CLchUVPN2tskFx1j4P5X4kc/Ddah7oA75WcAb41KU81QbrUh4/tzK+qEwepuZIut1uq6jssnCLi5Mfm52SR9HLxVH4r/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jZtS5ILv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=epMwy/As; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jZtS5ILv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="epMwy/As"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 08D2F7A00AF;
	Mon, 11 Aug 2025 09:46:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 11 Aug 2025 09:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754920018;
	 x=1755006418; bh=T2crL0vQy1HTkoKGt/YUmP2sY1lJtdf2OzXcysofr5A=; b=
	jZtS5ILv/7WdnGRrrJnAYXhkk9DkgDU5A4KTQy0Uu2pDkSDLL8o/gva5tqUgSCDP
	lXAhKQ+KoR+V7/4AOEgiK2p1+h/e/n5y7UqXT3zs6C6qSM70fxiaO8jO3xGqU7ar
	NQx3z2V71PUwhlQO1XLOOf3UfSzSU4xYjQip49qMhNb5VuPLSRqK/Xa9WkcAycMe
	yJtZAPm7EsbSWqlNnAxaqeDuBAtrBXLK7g2oZ6jtRfIXU1GCap4CPYxpZfaVfA2Y
	I6X40UhWESCfvEZOzPVJze6zpwPTSY27Q+CltlJz5W/5A5B12v6mCtYtK0ayCSoc
	xPbChmio/LB+4MxabwTK3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754920018; x=
	1755006418; bh=T2crL0vQy1HTkoKGt/YUmP2sY1lJtdf2OzXcysofr5A=; b=e
	pMwy/AsvTvW3WBOEZnMH4Ub/kEWKY0H1ZYZKce3oAfrTMwn7wFKGDkPwwdm3Cc3s
	JvfzzVVQniaXrpTceXG9zJceHIaq1RA7jdlume2l5sA890Ub32IIVZdzz2tN7nht
	R4aLjhkZcuJMDOoPvzichOUcWPGo61vItdtNmzs7s+PrvqcU/9lKouRuAjhXvDct
	Qh6EMFw9vDc9z+sQE2mik97+/lZibxiXObVDxN0yORHaArZjXem5PUU+CvAu14hu
	9L5QZKgEQln1hzfD41KR5r83EsBlaSPl+bPzRMn6UGx0B/Uo9aNw3e46oQRT8p1w
	QLBJTxv7tS1cRNZL5qTAg==
X-ME-Sender: <xms:UvSZaLV-tT-w9ZWSHeR_a3ke1ldwHleJIegIhasJB_4GJsVNa2lHrQ>
    <xme:UvSZaPEjDJjs-LBvQCP5RcrehHUYeJypv_1zaZBUi2Ym4qQJYX9rdBn3QhVaXEe_G
    VYJnr-OEjG0kZHj_A>
X-ME-Received: <xmr:UvSZaN39QkvDCLj7s66T9bIqE4OOAnddpR_t009wF4zo0_eNnyPUpdakbSlrlgC9tbJdJSWaGQPHbdsbaAj56RX3TkzoW5araxvDBgPjnbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhm
X-ME-Proxy: <xmx:UvSZaBNibB6ciOzZWBWMQVsqC7fOUTe9gWhutOsycr0a1rmVd13ZRA>
    <xmx:UvSZaM4twztXbwl6tHKBPRa6I2QmdNrFThGc7_Ekbn-YIoQ29rm6XQ>
    <xmx:UvSZaL3cYgHCTNaVvfILyRkd3Z_PLyOe3qqrmgKYTWzpbiE5jsiY6g>
    <xmx:UvSZaNwLF8VP7yrwb_9ZJmvNPQQIyCqLTdZoiMNgcrINLq-5_FztPA>
    <xmx:UvSZaPKYG32L6ONt9WPkz0CFbXsjSRR77RbQt8G-95imMuEGH59pYkJ1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:46:57 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d18f00e9 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 13:46:56 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Aug 2025 15:46:43 +0200
Subject: [PATCH v3 03/10] odb: consistently use "dir" to refer to
 alternate's directory
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-pks-midx-deduplicate-source-info-v3-3-e442bdf2b4ad@pks.im>
References: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
In-Reply-To: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>, 
 Derrick Stolee <stolee@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

The functions that add an alternate object directory to the object
database are somewhat inconsistent in how they call the paramater that
refers to the directory path: in our headers we refer to it as "dir",
whereas in the implementation we often call it "reference" or "entry".

Unify this and consistently call the parameter "dir". While at it,
refactor `link_alt_odb_entry()` to accept a C string instead of a
`struct strbuf` as parameter to clarify that we really only need the
path and nothing else.

Suggested-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 30 ++++++++++++++----------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/odb.c b/odb.c
index 4e7f14be4a..e41e3952ea 100644
--- a/odb.c
+++ b/odb.c
@@ -140,7 +140,7 @@ static void read_info_alternates(struct object_database *odb,
 				 int depth);
 
 static int link_alt_odb_entry(struct object_database *odb,
-			      const struct strbuf *entry,
+			      const char *dir,
 			      const char *relative_base,
 			      int depth,
 			      const char *normalized_objdir)
@@ -151,11 +151,11 @@ static int link_alt_odb_entry(struct object_database *odb,
 	khiter_t pos;
 	int ret = -1;
 
-	if (!is_absolute_path(entry->buf) && relative_base) {
+	if (!is_absolute_path(dir) && relative_base) {
 		strbuf_realpath(&pathbuf, relative_base, 1);
 		strbuf_addch(&pathbuf, '/');
 	}
-	strbuf_addbuf(&pathbuf, entry);
+	strbuf_addstr(&pathbuf, dir);
 
 	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
 		error(_("unable to normalize alternate object path: %s"),
@@ -229,7 +229,7 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 				 int sep, const char *relative_base, int depth)
 {
 	struct strbuf objdirbuf = STRBUF_INIT;
-	struct strbuf entry = STRBUF_INIT;
+	struct strbuf dir = STRBUF_INIT;
 
 	if (!alt || !*alt)
 		return;
@@ -243,13 +243,13 @@ static void link_alt_odb_entries(struct object_database *odb, const char *alt,
 	strbuf_realpath(&objdirbuf, odb->sources->path, 1);
 
 	while (*alt) {
-		alt = parse_alt_odb_entry(alt, sep, &entry);
-		if (!entry.len)
+		alt = parse_alt_odb_entry(alt, sep, &dir);
+		if (!dir.len)
 			continue;
-		link_alt_odb_entry(odb, &entry,
+		link_alt_odb_entry(odb, dir.buf,
 				   relative_base, depth, objdirbuf.buf);
 	}
-	strbuf_release(&entry);
+	strbuf_release(&dir);
 	strbuf_release(&objdirbuf);
 }
 
@@ -273,7 +273,7 @@ static void read_info_alternates(struct object_database *odb,
 }
 
 void odb_add_to_alternates_file(struct object_database *odb,
-				const char *reference)
+				const char *dir)
 {
 	struct lock_file lock = LOCK_INIT;
 	char *alts = repo_git_path(odb->repo, "objects/info/alternates");
@@ -290,7 +290,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
 		struct strbuf line = STRBUF_INIT;
 
 		while (strbuf_getline(&line, in) != EOF) {
-			if (!strcmp(reference, line.buf)) {
+			if (!strcmp(dir, line.buf)) {
 				found = 1;
 				break;
 			}
@@ -306,18 +306,17 @@ void odb_add_to_alternates_file(struct object_database *odb,
 	if (found) {
 		rollback_lock_file(&lock);
 	} else {
-		fprintf_or_die(out, "%s\n", reference);
+		fprintf_or_die(out, "%s\n", dir);
 		if (commit_lock_file(&lock))
 			die_errno(_("unable to move new alternates file into place"));
 		if (odb->loaded_alternates)
-			link_alt_odb_entries(odb, reference,
-					     '\n', NULL, 0);
+			link_alt_odb_entries(odb, dir, '\n', NULL, 0);
 	}
 	free(alts);
 }
 
 void odb_add_to_alternates_memory(struct object_database *odb,
-				  const char *reference)
+				  const char *dir)
 {
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
@@ -325,8 +324,7 @@ void odb_add_to_alternates_memory(struct object_database *odb,
 	 */
 	odb_prepare_alternates(odb);
 
-	link_alt_odb_entries(odb, reference,
-			     '\n', NULL, 0);
+	link_alt_odb_entries(odb, dir, '\n', NULL, 0);
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,

-- 
2.51.0.rc1.163.g2494970778.dirty

