Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E15267395
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 07:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394510; cv=none; b=sGdufRC7AErZGgchuFhwPiIM5RLsJjDCDZEn7NRPnS3F6283WXjb6ZeAtI983IQa2F0DfzbTsu2uJTIKaXBCDpgKN4eaJLOJoKY+q4L9VHQLcL1R3tfuClD6NrlIpUUx0N40RXTlLZpIQO+Msum8fxeO9FaSh0dqU8psnGh6HfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394510; c=relaxed/simple;
	bh=CVk9zvq9o2xaS5NceQhNsnDb6PiCT28lJB0IeMVwIqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lcJr2FxWt1dlUGxUOWGWm5V41ukydwqWnNCZhMEUNY+kyggNrJtNL6PepaeROqxCYPppOxJyXtS0sWfx2eZmUOAVF9U/1kUvqrF5R3rjwGU9z2J36xkX9oN/76tPRxcXsuwRVnVvK/9yx8dOwo9O4T3eMI0dzgGcCpbIQDu1Zz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=brN3LTan; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lFXGmh5v; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="brN3LTan";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lFXGmh5v"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5187613801A0
	for <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:27 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Apr 2025 03:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745394507;
	 x=1745480907; bh=pG082B9TCTm+LVIr4QkIreR2GPtBBsiHKwqhnyEB1x8=; b=
	brN3LTan5Uhgm3s5yMLqduN/AmcYVlglOyDNHUxzJQU/XvqYc0AFHT43bZVyYtcN
	Nz0dOqeWKDECzOjCDhFSf5Rqz8U20u3tQVCw8BidOJXj0P2fF4j3aoq0OWtoeswZ
	lP6eu2RmrlZhfwBXEjLBmfqSOUWCfNkklWztrp7Ts0N/MFoX0pQRQGhG9P6Fn6C6
	vLtJLSy7Zt88GG/eFVYpIrBSjSLhSoqLipvtVbgcOW6A8oZ+pFTCbMY065+zH7Jd
	50QsJI94Vh2J1cvt/GqHahtRyaenZZ9A/eSYiFk0pz3xJacsw841lMjXeUrLXYlJ
	iqPMcYYGVQTDRDy6Dblynw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745394507; x=
	1745480907; bh=pG082B9TCTm+LVIr4QkIreR2GPtBBsiHKwqhnyEB1x8=; b=l
	FXGmh5vNKz2br+Hc6pmNcpuK9bXZK2AIqZ2qy9BMfhEJVyp4yDZhgNBpzsbBWfSn
	UNwiEZFDDz9KZmP9jAPDEd/2g6KJ2Zor8AlnY1AdT9cRHqbhW4x7Tidzj82oREjW
	TtPmfU4nePotNNwkwBOXWRp50x4FwFUbqEE3oVWddS86ifoZJcu0GzkgnLrGcHyx
	9frdAamAGlpE5LcJzWgPnQdBHRvJap2w6u08UANKR9AA3lfq295sl8cwleTx96kv
	Kruj/QMuS3cFOSztnNFzWk2w+KXrHFs3VF5kO8GnjhczVxDiOAZ9WVN0e5925p5k
	3hR2OVc9LOPcMf9LJB00A==
X-ME-Sender: <xms:S5sIaIKkIE6-BaUYufjg7WZt5VrwSs7_9X7rsRfzMgIY_nSHSDX1cg>
    <xme:S5sIaILzgEPm5POeQPW00rJ83NKip-vp_0fu6xWMS4EXe6ALP5gOxZmduOxSZMzVC
    g4VT6bJjJuUDC2Ctw>
X-ME-Received: <xmr:S5sIaIvS5seVFqlX01bmSTfUd66ZHuCv-PhBC0lSFeJVIV3MPCd8zxUs84eLOC4jTdpnBOtseIRmZ2Xf_FX34qUbTZ6rD2DPPBjq6vXhPg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeitdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:S5sIaFbzd2VURZlgUtewe7pk0TqQteSI_pWVqwOoXe59GSkP8QFOaw>
    <xmx:S5sIaPajPRzhjWdrR8_LCY7kxZ2InPfwBQKUxsBhrs4YFxeN_6BGPg>
    <xmx:S5sIaBBwPGN0ZIafJBs42n5YlblkVnMFymoWiDRUMNbKEIYoOEFChA>
    <xmx:S5sIaFaoxy5jk2RsN3XnZYeLYAdJSwLNAJ-Bjbj5uAaxQUu2Y0lYHA>
    <xmx:S5sIaJmVaFMm44UMUgXfOmySSYQ8XwOJUrBHe-fihK8UKPIP7LEmXtkk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 23 Apr 2025 03:48:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ba310161 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Wed, 23 Apr 2025 07:48:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Apr 2025 09:48:13 +0200
Subject: [PATCH 03/13] object-store: move and rename `odb_pack_keep()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250423-pks-object-store-cleanups-v1-3-81f8411a5d08@pks.im>
References: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
In-Reply-To: <20250423-pks-object-store-cleanups-v1-0-81f8411a5d08@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The function `odb_pack_keep()` creates a file at the passed-in path. If
this fails, then the function re-tries by first creating any potentially
missing leading directoriesk and then trying to create the file once
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
2.49.0.901.g37484f566f.dirty

