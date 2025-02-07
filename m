Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5D71A4F12
	for <git@vger.kernel.org>; Fri,  7 Feb 2025 11:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738929125; cv=none; b=nSbgKycqOoMeWgflrfHgjW3XTUjfy+EBWqX16gxMqXm0C+ez79lvGINhmseE4YGdBt51Utuwk+3AOTTt1O9T5XdXM5jHKElAvBVU/6O1ukGCwvMVV65xQ0xs1F04+f+izLo26UO4gbajwB/4Y40kN9ZNJhHtdDo1hNBzDukstyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738929125; c=relaxed/simple;
	bh=O0bSCI4YlWWlJnsRlL3XdCVReLSNPXT/utc2fLwp6hk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=SW8nAhyoXZal9jrJHHSszf1VU/ugfLQP6xV4rOeKMVpvi/Ry3pBnPwDTfKpLmm1Atfq0HdhkLZEL4zKWb0WfDhnZuCiSd+BKMj1V9NpF1x/LikHChdD8EtYlrwm3Q76HdZxycsyHcGtlYTi536I0O2nZEUKsXLO8DeO4yo3CA2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TdUrwF1m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p1Conr3h; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TdUrwF1m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p1Conr3h"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BA27C114009F;
	Fri,  7 Feb 2025 06:52:02 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 07 Feb 2025 06:52:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738929122;
	 x=1739015522; bh=CjPc3rl1H8TQWze2w549g/TOtY8Fx2Bmn4eFtMh6ipY=; b=
	TdUrwF1mbZ2TDu6ydT6bYL/apq76fWS3NbERR95QGVTspWqWYuwRjjelBQFH6Zho
	SsY55HG+Zkqm7T2iAF0jzG0d6zXFFqXifAx7nkSnENmFbXieyuYbCI7ja7SLsVcN
	bsmK+INpNQ8R1PbDjjx68bzNOMP7Ew9h99jMnN9SnyKhC6iGc8XZqtRcm1oDRyls
	ndSu1GeTkv8zjnMBEGvNHA/mqlCFdoNXg37W/gpniuZ8t4g7BhHquezVGBSmSIvv
	46rlDbAvbqj+MnzbiX00gN4EWThixA+f+uFAvgtIxMh1mk0Jtz1+5dnhvEZYtWo2
	Y+87yYFfsF4HGJd8wt4rbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738929122; x=
	1739015522; bh=CjPc3rl1H8TQWze2w549g/TOtY8Fx2Bmn4eFtMh6ipY=; b=p
	1Conr3hH7O1dZQONPavugqM4R2mh1os+vp3NzJd9TA+EU5bfou/ZMP5vQMgPZw7q
	+YeZWRLYy157D2Ix2dfT1rcVu+lxyzLGi5qDAPbsYGh3PIKjYhZth3RGgTeTvnEQ
	Dd9DoZKIio/6bwTELgcNJ/tKhrzH+TzJBpO761GrnI2xwpcQlViG2Yc10vJ0YiO/
	3Wvzpddu2weaNg3mXoAcnyGI9hBkclAwvc23WtUt3dUWhSGqJc4UaIT3TiLSza9u
	5NBA/K2nFKZFSEKDqTuaVdYsIZqXhsOy2Vg05U4bXW8Hnuekm5XzzcgO0mnwiLVj
	lyY/ZFOM0AwNEgwEjjUsQ==
X-ME-Sender: <xms:4vOlZ6NYqag0jUqXioWtxPRR2vO0jdl8ssdLbinaLOjaJofB0phacA>
    <xme:4vOlZ49L901-5BMn8DPlXW-lvXr-EhI5KnwT2AP-hPMitN0WcGReSmDHNRfaMGGpu
    eG6IlflK_hvEtytag>
X-ME-Received: <xmr:4vOlZxT-YQG1UuTYFd4dUxEBKbAxxizVZu3gUNqCA0FZClziKhvZIYCTjbBO3CYwFWPjXgwnL9Is3NvBlh3DQyNSX2KaZ60bKKB1Zq8Anx4KdNgs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhephefgleekkeefhfeftefhgfeifeegkedvvdfgjeeu
    hefgueejffdujeeuleeikeehnecuffhomhgrihhnpehgohhoghhlvgdrtghomhdpkhgvrh
    hnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehtohhonhesihhothgtlhdrtg
    homhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthhhomhhsohhnse
    gvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:4vOlZ6uSUni8n7GOGA8Xl61VIJuKkMaHqur8tKc1WrZF-pwVclPAhQ>
    <xmx:4vOlZyfZ1SbOOf6yqFTZN83_KWFCDUhXkM8vu7YbP__Fw0Bxb9Gshg>
    <xmx:4vOlZ-0bAS0u78KreGWY8VafhUdSnlxwX4t1oBqwP2gIXPfcJLAScA>
    <xmx:4vOlZ29jqd-qk_e9H5T7Ok4Oq_NLhh4fY_UrRRxngKbKsvnvyQPUyA>
    <xmx:4vOlZ6Qs-ho5FVrTxgVjZ2uk7bozklIvk7f_WV9Schlp5e8oCaPDPLtl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Feb 2025 06:52:01 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 32a004f1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Feb 2025 11:52:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 00/18] reftable: stop using "git-compat-util.h"
Date: Fri, 07 Feb 2025 12:51:55 +0100
Message-Id: <20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANvzpWcC/43PTW7CMBAF4KsgrzuVPf5LWPUeVRfBnsCoQFLbR
 K1Q7l6HSgV2Wb6x/b3xVWRKTFlsN1eRaOLMw7kG+7IR4dCd9wQcaxYo0SilWhg/MyTqS7c7EsQ
 0jLDnAmE4jV2BS+EjGC973PWRrENRnbFe5+9bx/vHX070dalV5T48cC5D+rntMallulRaqdCvq
 JwUSHCEjeysM433b/XNK5/EQk/4yDVrOKxcaGxAqbXT6pnTd66er+F05YxxoaVoiFp64swj59Z
 wZvms1BG9i7Zv7T83z/MvNRQFPtEBAAA=
X-Change-ID: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562
In-Reply-To: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, Toon Claes <toon@iotcl.com>
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

Changes in v4:
  - Fix a couple of now-invalid relative includes that I missed. This
    fixes the build issue in "seen" with Meson.
  - Link to v3: https://lore.kernel.org/r/20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im

Changes in v5:
  - Rework the implementation of `REFTABLE_UNUSED` to use
    `__attribute__((__unused__))`.
  - Link to v4: https://lore.kernel.org/r/20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im

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

 Makefile                                |   2 +-
 compat/{mingw.c => mingw/compat-util.c} |  28 +-
 compat/mingw/compat-util.h              | 220 +++++++++++++
 compat/{mingw.h => mingw/posix.h}       | 216 +------------
 compat/msvc.c                           |   6 -
 compat/msvc/compat-util.c               |   6 +
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
 reftable/blocksource.c                  |  17 +-
 reftable/iter.c                         |  13 +-
 reftable/merged.c                       |  27 +-
 reftable/pq.c                           |  40 ++-
 reftable/pq.h                           |   2 +-
 reftable/reader.c                       |  33 +-
 reftable/record.c                       |  84 ++---
 reftable/record.h                       |   6 +-
 reftable/stack.c                        |  52 ++-
 reftable/system.c                       |   7 +
 reftable/system.h                       |   9 +-
 reftable/writer.c                       |  27 +-
 t/unit-tests/t-reftable-basics.c        |  28 +-
 t/unit-tests/t-reftable-pq.c            |  22 +-
 t/unit-tests/t-reftable-record.c        |  42 ++-
 31 files changed, 1205 insertions(+), 947 deletions(-)

Range-diff versus v4:

 1:  7db7704c24 =  1:  74f576c975 reftable/stack: stop using `read_in_full()`
 2:  3ddd26284d =  2:  acd5854f56 reftable/stack: stop using `write_in_full()`
 3:  5f4a747da9 =  3:  25aab5acc1 reftable/blocksource: stop using `xmmap()`
 4:  64b87dd35f =  4:  5ea4f2d8ea reftable/record: stop using `COPY_ARRAY()`
 5:  49ab3789ac =  5:  2ca248c1cc reftable/record: stop using `BUG()` in `reftable_record_init()`
 6:  47aacb4064 =  6:  590b9097e3 reftable/record: don't `BUG()` in `reftable_record_cmp()`
 7:  4a777111bb =  7:  461cb30e1c reftable: stop using `BUG()` in trivial cases
 8:  743e70374d =  8:  72f672b731 reftable/basics: stop using `st_mult()` in array allocators
 9:  2a7cba7ec7 =  9:  c597bd1621 reftable/basics: provide wrappers for big endian conversion
10:  fd741883d7 = 10:  643b70b67e reftable/reader: stop using `ARRAY_SIZE()` macro
11:  2a4e188e96 = 11:  dc809eefbf reftable/system: introduce `reftable_rand()`
12:  57014b3de7 = 12:  bf59b53b60 reftable/stack: stop using `sleep_millisec()`
13:  7daddddd0d = 13:  68ffa9306f reftable/basics: stop using `SWAP()` macro
14:  e7556a7d53 <  -:  ---------- reftable/basics: stop using `UNUSED` annotation
 -:  ---------- > 14:  b444c64faf reftable/basics: introduce `REFTABLE_UNUSED` annotation
15:  4628c8a98e = 15:  2043277fb1 compat/mingw: split out POSIX-related bits
16:  055b865078 = 16:  f496f30aa2 git-compat-util.h: split out POSIX-emulating bits
17:  ae323e3b8d = 17:  3e4564d927 reftable: decouple from Git codebase by pulling in "compat/posix.h"
18:  6c3360b76a = 18:  63d85e0ace Makefile: skip reftable library for Coccinelle

---
base-commit: 8047765d092881ec4aef7dfc57772161eee7f0f5
change-id: 20241119-pks-reftable-drop-git-compat-util-470f2bfde562

