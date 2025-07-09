Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C13A293B5F
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 11:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752059856; cv=none; b=FCYEfPLbq8WkYGgwQ73IFmJQR+g4lyoj0B+N3ENVV3WTDR2eRctr4FIB6DVVqSM7JoCr5abJtm7P31tb0+/mhTGVrf6IwMSKDppdygZ+S3rH3s+etzw6dzcpJJCsr8kyUNNlTVEWLyZoBp6CLFg8WHrmwY6EjRtsbbAsqQA/nQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752059856; c=relaxed/simple;
	bh=rNnT4M/eqpLgnFk4hdDc77kNnlW9K5KgEWJzMvuR9lc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eJRsReApUSPhQrD7J9UqBQgrueU95/WVfxxWhQDg4iKuotweMKucpkUBez8b4fjW3+E8u/dmJUiOor0aEAAEn+oRtdwQsfame3YCwC0atbDqpUYBuhVfsPh6khhhvM1URZ7VuexSjc8AQvv6l/eLPYi8BDhZCW/kDL5/8IZYp54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hvOWcPFh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mly4NINd; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hvOWcPFh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mly4NINd"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8086B1400332
	for <git@vger.kernel.org>; Wed,  9 Jul 2025 07:17:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 09 Jul 2025 07:17:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752059843;
	 x=1752146243; bh=KXPqIGXQifnahzZTeYSwgNWS0yusBcLANBkoSE7QbeE=; b=
	hvOWcPFhUNWWQmjmTXoWGzRHwV+xnSselXrABdGk0gNwEZcFJoK4XCplW9Phxn/1
	tAE//XHs8cseoSPBsL9xX/VAK7NjfaIiiHaGRh5vV6FKlD+oOkKIeJzfG0c4XubW
	/CmLZV27NjM5F7dOmiKlJIrd79+7FljpSc2ATmBN4rKXUhWyEm6E4SgYLDJDtf8L
	zEjsx+srivFKono5Y5T10IVGsKQKag+RA8xJGHdiZ8PoGL5OBypn7aGmL5ogtas6
	nNx1cBuDtHovEexDvlben9ZpV711Hm4Uc23yowH2vQg+YCiB/IIXRf+BOOmwEzn/
	d/zcL/Len4uYvWN+PUUquw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752059843; x=
	1752146243; bh=KXPqIGXQifnahzZTeYSwgNWS0yusBcLANBkoSE7QbeE=; b=m
	ly4NINdGDJq6HclqpH48U6qQmzYvpUwYzboIeeitxxl0Tx/DnKBEz4FtYA8FXgvQ
	aYWeEohPKz1kOJZ2shSwVUFQu06a3DCtj6mxfCYvaSJomZtr45LQWifMJxyjjxV4
	+0HyImdBITCovKaTBFemZR0QwkQqydJtixvmbz57JYlnaSrUhKqEsEny+eOOmmYA
	Y8Prz/YMO0/VYEbLqxeFCWPw8wH1jyBIuKUxw8BtMdCiBN8f2rTUDz1Y8TbkHSxP
	ipf1QgV20bX1Lt2vFJ1FA3MWYTRdQNVLi/Apgguy8U7AqB+XOQFMqY8FFu38R3J9
	ijdYn+mhlASJptITszpaw==
X-ME-Sender: <xms:w09uaLQrLhdAZL2PN3TaBD7Pn2ln6uj4WqhkrQbQDGPepHvQaivs-Q>
    <xme:w09uaOy-_jfI1W2AufEWkEci2PaycAaUJmo99MEm_JBDmDrx7KVsgMhQHXjlTDsD-
    RFVL-B-yZmJ_PGpJg>
X-ME-Received: <xmr:w09uaKPTBMkByxGzPuRIqk_6SqWmikGBQhIV5GijQ6mzvGMK9-L7c6h2ibQF2XkroYkHc_o6c9l1Fzg5EHlpOXY-ikKGbPEPjcV8hIkGK9dYvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:w09uaNODmwK09Rdp9FEDMH89nFcvTf7v_eVXDgJ1zXcTlhMQf0jvGA>
    <xmx:w09uaMSf1Ra7vjw1dng9s5DS7FetKIYiStngIRMyTbQX1ogHPBKuEg>
    <xmx:w09uaPAnLvZg5bKdtcOPKWoSbbgjxZIZHKZz7LRaKLqLOYzwBiDfIA>
    <xmx:w09uaLhAXBOy0bbjaHO47mFRVJj-TvwfIf3Sy7BD_aQXVJY9FWrspg>
    <xmx:w09uaIJDS44pKSYAIloQF3hAtqmt7z8rf3a2fgQpg6Up6joV6btb5g93>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 9 Jul 2025 07:17:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5fcd6fa (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 9 Jul 2025 11:17:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 09 Jul 2025 13:17:11 +0200
Subject: [PATCH 01/19] object-file: fix -Wsign-compare warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-pks-object-file-wo-the-repository-v1-1-62627b55707f@pks.im>
References: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
In-Reply-To: <20250709-pks-object-file-wo-the-repository-v1-0-62627b55707f@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

There are some trivial -Wsign-compare warnings in "object-file.c". Fix
them and drop the preprocessor define that disables those warnings.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/object-file.c b/object-file.c
index 3d674d1093e..987cf289420 100644
--- a/object-file.c
+++ b/object-file.c
@@ -8,7 +8,6 @@
  */
 
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "bulk-checkin.h"
@@ -44,8 +43,7 @@ static int get_conv_flags(unsigned flags)
 
 static void fill_loose_path(struct strbuf *buf, const struct object_id *oid)
 {
-	int i;
-	for (i = 0; i < the_hash_algo->rawsz; i++) {
+	for (size_t i = 0; i < the_hash_algo->rawsz; i++) {
 		static char hex[] = "0123456789abcdef";
 		unsigned int val = oid->hash[i];
 		strbuf_addch(buf, hex[val >> 4]);
@@ -327,9 +325,8 @@ static void *unpack_loose_rest(git_zstream *stream,
 			       void *buffer, unsigned long size,
 			       const struct object_id *oid)
 {
-	int bytes = strlen(buffer) + 1;
+	size_t bytes = strlen(buffer) + 1, n;
 	unsigned char *buf = xmallocz(size);
-	unsigned long n;
 	int status = Z_OK;
 
 	n = stream->total_out - bytes;
@@ -596,7 +593,7 @@ static int check_collision(const char *source, const char *dest)
 			goto out;
 		}
 
-		if (sz_a < sizeof(buf_source))
+		if ((size_t) sz_a < sizeof(buf_source))
 			break;
 	}
 
@@ -1240,7 +1237,7 @@ static int index_core(struct index_state *istate,
 		if (read_result < 0)
 			ret = error_errno(_("read error while indexing %s"),
 					  path ? path : "<unknown>");
-		else if (read_result != size)
+		else if ((size_t) read_result != size)
 			ret = error(_("short read while indexing %s"),
 				    path ? path : "<unknown>");
 		else
@@ -1268,7 +1265,7 @@ int index_fd(struct index_state *istate, struct object_id *oid,
 		ret = index_stream_convert_blob(istate, oid, fd, path, flags);
 	else if (!S_ISREG(st->st_mode))
 		ret = index_pipe(istate, oid, fd, type, path, flags);
-	else if (st->st_size <= repo_settings_get_big_file_threshold(the_repository) ||
+	else if ((st->st_size >= 0 && (size_t) st->st_size <= repo_settings_get_big_file_threshold(the_repository)) ||
 		 type != OBJ_BLOB ||
 		 (path && would_convert_to_git(istate, path)))
 		ret = index_core(istate, oid, fd, xsize_t(st->st_size),
@@ -1472,7 +1469,7 @@ struct oidtree *odb_loose_cache(struct odb_source *source,
 	uint32_t *bitmap;
 
 	if (subdir_nr < 0 ||
-	    subdir_nr >= bitsizeof(source->loose_objects_subdir_seen))
+	    (size_t) subdir_nr >= bitsizeof(source->loose_objects_subdir_seen))
 		BUG("subdir_nr out of range");
 
 	bitmap = &source->loose_objects_subdir_seen[word_index];

-- 
2.50.1.327.g047016eb4a.dirty

