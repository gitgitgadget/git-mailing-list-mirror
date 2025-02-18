Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C13522FF22
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870520; cv=none; b=k+kAHJynVCtqzX1DA3ZQG+BDkx+UjcmeMKD+iFtEjR04GvxUB6ob56Y5Ag5mDvsg/1IFsWRoNUPyLmxLJYXBIxziEqTvIzzpGV/rO9Y7MeNFMetyoNAEisK/taguEGU7Np/V9wic48Nyk2FHLdJgmiu8TqUavZ7PDABaSEZIQg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870520; c=relaxed/simple;
	bh=kbD4OW90yzqm0fPZDOcM1AtDbypSZO61ugtJ3dp3qvo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=t7WJrW2wprG+gGGndUhV+2nrIiU3SVVWd6d2RGycS3+E0s4uiWNHc12u4FuMJlrB8SDtSM1m9/svab4qpniJ4w3oNyszCIkw2c56uqNZ3u5F+0JiU+tPnj/3UArN+opbTMNzgnQPEOcPGSBnHvvJyZgHLMOiS1a5bIpDCBPr358=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=daTv4eWI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ASspf5rD; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="daTv4eWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ASspf5rD"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9A7421140272;
	Tue, 18 Feb 2025 04:21:57 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Feb 2025 04:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870517;
	 x=1739956917; bh=cNRda2dNdQs1j+oOQe67iMJY/toOpztsMOBrz0GEsfE=; b=
	daTv4eWIwbEQ2dUCc6bWA+wd76cVNJ3Tor7NHrn5+/lRC0gpge3ppGam74o0vZso
	AFsf7I/eVCStE0H9PF8K8YxhG49roy9wiEHGeIPQ1px2S/MfQ3dBdT2alH4qDwK6
	1g58cyfGkTaCtD0WLquZtP6zwEb/E3oXBwG2BSKv6joNkzSKJD51aNumMGRtCgjg
	8/vLH4m3OziFjtQdcd+1aG14o1v/yO9rbumlT26TgqmQqgptsB3gYkwWeLIeAtlW
	4JqedHsPW9dJ86WgtMJcDokvpFqC7UMSjwAiY1QpA/0eABhOD07LplyqV0MFEypb
	ToSZ9ohsPWWQUMBJHEpKIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870517; x=
	1739956917; bh=cNRda2dNdQs1j+oOQe67iMJY/toOpztsMOBrz0GEsfE=; b=A
	Sspf5rDS2hcdZnRKtprn/rgHyI1KHBlror68O4HLs/wjq7TwFMIe2ox9qmChMR+g
	4q3iT5CrdII9o7gDVgN4t6L9avs8w0zvffhDWNFjK+Cq4W8cnee2343ZU5t26J2J
	oYgQLtAG7kbRdJwjS8Zkv6Ltr6IczXaZR4sEKDL31Tc1AChUdgtDcMRJrGoMCGOc
	OLh9Dd5s3yNNXOdH2oD2bFhaldegpQXtnQphvSWvUD/i9WNVxiZmfmVHvEZ/cmhR
	8Pryq7hA1LhmCPxAejLssN42DDv46U2uT06K8eqYMhZApEuQ5CVT5y7dF+necYpU
	pYooclIOYAKRvl+8sgxEA==
X-ME-Sender: <xms:NFG0Z8zyYbgBlQWjVmWkFiEB8b1bksG1JI4pzAZvUPKo_wWntviVAQ>
    <xme:NFG0ZwTF3YVvx-8x1_nd4j5FQxJThaVNWpkr9uFOZw-CFnfH0WN6SeQUyP0B70SWs
    CtQH6iD2Su847beig>
X-ME-Received: <xmr:NFG0Z-XSfk0SUFMsfWi0hpUFOCTnkf1TGuVNAFXVyJyNY82MrMTlKX-US9lyykb3P7a-iRieQ4lOH8x63OUOkGwOGTjS2ca-1EjT6VRCuKILrbeT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepteeuueehhffhiedtueehtddtieekfedtudehtdeh
    fefhgeffveeggedthfehuedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdr
    ihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hjiehtsehkuggsghdrohhrghdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtgho
    mhdprhgtphhtthhopehtohhonhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:NFG0Z6j1eDZx3q-q71lTNyijaa25ZKB-y7G4V_NSkzbl9aqHzsTqlw>
    <xmx:NFG0Z-BMWUH7ocw8yr3PglVALmNESx5WZ9jokTk6FDO4FDG2iVPbnA>
    <xmx:NFG0Z7KXfa3YrRSnvwq7wJNQHwCug5F9SM7qS2gKiJMeM0Ci2g9q_A>
    <xmx:NFG0Z1AUeVs6nqBPuaY-nOEmo2mv7H38h8VpvFtXy6g8fUQ17SSz2A>
    <xmx:NVG0Z0CYEnEame5w4d8rF03F5qha1BHK45X3nKAvYrE1hK8VA5fzJQ7P>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:21:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c34c5a34 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:21:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v6 00/18] reftable: stop using "git-compat-util.h"
Date: Tue, 18 Feb 2025 10:20:36 +0100
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAORQtGcC/43QTW7DIBAF4KtErEsFw5+dVe8RZYFhSFCT2AVit
 Yp89+JUauydl2+A7wEPkjFFzGS/e5CEY8yxv9Wg33bEne3thDT6mgkwkJzzlg6fmSYMxXYXpD7
 1Az3FQl1/HWyh9xIvVBoWoAselQZSnaFuj9/PjsPxLyf8uteq8hqeYy59+nneY+TzdK5UjIPZU
 DlyyqhGaJhVWjbGfNQz7/FKZnqEJdds4aByrlEOmBBa8DUnXlxd38KJykmpXYteIra44uSS01s
 4OT+WCQ9GexVateLUktv0d6pynQXrnWk5Z+Gfm6bpFyf14tAgAgAA
X-Change-ID: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Toon Claes <toon@iotcl.com>
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

Changes in v3:
  - Fix type of `total_read` variable used to track how many bytes we
    have read in `fd_read_lines()`.
  - Drop the patch use root-relative includes again. Let's rather
    discuss this outside of the scope of this series.
  - Link to v2: https://lore.kernel.org/r/20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im

Changes in v4:
  - Fix a couple of now-invalid relative includes that I missed. This
    fixes the build issue in "seen" with Meson.
  - Link to v3: https://lore.kernel.org/r/20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im

Changes in v5:
  - Rework the implementation of `REFTABLE_UNUSED` to use
    `__attribute__((__unused__))`.
  - Link to v4: https://lore.kernel.org/r/20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im

Changes in v6:
  - I have rebased the patch series on top of "master" at 03944513488
    (The eleventh batch, 2025-02-14). On the one hand this gets rid of
    the conflict with the zlib-ng changes, which have meanwhile been
    merged to that branch. And on the other hand it pulls in the new CI
    build for MSVC+Meson, which allows me to have better test coverage
    on Windows to better detect breakage there.
  - Stop moving around Win32 files so that we do the minimum viable
    change in this context. Hopefully, this makes it easier for Dscho to
    integrate into Git for Windows. If it doesn't I don't really have
    any other good ideas for how to do it, so the only alternative would
    be to just ignore Windows altogether.
  - Link to v5: https://lore.kernel.org/r/20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im

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
      reftable/basics: introduce `REFTABLE_UNUSED` annotation
      compat/mingw: split out POSIX-related bits
      git-compat-util.h: split out POSIX-emulating bits
      reftable: decouple from Git codebase by pulling in "compat/posix.h"
      Makefile: skip reftable library for Coccinelle

 Makefile                         |   2 +-
 compat/mingw-posix.h             | 431 +++++++++++++++++++++++++++++++
 compat/mingw.h                   | 426 +-----------------------------
 compat/msvc-posix.h              |  33 +++
 compat/msvc.h                    |  30 +--
 compat/posix.h                   | 541 +++++++++++++++++++++++++++++++++++++++
 git-compat-util.h                | 531 +-------------------------------------
 reftable/basics.c                |  19 --
 reftable/basics.h                | 123 ++++++++-
 reftable/block.c                 |  16 +-
 reftable/blocksource.c           |  17 +-
 reftable/iter.c                  |  13 +-
 reftable/merged.c                |  27 +-
 reftable/pq.c                    |  40 ++-
 reftable/pq.h                    |   2 +-
 reftable/reader.c                |  33 ++-
 reftable/record.c                |  84 +++---
 reftable/record.h                |   6 +-
 reftable/stack.c                 |  52 +++-
 reftable/system.c                |   7 +
 reftable/system.h                |   8 +-
 reftable/writer.c                |  27 +-
 t/unit-tests/t-reftable-basics.c |  28 +-
 t/unit-tests/t-reftable-pq.c     |  22 +-
 t/unit-tests/t-reftable-record.c |  42 ++-
 25 files changed, 1405 insertions(+), 1155 deletions(-)

Range-diff versus v5:

 1:  18b6360460f =  1:  3589d759e69 reftable/stack: stop using `read_in_full()`
 2:  4426ec59a5e =  2:  e9fb7b0821f reftable/stack: stop using `write_in_full()`
 3:  4db9255d16d =  3:  f509993ee13 reftable/blocksource: stop using `xmmap()`
 4:  2752fb006c5 =  4:  48247ebf145 reftable/record: stop using `COPY_ARRAY()`
 5:  3bdd13f015e =  5:  795e9650146 reftable/record: stop using `BUG()` in `reftable_record_init()`
 6:  21529172e83 =  6:  8221aec91a9 reftable/record: don't `BUG()` in `reftable_record_cmp()`
 7:  e62c056f8e8 =  7:  8563af898e5 reftable: stop using `BUG()` in trivial cases
 8:  b506a862abc =  8:  447c7166c97 reftable/basics: stop using `st_mult()` in array allocators
 9:  b1749f88610 =  9:  108d40a63f5 reftable/basics: provide wrappers for big endian conversion
10:  f583f0cfb03 = 10:  19068751b6c reftable/reader: stop using `ARRAY_SIZE()` macro
11:  c59328f9299 ! 11:  316ca16a18c reftable/system: introduce `reftable_rand()`
    @@ reftable/system.c
     
      ## reftable/system.h ##
     @@ reftable/system.h: license that can be found in the LICENSE file or at
    - 
      #include "git-compat-util.h"
    + #include "compat/zlib-compat.h"
      
     +/*
     + * Return a random 32 bit integer. This function is expected to return
12:  0657d144327 = 12:  3cf2df99203 reftable/stack: stop using `sleep_millisec()`
13:  504ae579c30 = 13:  5184d4185a6 reftable/basics: stop using `SWAP()` macro
14:  34b0ae5f697 = 14:  a108a876c9a reftable/basics: introduce `REFTABLE_UNUSED` annotation
15:  1552c1f45bf <  -:  ----------- compat/mingw: split out POSIX-related bits
 -:  ----------- > 15:  48186eb7aeb compat/mingw: split out POSIX-related bits
16:  7cebd3c3381 ! 16:  16f2371c868 git-compat-util.h: split out POSIX-emulating bits
    @@ compat/posix.h (new)
     +#endif
     +
     +#if defined(__MINGW32__)
    -+#include "mingw/posix.h"
    ++#include "mingw-posix.h"
     +#elif defined(_MSC_VER)
    -+#include "msvc/posix.h"
    ++#include "msvc-posix.h"
     +#else
     +#include <sys/utsname.h>
     +#include <sys/wait.h>
    @@ git-compat-util.h: static inline int _have_unix_sockets(void)
     @@ git-compat-util.h: static inline int is_xplatform_dir_sep(int c)
      #elif defined(_MSC_VER)
      #include "compat/win32/path-utils.h"
    - #include "compat/msvc/compat-util.h"
    + #include "compat/msvc.h"
     -#else
     -#include <sys/utsname.h>
     -#include <sys/wait.h>
17:  dbb9b816d2e ! 17:  4461c8cf4a3 reftable: decouple from Git codebase by pulling in "compat/posix.h"
    @@ reftable/system.h: license that can be found in the LICENSE file or at
      /* This header glues the reftable library to the rest of Git */
      
     -#include "git-compat-util.h"
    -+#include "../compat/posix.h"
    -+#include <zlib.h>
    ++#include "compat/posix.h"
    + #include "compat/zlib-compat.h"
      
      /*
    -  * Return a random 32 bit integer. This function is expected to return
18:  f7b470f3387 = 18:  3e70da1abc8 Makefile: skip reftable library for Coccinelle

---
base-commit: 03944513488db4a81fdb4c21c3b515e4cb260b05
change-id: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562

