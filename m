Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04E7448CEC
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083502; cv=none; b=cvsOwOZf/ozUpa7PIftZbY2pLiRK1J68TQTCb9rSLzUq7mA1nMaKOYju+Pztd0IRsp6VST6LiRPEVgHpmc8DO/JTSO5c9HOO473CgylPr49hnnmvoq/R5iOlet+uVgszsbtA+V1WV/R9IaB4AMuWMyE9Wo8ymr+qcDMrjs7KMuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083502; c=relaxed/simple;
	bh=XuaOxrqSyHf7uijFWc5hM1yhLVRXLi8xjtrjW8YLdcA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=njwJNKQLyxd5yHat6NoDzkK21h5zEctbqqjN2iL6GN3S3IpwDam+hJ/oVwmQcPOEhh2vnuF78XH1VL5XqfZ+hUxNa1viCFhz8ofoCovh+QIkjYBdgbSPzQzqgKEIPK/Q4hqy7EqRK+I7E+ad5oTvIH/avPppAH62EZhp/6+TnLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mcvq4TlZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=msJHm1W/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mcvq4TlZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="msJHm1W/"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 030551400106;
	Fri,  7 Aug 2026 02:18:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 02:18:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786083500;
	 x=1786169900; bh=8IqSKCno7pR+G9S6macZq/TIrpNlBj246rp964rMPBg=; b=
	mcvq4TlZQNi0K3EdF/Exhl/u116/VufX2h1Ob5E2ShbQnxIigt0XZh5xyx/OHLhC
	teteORpwjuGzuYE4ondeDGkIHZDy77G4wzm85pSGXMEtT3h+1w7otieQxw7p+gl5
	ZLyQFhxDaHVdJhwfAnCe75O+FNDTzeSK5rrtqk8dYiE+SPMeXfm/nrN9SJo/dQZx
	/DJK3i34v5MPNvEKkQg/4jhp0S8dmxv9vISnQrVkpkg8m2gk3xOeDlDSnHhm92fr
	Sv78DwG5O88xHH0Jp/G4YtFqmFgKdm5Pv9YoxxStbYGev54xGYSrjjLwD/RR74GG
	U8g6uf/34bZ+wucMAQxzYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786083500; x=
	1786169900; bh=8IqSKCno7pR+G9S6macZq/TIrpNlBj246rp964rMPBg=; b=m
	sJHm1W/vOQIYwwd0/zK5V/o1KdlSnLWF5m/igqr+6t5t4H2Q5wGmEIGK75WhTYwv
	lnWIn5RUrTICQlYC2pVOnGRAx0SHo3JnRzdh8tDBg5AM+Cb4LatpnXZGs+NZcX/D
	LzCPxx6T81N1FDlCIpOp+9yg3gYMeq6OePJphf7dqD3PPAvxk4r73xsxDt1yDCbu
	BfFDxxmC8AwwTXwfK12o7TZEfZQZxSzyfOuCSJ2v1PHRM09iHruQYajnwZXP/Miv
	5xeGFSQvOZJbwr34mpDAMk6O+PZQ/V+cT4n1/dhxr8Lp1SsfK7A1JiaYJWkPQK9M
	FoTib2t+z5/Ift2R0S0xQ==
X-ME-Sender: <xms:q3h1aieQVTDMKq7iG7hjCc_mm8831v5p3wfQ_8XGzj8f8fFnKzoEXg>
    <xme:q3h1amOIzp75pcW7GUpBGBzGCns5e0nOwkm70amVXOlf7GIYCF_YD9mCAB79Nlcoj
    ZJxVvHey5nIPht0XuOlyfwN6zLrEv76eW0hhOul9SbVqcA2EWsYx54>
X-ME-Received: <xmr:q3h1aqKS--mMZEdbD3hIsXcXhPfbb5bIZAHDCHvIFaOUsaaLSOcvGF_7WQTLOZwdPR8uQPzUnqpEV4agB6Uybf3YgAPqOXmwJLJxG2iSGzSiWg>
X-ME-Proxy-Cause: dmFkZTGtplrCE+Xj2F6jSqC5NQvtjZ5r4G8UrSfnEbgyqfaIBhkJRlzCC+cqo5AGchBgiE
    Pl2kY0PU7OTWtQD98oRJFwOpKBwSlz6qyr4pRzhwfwePH7N6OakjjG2MmQ4+GCk0NHOjWV
    KLlVYwjprsIwtMI78SWchI7c0K46Iiw2ptoFS9vQqq09Bq7nJdaRlORv8sZtFkophUmeg/
    4ucf6of6VznlyeSqmsJV7KNRGF1j+8+X83lOMP/7SBLhts5g31/o659Gc58QA26mBhhEiS
    xMYKwBoECPmwMhyZW0aUsLc2mZ8rW9/eqHw7xrZw2pIXROv5IcV9wd0vVoC1xgRBwkDrBY
    +qSDe0dH/wDh9uO0bzHKGCbHCSBXwaubOtrYCYKtAP9C7rlI3aC1agx0VlTCildDzFOX3G
    0toS8FIoOqLG6P73PkNXG3LjpBwLVgzr7kebVgLrMtradIHZJXVYzPYM5sw4mXIdhTKLcM
    TTCXrw/9B+yMIh3VYoy9YQU0uOZFywRtU8KjXGjh9Tt04V/sW3eHt02pPDvT7rUCDpX6MC
    3+QQqznrdZhoYInQIieYuv/QCimonzS/Pqq7Z23d9LG7pFMIQ31tRvkre2TR7cuOf0VBw1
    dD0wJNq68m+Ur4K4qh5usexK431iAdyklad5VVj2Xm+VMb8eXO64SVdAnZCw
X-ME-Proxy: <xmx:q3h1auL46i-rz9yn2lYUZ5WST1YzVDOqZy1bAUXpZT7J8QUhNdiHPQ>
    <xmx:q3h1as5UwnEWIn6VUm5-6Ee8oZ7Jex_vOolG6D3GRrV7BHkbMtI2Hw>
    <xmx:q3h1agcQiwyIXL0sWK908NDMSWQ6QQx92zQ8tUj4Ktl_MWi5fB0GOQ>
    <xmx:q3h1avHxLacUcmSOdr10rEdJjHaggMSrhruOHe3hoovcT8jQJ3sQyQ>
    <xmx:rHh1alxYyua1O9SjrkKSueeNvBwElIRZjtn10yFkmWKkvhWtT89tYFwk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 02:18:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 64ba070b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 06:18:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 08:18:05 +0200
Subject: [PATCH v2 3/5] wrapper: properly handle MAX_IO_SIZE in writev(3p)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-reintroduce-writev-v2-3-30fcff0e89c1@pks.im>
References: <20260807-pks-reintroduce-writev-v2-0-30fcff0e89c1@pks.im>
In-Reply-To: <20260807-pks-reintroduce-writev-v2-0-30fcff0e89c1@pks.im>
To: git@vger.kernel.org
Cc: Ben Knoble <ben.knoble@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>, 
 Phillip Wood <phillip.wood@dunelm.org.uk>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Some systems like NonStop set a comparatively small `MAX_IO_SIZE`, which
limits the maximum number of bytes we're allowed to write in a single
call. We already handle this limit properly in `xwrite()`, but we have
recently introduced wrappers for writev(3p) where we don't. This will
cause the syscall to return EINVAL in case somebody passes an iovec
entry to writev(3p) that is larger than `MAX_IO_SIZE`.

Introduce a new function `xwritev()` that is similar to `xwrite()` in
that it handles such platform-specific nuances:

  - We only pass the leading iovec entries to writev(3p) that fit into
    `MAX_IO_SIZE`, pretending that the underlying syscall performed a
    short write. This mirrors how `xwrite()` chomps overly large
    requests before handing them to write(3p). As a consequence, callers
    will never see writev(3p)'s EINVAL error for requests whose summed
    length would overflow an ssize_t, but observe a short write instead.

  - If already the first iovec entry exceeds the limit we instead punt
    to `xwrite()`, which knows to handle this case for us.

  - We restart the underlying syscall on EINTR and EAGAIN, just like
    `xwrite()` does for write(3p).

Adapt `writev_in_full()` to use this new wrapper. With the retry logic
now living in `xwritev()`, the calling loop becomes the exact mirror
image of `write_in_full()`, which also retains the responsibility of
translating a zero-length write into ENOSPC.

Reported-by: Randall Becker <randall.becker@nexbridge.ca>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 wrapper.c | 47 ++++++++++++++++++++++++++++++++++++++++++-----
 wrapper.h |  1 +
 2 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/wrapper.c b/wrapper.c
index be8fa575e6..561f9ee9c9 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -323,17 +323,54 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 	return total;
 }
 
+ssize_t xwritev(int fd, struct iovec *iov, int iovcnt)
+{
+	size_t allowed = MAX_IO_SIZE;
+	int i;
+
+	/*
+	 * Some platforms define a comparatively small `MAX_IO_SIZE` that
+	 * limits how many bytes can be written with a single call to
+	 * write(3p) or writev(3p); exceeding that limit causes the syscall to
+	 * fail with EINVAL. Just like xwrite() chomps overly large requests
+	 * for write(3p), pretend that the underlying writev(3p) performed a
+	 * short write by only passing along the leading iovec entries that
+	 * fit into that limit.
+	 */
+	for (i = 0; i < iovcnt; i++) {
+		if (iov[i].iov_len > allowed) {
+			/*
+			 * If the first buffer is larger than MAX_IO_SIZE,
+			 * let xwrite() deal with it.
+			 */
+			if (!i)
+				return xwrite(fd, iov->iov_base, iov->iov_len);
+			break;
+		}
+		allowed -= iov[i].iov_len;
+	}
+
+	while (1) {
+		ssize_t bytes_written = writev(fd, iov, i);
+		if (bytes_written < 0) {
+			if (errno == EINTR)
+				continue;
+			if (handle_nonblock(fd, POLLOUT, errno))
+				continue;
+		}
+
+		return bytes_written;
+	}
+}
+
 ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
 {
 	ssize_t total_written = 0;
 
 	while (iovcnt) {
-		ssize_t bytes_written = writev(fd, iov, iovcnt);
-		if (bytes_written < 0) {
-			if (errno == EINTR || errno == EAGAIN)
-				continue;
+		ssize_t bytes_written = xwritev(fd, iov, iovcnt);
+		if (bytes_written < 0)
 			return -1;
-		}
 		if (!bytes_written) {
 			errno = ENOSPC;
 			return -1;
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

-- 
2.55.0.679.g6767b8d81c.dirty

