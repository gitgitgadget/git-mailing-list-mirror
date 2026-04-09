Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A8E37EFFE
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771619; cv=none; b=buj46fuK8n758rXS7FMnqyHjbTRea54gFGOraYlk3+Qa8rJWtrumgn+OLWADhDPRzLSH08ACGMF01IxFgna3Q4VHAgjx0HiSI7+3J+XgoHdgIsnucWEbR69uwG03OEXfOw67rw3rUwRa/Nqd1Y+8vdPu/ISQO4y4rUPoenNmiCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771619; c=relaxed/simple;
	bh=JfyWyjuD/ElkMSX6UZMoIq+0b7Q8PQmIiAilGOucX30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VahubOptl9vtLUeg9ZRT9Bf5Uq1zl92xPts7Z4MjjujGP+TPFkTdI+9pDWqKqIglxdbyob7Y5sgnAzK8upE6FaZKqVR2g2Xj8aOjnVRPF1bfSQgmCTJ48JkYKsxchhXDFUy3Qi1l695rjeMEdGQOeuGxZv/SEQDOtoOTXwQy4Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lDK0dt/n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=c/770EUH; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lDK0dt/n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="c/770EUH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A836E1D001C9;
	Thu,  9 Apr 2026 17:53:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 09 Apr 2026 17:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1775771610; x=1775858010; bh=kviRVQ6kN/
	XB8vHX1obXKHxScDxEV7jH+5NAcejHzGk=; b=lDK0dt/n6lu1xwM5J1kVZUQCy1
	WYG5mCJZBOnUVSvi42waxyL+IIFSyqSiYhC4FOWP107yy/KLb/S8dvxmzgd8qiq3
	XlVrbMfBCZxotv0cblRWPs7dgBIkKgC0EEWDim4UBKH43ZSlAY48PA0rSi8sw0Hi
	/dhIVFpdcOOX523fwR5lvi2MkAyDD36A9tTeGbkuujaxK0E5yVpkKwtYH2YV9Uxc
	+gHtfX1pq4UPjXV3mzuzeNVs+CiVTUFgz+PbagKqKI7YNkIsajp8iLX4hjaj/ciU
	3O+0TJRmoCcrhIguWwJ/VIZsGrJ1fGopj3L3fMK10P4ck9dQhYVjseoMAslw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1775771610; x=1775858010; bh=kviRVQ6kN/XB8vHX1obXKHxScDxEV7jH+5N
	AcejHzGk=; b=c/770EUHwGZxGAfDmp+u7W5U6Q5jkNDoW8pAfEI56OmtrJ8yDyc
	5q54b9ko5A0kDhtjJrFbm9jI/406jwKtORcDMbhP/RUGGCXR8BM4Nx0Ycb+TjjEd
	k99vceOMEyeTFvm06H3Ftr90tGvhaM4OfYGSMQKVxxopS6I+hdgn/55Ko40/z//M
	vO4ImfchJETOWQkNIvFbjc8VbZMVOwceSetdyuSYRlny5RY4wdq1V9tP6e43hCsY
	uSb0ccVekNkinJMl/gxbB9OdCwRFm99ZjkaDGjBH+TRXguNYoeR5ZiEglQrFsku1
	w0fnxOe+YBkhaGYXFupDaVt+O2Z4HmNFlKg==
X-ME-Sender: <xms:2h_YaRJrwG7xPz9_oD9J4APBqT-DDUBR_NPzEota1SYH_orceZE_JQ>
    <xme:2h_YaUCp5HPXC3WLEWYKhP9Lf9p22lT_cMW_K1UxQDcSpntnyWuhmucE-1QIeCs2C
    65z48udlXgw-EPxayXGHIUmtxJC4xkODV77NVTJ984RusMuuz4Z>
X-ME-Received: <xmr:2h_YaSAjfvLa0ino6UGoYPoD5GtnWoD1eUpnEKxrKDkWurcRMl7vigNjYJ3xHRXU-7BMXdBCjk-TPQLRIOShkRi9F8EG2ejDqA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprh
    hssggvtghkvghrsehnvgigsghrihgughgvrdgtohhmpdhrtghpthhtohepphhssehpkhhs
    rdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:2h_YaeDeZDrAZKfaEuOEd3Og8s1JN3GclKxSsfy_SXv1qStHWfbJfg>
    <xmx:2h_YaVrixWgio77_gFtrRjek8gc0zFiEbkqLUL2k5i7vYVbbv0dO1g>
    <xmx:2h_YaQmWkiAsy8cGfQV5fcYSUhiSdupBT8RhJU3gWdNRDJIDpoyJ1w>
    <xmx:2h_Yadw_uwX_8RM_EAJqD-weg-pXcp24KLxrl_a1Z_eXHywXgusRfw>
    <xmx:2h_YaUyPmhO4RWwQXYMPhOh9BVbt3ScWpRapDluWkGMzwN4dQ7paSH6h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 17:53:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: rsbecker@nexbridge.com,  Patrick Steinhardt <ps@pks.im>,
  git@vger.kernel.org
Subject: Re* 2.54.0-rc1 NO_WRITEV=Nope  does not work
In-Reply-To: <20260409211049.GA3119065@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 9 Apr 2026 17:10:49 -0400")
References: <028901dcc859$d2419470$76c4bd50$@nexbridge.com>
	<20260409211049.GA3119065@coredump.intra.peff.net>
Date: Thu, 09 Apr 2026 14:53:28 -0700
Message-ID: <xmqqmrzbreav.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> so you are probably hitting that EINVAL! Which is trying to emulate how
> a system writev() would work, but the fundamental problem is that it
> _doesn't_ work on your system, because ssize_t is too small for how
> we're using writev(), which assumes we can pass in 64k at a time.

Sigh.

> It is tempting to just delete the EINVAL check shown above, but then the
> rest of the fallback function needs to be more clever, and return a
> partial write before incrementing total_written over the ssize_t limit
> (otherwise we have no way to report to the caller how much was actually
> written).
>
> Yuck. I think for 2.54 we either have to truly implement MAX_IO_SIZE
> support, or we have to revert the use of writev() in send_sideband()
> until we do.

Sigh again.

$ git log -Swritev --oneline 8023abc632^..
89152af176 cmake: use writev(3p) wrapper as needed
26986f4cba sideband: use writev(3p) to send pktlines
1970fcef93 wrapper: introduce writev(3p) wrappers
3b9b2c2a29 compat/posix: introduce writev(3p) wrapper

Reverting them gave us the following patch relative to the tip of
'master'.

----- >8 -----
Subject: writev: retract the topic until we have a better emulation

The emulation layer we added for writev(3p) tries to be too faithful
to the spec that on systems with SSIZE_MAX set to lower than 64kB to
fit a single sideband packet would fail just like the real system
writev(), which makes our use of writev() for sideband messages
unworkable.

Let's revert them and reboot the effort after the release.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile                            |  4 ----
 compat/posix.h                      | 14 ------------
 compat/writev.c                     | 44 -------------------------------------
 config.mak.uname                    |  2 --
 contrib/buildsystems/CMakeLists.txt |  6 +----
 meson.build                         |  1 -
 sideband.c                          | 14 +++---------
 wrapper.c                           | 41 ----------------------------------
 wrapper.h                           |  9 --------
 write-or-die.c                      |  8 -------
 write-or-die.h                      |  1 -
 11 files changed, 4 insertions(+), 140 deletions(-)

diff --git a/Makefile b/Makefile
index 5d22394c2e..cedc234173 100644
--- a/Makefile
+++ b/Makefile
@@ -2029,10 +2029,6 @@ ifdef NO_PREAD
 	COMPAT_CFLAGS += -DNO_PREAD
 	COMPAT_OBJS += compat/pread.o
 endif
-ifdef NO_WRITEV
-	COMPAT_CFLAGS += -DNO_WRITEV
-	COMPAT_OBJS += compat/writev.o
-endif
 ifdef NO_FAST_WORKING_DIRECTORY
 	BASIC_CFLAGS += -DNO_FAST_WORKING_DIRECTORY
 endif
diff --git a/compat/posix.h b/compat/posix.h
index 94699a03fa..faaae1b655 100644
--- a/compat/posix.h
+++ b/compat/posix.h
@@ -137,9 +137,6 @@
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <sys/statvfs.h>
-#ifndef NO_WRITEV
-#include <sys/uio.h>
-#endif
 #include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
@@ -326,17 +323,6 @@ int git_lstat(const char *, struct stat *);
 ssize_t git_pread(int fd, void *buf, size_t count, off_t offset);
 #endif
 
-#ifdef NO_WRITEV
-#define writev git_writev
-#define iovec git_iovec
-struct git_iovec {
-	void *iov_base;
-	size_t iov_len;
-};
-
-ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt);
-#endif
-
 #ifdef NO_SETENV
 #define setenv gitsetenv
 int gitsetenv(const char *, const char *, int);
diff --git a/compat/writev.c b/compat/writev.c
deleted file mode 100644
index 3a94870a2f..0000000000
--- a/compat/writev.c
+++ /dev/null
@@ -1,44 +0,0 @@
-#include "../git-compat-util.h"
-#include "../wrapper.h"
-
-ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
-{
-	size_t total_written = 0;
-	size_t sum = 0;
-
-	/*
-	 * According to writev(3p), the syscall shall error with EINVAL in case
-	 * the sum of `iov_len` overflows `ssize_t`.
-	 */
-	 for (int i = 0; i < iovcnt; i++) {
-		if (iov[i].iov_len > maximum_signed_value_of_type(ssize_t) ||
-		    iov[i].iov_len + sum > maximum_signed_value_of_type(ssize_t)) {
-			errno = EINVAL;
-			return -1;
-		}
-
-		sum += iov[i].iov_len;
-	}
-
-	for (int i = 0; i < iovcnt; i++) {
-		const char *bytes = iov[i].iov_base;
-		size_t iovec_written = 0;
-
-		while (iovec_written < iov[i].iov_len) {
-			ssize_t bytes_written = xwrite(fd, bytes + iovec_written,
-						       iov[i].iov_len - iovec_written);
-			if (bytes_written < 0) {
-				if (total_written)
-					goto out;
-				return bytes_written;
-			}
-			if (!bytes_written)
-				goto out;
-			iovec_written += bytes_written;
-			total_written += bytes_written;
-		}
-	}
-
-out:
-	return (ssize_t) total_written;
-}
diff --git a/config.mak.uname b/config.mak.uname
index ccb3f71881..5feb582558 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -459,7 +459,6 @@ ifeq ($(uname_S),Windows)
 	SANE_TOOL_PATH ?= $(msvc_bin_dir_msys)
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
-	NO_WRITEV = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
@@ -675,7 +674,6 @@ ifeq ($(uname_S),MINGW)
 	pathsep = ;
 	HAVE_ALLOCA_H = YesPlease
 	NO_PREAD = YesPlease
-	NO_WRITEV = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
 	NO_POLL = YesPlease
diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index d7a087e584..81b4306e72 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -376,7 +376,7 @@ endif()
 #function checks
 set(function_checks
 	strcasestr memmem strlcpy strtoimax strtoumax strtoull
-	setenv mkdtemp poll pread memmem writev)
+	setenv mkdtemp poll pread memmem)
 
 #unsetenv,hstrerror are incompatible with windows build
 if(NOT WIN32)
@@ -421,10 +421,6 @@ if(NOT HAVE_MEMMEM)
 	list(APPEND compat_SOURCES compat/memmem.c)
 endif()
 
-if(NOT HAVE_WRITEV)
-	list(APPEND compat_SOURCES compat/writev.c)
-endif()
-
 if(NOT WIN32)
 	if(NOT HAVE_UNSETENV)
 		list(APPEND compat_SOURCES compat/unsetenv.c)
diff --git a/meson.build b/meson.build
index 8309942d18..11488623bf 100644
--- a/meson.build
+++ b/meson.build
@@ -1429,7 +1429,6 @@ checkfuncs = {
   'initgroups' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],
-  'writev' : ['writev.c'],
 }
 
 if host_machine.system() == 'windows'
diff --git a/sideband.c b/sideband.c
index 1ed6614eaf..ea7c25211e 100644
--- a/sideband.c
+++ b/sideband.c
@@ -264,7 +264,6 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 	const char *p = data;
 
 	while (sz) {
-		struct iovec iov[2];
 		unsigned n;
 		char hdr[5];
 
@@ -274,19 +273,12 @@ void send_sideband(int fd, int band, const char *data, ssize_t sz, int packet_ma
 		if (0 <= band) {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 5);
 			hdr[4] = band;
-			iov[0].iov_base = hdr;
-			iov[0].iov_len = 5;
+			write_or_die(fd, hdr, 5);
 		} else {
 			xsnprintf(hdr, sizeof(hdr), "%04x", n + 4);
-			iov[0].iov_base = hdr;
-			iov[0].iov_len = 4;
+			write_or_die(fd, hdr, 4);
 		}
-
-		iov[1].iov_base = (void *) p;
-		iov[1].iov_len = n;
-
-		writev_or_die(fd, iov, ARRAY_SIZE(iov));
-
+		write_or_die(fd, p, n);
 		p += n;
 		sz -= n;
 	}
diff --git a/wrapper.c b/wrapper.c
index be8fa575e6..16f5a63fbb 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -323,47 +323,6 @@ ssize_t write_in_full(int fd, const void *buf, size_t count)
 	return total;
 }
 
-ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt)
-{
-	ssize_t total_written = 0;
-
-	while (iovcnt) {
-		ssize_t bytes_written = writev(fd, iov, iovcnt);
-		if (bytes_written < 0) {
-			if (errno == EINTR || errno == EAGAIN)
-				continue;
-			return -1;
-		}
-		if (!bytes_written) {
-			errno = ENOSPC;
-			return -1;
-		}
-
-		total_written += bytes_written;
-
-		/*
-		 * We first need to discard any iovec entities that have been
-		 * fully written.
-		 */
-		while (iovcnt && (size_t)bytes_written >= iov->iov_len) {
-			bytes_written -= iov->iov_len;
-			iov++;
-			iovcnt--;
-		}
-
-		/*
-		 * Finally, we need to adjust the last iovec in case we have
-		 * performed a partial write.
-		 */
-		if (iovcnt && bytes_written) {
-			iov->iov_base = (char *) iov->iov_base + bytes_written;
-			iov->iov_len -= bytes_written;
-		}
-	}
-
-	return total_written;
-}
-
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset)
 {
 	char *p = buf;
diff --git a/wrapper.h b/wrapper.h
index 27519b32d1..15ac3bab6e 100644
--- a/wrapper.h
+++ b/wrapper.h
@@ -47,15 +47,6 @@ ssize_t read_in_full(int fd, void *buf, size_t count);
 ssize_t write_in_full(int fd, const void *buf, size_t count);
 ssize_t pread_in_full(int fd, void *buf, size_t count, off_t offset);
 
-/*
- * Try to write all iovecs. Returns -1 in case an error occurred with a proper
- * errno set, the number of bytes written otherwise.
- *
- * Note that the iovec will be modified as a result of this call to adjust for
- * partial writes!
- */
-ssize_t writev_in_full(int fd, struct iovec *iov, int iovcnt);
-
 static inline ssize_t write_str_in_full(int fd, const char *str)
 {
 	return write_in_full(fd, str, strlen(str));
diff --git a/write-or-die.c b/write-or-die.c
index 5f522fb728..01a9a51fa2 100644
--- a/write-or-die.c
+++ b/write-or-die.c
@@ -96,14 +96,6 @@ void write_or_die(int fd, const void *buf, size_t count)
 	}
 }
 
-void writev_or_die(int fd, struct iovec *iov, int iovlen)
-{
-	if (writev_in_full(fd, iov, iovlen) < 0) {
-		check_pipe(errno);
-		die_errno("writev error");
-	}
-}
-
 void fwrite_or_die(FILE *f, const void *buf, size_t count)
 {
 	if (fwrite(buf, 1, count, f) != count)
diff --git a/write-or-die.h b/write-or-die.h
index a045bdfaef..ff0408bd84 100644
--- a/write-or-die.h
+++ b/write-or-die.h
@@ -7,7 +7,6 @@ void fprintf_or_die(FILE *, const char *fmt, ...);
 void fwrite_or_die(FILE *f, const void *buf, size_t count);
 void fflush_or_die(FILE *f);
 void write_or_die(int fd, const void *buf, size_t count);
-void writev_or_die(int fd, struct iovec *iov, int iovlen);
 
 /*
  * These values are used to help identify parts of a repository to fsync.
