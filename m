Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4A01E491C
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 10:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508201; cv=none; b=U+gMH+d4stJa8t2D/AkNiXFIL/xIEO/pbTLQ0BWM9KZnT8dZvYC1Cl3jcKWiKN/xYZbUzKDY6sQFxawvLNrn5tNcqb4ZY99m84rJtTdObYHcpl9qBwisEQ5w4AB/PdwqWTMCIsxy38NCt7MOo0U8AIxGriYTqj8HMb44ZjGhpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508201; c=relaxed/simple;
	bh=WG37vefOCfN3eA95Bz+DAJ2GC08QRiqGUEvYWORU8CU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c2dgIVnJ0WXGByQuyI8DB7wgzd0UVPBOP/lzHH4P1tIUoykg+yTeoNPpQPkJiEhd9JpCIwa3JpOZF+wA8pFe6778gPs+i63/x+YeCMJ2UIgyejYG0uPiGk0Ya8a5y/xLNktR9p2y+YkUn30elfmb5wDjf6AEKIVqaG4uwmCHlnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C8aB9J/O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fuaYarcw; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C8aB9J/O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fuaYarcw"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CC4E114018D;
	Mon, 21 Oct 2024 06:56:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 21 Oct 2024 06:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1729508198;
	 x=1729594598; bh=+Rg5TCPSsgA92Jyhp595ghdebnh9pXd+CyCjyr/vtVQ=; b=
	C8aB9J/OYAi3J/RildmpGMmyha915yALTvNXaNv0FCqoX4plsEj8ZOoBldscXDj/
	W1wfspbWKxgsjK6kbYMCoQygWFwTospiZ1IWKMSbJTdt18gqUgCSDHwWWQemmgtm
	QbTMXni0DYSqFj9hIl7ZuF/y2MjMRautPmH1DziahA+ufZ/u69/NS6jvcVhBKe3V
	jd1G8OL95m0OjdyTp1teknayZO58V1x8rt4YWIwCBxxBIWfYCzLZ/fXfIRHvI5JK
	EFAx+q5afk5N6qiKa2iKcC103wpyzKZMPDJbKtLlpsHhoOHkFRljYMHBmA00knRT
	BXmqggFwu6RovfNwgvY18w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729508198; x=
	1729594598; bh=+Rg5TCPSsgA92Jyhp595ghdebnh9pXd+CyCjyr/vtVQ=; b=f
	uaYarcwfSphf95iwe7rxrLSPctAOow+C7uvYpohEqfuls+vHSxvAnLkzfHY6FLPA
	5XSd9AsILXkMtjksZopac2MiFIX8t600qj8ngRoHbFNhahmBYjcquIGaOFEhx8td
	dpZoOYHwAq8qyrtbBG++rABc47n32LkVXE63NMK6oSXVtZCSwgRRlkwD837yHmwj
	GMqiug4lrqTRl6TkBAh2yEvX2soGKpjyqNaOIy9C9F6GnCsc+9ILQZXSWNHfZ5cb
	3L89kEwFtWXY/A96ZFa5UDsAEv9dzR03sCjawv+JpuRSnkMyZKePaeUBDrYic9kJ
	01U2gtGoAWnAXK2/YcA9w==
X-ME-Sender: <xms:ZTMWZ_FVVNBSk9a7diQgHobfSZP60DNlgi3bbjgZkAQsDwKrVBkA6Q>
    <xme:ZTMWZ8U5Qfk6dL7ep8LjkBwGxh2MScOyTjFKFCW_Aay6NYFg0TFPQTpmuhRGi_iv_
    qHG26_fczNWxayv6w>
X-ME-Received: <xmr:ZTMWZxLvqMkwRtXcodVyo-UYKj8NOR4YVzmvjsvouwh4JoUUz5Wky-AV4cI3-pWWGsyueSwbBEEKy7IUGx3jeETduFVTaeeggui9Zt91iXyF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefhteetieefteehleeuheetiefgtddvhedutdefgefg
    teejhfetvddtjeegffeigeenucffohhmrghinhepphhkshdrihhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrshgvug
    gvnhhosehmihhtrdgvughupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrd
    guvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvggurhgv
    vghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggrghgrshguohhtmhgvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthho
    pegsohhnvghtsehgrhgvnhhosghlvgdrtghnrhhsrdhfrhdprhgtphhtthhopehtohhonh
    esihhothgtlhdrtghomh
X-ME-Proxy: <xmx:ZTMWZ9FiM-lWTETBEN7dkNDrxGvgJqNcbeJ4EJ7KiSsJiiZLpQ9EnA>
    <xmx:ZTMWZ1WdmAjsyVtn4qsRAhyu8qoazTmNLsDtIynmGYt7AYBqnQKK4A>
    <xmx:ZTMWZ4P3lwfXqagPQ4q8YNbLlt7dtvzvo5uKdKkgVH94RcRvtumqPA>
    <xmx:ZTMWZ02mdf1v8KMeU_1RiLzc_5jl3ztALULzO3bL-Hp5dS1PyC3SQQ>
    <xmx:ZjMWZ-Mu5RojLCf7Wo7Dp3sB3IIlh5MqZh77GEVIZQpHXMtZ1sEg2XSF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 06:56:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9ac9be5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 10:55:05 +0000 (UTC)
Date: Mon, 21 Oct 2024 12:56:30 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Taylor Blau <me@ttaylorr.com>,
	Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 0/5] t/unit-tests: improve clar platform compatibility
Message-ID: <cover.1729506329.git.ps@pks.im>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>

Hi,

this is the second version of my patch series that addresses some
platform compatibility issues with clar. Changes compared to v1:

  - I've merged the CMake fixes at [1] into this patch series to avoid
    conflicts. @Taylor, please drop that other series, which is
    "ps/cmake-clar".

  - I've fixed up the "generate-clar-decls.h" script.

  - I've updated the clar such that it includes upstreamed changes for
    improved uClibc support when we lack support for `wchar_t`.

Thanks!

Patrick

[1]: <cover.1728914219.git.ps@pks.im>

Alejandro R. Sedeño (1):
  Makefile: adjust sed command for generating "clar-decls.h"

Patrick Steinhardt (4):
  t/unit-tests: update clar to 206accb
  Makefile: extract script to generate clar declarations
  cmake: fix compilation of clar-based unit tests
  cmake: set up proper dependencies for generated clar headers

 Makefile                                   |   4 +-
 contrib/buildsystems/CMakeLists.txt        |  52 +++------
 t/unit-tests/clar/.editorconfig            |  13 +++
 t/unit-tests/clar/.github/workflows/ci.yml |  20 +++-
 t/unit-tests/clar/.gitignore               |   1 +
 t/unit-tests/clar/CMakeLists.txt           |  28 +++++
 t/unit-tests/clar/clar.c                   | 127 ++++++++++++---------
 t/unit-tests/clar/clar/print.h             |  11 +-
 t/unit-tests/clar/clar/sandbox.h           |  17 ++-
 t/unit-tests/clar/clar/summary.h           |  14 +--
 t/unit-tests/clar/test/.gitignore          |   4 -
 t/unit-tests/clar/test/CMakeLists.txt      |  39 +++++++
 t/unit-tests/clar/test/Makefile            |  39 -------
 t/unit-tests/generate-clar-decls.sh        |  16 +++
 14 files changed, 219 insertions(+), 166 deletions(-)
 create mode 100644 t/unit-tests/clar/.editorconfig
 create mode 100644 t/unit-tests/clar/.gitignore
 create mode 100644 t/unit-tests/clar/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/.gitignore
 create mode 100644 t/unit-tests/clar/test/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/Makefile
 create mode 100755 t/unit-tests/generate-clar-decls.sh

Range-diff against v1:
1:  a96fbdbb5f9 ! 1:  06145a141dd t/unit-tests: update clar to 0810a36
    @@ Metadata
     Author: Patrick Steinhardt <ps@pks.im>
     
      ## Commit message ##
    -    t/unit-tests: update clar to 0810a36
    +    t/unit-tests: update clar to 206accb
     
         Update clar from:
     
    @@ Commit message
     
         To:
     
    -        - 0810a36 (Merge pull request #107 from pks-t/pks-sunos-compatibility, 2024-10-14)
    +        - 206accb (Merge pull request #108 from pks-t/pks-uclibc-without-wchar, 2024-10-21)
     
         This update includes a bunch of fixes and improvements that we have
         discussed in Git when initial support for clar was merged:
    @@ Commit message
           - We now use the combination of mktemp(3) and mkdir(3) on SunOS, same
             as we do on NonStop.
     
    +      - We now support uClibc without support for <wchar.h>.
    +
         The most important bits here are the improved platform compatibility
    -    with Windows, OpenSUSE and SunOS.
    +    with Windows, OpenSUSE, SunOS and uClibc.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ t/unit-tests/clar/clar.c
      
      /* required for sandboxing */
      #include <sys/types.h>
    + #include <sys/stat.h>
    + 
    ++#if defined(__UCLIBC__) && ! defined(__UCLIBC_HAS_WCHAR__)
    ++	/*
    ++	 * uClibc can optionally be built without wchar support, in which case
    ++	 * the installed <wchar.h> is a stub that only defines the `whar_t`
    ++	 * type but none of the functions typically declared by it.
    ++	 */
    ++#else
    ++#	define CLAR_HAVE_WCHAR
    ++#endif
    ++
    + #ifdef _WIN32
    + #	define WIN32_LEAN_AND_MEAN
    + #	include <windows.h>
     @@
      
      #	ifndef stat
    @@ t/unit-tests/clar/clar.c: void clar__assert_equal(
      			}
      		}
      	}
    ++#ifdef CLAR_HAVE_WCHAR
    + 	else if (!strcmp("%ls", fmt)) {
    + 		const wchar_t *wcs1 = va_arg(args, const wchar_t *);
    + 		const wchar_t *wcs2 = va_arg(args, const wchar_t *);
    +@@ t/unit-tests/clar/clar.c: void clar__assert_equal(
    + 			}
    + 		}
    + 	}
     -	else if (!strcmp("%"PRIuZ, fmt) || !strcmp("%"PRIxZ, fmt)) {
     -		size_t sz1 = va_arg(args, size_t), sz2 = va_arg(args, size_t);
    ++#endif /* CLAR_HAVE_WCHAR */
     +	else if (!strcmp("%"PRIuMAX, fmt) || !strcmp("%"PRIxMAX, fmt)) {
     +		uintmax_t sz1 = va_arg(args, uintmax_t), sz2 = va_arg(args, uintmax_t);
      		is_equal = (sz1 == sz2);
2:  dda9b8e033c = 2:  17d77f36d41 Makefile: adjust sed command for generating "clar-decls.h"
-:  ----------- > 3:  c2e3fbcd853 Makefile: extract script to generate clar declarations
-:  ----------- > 4:  a30017a4d89 cmake: fix compilation of clar-based unit tests
-:  ----------- > 5:  bb005979e7e cmake: set up proper dependencies for generated clar headers

base-commit: 3a0677f8601d8937562ba14665d773fd8f2d71da
-- 
2.47.0.72.gef8ce8f3d4.dirty

