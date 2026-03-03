Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C31480978
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550045; cv=none; b=hDtiIzxVwiPm9TxeMm0p+0wZ1sYpTxsQZnSTI084NOZTsEgnKHSQrOFwaq6txTPcKyiF94zOBUzCXfqaWJpMwdbp034/jyUasfOUC34XkYIv2eOBMKERymRCFslBbo5eGdN16XHkM7s0T2ooYrF2fMV6GrkAHuufJBXwfimJJMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550045; c=relaxed/simple;
	bh=XS6LEZHT4SuX+z44KaKH0ptt82MSQMqzdOrstqk6KiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=knHuxYmpwADAOcTg2L6r0kP97lEWHL1xNnhN5poa1m/dkdVheH1IFVVQCcRNP1ajyKUM+D9sQDmLwZ0KHM+o3H0QZ3GaFrnufOau2EQhD2nMm9W3XM8sNx4Yh7lZzFr2Op/NCR5VuYIwnrfADmydTnUZoa1cuXo1B78VvIexYcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bYxenFzp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FyjjXlHh; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bYxenFzp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FyjjXlHh"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE4D314001CE;
	Tue,  3 Mar 2026 10:00:43 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 03 Mar 2026 10:00:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1772550043;
	 x=1772636443; bh=gZVSwUBS49ATW5zrFa7rVpTfR1tQSskuE4Ge9RfHMz4=; b=
	bYxenFzpr3AyZsT1jcSf5Lr74bcmXamVbHtezeiHFnsClP7q/H0RUyc4IP+GHFJZ
	ip/zA3jNnW+fGwtMV4NEcZZwU7AJVDyJ+72OfI2wD/myrFGP1Me74JUAabs/thN3
	kb32FxmXtHlEo7YlOOZepZA1RdDZwN+1+pEf+ZJO4d6Px2taFfzbwDW8IqYutSTj
	mSeQ23GQQyhnWzlu/aqmnB0Q3V/AkqE3bSEmvf6InExMKFrNkYA2ow343Spw1sMz
	/Dg4gVpgOBzYe6CeubVLaw0uu+EyGHnrT0Q+epi0udsJPTq4bO352NAKFaaKt0AI
	evOQyEFTVTDFINSI8AtDEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772550043; x=
	1772636443; bh=gZVSwUBS49ATW5zrFa7rVpTfR1tQSskuE4Ge9RfHMz4=; b=F
	yjjXlHhYBs5kClFsJYbJAxiOcege4KQD2wR8xS4tVLhKmtyTyeR/o6uxIO94sYNP
	Ec7rjjmdjpPBsT5yd7wHfuDpQWGboUeq4xqvo+MaqWSe9V2xYCLsduP64n5ZaUDR
	SFvvgFg+D3XbFiKcQE5KlCx5SEGonn2hsAC+ETnC+CoUgoilpP5w02bR7vUXrCs/
	ncOBYSxQn3bGmzVCuf23LxPd56qnb0r3XWzczAZLgv7SOjOYFWuotiBjz+2v5gBl
	MdSRp8BiLF2BP/hbktnbkV0qTExBan3Enip6cFxpEJ/GrUwnp7Gjblg1kUp2ggAK
	w4EQuq4IUOGCHNqTOd8Mw==
X-ME-Sender: <xms:m_emaa8D87T_HhyEzJH6HhXK4LCvgelpvk8Z2kSe7RkGqZSWvB3vnA>
    <xme:m_emaRuMSuscJzgN8v-vrqCIFBABhl_Yz4YVCqmmtSwkV9jF2yvYHSA_gwct4kxR7
    ueq53302cbN5U_pbC34P78OM8ql-7sXxHLoRrXaHpdRD3sTk-c2sw>
X-ME-Received: <xmr:m_emaVD3aykPJwCjEkXBfGEugzwbmmI9U3hfxDTfVQaNqU2WYrGMIaS_A96KMLhRtfnd3EvuYVHttPx6jYg1ZWnbSyI0llHfcTU55r5J5QJ5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetfeeuffelkeduteduteehhfdtleefffevgfduteeiudettdffffduledtieettden
    ucffohhmrghinhepnhhonhhsthhophhtohholhhsrdgtohhmpdhgnhhurdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehmshhmihhlvgihsehgihhtlh
    grsgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:m_emaRU7CtpUmbem7l0JUa8KBGnQYiPysPxbhmyy-T_4WlyfHNsTFw>
    <xmx:m_emabA7DWINguuTKOls1c2C4P-TudcmeGWzAPJd6pvP05MKxl4wEw>
    <xmx:m_emac_XGJhRBrFTJSoDBIPz2jmZbFnb6CFmoshKTriqhnhJclMNbw>
    <xmx:m_emaaHwNhFsXkNT_SnAG26go-_oBIulhNHt6I7-uierorkii_I7MQ>
    <xmx:m_emaQZ-Ajv7Go7A9n9UBCSPIi3yoGGZMPlfrzXzbL55_8d3nrHdiNzr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 10:00:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 08fcb006 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Mar 2026 15:00:42 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Mar 2026 16:00:20 +0100
Subject: [PATCH v2 05/10] compat/posix: introduce writev(3p) wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260303-pks-upload-pack-write-contention-v2-5-7321830f08fe@pks.im>
References: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
In-Reply-To: <20260303-pks-upload-pack-write-contention-v2-0-7321830f08fe@pks.im>
To: git@vger.kernel.org
Cc: Matt Smiley <msmiley@gitlab.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>
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
 compat/writev.c  | 29 +++++++++++++++++++++++++++++
 config.mak.uname |  2 ++
 meson.build      |  1 +
 5 files changed, 50 insertions(+)

diff --git a/Makefile b/Makefile
index 7f37ad8f58..cb95ff2daf 100644
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
index 0000000000..b77e534d5d
--- /dev/null
+++ b/compat/writev.c
@@ -0,0 +1,29 @@
+#include "../git-compat-util.h"
+#include "../wrapper.h"
+
+ssize_t git_writev(int fd, const struct iovec *iov, int iovcnt)
+{
+	size_t total_written = 0;
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
+	return cast_size_t_to_ssize_t(total_written);
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
index 762e2d0fc0..63514b6b84 100644
--- a/meson.build
+++ b/meson.build
@@ -1409,6 +1409,7 @@ checkfuncs = {
   'initgroups' : [],
   'strtoumax' : ['strtoumax.c', 'strtoimax.c'],
   'pread' : ['pread.c'],
+  'writev' : ['writev.c'],
 }
 
 if host_machine.system() == 'windows'

-- 
2.53.0.697.g625c4fb2da.dirty

