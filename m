Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C045C18
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 06:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744613477; cv=none; b=Ct0qdF0qB9En/b94ejNujwswy1TQvblAgL6hFNgQxvPGgW3T/kadRynuxNXa/S7ouQUlpxGvgQrSGKeWCYUbmiOPMRsOFZhxju3ezdj9otnsqe6dEXyiaR10vq6iYJgd4Exc54f/QxYGDEh3XL0hY7IrmPc97qZdAT8GMH2CUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744613477; c=relaxed/simple;
	bh=6nZTNbCj9wQilDfTpjSOAKWDiD7/s68W7ZypjnXDAFo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To; b=qpfCVHMHKURBIoXuslmuigASL4E5CTvsGNcgdFik+HoH+tyUyKRmyc44RENqREOTKVrqhq/nUNVWsHq66hTkYstsScTB3Pn+XqxhigpYd61aGf+DiUaCR6sY/EIaInNyn324i4lk2cTldwLI9/aZjgOmqGWfcbfi5RJ37rwwhSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VA5wjv4F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+ByZBWv; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VA5wjv4F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+ByZBWv"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id C8C881140105
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 14 Apr 2025 02:51:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1744613474;
	 x=1744699874; bh=onL/H2iOfs1ozysXsgtg2q3VfuCIhf4fvnrqSurHMGI=; b=
	VA5wjv4FXJf8V6T8fn451hR3r1Q0Y8D2Zre4PhG2MTP6AhLmkQn6HNkE5FP6Ob28
	m3CG5kU7L+583FXv6vln44gPW9povmDc2WoidgEOT80U8b1cvFx3BZP3bu8my9UH
	nensUqPzbz4KeGsBm/gE2rimvf71kIgl6k0ZHUHncQQuHBKT9XgYsNlsSgL8ggRf
	ub/xHtl/9GtrDJ2xt3aiFWoZ7ox8CVam/HsONmsVUlJJmEFuvZdtlC2oZPZUA8ZR
	t+cQDfh1dXUCMALGsxLY65eK10Yg9In7nfaNIRsd8RDNXrnmujsm5vuVD754R8X0
	zF/RpvmBZ/iJ1KpwzkkYOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1744613474; x=1744699874; bh=o
	nL/H2iOfs1ozysXsgtg2q3VfuCIhf4fvnrqSurHMGI=; b=b+ByZBWvLtzkyGblq
	aqtvqf5MUPnHqHH4V59iAycxBXvcVT9GPKv8l70/SlKOro7J/gTWzUxop/5msIvz
	7cJbdfhH/+RbODivIbxl2VaTLCMhqTFDvF2+eoIEG+CtmZG/nfWoUJUGMq4U2LPn
	VQEGBq4Nx1KXE3PIFv3QKRA2RbDIanNHiX1YRR5ogXALQCpA0mYNe5Yi3CGgurVJ
	JzLU5+UUhgFZcRy/adZzv9DW8DP048iZRT8wJBnQurntzfr6PyV+cCqbaNU1mbC/
	QpZd5wDinmR05TkHDMfi55698Slx51LDt//2NHvRdHRxQ4S75eCYN7C63Kfah6I0
	gqM0w==
X-ME-Sender: <xms:YrD8Z6cLTs2-QJ6t8X8-7e-TglbUnoqlrOg9nYEHJ-LOLaA-Vpa-wA>
    <xme:YrD8Z0McnWCfj1oZXDmjubqMtTipjEsTucUJkfcwarauZWza67tKzCA2GqXPoXC9R
    IVC0l2oYfoIYe7J7g>
X-ME-Received: <xmr:YrD8Z7iSbWmJNWPasv2c-pQ0eMtffjKsBRk_kodO-KXtoWFck0tWj6u2Bn-yvQfM4gnIcqBlCxAOSY63on4cO7epLNIXnnbxXMlFydwth3po>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvudelkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucgovfgvgihtqfhnlh
    ihqddqteefjeefqddtgeculdehtddmnecujfgurhephffufffkgggtgfgjfhfvofesthej
    redtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhsse
    hpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgedttdetveefieeuteektdefvdejfeej
    ieevledvjeetvdegfeefleeihffgffdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhmpdhnsggprhgtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YrD8Z380_GvN8lwgx5a7oC3tVu8-ROlVTe1QSfYXXPgwil50pjQZ-g>
    <xmx:YrD8Z2s45FQHayzumoDBbBUPQk_zwKmrK5DtkECRyQu-H1bRe66Gbw>
    <xmx:YrD8Z-HDZn3O0Iy2UY_JZpZBEPCNtxyKqHW-VGcpUetc_39vNzV0vQ>
    <xmx:YrD8Z1Mex9xdbYe96n1o1nEEKcUUSRCiwsw4KjfMXr_qPrmXq3teKg>
    <xmx:YrD8ZwJzE-rUft4PWJqejcVP8Ob0y1TGUbsBltgebqvudX1prLyxs10T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 14 Apr 2025 02:51:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b2e88ad8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 14 Apr 2025 06:51:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] meson: wire up support for benchmarks
Date: Mon, 14 Apr 2025 08:51:10 +0200
Message-Id: <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF6w/GcC/22NQQ7CIBREr9L8tZgCgujKe5guKH7sjyk0YIim4
 e5i49Llm8y8WSFjIsxw7lZIWChTDA3ErgM32XBHRrfGIHqheikMWx6ZzZhjYCMGN802tcAab53
 y+nTQR2jTJaGn16a9Do0nys+Y3ttL4d/0J5T8v7Bw1rNRWIdGaa6tvLTanmYYaq0fzvCc67UAA
 AA=
X-Change-ID: 20250328-pks-meson-benchmarks-a8fac5f69467
In-Reply-To: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
To: git@vger.kernel.org
X-Mailer: b4 0.14.2

Hi,

this small patch series implements support for running our benchmarks in
"t/perf" via Meson. The series does not aim to replace "t/perf/run",
which is more fully-featured and allows running benchmarks against
multiple different trees. Instead, this series only allows running the
benchmarks against the current tree. Users are thus expected to continue
using "t/perf/run" for more advanced usecases.

Changes in v2:
  - Adapt "aggregate.perl" to use a "/usr/bin/env perl" shebang.
  - Link to v1: https://lore.kernel.org/r/20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      t/perf: fix benchmarks with alternate repo formats
      t/perf: use configured PERL_PATH
      t/perf: fix benchmarks with out-of-tree builds
      meson: wire up benchmarks
      meson: wire up benchmarking options

 meson.build           |  7 +++--
 meson_options.txt     |  6 ++++
 t/meson.build         | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/perf/aggregate.perl |  2 +-
 t/perf/perf-lib.sh    | 32 ++++++++++++++++++---
 t/perf/run            |  4 +--
 6 files changed, 118 insertions(+), 10 deletions(-)

Range-diff versus v1:

1:  fd734280c1d = 1:  844e8bdf81d t/perf: fix benchmarks with alternate repo formats
2:  89a011eec63 ! 2:  d950c828933 t/perf: use configured PERL_PATH
    @@ Commit message
         location.
     
         Use "PERL_PATH" to execute Perl scripts, which makes them work on more
    -    esoteric systems like NixOS.
    +    esoteric systems like NixOS. Furthermore, adapt the shebang to use
    +    env(1) to execute Perl so that users who have Perl in PATH, but in a
    +    non-standard location can execute the script directly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## t/perf/aggregate.perl ##
    +@@
    +-#!/usr/bin/perl
    ++#!/usr/bin/env perl
    + 
    + use lib '../../perl/build/lib';
    + use strict;
    +
      ## t/perf/perf-lib.sh ##
     @@ t/perf/perf-lib.sh: test_perf_ () {
      	else
3:  efecbd86cd6 = 3:  dc1adf62a86 t/perf: fix benchmarks with out-of-tree builds
4:  feeaaae3ec1 = 4:  8528a775395 meson: wire up benchmarks
5:  fc594fc3dc5 = 5:  c8a4d0b354e meson: wire up benchmarking options

---
base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250328-pks-meson-benchmarks-a8fac5f69467

