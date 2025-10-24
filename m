Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4E030C627
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 09:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761299513; cv=none; b=YYPXhlkGMX4KfibxRuqRba+2scXneH0rBWqM51KVaxr4mfUoP0fmDk6UDoeYMX/S0TpAL43O2HElfWMBLH8QozNZSZuluY+fkNEoDD5We0l8ZkXdqi9j3eHCE7xGnpx+z8AuEkCgWVJ1TRqfQFTE9vMlz04eimvTmhsk8/pJoEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761299513; c=relaxed/simple;
	bh=8whAuGQXaPnfdz2/fSieFQ+cbt+VRu0sxkCNcFvVxGo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=eUf0lf2TddxR60wd7jdMXlmfQwIqbLI5AJD35+QTCD1n7tsyKXfKpVJddZTMCVG6HCE5xYQYU/AsZwdwiJWwpaJS14vTWa3fsWyb+tVYBYPvW8mOBbZ1oieXJ4prV9ZADlYHNIoPX+345inA2p/NdcVyxQtm/8S5CK0A6Ad9vgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LX+2t3Ba; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cNGY4HmI; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LX+2t3Ba";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cNGY4HmI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1FF52140011F;
	Fri, 24 Oct 2025 05:51:50 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 24 Oct 2025 05:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761299510;
	 x=1761385910; bh=aVENh1goeVFkxxYc+8KiFhO34MuJWlgVOkHN7WTHLks=; b=
	LX+2t3Ba8AR9/rQvpQLp/E7lvqVsQKnFDe03h94y/N5cgNwXRZahen1OVKlrv9nd
	gfWl4ZsGc0xsM8dNjjU3MU/qv7g6ufsyMcWoSCG9dFeL9Ll626nr2c/72QazB/oI
	CQKVtahzezPH+bUnmX16Xg8T1dK94VIYxVFLgUdi1ssGenba5D5eOfowt8/oHgS/
	1ocpHD7iWo6QvkKSGH5AE2nVSoGpzzuEcXA+jP4ldpMcJgyV8rw8se3qduZ1UIcV
	f1I7wq1IXBe0ro5V8AUsA7PadCxb5lGxiZkKAVgwE/qth9UDcFnup6vUNN2s4Bzz
	+74DD70gQmpmGGh2n/80cQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761299510; x=
	1761385910; bh=aVENh1goeVFkxxYc+8KiFhO34MuJWlgVOkHN7WTHLks=; b=c
	NGY4HmIEmJ6y7JNjRz/E25rSisKpuYDxDCIhGsksp9wD7tBmgVx6HWv/YWC8o9Tz
	Iudm7sbQHvThnbqGZGs9vYWEvGYHf9yeIB7RaWor4hq9hTdfuVPgr1ZcaTbuI0uP
	nGfbsaEirMX9XXilw1V0lb1QKH8CO7Qypinwd1tRC/TGIOkf+ik+sDtrbb3+ZNog
	xcHKSpe6S5NVGV3ukzg8RZGrIEKTSvneAypt0X932V6iVaXEXd9DBSg0eOJj+OkZ
	wGrKR8a9/DNwAg0aGOdwQ5+PREh4jxMslsM/21qVKT0F75SCpX0FFD8YOLA/5hk+
	k737FcrqEkDg09zvvDwww==
X-ME-Sender: <xms:NUz7aA64W_F-r7kTuFE1Y4zKP2x9RQzs6B_vQhhFHwIsdO49EX86Mg>
    <xme:NUz7aI6ygF9r2xSCVEYYNek5tuPPnQCq286wxJpAqMKOjSsSEjW2YcUqQU9WX77zK
    goxqTuAtaaczhftNbhdWDfgrbFX4-bfqobjILggZlS9kaEa6OKFOA>
X-ME-Received: <xmr:NUz7aEeoCXc7SRWfrfzhbVsGY_h6JNlpu2zjboFWZexCtkUVclcQ7Q7nasn6jZcMv6agksnKk68fVIrSa0Mpi0fjaPmd-mGebkO1rVxqfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeeltdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffufffkgggtgfgjfhfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueeuhefhhfeitdeuhedttdeikeeftdduhedtheefhfegffevgeegtdfhheeuvden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohep
    gedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvgiivghkihgvlhhnvgifrhgvnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:NUz7aEB-4OijJwPH1DAYbigYhyxX8h8ZB7IRk7xX1QJhWhUzwOKGgg>
    <xmx:NUz7aP92RGlCLuUCcM7TQwb3i1LRYzTXgThFdJxAFrDRST4s2nhcjQ>
    <xmx:NUz7aHISungi1xbZRNuUUaVAgk5pDzK3PizXdAuKCBVg5QfSJvIkPg>
    <xmx:NUz7aAhaz_gQ0kuT1fhwMR7OGRo2g3ifdgy6Pmn1DQR0qjvPNXk6PQ>
    <xmx:Nkz7aILa6Ku7FeFZySYbkXbL1Yo45WPr7jEZ9KlAips4ro_GAC4liuqm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Oct 2025 05:51:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2536d759 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 24 Oct 2025 09:51:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/5] rust: generate bindings via cbindgen
Date: Fri, 24 Oct 2025 11:51:32 +0200
Message-Id: <20251024-b4-pks-rust-cbindgen-v2-0-4b4bd4f18490@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACVM+2gC/22NwQ6CMBBEf4Xs2TXtomA5+R+Gg6UrbIyFtEg0p
 P9uJR49vsnMmxUiB+EITbFC4EWijD4D7QrohqvvGcVlBlJ01EoZtAec7hHDM87YWfGuZ4/upOr
 asCOqDOTpFPgmr017aTMPEucxvLeXRX/Tn5DK/8JFo8JOG1tpq0pN9Tl39vKANqX0AQwP8t21A
 AAA
X-Change-ID: 20251009-b4-pks-rust-cbindgen-d80779ed2269
In-Reply-To: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
To: git@vger.kernel.org
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Ezekiel Newren <ezekielnewren@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.3

Hi,

this small patch series introduces support for cbindgen(1). This tool is
used to generate C headers from `extern "C"` blocks so that Rust code
can easily be called from C code.

For now, the only use case is to verify that our varint reimplementation
matches the C implementation. But later on this can and will be used to
call Rust-specific features from C, as well.

The topic is built on top of c54a18ef67 (The twenty-second batch,
2025-10-22) with ps/ci-rust at e509b5b8be (rust: support for Windows,
2025-10-15) merged into it.

Changes in v2:
  - Take some of the pieces from Ezekiel's "cbindgen.toml" file. I have
    not yet taken `usize_is_size_t`, as that option requires cbindgen
    v0.16.0, which is not available on Ubuntu 20.04.
  - Backfill missing jobs for GitLab CI.
  - Fix CI failures on Alma Linux 8 because cbindgen isn't available
    there.
  - Link to v1: https://lore.kernel.org/r/20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (5):
      gitlab-ci: reorder Linux job matrix to match GitHub's order
      gitlab-ci: backfill missing Linux jobs
      ci: use Debian instead of deprecated i386/ubuntu
      meson: rename Rust library target
      rust: generate bindings via cbindgen

 .github/workflows/main.yml |  3 +--
 .gitignore                 |  1 +
 .gitlab-ci.yml             | 22 ++++++++++++++--------
 Makefile                   | 14 +++++++++++---
 cbindgen.toml              | 13 +++++++++++++
 ci/install-dependencies.sh | 16 +++++++++++-----
 ci/lib.sh                  |  2 +-
 meson.build                | 25 ++++++++++++++++++++-----
 shared.mak                 |  1 +
 src/meson.build            |  2 +-
 varint.c                   |  9 +++++++++
 11 files changed, 83 insertions(+), 25 deletions(-)

Range-diff versus v1:

-:  ---------- > 1:  81e7677f3a gitlab-ci: reorder Linux job matrix to match GitHub's order
-:  ---------- > 2:  c367154007 gitlab-ci: backfill missing Linux jobs
1:  740702529c ! 3:  a1d7260326 ci: use Debian instead of deprecated i386/ubuntu
    @@ .gitlab-ci.yml: test:linux:
            - jobname: linux32
     -        image: i386/ubuntu:20.04
     +        image: i386/debian:latest
    -       - jobname: linux-meson
    -         image: ubuntu:rolling
    -         CC: gcc
    +       # A RHEL 8 compatible distro.  Supported until 2029-05-31.
    +       - jobname: almalinux-8
    +         image: almalinux:8
     
      ## ci/install-dependencies.sh ##
     @@ ci/install-dependencies.sh: fedora-*|almalinux-*)
    @@ ci/lib.sh: then
      		CI_OS_NAME=osx
      		JOBS=$(nproc)
      		;;
    --	*,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
    -+	*,alpine:*|*,fedora:*|*,ubuntu:*|*,i386/debian:*)
    +-	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/ubuntu:*)
    ++	*,almalinux:*|*,alpine:*|*,debian:*|*,fedora:*|*,ubuntu:*|*,i386/debian:*)
      		CI_OS_NAME=linux
      		JOBS=$(nproc)
      		;;
2:  ff696cfb2e = 4:  490c8a4d45 meson: rename Rust library target
3:  67a9f353df ! 5:  8b7a2469b2 rust: generate bindings via cbindgen
    @@ cbindgen.toml (new)
     @@
     +language = "C"
     +
    ++# Write a warning into the generated file.
    ++autogen_warning = "/* Warning, this file is autogenerated by cbindgen. Don't modify this manually. */"
    ++
     +# Don't include standard C headers. These are managed by "git-compat-util.h".
     +no_includes = true
     +
     +# Use plain structs instead of using typedefs.
     +style = "tag"
    ++
    ++# Match our coding style more closely.
    ++tab_width = 8
     
      ## ci/install-dependencies.sh ##
    -@@ ci/install-dependencies.sh: fedora-*|almalinux-*)
    +@@ ci/install-dependencies.sh: alpine-*)
    + 		bash cvs gnupg perl-cgi perl-dbd-sqlite perl-io-tty >/dev/null
    + 	;;
    + fedora-*|almalinux-*)
    ++	RUST_DEPS="cargo cbindgen"
    + 	case "$jobname" in
    ++	almalinux-8)
    ++		# AlmaLinux 8 does not have cbindgen, it was only added in version 9.
    ++		RUST_DEPS=;;
    + 	*-meson)
      		MESON_DEPS="meson ninja";;
      	esac
    ++
      	dnf -yq update >/dev/null &&
     -	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo >/dev/null
    -+	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS cargo cbindgen >/dev/null
    ++	dnf -yq install shadow-utils sudo make pkg-config gcc findutils diffutils perl python3 gawk gettext \
    ++		zlib-devel expat-devel openssl-devel curl-devel pcre2-devel $MESON_DEPS $RUST_DEPS >/dev/null
      	;;
      ubuntu-*|i386/debian-*|debian-*)
      	# Required so that apt doesn't wait for user input on certain packages.

---
base-commit: 8654b230d9afe1326340989dd7082997c672472e
change-id: 20251009-b4-pks-rust-cbindgen-d80779ed2269

