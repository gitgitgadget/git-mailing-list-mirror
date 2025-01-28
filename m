Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732501DDC22
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052898; cv=none; b=V7rJ1vr7PY3gZ2si8U9bYqyo29IEop4l4I8moaC3zZLppfkl4ZugtA1O3lTlh8wUd/HowxsU6uGtXO9ETF7hPc9Ma9svMrzzPmfsnBDqVGU3hqixbmOZf2TuZz1mqZkPIE/MWWNzdH2zDKkNYIaKmizwO8Q8Amabbw6OywnC878=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052898; c=relaxed/simple;
	bh=dQxrNzn3WWONwWtvLRFQ6DyDVjPcYM78hgcmIuwVx3A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=Q4i28ChfjxH8/QDks/7t6seScFpfABLkO7uUFEFruYzN9cN9oMWZfHHdCO0ha9vNOBPZYwi4szaqN3uK7w7VAbMoUo/GnGhrFbm934EYpDQ8fA8St61FUghAQCV9pQMQhYaMh9b0zY8bE1T0oaVBBatmbesTXrkUvnQJ1m1jnFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=soqs/1nL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eciCLQW3; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="soqs/1nL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eciCLQW3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 8525A1140149;
	Tue, 28 Jan 2025 03:28:15 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 28 Jan 2025 03:28:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052895;
	 x=1738139295; bh=/WseU0w9L0bLvRirQaloTD/BSNiNTP5Ie7VS3htdPVM=; b=
	soqs/1nLlaWf4QHuUq00fKnGQxlbu2plI086hMrV6VNcU3OHpz9tG5Yba2XSaKXH
	ROv89bwgYth3Gme05iICwmAxlvgxmWAVGRp+qaf+uQywUouJm1sY44U3klVlj+AF
	m0pUbroNgAB1+2mzCdU3RIdOTsd1dXaDQsm6RG1/W/JyW7w2+uNZyQng+ZdVaEju
	Vkyd05H8U53+kwnUIlJ2KHAxe+igDASLEiIyL65KatWj28yj09IHg7pDs2pp1vWz
	gcDdfqsOhbi9qfdwMugrL04NbFA03mfm4jc3mNAiEFi88UA4vvNJavOm2G0Prmvg
	40Dgqj8UQ6rQfm3UrNQvXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052895; x=
	1738139295; bh=/WseU0w9L0bLvRirQaloTD/BSNiNTP5Ie7VS3htdPVM=; b=e
	ciCLQW3BXoBYHGONlWd++QhFQo3+aauDqzrUiTkH+k0YpoQWGiHc29OytcJPp7XE
	NF9LNJqXFLvAwV+HvFIq64hw13yrjK+2EaC+GTeG4H1cbUcLhQFiDQ/meag8gO3I
	52QpC/kgdZKU5c0vRgWb6AIZyCdBMgGV0uuzkxs0YIPvAC7ebZWRxZb7juifTXTu
	gORql0r8DXaobv79Wg/Gui5omjWIHWxFmMEgpkdAqce2DCR0Q2VTuT+HtveTac/+
	U60hNoKWXsb+0VUV2ZrDoSG3ZnNbhpfW3ZSEfMUQgcZUgbJUyLnhZ7rCqGTJ8MBJ
	cvAkIFsxWUxgKf9fLI3sg==
X-ME-Sender: <xms:H5WYZ7Msu2bgwX07FkFb3iCfqII0zLs54HTpSAWOnSYxUxCh8ct6Ng>
    <xme:H5WYZ1_21J5pzbB1Iio6hZ3ufHnLQ0dhjkKeMCluzUlysJcl5kYSpa2tY85fzHMXZ
    S83jx98lhj3CaGsYw>
X-ME-Received: <xmr:H5WYZ6SY-m4Fg9G9usRN09JtKeKUsuOm-qIzYihEqOOjyrFmVy83POVynvrbLJM3E_JUdRhoE02vODMyIkFa2uKFH5wZFMC3l-ET2F0nrBM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeehgfelkeekfefhfeethffgieefgeekvddvgfej
    ueehgfeujeffudejueelieekheenucffohhmrghinhepghhoohhglhgvrdgtohhmpdhkvg
    hrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgv
    rhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:H5WYZ_vB6ZmZNVhgJTjFQp3YvAOv5O3V9d5qIj0dPWP2CTNF-jNyhA>
    <xmx:H5WYZzfedkYDsRPQ-rFFVcWqmyuvyhvuOY28262H9nqyxMFdSsn0YA>
    <xmx:H5WYZ72j3Nkx8W6k9Zn9jVGhZi6x6g-Plmwtk5exoUDDg6AS1-Fdzg>
    <xmx:H5WYZ_8W50gnTs975ynJw7jAbIFi2oxhR1FZvHHAtc-rQ_9ZtG53FQ>
    <xmx:H5WYZ67m3vXvzgVSL1iernU-I2XIjljnfo7fq8Gh_RkxXxSc35d0xMDL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:14 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a13fd4aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/20] reftable: stop using "git-compat-util.h"
Date: Tue, 28 Jan 2025 09:28:01 +0100
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABKVmGcC/42Qy27DIBBFf8Vi3amA8IoVVfmPKAtsBgc1fhSI1
 Sryvxfb2XTX5R1dnTkzT5IwBkykrp4k4hxSGIcS+FtF2psdOoTgSiaccsEYO8L0mSCiz7a5I7g
 4TtCFDO3YTzbDI4c7CE09b7xDqTgpnKnUw/e243Ldc8SvR1mV9yFpbMIV0YdcV9Ibr6lhXmvFb
 Ou8OThqRasMO3o8OM2Fp8zpFd1jSnZzrKtTUZSUcQqN+GuZQjfshhFh5rA2pFKOchRWnkv3PfQ
 fZHW7hZTH+LO9Y2ab3Aur/3H5zApbITfUSiWM1i82uS7L8gtjgxVTawEAAA==
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

Thanks!

Patrick

---
Patrick Steinhardt (20):
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
      compat: consistently resolve headers via project root
      compat/mingw: split out POSIX-related bits
      compat/msvc: split out POSIX-related bits
      git-compat-util.h: split out POSIX-emulating bits
      reftable: decouple from Git codebase by pulling in "compat/posix.h"
      Makefile: skip reftable library for Coccinelle

 Makefile                                 |   2 +-
 compat/access.c                          |   3 +-
 compat/basename.c                        |   4 +-
 compat/fileno.c                          |   2 +-
 compat/fopen.c                           |   2 +-
 compat/fsmonitor/fsm-health-darwin.c     |   2 +-
 compat/fsmonitor/fsm-health-win32.c      |   2 +-
 compat/fsmonitor/fsm-listen-darwin.c     |   4 +-
 compat/fsmonitor/fsm-listen-win32.c      |   2 +-
 compat/inet_ntop.c                       |   2 +-
 compat/inet_pton.c                       |   2 +-
 compat/memmem.c                          |   2 +-
 compat/{mingw.c => mingw/compat-util.c}  |  24 +-
 compat/mingw/compat-util.h               | 220 +++++++++++++
 compat/{mingw.h => mingw/posix.h}        | 216 +-----------
 compat/mkdir.c                           |   2 +-
 compat/mkdtemp.c                         |   2 +-
 compat/mmap.c                            |   2 +-
 compat/msvc.c                            |   6 -
 compat/msvc/compat-util.c                |   6 +
 compat/msvc/compat-util.h                |   7 +
 compat/{msvc.h => msvc/posix.h}          |   8 +-
 compat/nonblock.c                        |   4 +-
 compat/obstack.c                         |   2 +-
 compat/posix.h                           | 541 +++++++++++++++++++++++++++++++
 compat/pread.c                           |   4 +-
 compat/precompose_utf8.c                 |   2 +-
 compat/qsort_s.c                         |   2 +-
 compat/regcomp_enhanced.c                |   2 +-
 compat/setenv.c                          |   2 +-
 compat/snprintf.c                        |   2 +-
 compat/strcasestr.c                      |   2 +-
 compat/strdup.c                          |   2 +-
 compat/strlcpy.c                         |   2 +-
 compat/strtoimax.c                       |   2 +-
 compat/strtoumax.c                       |   2 +-
 compat/unsetenv.c                        |   2 +-
 compat/win32/dirent.c                    |   2 +-
 compat/win32/flush.c                     |   2 +-
 compat/win32/path-utils.c                |   4 +-
 compat/win32/pthread.c                   |   4 +-
 compat/win32/syslog.c                    |   2 +-
 compat/win32/trace2_win32_process_info.c |  10 +-
 compat/win32mmap.c                       |   2 +-
 compat/winansi.c                         |   6 +-
 config.mak.uname                         |  10 +-
 contrib/buildsystems/CMakeLists.txt      |   2 +-
 git-compat-util.h                        | 535 +-----------------------------
 meson.build                              |   8 +-
 reftable/basics.c                        |  19 --
 reftable/basics.h                        | 123 ++++++-
 reftable/block.c                         |  16 +-
 reftable/blocksource.c                   |  21 +-
 reftable/iter.c                          |  20 +-
 reftable/merged.c                        |  27 +-
 reftable/pq.c                            |  40 ++-
 reftable/pq.h                            |   2 +-
 reftable/reader.c                        |  33 +-
 reftable/record.c                        |  96 ++++--
 reftable/record.h                        |   6 +-
 reftable/stack.c                         |  52 ++-
 reftable/system.c                        |   7 +
 reftable/system.h                        |   9 +-
 reftable/writer.c                        |  29 +-
 t/unit-tests/t-reftable-basics.c         |  28 +-
 t/unit-tests/t-reftable-pq.c             |  22 +-
 t/unit-tests/t-reftable-record.c         |  42 ++-
 67 files changed, 1282 insertions(+), 992 deletions(-)

Range-diff versus v1:

 1:  1dc7341c0d !  1:  a0985a8b32 reftable/stack: stop using `read_in_full()`
    @@ Commit message
         There is a single callsite of `read_in_full()` in the reftable library.
         Open-code the function to reduce our dependency on the Git library.
     
    +    Note that we only partially port over the logic from `read_in_full()`
    +    and its underlying `xread()` helper. Most importantly, the latter also
    +    knows to handle `EWOULDBLOCK` via `handle_nonblock()`. This logic is
    +    irrelevant for us though because the reftable library never sets the
    +    `O_NONBLOCK` option in the first place.
    +
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## reftable/stack.c ##
 2:  a3a8bc7e8f =  2:  09e27dcfaf reftable/stack: stop using `write_in_full()`
 3:  43b83eb8e8 =  3:  0ecdb7a440 reftable/blocksource: stop using `xmmap()`
 4:  d89df1bac5 =  4:  b5e5803ec9 reftable/record: stop using `COPY_ARRAY()`
 5:  94fd212a82 =  5:  5f479bf84d reftable/record: stop using `BUG()` in `reftable_record_init()`
 6:  c110e452fe !  6:  9b10ec8f35 reftable/record: don't `BUG()` in `reftable_record_cmp()`
    @@ Metadata
      ## Commit message ##
         reftable/record: don't `BUG()` in `reftable_record_cmp()`
     
    -    The refatble library aborts with a bug in case `reftable_record_cmp()`
    +    The reftable library aborts with a bug in case `reftable_record_cmp()`
         is invoked with two records of differing types. This would cause the
         program to die without the caller being able to handle the error, which
         is not something we want in the context of library code. And it ties us
 7:  61165df24e =  7:  0fe9c21db3 reftable: stop using `BUG()` in trivial cases
 8:  a3e2d8f194 =  8:  b1f8ed2e92 reftable/basics: stop using `st_mult()` in array allocators
 9:  75c719d097 =  9:  40a5989b25 reftable/basics: provide wrappers for big endian conversion
10:  754391b32e = 10:  6c258880f1 reftable/reader: stop using `ARRAY_SIZE()` macro
11:  4e14362169 = 11:  65a78993fc reftable/system: introduce `reftable_rand()`
12:  142610e800 = 12:  e8a5090382 reftable/stack: stop using `sleep_millisec()`
13:  2b748b36ee = 13:  af72104f1c reftable/basics: stop using `SWAP()` macro
14:  fda87c2ec7 = 14:  4634e83e47 reftable/basics: stop using `UNUSED` annotation
 -:  ---------- > 15:  3a4949d74d compat: consistently resolve headers via project root
15:  34f81f0477 ! 16:  3520bf9252 compat/mingw: split out POSIX-related bits
    @@ compat/mingw/posix.h: char *mingw_query_user_email(void);
      ## compat/msvc.c ##
     @@
      #include <conio.h>
    - #include "../strbuf.h"
    + #include "strbuf.h"
      
    --#include "mingw.c"
    -+#include "mingw/compat-util.c"
    +-#include "compat/mingw.c"
    ++#include "compat/mingw/compat-util.c"
     
      ## compat/msvc.h ##
     @@ compat/msvc.h: typedef int sigset_t;
    @@ config.mak.uname: endif
      	NO_INITGROUPS = YesPlease
     @@ config.mak.uname: ifeq ($(uname_S),MINGW)
      	BASIC_LDFLAGS += -municode
    - 	COMPAT_CFLAGS += -DNOGDI -Icompat -Icompat/win32
    + 	COMPAT_CFLAGS += -DNOGDI -Icompat/win32
      	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
     -	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
     +	COMPAT_OBJS += compat/mingw/compat-util.o compat/winansi.o \
16:  ed9da5dbf4 = 17:  fbb53e8526 compat/msvc: split out POSIX-related bits
17:  f19f95e6d8 ! 18:  6d57bc4b26 git-compat-util.h: split out POSIX-emulating bits
    @@ Commit message
         This intermixing is a bit of a problem for the reftable library as we
         don't want to recreate the POSIX-like interface there. But neither do we
         want to pull in the Git-specific functionality, as it is otherwise quite
    -    easy to start depedning on the Git codebase again.
    +    easy to start depending on the Git codebase again.
     
         Split out a new header "compat/posix.h" that only contains the bits and
         pieces relevant for the emulation of POSIX, which we will start using in
18:  463c285baa = 19:  746698c8ef reftable: decouple from Git codebase by pulling in "compat/posix.h"
19:  0973de24c0 = 20:  0f34ac6145 Makefile: skip reftable library for Coccinelle

---
base-commit: 5f8f7081f7761acdf83d0a4c6819fe3d724f01d7
change-id: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562
prerequisite-message-id: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
prerequisite-patch-id: fda53cfaa42008baf9e5e66f9805f1091d5e28f0
prerequisite-patch-id: 5b9f06f4b50f51c0afb42fbf4a1a678069b38056
prerequisite-patch-id: 864d6d587b43aae2dedbb6a327a1632eafae51c7
prerequisite-patch-id: aec82a709396ae48b44c86016533517f2a9983cb
prerequisite-patch-id: 89087dd9f69dabfaac9b14874a6e8d8c1a42eada
prerequisite-patch-id: 87ec0aec4990da55346179776f9326725256642f
prerequisite-patch-id: b19cbfbe4fdd75d9ae319ca0e222ea01902f513e
prerequisite-patch-id: 1395a747e0005f729ef88a47f0d0dd4cd7c4dca2
prerequisite-patch-id: d0e48535aa481bb1770753858cd6a093a1ad625b
prerequisite-patch-id: d11a8b914e70cd56a5280e75fb7158f5de87eb22

