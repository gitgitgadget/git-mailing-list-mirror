Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F33A126F3B
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773384337; cv=none; b=ppGYpGxUa1WDQGCnCyQ0t8SO8f/8mGu6lRiakmNtUu6qW5XcvkwdB1qgEdZko3cB91YP3ozK9yMqFARKk3+e+9v4PlEdEpi9pb5TeQSLgAcvnSXOKmU/+LGkoU+4rMbYVjJKT3HCEaYDLUh/dpeisuNOcVsf9XuQO/NfEvCieNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773384337; c=relaxed/simple;
	bh=LyfI/XI2nHNzzV5xVrU4aIcUX7G/j7kItacnkKmy2p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4uLtQVl5HFCXMiX+dJmv0bwF2oe0YKnYZysx8+RxtOf50M1lUa0M0yz8fTMFWxapThwBL6DVPxeUXsgNfzCht7W/dcu3CuLkFiGyPPfcy+upwpNnEhv5Mx/ABKNcFUaQwYpnCLZkGMQ8FYjqQnPQ96IVaQiuCUCknpv8SHIh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a18M5vYc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=em8imwto; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a18M5vYc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="em8imwto"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B9CD47A018A;
	Fri, 13 Mar 2026 02:45:33 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 13 Mar 2026 02:45:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773384333;
	 x=1773470733; bh=F5xOYbkbYer1XVI4h731eThft1kqAsTzxLiMfxfZTpc=; b=
	a18M5vYcyz5LeVJIt9AhaoKqawjzVQ7cDPd5Iq1qXMCxK3cyqHmdsTBDUUKeMeDd
	5KVoapJB+7ag8/Mqy8Mb5dy2o/DSwbtDOo4iTxSvuG6aYsVJ3JMYp3c2IX1vkBqN
	f+ZoHesxgc/o+PYDDTBNLS/cznIi1ARzc9JYEsyq0PZyapvNo0kDHQ/mKBkx3wZ+
	/uD9009Xx9qLKJQA/M0UC3YCMBRPdbZcsyNistF0uruSaFFbh5V6XNtVasIfgfR4
	48kc5tKy2B0TTCz4EkErT8hRuC/bu/hVSUn9jV5Ic2PBVH8lNU09lo+TVrVUj6UG
	83mgea2ZJIsPa7K52R3HXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773384333; x=
	1773470733; bh=F5xOYbkbYer1XVI4h731eThft1kqAsTzxLiMfxfZTpc=; b=e
	m8imwtouhD3Llb+rwbi+uAd3cQeZA/GmwJCApXlKPKBPngGK5c8wy7ZrXsqB/0GU
	nhQ5o4ZgOCQSyncRQo1EYO3IVoM9LMm9W4nC8FN+ji2+d1uyLKXXqOvZxhxLb20U
	Ot4A8jhUnxpZ7rtn+IhgEwHk4YCaOwNPpaA8+IEdi3Xswb3VDQY6hUsU5mYjOrv6
	yXBxEduHBScWKBXr5G7hdA0gMJzmCpcnbapAu54TzG+cesqcFn6ZRIdZsadI34Y0
	kztnZlxX0II5zjobia3Uj76PUSq3551XvaNaAW9Ac63P4V4L2Xg0bee7EqF1P0EK
	dspt/tbmV/TpJwk9Ve8iA==
X-ME-Sender: <xms:jbKzaeM4QqvDNwBzFKWFnWE-Uwft-1q__PYRzpBQFboCj8pZ1GnfNA>
    <xme:jbKzaT0Rv9Bg-jZjb1Cpj-pogm7BLTAHJX9EnzMg_Takl1RX2jKd1TddU_JiFFVkJ
    2hUuNLclTqy_T9Zv7rfr8sn0vEweNudtLOO0jJeQJlhuQPD8UJGHA>
X-ME-Received: <xmr:jbKzadm3JfhFZmdTW5lMSFSufuONgZoDCr2fp3hJOJ1rO2veHiT31zcPe6ZmMpZ37FsI4lVAyGoGBIWXprE-UFMsVIO-M2Sm-VRLXa9oWA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetfeeuffelkeduteduteehhfdtleefffevgfduteeiudettdffffduledtieettden
    ucffohhmrghinhepnhhonhhsthhophhtohholhhsrdgtohhmpdhgnhhurdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epjheitheskhgusghgrdhorhhgpdhrtghpthhtohepmhhsmhhilhgvhiesghhithhlrggs
    rdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsth
    gvrdhnvghtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:jbKzaaVn6bpi_NizAxanb4DnWRGug7jSN_Gy4NnJHoLoCdHMGUnOLA>
    <xmx:jbKzaTscsR8B-VBcS_fuNJLbP5D8bfcG3JMublpJsqRpmTpmCxNJjQ>
    <xmx:jbKzadZgJtJtKP20WFqJZdE3ZqYIFpLQX_WTG0QVTCHIYat_9m2rMw>
    <xmx:jbKzaSXH2CRICpuBuO0dGvxpMGbE9PYxAqlt8FHcDU6QqqYZbiTgAg>
    <xmx:jbKzaY35bfy02seBL22F2CmP3XQYBa75p35HUNogBOL1RY7vDOG6EGN2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:45:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 028e2b7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:45:31 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Mar 2026 07:45:16 +0100
Subject: [PATCH v4 05/10] compat/posix: introduce writev(3p) wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260313-pks-upload-pack-write-contention-v4-5-7a9668061f7f@pks.im>
References: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
In-Reply-To: <20260313-pks-upload-pack-write-contention-v4-0-7a9668061f7f@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>
X-Mailer: b4 0.14.3

In a subsequent commit we're going to add the first caller to
writev(3p). Introduce a compatibility wrapper for this syscall that we
can use on systems that don't have this syscall.

The syscall exists on modern Unixes like Linux and macOS, and seemingly
even for NonStop according to [1]. It doesn't seem to exist on Windows
though.

[1]: http://nonstoptools.com/manuals/OSS-SystemCalls.pdf
[2]: https://www.gnu.org/software/gnulib/manual/html_node/writev.html

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile         |  4 ++++
 compat/posix.h   | 14 ++++++++++++++
 compat/writev.c  | 44 ++++++++++++++++++++++++++++++++++++++++++++
 config.mak.uname |  2 ++
 meson.build      |  1 +
 5 files changed, 65 insertions(+)

diff --git a/Makefile b/Makefile
index f3264d0a37..493851162d 100644
--- a/Makefile
+++ b/Makefile
@@ -2021,6 +2021,10 @@ ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
 endif
+ifdef NO_WRITEV
+	COMPAT_CFLAGS += -DNO_WRITEV
+	COMPAT_OBJS += compat/writev.o
+endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
 endif
diff --git a/compat/posix.h b/compat/posix.h
index 245386fa4a..3c611d2736 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -137,6 +137,9 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/statvfs.h>
+#ifndef NO_WRITEV
+#include <sys/uio.h>
+#endif
 #include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
@@ -323,6 +326,17 @@ int git_lstat(const char *, struct stat *);
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
 
+#ifdef NO_WRITEV
+#define writev git_writev
+#define iovec git_iovec
+struct git_iovec {
+	void *iov_base;
+	size_t iov_len;
+};
+
+ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt);
+#endif
+
 #ifdef NO_SETENV
 #define setenv gitsetenv
 int gitsetenv(const char *, const char *, int);
diff --git a/compat/writev.c b/compat/writev.c
new file mode 100644
index 0000000000..3a94870a2f
--- /dev/null
+++ b/compat/writev.c
@@ -0,0 +1,44 @@
+#include "../git-compat-util.h"
+#include "../wrapper.h"
+
+ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
+{
+	size_t total_written = 0;
+	size_t sum = 0;
+
+	/*
+	 * According to writev(3p), the syscall shall error with EINVAL in case
+	 * the sum of `iov_len` overflows `ssize_t`.
+	 */
+	 for (int i = 0; i < iovcnt; i++) {
+		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
+		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
+			errno = EINVAL;
+			return -1;
+		}
+
+		sum += iov[i].iov_len;
+	}
+
+	for (int i = 0; i < iovcnt; i++) {
+		const char *bytes = iov[i].iov_base;
+		size_t iovec_written = 0;
+
+		while (iovec_written < iov[i].iov_len) {
+			ssize_t bytes_written = xwrite(fd, bytes + iovec_written,
+						       iov[i].iov_len - iovec_written);
+			if (bytes_written < 0) {
+				if (total_written)
+					goto out;
+				return bytes_written;
+			}
+			if (!bytes_written)
+				goto out;
+			iovec_written += bytes_written;
+			total_written += bytes_written;
+		}
+	}
+
+out:
+	return (ssize_t) total_written;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 5feb582558..ccb3f71881 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -459,6 +459,7 @@ ifeq ($(uname_S),Windows)
 	SANE_TOOL_PATH ?= $(msvc_bin_dir_msys)
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
+	NO_WRITEV = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
@@ -674,6 +675,7 @@ ifeq ($(uname_S),MINGW)
 	pathsep = ;
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
+	NO_WRITEV = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
diff --git a/meson.build b/meson.build
index 4b536e0124..381974ab57 100644
--- a/meson.build
+++ b/meson.build
@@ -1414,6 +1414,7 @@ checkfuncs = {
   'initgroups' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],
+  'writev' : ['writev.c'],
 }
 
 if host_machine.system() == 'windows'

-- 
2.53.0.904.g2727be2e99.dirty

