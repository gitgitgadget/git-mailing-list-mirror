Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3ECB1D935C
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155476; cv=none; b=VHrjWwlRxgQfzk/CJrSJbvcmhDaWUHZKFXik88rk8+ChtJ68aCxe8WWwIm6qa4PlWapgIzLqgGGLYvdYHbqwdQmaQo/CTWDP8yJ4fC4s+Sit/hDcaBSRFHsYjwn4u0oKOFWK5y/9V1963qhiQuwrJpeBMOLP1giM/WdsriHQClM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155476; c=relaxed/simple;
	bh=H/CYUTwWKAzEZbr1ZqwqzdoZVLOiEQOw298hSCJiJEw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otRCXOCXT4PkrIDBHdLEYTF58EvOnva1Gte5EN3kWiQnRoQq3XVwk3tzdy9GfQZWQvXojnkl4xedMnRdudJaFimFlC2biiw7MNOMuGL54WBfH+Ufhx1BKUCar3161hHBWbx6oFlcbsiScqU0a2ErM0DUvVrQzuKIIjqcmxfe4jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SBcRAirb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cvq+banE; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SBcRAirb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cvq+banE"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E252913809DA;
	Mon,  6 Jan 2025 04:24:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jan 2025 04:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736155472;
	 x=1736241872; bh=9au2lMPEJEFkbsD2KX3eOyhpcU6NW1a9BtwrV87kzvM=; b=
	SBcRAirb7BdokkmTab3H6wzwLgd5rCfAx+jOos13tVQu2mxd4uIaYFc7kAihnuzW
	2FpdSRwkuW1OkouhLZrL1+gCHgCkZS5lSxDRRcO4rnuU7xporhbUxkdNPwNzoRQO
	jvW8MTjdotg8NSfXNZl6bh7dC9FChG1rlfWfcpauwFjM734Fw6gGb0A8ZA1j0k4L
	c3l/oyfF+ElD5Im6UA/rBx8SJtbxHRjK6IcpvosTD3PGy49yjaw/5+Uh4JknzSbW
	HJVjszhlo5o53PxGYOkv1ApwIhDGex45boRfAX/srnEW6p1+WQ5pAR9ufdyExvWj
	+p0QvmjpsOKxODilQ5gU+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736155472; x=
	1736241872; bh=9au2lMPEJEFkbsD2KX3eOyhpcU6NW1a9BtwrV87kzvM=; b=C
	vq+banEDq9pgkT1kLb92k6FFYfsV6fRsz4v73P2L7tuHMG01tcPyety8P0heQmcW
	QJK6Zv8TTBu7TkWs+e8zVkA0gxfyv3EBb6fRCSxZxHmu5puUA0fgtPnjAn0wExA/
	TQd5enXcKLpZ7+FucAJqehRxNTSm9NNotex2fvsv1W6G9h175iAotTlfO2Hxy2ab
	vJMF6YpVATSmG6D2DVNjBUxiejo7Y+afRK4HZcE23EegjChcSE86mDJe8DVxXdR2
	75yl+rQyxypueq/h046dJhd4BYkM28IvAvw6dEjXOtGwfbGMx58flxEThB0umhs+
	8EPxkW42W+jmpuZ/6OTfA==
X-ME-Sender: <xms:UKF7Z9UE_ICKCciChh9_H0mSlOAX0N87S9DvHfbhmwJxu-LhwAvdEA>
    <xme:UKF7Z9mI98levVEBZgMOtA7x_O4q9prV3ZUpajTwst_FGLWAiRbWAZqNrNG6vl45z
    6mpOaxw1m1jioE8Dg>
X-ME-Received: <xmr:UKF7Z5aSxLDFfcqceFFa7ogcdwwlxrPa_QQtNZiVynDqkSJLlu93z0EwqTHMH42irrzpnkbs5wmNfOExIxrEdBfGhiSrcdakCeSQD8pv3ICXJg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:UKF7ZwWakFr_dUyIuoFa4xMXJARCwTHsYFfT-13E6dvMDvsgxNuCEA>
    <xmx:UKF7Z3nW0QhgjMS1a76a49CwiI8DajfXOB2XgI7PhwYW4xy8B8BTaQ>
    <xmx:UKF7Z9eje25KOB7ucdKPJ2zmdjLy0O2spbdrt3AgZgneIM_yAKI9aw>
    <xmx:UKF7ZxF-qQ5zO1cD7earGNRpOo3VJ4qZsW0dWhPX7u8pX5SxK73ogQ>
    <xmx:UKF7Z1gNbiVjPidd26o5ziP4k4peRpR8AinYih-l2Cmsp8Aft7EHaMWU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 04:24:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7db1964f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 09:24:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 10:24:25 +0100
Subject: [PATCH v2 1/3] object-file: rename variables in
 `check_collision()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-object-file-racy-collision-check-v2-1-8b3984ecbb18@pks.im>
References: <20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im>
In-Reply-To: <20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Rename variables used in `check_collision()` to clearly identify which
file is the source and which is the destination. This will make the next
step easier to reason about when we start to treat those files different
from one another.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/object-file.c b/object-file.c
index f84dcd2f2a7b88716ab47bc00ee7a605a82e8d21..e1989236ca87e565dea4d003f57882f257889ecf 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1970,56 +1970,56 @@ static void write_object_file_prepare_literally(const struct git_hash_algo *algo
 	hash_object_body(algo, &c, buf, len, oid, hdr, hdrlen);
 }
 
-static int check_collision(const char *filename_a, const char *filename_b)
+static int check_collision(const char *source, const char *dest)
 {
-	char buf_a[4096], buf_b[4096];
-	int fd_a = -1, fd_b = -1;
+	char buf_source[4096], buf_dest[4096];
+	int fd_source = -1, fd_dest = -1;
 	int ret = 0;
 
-	fd_a = open(filename_a, O_RDONLY);
-	if (fd_a < 0) {
+	fd_source = open(source, O_RDONLY);
+	if (fd_source < 0) {
 		if (errno != ENOENT)
-			ret = error_errno(_("unable to open %s"), filename_a);
+			ret = error_errno(_("unable to open %s"), source);
 		goto out;
 	}
 
-	fd_b = open(filename_b, O_RDONLY);
-	if (fd_b < 0) {
+	fd_dest = open(dest, O_RDONLY);
+	if (fd_dest < 0) {
 		if (errno != ENOENT)
-			ret = error_errno(_("unable to open %s"), filename_b);
+			ret = error_errno(_("unable to open %s"), dest);
 		goto out;
 	}
 
 	while (1) {
 		ssize_t sz_a, sz_b;
 
-		sz_a = read_in_full(fd_a, buf_a, sizeof(buf_a));
+		sz_a = read_in_full(fd_source, buf_source, sizeof(buf_source));
 		if (sz_a < 0) {
-			ret = error_errno(_("unable to read %s"), filename_a);
+			ret = error_errno(_("unable to read %s"), source);
 			goto out;
 		}
 
-		sz_b = read_in_full(fd_b, buf_b, sizeof(buf_b));
+		sz_b = read_in_full(fd_dest, buf_dest, sizeof(buf_dest));
 		if (sz_b < 0) {
-			ret = error_errno(_("unable to read %s"), filename_b);
+			ret = error_errno(_("unable to read %s"), dest);
 			goto out;
 		}
 
-		if (sz_a != sz_b || memcmp(buf_a, buf_b, sz_a)) {
+		if (sz_a != sz_b || memcmp(buf_source, buf_dest, sz_a)) {
 			ret = error(_("files '%s' and '%s' differ in contents"),
-				    filename_a, filename_b);
+				    source, dest);
 			goto out;
 		}
 
-		if (sz_a < sizeof(buf_a))
+		if (sz_a < sizeof(buf_source))
 			break;
 	}
 
 out:
-	if (fd_a > -1)
-		close(fd_a);
-	if (fd_b > -1)
-		close(fd_b);
+	if (fd_source > -1)
+		close(fd_source);
+	if (fd_dest > -1)
+		close(fd_dest);
 	return ret;
 }
 

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

