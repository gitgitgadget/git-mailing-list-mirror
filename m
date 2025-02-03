Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5687D1DDA24
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569828; cv=none; b=inLxyrXoeCYX7ThtLLNVrRtzP6QnPSgXiAWy2BH8c14aRi8aYuv5AO0OdtFxchZIRNRZr3gmJfL2CZzYe3V7Zhk1KzOMSS8VgxKlsTSGfee6uhVet8Mo0hbpIpQ59xCf9DdFmNp6fISikwfRRWokmDD+ftcr/jGd9RrVMWrD+tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569828; c=relaxed/simple;
	bh=1AEHNaDFykLARPYaPnETlOP4Gz3tDDDMdBtjyme14ng=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=KpFHhj9SDR8dri2J83CzHrZ4EhN+6NC6Qiep4PjJDTqvgUtOeogeyQ5WF1ytzvu4qijZBvYe98u/76clV4IfJ8zbn6Vdjwp0JU9MEb5uLI/wXOWvN6W2UB4ZHhSQHx3Wtl83/so/TarrW2DZyw97d35nmdiYpDv7CyX319k+580=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ipAAYBaS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pAbyUm3c; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ipAAYBaS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pAbyUm3c"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4C6CA11400B9;
	Mon,  3 Feb 2025 03:03:45 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 03 Feb 2025 03:03:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569825;
	 x=1738656225; bh=ldmabMe7DdsMHJEsnOpb1mCGWHJjjA2xBnCXRhtmmJM=; b=
	ipAAYBaSYyp/lqQYpderPD4aenr/NHy6PWBr47CsfTfJafNvl+Ri20Jkx4+Mbi+s
	57wPz0OOgErC0DGVWVlrgQhF4pywYIVvR6QfczqtmHwkBMbroMSZA4sE1tO7Bmht
	gxnAGiJR3yhJ+lB8WoZXkVvUzCEHHxMmxC9d8n+g4B1K84iYqgoD1gm/bP1lZU6o
	ZSkOFtjTtAN2TTpKNlNEfUB9uJW7ZgBPuwf7ZJ1LH5sir+7p2i+Iq6U1g7WRFAD4
	M8i+M5O5p8RvCHllUcmKOiWGBtvRtmoc+Gtcz5o2d+kud4jV8nkchmiE/7PevMrT
	TLnntmGacVwvXR73AT3UTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569825; x=
	1738656225; bh=ldmabMe7DdsMHJEsnOpb1mCGWHJjjA2xBnCXRhtmmJM=; b=p
	AbyUm3c7GSJB8tHVJF9xD1FixCzYCpTfNJB5dDkghHqPS6eVWdWHhsZnxf3AhEAD
	rVR3UcEtv5ieKzKlXZ35xb46uU/8R3og88E2jf+5shmKYxwyDtk+lglKO1UEXxak
	zNA/K3nCwRAMvYiqqbTSuYE1Bx4mNSbilcvBDYpkWOylc9tRvxz4GIgg8tk8/Niz
	w9Eo49yp8KwYxrmozjC1FlM29ZPM0XjdPjejXapgZg086IPbkztZv6SdvygBApsl
	f3gVbbW88YKThofTMSvplUyv7EEvTJ4BWO0L6Wd/mXNuJ/R/iCWybFVQaxGUWf0P
	L7znh/yfQXNRzpTVq3Xwg==
X-ME-Sender: <xms:YXigZzn1M5dL61zVtjCibnUHBzTwszNzL2rhLhwrNGGNP3ZVGDJ27g>
    <xme:YXigZ2278tWWRBFI-X8XgfgmEH3g_dq3QgPxYI3jNjow9Dn6KRIouCQ6w7Di2jNE-
    M-5qGafNjcgGw1NbA>
X-ME-Received: <xmr:YXigZ5oTmnLt5TDM-UQHOk5iQHOyOzo8vgUK_kmq94rWNhD8XFcfkeaCkNYqX5MlaZxPbv3fN1gVNy2WyRJV_eLSXLg-o53_8aCGdEVZU-r5Fw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephefgleekkeefhfeftefhgfeifeegkedvvdfgjeeu
    hefgueejffdujeeuleeikeehnecuffhomhgrihhnpehgohhoghhlvgdrtghomhdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YXigZ7kgEhzUwiOI9AuN91LeOrbk7giyFnBIU7KZDz5AkRIRVIIbdQ>
    <xmx:YXigZx3p7REUBrqumnNtNoOoRCmy4aZnD7jk90HYMfTqzwjfWKZfmA>
    <xmx:YXigZ6vrXu8mzPDgLvXxiobIxfR6-gighgZXwFg7eyB1hfdkPipT0A>
    <xmx:YXigZ1WLZzH9Ko5xMCQaCJqRRRuLLysgos-rjHFIM1jxGDFt9WC8hQ>
    <xmx:YXigZ8RPHfF1k4Qrh_C2TUVHxpP85PyRqpm5pcN3guaMyCScTg1aAnd2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:44 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id eddccd9a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/18] reftable: stop using "git-compat-util.h"
Date: Mon, 03 Feb 2025 09:03:31 +0100
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFN4oGcC/42Oyw6CMBBFf4V07Zh2eOrK/zAueAwwkZdtIRrCv
 1twgUuW92buOTMLQ5rJiKs3C00TG+47F/yTJ/I67SoCLlwWKDFQSl1geBrQVNo0awgK3Q9QsYW
 8b4fUwmi5gSCWJWZlQWGEwnEGd87vzXF//LKm1+hUdi9rNrbXn+2PSa3tqgylwviAclIgISJMZ
 BpGQRLHN7c5cytW9IT/uOQIDh0uT8Icpe9Hvtpxy7J8AYD77f8zAQAA
X-Change-ID: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Hi,

this patch series is the final step to fully decouple the reftable
library from the rest of the Git codebase. The goal of this is to make
the library reusable by other projects like libgit2 by simply copying
over the source files, making Git the canonical upstream for reftable
functionality.

This patch series stops using all kinds of helpers exposed by our
"git-compat-util.h" header and open-codes them instead. In order to keep
us from using these helpers by accident the final step is to pull out
POSIX-related bits and pieces into a new "compat/posix.h" header, which
the reftable library then uses instead of "git-compat-util.h".

The series is built on top of master at 5f8f7081f7 (The third batch,
2025-01-23) with ps/reftable-sign-compare at 33319b0976 (reftable:
address trivial -Wsign-compare warnings, 2025-01-20) merged into it.
There is a trivial merge conflict with ps/zlib-ng that can be solved
like this:

    diff --cc reftable/system.h
    index e4a8944a70,d02eacea8f..0000000000
    --- a/reftable/system.h
    +++ b/reftable/system.h
    @@@ -11,15 -11,9 +11,15 @@@ https://developers.google.com/open-sour
      
      /* This header glues the reftable library to the rest of Git */
      
     -#include "git-compat-util.h"
     +#include "compat/posix.h"
    - #include <zlib.h>
    + #include "compat/zlib-compat.h"
      
     +/*
     + * Return a random 32 bit integer. This function is expected to return
     + * pre-seeded data.
     + */
     +uint32_t reftable_rand(void);
     +
      /*
       * An implementation-specific temporary file. By making this specific to the
       * implementation it becomes possible to tie temporary files into any kind of

Changes in v2:
  - The splitup of Windows headers has broken compilation because some
    of the headers couldn't be found anymore. I've fixed this more
    generally by converting includes in "compat/" to always be relative
    to the project source directory, dropping the platform-specific
    `-Icompat/` include.
  - Explain why we don't port over `EWOULDBLOCK` handling.
  - Fix commit message typos.
  - Link to v1: https://lore.kernel.org/r/20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im

Changes in v3:
  - Fix type of `total_read` variable used to track how many bytes we
    have read in `fd_read_lines()`.
  - Drop the patch use root-relative includes again. Let's rather
    discuss this outside of the scope of this series.
  - Link to v2: https://lore.kernel.org/r/20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (18):
      reftable/stack: stop using `read_in_full()`
      reftable/stack: stop using `write_in_full()`
      reftable/blocksource: stop using `xmmap()`
      reftable/record: stop using `COPY_ARRAY()`
      reftable/record: stop using `BUG()` in `reftable_record_init()`
      reftable/record: don't `BUG()` in `reftable_record_cmp()`
      reftable: stop using `BUG()` in trivial cases
      reftable/basics: stop using `st_mult()` in array allocators
      reftable/basics: provide wrappers for big endian conversion
      reftable/reader: stop using `ARRAY_SIZE()` macro
      reftable/system: introduce `reftable_rand()`
      reftable/stack: stop using `sleep_millisec()`
      reftable/basics: stop using `SWAP()` macro
      reftable/basics: stop using `UNUSED` annotation
      compat/mingw: split out POSIX-related bits
      git-compat-util.h: split out POSIX-emulating bits
      reftable: decouple from Git codebase by pulling in "compat/posix.h"
      Makefile: skip reftable library for Coccinelle

 Makefile                                |   2 +-
 compat/{mingw.c => mingw/compat-util.c} |   0
 compat/mingw/compat-util.h              | 220 +++++++++++++
 compat/{mingw.h => mingw/posix.h}       | 216 +------------
 compat/{msvc.c => msvc/compat-util.c}   |   2 +-
 compat/msvc/compat-util.h               |   7 +
 compat/{msvc.h => msvc/posix.h}         |   8 +-
 compat/posix.h                          | 541 ++++++++++++++++++++++++++++++++
 config.mak.uname                        |   6 +-
 contrib/buildsystems/CMakeLists.txt     |   2 +-
 git-compat-util.h                       | 535 +------------------------------
 meson.build                             |   8 +-
 reftable/basics.c                       |  19 --
 reftable/basics.h                       | 123 +++++++-
 reftable/block.c                        |  16 +-
 reftable/blocksource.c                  |  21 +-
 reftable/iter.c                         |  20 +-
 reftable/merged.c                       |  27 +-
 reftable/pq.c                           |  40 ++-
 reftable/pq.h                           |   2 +-
 reftable/reader.c                       |  33 +-
 reftable/record.c                       | 109 ++++---
 reftable/record.h                       |   6 +-
 reftable/stack.c                        |  52 ++-
 reftable/system.c                       |   7 +
 reftable/system.h                       |   9 +-
 reftable/writer.c                       |  29 +-
 t/unit-tests/t-reftable-basics.c        |  28 +-
 t/unit-tests/t-reftable-pq.c            |  22 +-
 t/unit-tests/t-reftable-record.c        |  42 ++-
 30 files changed, 1223 insertions(+), 929 deletions(-)

Range-diff versus v2:

 1:  e9364a8d05 !  1:  8488db3ac9 reftable/stack: stop using `read_in_full()`
    @@ reftable/stack.c: static int fd_read_lines(int fd, char ***namesp)
     -	if (read_in_full(fd, buf, size) != size) {
     -		err = REFTABLE_IO_ERROR;
     -		goto done;
    -+	for (size_t total_read = 0; total_read < (size_t) size; ) {
    ++	for (off_t total_read = 0; total_read < size; ) {
     +		ssize_t bytes_read = read(fd, buf + total_read, size - total_read);
     +		if (bytes_read < 0 && (errno == EAGAIN || errno == EINTR))
     +			continue;
 2:  41e411c00d =  2:  19db682279 reftable/stack: stop using `write_in_full()`
 3:  1abf9a77e4 =  3:  17fa559a68 reftable/blocksource: stop using `xmmap()`
 4:  458837e511 <  -:  ---------- reftable/record: stop using `COPY_ARRAY()`
 -:  ---------- >  4:  1667a37d38 reftable/record: stop using `COPY_ARRAY()`
 5:  a620950cb4 =  5:  1fe9563380 reftable/record: stop using `BUG()` in `reftable_record_init()`
 6:  0590780f55 =  6:  12c1fdc125 reftable/record: don't `BUG()` in `reftable_record_cmp()`
 7:  adcba48303 =  7:  8cfb77ce2c reftable: stop using `BUG()` in trivial cases
 8:  353d958e38 =  8:  c7227123fa reftable/basics: stop using `st_mult()` in array allocators
 9:  c6abf6ca1e =  9:  204a7ffed7 reftable/basics: provide wrappers for big endian conversion
10:  095c6805d1 = 10:  533f2cdbd5 reftable/reader: stop using `ARRAY_SIZE()` macro
11:  816a984361 = 11:  f5a9edc360 reftable/system: introduce `reftable_rand()`
12:  eb09c1d79d = 12:  4b066d5be8 reftable/stack: stop using `sleep_millisec()`
13:  1595e4d771 = 13:  8580d01ee2 reftable/basics: stop using `SWAP()` macro
14:  448ec74479 = 14:  72847f6d69 reftable/basics: stop using `UNUSED` annotation
15:  838f2bcd3a <  -:  ---------- compat: consistently resolve headers via project root
16:  cf6b915daf ! 15:  0348eed321 compat/mingw: split out POSIX-related bits
    @@ compat/mingw/compat-util.h (new)
     +#ifndef COMPAT_MINGW_COMPAT_UTIL_H
     +#define COMPAT_MINGW_COMPAT_UTIL_H
     +
    -+#include "compat/mingw/posix.h"
    ++#include "posix.h"
     +
     +struct config_context;
     +int mingw_core_config(const char *var, const char *value,
    @@ compat/mingw/posix.h: char *mingw_query_user_email(void);
     -#endif
     +#endif /* COMPAT_MINGW_POSIX_H */
     
    - ## compat/msvc.c ##
    + ## compat/msvc.c => compat/msvc/compat-util.c ##
     @@
      #include <conio.h>
    - #include "strbuf.h"
    + #include "../strbuf.h"
      
    --#include "compat/mingw.c"
    -+#include "compat/mingw/compat-util.c"
    +-#include "mingw.c"
    ++#include "mingw/compat-util.c"
     
    - ## compat/msvc.h ##
    -@@ compat/msvc.h: typedef int sigset_t;
    + ## compat/msvc/compat-util.h (new) ##
    +@@
    ++#ifndef COMPAT_MSVC_COMPAT_UTIL_H
    ++#define COMPAT_MSVC_COMPAT_UTIL_H
    ++
    ++#include "posix.h"
    ++#include "../mingw/compat-util.h"
    ++
    ++#endif /* COMPAT_MSVC_COMPAT_UTIL_H */
    +
    + ## compat/msvc.h => compat/msvc/posix.h ##
    +@@
    +-#ifndef __MSVC__HEAD
    +-#define __MSVC__HEAD
    ++#ifndef COMPAT_MSVC_POSIX_H
    ++#define COMPAT_MSVC_POSIX_H
    + 
    + #include <direct.h>
    + #include <process.h>
    +@@ compat/msvc/posix.h: typedef int sigset_t;
      /* open for reading, writing, or both (not in fcntl.h) */
      #define O_ACCMODE     (_O_RDONLY | _O_WRONLY | _O_RDWR)
      
     -#include "compat/mingw.h"
    -+#include "compat/mingw/compat-util.h"
    ++#include "../mingw/posix.h"
      
    - #endif
    +-#endif
    ++#endif /* COMPAT_MSVC_POSIX_H */
     
      ## config.mak.uname ##
     @@ config.mak.uname: endif
    + 	AR = compat/vcbuild/scripts/lib.pl
    + 	CFLAGS =
    + 	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
    +-	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
    ++	COMPAT_OBJS = compat/msvc/compat-util.o compat/winansi.o \
    + 		compat/win32/flush.o \
    + 		compat/win32/path-utils.o \
    + 		compat/win32/pthread.o compat/win32/syslog.o \
    +@@ config.mak.uname: endif
      
      	EXTRA_PROGRAMS += headless-git$X
      
     -compat/msvc.o: compat/msvc.c compat/mingw.c GIT-CFLAGS
    -+compat/msvc.o: compat/msvc.c compat/mingw/compat-util.c GIT-CFLAGS
    ++compat/msvc/compat-util.o: compat/msvc/compat-util.c compat/mingw/compat-util.c GIT-CFLAGS
      endif
      ifeq ($(uname_S),Interix)
      	NO_INITGROUPS = YesPlease
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
      	BASIC_LDFLAGS += -municode
    - 	COMPAT_CFLAGS += -DNOGDI -Icompat/win32
    + 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
      	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
     -	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
     +	COMPAT_OBJS += compat/mingw/compat-util.o compat/winansi.o \
    @@ meson.build: if host_machine.system() == 'cygwin'
      elif host_machine.system() == 'windows'
        libgit_sources += [
     -    'compat/mingw.c',
    -+    'compat/mingw/compat-util.c',
          'compat/winansi.c',
          'compat/win32/flush.c',
          'compat/win32/path-utils.c',
    +@@ meson.build: elif host_machine.system() == 'windows'
    +   libgit_include_directories += 'compat/win32'
    +   if compiler.get_id() == 'msvc'
    +     libgit_include_directories += 'compat/vcbuild/include'
    ++    libgit_sources += 'compat/msvc/compat-util.c'
    ++  else
    ++    libgit_sources += 'compat/mingw/compat-util.c'
    +   endif
    + endif
    + 
     @@ meson.build: else
          error('Native regex support requested but not found')
      endif
17:  ae57e3f391 <  -:  ---------- compat/msvc: split out POSIX-related bits
18:  c32f39b777 ! 16:  141fd6a7cd git-compat-util.h: split out POSIX-emulating bits
    @@ compat/posix.h (new)
     +#endif
     +
     +#if defined(__MINGW32__)
    -+#include "compat/mingw/posix.h"
    ++#include "mingw/posix.h"
     +#elif defined(_MSC_VER)
    -+#include "compat/msvc/posix.h"
    ++#include "msvc/posix.h"
     +#else
     +#include <sys/utsname.h>
     +#include <sys/wait.h>
19:  496d30ee27 ! 17:  640f5e6376 reftable: decouple from Git codebase by pulling in "compat/posix.h"
    @@ reftable/system.h: license that can be found in the LICENSE file or at
      /* This header glues the reftable library to the rest of Git */
      
     -#include "git-compat-util.h"
    -+#include "compat/posix.h"
    ++#include "../compat/posix.h"
     +#include <zlib.h>
      
      /*
20:  d257172bf7 = 18:  2f17a1963d Makefile: skip reftable library for Coccinelle

---
base-commit: 8047765d092881ec4aef7dfc57772161eee7f0f5
change-id: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562

