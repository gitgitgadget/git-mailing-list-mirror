Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CDF212FB6
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 07:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745913149; cv=none; b=r24QjrwKVwzOVJX09Csy3FNY3QxIZWKK6EqOE3KgoyrHJhmD4RMhf/ZyFbw0TDfOchAeMpc/cIjpzVfYElGjdkT3R5R8PB8COiR5IMPlss7jfK5hH2XJlf76tDRR6JDEXg0we0ipWemoxOEFDplfSOPHN/z9kEBLKOVDZ+paGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745913149; c=relaxed/simple;
	bh=gm5aqYOHiytoRq0fkyMa+fMr6XdCHqzRUGVvHSLxGzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxe71FufFqtjLjKUGcqKT4veAM0nNEg0eGXeK6gG5qCmLI2bp+CPBSdQ1YnBZp42ntv+1hssNUQKdtIt7E4be2qoRG96zu7XuV4x9JHO+QNdDpleTP0HjwUToEKSz7Mwb97hFsRABxqqOfTLfUY6vtMSupuDZdEDMk1ac/gRd2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EEvpI3kR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ptubdTi1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EEvpI3kR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ptubdTi1"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 155941380516;
	Tue, 29 Apr 2025 03:52:27 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Tue, 29 Apr 2025 03:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745913147;
	 x=1745999547; bh=cWM5vbezVRPcOL4zkLBba29O/MXgb7gFI13Y/Pzqt60=; b=
	EEvpI3kRhcs5UUasTilylVtDbcEmSnTy+U5P6iKQahuDrO6rUivXWko7jsyCkz2Y
	4TLug8cHN/lHFM1Qr3RGdfzHEuKnBBk37imhj9drGTdC277ruvUsXlhm5zKlkGAO
	n6/05gh8yHwg/nIB+K0NpZrE1OdH02CcGBlBExySyZYgNLa2zMRUzBmFuyx55qog
	ReZbEUzsKQEM5G9TIbCv3kGHDqs6cojJYiw9W4+7s72NUb/oktUoa0jymLQZQAO0
	Aqr6XIQIUsZmv9SHl1ZZQ2K2V/5lf6rkywfDQFt+mGfbSJpF2BH9ss9MqOmyjRlF
	3o563q9+c1GiiSkjMERe8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745913147; x=
	1745999547; bh=cWM5vbezVRPcOL4zkLBba29O/MXgb7gFI13Y/Pzqt60=; b=p
	tubdTi1RpqlGq4x+oYXn7wysx6wRvPgP+SUQtb8DLvO8BdMR2RtkeBSpPwJZpgJ3
	ex6W8F9UR0e+L3/9S4Yryos4NMOv4wZKWcgqhny7m6RTUZphDkUMfurC0nc6FkRo
	E8YqV7jRed4VEOC6LTzQ9R2nZj6Ps+ZQrbNjWzi7AlOYq6GmNt+9WozEYyaWm84q
	kdrblDn1l4qobYXzIoJ7w1KQKtsZVoz64G7VVzFNTT3w/X0pDYLLYnm3DypvJBL1
	krXIHnP5QbiVfzI/WqbauVBP+cUxsF1e0xkN8yrFIJNrCX1ehfHoPjWqWVh9QamB
	/Z2pL7ksN7L7gATEpnnRw==
X-ME-Sender: <xms:OoUQaO874s74KrF-P6MXc9lgs7xJ3abSmsdhafEl6CDCCTuCKUGrZA>
    <xme:OoUQaOtadiKzP8TE2XJAYfgroI3spxzrYsKpTiyQDtKCd_WPRsg_k5Ryc6okuQxSd
    aymo-XKsoZo8Zm0-g>
X-ME-Received: <xmr:OoUQaEAwGJTfPyewJ28IkTxjbabjHpbK_WK4e4nDB8Ptar37ASWkZSmCkrAxQjVmN1zL9SQA-ZCWCdulHTjTZYtmQKSRCwUlJ51kmZZ9adw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieefvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:OoUQaGd3iQlGIZww-esWmLVNqxHpC3QCxciR6rjW13H245Ad4ar6GQ>
    <xmx:OoUQaDMlBjJbq07Aivx1jtNJ-j6m2a11dRMtSHijSGWfGYNmSRO4nA>
    <xmx:OoUQaAlF9Nfa4Tnkx4gh2iWD1VWINpalwATS0_nADHYjcSPBeZBdpA>
    <xmx:OoUQaFsM8U1IKhLubdNlcqyBFDvxvGmQk1mYAKdm3OzQesPSTprGoA>
    <xmx:O4UQaP5gulLJ0_Ybm_Y_BkuZVEQ9ClN1IKWXuuHbBw5t3pWVzwuuKWzt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 03:52:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 642539f6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 29 Apr 2025 07:52:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 29 Apr 2025 09:52:17 +0200
Subject: [PATCH v3 3/7] object-store: move and rename `odb_pack_keep()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-pks-object-store-cleanups-v3-3-42902bad09a1@pks.im>
References: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
In-Reply-To: <20250429-pks-object-store-cleanups-v3-0-42902bad09a1@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

The function `odb_pack_keep()` creates a file at the passed-in path. If
this fails, then the function re-tries by first creating any potentially
missing leading directories and then trying to create the file once
again. As such, this function doesn't host any kind of logic that is
specific to the object store, but is rather a generic helper function.

Rename the function to `safe_create_file_with_leading_directories()` and
move it into "path.c". While at it, refactor it so that it loses its
dependency on `the_repository`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  3 ++-
 builtin/index-pack.c  |  2 +-
 object-store.c        | 13 -------------
 object-store.h        |  7 -------
 path.c                | 14 ++++++++++++++
 path.h                |  7 +++++++
 6 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index c1e198f4e34..b2839c5f439 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -811,7 +811,8 @@ static char *keep_pack(const char *curr_index_name)
 	int keep_fd;
 
 	odb_pack_name(pack_data->repo, &name, pack_data->hash, "keep");
-	keep_fd = odb_pack_keep(name.buf);
+	keep_fd = safe_create_file_with_leading_directories(pack_data->repo,
+							    name.buf);
 	if (keep_fd < 0)
 		die_errno("cannot create keep file");
 	write_or_die(keep_fd, keep_msg, strlen(keep_msg));
diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 60a8ee05dbc..f49431d626b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1565,7 +1565,7 @@ static void write_special_file(const char *suffix, const char *msg,
 	else
 		filename = odb_pack_name(the_repository, &name_buf, hash, suffix);
 
-	fd = odb_pack_keep(filename);
+	fd = safe_create_file_with_leading_directories(the_repository, filename);
 	if (fd < 0) {
 		if (errno != EEXIST)
 			die_errno(_("cannot write %s file '%s'"),
diff --git a/object-store.c b/object-store.c
index e5cfb8c0079..0cbad5a19a0 100644
--- a/object-store.c
+++ b/object-store.c
@@ -83,19 +83,6 @@ int odb_mkstemp(struct strbuf *temp_filename, const char *pattern)
 	return xmkstemp_mode(temp_filename->buf, mode);
 }
 
-int odb_pack_keep(const char *name)
-{
-	int fd;
-
-	fd = open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-	if (0 <= fd)
-		return fd;
-
-	/* slow path */
-	safe_create_leading_directories_const(the_repository, name);
-	return open(name, O_RDWR|O_CREAT|O_EXCL, 0600);
-}
-
 /*
  * Return non-zero iff the path is usable as an alternate object database.
  */
diff --git a/object-store.h b/object-store.h
index 5668de62d01..aa8fc63043e 100644
--- a/object-store.h
+++ b/object-store.h
@@ -189,13 +189,6 @@ void raw_object_store_clear(struct raw_object_store *o);
  */
 int odb_mkstemp(struct strbuf *temp_filename, const char *pattern);
 
-/*
- * Create a pack .keep file named "name" (which should generally be the output
- * of odb_pack_name). Returns a file descriptor opened for writing, or -1 on
- * error.
- */
-int odb_pack_keep(const char *name);
-
 void *map_loose_object(struct repository *r, const struct object_id *oid,
 		       unsigned long *size);
 
diff --git a/path.c b/path.c
index 4505bb78e8b..3b598b2847f 100644
--- a/path.c
+++ b/path.c
@@ -1011,6 +1011,20 @@ enum scld_error safe_create_leading_directories_const(struct repository *repo,
 	return result;
 }
 
+int safe_create_file_with_leading_directories(struct repository *repo,
+					      const char *path)
+{
+	int fd;
+
+	fd = open(path, O_RDWR|O_CREAT|O_EXCL, 0600);
+	if (0 <= fd)
+		return fd;
+
+	/* slow path */
+	safe_create_leading_directories_const(repo, path);
+	return open(path, O_RDWR|O_CREAT|O_EXCL, 0600);
+}
+
 static int have_same_root(const char *path1, const char *path2)
 {
 	int is_abs1, is_abs2;
diff --git a/path.h b/path.h
index fd1a194b060..e67348f2539 100644
--- a/path.h
+++ b/path.h
@@ -266,6 +266,13 @@ enum scld_error safe_create_leading_directories_const(struct repository *repo,
 						      const char *path);
 enum scld_error safe_create_leading_directories_no_share(char *path);
 
+/*
+ * Create a file, potentially creating its leading directories in case they
+ * don't exist. Returns the return value of the open(3p) call.
+ */
+int safe_create_file_with_leading_directories(struct repository *repo,
+					      const char *path);
+
 # ifdef USE_THE_REPOSITORY_VARIABLE
 #  include "strbuf.h"
 #  include "repository.h"

-- 
2.49.0.967.g6a0df3ecc3.dirty

