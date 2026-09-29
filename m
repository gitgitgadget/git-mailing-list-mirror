Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18B7514746
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681152; cv=none; b=pFskbrwFXA/2EWoHKOBbqEb9YfNCwesYqf0SPzmbFmFmHYITjtsUFChyKG7i7JW5gQOEbTC2nXlBWaRhBwe/m8QvhnObM4SxGueBw0fwwXSUIWiuv0oB/5pYqr83qacTR5b16cDU0pWH8kUih4J8AqJiq0Z3Hs0k3Yrfk5BAgtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681152; c=relaxed/simple;
	bh=faxcR9DGC4+Cw4lziMcUB/smbyAF8nQrM3XMlOVg8C8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ffk1wrPkehZs2gufIJt2Vji38z5IZLKGykbSvls9jHnyhS8EsAKDqbhgn0IelX4uDMylcJYe9I5a5rdUE0ecMfU+pFKKg9XyqGCaEkhcbeg7wLeexH9pp9IB6jwdINlAnbR60dfMo68Uv6H9Vt6j6fxJZLyqxEYUqvXZ2lJCGIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net; spf=pass smtp.mailfrom=gitbutler.net; dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b=NKvJ++LZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t3J7QOlC; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gitbutler.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gitbutler.net header.i=@gitbutler.net header.b="NKvJ++LZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t3J7QOlC"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D0CDA7A0038
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 07:25:48 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 29 Sep 2026 07:25:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gitbutler.net;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm2; t=1790681148; x=1790767548; bh=Xc
	eoLvP7JaDy0Y8/jneM1iI5QB58i5Q8mQsmx76wrXA=; b=NKvJ++LZ7o+nFX/qRL
	DCXoA3P9NA4NrRF9OrTpEb37mwK77gpUXc1J6lvDy8oAi+VHeI+WqDhFztZyGDym
	U+4x7CEncMGQYucLfQAf6wa+cNs/kb6jgQdvPISuXflNnKjn5wXobM1L+uFCV9bB
	1KC5RX6JKsy1418xEw8ps0TnHJkRarxR9Mw433eWs4ViTr485f95HGZvdW+0vxE9
	IcTpS3/lZMy3kamH/YIIWed5husnnHUmeYcUUdPVzVldwKGKeMoj1Lqyl0r6HSKa
	JdiamZpQ9Q9aS2gAic32hzSqEFyzmyZ6eHzcAIMPHam1chQ7CIB3iujpiJbhIhgi
	DP/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790681148; x=1790767548; bh=XceoLvP7JaDy0Y8/jneM1iI5QB58i5Q8mQs
	mx76wrXA=; b=t3J7QOlCc9Wtoh85f6ZTa0DeAsOI+Ti1+F+qc7ttIOpWXs764Il
	shgYTfJE+MnwpIZJ4LPA0JyixM6S78eaYeCra2EBm4rE4RlqY50s4do+XDp0DaVI
	pOSTLj1/5xehRSAR36S/Jr0YHtz+Wq0Dd9sfHY/EfShqmts0Oa2zikKgiSBic1m8
	BKBdomLKURGlBf8HzSuSSjlECARKF+ZssPY5JL2tLUsFrA/r7E2g9S+XwyOKzlri
	NhIvofGL7YgkMXZUg0teA5UUGAjZGXYWuup52k5iL1+2Sp96MgD/kAPwua+HBgT+
	s81jwzJpWuq+nwMb7EaGpDaIf3X8em/dRCA==
X-ME-Sender: <xms:PKC7agB95v7YBzobniDd-VXSyGIYKQnYGcQ10kAXht1zwDYGwyT0vg>
    <xme:PKC7apdNEX_KO_qBi0YJiGrYZ4pLLRSIv1DoxPlCNjrwNhhpKuGpuRB5lMdYJ6cVu
    p4fsW5aRaIAAzJXi3lEfhFHbRdUPrw6Kv4oGZcTIMVSedunVyyqTw>
X-ME-Received: <xmr:PKC7apMeaput18feE9SCQ_PXJk30J3G6Rhpg4Emds4AE1qUePTz4awEzhxlT2cuzjzN1lg>
X-ME-Proxy-Cause: dmFkZTEFCj2bTYshrmF9pZ8xDo3wu0ENdelNQEsmA0//4UTyl2+ehzhkHb234M5HjAK1mg
    8zms5x9p3QCH54AetaYUSqIKaOx+wGwYhHKFv5bM4kRGmcVU38xibJ8no++40hpkKCuG5V
    pwfEPuNqowvO3ho3LC1ylfiMiO4CoyjQYLawGVsSCAUMWzju1fYM9PT5jUIqc7U9ud/JjT
    MFuJ9ECbZuEC9lbKhfJbxnxe918mga8Co9cpc3hpVwjJTbPAHsISub7p1AnoqMdUEtLyFo
    ML/XQHPj1J6YSf4RxtWcV33W0iDfGWKE31k8mK572k1sWlP3K9rNxkQNASFRBCTN0JtCU9
    4XN7e/kktLTbZ7JC75iiMwKYKxCTG063Pjli9sY7Segy0h4GTNNFZgqKq/TRTKJ91oshGu
    dLYw19H3MmJlCDq39SMmASa/9sJc4V2sccPKVT1nFCAX6j3M0yz+JhwVng6QFItHOvmXUu
    UbZfdNOzWqpWx3OQIhmKFtRXiYu3L6rH4jmlpzK9fZOp5Ap0JW2jufoad7DeM6WThf+bdr
    oc0klA6YiQQdvw+xW3cCVFiqndVhn0kFa/0XHi1FG1zgy5deybbLEpYIuEDvFn/0nCtJhf
    wLKZScosT2baLVa98bUH/AyLQJkWnRUTXlNS2SZ+jrujkdhq04+xRkrh350A
X-ME-Proxy: <xmx:PKC7ar6XoJV_Nwx9ADXKtl_186EbbdGA1GmEgO2uh_OScrLEc1vpgQ>
    <xmx:PKC7alJFAkacUR6ca3NMbmzMmqz3PpLRNLrQpwSeAZQ6InDS4ynFuw>
    <xmx:PKC7atccgp7zPaB5fJKFNkaiTRdpciRkEkTXHo38yrw5DL7UbqA3ng>
    <xmx:PKC7agd7gno3-OKpr4HYWZe5KNH1sKscmUtfPhSTGE-arqvyAzs4Gg>
    <xmx:PKC7arBSAqPDT9PV1OjoTE730BVq70IJHIi_Q_lZGWjzUQZS3FTMAGdM>
Feedback-ID: iecfe4abb:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 29 Sep 2026 07:25:46 -0400 (EDT)
From: Scott Chacon <scott@gitbutler.net>
To: git@vger.kernel.org
Subject: [PATCH 0/4] faster SHA-1 collision detection
Date: Tue, 29 Sep 2026 13:25:40 +0200
Message-ID: <20260929112544.86511-1-scott@gitbutler.net>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

So, spoiler alert, the code in this patch series is mainly AI generated.
I would try to fool you, but too many of you are far too aware of my
actual C skills. That being said, I thought maybe someone here (especially
those of you working on server optimization stuff) would be interested
in the speed increases for both the server and client in making sha1dc
quite a bit faster.

This series ports the approach of Sam Reis's sha1dc Rust crate [1], 
which gitoxide recently switched to [2], to C. 

The end result hashes roughly 2.7x faster on the Xeon and 2.85x faster
on the M5 Max. Single-threaded index-pack of git.git goes from 24.3s to
12.7s on the Xeon, and from 16.1s to 8.7s on the M5 Max.

Hashing throughput on the Xeon, in MiB/s:

                                16KiB    1MiB   vs OpenSSL
  OpenSSL SHA-1 (no detection)   1234    1129      1.00x
  sha1dc/ (today)                 435     450      2.67x
  shani+avx2 (default here)      1002     901      1.24x
  shani+sse2                     1075    1008      1.13x
  portable+avx2                   553     654      1.96x
  portable+sse2                   603     681      1.84x
  portable                        466     565      2.29x

In other words, currently collision detection costs about 1.5–2.5x on
top of the hashing itself today, but only about 0.2x with the series. 

The patches are:

  [1/4]: sha1dc-accel: add a block loop for sha1dc's SHA1_CTX

    Just groundwork: our own block loop around sha1dc's context and DV
    table, with the same results and a few percent slower, plus tests
    that compare against sha1dc/ directly, including on real collisions
    in every mode.

  [2/4]: sha1dc-accel: vectorize the unavoidable-bitconditions check

    The UBC filter rewritten as SSE2, AVX2, NEON, and new scalar forms, 
    using the conditions the crate's solver picks for each. They're 
    carried as tables, with a short loop per form to run them. 
    1.29x on the Xeon, 1.27x on the M5 Max.

  [3/4]: sha1dc-accel: compress with SHA-NI on x86-64

    Hardware compression, with the schedule spilled, and recompression
    of flagged blocks in hardware, too. Another 2.07x on the Xeon.

  [4/4]: sha1dc-accel: compress with the ARMv8 SHA-1 instructions

    The same for arm64. Another 2.4x on the M5 Max.

The x86 numbers are from a 4-vCPU Xeon VM with SHA-NI and AVX2 (GCC 13,
Linux), which is unfortunately rather noisy; the per-patch hyperfine
output has the spread. The arm64 numbers are medians of 9 runs on an
Apple M5 Max (Apple clang, macOS). The full test suite passes on both.

[1] https://sam.dev/blog/faster-sha1-collision-detection
[2] https://github.com/GitoxideLabs/gitoxide/pull/3008

Scott Chacon (4):
  sha1dc-accel: add a block loop for sha1dc's SHA1_CTX
  sha1dc-accel: vectorize the unavoidable-bitconditions check
  sha1dc-accel: compress with SHA-NI on x86-64
  sha1dc-accel: compress with the ARMv8 SHA-1 instructions

 Makefile                            |   14 +
 contrib/buildsystems/CMakeLists.txt |    2 +-
 meson.build                         |    4 +
 sha1dc-accel/arm.c                  |  274 ++++
 sha1dc-accel/internal.h             |  126 ++
 sha1dc-accel/sha1.c                 |  498 ++++++++
 sha1dc-accel/sha1.h                 |   31 +
 sha1dc-accel/ubc_check.c            | 1789 +++++++++++++++++++++++++++
 sha1dc-accel/x86.c                  |  260 ++++
 sha1dc_git.c                        |   18 +
 t/.gitattributes                    |    1 +
 t/helper/test-sha1.c                |   95 ++
 t/helper/test-tool.c                |    2 +
 t/helper/test-tool.h                |    2 +
 t/meson.build                       |    1 +
 t/t0013-sha1dc.sh                   |   47 +
 t/t0013/sha-mbles-1.bin             |  Bin 0 -> 640 bytes
 t/t0013/sha1-reduced-round.bin      |  Bin 0 -> 128 bytes
 t/unit-tests/u-sha1dc.c             |  366 ++++++
 19 files changed, 3529 insertions(+), 1 deletion(-)
 create mode 100644 sha1dc-accel/arm.c
 create mode 100644 sha1dc-accel/internal.h
 create mode 100644 sha1dc-accel/sha1.c
 create mode 100644 sha1dc-accel/sha1.h
 create mode 100644 sha1dc-accel/ubc_check.c
 create mode 100644 sha1dc-accel/x86.c
 create mode 100644 t/t0013/sha-mbles-1.bin
 create mode 100644 t/t0013/sha1-reduced-round.bin
 create mode 100644 t/unit-tests/u-sha1dc.c


base-commit: a018953688f1b10bddf91bff8747068f5f4746a4
-- 
2.50.1 (Apple Git-155)


