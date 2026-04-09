Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510139DBC0
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738894; cv=none; b=kIWQdl1LyE7JnFD0XMYUkOqK4K7qdIpJjZtS85jfuRHUHl1I7o2x1mepOdpVu3pPs86dSydZNNDbsSts4abuQA2DVIbM1BLABDDEh2fao282N7w5tQ2DNV4ESEsUYpE580cqFbgN4HQisbtSbg6F8dGDXfksaKLLIoHQX8BahAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738894; c=relaxed/simple;
	bh=Kgp+oSv2BlfrB5evJ4r1M5G4k7ZknbQpdeB0rnZWXPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Nx4zFrZ7NU2tig4f6qUaMLNVpHfCfW3mKQuiOtrnbtUk5KNYBhj1d7K1R+YBZoxIvJjqbimxMGlZJpi5Yq/7Lm4FuNQxwys8WWszmQh8ck/2rrK0+lcP9zAnU5mOLTTwhaSFPbUkFvdDG3YOoqSzm+0d1wQIO8vNuW5B6fDYaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=yJ7E5RYv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJ0B8WPc; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="yJ7E5RYv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJ0B8WPc"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5101F7A0200;
	Thu,  9 Apr 2026 08:48:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 09 Apr 2026 08:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1775738887; x=1775825287; bh=AgkbKD17ku
	/1g2Hci0Rg21zRIxHGPS9/tUBT59km3WA=; b=yJ7E5RYvbsebxafevO14x6sD8f
	pFc4RC34Wy3vBFdiiYH00KcxB7i3Hdwaa2faSXy1TELpRJQBz4l0EbVYdc2rG+qK
	yStdpBarMD+FL9Om0sgsWmeYu2beuWxkwjCrwStSEmryIasAKibZQ7X+p8tJgxM8
	ml02BJEuXoi7RG9hZsgX8MUEjypSLksU4ILFr753HjxRDt0VdmHePO+2PbeGvewM
	CoGdSF5tiT5i8FlsJ9myVVFjfxvvhHnalrTV10s5W+wbSvsY8MpA7A4pbnEkfDJ/
	g6NN+AOp14yrrkJfGvYh+Jp9VkPYv7RSUgBev0Wa+hvuVzxJBT2tPINULuxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1775738887; x=1775825287; bh=AgkbKD17ku/1g2Hci0Rg21zRIxHG
	PS9/tUBT59km3WA=; b=dJ0B8WPc1WNq26dckQFlsIFBYxoUKWttgOXLVKcrsIHq
	Z2zIwzCKu+y/bSCnbOifjJzjerO4VKq9E/2llQIzXRzzWK0vnwZSpzhY0YQVrj71
	8kz5HXZAj6zwnVv5cSbGUDZUjJQ2uiiiM+mNVWwBzR65mnVF7uTOIgu078PcLdWK
	P2PbGtgMP7zgb149taOkmt1YbsnfH6LRn6xRUexmeVABgno3MjesEeulNevoMydO
	zYcq/Pvv0BiRTzmgFjXFMP253BI17vDtvLDCOZEuy7w3lAVYE6ES8t7nWCC4Fj3w
	1W3kgH9K6IBHUqxUD898NuPlHrVGttEiCma8NHN1Xw==
X-ME-Sender: <xms:B6DXaTyCdIYnJNiI5gBC5w-tQuH_bQM_vZeX3RlBXYUCJriFjTySvw>
    <xme:B6DXaUnL2ud1wonuNxvAhTqhX-dRpHefMTfKJqfdQ8kgNsf3TSFVOMaLHW5ReeEQf
    yOT458lw3hny9VnrAz6NBydGBFTXWpHjQSElDAJv2spu8_gzxY7xg>
X-ME-Received: <xmr:B6DXaUnzjWbJw5i61g5sTeUeLucMuG0TGLHnQCmuAPE1D22pDb4AP7qZFovFt8l6OmFJlbhT7eiJM_ni3phL_Vq-zB4_9B2MCnFoMn_Atzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvieehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepie
    fgiedtffffvddvueehheejheehleduudfhheekkeeggefgueffheevgeetjeefnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghl
    mhdrohhrghdruhhkpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtth
    hopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphht
    thhopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggr
X-ME-Proxy: <xmx:B6DXaexKgFczFAdSw4nC2J1RfnyK8Q-q9Uq4jpY7Hs_8HZBZDLvrVw>
    <xmx:B6DXaRpliEzJzZxqMk_JLb51AoFcDK1Zf7RGaD_hi2tayzZ-IhTnng>
    <xmx:B6DXaV5srt-M9UvWU0TvLsXKveTSMPaWBRtBo_ZTzJT8i6gkP19qpQ>
    <xmx:B6DXaQd0jEggNXOZfAY7xPWU2-tHX4Ozdl-HIg1L-gvXIuueSzMTyA>
    <xmx:B6DXaYulIcp21mQ3ibNt1EDPrXIQxJVD6Ezvrz5O_cv3zKRDAFxjm_hT>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 08:48:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c948c4e6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 9 Apr 2026 12:48:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Apr 2026 14:47:59 +0200
Subject: [PATCH] wrapper: properly handle MAX_IO_SIZE in `write_in_full()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
X-B4-Tracking: v=1; b=H4sIAP6f12kC/yXMQQ6CMBBG4auQWTNJhcZQrmJYtPijoxFIB5FIu
 DtFl9/ivZUUUaBUZytFzKIy9AmnPKP27vsbWK7JVJjibKxxHCyPT+VPlAkzv/zCMrDKFwwXKlP
 a0nlUlPoxopPl9740f+s7PNBOx5C2bQeVvqQifQAAAA==
X-Change-ID: 20260409-b4-pks-writev-max-io-size-e9b803439ae8
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Randall Becker <randall.becker@nexbridge.ca>
X-Mailer: b4 0.15.1

Some systems like NonStop set a comparatively small `MAX_IO_SIZE`, which
limits the maximum number of bytes we're allowed to write in a single
call. We already handle this limit properly in `xwrite()`, but we have
recently introduced wrappers for writev(3p) where we don't. This will
cause the syscall to return EINVAL in case somebody passes an iovec
entry to writev(3p) that is larger than `MAX_IO_SIZE`.

Introduce a new function `xwritev()` that is similar to `xwrite()` in
that it handles such platform-specific nuances. The logic is rather
simple: we simply coalesce all iovecs that don't exceed `MAX_IO_SIZE`
and pass those to writev(3p). If the first iovec already exceeds the
limit, we'll instead pass it to `xwrite()`, which handles the limit for
us.

Adapt `writev_in_full()` to use this new wrapper. As this wrapper
already knows to to call writev(3p) in a loop already it doesn't need
any further adjustment.

Reported-by: Randall Becker <randall.becker@nexbridge.ca>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this fixes the issue reported by Randall in [1].

I mostly wanted to get this patch out there so that we can discuss a
proposed fix, but as said in the thread I'm also happy to revise course
and instead set NO_WRITEV on NonStop for now. I think we'll want to
eventually land a fix like the one proposed here though, and at that
point the workaround would not be required anymore.

Thanks!

Patrick

[1]: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>
---
 wrapper.c | 51 +++++++++++++++++++++++++++++++++++++++++++++------
 wrapper.h |  1 +
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index be8fa575e6..d989c78b4b 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -323,21 +323,60 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 	return total;
 }
 
+ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
+{
+	ssize_t bytes_written;
+	size_t total_length;
+	int i;
+
+	/*
+	 * We need to make sure that writev(3p) call does not write more than
+	 * `MAX_IO_SIZE` many bytes. If we do exceed that limit, we only pass
+	 * those iovecs to writev(3p) that sum up to less than the limit.
+	 *
+	 * If on the other hand the first iovec entry already exceeds this
+	 * limit we'll instead use xwrite() to write it, which knows to handle
+	 * `MAX_IO_SIZE` for us.
+	 */
+	for (i = 0, total_length = 0; i < iovcnt; i++) {
+		if (unsigned_add_overflows(total_length, iov[i].iov_len))
+			break;
+
+		total_length += iov[i].iov_len;
+		if (total_length > MAX_IO_SIZE)
+			break;
+	}
+
+	if (i < iovcnt) {
+		/*
+		 * The first entry exceeds MAX_IO_SIZE, so we pass it to
+		 * xwrite, which knows to handle this case.
+		 */
+		if (!i)
+			return xwrite(fd, iov->iov_base, iov->iov_len);
+		iovcnt = i;
+	}
+
+	bytes_written = writev(fd, iov, iovcnt);
+	if (!bytes_written) {
+		errno = ENOSPC;
+		return -1;
+	}
+
+	return bytes_written;
+}
+
 ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
 {
 	ssize_t total_written = 0;
 
 	while (iovcnt) {
-		ssize_t bytes_written = writev(fd, iov, iovcnt);
-		if (bytes_written < 0) {
+		ssize_t bytes_written = xwritev(fd, iov, iovcnt);
+		if (bytes_written <= 0) {
 			if (errno == EINTR || errno == EAGAIN)
 				continue;
 			return -1;
 		}
-		if (!bytes_written) {
-			errno = ENOSPC;
-			return -1;
-		}
 
 		total_written += bytes_written;
 
diff --git a/wrapper.h b/wrapper.h
index 27519b32d1..a6287d7f4d 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -16,6 +16,7 @@ void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_
 int xopen(const char *path, int flags, ...);
 ssize_t xread(int fd, void *buf, size_t len);
 ssize_t xwrite(int fd, const void *buf, size_t len);
+ssize_t xwritev(int fd, struct iovec *iov, int iovcnt);
 ssize_t xpread(int fd, void *buf, size_t len, off_t offset);
 int xdup(int fd);
 FILE *xfopen(const char *path, const char *mode);

---
base-commit: b15384c06f77bc2d34d0d3623a8a58218313a561
change-id: 20260409-b4-pks-writev-max-io-size-e9b803439ae8

