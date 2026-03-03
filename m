Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51E347F2E8
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550049; cv=none; b=Jmv1c9IdoW2USOnW9fA9kerUZYnSSnK5wQthBiFVWmdaMIRbN/4ezidlkVgBo4EQIMODPwvyRpqoiXJT9TZGLH1jBOyVO6FyKiV+qiTXZr8MctDdhHcDaGZxd/S4DOWnN/nT+DgC+MPLgS6Bjwe14QlWtxjZXyRJIcV/vk+UIDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550049; c=relaxed/simple;
	bh=fyHUuYDkjKRWWumrMFhNgPVa12HTRuXIkysHi4umBXc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EY5uJ1HwPJ2nOAjhpXpvHNfr+8yG+TScq8HHlqmIrCgP+JYPNy8w6t4Zgll95Ub4Ktp5KuuwegM4kuz+kVcl5Me0276DHlLamIPtUDeSwE3kyS/SfUrNRBKdujWqqJT6p6dMit91GEL2dqhHlT6buLxNPT/Ve3mMcJTDk62OWQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Z8jxOA5h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a5nJ5QJy; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Z8jxOA5h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a5nJ5QJy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5DF7CEC0578;
	Tue,  3 Mar 2026 10:00:47 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 03 Mar 2026 10:00:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550047;
	 x=1772636447; bh=vOHkA4AUbkQxhW/msX/hG4Fej8HqHqt9alT8nJmw3hA=; b=
	Z8jxOA5htKUjKuirrK/KRxMhVxvi2lXkcukiiD79s8fpi1X2ydNH171C9UUz+9vd
	XSUQIj/reS3Fx2DUQix0wfRmBS4ZrQY3+7yjBQvokttFxLMsYHMtImYKOk6t51GY
	4n5yVSO/Ipc5piSJHW7mjtBVGskNr6P/maGUG57/GtV/0Zmr0n/wUF34bk20UXRn
	EEMa02eLpqdal5ZZ4iE/2M1kcQnG+EHrZqDUSxfQPONpT6k6jpz8xnpWzq56Ne8X
	lBadbpTCGbZbu5Rkn239ulBviU3PEuBdiKpzmRKT+DOclw+aNPdl1/7BueRajzUT
	zyw0/wsOrnvhbaiY6y7i1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550047; x=
	1772636447; bh=vOHkA4AUbkQxhW/msX/hG4Fej8HqHqt9alT8nJmw3hA=; b=a
	5nJ5QJyB9EneE83hfchVJ+CfCRJhnK/7p+z89mYk1VtnoIhXrYLTNqoxYVvMFRxy
	KNY9TXydk7n1Tm2/aUje5OT02VQC2Q1dL8M7HQd/G/zs0vIoJy41xyN742VOsEDM
	H55wZBB6dsUCgbd0Fhwxhut0xTCe3Z1yKbAsUNL+31pYdaVt0/ulnlGu2Fsfv2dg
	TOAeovi5ieFg426svSe6KvbYOnhEp5PCU5XQuNu1735wUmVv0LR7Q9KX8PhXeWB4
	IdlrftqIULL4A77MFCLL6NAFXc1WACTH+summG36h4xMep71mlb4Yq0VVgWrZoTX
	P2e6GykE90A+NZFZGaFQg==
X-ME-Sender: <xms:n_emaTrrjUjkTZ1uOnrC4-9bUMi6yJpJqBB4mrzfv-8WpjjOmycNug>
    <xme:n_emaUoEau69kfHwYrcGWpDLqOVDewPE92IbsCos2Af3fFeexmcVe_B-s8W31uHum
    Rgp2gCHv_wGQoIH8qM7cfvfxdy58SMSmMvsndR00vs3BRE7wuRYizs>
X-ME-Received: <xmr:n_emaVNdIFGwMZboEg22xW5IaaU09Xh8Xf_EE1SvzcGNijHbl1mAU2LUPyOpf0AyUNn--MHBVWitfX7Gxb1w8NDmRfBzEZFoqk9cNBxkDZng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepmhhsmhhilhgvhiesghhith
    hlrggsrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:n_emaVxcRHppLlkymAwV94o6hmnxWLCSOSy8bylNCQkY5Bc2pXJnfA>
    <xmx:n_emaeswJxSBfDAHU7HOkTnUgq7Htzj1j6XleCnpAqbxDhT8aOmvdw>
    <xmx:n_emae5D3fuHFEpN2sK_Ewjw9moMLIeQ9pKLfAh1Q7r28ZfkSNF4fA>
    <xmx:n_emadTTkJOPFkzi45y5UU-Aaywc5DBREm_JrDJBsstbYyUDd8M6gg>
    <xmx:n_emaQErEgXA445RYq0lrDdHk8sU0KGzCHyAA61GTHdkUzGW413t4zcN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:46 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 10856e0c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:21 +0100
Subject: [PATCH v2 06/10] wrapper: introduce writev(3p) wrappers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-6-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
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
2.53.0.697.g625c4fb2da.dirty

