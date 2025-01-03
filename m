Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7300D1B0F2F
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892403; cv=none; b=BLbfjMo1lL4I4LtvNn2gY71hyBgh8wXaO1Bo8GeSnLGt81W//U/EQsXIPlh/1x4zCHv/87heru+1gqf1FXe+XxN5+1JDzU/yeuHUAm+EtRBPJfqbYBiCRHu0l4NQ//S/f8SVM7vBoeyEpV8bYnjqB/zo6UxiJYImjYwt3o7uhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892403; c=relaxed/simple;
	bh=Yecie3bOF+oz3gJFjP7BQeueiq/+WLtZclQ4XTLqj9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=okSWUBBZZtnfvBNnPAUU1OGTuGRmy5U6zJrwVFmKv4zD/bnRKvaA2zVQaXdsmAt1IWqqoY/luJFS048hORGMl2HawS5XgTxo8QU9GGW8hHuo37HdyL8UeLyESr0TP3U+qIF9m87pr2enVerQpmLMeCHoPRcK7TGkVp146wXQWR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=PdDPA1SY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QufSZn7T; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="PdDPA1SY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QufSZn7T"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 457271380765;
	Fri,  3 Jan 2025 03:20:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Fri, 03 Jan 2025 03:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1735892400;
	 x=1735978800; bh=5JiR9G63LBfT6y54TeulAYvTl95J6xjuYddh42Vt1j8=; b=
	PdDPA1SYMwcAX2E2TlojwaGRQNoU5o1W7LyuaALQjY1fesU3trROrWRD2giSrDXn
	ScedKb0hNf60Te3G6ycYGKF+6BTtA1BdVgtb3dBTxXLoyySYW4MZnq9Dwuv6EMS4
	5jxIzMfzfWZ1GD1lr35uXv41EUWowa57caOaW53k6BEzSao5g9Ej0D1CzXq2j29V
	vHoenX1XQcW8Wi2gqCiFeMjNQXS2zzmODSD3PWzU3GZSohUljdWDjVjKSseb+xC3
	mkw/eetaRwR/R6iMqG9XRyzXZkGBSC7MCkmTsDyoFCiJi69H8JlN/NCmvTMft7PT
	frQmkWo6+KuFayP1C//F4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735892400; x=
	1735978800; bh=5JiR9G63LBfT6y54TeulAYvTl95J6xjuYddh42Vt1j8=; b=Q
	ufSZn7TiDxIVh61H8V9Cx1hGuDTgPOjFrHzoJYIQNdyjGapTxjnqczNgKsxcjR+c
	Z8Da8NqSk3PgMv1XvTU64X2sYFSl/CjGkacIaWEI/Z/nwq5f3TorXoNuPZVp8dU9
	R8x/B7uVuP+9BaCJwkrQbHJxs84Y5rjb2bH7NFuzsXDzdVzvvns5qSBf58N4CMhy
	nL+66sbG7kkmkmDBsoQv3WdtoQajQG/n+FZankkPY5+4Y9OBggnuBL45DPIBbAKP
	fZ97rl8R2+lV5I1AMG+3EPbftfbqWTgJh50PaMH+qC4Mo4/otC2wiMq4lG2zoNDN
	kaIVCxaCBjbJ6vIXzThmw==
X-ME-Sender: <xms:sJ13Z7VJHznxsLT7rKQYO-g0eg6jd5z3jNmQFvA4lrWDzAJ2zVHgfA>
    <xme:sJ13ZzkcXZ9bFFV9RpJiekmNTU5uKf-k_pyFcdgQ_qG2k4QpGA95Tlbx6y3UDvubm
    wLOF6wP-lTSmfHKEA>
X-ME-Received: <xmr:sJ13Z3aS7OvadQfazlhwY3jKJ1SNO8jKPI9UB1_y0fytB3Lp12t2wxP_AHu19YCFvAbgM9rJAg-PA5n-SM7GF-qYN8Z5X82ie9HndqxFSBG1IqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeffedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephfffuf
    ggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeffueeiud
    ejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sJ13Z2XM-5xHJebZprM_GXT6vnkI3jKiaMMOg6GtEmsJXE2iJcuk9g>
    <xmx:sJ13Z1mJOFBPHpgonaM_pLwxyAHF8_EOxwTOWldZaF26Xtk3PhRo_g>
    <xmx:sJ13ZzcNa0CSk6dsGv_v9ZPEtczEOOFAIhQZ5zzwJuN6uV9TXwyrXw>
    <xmx:sJ13Z_Gbxe7RrFaWGUGIZkuZsnMOE8y8PEuym4rn5VSJU0CxGQB1zQ>
    <xmx:sJ13Z7hCncJ-C9-Lt9ntRcM4JrRAhISIXh_hIEjEYPmEanK9n9XKJRnf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jan 2025 03:19:59 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a82ed682 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jan 2025 08:19:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 03 Jan 2025 09:19:55 +0100
Subject: [PATCH 2/2] object-file: retry linking file into place when
 occluding file vanishes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250103-b4-pks-object-file-racy-collision-check-v1-2-6ef9e2da1f87@pks.im>
References: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
In-Reply-To: <20250103-b4-pks-object-file-racy-collision-check-v1-0-6ef9e2da1f87@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

In a preceding commit, we have adapted `check_collision()` to ignore
the case where either of the colliding files vanishes. This should be
safe in general when we assume that the contents of these two files were
the same. But the check is all about detecting collisions, so that
assumption may be too optimistic.

Adapt the code to retry linking the object into place when we see that
the destination file has racily vanished. This should generally succeed
as we have just observed that the destination file does not exist
anymore, except in the very unlikely event that it gets recreated by
another concurrent process again.

Furthermore, stop treating `ENOENT` specially for the source file. It
shouldn't happen that the source vanishes as we're using a fresh
temporary file for it, so if it does vanish it indicates an actual
error.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index e1989236ca87e565dea4d003f57882f257889ecf..88432cc9c07c3c56ce31a298a0ee90e5b5acbaff 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1970,6 +1970,8 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
 	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
 }
 
+#define CHECK_COLLISION_DEST_VANISHED -2
+
 static int check_collision(const char *source, const char *dest)
 {
 	char buf_source[4096], buf_dest[4096];
@@ -1978,8 +1980,7 @@ static int check_collision(const char *source, const char *dest)
 
 	fd_source = open(source, O_RDONLY);
 	if (fd_source < 0) {
-		if (errno != ENOENT)
-			ret = error_errno(_("unable to open %s"), source);
+		ret = error_errno(_("unable to open %s"), source);
 		goto out;
 	}
 
@@ -1987,6 +1988,8 @@ static int check_collision(const char *source, const char *dest)
 	if (fd_dest < 0) {
 		if (errno != ENOENT)
 			ret = error_errno(_("unable to open %s"), dest);
+		else
+			ret = CHECK_COLLISION_DEST_VANISHED;
 		goto out;
 	}
 
@@ -2034,8 +2037,10 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 int finalize_object_file_flags(const char *tmpfile, const char *filename,
 			       enum finalize_object_file_flags flags)
 {
-	struct stat st;
-	int ret = 0;
+	int ret;
+
+retry:
+	ret = 0;
 
 	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
 		goto try_rename;
@@ -2056,6 +2061,8 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 	 * left to unlink.
 	 */
 	if (ret && ret != EEXIST) {
+		struct stat st;
+
 	try_rename:
 		if (!stat(filename, &st))
 			ret = EEXIST;
@@ -2071,9 +2078,13 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 			errno = saved_errno;
 			return error_errno(_("unable to write file %s"), filename);
 		}
-		if (!(flags & FOF_SKIP_COLLISION_CHECK) &&
-		    check_collision(tmpfile, filename))
+		if (!(flags & FOF_SKIP_COLLISION_CHECK)) {
+			ret = check_collision(tmpfile, filename);
+			if (ret == CHECK_COLLISION_DEST_VANISHED)
+				goto retry;
+			else if (ret)
 				return -1;
+		}
 		unlink_or_warn(tmpfile);
 	}
 

-- 
2.48.0.rc1.241.g6c04ab211c.dirty

