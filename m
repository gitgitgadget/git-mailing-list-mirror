Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F6F38AC90
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188378; cv=none; b=dEM3N5F83u7nPg2ZXN+6ktqoRX7CQTX+5WfqA/DfAnOTOCKl8R6dTgKpHIMN12GM9ND93PeDDpOiG803jccjP1uzq3JqvsqbelgfpNJjNzVfAQflvQhgv3ivWcn51/BvJ57epLWmWOc1Z7pu/DAgGkrXfjTfnaYcaOAM3GxS8fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188378; c=relaxed/simple;
	bh=MdnKgoHJh7Pj7IWdX9N8UdnYzfeIAsS74yFn1A24RuA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zq/ytHKo0MRHC9HOsJ/L6nU5vbTQlo00RYXqube4nVfGQlShYCx8ngLjGkgm5Tvbmh1IEeMg+3NrN89lUdUxcD+LWJGLMYYvlTLa+f0gWn0q9Ifc8uqlxfppvIaLNag8QN9axjxCZqSWkZ5alPhnRkFRljBcmow+Aq6tc6WdVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FN5fxhOH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q0FeUcsM; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FN5fxhOH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q0FeUcsM"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id C71C81D00111;
	Thu, 16 Jul 2026 03:52:44 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 03:52:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784188364;
	 x=1784274764; bh=EbmZmb5mxAbsEhAEd0irrSF+HbvNyHb/plFT4KpmZZs=; b=
	FN5fxhOH4L8c0obzXUCB3ahBN/bm7bWc44R7j/nGjGdZxnBK0j/u5e1mL/DgzOWY
	3RPXHOvFtdx6ycQzbsDflR0Zt/ZrLT0AolQHtISi3F8W9bwI38joSs4hLnpHLDyM
	tlM68NUmg+UQtrOqx3oauyih1Uo7wjiSs9MqJ1R5wc9b/xZKAEIbY7/QfHn0V6AB
	EUnsZNJfNQRx8B172xFx02d1Oe7QZzZ9QjP9DeI0LqJwdE01Wb6LTVHuMwXJ3YyF
	JuEjgGVJP/ELRrIA6ru7Re1b5tIzxw3rfGN9ypgiPIJDkNtyfbRxXaZdFx7hSlTw
	5DtczimRDberNiIjlVkm3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784188364; x=
	1784274764; bh=EbmZmb5mxAbsEhAEd0irrSF+HbvNyHb/plFT4KpmZZs=; b=Q
	0FeUcsMVzVgEortcWwNV2bdp99F1HcValZQev7dVtksB0F32/M488biwXGU3/q+N
	07QMa2ngPHxFsPKAF1ZU84V+ll4wR3S70L6HL27a5juAna8F9G4tzkFGOMo4bVfQ
	/JZO8KoqU+qr1UTFrKZrPJ9fQuXuLlNkJ/ygxCx0mfKrxDTsaGQXBxuMHWYXVdcg
	kbzrS8P/zuGaDXojPyUtnyjQ/1cZ1q11zl7yRSKTkxaooFNregNXY7lK/U6CcBVr
	/LcdjM5C21pbtV7LDzMbXD7R4e059MRO9XdyvBIlVq6nXW7Sv1r08Ycu4LHvKAhy
	UupvLeMDhcfDO74xAt/7Q==
X-ME-Sender: <xms:zI1YaoYL9JlCdKVKU6OXPJyYnIW02wRCIrtnIfIdTw82JI6FpOCc5g>
    <xme:zI1YatZptBcy677lVOqoVYzEjjG2-TrGtYar99s8_uUR5eCRTl609CY-hNkR4l8MU
    qtN-9vwDszcRiXRpzqfXahSbhkqZrWCQ5t1hLr3L8tQXUXsbXrgRA>
X-ME-Received: <xmr:zI1YapnibXy8EOks_bCtM4htgHlmLcU9sBzoP0HL8YsZkDsuBIabuh2Lz_R9S-6ewDbGXvcG8j-hXJNP8rZ_lcGHUBWw1qkMSbekWKnv>
X-ME-Proxy-Cause: dmFkZTEda8sS+0wxhrO43o6pMt80nwB26KE8oIx9Ot0fIcS46H1XnbSymUNwFotLh2x/dA
    lyoXavDsV71kfmGdk6Eu+OJGUMCgylc3DSWtE6cmqkuhvChxz7suH+0H6je8cX9mWWyB/s
    ZQ6TJd1BeE80TPw1c7CmezQizV1gGiTU20Xefqsye3bngtMRnYWkEHoJbWcwBIhXFwchcv
    55Wcwm/5V0r9EIqEnwIV5gfBv56/Mkexop2ypGNyGnL24denSuuiazHA161L1d03IBtOgA
    j9F5Znme4PyUctOrI/vpBCf2irzLLYDr0zuZWbssKLG4GtXU7osHbtyp/YIMVf2NYdaMoa
    oYyIKip7nTM9lx90psMZiGoxO7eEaehD5amaY+ZAqIz2EaheNE/HFarw25GHLFNbXHV3cz
    DHiMoKNZYS9eshoMf50pKiTSeUVc7UMYPLwACMZHsMATJj00l/wOwcgWnGvw2t+J9tzeAC
    sKD6V3YazSgSFSBnNMnz7KuvUCsMpBKE7rWax2oesqlSK5Wldo0icCnnfPkx8TFAiTJdnx
    EcOnqoD38Nyr5Xvbkr1YvrEkTzZp8i2llh3DFnNoJriWgGzX6oyRw8voJAGLag1pmbWX/a
    4wa2/UhXEHNVYcwoIJe86UaCQUCd34KbdoaPqTpftHMTngDOTgZU8fbh+zEA
X-ME-Proxy: <xmx:zI1Yag3vIiipngKucN3_W3cUKzzOhvo7cg3wAWXt_3QpOxy4jG2OqQ>
    <xmx:zI1Yah3HZKLZAiorwib2EE0tmY1FqMFQHG8bE6aDtkaPaQiUotoz-Q>
    <xmx:zI1Yaqq1PJc5aD-WVrSi7UARk-n3xQNPRhruQx_JgsInzovR5cpnhg>
    <xmx:zI1Yaljq5VvIbzr0wI8pquGsizbE76WYeH5KPFpO-yhEHgUBIFUtqA>
    <xmx:zI1YarKopd5tWoVOOZapU0sniWmVpTVOBPGhytqJyly-XXZYg0ICtYmj>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 03:52:43 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 19f1dcee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 07:52:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 09:52:21 +0200
Subject: [PATCH 3/5] wrapper: properly handle MAX_IO_SIZE in writev(3p)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-reintroduce-writev-v1-3-ea9038c884bc@pks.im>
References: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
In-Reply-To: <20260716-pks-reintroduce-writev-v1-0-ea9038c884bc@pks.im>
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
2.55.0.313.g8d093f411d.dirty

