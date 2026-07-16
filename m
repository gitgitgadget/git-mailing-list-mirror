Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826C3BAD94
	for <git@vger.kernel.org>; Thu, 16 Jul 2026 07:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784188378; cv=none; b=ENsuqu4T2WoPpsahHriQp111Ng+FqpMY+Tczi0VbgtXW4r+cDn+iXG1PrO0TfXqj4MKLTsSb4L5lA1Zt6hhpxYXZQb1oPd7ZBC9VwFi4hvUXnRyNH1EMQH+EOoRACLDI54KfpaRlclSkWsUOBezxbbxX3DDX0Uc/iy7k0oMvek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784188378; c=relaxed/simple;
	bh=pBxQg5aONwPv9Ts0/6cPwKNu6FSAOhOoElG4F0fUBwc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EVi6h0btu6jxi//NZExzgyIS+T5qLaWpQGSgU94pIbQj/8Uq3WIY+EEJkU7Z/vzJRfBSzFHBklrysSO8vH0Yg830mqdWmlpmHl2Db0FvVAauG3jGUUsscAw/KDGQnUOw51iKoehmsdrcNFSpMLu//7yPqpOdRVy8Hr5GzqO+vbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Gw8gOvBV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dUauPt7i; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Gw8gOvBV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUauPt7i"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id B59D11D00103;
	Thu, 16 Jul 2026 03:52:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 16 Jul 2026 03:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784188360;
	 x=1784274760; bh=GvBrljHv9QukJeJKe4V8XsOckhLzeAefGMUjwRFjzXw=; b=
	Gw8gOvBVFQHdCzPDLL3g1jdQ1hghQuQPdQoAmFhRDtaAnYMzwYiOOyO2AFQBl87L
	doaKl2LQZ74b8gHCLnnCrCqy3dc2TBf0CgEHzdI8T9+JbmSuKNRKnoGLK/tS/Wf5
	Si2Iwk/7E9QmZSB+yDffwYrVx66CeRv3/lJDzkCQ1BPhAgErDhv13tLpj61wB7pY
	esFTR/IAKKSYqjb0MOrMdTMEgVgKaPmLYkxZ+n/aO8T6rOuQbfs/zH1+1+CQNXfn
	qABW6nOgyosREM096LepigyPp7MvXZ3cvCYeF5C7VKQ3Sp4SRqhucIpHu6Jz8VB7
	IjAZR+yzvkhp6c201yoLwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784188360; x=
	1784274760; bh=GvBrljHv9QukJeJKe4V8XsOckhLzeAefGMUjwRFjzXw=; b=d
	UauPt7iXKh+V4NP+UG2fpceR4rW7Pja42uoWaOduPTk4+QFdIsdJHpYyyiOca0dW
	n2sYhnvMQjA0C7y6QQSt3Suzb84S15lh8mBL0NB9T6hAVOPeUdM/n1ImOHuI+0ji
	n/Uh15OQGKOlR4OFzWeRSYZFVuYonEOa1ahIxfngI4H79QzYCWC8aaS7zeplN/Hm
	47OjEIyDoAHrN5E+1HGPMMDJqe53rzXvqjPELLPTBhxi7bgPmWLosaq3vF1CYu2L
	1qTlWs+sU/3n5jfnensMsXhp37FCpFQbBlZca0Fmp06cdLeiB4/emdIy2B9YHmOI
	nD8Af2nE1W5BDFvEVYFgw==
X-ME-Sender: <xms:yI1YakbXxEZ_lmK7BXo9MDYgcu-Q-TVn06Ism6CI1yRbG3vESlJq8w>
    <xme:yI1YapaqqZgjc5REcaSx8ZUo1rpBWjzK3kqjYzia3qrIY2-Hssw_GNgYVq-36hoJI
    C6uOXoZJ37S845_Lg0IwaGI7j3m5-I4P0licoG2a1-1qFUpV6ausw>
X-ME-Received: <xmr:yI1Yaln0Bu7-6miqeZGI8cpr4GgAnc1WCVzOfIXnFiZFuk6RuHS9hf4C3seGyDLcKbAfekuhoGQKjMn9kinN8M0so8F_wdDB3qs1OpdI>
X-ME-Proxy-Cause: dmFkZTEWPZ6Mjn9lv9iRED9aHvuplvBZxrqFeZgQpnFuPCiWJDrp0I8/1GwxLWM37qMYpv
    9RZdLeFpeOT1ZL/JFzFeagaRvJeyj9G5x86XB6A6EEU2dlBIurcd1xRjtBUFMENtsBkZ83
    iGXNMS9u0H2TkRjKYEFnGccL8qth43KASmQign1cf7apthC+4YUUUscnpTr6uN+sYkucbc
    hoK3ms19i362cUnQEY0cvoC6wQ1NaiVKVdPBYA1TMmnDZFSM1djFPqtx9IZq/L4ag6cPEv
    eE4EZb2Dk1S11RzGZEC4E2CF5RaIDJGK7XOCR3tlQLZe3sPpQ7TrrtqtJwJQIwKkoGrpOp
    PoDJ3dlRfmQVY45mW4hG92MVKJnbV6D1EMN9mUlfx3VBltc4vNKoBUEnF5RQ42tsBbQISS
    hjJjmQ5xV+x0A6sMEVn8cB1CBgDd1ytnkg7oQqXqx2OOC1sERu6lPrI3qnzUlDYzJP6RS1
    paCxg8xjwmzPLhVV22FuCGRcxpXLAq61NR5djpSr7I8CrireRK2eCskv3fl5QWU10UJ+JV
    LZ4klVsBiqA0clNbUXoHOHCH97TPg9LSGHjaAlwVJlh1Cdr0Ux2GCtnQgCH57p96mAe/F1
    UNnEBZJOFhmg5QWWKuo0w0RcjSE+hLhYByfb7+T/HmboG9WswAPFyPoR29mg
X-ME-Proxy: <xmx:yI1Yas39QemKUX4Rz5_WkmJI5C1Z4hVlOqRoe_0pBF2QbKxfXEEGcQ>
    <xmx:yI1Yat2O3tzn3dmZ3Ptm_FQfiTe0_S0e703_9G-tWEQvPC0OWRba_w>
    <xmx:yI1YampCjYtUXMRfIohj1cfx1Hc4EtnUgYiOXnpfesgoeS9GqteCyA>
    <xmx:yI1YahhYpgEbjjxxqUdWYBXj7q1ktT8BicWUobpOIBOT12uBdpey4w>
    <xmx:yI1YanIq1t1perH5oIcb7pmjV0KDEYN04bqSDt5HOuoPe5jmtjnAy5I3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 03:52:38 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6551bbb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Jul 2026 07:52:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Jul 2026 09:52:19 +0200
Subject: [PATCH 1/5] compat/posix: introduce writev(3p) wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260716-pks-reintroduce-writev-v1-1-ea9038c884bc@pks.im>
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
 compat/posix.h                      | 14 ++++++++++++
 compat/writev.c                     | 44 +++++++++++++++++++++++++++++++++++++
 config.mak.uname                    |  2 ++
 contrib/buildsystems/CMakeLists.txt |  6 ++++-
 meson.build                         |  1 +
 6 files changed, 70 insertions(+), 1 deletion(-)

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
index 0000000000..ab2e223634
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
+	for (int i = 0; i < iovcnt; i++) {
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
2.55.0.313.g8d093f411d.dirty

