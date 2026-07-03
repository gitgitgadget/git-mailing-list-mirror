Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0273D330C
	for <git@vger.kernel.org>; Fri,  3 Jul 2026 12:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783083538; cv=none; b=UIc2j+kc4pl+p9DEpQKl/G3ANX8l8HnObGPAMKLFUdlf90P/iv5REYRL4U991FdhQZDn4IAcbDGNB3WV15q3YxekTBq+DN8xSSeXhE/LeCJGOHHONGDG4gd4ePND4+3Aq/B8UwENwYxVv36wj2fJHr5Q4k1GN9Nr1+Li2iogpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783083538; c=relaxed/simple;
	bh=yFD+xC0Kw3FNY/ScfAPy/dQ1dPI69/YZKRWdCQHbemo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=AXGwhr+c1IRu6WkPgJyQ+EBECCU7Q54xtJqnmP2RI/ZElQQ5B1vnVp0VvHrjEL5bcoasKjJ2AZ8fYuJR7Tn2j3lulzoGDIrPxKzeAkBPuxzODTTdeospg5A409198TNkMEMDu28DsC9xkPVi3bMwccDyEZPuBfZB4g+kWVMqkqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=W0tlbpu0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B/B1zIeN; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="W0tlbpu0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B/B1zIeN"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id ADB5E7A0105;
	Fri,  3 Jul 2026 08:58:55 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 03 Jul 2026 08:58:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783083535;
	 x=1783169935; bh=srgIs2+jbl67TqB+4dWJyaPUJf1fh81BtHcHqAF4/to=; b=
	W0tlbpu0wm8EhjTKyDIgHlF8rEYWtxPyZX531ytEx5Hsx3Hgrn293eiIiu62QzOU
	TGWHLWV91cDGmnrjR4Fi4nkGH4quvrTwK2IrbTttV/CyLqvTu4Z8SrAd2/umhYiE
	XlgcKcRPjyArJnX+XjNuSXAualvzgNaRKOmQR2csEgR+bxAdFQMl+lxNK83BpYvT
	BHu679Ypbcx+O5viguPkMQSlfULVEymrwB3r8IaE/XRtA9h5Wnv1E5YU83e/cko7
	cK+pZHU0SUAUgOc+VGy00tSP+q9Ld32RsFtlJUlJ1lG//OGRzdQryGQE052z9mLY
	tPJuGCNV4Q5z3dEt8WZHgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783083535; x=
	1783169935; bh=srgIs2+jbl67TqB+4dWJyaPUJf1fh81BtHcHqAF4/to=; b=B
	/B1zIeNbme9wJUnvawgLQadFVImIeO+Sq1jL8JougzGL67qmCFWBS+Lr8QmQ3BUb
	aq9bp28RhRGj4Lr6Gunf2w7cXapj/C+LqbLdbsRKrrupTDR4krGoAluzzmmwR8MJ
	1bDOpJkAMXJKoOC7BFshFi9lyjuPo2Nfis+Eo2b9egP0SZWOzubyl2BcO/n9heCu
	RmYFdvzbVxrGLa5eNQ7fkLCHyurtpWwBLTRFfpjaYTdP6ZnL2FpcsvtiU+Ao+wuQ
	oi+5YLBCnb+rtdj9mtHPkGh22J4kQHkYS7vYoWjS5uZcw1dWYj8Tc8EygSHTtBAq
	Ty3uRko4Q2gi6zwNK8Hdg==
X-ME-Sender: <xms:DrJHancr_hydCx05wYeqMOhS4U5R1wdAYipON31jqxfwU2_qMFrzSw>
    <xme:DrJHakMsKFooqMPixxa9P8iHABrxJIxOQv55xPhAoxiUdrtBBNP4RApXsTotnFhPK
    VmWka9awoeR5zeAthWarfEJWDc74hnOmNFNMCuEY0PGfapLcTJk8xU>
X-ME-Received: <xmr:DrJHalgYjdCOw-v_DMzst9VrejcFkUZI7hMzcaf0wqJHlpH0UmaoBcWtMeWUp4OmV1gBQE-PhlijKK3P6UMhOeb3eS-gDYzcyFmIB8nQsw>
X-ME-Proxy-Cause: dmFkZTEOt1DSRk64ggsCQs4UBk54Kjm+byyyOnESHSkWk/4kJzz23e30Hva134Z4hKxd4N
    yQcPijBok9CfvbqshNIawVVwBBwrJhw+Ki7b34sI5iiSG/QqlRUYz9B/372EZI9US40B0Q
    4kNWx9LJVaygJepQZLW1X2Of/LrLvscqqbeKlaDRazdi12uz2Pp5TlAMPo97esm7oLmzGP
    84LDkRrkYvOdyX1+5KkILwfgQaVlaVdx0f8cDAAn/j8AFNmeazlRCkomip5hzoCmGDgA69
    6NDzgoMPkJJ5yCzEC6RyrL2AKha2aXhX0spHENH0fLXpPhBLAUMTOyTj4RO7IxVuTFoLXI
    UHgwgaShzQMoQ+G3oqrylqrXEu9/1y79P5B63IIOaX4G7Ai0zxxj2q5NBMBwM0pojtocku
    v4C6/Wx2i855r5GNGLfcjO3h1sZMZEVMrsI0+ltYm+yQt733NZE1yFuL0m9lCL0kvzxZ/6
    Q5R+a6dq2O3cLd2u6pmIQpYveVldfle9OkSuFwWyLYyZ3OuEilssaGhkdCmrsJiI5XuPD3
    wY2sV7KiU1qPJGqhx2dTJiBONgngeEmJz51L8koVGhccuSsdCIpInMobsocSbj0Z7w9J32
    D6Hv4Ko7Fqivs4CEl6T2VlGMzjwmxOEWLasvLLxfNxyCyG/eh2hv8QASDBmw
X-ME-Proxy: <xmx:DrJHan17MirMgbgg6PDiqF9sF-EwY2TbggnRBzHjo6JT1-koyv7y4g>
    <xmx:D7JHavgX7jz45V7JBHbtKU2SVsyY24CCT9_X6KLK1GrP9HNjvK3iZg>
    <xmx:D7JHandSH1I_Vs1pJFnlZKaPaiFOKpNx7mwlt72g_R7N-8nk_a12aw>
    <xmx:D7JHaikaDNuwit5rxv2cT2SxblAE8N4v3v-fArz8waX-oablYowh3Q>
    <xmx:D7JHak3YMMWX9gGktWH5iV53zZttFODvBaGsr5NymshmLMfTTWg7cz-E>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 3 Jul 2026 08:58:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f8f7c48f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 3 Jul 2026 12:58:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/12] reftable: harden against corrupted tables
Date: Fri, 03 Jul 2026 14:58:43 +0200
Message-Id: <20260703-pks-reftable-hardening-v3-0-b87c555b9920@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAOyR2oC/3WNyw6CMBQFf8V0bU0pWMCV/2Fc9HGB66OQFhsN4
 d9tMRo3LE8yZ2YiHhyCJ4fNRBwE9NjbOPLthuhO2hYomrgJZ1wwwXM6XD110IxS3YB20hmwaFv
 a7AsDom5AipzE8xAZfC7i0/mz/UNdQI/JlogO/di711IOWeK+kWItEjLKqBBQaKhKLVR9jOAO7
 yQVAv931KsOHh2KcV5BaWpWmZ9jnuc3FJ6F5w8BAAA=
X-Change-ID: 20260623-pks-reftable-hardening-f54de69fea63
In-Reply-To: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
References: <20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im>
To: git@vger.kernel.org
Cc: oxsignal <awo@kakao.com>, Toon Claes <toon@iotcl.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

Hi,

this patch series addresses a bunch of errors that may happen when
trying to read corrupted tables. These errors include out-of-bounds
writes, out-of-bounds reads and the ability to hit abort(3p) calls.

The out-of-bounds write was originally reported by awo on the security
mailing list. As we never transfer reftables over the protocol it would
require local disk access to create such corrupted reftables, so there
isn't really an easy way to exploit these.

In any case, I took that chance and wrote a fuzzer for parsing the
tables, which surfaced a bunch of issues. At the end of this series
though the fuzzer can now run for an extended amount of time (2hrs+)
without surfacing any new issues.

Changes in v3:
  - Make one of the unit tests a bit stricter.
  - Link to v2: https://patch.msgid.link/20260629-pks-reftable-hardening-v2-0-b0228e7d908d@pks.im

Changes in v2:
  - Introduce a test helper that writes a reftable block.
  - Link to v1: https://patch.msgid.link/20260624-pks-reftable-hardening-v1-0-66e4ce87c6b9@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (12):
      meson: support building fuzzers with libFuzzer
      oss-fuzz: add fuzzer for parsing reftables
      reftable/basics: fix OOB read on binary search of empty range
      reftable/record: don't abort when decoding invalid ref value type
      t/unit-tests: introduce test helper to write reftable blocks
      reftable/block: fix OOB write with bogus inflated log size
      reftable/block: fix OOB read with bogus block size
      reftable/block: fix OOB read with bogus restart count
      reftable/block: fix use of uninitialized memory when binsearch fails
      reftable/block: fix OOB read with bogus restart offset
      reftable/table: fix NULL pointer access when seeking to bogus offsets
      reftable/table: fix OOB read on truncated table

 Makefile                            |   1 +
 ci/run-build-and-minimal-fuzzers.sh |   1 +
 meson.build                         |  15 +++
 meson_options.txt                   |   2 +
 oss-fuzz/.gitignore                 |   1 +
 oss-fuzz/fuzz-reftable.c            |  74 ++++++++++++++
 oss-fuzz/meson.build                |   2 +
 reftable/basics.c                   |   3 +
 reftable/block.c                    |  39 +++++++-
 reftable/record.c                   |   6 +-
 reftable/table.c                    |   7 ++
 t/unit-tests/u-reftable-basics.c    |  11 +++
 t/unit-tests/u-reftable-block.c     | 189 ++++++++++++++++++++++++++++++++----
 t/unit-tests/u-reftable-record.c    |  24 +++++
 t/unit-tests/u-reftable-table.c     |  91 +++++++++++++++++
 15 files changed, 440 insertions(+), 26 deletions(-)

Range-diff versus v2:

 1:  cd28489ce9 =  1:  53673a5044 meson: support building fuzzers with libFuzzer
 2:  2f304e5bef =  2:  06037f8cc6 oss-fuzz: add fuzzer for parsing reftables
 3:  d74a5b244d =  3:  21b4025e1d reftable/basics: fix OOB read on binary search of empty range
 4:  f710410b28 =  4:  dfed39b876 reftable/record: don't abort when decoding invalid ref value type
 5:  0f90c22ccf =  5:  badbfdc070 t/unit-tests: introduce test helper to write reftable blocks
 6:  b69a8c40a0 =  6:  b0d13e79c5 reftable/block: fix OOB write with bogus inflated log size
 7:  19046dbb2e !  7:  612df3c909 reftable/block: fix OOB read with bogus block size
    @@ Commit message
         block size that exceeds the data we have actually read this can lead to
         an out-of-bounds read:
     
    -      ==1458284==ERROR: AddressSanitizer: SEGV on unknown address 0x7d8ff7de4b7d (pc 0x55555598c339 bp 0x7fffffff4ef0 sp 0x7fffffff4eb0 T0)
    -      ==1458284==The signal is caused by a READ memory access.
    -          #0 0x55555598c339 in reftable_get_be16 ./build/../reftable/basics.h:118:9
    -          #1 0x55555598bee2 in reftable_block_init ./build/../reftable/block.c:344:18
    -          #2 0x555555813e0e in test_reftable_block__corrupt_block_size ./build/../t/unit-tests/u-reftable-block.c:540:8
    -          #3 0x5555557f684e in clar_run_test ./build/../t/unit-tests/clar/clar.c:335:3
    -          #4 0x5555557f2e69 in clar_run_suite ./build/../t/unit-tests/clar/clar.c:431:3
    -          #5 0x5555557f2882 in clar_test_run ./build/../t/unit-tests/clar/clar.c:636:4
    -          #6 0x5555557f375f in clar_test ./build/../t/unit-tests/clar/clar.c:687:11
    -          #7 0x5555557fa49d in cmd_main ./build/../t/unit-tests/unit-test.c:62:8
    -          #8 0x55555584b55a in main ./build/../common-main.c:9:11
    -          #9 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b284) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
    -          #10 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/57iz36553175g3178pvxjij8z5rcsd4n-glibc-2.42-61/lib/libc.so.6+0x2b337) (BuildId: 8ae0b698f2d4e727f569f64bb166e08ae30bd077)
    -          #11 0x555555694c24 in _start (./build/t/unit-tests+0x140c24)
    +      ==2274138==ERROR: AddressSanitizer: heap-buffer-overflow on address 0x7c3ff6de2e3f at pc 0x55555598c6ea bp 0x7fffffff4ee0 sp 0x7fffffff4ed8
    +      READ of size 1 at 0x7c3ff6de2e3f thread T0
    +          #0 0x55555598c6e9 in reftable_get_be16 /home/pks/Development/git/build/../reftable/basics.h:119:20
    +          #1 0x55555598c252 in reftable_block_init /home/pks/Development/git/build/../reftable/block.c:343:18
    +          #2 0x555555813c70 in test_reftable_block__corrupt_block_size /home/pks/Development/git/build/../t/unit-tests/u-reftable-block.c:531:20
    +          #3 0x5555557f684e in clar_run_test /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:335:3
    +          #4 0x5555557f2e69 in clar_run_suite /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:431:3
    +          #5 0x5555557f2882 in clar_test_run /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:636:4
    +          #6 0x5555557f375f in clar_test /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:687:11
    +          #7 0x5555557fa49d in cmd_main /home/pks/Development/git/build/../t/unit-tests/unit-test.c:62:8
    +          #8 0x55555584b8aa in main /home/pks/Development/git/build/../common-main.c:9:11
    +          #9 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/8kvxvr3pmsypxiypq4g8zy13glnfr7nx-glibc-2.42-67/lib/libc.so.6+0x2b284) (BuildId: 5a702452a01df1d7d50ce0663acec7be3c71fd4d)
    +          #10 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/8kvxvr3pmsypxiypq4g8zy13glnfr7nx-glibc-2.42-67/lib/libc.so.6+0x2b337) (BuildId: 5a702452a01df1d7d50ce0663acec7be3c71fd4d)
    +          #11 0x555555694c24 in _start (/home/pks/Development/git/build/t/unit-tests+0x140c24)
     
    -      ==1458284==Register values:
    -      rax = 0x00007d8ff7de4b7d  rbx = 0x00007fffffff4f00  rcx = 0x0000000000000006  rdx = 0x0000000000000010
    -      rdi = 0x00007d8ff7de4b7d  rsi = 0x00007bfff5cf0420  rbp = 0x00007fffffff4ef0  rsp = 0x00007fffffff4eb0
    -       r8 = 0x00000f807eb960b8   r9 = 0x0000000000000001  r10 = 0x00007bfff5cf05e7  r11 = 0x000000000000000f
    -      r12 = 0x00007fffffff58f8  r13 = 0x0000000000000001  r14 = 0x0000555555ee8160  r15 = 0x0000000000000000
    -      AddressSanitizer can not provide additional info.
    +      0x7c3ff6de2e3f is located 0 bytes after 47-byte region [0x7c3ff6de2e10,0x7c3ff6de2e3f)
    +      allocated by thread T0 here:
    +          #0 0x55555579e95b in malloc (/home/pks/Development/git/build/t/unit-tests+0x24a95b)
    +          #1 0x5555559871c2 in reftable_malloc /home/pks/Development/git/build/../reftable/basics.c:24:9
    +          #2 0x5555559872e8 in reftable_calloc /home/pks/Development/git/build/../reftable/basics.c:54:6
    +          #3 0x55555598f0d3 in reftable_buf_read_data /home/pks/Development/git/build/../reftable/blocksource.c:67:2
    +          #4 0x55555598ea7e in block_source_read_data /home/pks/Development/git/build/../reftable/blocksource.c:41:19
    +          #5 0x55555598c555 in read_block /home/pks/Development/git/build/../reftable/block.c:224:9
    +          #6 0x55555598b69e in reftable_block_init /home/pks/Development/git/build/../reftable/block.c:258:9
    +          #7 0x555555813c70 in test_reftable_block__corrupt_block_size /home/pks/Development/git/build/../t/unit-tests/u-reftable-block.c:531:20
    +          #8 0x5555557f684e in clar_run_test /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:335:3
    +          #9 0x5555557f2e69 in clar_run_suite /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:431:3
    +          #10 0x5555557f2882 in clar_test_run /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:636:4
    +          #11 0x5555557f375f in clar_test /home/pks/Development/git/build/../t/unit-tests/clar/clar.c:687:11
    +          #12 0x5555557fa49d in cmd_main /home/pks/Development/git/build/../t/unit-tests/unit-test.c:62:8
    +          #13 0x55555584b8aa in main /home/pks/Development/git/build/../common-main.c:9:11
    +          #14 0x7ffff7a2b284 in __libc_start_call_main (/nix/store/8kvxvr3pmsypxiypq4g8zy13glnfr7nx-glibc-2.42-67/lib/libc.so.6+0x2b284) (BuildId: 5a702452a01df1d7d50ce0663acec7be3c71fd4d)
    +          #15 0x7ffff7a2b337 in __libc_start_main@GLIBC_2.2.5 (/nix/store/8kvxvr3pmsypxiypq4g8zy13glnfr7nx-glibc-2.42-67/lib/libc.so.6+0x2b337) (BuildId: 5a702452a01df1d7d50ce0663acec7be3c71fd4d)
    +          #16 0x555555694c24 in _start (/home/pks/Development/git/build/t/unit-tests+0x140c24)
    +
    +      SUMMARY: AddressSanitizer: heap-buffer-overflow /home/pks/Development/git/build/../reftable/basics.h:119:20 in reftable_get_be16
    +      Shadow bytes around the buggy address:
    +        0x7c3ff6de2b80: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
    +        0x7c3ff6de2c00: fa fa fd fd fd fd fd fa fa fa fd fd fd fd fd fa
    +        0x7c3ff6de2c80: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fa
    +        0x7c3ff6de2d00: fa fa fd fd fd fd fd fd fa fa fd fd fd fd fd fa
    +        0x7c3ff6de2d80: fa fa 00 00 00 00 00 00 fa fa fd fd fd fd fd fd
    +      =>0x7c3ff6de2e00: fa fa 00 00 00 00 00[07]fa fa fa fa fa fa fa fa
    +        0x7c3ff6de2e80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    +        0x7c3ff6de2f00: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    +        0x7c3ff6de2f80: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    +        0x7c3ff6de3000: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    +        0x7c3ff6de3080: fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa fa
    +      Shadow byte legend (one shadow byte represents 8 application bytes):
    +        Addressable:           00
    +        Partially addressable: 01 02 03 04 05 06 07
    +        Heap left redzone:       fa
    +        Freed heap region:       fd
    +        Stack left redzone:      f1
    +        Stack mid redzone:       f2
    +        Stack right redzone:     f3
    +        Stack after return:      f5
    +        Stack use after scope:   f8
    +        Global redzone:          f9
    +        Global init order:       f6
    +        Poisoned by user:        f7
    +        Container overflow:      fc
    +        Array cookie:            ac
    +        Intra object redzone:    bb
    +        ASan internal:           fe
    +        Left alloca redzone:     ca
    +        Right alloca redzone:    cb
     
         Verify that the claimed block size fits into the block data before using
         it.
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_log_block_siz
     +	};
     +	struct reftable_block block = { 0 };
     +	struct reftable_buf data = REFTABLE_BUF_INIT;
    ++	uint32_t block_size;
    ++	unsigned char *p;
     +
     +	cl_reftable_write_block(&data, REFTABLE_BLOCK_TYPE_REF, &rec, 1);
     +
    @@ t/unit-tests/u-reftable-block.c: void test_reftable_block__corrupt_log_block_siz
     +	 * the restart count and restart table relative to such a bogus block
     +	 * size must not access out-of-bounds memory.
     +	 */
    -+	reftable_put_be24((uint8_t *) data.buf + 1, 0xffffff);
    ++	p = (unsigned char *) data.buf + 1;
    ++	block_size = reftable_get_be24(p);
    ++	cl_assert_equal_i(block_size, 47);
    ++	reftable_put_be24(p, block_size + 1);
     +
     +	block_source_from_buf(&source, &data);
     +	cl_assert_equal_i(reftable_block_init(&block, &source, 0, 0, data.len,
 8:  bc0e0e5f30 =  8:  6df5cc741a reftable/block: fix OOB read with bogus restart count
 9:  668108e851 =  9:  74e7d35bd9 reftable/block: fix use of uninitialized memory when binsearch fails
10:  bb3f76e084 = 10:  3264933eba reftable/block: fix OOB read with bogus restart offset
11:  6b7e61728b = 11:  638964395c reftable/table: fix NULL pointer access when seeking to bogus offsets
12:  ea051207e1 = 12:  6745a7fca8 reftable/table: fix OOB read on truncated table

---
base-commit: ab776a62a78576513ee121424adb19597fbb7613
change-id: 20260623-pks-reftable-hardening-f54de69fea63

