Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291814D28C
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737983062; cv=none; b=iaAMQyULg8xTGKIGpHEmI66Pn1ZRkikI3QGB99hFNcdTvZiyQAvhc2myVplaQDK+vFnlcmouvrsmg74ufnmW0DqRI7CKnPjhcweA5lsYs+PO1jMtWl0wxxNMUt9X3SPMMDi84QgOZ2YAKodE2tAKLiDzs9N+r4Psyhn9Y7YnKLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737983062; c=relaxed/simple;
	bh=+iagMjpQ8dX07lvRT/xY2dTiLj7CiNWhYiNKUuiqBe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1q5MsgoJlg6YRCGOhe5wSPvYmTwlySrtFyciNZPeZxDwhhMD0JX0AsMD132egOFEMDcng8hwCpGkC3HSZpsdKVGcsb6Ncu8nqUP+0rV8JQdDIAo2b0r7HNA6S8FTVWoKiJGUDBYPSEjefAhpVzWbRaTOZvL40589xjJxkIumGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eK+u8RM7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ndTq7P6H; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eK+u8RM7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ndTq7P6H"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 36D4211401E4;
	Mon, 27 Jan 2025 08:04:18 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 27 Jan 2025 08:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737983058;
	 x=1738069458; bh=GvMn42ozwWo5GYWrzRiRYUFzxGTOhQY5Y730BGkbxPs=; b=
	eK+u8RM7sN5zquK7e3khjSaTfpuDngulAp9jCE1KQ4I4CrUPkNdaNIEW+a3x2eYl
	ip2Vhk0SWSPP1LrNNWa7wYnI8JOH74zlMdt4yOjBuNsIIT1M0PbqjA9qRRP6UIZQ
	KGDvyF6PNC642OKmMiRF1ZwTqGojyUKnBMI+4CrOshB6jVzNIhW3bCjWrAF+AAdC
	7VVATmdF0SnIb3Fwd5JUeW0RBIS979zUbE7vcLSEdHOTGH3+N7k1LzJxWyK9clxa
	Ov3p6uFTzvIoyAqn7xyve07aVCtRkuSWeBuPjXicY8pgR6lrI/1CxBjcxDMKHPRF
	9V1SgLzH03SLA9NeRD1HUA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737983058; x=
	1738069458; bh=GvMn42ozwWo5GYWrzRiRYUFzxGTOhQY5Y730BGkbxPs=; b=n
	dTq7P6Hcn/nZdD2nf+4bLmF0z44uDEJkKx9gKMRC76epm1gkeRuGCyUALOnxSV8D
	HYGLu4QEV4BZ46zj66oEbcyv+sDz12jKhomIqf4ryY3H7/uVZIH0y8bY0VK2A/Hl
	jpVgePBW/kyfIJWxweYKWRCe0IFe2Lbl3/Fgs9fxUWj1t/Tmycghf6RsOW4cbOHV
	EbdKfH0D4FslZX63wsyOm5jB4zNvkGjvpNCt4dc6Y2oIPhat+t3MoreZsCQExTrN
	if80fasmfNiIAsjb96d8+FAWN4+gxsa+u0/NiQCzCQwwHDkDoSz99oIwBf+UFZqn
	0+dk5FFjS3N+jdGzNOSVQ==
X-ME-Sender: <xms:UoSXZ33U3cCOXWEIb3T4ATEo6uXnAv4khKqugOm5Qaf_y3eSP47qkQ>
    <xme:UoSXZ2HjjfxXrj0BXuttB-tO8isRMXoLdVhKG20iAFYoFnQA_pvHFrT5D3DeUtQ97
    NcXqdBaON-_T43Fcg>
X-ME-Received: <xmr:UoSXZ35Of7UEUJ_l2pj3TSYdBwwF_Ub82xXgsINp_CWB-zNWZgB69IAS4838FxKk6MdaRzwgFa6Sm6DVnbCKsWB3t0yCenT9I9K36q3M4Hi->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudefvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhoh
    hmshhonhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:UoSXZ80LxYx1Tc_FToSNClYfTl68SnDFoCM3lHtFI_87s6V6bdXzVQ>
    <xmx:UoSXZ6H4v9upLEJ3BxBbeFOH1FYr9Wd1LV-N8hMsZWigshkaH_HC4g>
    <xmx:UoSXZ98ecF0vgrSpcH235tI_EmvwBJujK4GjlG3kSlsDRkQmDIZrtw>
    <xmx:UoSXZ3kQq864RS9mDwOuztLZFG96kEO43K9JugxaqiTivWhrGJBOYQ>
    <xmx:UoSXZ_QYOzpvEb_PvsSfXwEiGa6p-ku-4XVrgbzUcnRWoW5VA3_1jzg1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 08:04:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e1568458 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 13:04:14 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Jan 2025 14:04:09 +0100
Subject: [PATCH 01/19] reftable/stack: stop using `read_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250127-pks-reftable-drop-git-compat-util-v1-1-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
X-Mailer: b4 0.14.2

There is a single callsite of `read_in_full()` in the reftable library.
Open-code the function to reduce our dependency on the Git library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index f7c1845e15..9490366795 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -115,13 +115,16 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 
 static int fd_read_lines(int fd, char ***namesp)
 {
-	off_t size = lseek(fd, 0, SEEK_END);
 	char *buf = NULL;
 	int err = 0;
+	off_t size;
+
+	size = lseek(fd, 0, SEEK_END);
 	if (size < 0) {
 		err = REFTABLE_IO_ERROR;
 		goto done;
 	}
+
 	err = lseek(fd, 0, SEEK_SET);
 	if (err < 0) {
 		err = REFTABLE_IO_ERROR;
@@ -134,9 +137,16 @@ static int fd_read_lines(int fd, char ***namesp)
 		goto done;
 	}
 
-	if (read_in_full(fd, buf, size) != size) {
-		err = REFTABLE_IO_ERROR;
-		goto done;
+	for (size_t total_read = 0; total_read < (size_t) size; ) {
+		ssize_t bytes_read = read(fd, buf + total_read, size - total_read);
+		if (bytes_read < 0 && (errno == EAGAIN || errno == EINTR))
+			continue;
+		if (bytes_read < 0 || !bytes_read) {
+			err = REFTABLE_IO_ERROR;
+			goto done;
+		}
+
+		total_read += bytes_read;
 	}
 	buf[size] = 0;
 

-- 
2.48.1.362.g079036d154.dirty

