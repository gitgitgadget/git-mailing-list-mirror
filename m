Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B9438B7CB
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149123; cv=none; b=M8qrZchyLpAlfjerpd4s6o9Sx9E/92jy2jlnMGqhHJlNiIBJreg+IRUM0L0LaPq56ZWRSp3PlmkvBhL17x5yv4gELEkuo4VYSqoo5Awo2E/sseFdpj8uQtxSpcWzKK2/15tEVP+9WN9KA4d2NHgutucLkauTymmtVhsAy045NxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149123; c=relaxed/simple;
	bh=1KqH6zrr8h8plba77FE+hN2FDAB4kUr5AYtdjqgT/Mg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cNAIdckAVwnSg/K7jAStBsNRYbxnLkNPKkxoH1mns501tGlIUZVx97unWBNQ6ogZZ9PuF/+lfNx+KJrxYSqmJGV+SOSome7ANH6vohKR9DhzFk+G/wCZVbDiIIX+80CJRNHYuYdwzWO6EpHNHgxx4QqGR+0B/+ZMddeBdHUnnEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mPcvqi2F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JNiwkbkt; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mPcvqi2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JNiwkbkt"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C0D8CEC0B0A;
	Tue, 10 Mar 2026 09:25:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 10 Mar 2026 09:25:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149121;
	 x=1773235521; bh=wKuWRavWV2QoNluUsmHSx2wfbYmSDoWt2XE5y+NKjsA=; b=
	mPcvqi2Ficx859X+jsalOB6vNyo5kjEFr28o51pygKQp4qn5HcxViQ+4LQohChMv
	oDPzW9kFMwAM1h/jycozl8lTygloo6uO+OIJaARs7HaxxwLqVBGVXuq+UUo+5oEB
	vP7T13IwNWw6tg7W37A9f3+xsg6NwWIUcNrHzRv0mQ/A/V1ns7FO20yUzh1wFnN3
	NiK6XiARDoNz0xrMM7/5/vLtoGVuezydDHCRfSj5QozW6wN91q03g0nagWOi8N7/
	Y5cfH1bU4d6iA3HyqR9GZCPJlvUZNvWcAcm7OGtjVOgZbHW0pnF6XDKl31AHgW4Q
	0R7kplOo+XrUtCA1XrdMMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149121; x=
	1773235521; bh=wKuWRavWV2QoNluUsmHSx2wfbYmSDoWt2XE5y+NKjsA=; b=J
	NiwkbktHvODFLfSeyXBZ+RCV/vOFPbkbXIN4vIwKF66ewXuw5jijzAd/gM7ig9jm
	keD9DSOCSWmYq3gtD0eUi2eg0okgKl9dxR1ZP+pgM0ZFpsKMSub6NR6gK1RBA3Fy
	NDAjBAeSP3GwrleN0/5jbBWMVGhbSQ46z5Q1NHjRekeBmQ5JfNkMdBNghUMN1VZ4
	CZrnD4HDZWom//oJe2V98nQhRy1v2XbPICR6H7/16faWJxKVfJN6TKR9sLEns89V
	9AwfK27nfs+ZbKMZ8UrnJfQKaE+QH+0s3gJ3B9spRjwdyo2AX9mOi1w0k4l+4tCn
	DiEcmWhAVwDFTzS/rAKLg==
X-ME-Sender: <xms:wRuwaY5rKUlOHmFayWPdmzf6NlO5AQn6ZV4B7jyttm6OF-SH0TQR_w>
    <xme:wRuwaQxGWcPhrmV_gZIdX6eXrBOw_Pkta27hEOEZEQWLpK95h8EAiXyepihSNLuiK
    KyqFhSTgJu3WBKtVM9agXvD8JMq0dM9sQCBy1toRcBhTAxc1QUo5Q>
X-ME-Received: <xmr:wRuwafwtFABrbkDhyXyihQ7QZrFKhTEdY8TRBdk6cC7dFUxB6Mm48OkbCW_ILi76WQxI7JNyhnAzXr4tqgRvnyns6ILRxnmdFJVRcq0I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhush
    hthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmshhmihhlvgihsehgihht
    lhgrsgdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:wRuwaYwm2ZtHUz7-4dyB6tTTsV9RvPPCxf0TQ7VPEkiyFHEYtc6m2g>
    <xmx:wRuwaZbuPJpjf0h5guFnpQ88dqWLS-gpMwmGijLDo5bdxv5XFUV4RQ>
    <xmx:wRuwaZWzkHRZA6oc7iJTW-T6zxCJOk66rfNbOqL2DjtYDSZdQX9acg>
    <xmx:wRuwaXicibziG5ouc-zpQd5pEqSJ4Ii2Jdl8wx6fyqA5X-lqVF6gqQ>
    <xmx:wRuwaRQtQlgKfZgiIXdMCjorN4tY-pxkHEJcBwGCt89P8C_E2vsOZBtK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:20 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0c549823 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:25:02 +0100
Subject: [PATCH v3 06/10] wrapper: introduce writev(3p) wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-6-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

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
index 65a5c42a47..ae3d7d88b8 100644
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
2.53.0.880.g73c4285caa.dirty

