Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276AB386440
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775115090; cv=none; b=csxKU47xR18E6yOCjf2W93Obaakq9ER0iZT/yDRtqwRMFIbh6spvqZZIDk/4kWa9iG1M30v5EDiRZJ7vZPBOyQg/h6o2cOXBtfB3m5aUkWTGc0CH/EeXelO0AI69NXTaUe4r6jjuaHf1tw4zMMmVTwO7XfNxL+QWyc5zDJNTKEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775115090; c=relaxed/simple;
	bh=wVYU5Q5g4ElH8GX2ogPXlAauhGhDr4IZXAfmO/a5UuQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ZIP/fh17ml6sRJGsdJUVQv0F3kSgQHda3MpqcR0aJSgJgS7vA0EiEzsAteASCPTkqEgvKhHB/ktpGezIFmocK93tjl4HX0FfsbtpK+hP+/MRfPEoOptycWhBHrZ9jJjL7MXhucYnkjIfeZySMn6ec8LIGdwTO+OC4CWVHEDNMO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ineRg6i2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TOpGMcB1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ineRg6i2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TOpGMcB1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 283941D003D3;
	Thu,  2 Apr 2026 03:31:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 02 Apr 2026 03:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775115088;
	 x=1775201488; bh=dzd+pxF/UuySD+Ja4MKMsZ722+KccMamgCCdG5uEFA8=; b=
	ineRg6i2jL9e7gYVsR9JF262Id11om1FYdHo6+ThnOi81Y/fbaQ5DPzsQiecBwy+
	xRRNggwTayCnGJ562TKeROxAKj4XHxEVGQr5Ohi2eDyvl1e6n0/ghbqYosS9kFkU
	mF3MKtYd2g5+63uIdMdAP5Vfjg93GesOjzUf4JRSu7gxEZ1uZTkMIwXBbL2lbWek
	jd1fj/P5SUepnbeWkQuz9ObvgMlwSZzCLlHUz/OAwUWtzTG4UyW8WdYdPSBp5ZQn
	EeSl+3FF87V7vwkn+kyiqFTdvC+bf9su3YwVocVZ8xUSP7Czar3Q14Lr046ShQF1
	NjDrKDY5mOXfSpOBvdyXOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775115088; x=
	1775201488; bh=dzd+pxF/UuySD+Ja4MKMsZ722+KccMamgCCdG5uEFA8=; b=T
	OpGMcB1j2UPqUuqXxXO+gxo3MhUaFCLiC+/nsvqbwKVP/98iPSkRG/LRAmxAY6CF
	qJBAv/BRAzOJqrul7vqFDgRcY2f3t0Bk8A3j+1p84KJKHAm/LpkaoUluxqD1rKgR
	XTFYZe+8Jnh1qdPHdRDYRZv8v1RoWE99wO0To6gZQ8qZslbz6NP69vKKAYHwE3st
	wyfUiFYo1iwgSz5SzySFfxfDkyZdiHv7Oag7q6zgEzAsY92y15JiBEjuTuwyqMs4
	WUNaSIIGT+6QKtwG5NbYFDHDfIkJ3ewbbcSHri9fZ4yHVe/KEFW7gvtCBBNTFtMl
	PGWIzQYw26p84olOkj+8w==
X-ME-Sender: <xms:TxvOaZZSfxjZ-wwWPWs88dR9a88zjvocuCgSs1iDbpclc36C36Hj7A>
    <xme:TxvOaa_7mnaDhqzjJDWV9ZzqL8bAg02VbXdFoCw0u_wcoY4QUal-UMG_9FKfieGtu
    WVdwfFUUVseAF3x1Dj7NXUR41LsHgDE0AM-qqYc37D8A4fj547V>
X-ME-Received: <xmr:TxvOaYhxkF6hPUQLjkqx5P-5Ve9-DAK7B2zFQii48iEF_QCL9WKiMC4WQSm8jHeWIVdH-IJy19ui03UD-M5p2Kag9JBgVvyGwIaNBD6WXg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehgeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtre
    dtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepgedtteeghfefkeefvedtjedvueefudejfeduud
    etfffhffelveeileejheeugfetnecuffhomhgrihhnpehmshhgihgurdhlihhnkhdpghhi
    thhhuhgsrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvg
    dprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgv
    thdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:TxvOaae8IVBG-LNvwp4W3PXoeSy6bmwc4-xrT9sFj1sQnN6okEFUUw>
    <xmx:TxvOafqqZXgtv6RKCf94Y-5M9nL814DPCHkp7w1IGsFz8aGGfa7HvA>
    <xmx:TxvOafB7SY21UgdojuWPPvtzELYb6Y8m9ClO06uRsOkkxDW0smYAQg>
    <xmx:TxvOacZLEKokJXz8XVWtUJIuTENRSaWJy9qfwqF3NXNws8CkIxINYQ>
    <xmx:UBvOaXnNJug-gGQuXnF7RPpGJJwNLdl1vKOLbJ50iW4eeyytMasIjam2>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 03:31:26 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 23b30528 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 07:31:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] reftable: some more portability improvements
Date: Thu, 02 Apr 2026 09:31:13 +0200
Message-Id: <20260402-pks-reftable-portability-fixes-v2-0-bc110cee0ae0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEEbzmkC/4WOSQ7CMAxFr1JljVGa0jCsuAfqogkONXRSHCqqq
 ncnAbFm5yc//+9FMHpCFqdsER4nYhr6CGqTCdvU/Q2BrpGFkkrLopAwPhg8ulCbFmEcfByopTC
 DoxcyFBqNOzql9laJGDJGNy1ixqX6Mj/NHW1IqcloiMPg588HU568X1n+r2zKQcJOG1djWVp9s
 Od4sKVOVOu6vgFANH6F2wAAAA==
X-Change-ID: 20260330-pks-reftable-portability-fixes-36ebf9f227c2
In-Reply-To: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
References: <20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>
X-Mailer: b4 0.15.1

Hi,

this patch series contains the last set of portability improvements
that currently sits in the reftable implementation of libgit2. With
these patches merged lbigit2 is able to fully reuse the reftable library
while only having to provide its own system headers.

I've got a test run with libgit2 at [1], the code in Git is tested at
[2]. Overall we're quite close -- the pull requests to implement the
repository extension and to adjust handling of pseudo-refs have been
merged. Still missing is a couple of test fixes, but once those are
merged the reftable backend itself will be in review.

Changes in v2:
  - Reorder commits a bit so that we introduce "reftable-system.h" early
    on.
  - Make the split between "reftable-system.h" and "system.h" cleaner
    and explain it better.
  - Drop the `REFTABLE_INLINE()` patch. I can work around it in libgit2
    itself.
  - Drop the fsync callback and instead require it to exist, so that we
    can do some macro magic to use our own `fsync_component()` instead.
  - Rebased the libgit2 changes on top of this series to verify that
    we're still moving into the right direction.
  - Link to v1: https://patch.msgid.link/20260331-pks-reftable-portability-fixes-v1-0-46bfae55c68c@pks.im

Thanks!

Patrick

[1]: https://github.com/libgit2/libgit2/pull/7117
[2]: https://gitlab.com/gitlab-org/git/-/merge_requests/535

---
Patrick Steinhardt (5):
      reftable: introduce "reftable-system.h" header
      reftable/stack: provide fsync(3p) via system header
      reftable/fsck: use REFTABLE_UNUSED instead of UNUSED
      reftable/system: add abstraction to retrieve time in milliseconds
      reftable/system: add abstraction to mmap files

 refs/reftable-backend.c         |  6 ------
 reftable/blocksource.c          | 19 +++++++------------
 reftable/fsck.c                 |  2 +-
 reftable/reftable-basics.h      |  2 +-
 reftable/reftable-block.h       |  3 +--
 reftable/reftable-blocksource.h |  2 +-
 reftable/reftable-error.h       |  2 ++
 reftable/reftable-fsck.h        |  1 +
 reftable/reftable-iterator.h    |  1 +
 reftable/reftable-merged.h      |  1 +
 reftable/reftable-record.h      |  2 +-
 reftable/reftable-stack.h       |  1 +
 reftable/reftable-system.h      | 18 ++++++++++++++++++
 reftable/reftable-table.h       |  1 +
 reftable/reftable-writer.h      | 10 +---------
 reftable/stack.c                | 40 +++++++---------------------------------
 reftable/system.c               | 32 ++++++++++++++++++++++++++++++++
 reftable/system.h               | 32 ++++++++++++++++++++++++++++----
 18 files changed, 105 insertions(+), 70 deletions(-)

Range-diff versus v1:

1:  77c23e530a < -:  ---------- reftable/system: provide `REFTABLE_INLINE()` macro
2:  a32aeffa92 < -:  ---------- reftable/stack: don't call fsync(3p) unless provided
6:  5413397e77 ! 1:  11f69c228e reftable: introduce "reftable-system.h" header
    @@ Commit message
         headers relevant to us.
     
         Introduce a new "reftable-system.h" header that allows projects to
    -    provide their own headers.
    +    provide their own headers. This new header is supposed to contain all
    +    the project-specific bits to provide the POSIX-like environment, and some
    +    additional supporting code. With this change, we thus have the following
    +    split in our system-specific code:
    +
    +      - "reftable/reftable-system.h" is the project-specific header that
    +        provides a POSIX-like environment. Every project is expected to
    +        provide their own implementation.
    +
    +      - "reftable/system.h" contains the project-independent definition of
    +        the interfaces that a project needs to implement. This file should
    +        not be touched by a project.
    +
    +      - "reftable/system.c" contains the project-specific implementation of
    +        the interfaces defined in "system.h". Again, every project is
    +        expected to provide their own implementation.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ reftable/reftable-system.h (new)
     +#ifndef REFTABLE_SYSTEM_H
     +#define REFTABLE_SYSTEM_H
     +
    ++/*
    ++ * This header defines the platform-specific bits required to compile the
    ++ * reftable library. It should provide an environment that bridges over the
    ++ * gaps between POSIX and your system, as well as the zlib interfaces. This
    ++ * header is expected to be changed by the individual project.
    ++ */
    ++
     +#define MINGW_DONT_HANDLE_IN_USE_ERROR
     +#include "compat/posix.h"
    ++#include "compat/zlib-compat.h"
     +
     +#endif
     
    @@ reftable/reftable-writer.h
     
      ## reftable/system.h ##
     @@
    + #ifndef SYSTEM_H
    + #define SYSTEM_H
      
    - /* This header glues the reftable library to the rest of Git */
    +-/* This header glues the reftable library to the rest of Git */
    ++/*
    ++ * This header defines the platform-agnostic interface that is to be
    ++ * implemented by the project to make it work on their respective supported
    ++ * systems, and to integrate it into the project itself. This header is not
    ++ * expected to be changed by the individual project.
    ++ */
      
     -#define MINGW_DONT_HANDLE_IN_USE_ERROR
     -#include "compat/posix.h"
    +-#include "compat/zlib-compat.h"
     +#include "reftable-system.h"
    - #include "compat/zlib-compat.h"
      
    - #define REFTABLE_INLINE(type) static inline type
    + /*
    +  * Return a random 32 bit integer. This function is expected to return
-:  ---------- > 2:  422c12955e reftable/stack: provide fsync(3p) via system header
3:  94bd6cae41 = 3:  73fa205b5a reftable/fsck: use REFTABLE_UNUSED instead of UNUSED
4:  ea5aa25f71 ! 4:  139583e68a reftable/system: add abstraction to retrieve time in milliseconds
    @@ reftable/system.c
      #include "../lockfile.h"
     +#include "../trace.h"
      #include "../tempfile.h"
    + #include "../write-or-die.h"
      
    - uint32_t reftable_rand(void)
    -@@ reftable/system.c: int flock_commit(struct reftable_flock *l)
    - 
    - 	return 0;
    +@@ reftable/system.c: int reftable_fsync(int fd)
    + {
    + 	return fsync_component(FSYNC_COMPONENT_REFERENCE, fd);
      }
     +
     +uint64_t reftable_time_ms(void)
5:  27d055eecd = 5:  a445a6e6eb reftable/system: add abstraction to mmap files

---
base-commit: 270e10ad6dda3379ea0da7efd11e4fbf2cd7a325
change-id: 20260330-pks-reftable-portability-fixes-36ebf9f227c2

