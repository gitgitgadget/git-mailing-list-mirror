Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECC449ECB
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083500; cv=none; b=GDnmv7DngMSyo4O9Fr3WcdoeTXkZABnIxkdABnaZON9mdVG/tET6KgwmcyveQUqkfwono8vi8xgr8unz7iQpxueo8qhL/xUrpHIzpPADSXH48CUAqIM1+ZWXIXwuTzSxmgCeWUli5NhPkWxZh/CebNGXdWdzp9J/Bw8Opeoj5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083500; c=relaxed/simple;
	bh=An9Be1p0F2Xcz+nY0buzujh9peESEerTttXISo5iZtg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6dBInxBGtCrUmLYeMm16ve8t6dmzybv+CNIKXVWpe8C24SIFQcWcRsfCRR6rX21DJQschE7EqLEtV6hAXg58JBrkpHSFxJwVpun7SbfEw7hoE5Owe3/uCFwgdV3pRNKtwPhFcvf75DoQQvVDK59IqaZA0etXY7wXEwqGdiyxNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=axOM2zcp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iYHU4YRc; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="axOM2zcp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iYHU4YRc"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 86171140010D;
	Fri,  7 Aug 2026 02:18:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 07 Aug 2026 02:18:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786083497;
	 x=1786169897; bh=4SaCcJe45tictldw+Rhe5e9iQ+yE+o1x2nrIT4Yn9S0=; b=
	axOM2zcp4Z/Q+G68hlI/VUyJg6dGctAtjVSdMuTEamY6M2HnA37Wr191Y5RHqKFO
	otUXloBFi5rzUY1hmhRSCfJTdbChUd/tmGjW2Jtx6HHKJyz+JdmbdHz1ggXDTXrk
	Fm3NPnHNLPQr8Kdr78Au5icOAfbCr/L5EPwUFDknA7qkpvmxHGifofxRwMskRTRL
	P7BLi3nwPgiI+nEcj1zwqYxh/Y1I6w6Fnk3mk0tHNxwBprYA8T70sEkka/ETShrV
	8JmMTklzMLoaw2/eQ2TxkHv3c1McTK5UER51lzC9WoPQQe/fBlsRlIKzLcAy9qVv
	8oBFFGswICI3OJgMhfNDEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786083497; x=
	1786169897; bh=4SaCcJe45tictldw+Rhe5e9iQ+yE+o1x2nrIT4Yn9S0=; b=i
	YHU4YRch+PYNBHenRBLD13jKMK3Xb0LAXoP2TTdKoI36OsKqLvGmxvzWV2jkvzIp
	SR4kN2qj9wtmyqc2Wg/y7vxZ40u2KcaGFxbNvUxgYe+/fbMheisOFRgIAkfcM+4t
	mUTJuWRiCepEtbftTCQSD66xop5nsrETdYwNzL/2eW9RBPNfob4kOuAnf2LTRxBR
	xc4V/wuTUIoz+XJg5jXI03UZJWe/J2uCVBimfQdgb2v9bsEb5CDX5506S6TbGBXl
	Sh9pxAy1pqcT3K8RY9fPnQChtdFEPIJbbV5Jg/SVzi0GYSz/naVWNhEE8UbeySlX
	KSkvKkqwLAuUxDblgMV2g==
X-ME-Sender: <xms:qXh1aoHRyLtnE2HQ2OInoIzhh7P4lTTa0VYTqYplrQ9nRm_ouS2CwQ>
    <xme:qXh1arU3kNakP4uS3eDgqsvRE5Hgosm5WjDpBrzKrs_PHgP29E0___a4bogGb7ihc
    6cr0f5UBXQJ1RJMHbpPl3ays7uoWKEdpkCI1xLXU4nT1lpRCnNczw>
X-ME-Received: <xmr:qXh1aozkjmYY7uDN7E8Hba2oqEeztLiF2Vs2dbbmWbr3JDUMwu2pLIDUJcTysjYUEM4feqN4BGbS0n46Kf-aTP06SPidg09CQZWqtJID1DHWEQ>
X-ME-Proxy-Cause: dmFkZTG1N9eFOEjW9F/tsHTgYGBMfnzYVsZfiUzzNpfy3L349Ebh7o8+PZfg6+wr8dRRUg
    uKE0BCvRENZpzpWgLGZ2ALsR1sPlrhJ31UvM7Z2fQGGTWm/nsUtTmV4d4Zw+HB8KsTXqsj
    Mr4aSAdrP7HAJGB5X6OZXLDRSLWjD+cWJhxqBkWEdsn8S5Gn1EuQNVG/2nv+InZMCkKigh
    xR54FCYub0oPnDNtzMLuaGdqW6oxyPe/5ITPzFYgYghT0kjvkVR4Ey3voz1kxslGrQnxeC
    17UEnIXgbLOJ8DrWekwMXizAmnNSYpX1ocQWnXZqwore1sflIOlPGrkXcxYFe/ppt7sAn4
    DDm5/kWxoEvMtVSDc3fuMlKlPEXgQuWJYnp2yrrkaTXwViO9qvFXFHIiEkNzW7LkQZOJCy
    zx0C64BQCElMxO+ucV89epO874hUZLUHfDxXkMEZNHj+sNyOVqu2Hmwwb8TC55q0e/awpY
    av5oKJprLsTJz2sAYSIdvmU8NgeqVG7yQJOIrSNlHBRGIlpQkcPxS7Kc9rZ8kOKQ+qbKNu
    PYgk8RIfDc3IGbzb8Hzyf7U5S//SnKtpIX+cvnyvAJM3WzilGmvERAi8fO55qA/wqHd3xy
    78kfmiH10ORTVrYylO/u7tNq85RvuhjAmlCiIj6/zeSW8kH5oMtNnqZkkATA
X-ME-Proxy: <xmx:qXh1aoQV9QVLjGeRs-sXFuBfS54l-ypeho3CF4TjOQDDA7EZwEaN_w>
    <xmx:qXh1asgRIovHJkFiQrHKZMXO3cn63b1S3d86_217cXLsv3jde-1AJw>
    <xmx:qXh1ankij-DDBREP1CRFVSqwtB7NvmTodQh-EiFCQIYhYdLtI4Qi5g>
    <xmx:qXh1ans4lHJMWKcM6CdLQS-YPxT5X1OOjxZuZvyCmgog9ulldzJnvA>
    <xmx:qXh1amXj2LaOgZvmJHGWxwt2a0U5Dp-kDLHrQP7MY2jN8v67pR7F3jz_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 02:18:15 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6389d0f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 06:18:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 08:18:04 +0200
Subject: [PATCH v2 2/5] wrapper: introduce writev(3p) wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-reintroduce-writev-v2-2-30fcff0e89c1@pks.im>
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

In the preceding commit we have added a compatibility wrapper for the
writev(3p) syscall. Introduce some generic wrappers for this function
that we nowadays take for granted in the Git codebase.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 wrapper.c      | 41 +++++++++++++++++++++++++++++++++++++++++
 wrapper.h      |  9 +++++++++
 write-or-die.c |  8 ++++++++
 write-or-die.h |  1 +
 4 files changed, 59 insertions(+)

diff --git a/wrapper.c b/wrapper.c
index 16f5a63fbb..be8fa575e6 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -323,6 +323,47 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 	return total;
 }
 
+ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
+{
+	ssize_t total_written = 0;
+
+	while (iovcnt) {
+		ssize_t bytes_written = writev(fd, iov, iovcnt);
+		if (bytes_written < 0) {
+			if (errno == EINTR || errno == EAGAIN)
+				continue;
+			return -1;
+		}
+		if (!bytes_written) {
+			errno = ENOSPC;
+			return -1;
+		}
+
+		total_written += bytes_written;
+
+		/*
+		 * We first need to discard any iovec entities that have been
+		 * fully written.
+		 */
+		while (iovcnt && (size_t)bytes_written >= iov->iov_len) {
+			bytes_written -= iov->iov_len;
+			iov++;
+			iovcnt--;
+		}
+
+		/*
+		 * Finally, we need to adjust the last iovec in case we have
+		 * performed a partial write.
+		 */
+		if (iovcnt && bytes_written) {
+			iov->iov_base = (char *) iov->iov_base + bytes_written;
+			iov->iov_len -= bytes_written;
+		}
+	}
+
+	return total_written;
+}
+
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
 {
 	char *p = buf;
diff --git a/wrapper.h b/wrapper.h
index 15ac3bab6e..27519b32d1 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -47,6 +47,15 @@ ssize_t read_in_full(int fd, void *buf, size_t count);
 ssize_t write_in_full(int fd, const void *buf, size_t count);
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
 
+/*
+ * Try to write all iovecs. Returns -1 in case an error occurred with a proper
+ * errno set, the number of bytes written otherwise.
+ *
+ * Note that the iovec will be modified as a result of this call to adjust for
+ * partial writes!
+ */
+ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt);
+
 static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
diff --git a/write-or-die.c b/write-or-die.c
index 01a9a51fa2..5f522fb728 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -96,6 +96,14 @@ void write_or_die(int fd, const void *buf, size_t count)
 	}
 }
 
+void writev_or_die(int fd, struct iovec *iov, int iovlen)
+{
+	if (writev_in_full(fd, iov, iovlen) < 0) {
+		check_pipe(errno);
+		die_errno("writev error");
+	}
+}
+
 void fwrite_or_die(FILE *f, const void *buf, size_t count)
 {
 	if (fwrite(buf, 1, count, f) != count)
diff --git a/write-or-die.h b/write-or-die.h
index ff0408bd84..a045bdfaef 100644
--- a/write-or-die.h
+++ b/write-or-die.h
@@ -7,6 +7,7 @@ void fprintf_or_die(FILE *, const char *fmt, ...);
 void fwrite_or_die(FILE *f, const void *buf, size_t count);
 void fflush_or_die(FILE *f);
 void write_or_die(int fd, const void *buf, size_t count);
+void writev_or_die(int fd, struct iovec *iov, int iovlen);
 
 /*
  * These values are used to help identify parts of a repository to fsync.

-- 
2.55.0.679.g6767b8d81c.dirty

