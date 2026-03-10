Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AEE43B9DA4
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 13:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773149121; cv=none; b=RYlGZRab4SW50IaYMXwdq6m3zAjkOTa6dzz5Y8LdbfSh+AvS02a1uEATicRa4iQK21Bpt12RhVYs94RAj9g82pevmqNnsoPIQHaOPQJUQG6ISPY52L1G6UkNAgRnbdCKY8rZKpc5CHiHyk0GI/Gsfg256lIc+/4Mwa0ULgDXiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773149121; c=relaxed/simple;
	bh=osqaOaTjeEXobKCUpZj8QXROb1pzecpp/h2rmu24uwk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=swhvj/KSG5v+sCBcQDBuCRCpcnd+E92CwQEOLeXZ8YDDRZ6+Lk6s6qZM1r4rFFQyGetI9Ttfe5xJqFbVlTUR+ZkgnWrlqp73WEUYaQtyUhUInU5WfAdMhdWNqfP7qIpZXRzE109DCsX38vcC4WFYrtfka5PA8x8AVM/y7C3Xip8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LexK/wBD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvrdyTbh; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LexK/wBD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvrdyTbh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 84764EC0610;
	Tue, 10 Mar 2026 09:25:19 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 10 Mar 2026 09:25:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1773149119;
	 x=1773235519; bh=+pkox0OTwHzyAaAiYCzao0AGF+XcuBIV9vIg8qlOGRk=; b=
	LexK/wBDvV7ZDYlnndIu9Zod/4KcgcykyH6xK1v5S5KZ7JMbnP+srn6LfRtoAdrz
	8b6wdSrI1oyOLtfTdKO9o5lefzaPMPtYBS6v+stLgpk7pk3xh5KDUVKDitAJj/Ol
	PUH11O/fcoJZSXiDsSmO806A51BxL1ztGYKRxxVCdoZD3PC+lu5J0D2E2J0K9P7m
	C6IlHFD/isVxpP/ZmuMnz2qzXNUgaVWFEvA9b/eM3R/Hf57jBv+KTegyYA8JhyMW
	+eKoIhzq5cfqnZzEmS2ovgPkkkrUKOJ9f9zoOj5oMTRaTHjqCTRjCDUBPPMufR0w
	1lDExT++hF36pCVdS1ptjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773149119; x=
	1773235519; bh=+pkox0OTwHzyAaAiYCzao0AGF+XcuBIV9vIg8qlOGRk=; b=H
	vrdyTbhmquOMa33iUjrtNN61DxYEFUEmbN+tU34/q0+SvW902Yjdl1liqcLZdooN
	0Jf5wiy2sOElaoyfIzh1rXv+rAFGCr8Km7j8c8epmyVNoidYfIgr/H4p099kq6xq
	ym3+sRy6TJtjI60he4RNqt04lDOvrMZE2Q4/kRSXJwkXb6VnY61DttN70UhbzOn2
	iXpxZKjLgNAYnFg9vG4jsqRraNbM1naA8tkEJqHaVO13qWZ+xUMTGdIb7yXNPmEQ
	yeDyIikcsDHcNXsn4E/axWZiZzfaBQlAIjQTv3S9CE1NtSEDd6X518j9w/CYP5zm
	+d73TGijOvdflH5MZOyDA==
X-ME-Sender: <xms:vxuwad2Km2soC0u7TWdKCv2TTX0CAwj4XIedFC9RR8W5EyRWeijcSg>
    <xme:vxuwaa-U5VRHkrRtFSyv_79rf4v0-F69I4CDc3BMarGjiPN7HOii2E60i5hW51MMV
    I-_DZRncMqcdPdxe9ZpjhK5CCEv47VbhKTK3BjuD0mnVf30MASZUw>
X-ME-Received: <xmr:vxuwaWMbvN9ZS22OPK8CVpr6zBOclFDWQHMkIkoThjtWLNQoPeY1dla9BjC2g2Mq7bVplxDabJoVQuWiXvQggzEgOmE7nvH9FryRD4so>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetfeeuffelkeduteduteehhfdtleefffevgfduteeiudettdffffduledtieettden
    ucffohhmrghinhepnhhonhhsthhophhtohholhhsrdgtohhmpdhgnhhurdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushht
    hihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmshhmihhlvgihsehgihhtlh
    grsgdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:vxuwaWfFl-Jov8A06YqianSdKzpfLFtQv6mt_W7MVfHcsBf6vazIpg>
    <xmx:vxuwadVTA1j5n13KyA5QyiuzlCzWb_Gcu-zkMVgReaHaSMVdcU_e5A>
    <xmx:vxuwaWhpFHm_qMehK8UIazdSKB1TCZ0F2GKHPTtqhtHoZkn4iZ7v1A>
    <xmx:vxuwaU-ZfZYA6zNhju87VMqRepHpbAKFjEw_j9xSBty2PnwjSa5frQ>
    <xmx:vxuwaQ_kqytFS5hgKW0Jv_-EsOp8-ozuFXV4-BvUV1N5JLtJ-OkfcRjc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 09:25:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 41542628 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Mar 2026 13:25:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Mar 2026 14:25:01 +0100
Subject: [PATCH v3 05/10] compat/posix: introduce writev(3p) wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260310-pks-upload-pack-write-contention-v3-5-8bc97aa3e267@pks.im>
References: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
In-Reply-To: <20260310-pks-upload-pack-write-contention-v3-0-8bc97aa3e267@pks.im>
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
2.53.0.880.g73c4285caa.dirty

