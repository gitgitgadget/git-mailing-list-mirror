Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878D01E492D
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 13:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754920024; cv=none; b=n28Wxzucgs8lxw6VkXV376P5KWX5vyAgWYX/B26XbooraPnadvRBlwvPNcRFE9x/bGPHDjEgdWUY1RHQ+eDpDF2qnFUAW4C6odxZjK4YspuDLackF7yvIBaT6fteKgO0BlpQuoMxBQxEwBdtVIvq9x+dz6Vw66A3cYC6vCqN/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754920024; c=relaxed/simple;
	bh=WmwDTwI3MFJlL2OKAD7MQDzvJ3z1mOpxMyhp5qxJgO0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jzNlGpQwOZEP4tkp/iXAt4JAPXJ3t+97qsfWk5nwtuS8DrjoaYLFSbgcKW2ldwZubp0m2sKhKgF0tKGfUNxIuL2tBMvfBZqHe06Vq61vkM1z2oRuNhp2cldgWD8aGQJOrsZDcZ9uQe4kMiFbuzFdpvscuOPtkwfiTWLMLD0RKe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vt/JzmL7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=etVpLivi; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vt/JzmL7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="etVpLivi"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 8BB3E1D0005F;
	Mon, 11 Aug 2025 09:47:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 11 Aug 2025 09:47:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754920021;
	 x=1755006421; bh=Rv8ktnZtwKqqVpe2l2DhMfYv8HNbqiAv5iBgU9bNxN0=; b=
	Vt/JzmL7eDXg4ecIE9V3uElqgKdgP8kmI+uBmYAsQJUpSerKdD/hyip4kEl/iHa9
	ZI21UHY1ngb9V09PNHXgowBgrKa/vlVSyzMdiI6pvfd6OAHwpuAznssMnAC9wKvN
	xN0rRhAr9wfQ3mV405BRh50oCfbtIIh4GWGe2p9LanxyBThUQH8jGQjndOJS0r+i
	zgxUfS7uM7XHR86k9n9K87oS7PnGul4g4dAlJAAKhiNEv1P2St+8obyNKYSTBXUO
	jXFqy+6+uWZNPE95zr/h6MKWqu6hNUx/m8G3smsoow9rdy54MjPvl5TMIh+AZ/9Y
	Q94Grr6ve10CWKRUvP9tvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754920021; x=
	1755006421; bh=Rv8ktnZtwKqqVpe2l2DhMfYv8HNbqiAv5iBgU9bNxN0=; b=e
	tVpLivil2ZDpdEvFFJxNUrAE0B/6gRoJSExiztmD7glJ+MnddzUlha3H1o64Cal/
	msxKnwgxZ/eghb3ipJmyQv+SS9f8rroAIV9v/Nt6ADZxIJVY5O9IRi/gS7y/AUbA
	dA9hb8l2qkIqd5+51dZHim35uCeJXiKZcQdHElIAXjofooQhIUIqH/6Aub6hUUEv
	Jwc3mV6SxQaNOsQ7KaPNr0jnWhk5nShhnbZMUVui6eXtTg8VjE9cREoA6H1QOXsC
	/NaxHhc7WERfL32Agv7yUwOZ6nI0QfEkNzktZpgc2IyfMcB4Ad9yqSpSgXp/Hc/F
	sQGr/8UWvo3qxHzK/zb6w==
X-ME-Sender: <xms:VfSZaHLcTLPTx1S61_JWZH4AXhIpFT-msX9hjfb8A3B6glk2xi1Pmg>
    <xme:VfSZaGrb8h2ZeWP5FsSVSn8_QGyGj56JxPkouLk3LClsysmHIYr4Cz9XWmZ-2MLGr
    _IQo2F9H_eBPhqraw>
X-ME-Received: <xmr:VfSZaGLS4airIM2Kl9SW-Xp2noC3t0efxKgfACYQWHmMv5OA_ln7XmxnNdvr296FcmDQZ0k56WZfGt43QyR0e39rronF1fQcPN37XEQbOSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvse
    htthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepsh
    htohhlvggvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:VfSZaLRcmO4T5_CXsBnhHXzlGpLxhckxgSuIxpFYUk_vNI-s8rzJ8A>
    <xmx:VfSZaFuKFQxwrVBsGkp4Bzd1FUDZovOUKug5cXsam6de-FvuI8o1rQ>
    <xmx:VfSZaMbylksu40gLBeuOwNt0OpExylMjAZRE5oJYPsPhza9QlNJX2w>
    <xmx:VfSZaLGDXEcRddApkverRg4vCZ1mlnlmC17EvPWRbq-RX3O4qAHZpw>
    <xmx:VfSZaHPWDOX-DHHFSnzcbAs3nm1tOX85iTG21AAgsi03UpaLFuLLIAGF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 09:47:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e29fce97 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 11 Aug 2025 13:46:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Aug 2025 15:46:44 +0200
Subject: [PATCH v3 04/10] odb: return newly created in-memory sources
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-b4-pks-midx-deduplicate-source-info-v3-4-e442bdf2b4ad@pks.im>
References: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
In-Reply-To: <20250811-b4-pks-midx-deduplicate-source-info-v3-0-e442bdf2b4ad@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>, 
 Derrick Stolee <stolee@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

Callers have no trivial way to obtain the newly created object database
source when adding it to the in-memory list of alternates. While not yet
needed anywhere, a subsequent commit will want to obtain that pointer.

Refactor the function to return the source to make it easily accessible.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 30 ++++++++++++++++++------------
 odb.h |  4 ++--
 2 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/odb.c b/odb.c
index e41e3952ea..0c808bb288 100644
--- a/odb.c
+++ b/odb.c
@@ -139,17 +139,16 @@ static void read_info_alternates(struct object_database *odb,
 				 const char *relative_base,
 				 int depth);
 
-static int link_alt_odb_entry(struct object_database *odb,
-			      const char *dir,
-			      const char *relative_base,
-			      int depth,
-			      const char *normalized_objdir)
+static struct odb_source *link_alt_odb_entry(struct object_database *odb,
+					     const char *dir,
+					     const char *relative_base,
+					     int depth,
+					     const char *normalized_objdir)
 {
-	struct odb_source *alternate;
+	struct odb_source *alternate = NULL;
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct strbuf tmp = STRBUF_INIT;
 	khiter_t pos;
-	int ret = -1;
 
 	if (!is_absolute_path(dir) && relative_base) {
 		strbuf_realpath(&pathbuf, relative_base, 1);
@@ -189,11 +188,11 @@ static int link_alt_odb_entry(struct object_database *odb,
 
 	/* recursively add alternates */
 	read_info_alternates(odb, alternate->path, depth + 1);
-	ret = 0;
+
  error:
 	strbuf_release(&tmp);
 	strbuf_release(&pathbuf);
-	return ret;
+	return alternate;
 }
 
 static const char *parse_alt_odb_entry(const char *string,
@@ -315,16 +314,23 @@ void odb_add_to_alternates_file(struct object_database *odb,
 	free(alts);
 }
 
-void odb_add_to_alternates_memory(struct object_database *odb,
-				  const char *dir)
+struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
+						const char *dir)
 {
+	struct odb_source *alternate;
+	char *objdir;
+
 	/*
 	 * Make sure alternates are initialized, or else our entry may be
 	 * overwritten when they are.
 	 */
 	odb_prepare_alternates(odb);
 
-	link_alt_odb_entries(odb, dir, '\n', NULL, 0);
+	objdir = real_pathdup(odb->sources->path, 1);
+	alternate = link_alt_odb_entry(odb, dir, NULL, 0, objdir);
+
+	free(objdir);
+	return alternate;
 }
 
 struct odb_source *odb_set_temporary_primary_source(struct object_database *odb,
diff --git a/odb.h b/odb.h
index 312921077b..d769132699 100644
--- a/odb.h
+++ b/odb.h
@@ -268,8 +268,8 @@ void odb_add_to_alternates_file(struct object_database *odb,
  * recursive alternates it points to), but do not modify the on-disk alternates
  * file.
  */
-void odb_add_to_alternates_memory(struct object_database *odb,
-				  const char *dir);
+struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
+						const char *dir);
 
 /*
  * Read an object from the database. Returns the object data and assigns object

-- 
2.51.0.rc1.163.g2494970778.dirty

