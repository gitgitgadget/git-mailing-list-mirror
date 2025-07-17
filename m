Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA75BE5E
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728201; cv=none; b=F09QuSAO1dlK/l00rzk6SGNOPPs0pgtREZDK1Atr8gnHWzmGDNh/W7dihlO5LnOulw4sDIr+1ztXxp7t+3F9nNhJrYZgTxANkG9AmnCvkFLhhM7upehrQqRG0y2rq8zKMVm/tQ0BEf0B5hSwiDsyUD1XwPzySRiAP9SJmiyBcn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728201; c=relaxed/simple;
	bh=JpcczZ55IJiVVQJ22ML4wLjtdyogzv238s4+eqSmX60=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P6bJdDR8Dlt2vd5mZjVBnbIXuKxlXDjVih1t3KKG0Mqiwz9zlROWSp5y8bpU7oFa8uV5U5k4uK4m5QOxpRVKC8PYwNrz1RH0itc/8kQJ3N88EkydUQzKrbsjc+SNfdUc27c9SMge5J3lY+Vbj+XyiG/vA5oC6hRaWEStIH3lQlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pi2Cno1m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hjgCXQME; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pi2Cno1m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hjgCXQME"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 782011D00192;
	Thu, 17 Jul 2025 00:56:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 17 Jul 2025 00:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728198;
	 x=1752814598; bh=IglXoeH2/wtOojWGTZ4rkK3hxz15SyZJNon24HPGqMg=; b=
	Pi2Cno1m8zeUwAt6jk/hXggtey6uXxThnOtiBvhhg7T/5O97yykEc3+itpxrTPgR
	0yNwZEcvSPC3GODH4BJVcsbimA6RktrgcBHE6mbg3/wk+gdRZXLBxxmMuP5ZPp7j
	GIPc4qOFehm0qI424RdAyOkEr9PYMnbfXe7W+EIbmXRxXYQAf07oDYUjKK6ehStH
	w9S6EFlwqYEa4pxuuPeg09tY9c5qGyiEEsv9H57ceJXBahty6zIqoTmkZRcVHlq4
	SQvtZ+fqljCk+ls4wcWhSXsfb65rUR5JDchHVSPmeMuLwymSEe1+FxRE3ELc25kB
	MnVZ+6gBSD67GtvmlleNBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728198; x=
	1752814598; bh=IglXoeH2/wtOojWGTZ4rkK3hxz15SyZJNon24HPGqMg=; b=h
	jgCXQMEf3O8HAmF4iXW/HfOXIq60YTsalXYZGqA1yUHcoZVs3YnYg6Ug9//K2luY
	QVzFDYZnbqQs4YH6XXTKASY+C6vdEX2nPqJluDQnhvFkFSaa/hTHIIFUg5L/gErR
	brQGl785+V8r8XbSn/soyRoPcrotFI4/19rGxWf+/RaK2m2x6S/Jd9TSeyphz8h1
	nrWyhQAWqMmdUKJ/YAl0WY6ih6boXwr+x2v3vE4QNJyuaESVI+MKSMqrjKKZCGGE
	4aECdQxN3QlpOXnq06goV2yO6vQcdDCIkcACsXmCFOlma7cdHhVyIsZQSsEx9igG
	Xl/ne/nD9v1BgUOffnpvg==
X-ME-Sender: <xms:hoJ4aLD4TpPe-8tcKekZq7M4c7T6ikuzxlIw5cTC9qoiqiCvFBvCCg>
    <xme:hoJ4aNCVYDHc0PpnnzF0F8O6F_uCJCqr3rK95W7NWejDw7_N2KSjMtV7RzIw1nojT
    mUfvOlHZlDtgFQirg>
X-ME-Received: <xmr:hoJ4aNDTGc77Izr4OMLfai3HDKoYfHn_PyztLa3nSXC20NIlZVGT3OMTGot3MSF75u6vzize8NlwzkfQm5HNocj61JZlqO3R9SpeNdKFD-vj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:hoJ4aIrMIc4T-W8Qvma3IQXdONkf4O-RlrkpCAanVRvUsgWCJxGnVA>
    <xmx:hoJ4aHlsXGFRCu33cuo4VmXSjm81SZYpCDLpehGkzoyy5rVQ452QMA>
    <xmx:hoJ4aIwtlMHrL_1oNQ_QjTlRVyzWkfXP331i3QdpDzZ_Ie3AQ6bthw>
    <xmx:hoJ4aP9thOlOJNJexuHOzHOwQwiFJdyvu2u-UeUIPBQZqmJc8m8WdA>
    <xmx:hoJ4aD-plU_i33ViJ6S3TIaUQlxKLkIbLV89SeDUISAJQIkrmuGTAqyg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:56:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 67628b73 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:56:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:27 +0200
Subject: [PATCH v2 01/16] object-file: fix -Wsign-compare warnings
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-1-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
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
2.50.1.465.gcb3da1c9e6.dirty

