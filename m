Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C9414DE0
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786083497; cv=none; b=pRF8iQnyYUJPMjU10fuK734QxChvlKcvwnoEokB6uDhNxkZtCtU6lqEm0Z+smSsywyta0YoYYAh4N5ACX2je55vCtUWN1YLun+ewACtTfs/DnGvgZyTdbBCWJHuYKg6NU4KfANPyN4IIM+YKZAmrCvJbhI5OyqAGKQXed0soppU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786083497; c=relaxed/simple;
	bh=AT7mas/7JS1PsYglWaaRWUiX0E3WmFSCapysCQYxR/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dG1LJoSIb9f03qO1+vBr9SEeMsy+NgroVu8Kn7QpRkHM1tTtvlhp2VdQm+q4caPAWFNDkt/Mu75wQ9gCENSy+uZj6YRMCA1MgSYZLjzUH5NTc+05GICHhtoK5ODDHtu2zekAJ5SJ4jvBEr4jdSTNjK1v84MKNRGl3NSeP+9THQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fQODf4ft; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ru13q8IW; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fQODf4ft";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ru13q8IW"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id D0BD7EC01AE;
	Fri,  7 Aug 2026 02:18:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 07 Aug 2026 02:18:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786083494;
	 x=1786169894; bh=cK+GPTCwMAbpMExY+HvLHzS+1+bcZBfx8B0Yp+cZJiY=; b=
	fQODf4ftV3S92rrK1WRvEo5Ue0SPuOLdIZsyuJ3fIDS0hLN08V8LzI1gj7Tsorgs
	ZIx0fwfOAjNos+PPm1/HbLQ5iEyB4f8CdVK40HG3167U3Tou0u7fE457ZD2rqTSj
	/bIW28Ckg+BcyJpcaLZ5Z0jHdAfb/fvdH1G/xTOQMeFTUaHPgU2F886gVB8YEPSS
	oGgJpkkTO1GVAyr+tuaBy1TBOWE8YZGk8LS2JrrLLVqT/JCn+8Yp47nn9V4+bjWK
	XUprCsVmCHurCZohVCodlDKIj2n9EZTS7hLtfGRcX3q9iC/ZzMwXxjUEpUs5podl
	TjDDek+0tf+fjvZb1/jCVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786083494; x=
	1786169894; bh=cK+GPTCwMAbpMExY+HvLHzS+1+bcZBfx8B0Yp+cZJiY=; b=R
	u13q8IWx3RhK5k4ZYoaTmTW7uwsJDgMQPLKM+aKuaJLyugz2dQK1Gk6upbiupv3E
	mkgiHapdv2b7L+iNdtf5O/saMaGPX4PXv+IW9wCwp+PkHlmWdg7ysHDntYnr/HGR
	UnkkI5c+8SpeerjSZi8OztF6k+fW/QI/W7Mc/4TUYQRAk8EUC3OczR3j6CR7xPeR
	QYKsXnylu9senCc2/TWMN93dimopW/qM6szARb9k9B3oFouYwgDodjDF7QmijNws
	GtZoZvI89Xz0wYIeA+D29jNyoEKC7IP/z2v7JjrUiBG0vHouOhmRgsF4ReCgeTiW
	Cpttp/mcxtXpnoxNCalHQ==
X-ME-Sender: <xms:pnh1apGah8QUiFL0jftvmUWHXf85Qy5RBuG6BGxlQzr1nWVi0g-oYQ>
    <xme:pnh1aoUzMDMwon8themVaZxCRKEY6B2nRp66xZnEo1Uo2yBppr2TUGeffAV0gYP5p
    KDF8yKPBkHl6O9SnEWHuo721s_y_N_s2r_BkThtsZNZRh4nUCK2awk>
X-ME-Received: <xmr:pnh1ahz8qRZnpW3KynR6sxxJ3FA2VeygUT9lRDhNSawTSAnEYn369rhF1het9l2MqVp7Lc54klXBFaTLkpgcgAhlB9DhI1QFmDEC0nujt0_iPg>
X-ME-Proxy-Cause: dmFkZTGrFKEnXSwaYDZrO5VYsNTB6YREH7zz7IaYBHZsn/hcrevsHTrUCqHoUn7irspjW0
    CJyVWa+ZfqvqB/Kjqz+gstFEctXbDsz9jm1LeUKDn2GrmC1iH57he0u6+KcONE+b6BkJtN
    rWiMWORwqTkOlUbBjo0zBPwuaP4komJ+GuFaxNmNYmMeNXJJOxCV3jW1BPdVaV/UygHHJr
    BlveDp0ynmz0xvi6b4U7pMsG4fI57EE2jjzRLmgYx4yHE2qp9nM7G0nXTkW4ysw7bm2LIg
    ECnDJhU/D2RiS+ZmABQ/xgEARzJ186Tpf5wwZxd73QeOOdw3RLWA9rtF9HQCtsWyOJFZRZ
    HcCPXRV2Dx5WNvCFHcEC1Ie69OZLW/Xgd7GhiEtaONBMtDVmbujHQgN0YQzt9is3f+irtD
    Xl8LhREtibmrhsO25ErxSMZxAwDx7vT+/zbSlgGs2+CHP2WGOkn+cgfqV5cCJkZRU+BX9o
    IvuxAS6B5/Q87rBEBdcE14vAu9lMGPJhtnKnu7masGb9dof9xiyNB7JkdANq+NL3noErA4
    qNjf8PAtq5NrhFfBAeja6HBowK1rO2HnVt54jKAyufmgoRaf9z1J5+uKTV7PrBHoWLlxWT
    xeph89Ab1DThhJqaR6VSgk+BLdBdvF5h73/EKPFKUFJg4poJHAmA1J7qqg4A
X-ME-Proxy: <xmx:pnh1atR9afFrCKsK2EgQmpHGnDgHf9vC0l_0FSrN6NdxXwnSJPZyrQ>
    <xmx:pnh1athbKuuZhFgVFS76Pc3lqXpgFr1ga_LhPTfEQJP2oywiDIEUjw>
    <xmx:pnh1akkLYV3IyXyCgnTc5v-8-WxL_kIA3We3p1-1S7UuXpPcREQbyQ>
    <xmx:pnh1ags53y72mQf4QDWtsecBYfNoyEPMGkDHDl9EcRQW5tunnJn0AA>
    <xmx:pnh1avUeFW6fpeLsI8OcwcdYnusoWSLwHLIQnetCtPOoI6H8QyQ6n6Oa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 02:18:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 78308405 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Aug 2026 06:18:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 07 Aug 2026 08:18:03 +0200
Subject: [PATCH v2 1/5] compat/posix: introduce writev(3p) wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260807-pks-reintroduce-writev-v2-1-30fcff0e89c1@pks.im>
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

In a subsequent commit we're going to add the first caller to
writev(3p). Introduce a compatibility wrapper for this syscall that we
can use on systems that don't have this syscall.

The syscall exists on modern Unixes like Linux and macOS, and seemingly
even for NonStop according to [1]. It doesn't seem to exist on Windows
though.

[1]: http://nonstoptools.com/manuals/OSS-SystemCalls.pdf
[2]: https://www.gnu.org/software/gnulib/manual/html_node/writev.html

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                            |  4 ++++
 compat/posix.h                      | 14 +++++++++++++
 compat/writev.c                     | 41 +++++++++++++++++++++++++++++++++++++
 config.mak.uname                    |  2 ++
 contrib/buildsystems/CMakeLists.txt |  6 +++++-
 meson.build                         |  1 +
 6 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 1f3f099f5c..eda5ecc5b4 100644
--- a/Makefile
+++ b/Makefile
@@ -2033,6 +2033,10 @@ ifdef NO_PREAD
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
index e2e794cad7..71cc731620 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -148,6 +148,9 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/statvfs.h>
+#ifndef NO_WRITEV
+#include <sys/uio.h>
+#endif
 #include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
@@ -334,6 +337,17 @@ int git_lstat(const char *, struct stat *);
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
index 0000000000..540f66de61
--- /dev/null
+++ b/compat/writev.c
@@ -0,0 +1,41 @@
+#include "../git-compat-util.h"
+#include "../wrapper.h"
+
+ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
+{
+	size_t sum = 0;
+
+	if (iovcnt <= 0) {
+		errno = EINVAL;
+		return -1;
+	}
+
+	/*
+	 * According to writev(3p), the syscall shall error with EINVAL in case
+	 * the sum of `iov_len` overflows `ssize_t`.
+	 */
+	for (int i = 0; i < iovcnt; i++) {
+		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
+		    unsigned_add_overflows(iov[i].iov_len, sum) ||
+		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
+			errno = EINVAL;
+			return -1;
+		}
+
+		sum += iov[i].iov_len;
+	}
+
+	/*
+	 * We only ever write the first non-empty vector so that we can
+	 * guarantee the call to be non-interleaving as guaranteed by POSIX.
+	 * This works just fine as callers have to loop around writev anyway.
+	 */
+	for (int i = 0; i < iovcnt; i++) {
+		if (!iov[i].iov_len)
+			continue;
+		return xwrite(fd, iov[i].iov_base, iov[i].iov_len);
+	}
+
+	/* When all iovec members were zero we ought to return 0 according to POSIX. */
+	return 0;
+}
diff --git a/config.mak.uname b/config.mak.uname
index 9ebd240378..95ef6e64dc 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -483,6 +483,7 @@ ifeq ($(uname_S),Windows)
 	SANE_TOOL_PATH ?= $(msvc_bin_dir_msys)
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
+	NO_WRITEV = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
@@ -697,6 +698,7 @@ ifeq ($(uname_S),MINGW)
 	pathsep = ;
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
+	NO_WRITEV = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index a57c4b464f..8f56203f34 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -378,7 +378,7 @@ endif()
 #function checks
 set(function_checks
 	strcasestr memmem strlcpy strtoimax strtoumax strtoull
-	setenv mkdtemp poll pread memmem)
+	setenv mkdtemp poll pread memmem writev)
 
 #unsetenv,hstrerror are incompatible with windows build
 if(NOT WIN32)
@@ -423,6 +423,10 @@ if(NOT HAVE_MEMMEM)
 	list(APPEND compat_SOURCES compat/memmem.c)
 endif()
 
+if(NOT HAVE_WRITEV)
+	list(APPEND compat_SOURCES compat/writev.c)
+endif()
+
 if(NOT WIN32)
 	if(NOT HAVE_UNSETENV)
 		list(APPEND compat_SOURCES compat/unsetenv.c)
diff --git a/meson.build b/meson.build
index ca235801cf..613828ff25 100644
--- a/meson.build
+++ b/meson.build
@@ -1446,6 +1446,7 @@ checkfuncs = {
   'initgroups' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],
+  'writev' : ['writev.c'],
 }
 
 if host_machine.system() == 'windows'

-- 
2.55.0.679.g6767b8d81c.dirty

