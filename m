Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB46C1C84A2
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384341; cv=none; b=fqeePIPEhhSSfIc1EJfyGIU7Nzrl5jgLTtQnwDqzrw0zU3tjBtWUOq95U461+RQ0iCdeDIh0QRRK3JT0znCh+w3ivnSudXwzqVJxRy3j/RZb3AzV2axuO+BPmxYzat4l769lYNJh/5AowUwo+dKFY+fSf0wB4g55sJun83dQgK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384341; c=relaxed/simple;
	bh=t6vhza+NC5kbCw+tUiaWYPEihGrOibYiEsQZc5qH+E4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M2K6bshjWZIgW9KkJmf1dpDpfoWpJdM+HXR4dfnNVOsCSuM00xiHjhO0ze6r+00luM9ErNaHwjEOixsyRAdrNM3JHyKgIdqDIUNPJEfB2nV5Z5pgVYgQVoTlxHa050lZrkYvE2Ssyg5QFuhHhk24yl+6y5bMkyM10LFIOX39oOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=m7xr7JD8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R2zr74KR; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="m7xr7JD8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R2zr74KR"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 42B481D00126;
	Fri, 13 Mar 2026 02:45:36 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 02:45:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384336;
	 x=1773470736; bh=uqkj4VkSKAP6Ye8E3DdexCuGdm3yVCz4CW9noOuIGP4=; b=
	m7xr7JD8JxYX8AYECojzdZseh6qxUYd+STzC1sSWcspw1FFIEz2TU9Tn/1d8h0kD
	gNTheRcr+BLYoyDt+kJXK2+24y0XRpzsGDcssPJur2guY2wEhsa9qwFg22/drNzf
	yxDo67dtLEMWjQujUVz9502qTZwOW2oobyTGRpE/XGWR31JPn9Zucq9/vEpNzrji
	0a9frtCfqdWicRpnbWGGpBW6GB+JXGclhbBh1D0qdo16Laycihb6YEHf4BmsD16B
	JJNl/m9apWm/yAhKw0N2bIC5bbWblDAZRXUwKGjhDMkCy/eY4Xtf830EOYPqR4tH
	q/iWwfTYlQxp6dvp6yVtog==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384336; x=
	1773470736; bh=uqkj4VkSKAP6Ye8E3DdexCuGdm3yVCz4CW9noOuIGP4=; b=R
	2zr74KRhYUNm3kad+apwFhto8JETfI6Gtm0T4JpuS1nXcuA9KIxW342s2uUQJwp8
	+/rYCdKN8BYJt5hKPg80UvCMuAhzMsL0jjULHoFA34YIaCaAwxAhZP62Cs2bVkoq
	UxiisecJnJVnHOmFwrSeeyY4vL7zbb1Ty7x7Z1yHzRaIt0QcozXu4FLe+Bpen24U
	qJJDlKruIi93WbXbIfBTnUiXxiXtONRYAfMkUQE//DU8pJ8UAaVB9mGJqTk7afdG
	t2XbbU+0kpJY8o3s0Z60hrPT29E4zaK42AfgaM9eornrRSkkWJn/ats+juWw4fvJ
	B32cGwZ0r7NT7WKe7m7hQ==
X-ME-Sender: <xms:kLKzaYZsZLUx6sSXgX5ORn4rdM4uE8mJs5-bleCa8oigpu5l_Ah2eA>
    <xme:kLKzaaR_989ZY--pgChgTigc9gsXL91ygqryd3XD4-3kJnTsYDh9dtqPeJXDATzRC
    ri80uPGdIowMucFayj2SphBiMnpAducs58uNA-CwNCABe90Iecj_w>
X-ME-Received: <xmr:kLKzabRDUW-eN83SvYVfFev-4gA5vzc4YpnWTEgZZDs3Fx6N2eeai3Ab8VFnqWYd2gQMh29SdfJeDsn-ZbUQjzoh-uJ62dhXgsOhuOinhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehmshhmihhlvgihsehgihhtlhgrsgdrtghomhdprhgtphhtthhopehsrghnuggrlh
    hssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
    dprhgtphhtthhopehjiehtsehkuggsghdrohhrgh
X-ME-Proxy: <xmx:kLKzaeS1_m-xk_FYbrzYRIzTfAuYCsQJyl3x9Xf4uYajAcRPzODeAA>
    <xmx:kLKzaQ4HJCLNTc5IGDa3LmBMMe96w06KQfJGMDW8fyJE9fHWDVWoDw>
    <xmx:kLKzaa3ukZBi0dRrYayZNSv5WaIB55J7BAvq32HmCHHsDEdig-LqcQ>
    <xmx:kLKzabBVRw5dkbG34mHTofC7pMHnyrZkLwsTFCrRbGcJcsghn3KONw>
    <xmx:kLKzaTsx0uvFsP0lmLJoKqT_gR8gum73udaM7NI5ytJOjkTD24vbSHAh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 22846b59 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:17 +0100
Subject: [PATCH v4 06/10] wrapper: introduce writev(3p) wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-6-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
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
2.53.0.904.g2727be2e99.dirty

