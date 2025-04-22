Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4621E2848
	for <git@vger.kernel.org>; Tue, 22 Apr 2025 06:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745304623; cv=none; b=AqQ/X3Ahkh7UFq6Bh1AHwi6JiGxVRLYEcaAKmiZlsmpncMHYNyhkr2WG/wcDu+8qemCZ13BYs44P77jVHSDe/PiNeuXqTxFDefh2ZmiIOoe6nGD+NZQo7wTZURxp75M9u3hggz4prs1V9YY03XovfIAiqhyM3opigvr4AyLLmxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745304623; c=relaxed/simple;
	bh=1Q4yqBbeva2H4VRDJBpSgpUTOK60n0YAKceMsRSh9Hg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=ALlqWjRVOB2n7C8pRVjC4Lh5wo9/ngAEgoSmR6jZEgMavN/zcNpy0r/fd9wqD6lxLW0E2h3gUAa2OhZdmaWtgYbAS9+Ub8qtVLCVIHCmuHRJYzeuDrLKFYwa+7H63vj2JrOEsTwUiMs2OQ39qwVNep6840nzYPCn9+xK5/YUDTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mMDhzBJ9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rTzcEtpk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mMDhzBJ9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rTzcEtpk"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 62622254022C;
	Tue, 22 Apr 2025 02:50:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 22 Apr 2025 02:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1745304620;
	 x=1745391020; bh=tyG4whW6cj3C31mXphXO+XiNglifpkortWe4ZCm/WrE=; b=
	mMDhzBJ90bhZS80fr28d4yTakpHkNl9zN+4e1A7f7ea5TPHMc4ye2IFF1za7oWkN
	mqZvN+lcG5DdSOokOiK6NbLI6th/5gH7qgxj3PSiVwez/A7G8qSOWZJxOyDA0UHD
	hagYDxrWKOYTiZOXyfwAuPJg9O5CdGFQcGTXPX/9dBitBYWJX2zGl6Vfd9+pOzB5
	wA/DPMY3WeIr9GZWU048NHE8l3UkgOApccC6LfPNx9VD3lIK3fWII81fnVC6M7qJ
	Nua/U2aSMFiQRutxoJUYK093LZjONI//gWxHDbWlNzNdsXoZ4vLrgOzQW1eEhjih
	Egi16bYZzFOeujHdmo6NkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1745304620; x=
	1745391020; bh=tyG4whW6cj3C31mXphXO+XiNglifpkortWe4ZCm/WrE=; b=r
	TzcEtpknj5pKoQXR9x7u3tkn6u1xwJ5Qaiw7gceK7MPYb2khcPMTmjgi2HSF2RVV
	XF67rXF+tDLfif34eNrXg1Mb67z3LEwSA55+8UOQ46dTZaaz3ZcLs5e+UHmbf5QS
	PDa+7xJ9mwYftGk0HxnmgTSNcTuVh4UPev64qCeJv8or0REJo6lpGUyQ656WHvHZ
	OLmXi26VBCXWxzDIL7BFtQfrR+Bm1/OYa5W57MqxGuBZK1uYD+qL5LVzz+Wcrfjs
	g57fMibnwCYZ7NCbKIo/4yHGUApxSBGM8xmETeyv1u0mrTN9La9vzZUWek3fC/O3
	VPr8dQuk8iruEu3EM0E4w==
X-ME-Sender: <xms:KzwHaBn0kORBWeVMRS6sMMlkxy3mvoRBlaXU77aSifkvJ9BNpBx-Zg>
    <xme:KzwHaM2ACIrvdCWNtUv8c_SYq234KyWvS6CJpsX8dhohLq3F6kHHG_Znvj6XXfFeq
    SlXtv7OPTFkVgVGwA>
X-ME-Received: <xmr:KzwHaHpds-OHHRfXDn0W7NLAPuHMEExd-tnxOgv7HF5-UsEhfRoLVctAzoDO7tx-4-AHrsX63cvZpi7bxOwDlgyL-ysabc7GIHx-PhFdbW4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvgeeftdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedt
    heefhfegffevgeegtdfhheeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhstgho
    ohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepthhoohhnsehiohhttghlrd
    gtohhm
X-ME-Proxy: <xmx:KzwHaBnVtVa9haQxRl678BTBeUaf2gX85LMP8v1ShU71ipGPjNZrmA>
    <xmx:KzwHaP31L6b-WLudl92yd8ubGwP2Ca6xqz80e6x9qc8orw4wBHZ7cg>
    <xmx:KzwHaAunj4Wlur97jErM966tLmD7BTZvOeKWluN-TBKjyNdVq--i_Q>
    <xmx:KzwHaDWT_-hrN_lQccuB7JSPpyo5_yWZbmPnan1kzn1nLAKA8uogmQ>
    <xmx:LDwHaEJHEw0SOph7Jh8Xd4eMBVel3XA2vCydb14f5C5_eW0G1l7MDdKm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Apr 2025 02:50:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 22e33b77 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 22 Apr 2025 06:50:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 0/5] meson: wire up support for benchmarks
Date: Tue, 22 Apr 2025 08:50:10 +0200
Message-Id: <20250422-pks-meson-benchmarks-v3-0-7aad68bac6fd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACI8B2gC/3XNTQrCMBAF4KuUrI3kr0nsynuIizRObZCmJZGgl
 N7daRHd6PI95n0zkwwpQCZNNZMEJeQwRgxyVxHfu3gFGi6YiWCiZlJYOt0yHSCPkbYQfT+4hIW
 znfN1pw9KG4LTKUEXHht7OmPuQ76P6bl9KXxt36Dkv8HCKaOtcB5srbl28ohn+zCQVSviKyiu/
 ggCBaakMcwyx7X5CMuyvAChQLeF9wAAAA==
X-Change-ID: 20250328-pks-meson-benchmarks-a8fac5f69467
In-Reply-To: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Christian Couder <chriscool@tuxfamily.org>
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

Changes in v3:
  - Document how to run benchmarks in "meson.build".
  - Expand the message for the commit that enables out-of-tree
    benchmarking.
  - Link to v2: https://lore.kernel.org/r/20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      t/perf: fix benchmarks with alternate repo formats
      t/perf: use configured PERL_PATH
      t/perf: fix benchmarks with out-of-tree builds
      meson: wire up benchmarks
      meson: wire up benchmarking options

 meson.build           | 13 +++++++--
 meson_options.txt     |  6 ++++
 t/meson.build         | 77 +++++++++++++++++++++++++++++++++++++++++++++++++++
 t/perf/aggregate.perl |  2 +-
 t/perf/perf-lib.sh    | 32 ++++++++++++++++++---
 t/perf/run            |  4 +--
 6 files changed, 124 insertions(+), 10 deletions(-)

Range-diff versus v2:

1:  dad3c5a3e78 = 1:  85098f35716 t/perf: fix benchmarks with alternate repo formats
2:  42284091b9c = 2:  457ea957acf t/perf: use configured PERL_PATH
3:  d03ca0c0630 ! 3:  a66bc5aaf51 t/perf: fix benchmarks with out-of-tree builds
    @@ Commit message
         assumption breaks with both CMake and Meson, where the build directory
         can be located in an arbitrary place.
     
    -    Adapt the script so that it works with out-of-tree builds. This prepares
    -    us for wiring up benchmarks in Meson.
    +    Adapt the script so that it works with out-of-tree builds. Most
    +    importantly, this requires us to figure out the location of the build
    +    directory:
    +
    +      - When running benchmarks via our Makefile the build directory is the
    +        same as the source directory. We already know to derive the test
    +        directory ("t/") via `$(pwd)/..`, which works because we chdir into
    +        "t/perf" before executing benchmarks. We can thus derive the build
    +        directory by appending another "/.." to that path.
    +
    +      - When running benchmarks via Meson the build directory is located at
    +        an arbitrary location. The build system thus has to make the path
    +        known by exporting the `GIT_BUILD_DIR` environment variable.
    +
    +    This change prepares us for wiring up benchmarks in Meson.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
4:  14945278066 ! 4:  386b960f3e1 meson: wire up benchmarks
    @@ Commit message
         tests are also accepted when running benchmarks.
     
         Note that the benchmarking target is somewhat limited because it will
    -    only run benchmarks for the current build. Other usecases, like running
    +    only run benchmarks for the current build. Other use cases, like running
         benchmarks against multiple different versions of Git, are not currently
    -    supported. Users should continue to use "t/perf/run" for those usecases.
    -    The script should get extended at one point in time to support Meson,
    -    but this is outside of the scope of this series.
    +    supported. Users should continue to use "t/perf/run" for those use
    +    cases. The script should get extended at one point in time to support
    +    Meson, but this is outside of the scope of this series.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## meson.build ##
    +@@
    + #      # Execute single test interactively such that features like `debug ()` work.
    + #      $ meson test -i --test-args='-ix' t1400-update-ref
    + #
    ++#      # Execute all benchmarks.
    ++#      $ meson test -i --benchmark
    ++#
    ++#      # Execute single benchmark.
    ++#      $ meson test -i --benchmark p0000-*
    ++#
    + #   Test execution is parallelized by default and scales with the number of
    + #   processor cores available. You can change the number of processes by passing
    + #   the `-jN` flag to `meson test`.
     @@ meson.build: git = find_program('git', dirs: program_path, required: false)
      sed = find_program('sed', dirs: program_path)
      shell = find_program('sh', dirs: program_path)
5:  101be1e8efc = 5:  cc3e771ada0 meson: wire up benchmarking options

---
base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250328-pks-meson-benchmarks-a8fac5f69467

