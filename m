Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211F91D90BE
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 09:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736155477; cv=none; b=MNzvpE0ooK9w9VGcE7DkzSdddIgcfqFWGkUsm4SZmBvf4IkdtjJWoMe0Ma7JufXReGiOswXBHrluX+QJS8BFJGBMKjgSCaL8MDKIbHXFFsnN8YnzRY9vv+P6iU7hLZp6p9CGn6ZYcvR0c7CYbsVFJPyNMt8cmszswBE/3cq47b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736155477; c=relaxed/simple;
	bh=Rk2OOghvesikhTatPL7PtzcW68K2fL2TN5eP2rIZy/s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ltdMD/gV9thwlKcYQTgwQf8BGOhlPmLamGFlIDK7eWxR+fbe8sqC4gxX5EeogdTCl78kZTSPQFdH4tThuvRyn9F/4HGlYVdnuTK4rE6G+3Xj6T1Sy3LgJf9AWq24oh1a5pa7CwwSdclt1B6tS4neKCpBsXcNiU7fAOAS4zO22Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aQdU/Qmk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lOnwziNa; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aQdU/Qmk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lOnwziNa"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id F03301380169;
	Mon,  6 Jan 2025 04:24:33 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 06 Jan 2025 04:24:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736155473;
	 x=1736241873; bh=N7KFPpnrFwKQWE6KRNGekgnx8PE2LUtmdvOwYkwnNJY=; b=
	aQdU/QmkDh06mLEIuqJ84KfMFijfLYk/+ho/gKrB0NaX4UfyqLACBRnWq3ZdbPBh
	W4tNR7QFnMtprP3lAuairdQx1++WUakcvqUA8yDi8r5bq1F3vYXZImM6FCQEwwqS
	bHXnOQKXlELUAe+JReNTsL+/RZKu/xxnAlqccP+s8IE10q5sWC/4BOkkCoM62Pl6
	A2ApdYRUlSqOW11y0snG7UzYIKuZqbLK1KtBnjJ8kaB4SMdd4pLdaPARFoY/GkXe
	ObK2V9SraLmLBq9VtMbtafia+1wYWlVMoMMMg9bcFQB3pfvipGjU23E6Z5xJGulW
	YoX27mOPuC/TqyaENz4ieg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736155473; x=
	1736241873; bh=N7KFPpnrFwKQWE6KRNGekgnx8PE2LUtmdvOwYkwnNJY=; b=l
	OnwziNaHPjBSWcS/o8pmJ9IFIq4LVLgw9QV/W9y8CkkWg37/l3AmysQfH01fJPwU
	GUx9LgAqpl8wqrDU8XXHjvdRVGZmpwSNYD2iIcXlFuOHKSNaVEbnTZHAEkQORo8A
	b0YwztleBUVsXsOY30z0DgF2o2c3WihZx/Rc0E6Z+OX88Z4EYxCSmwLbJ7uGhYyN
	yFWVKxWLD7jRGGytOvEzaz5K37X8mH77XMAe9tBWZHx55Hzq/+bMTU3EoMbLAxFu
	jTWfMfffDqASH/guhkGXgGHD0OeJUuTN9gNI6mKbkZkpB62I4OlQgoUk91Kky7+i
	oBp3iOlOkbDowoLhFKqQQ==
X-ME-Sender: <xms:UaF7Z7LMH8QRb2ahi96yIqHXQd-gYqkbm7TXpFxgfqcmZ_bgRAcA1A>
    <xme:UaF7Z_IvgGvtWXRBKcduChY-LkirFXesFqT0d-e4AUito37k-_-REvKYT9laIekW_
    xsUM2gIwtb8fw8I4A>
X-ME-Received: <xmr:UaF7ZzsuIPepWgYys6qsdmkIO8aDbF7HIwXinCuUMJFpNg0rRN4KeeHkO0NYSE1diB15DyKdAXCsA6Rk290kMHAGdz967Foj9SYgvZ4A42j-Yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:UaF7Z0YdhC-y6NV79OUmy_lHzqDZ4D2umDIUK39HOI5EPakYx7sz2Q>
    <xmx:UaF7ZyYfWdpjp1shV4u0Hkef4sK-oyY69Uxx5nC37k7b8hR_V9MddA>
    <xmx:UaF7Z4AD3TWeP_ZFWeTagXOYGKZprK_Mz6j5JvmC4EGr4GiYFOSmhA>
    <xmx:UaF7ZwYP3Sy5hvZNlYKX9JqhPfaDA7vPJIabRzLX8t0VFpXADkMbSA>
    <xmx:UaF7ZyFZ0h135zjkspTNcofNWUrpxz-AjTvlN6NAM29RNw3OS4BbkcdM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 04:24:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c55cad0a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 Jan 2025 09:24:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 06 Jan 2025 10:24:27 +0100
Subject: [PATCH v2 3/3] object-file: retry linking file into place when
 occluding file vanishes
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250106-b4-pks-object-file-racy-collision-check-v2-3-8b3984ecbb18@pks.im>
References: <20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im>
In-Reply-To: <20250106-b4-pks-object-file-racy-collision-check-v2-0-8b3984ecbb18@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Prior to 0ad3d65652 (object-file: fix race in object collision check,
2024-12-30), callers could expect that a successful return from
`finalize_object_file()` means that either the file was moved into
place, or the identical bytes were already present. If neither of those
happens, we'd return an error.

Since that commit, if the destination file disappears between our
link(3p) call and the collision check, we'd return success without
actually checking the contents, and without retrying the link. This
solves the common case that the files were indeed the same, but it means
that we may corrupt the repository if they weren't (this implies a hash
collision, but the whole point of this function is protecting against
hash collisions).

We can't be pessimistic and assume they're different; that hurts the
common case that the mentioned commit was trying to fix. But after
seeing that the destination file went away, we can retry linking again.
Adapt the code to do so when we see that the destination file has racily
vanished. This should generally succeed as we have just observed that
the destination file does not exist anymore, except in the very unlikely
event that it gets recreated by another concurrent process again.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index acfda5e303659195109c94f5b54b8a081fe92c59..aeca61b8ae3aadecef1ce11306b38e7368af829f 100644
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
@@ -1986,6 +1988,8 @@ static int check_collision(const char *source, const char *dest)
 	if (fd_dest < 0) {
 		if (errno != ENOENT)
 			ret = error_errno(_("unable to open %s"), dest);
+		else
+			ret = CHECK_COLLISION_DEST_VANISHED;
 		goto out;
 	}
 
@@ -2033,8 +2037,11 @@ int finalize_object_file(const char *tmpfile, const char *filename)
 int finalize_object_file_flags(const char *tmpfile, const char *filename,
 			       enum finalize_object_file_flags flags)
 {
-	struct stat st;
-	int ret = 0;
+	unsigned retries = 0;
+	int ret;
+
+retry:
+	ret = 0;
 
 	if (object_creation_mode == OBJECT_CREATION_USES_RENAMES)
 		goto try_rename;
@@ -2055,6 +2062,8 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 	 * left to unlink.
 	 */
 	if (ret && ret != EEXIST) {
+		struct stat st;
+
 	try_rename:
 		if (!stat(filename, &st))
 			ret = EEXIST;
@@ -2070,9 +2079,17 @@ int finalize_object_file_flags(const char *tmpfile, const char *filename,
 			errno = saved_errno;
 			return error_errno(_("unable to write file %s"), filename);
 		}
-		if (!(flags & FOF_SKIP_COLLISION_CHECK) &&
-		    check_collision(tmpfile, filename))
+		if (!(flags & FOF_SKIP_COLLISION_CHECK)) {
+			ret = check_collision(tmpfile, filename);
+			if (ret == CHECK_COLLISION_DEST_VANISHED) {
+				if (retries++ > 5)
+					return error(_("unable to write repeatedly vanishing file %s"),
+						     filename);
+				goto retry;
+			}
+			else if (ret)
 				return -1;
+		}
 		unlink_or_warn(tmpfile);
 	}
 

-- 
2.48.0.rc1.245.gb3e6e7acbc.dirty

