Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F89D1F2380
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771863504; cv=none; b=LH781b0Cm29hBGaXoDa/wkmjDj6IYGbhRLt909pztHLIDfrKRfPD8Q3hK6akkeZK7Yk+KZCzg7DRiYRUOo1uJYUcr9kR99DWuK8b9DWBPgp91MGxNijlYHvoleeavPWcWQUBT7FFhYGa/HNGRuvjqViKm3E9zHRbZuFCQ8gKkII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771863504; c=relaxed/simple;
	bh=NuuEw3aMor10Hvm0yLFylMsnAA9eDAzcEpG5Bd4J0+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=evhnAd5eKmOjqi+qXXHTV9hUavJt5+4Lj6KZULYPi3Ru1VsfHUTgIEmb3l5UTR1QL0/s9neJ6NbBupTJBSydsonlaNp+256eFgfeAYYs4cj9Q2+SvhQ8/p+WHiNZYz97nKL+1j6crCOAxtqbe8QyrH49SudGtutSm36nkUQcNC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SZimOkxp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hxtTM4rG; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SZimOkxp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hxtTM4rG"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CCB0DEC054E
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:22 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 23 Feb 2026 11:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771863502;
	 x=1771949902; bh=r1/EFAR4DZ/USIlGOf+cYvWRb5LXuLS9JoSRegYqjvM=; b=
	SZimOkxpCx00xg+aU+NhpQgMRYE+i50amCV4IQUvhi3cRsikRz6m+xGLHnq1TpHn
	GYnrJfaarbYDGNQQpuF2F9MC7flCyGBaX9RFes+bDz7b49JuFU2fYciDlKXkhAHc
	B/NrcZLTqs/ODwd3Y/VIv7XeJeJhNauB0RRKwXm8AbcxoUMyKETLiVX1aMRsvSb9
	yqCbhA/6vii5oSPBD/9A9B04CGQhoy1/f7AUzaJlZIj0bmT7C10E8iTk/jVL9fxR
	3WIFvJzThU6UJ5cSQzAN8YTMaFldanE90GYGO3CVDuVVeuEmBs9MmNA/33ga9aT6
	KgyNLHV27QT14J6/TQT9bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771863502; x=
	1771949902; bh=r1/EFAR4DZ/USIlGOf+cYvWRb5LXuLS9JoSRegYqjvM=; b=h
	xtTM4rGHYCmJ5spI4mFVd0T2Qhu/OmBH42C2K6TJ3I34jnPpq6x7NtUHSXe/mGqW
	s60FVPpaAnR7IrWasvGPUNhU4h+Od8gxkZikJnbOj+LRyjKaOBoPQgCyspNeUh39
	l3swCb0kS7riVanmsm2s7dveyySQeH7obnNbfaWtp9D67ULPuItBMivtzrFfVKHP
	3fNIWXzjINbxxvmcABPKeSoGFuGxSu45Ry2fnZMMmrtzPbgIFyXvzcOTnrdbvetq
	KpGnBwn6uUNo5bZGXfS8DqOnwo2eLtxXSehL46J4F2H6SgklUJoU9g19/8iL9k/d
	/mcNrjVmg6DHzjpFnpMBA==
X-ME-Sender: <xms:zn2caXZk4i7q4m_3gCESn3u5f9yyl9X3GKzmuolAVNqPHDNgjCINFg>
    <xme:zn2cadXeDvRCaxIt8N_F5M0XgouuP-sjpiC6iDOlkzqJtOv-3oROUsMgpxKTZK72o
    Y_qk2C5KCjTrnD6NOS2NxX71GNmnGMnEtyZkXMx0bO-STZh-CF9t5Y>
X-ME-Received: <xmr:zn2cafmpBuXfRRcVbmNNTDbHH8tkWJYZIumb4Z6WCNvqbn84CXZ2nt2ROWP32gYC0omeGPpdltsiFPNeTjYbT2JW1xx3yOqFQVCfpMkzHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:zn2caSyWjYhZRANTM3wC2oOTaD6G2yFU9Ivmj0jyYY4RyTlsUzHM8Q>
    <xmx:zn2caShu6ZJLJk2n-vM8fTD78FY-BstczDQdYtfjaX7sDa8HWoR-bQ>
    <xmx:zn2cafXD5kRREIC2oIk4tVliArjnxVJWlW4K_6uqIEuAn9omi6TygA>
    <xmx:zn2cac2WKtWJ1vVYVd8WgrqIGI6ZRU-EJrhjCckcbrMJZJ4ZA-JAMQ>
    <xmx:zn2caZ7IA7UiF8nB6HCdT54GOJKNLF7mK5XzlzYB8XdJKDYEmy2CNFvf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 23 Feb 2026 11:18:22 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7e7b9045 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 23 Feb 2026 16:18:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 17:17:57 +0100
Subject: [PATCH 06/17] odb/source: make `free()` function pluggable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-b4-pks-odb-source-pluggable-v1-6-253bac1db598@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

Introduce a new callback function in `struct odb_source` to make the
function pluggable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 7 ++++---
 odb/source-files.h | 3 ---
 odb/source.c       | 4 +---
 odb/source.h       | 6 ++++++
 4 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 7496e1d9f8..65d7805c5a 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -18,10 +18,9 @@ static void odb_source_files_reparent(const char *name UNUSED,
 	files->base.path = path;
 }
 
-void odb_source_files_free(struct odb_source_files *files)
+static void odb_source_files_free(struct odb_source *source)
 {
-	if (!files)
-		return;
+	struct odb_source_files *files = odb_source_files_downcast(source);
 	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
 	odb_source_loose_free(files->loose);
 	packfile_store_free(files->packed);
@@ -40,6 +39,8 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	files->loose = odb_source_loose_new(&files->base);
 	files->packed = packfile_store_new(&files->base);
 
+	files->base.free = odb_source_files_free;
+
 	/*
 	 * Ideally, we would only ever store absolute paths in the source. This
 	 * is not (yet) possible though because we access and assume relative
diff --git a/odb/source-files.h b/odb/source-files.h
index 803fa995fb..23a3b4e04b 100644
--- a/odb/source-files.h
+++ b/odb/source-files.h
@@ -21,9 +21,6 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 					      const char *path,
 					      bool local);
 
-/* Free the object source and release all associated resources. */
-void odb_source_files_free(struct odb_source_files *files);
-
 /*
  * Cast the given object database source to the files backend. This will cause
  * a BUG in case the source doesn't use this backend.
diff --git a/odb/source.c b/odb/source.c
index c7dcc528f6..7993dcbd65 100644
--- a/odb/source.c
+++ b/odb/source.c
@@ -25,11 +25,9 @@ void odb_source_init(struct odb_source *source,
 
 void odb_source_free(struct odb_source *source)
 {
-	struct odb_source_files *files;
 	if (!source)
 		return;
-	files = odb_source_files_downcast(source);
-	odb_source_files_free(files);
+	source->free(source);
 }
 
 void odb_source_release(struct odb_source *source)
diff --git a/odb/source.h b/odb/source.h
index a1f2f8fdb1..f84da59ef0 100644
--- a/odb/source.h
+++ b/odb/source.h
@@ -52,6 +52,12 @@ struct odb_source {
 	 * the current working directory.
 	 */
 	char *path;
+
+	/*
+	 * This callback is expected to free the underlying object database source and
+	 * all associated resources. The function will never be called with a NULL pointer.
+	 */
+	void (*free)(struct odb_source *source);
 };
 
 /*

-- 
2.53.0.536.g309c995771.dirty

