Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFEE3BED77
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188382; cv=none; b=qvkbXG3yxKMgxJ0iqRf7kydqiAxWYIMqX0FH7S01KZXLCxv+cHQwXNKG9SKFonEm6cxDEwXACrT6ejOAuwqpJK0WeEl8jKMtW9L71jHZw+rRdbqyZKsS1CNIe0VmhpoV+n6QqPVhoUa5Q2v4wtTEmoC+WG9wFK+GfupxO3eMeso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188382; c=relaxed/simple;
	bh=4IuGb59Ttpo9ZJDrUeBmIR1dFX92Hu/WK+ZqB+IMjq0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mNPEOVXQW93kBP4U54JPGehF6kjM7AisnTBcgDHmklew/Kzef9Xn3FPmEQuKRYGCX7GXBkJkgkTSS6TVr5ADhA1iN2m3eIecuWFIeHtcANqh2SyIY1mZ8OjrJJXlVCIa2Jah+6TSD24IptVZMOhAMbycqFuLQPOmPcGwUF2z5Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Fj7sTPz4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bGZ6ZFcY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Fj7sTPz4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bGZ6ZFcY"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C416A7A016A;
	Thu, 16 Jul 2026 03:52:42 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 03:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784188362;
	 x=1784274762; bh=nXuSkA55uacUbi9dMjc6fJlDSZQ+mSgid+vXSypDekQ=; b=
	Fj7sTPz4IExTQxJ54tKq+CIeV0VPp74BwqjhRbqHm64KN/76qmHYIpYa9YxJVD5Q
	XluMeqNInobxM+K0rPd09RhC2Qju5IDPLcfqFXwd3vDDJCiRAjkG8o1j45zCH6qZ
	uWLEYolm9tvLC3H0rRC39cw119ItYpxG30r+cYEw6otuYZmys1sapQGPrZyWW6zK
	WVRQa2IhXbXts0Edtz0LOLBwpjezhlZwy7QzrrOwvq6TPhHiQi2531eYqYRbMgZm
	G/bgDwTxVjg8Gw+JURezvH4OaNodHtkbhyfMjNJtIOqWKjD1PY3MQkMNn2aOCI8q
	LnC9HY38tO3k27zrE/n77A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784188362; x=
	1784274762; bh=nXuSkA55uacUbi9dMjc6fJlDSZQ+mSgid+vXSypDekQ=; b=b
	GZ6ZFcY+NiZr7bYwuUcORcPVvxtINMmnOUeM6aXfMqpGKFdtnItFpMTcUtddKaWO
	B/Tj7kbM3JJl8wTe6shnyrTZVGMbJDRXeFIEwMXjLoW8Cia39DaMkDZndOw5O+Dk
	WEXVtUB+mbZbT3yiEYT6bEVdwBnkGf9jac/2W58rvhICYJLPS1jTHC609CbvkCsi
	WRVT1B7P7heyPIvxRpzr5U9xZrNe1cU/ot+nfnGUVXsba0dMXDo+V4hnO7NN86Il
	FUePGWMtIkq4WtHSyUaojAYtU5RlPE7P8lR8O9rktIMLqfqFJ4vrhEXAr0H/z6DV
	l7y+aLrA0tZbhMN0EyBdQ==
X-ME-Sender: <xms:yo1YaicJRSss_03HqI0QFcHDT2QXDfRHiqXCL8EQarKs-Gigrb4hIw>
    <xme:yo1YamMNeynfP0tgaX97ERTkzXnO7KwkvhvJodvTjmFPYTSHjOEM7tZfBmP-g8W6Q
    iGP3ZysDjtgePY5KnH8EN9s8lT2y94UbOo4xpRwvxnol-efv87u3A>
X-ME-Received: <xmr:yo1YaqIz7pBFFynGlhuFNwitvqnWHlDPn2NpQM18thyOmrn4RZOhiw297yCmJg-rQn2jx_NkPINiAaKc1LHfYAEoGb49_f_y23oaB04S>
X-ME-Proxy-Cause: dmFkZTGYii/B1rFJhXzo3z0wN8Ezh9lUCSv+undd5qPY/f25ho7sQI5M7sGK08HN4j2jF7
    5V3X0M3dUbdZqdWtiiqG0VjhPl1/0fVo+zQ1YPcnHjFx9gtogh+FSgpL4TZUj6haR2dWA4
    7ed3fXD7+DfrAKRXLw8qTQnMVUcxdLsMxmO0bHg+h5YNPBFiQkcKhGJPAfED479Jubpxco
    JBNp5/h2QhfpZ4HATmJ86nSg0XkrK8v8KiHBrYztf/OQgxPtanrpBf3RNqfu/umGLfFD0K
    mYIKpcVXtgbpzY7xkCa4L7LVxz4FrV2YoC2rQ8Rse6fGN+wnBoFMifTyPrC7cjRlClxJHd
    OEaHH+kyqLzixvDQJGUTV8UhVSz8zxx2EKRdh+OCSaKvAerj8XygUbCk6e+ChKIAlhjWRM
    e9d4fIK4hdEO/SZEE252VZIsyx3IeUAsMmcerPkD1YygxkAiODVlm9SJ1Pk0m+bTqSq2+7
    xjGDlfhLzq7qDTx8FHC7hJAGW36zsZf/a4955X4vop8gtzpbOIwiSnBBHybXz99LrYmjkr
    VBbQss6fRGLjON+wmIK58ksix6XWZnK6g7UywSTNQtKmWI6Kt5IDYE0TtepQ3aHEQS4s+4
    uu36hPCgu7PtNCI1glUnIzYFwmbLQv8Mb/TEnjRXPWLb8/QIPrnjua+DPXhQ
X-ME-Proxy: <xmx:yo1YauKF361he50h-iNEFGFfeclOWJIDHViXqcBrYauZNXe1zu9kXA>
    <xmx:yo1Yas5dkMV_AtF4K3Ty4eRNTGhIS17e77FbzP1rzI8VtObBzAacIg>
    <xmx:yo1YagflWiMp5uXcxxk2oIBb6XMQni09D_mn7qsXF8T7aI2yA8QfJA>
    <xmx:yo1YavGiCXOzb77ji48V2POty_F7zoznAEhkJD48FceAOu55R76Rpg>
    <xmx:yo1YavsvO2zAr0MVDVwLmvAsmtzSQrsxF9hzJyK290fokO51NYYMrXSF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 03:52:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 61b5a0ec (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 07:52:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 09:52:20 +0200
Subject: [PATCH 2/5] wrapper: introduce writev(3p) wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-reintroduce-writev-v1-2-ea9038c884bc@pks.im>
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
2.55.0.313.g8d093f411d.dirty

