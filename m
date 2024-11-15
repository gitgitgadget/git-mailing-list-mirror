Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62A2523A
	for <git@vger.kernel.org>; Fri, 15 Nov 2024 07:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731655300; cv=none; b=XyVv+IUvxppGq7SwEEiUxDOKW1+OVBm2NA0k69ytjF5TgoqNqoWjss8o3NBX02f/XA9x1vLLEzOwI+/LWUkm3veFJWdtBDR6InD7AFhvyNUUUSUz0jKFoxX0L+mpsi+incc3axI6/jHbky2+ouzvexAGYo2KHprB7jWJh1+d3bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731655300; c=relaxed/simple;
	bh=dcd5SZrkqsfX4phbhHk2wBB3D7Jeb/7dnlDh/a4cuXw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=hQRs3MjUvqDHpMaWHUQHF87UBLfVo7FRK+WpwxUxK37NAI3b4IvRGgXQsOweQkKPolNvSbCqysHul0pKMfsvUVKFLTt3oA2p2Eo3A4kwgI2D1RFdQ/+R3uYnuPSMA+eqNzmMiBwiHnQ7lbZhSQ34iP+OjFtIQRcn8QRvpLRB4nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TLpPeste; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LrL/Qgdk; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TLpPeste";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LrL/Qgdk"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AE8641140108;
	Fri, 15 Nov 2024 02:21:34 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 15 Nov 2024 02:21:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731655294;
	 x=1731741694; bh=tK6Zbi0n6YPwbVv9mNaiIy0QrB21C8U5OVFBocxaow4=; b=
	TLpPeste/O+2Fl9z1MYH1Tuqczp+Qn7vPn1Hme/xTee+Ano+9BQ7Nxuq+dCftzPC
	6CAo0ByxvKCH+ENhYzAaCGDmDMy6+bvSFmTe43vixu1vFGYogMWTkyK+NlwoSp0n
	weSRlIz6mqScvrOIS6DXGxRGKJIPj6LZC4xbeTN5RTiGg1trfOpDZEpClyhInxI3
	d14oNhfeJcc2FsROVRSPmOx3xtGFiCNC03NiezQNcbKpNoQSpgpD3IP51LdjW6Cy
	ACranK5blQ9srLAt4d2iJXV7q0qFyigo7eEcIwg66nLrfcVDg32rBXkqLBZFP9e8
	nMxWIKDlk6NOYwEZVgJsxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731655294; x=
	1731741694; bh=tK6Zbi0n6YPwbVv9mNaiIy0QrB21C8U5OVFBocxaow4=; b=L
	rL/Qgdkef/vfFKH3MDQH41f+wtIJzYSfDarz2+2bXTmWWvmDGPOlsRS4qVOU2utu
	xJu2orEjdwRkqwEJIK9+hg7Z1bZ25qdcHSO5zMVm98VgQveL+Sf/Re3TLI6DguAM
	ZVgFmAg0zAqdoutDJKDsqhpuyzPDYNSVYHWIePp7cucpgZ6jPnqVGuk2qzZdoQ13
	oYlnjcMrVXOP+R+Gv8p7ganFsdUVzZj1e/jhmnctoruMFzTlAom6vQ8CgB0VUEsr
	ggdp4ZtvNy6McRrBU5apwyz31N5/3C+9xsKzH1sL4cpyFEBi/1x5qK/3TsekaZ7v
	1J5KD1LVX/Ca4eNdeG+mQ==
X-ME-Sender: <xms:ffY2Z3XoAacP2-483dhHZzYCHCRBRYZ06hQcX5fPnRVbMla5ZKOppw>
    <xme:ffY2Z_kze9xY2PMUEdlH20Z5GblsN-Gynb0SCYsqZ5_IPZDlYkqQvboqEPA2Nt4JJ
    6vqSfOp_mBJt2CDOA>
X-ME-Received: <xmr:ffY2ZzYvE2AdR6u6dDE4dqknk6QNYz3nrs4DdlKNbH4fdy2mwzBR0xdRDBBsUWsAKVWRlSW72sNWz7tnau5_VM-o9idk7Bb1t2mPi7jvtz0r9TlK0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpefgudffgedvkeetieefgeehieeiuedvtdelteehgeel
    udeffefhtdehveegjeevheenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhrtgdrih
    hnnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhes
    phgvfhhfrdhnvghtpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomhdprhgtphhtthhopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
X-ME-Proxy: <xmx:fvY2ZyUKQcOgmhulPPrPIvaJwow2BtyfkuwB8I_8nVO0F8nnMeL0DQ>
    <xmx:fvY2ZxlULj71wI3RruJqgQSAB6dzSv3VBDuTEnT3dpLle2NK8qUlZg>
    <xmx:fvY2Z_fgOs9Rvru-WSeRvKuyG9GmL0Lty-dDKA5VqLphCMayt4A3MA>
    <xmx:fvY2Z7FEgSopUS0-nuEhLgsS9uAnwyt0aHvWZFYTthIj6-wrsWL6aQ>
    <xmx:fvY2Z6ceJjKweXSNtq9rzQKAAK5Kwu1bp45scRDxj6iEsWo8uwy8Tnig>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 02:21:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0bfb7ef5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 15 Nov 2024 07:20:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC v7 00/22] Modernize the build system
Date: Fri, 15 Nov 2024 08:21:12 +0100
Message-Id: <20241115-pks-meson-v7-0-47ec19b780b2@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGn2NmcC/23QTQrCMBAF4KtI1qZk8jNJXAmCB3ArLmyNGsS2J
 BKU0rsbshAqWc7M995iJhJd8C6SzWoiwSUf/dDnQa9XpLuf+5uj/pJnwhmXAMDp+Ij06eLQU6t
 aRNUxc2VIsh+Du/p36TqSw35HTnl59/E1hE/pT1BO3ZBcaEBzbQwAyubmX80Yt7m58c+SSnwpj
 TQKhK1JsZSWK8k0q0n5J7UGZKom1UIKEEJZYWoSi6w8JyFlFKVpBbMWDde/2DzPXwXxVQF2AQA
 A
X-Change-ID: 20241112-pks-meson-95b665c08f06
In-Reply-To: <cover.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Hi,

this patch series modernizes our build infrasturcture. It refactors
various parts of it to make it possible to perform out-of-tree builds in
theory.

The series then continues to wire up Meson as a proposed alternative as
a modern replacement for our current build systems. It provides better
integration into IDEs than our Makefiles, better usability than our
Makefiles and CMake, better configuration and discoverability thereof
than autoconf and CMake (which is of course my personal opinion).

The intent is to have Meson replace autoconf, which is mostly unused and
broken. Eventually, the plan would to also replace CMake and our
Makefiles in case we figure out that this replacement is indeed a net
benefit for the project, but all of this would happen over the course of
multiple releases.

Changes in v7:

  - Fix overriding TEST_OUTPUT_DIRECTORY via the environment.

  - Rework generation of version information. GIT-VERSION-GEN now knows
    to replace @PLACEHOLDERS@ in other files, and this gets used across
    Makefiles, CMake and Meson now. This makes us properly rebuild when
    the version info changes and fixes the version numbers in "git.rc".

  - The CMake build instructions are now doing a proper out-of-tree
    build.

  - We now generate and install gitweb.js, which gets built via a new
    "generate-gitweb-js.sh".

  - Some improvements to the Meson documentation.

  - Wire up DEVELOPER=1 style warnings via `--warnlevel 2` and above.

  - Wire up sanitizers properly.

  - Provide a new "regex" option to disable the platform-provided
    version of regcomp() et al.

  - Stop installing git-http-backend into bindir.

  - Install Perl scripts into libexecdir.

  - Install git-cvsserver into bindir and libexecdir.

  - Install template directory into datadir.

As before, the tip of this patch series catches up with what is
happening in "seen". If you want to test it without topics in "seen" you
have to revert it.

Links to previous versions:

  - Link to v1: https://lore.kernel.org/r/cover.1727881164.git.ps@pks.im
  - Link to v2: https://lore.kernel.org/r/cover.1728485139.git.ps@pks.im
  - Link to v3: https://lore.kernel.org/r/cover.1729254070.git.ps@pks.im
  - Link to v4: https://lore.kernel.org/r/cover.1729771605.git.ps@pks.im
  - Link to v5: https://lore.kernel.org/r/cover.1731335938.git.ps@pks.im
  - Link to v6: https://lore.kernel.org/r/20241112-pks-meson-v6-0-648b30996827@pks.im

Thanks!

Patrick

To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc: Taylor Blau <me@ttaylorr.com>
Cc: David Aguilar <davvid@gmail.com>
Cc: Jeff King <peff@peff.net>
Cc: Christian Couder <christian.couder@gmail.com>

Patrick Steinhardt (22):
      Makefile: use common template for GIT-BUILD-OPTIONS
      Makefile: consistently use @PLACEHOLDER@ to substitute
      Makefile: refactor GIT-VERSION-GEN to be reusable
      Makefile: propagate Git version via generated header
      Makefile: generate "git.rc" via GIT-VERSION-GEN
      Makefile: consistently use PERL_PATH
      Makefile: extract script to massage Perl scripts
      Makefile: use "generate-perl.sh" to massage Perl library
      Makefile: extract script to massage Shell scripts
      Makefile: extract script to generate gitweb.cgi
      Makefile: extract script to generate gitweb.js
      Makefile: refactor generators to be PWD-independent
      Makefile: allow "bin-wrappers/" directory to exist
      Makefile: simplify building of templates
      Documentation: allow sourcing generated includes from separate dir
      Documentation: teach "cmd-list.perl" about out-of-tree builds
      Documentation: extract script to generate a list of mergetools
      t: better support for out-of-tree builds
      t: allow overriding build dir
      Documentation: add comparison of build systems
      Introduce support for the Meson build system
      meson: fix conflicts with in-flight topics

 .gitignore                                         |    3 +-
 Documentation/CodingGuidelines                     |    2 +-
 Documentation/Makefile                             |   28 +-
 Documentation/build-docdep.perl                    |    2 +
 Documentation/cmd-list.perl                        |   23 +-
 Documentation/config/diff.txt                      |    2 +-
 Documentation/config/merge.txt                     |    2 +-
 Documentation/generate-mergetool-list.sh           |   17 +
 Documentation/git.txt                              |   24 +-
 Documentation/meson.build                          |  317 ++++
 Documentation/technical/build-systems.txt          |  224 +++
 GIT-BUILD-OPTIONS.in                               |   47 +
 GIT-VERSION-FILE.in                                |    1 +
 GIT-VERSION-GEN                                    |   62 +-
 Makefile                                           |  232 +--
 bin-wrappers/.gitignore                            |    9 +
 bin-wrappers/meson.build                           |   28 +
 bin-wrappers/wrap-for-bin.sh                       |   37 +
 ci/test-documentation.sh                           |    2 +-
 configure.ac                                       |    2 +-
 contrib/buildsystems/CMakeLists.txt                |  287 +--
 contrib/buildsystems/git-version.in                |    1 +
 contrib/completion/meson.build                     |    8 +
 contrib/meson.build                                |    1 +
 generate-cmdlist.sh                                |   42 +-
 generate-configlist.sh                             |   20 +-
 generate-hooklist.sh                               |   15 +-
 generate-perl.sh                                   |   37 +
 generate-script.sh                                 |   34 +
 git-cvsserver.perl                                 |    2 +-
 git-instaweb.sh                                    |    8 +-
 git-request-pull.sh                                |    2 +-
 git-send-email.perl                                |    2 +-
 git-sh-i18n.sh                                     |    6 +-
 git-sh-setup.sh                                    |    6 +-
 git-svn.perl                                       |    2 +-
 git.rc => git.rc.in                                |    6 +-
 gitk-git/po/vi.po                                  |    2 +-
 gitweb/GITWEB-BUILD-OPTIONS.in                     |   24 +
 gitweb/Makefile                                    |   62 +-
 gitweb/generate-gitweb-cgi.sh                      |   47 +
 gitweb/generate-gitweb-js.sh                       |   12 +
 gitweb/gitweb.perl                                 |   44 +-
 gitweb/meson.build                                 |   79 +
 meson.build                                        | 1857 ++++++++++++++++++++
 meson_options.txt                                  |   83 +
 perl/FromCPAN/Mail/meson.build                     |    7 +
 perl/FromCPAN/meson.build                          |    9 +
 perl/Git/I18N.pm                                   |    6 +-
 perl/Git/LoadCPAN.pm                               |    6 +-
 perl/Git/LoadCPAN/Mail/meson.build                 |    7 +
 perl/Git/LoadCPAN/meson.build                      |    9 +
 perl/Git/SVN/Memoize/meson.build                   |    7 +
 perl/Git/SVN/meson.build                           |   20 +
 perl/Git/meson.build                               |   18 +
 perl/header_templates/fixed_prefix.template.pl     |    2 +-
 perl/header_templates/runtime_prefix.template.pl   |    8 +-
 perl/meson.build                                   |   12 +
 po/meson.build                                     |   27 +
 subprojects/.gitignore                             |    1 +
 subprojects/curl.wrap                              |   13 +
 subprojects/expat.wrap                             |   13 +
 subprojects/openssl.wrap                           |   15 +
 subprojects/pcre2.wrap                             |   16 +
 subprojects/zlib.wrap                              |   13 +
 t/helper/meson.build                               |   93 +
 t/lib-gettext.sh                                   |    4 +-
 t/meson.build                                      | 1107 ++++++++++++
 t/t7609-mergetool--lib.sh                          |    2 +-
 t/test-lib.sh                                      |   31 +-
 templates/Makefile                                 |   39 +-
 templates/branches--                               |    1 -
 templates/{this--description => description}       |    0
 .../applypatch-msg.sample}                         |    0
 .../commit-msg.sample}                             |    0
 .../fsmonitor-watchman.sample}                     |    0
 templates/hooks/meson.build                        |   26 +
 .../post-update.sample}                            |    0
 .../pre-applypatch.sample}                         |    0
 .../pre-commit.sample}                             |    0
 .../pre-merge-commit.sample}                       |    0
 .../pre-push.sample}                               |    0
 .../pre-rebase.sample}                             |    0
 .../pre-receive.sample}                            |    0
 .../prepare-commit-msg.sample}                     |    0
 .../push-to-checkout.sample}                       |    0
 .../sendemail-validate.sample}                     |    0
 .../{hooks--update.sample => hooks/update.sample}  |    0
 templates/{info--exclude => info/exclude}          |    0
 templates/info/meson.build                         |    7 +
 templates/meson.build                              |   15 +
 unimplemented.sh                                   |    2 +-
 version-def.h.in                                   |    8 +
 version.c                                          |    1 +
 wrap-for-bin.sh                                    |   36 -
 95 files changed, 4848 insertions(+), 486 deletions(-)

Range-diff versus v6:

 1:  7c89e63ea5 !  1:  61d8677718 Makefile: use common template for GIT-BUILD-OPTIONS
    @@ Commit message
         While at it, remove the `SUPPORTS_SIMPLE_IPC` variable that we only set
         up in CMake as it isn't used anywhere.
     
    -    Note that this change requires us to move around the setup of
    -    TEST_OUTPUT_DIRECTORY in "test-lib.sh" such that it comes after sourcing
    -    the "GIT-BUILD-OPTIONS" file. This is the only instance I could find
    -    where we rely on ordering on variables.
    +    This change requires us to adapt the setup of TEST_OUTPUT_DIRECTORY in
    +    "test-lib.sh" such that it does not get overwritten after sourcing when
    +    it has been set up via the environment. This is the only instance I
    +    could find where we rely on ordering on variables.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ contrib/buildsystems/CMakeLists.txt: if(NOT PYTHON_TESTS)
     -file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PYTHON='${NO_PYTHON}'\n")
     -file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "SUPPORTS_SIMPLE_IPC='${SUPPORTS_SIMPLE_IPC}'\n")
     +file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_CONSUME)
    -+string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" git_build_options "${git_build_options}")
    -+string(REPLACE "@TEST_SHELL_PATH@" "${TEST_SHELL_PATH}" git_build_options "${git_build_options}")
    -+string(REPLACE "@PERL_PATH@" "${PERL_PATH}" git_build_options "${git_build_options}")
    -+string(REPLACE "@DIFF@" "${DIFF}" git_build_options "${git_build_options}")
    -+string(REPLACE "@PYTHON_PATH@" "${PYTHON_PATH}" git_build_options "${git_build_options}")
    -+string(REPLACE "@TAR@" "${TAR}" git_build_options "${git_build_options}")
    ++string(REPLACE "@SHELL_PATH@" "'${SHELL_PATH}'" git_build_options "${git_build_options}")
    ++string(REPLACE "@TEST_SHELL_PATH@" "'${TEST_SHELL_PATH}'" git_build_options "${git_build_options}")
    ++string(REPLACE "@PERL_PATH@" "'${PERL_PATH}'" git_build_options "${git_build_options}")
    ++string(REPLACE "@DIFF@" "'${DIFF}'" git_build_options "${git_build_options}")
    ++string(REPLACE "@PYTHON_PATH@" "'${PYTHON_PATH}'" git_build_options "${git_build_options}")
    ++string(REPLACE "@TAR@" "'${TAR}'" git_build_options "${git_build_options}")
     +string(REPLACE "@NO_CURL@" "${NO_CURL}" git_build_options "${git_build_options}")
     +string(REPLACE "@NO_ICONV@" "${NO_ICONV}" git_build_options "${git_build_options}")
     +string(REPLACE "@NO_EXPAT@" "${NO_EXPAT}" git_build_options "${git_build_options}")
    @@ contrib/buildsystems/CMakeLists.txt: if(NOT PYTHON_TESTS)
     +string(REPLACE "@NO_PYTHON@" "${NO_PYTHON}" git_build_options "${git_build_options}")
     +string(REPLACE "@NO_REGEX@" "" git_build_options "${git_build_options}")
     +string(REPLACE "@NO_UNIX_SOCKETS@" "${NO_UNIX_SOCKETS}" git_build_options "${git_build_options}")
    -+string(REPLACE "@PAGER_ENV@" "${PAGER_ENV}" git_build_options "${git_build_options}")
    ++string(REPLACE "@PAGER_ENV@" "'${PAGER_ENV}'" git_build_options "${git_build_options}")
     +string(REPLACE "@SANITIZE_LEAK@" "" git_build_options "${git_build_options}")
     +string(REPLACE "@SANITIZE_ADDRESS@" "" git_build_options "${git_build_options}")
     +string(REPLACE "@X@" "${EXE_EXTENSION}" git_build_options "${git_build_options}")
    @@ contrib/buildsystems/CMakeLists.txt: if(NOT PYTHON_TESTS)
     +string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
     +string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
     +string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
    -+string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
    ++string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
      if(USE_VCPKG)
     -	file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
     +	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
    @@ t/test-lib.sh: else
      GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
      if test "$TEST_DIRECTORY" = "$GIT_BUILD_DIR"
      then
    +@@ t/test-lib.sh: export LSAN_OPTIONS
    + prepend_var UBSAN_OPTIONS : $GIT_SAN_OPTIONS
    + export UBSAN_OPTIONS
    + 
    ++# The TEST_OUTPUT_DIRECTORY will be overwritten via GIT-BUILD-OPTIONS. So in
    ++# case the caller has manually set up this variable via the environment we must
    ++# make sure to not overwrite that value, and thus we save it into
    ++# TEST_OUTPUT_DIRECTORY_OVERRIDE here.
    ++if test -n "$TEST_OUTPUT_DIRECTORY" && test -z "$TEST_OUTPUT_DIRECTORY_OVERRIDE"
    ++then
    ++	TEST_OUTPUT_DIRECTORY_OVERRIDE=$TEST_OUTPUT_DIRECTORY
    ++fi
    ++
    + if test ! -f "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
    + then
    + 	echo >&2 'error: GIT-BUILD-OPTIONS missing (has Git been built?).'
     @@ t/test-lib.sh: fi
      . "$GIT_BUILD_DIR"/GIT-BUILD-OPTIONS
      export PERL_PATH SHELL_PATH
 2:  ebddce640a =  2:  749b5d29e5 Makefile: consistently use @PLACEHOLDER@ to substitute
 -:  ---------- >  3:  af6b00a7b7 Makefile: refactor GIT-VERSION-GEN to be reusable
 -:  ---------- >  4:  666c1d6cf4 Makefile: propagate Git version via generated header
 -:  ---------- >  5:  0358fa0574 Makefile: generate "git.rc" via GIT-VERSION-GEN
 3:  2b8f7520bf =  6:  d99407979a Makefile: consistently use PERL_PATH
 4:  4545c43196 !  7:  47e0291d3e Makefile: extract script to massage Perl scripts
    @@ Makefile: endif
     -	    $< >$@+ && \
     -	chmod +x $@+ && \
     +$(SCRIPT_PERL_GEN): % : %.perl generate-perl.sh GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
    -+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION) GIT-PERL-HEADER "$<" "$@+" && \
    ++	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@+" && \
      	mv $@+ $@
      
      PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
    @@ contrib/buildsystems/CMakeLists.txt: foreach(script ${git_shell_scripts})
      string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
      string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
     +file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
    ++
    ++add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
    ++	COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
    ++		"${CMAKE_SOURCE_DIR}"
    ++		"${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE.in"
    ++		"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
    ++	DEPENDS ${SH_EXE} "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
    ++		"${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE.in"
    ++	VERBATIM)
      
      foreach(script ${git_perl_scripts})
     -	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
    @@ contrib/buildsystems/CMakeLists.txt: foreach(script ${git_shell_scripts})
     +	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
     +		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
     +			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
    -+			"${PROJECT_VERSION}"
    ++			"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
     +			"${CMAKE_BINARY_DIR}/PERL-HEADER"
     +			"${CMAKE_SOURCE_DIR}/${script}"
     +			"${CMAKE_BINARY_DIR}/${perl_gen_path}"
     +		DEPENDS "${CMAKE_SOURCE_DIR}/generate-perl.sh"
     +			"${CMAKE_SOURCE_DIR}/${script}"
    ++			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
    ++			"${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
     +		VERBATIM)
     +	list(APPEND perl_gen ${CMAKE_BINARY_DIR}/${perl_gen_path})
      endforeach()
    @@ generate-perl.sh (new)
     +
     +if test $# -ne 5
     +then
    -+	echo "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION> <PERL_HEADER> <INPUT> <OUTPUT>" >&2
    ++	echo "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION_FILE> <PERL_HEADER> <INPUT> <OUTPUT>" >&2
     +	exit 1
     +fi
     +
     +GIT_BUILD_OPTIONS="$1"
    -+GIT_VERSION="$2"
    ++GIT_VERSION_FILE="$2"
     +PERL_HEADER="$3"
     +INPUT="$4"
     +OUTPUT="$5"
     +
     +. "$GIT_BUILD_OPTIONS"
    ++. "$GIT_VERSION_FILE"
     +
     +sed -e '1{' \
     +    -e "	s|#!.*perl|#!$PERL_PATH|" \
 5:  50948f7020 !  8:  c3f9a22ae4 Makefile: use "generate-perl.sh" to massage Perl library
    @@ Makefile: endif
      endif
      
     -perl/build/lib/%.pm: perl/%.pm GIT-PERL-DEFINES
    -+perl/build/lib/%.pm: perl/%.pm generate-perl.sh GIT-BUILD-OPTIONS GIT-PERL-DEFINES
    ++perl/build/lib/%.pm: perl/%.pm generate-perl.sh GIT-BUILD-OPTIONS GIT-VERSION-FILE GIT-PERL-DEFINES
      	$(call mkdir_p_parent_template)
     -	$(QUIET_GEN) \
     -	sed -e 's|@LOCALEDIR@|$(perl_localedir_SQ)|g' \
     -	    -e 's|@NO_GETTEXT@|$(NO_GETTEXT_SQ)|g' \
     -	    -e 's|@NO_PERL_CPAN_FALLBACKS@|$(NO_PERL_CPAN_FALLBACKS_SQ)|g' \
     -	< $< > $@
    -+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION) GIT-PERL-HEADER "$<" "$@"
    ++	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS ./GIT-VERSION-FILE GIT-PERL-HEADER "$<" "$@"
      
      perl/build/man/man3/Git.3pm: perl/Git.pm
      	$(call mkdir_p_parent_template)
    @@ contrib/buildsystems/CMakeLists.txt: endforeach()
      
      #create perl header
      file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
    -@@ contrib/buildsystems/CMakeLists.txt: string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
    - string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
    - file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
    +@@ contrib/buildsystems/CMakeLists.txt: add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/GIT-VERSION-FILE"
    + 		"${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE.in"
    + 	VERBATIM)
      
     -foreach(script ${git_perl_scripts})
     +foreach(script ${git_perl_scripts} ${perl_modules})
    @@ contrib/buildsystems/CMakeLists.txt: file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py
      file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
      list(TRANSFORM templates REPLACE "${CMAKE_SOURCE_DIR}/templates/" "")
     @@ contrib/buildsystems/CMakeLists.txt: file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-BUILD-OPTIONS.in git_build_options NEWLINE_
    - string(REPLACE "@SHELL_PATH@" "${SHELL_PATH}" git_build_options "${git_build_options}")
    - string(REPLACE "@TEST_SHELL_PATH@" "${TEST_SHELL_PATH}" git_build_options "${git_build_options}")
    - string(REPLACE "@PERL_PATH@" "${PERL_PATH}" git_build_options "${git_build_options}")
    -+string(REPLACE "@PERL_LOCALEDIR@" "${LOCALEDIR}" git_build_options "${git_build_options}")
    + string(REPLACE "@SHELL_PATH@" "'${SHELL_PATH}'" git_build_options "${git_build_options}")
    + string(REPLACE "@TEST_SHELL_PATH@" "'${TEST_SHELL_PATH}'" git_build_options "${git_build_options}")
    + string(REPLACE "@PERL_PATH@" "'${PERL_PATH}'" git_build_options "${git_build_options}")
    ++string(REPLACE "@PERL_LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
     +string(REPLACE "@NO_PERL_CPAN_FALLBACKS@" "" git_build_options "${git_build_options}")
    - string(REPLACE "@DIFF@" "${DIFF}" git_build_options "${git_build_options}")
    - string(REPLACE "@PYTHON_PATH@" "${PYTHON_PATH}" git_build_options "${git_build_options}")
    - string(REPLACE "@TAR@" "${TAR}" git_build_options "${git_build_options}")
    + string(REPLACE "@DIFF@" "'${DIFF}'" git_build_options "${git_build_options}")
    + string(REPLACE "@PYTHON_PATH@" "'${PYTHON_PATH}'" git_build_options "${git_build_options}")
    + string(REPLACE "@TAR@" "'${TAR}'" git_build_options "${git_build_options}")
     
      ## generate-perl.sh ##
     @@ generate-perl.sh: OUTPUT="$5"
    - . "$GIT_BUILD_OPTIONS"
    + . "$GIT_VERSION_FILE"
      
      sed -e '1{' \
     +    -e "	/^#!.*perl/!b" \
 6:  2340c63def !  9:  23f094d0ba Makefile: extract script to massage Shell scripts
    @@ Makefile: GIT-SCRIPT-DEFINES: FORCE
     +	$(QUIET_GEN)./generate-script.sh "$<" "$@+" ./GIT-BUILD-OPTIONS && \
      	mv $@+ $@
      
    - git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
    + git.rc: git.rc.in GIT-VERSION-GEN GIT-VERSION-FILE
     @@ Makefile: GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
      perllibdir:
      	@echo '$(perllibdir_SQ)'
    @@ contrib/buildsystems/CMakeLists.txt: set(git_shell_scripts
     @@ contrib/buildsystems/CMakeLists.txt: string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_optio
      string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
      string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
    - string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
    -+string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" git_build_options "${git_build_options}")
    + string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
    ++string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
     +string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
    -+string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" git_build_options "${git_build_options}")
    ++string(REPLACE "@LOCALEDIR@" "'${LOCALEDIR}'" git_build_options "${git_build_options}")
     +string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
      if(USE_VCPKG)
      	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 7:  68c0dad962 ! 10:  457a42ef55 Makefile: extract script to generate gitweb.cgi
    @@ gitweb/GITWEB-BUILD-OPTIONS.in (new)
     +PERL_PATH=@PERL_PATH@
     +JSMIN=@JSMIN@
     +CSSMIN=@CSSMIN@
    -+GIT_VERSION=@GIT_VERSION@
     +GIT_BINDIR=@GIT_BINDIR@
     +GITWEB_CONFIG=@GITWEB_CONFIG@
     +GITWEB_CONFIG_SYSTEM=@GITWEB_CONFIG_SYSTEM@
    @@ gitweb/Makefile: GITWEB_JSLIB_FILES += static/js/javascript-detection.js
     +	     $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS.in >"$@+"
      	@cmp -s $@+ $@ && rm -f $@+ || mv -f $@+ $@
      
    -+$(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)generate-gitweb.sh
    ++$(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)generate-gitweb-cgi.sh
      $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)GITWEB-BUILD-OPTIONS
    ++$(MAK_DIR_GITWEB)gitweb.cgi: GIT-VERSION-FILE
      $(MAK_DIR_GITWEB)gitweb.cgi: $(MAK_DIR_GITWEB)gitweb.perl
      	$(QUIET_GEN)$(RM) $@ $@+ && \
     -	sed -e '1s|#!.*perl|#!$(PERL_PATH_SQ)|' \
     -		$(GITWEB_REPLACE) $< >$@+ && \
     -	chmod +x $@+ && \
    -+	$(MAK_DIR_GITWEB)generate-gitweb.sh $(MAK_DIR_GITWEB)/GITWEB-BUILD-OPTIONS $< $@+ && \
    ++	$(MAK_DIR_GITWEB)generate-gitweb-cgi.sh $(MAK_DIR_GITWEB)/GITWEB-BUILD-OPTIONS ./GIT-VERSION-FILE $< $@+ && \
      	mv $@+ $@
      
      $(MAK_DIR_GITWEB)static/gitweb.js: $(addprefix $(MAK_DIR_GITWEB),$(GITWEB_JSLIB_FILES))
     
    - ## gitweb/generate-gitweb.sh (new) ##
    + ## gitweb/generate-gitweb-cgi.sh (new) ##
     @@
     +#!/bin/sh
     +
     +set -e
     +
    -+if test $# -ne 3
    ++if test $# -ne 4
     +then
    -+	echo "USAGE: $0 <GITWEB-BUILD-OPTIONS> <INPUT> <OUTPUT>" >&2
    ++	echo "USAGE: $0 <GITWEB-BUILD-OPTIONS> <GIT-VERSION-FILE> <INPUT> <OUTPUT>" >&2
     +	exit 1
     +fi
     +
     +GITWEB_BUILD_OPTIONS="$1"
    -+INPUT="$2"
    -+OUTPUT="$3"
    ++GIT_VERSION_FILE="$2"
    ++INPUT="$3"
    ++OUTPUT="$4"
     +
     +. "$GITWEB_BUILD_OPTIONS"
    ++. "$GIT_VERSION_FILE"
     +
     +sed -e "1s|#!/usr/bin/perl|#!$PERL_PATH|" \
     +    -e "s|@PERL_PATH@|$PERL_PATH|" \
 8:  f2735c317c <  -:  ---------- Makefile: refactor GIT-VERSION-GEN to be reusable
 -:  ---------- > 11:  a9842baae7 Makefile: extract script to generate gitweb.js
 9:  e4fa8b74e8 = 12:  eb8c8eaf71 Makefile: refactor generators to be PWD-independent
10:  b1bbebf30d = 13:  8d74f3adde Makefile: allow "bin-wrappers/" directory to exist
11:  bee17be2a2 ! 14:  cda66f5f07 Makefile: simplify building of templates
    @@ contrib/buildsystems/CMakeLists.txt: include_directories(${CMAKE_BINARY_DIR})
      
      list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
      list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    +@@ contrib/buildsystems/CMakeLists.txt: list(APPEND libgit_SOURCES "${CMAKE_BINARY_DIR}/version-def.h")
      add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
      
      #libxdiff
12:  b4cea04721 = 15:  d763b2c7bb Documentation: allow sourcing generated includes from separate dir
13:  56ba18676e = 16:  c3b0ce492c Documentation: teach "cmd-list.perl" about out-of-tree builds
14:  448f3aac9b = 17:  432cc11dea Documentation: extract script to generate a list of mergetools
15:  dd4ceab0d8 ! 18:  436f8d7dcb t: better support for out-of-tree builds
    @@ contrib/buildsystems/CMakeLists.txt: string(REPLACE "@GIT_PERF_MAKE_COMMAND@" ""
      string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
      string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
      string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
    -+string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" git_build_options "${git_build_options}")
    -+string(REPLACE "@GIT_TEST_POPATH@" "${CMAKE_BINARY_DIR}/po" git_build_options "${git_build_options}")
    -+string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "${CMAKE_BINARY_DIR}/templates/blt" git_build_options "${git_build_options}")
    -+string(REPLACE "@GIT_TEST_GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" git_build_options "${git_build_options}")
    -+string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
    - string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
    - string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" git_build_options "${git_build_options}")
    ++string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "'${CMAKE_BINARY_DIR}/po/build/locale'" git_build_options "${git_build_options}")
    ++string(REPLACE "@GIT_TEST_POPATH@" "'${CMAKE_BINARY_DIR}/po'" git_build_options "${git_build_options}")
    ++string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "'${CMAKE_BINARY_DIR}/templates/blt'" git_build_options "${git_build_options}")
    ++string(REPLACE "@GIT_TEST_GITPERLLIB@" "'${CMAKE_BINARY_DIR}/perl/build/lib'" git_build_options "${git_build_options}")
    ++string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
    + string(REPLACE "@RUNTIME_PREFIX@" "'${RUNTIME_PREFIX}'" git_build_options "${git_build_options}")
    + string(REPLACE "@GITWEBDIR@" "'${GITWEBDIR}'" git_build_options "${git_build_options}")
      string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
     
      ## t/lib-gettext.sh ##
16:  c1ac988650 = 19:  eba2e18294 t: allow overriding build dir
17:  fd053fe4a9 = 20:  0abdac86b1 Documentation: add comparison of build systems
18:  4c10499220 ! 21:  30055908e5 Introduce support for the Meson build system
    @@ gitweb/meson.build (new)
     +gitweb_config.set_quoted('PERL_PATH', perl.full_path())
     +gitweb_config.set_quoted('CSSMIN', '')
     +gitweb_config.set_quoted('JSMIN', '')
    -+gitweb_config.set_quoted('GIT_VERSION', git_version)
     +gitweb_config.set_quoted('GIT_BINDIR', get_option('prefix') / get_option('bindir'))
     +gitweb_config.set_quoted('GITWEB_CONFIG', get_option('gitweb_config'))
     +gitweb_config.set_quoted('GITWEB_CONFIG_SYSTEM', get_option('gitweb_config_system'))
    @@ gitweb/meson.build (new)
     +  output: 'gitweb.cgi',
     +  command: [
     +    shell,
    -+    meson.current_source_dir() / 'generate-gitweb.sh',
    ++    meson.current_source_dir() / 'generate-gitweb-cgi.sh',
     +    meson.current_build_dir() / 'GITWEB-BUILD-OPTIONS',
    ++    git_version_file.full_path(),
     +    '@INPUT@',
     +    '@OUTPUT@',
     +  ],
     +  install: true,
     +  install_dir: get_option('datadir') / 'gitweb',
    ++  depends: [git_version_file],
    ++)
    ++
    ++javascript_files = [
    ++  meson.current_source_dir() / 'static/js/adjust-timezone.js',
    ++  meson.current_source_dir() / 'static/js/blame_incremental.js',
    ++  meson.current_source_dir() / 'static/js/javascript-detection.js',
    ++  meson.current_source_dir() / 'static/js/lib/common-lib.js',
    ++  meson.current_source_dir() / 'static/js/lib/cookies.js',
    ++  meson.current_source_dir() / 'static/js/lib/datetime.js',
    ++]
    ++
    ++test_dependencies += custom_target(
    ++  input: javascript_files,
    ++  output: 'gitweb.js',
    ++  command: [
    ++    shell,
    ++    meson.current_source_dir() / 'generate-gitweb-js.sh',
    ++    '@OUTPUT@',
    ++  ] + javascript_files,
    ++  install: true,
    ++  install_dir: get_option('datadir') / 'gitweb/static',
     +)
     +
     +foreach asset : [
     +  'static/git-favicon.png',
     +  'static/git-logo.png',
     +  'static/gitweb.css',
    -+  'static/js/adjust-timezone.js',
    -+  'static/js/blame_incremental.js',
    -+  'static/js/javascript-detection.js',
    -+  'static/js/lib/common-lib.js',
    -+  'static/js/lib/cookies.js',
    -+  'static/js/lib/datetime.js',
     +]
     +  fs.copyfile(asset,
     +    install: true,
    @@ meson.build (new)
     +# Configuration
     +# =============
     +#
    -+# The exact configuration of Git is determined when setting up the Git
    -+# directory. Unless told otherwise, Meson will automatically detect the
    -+# availability of various bits and pieces. There are two different kinds of
    -+# options that can be used to further tweak the build:
    ++# The exact configuration of Git is determined when setting up the build
    ++# directory via `meson setup`. Unless told otherwise, Meson will automatically
    ++# detect the availability of various bits and pieces. There are two different
    ++# kinds of options that can be used to further tweak the build:
     +#
     +#   - Built-in options provided by Meson.
     +#
    @@ meson.build (new)
     +# Options can be configured either when setting up the build directory or can
     +# be changed in preexisting build directories:
     +#
    -+#      # Set up a build directory with optimized settings that will be
    ++#      # Set up a new build directory with optimized settings that will be
     +#      # installed into an alternative prefix.
    -+#      $ meson setup --buildtype release --optimization 3 --strip --prefix=/home/$USER
    ++#      $ meson setup --buildtype release --optimization 3 --strip --prefix=/home/$USER build
    ++#
    ++#      # Set up a new build directory with a higher warning level. Level 2 is
    ++#      # mostly equivalent to setting DEVELOPER=1, level 3 and "everything"
    ++#      # will enable even more warnings.
    ++#      $ meson setup -Dwarning_level=2
     +#
    -+#      # Set up a build directory with 'address' and 'undefined' sanitizers
    ++#      # Set up a new build directory with 'address' and 'undefined' sanitizers
     +#      # using Clang.
    -+#      $ CC=clang meson setup -Db_sanitize=address,undefined
    ++#      $ CC=clang meson setup -Db_sanitize=address,undefined build
     +#
     +#      # Disable tests in a preexisting build directory.
     +#      $ meson configure -Dtests=false
    @@ meson.build (new)
     +#      # Disable features based on Python
     +#      $ meson configure -Dpython=disabled
     +#
    -+#      # Disable features based on Python
    -+#      $ meson configure -Dpython=disabled
    -+#
     +# Options have a type like booleans, choices, strings or features. Features are
     +# somewhat special as they can have one of three values: enabled, disabled or
     +# auto. While the first two values are self-explanatory, "auto" will enable or
    @@ meson.build (new)
     +  script_environment.prepend('PATH', fs.parent(program.full_path()))
     +endforeach
     +
    -+git_version = run_command(shell, 'GIT-VERSION-GEN', check: false, env: script_environment).stdout().strip()
    -+if git_version == ''
    -+  git_version = meson.project_version()
    -+endif
    -+
     +compiler = meson.get_compiler('c')
     +
     +libgit_sources = [
    @@ meson.build (new)
     +build_options_config.set('GIT_TEST_OPTS', '')
     +build_options_config.set('GIT_TEST_PERL_FATAL_WARNINGS', '')
     +build_options_config.set('GIT_TEST_UTF8_LOCALE', '')
    -+build_options_config.set('SANITIZE_ADDRESS', '')
    -+build_options_config.set('SANITIZE_LEAK', '')
     +build_options_config.set('BROKEN_PATH_FIX', '')
     +build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
     +build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
    @@ meson.build (new)
     +libgit_include_directories = [ '.' ]
     +libgit_dependencies = [ ]
     +
    ++# Treat any warning level above 1 the same as we treat DEVELOPER=1 in our
    ++# Makefile.
    ++if get_option('warning_level') in ['2','3', 'everything'] and compiler.get_argument_syntax() == 'gcc'
    ++  foreach cflag : [
    ++    '-Wdeclaration-after-statement',
    ++    '-Wformat-security',
    ++    '-Wold-style-definition',
    ++    '-Woverflow',
    ++    '-Wpointer-arith',
    ++    '-Wstrict-prototypes',
    ++    '-Wunused',
    ++    '-Wvla',
    ++    '-Wwrite-strings',
    ++    '-fno-common',
    ++    '-Wtautological-constant-out-of-range-compare',
    ++    # If a function is public, there should be a prototype and the right
    ++    # header file should be included. If not, it should be static.
    ++    '-Wmissing-prototypes',
    ++    # These are disabled because we have these all over the place.
    ++    '-Wno-empty-body',
    ++    '-Wno-missing-field-initializers',
    ++    '-Wno-sign-compare',
    ++  ]
    ++    if compiler.has_argument(cflag)
    ++      libgit_c_args += cflag
    ++    endif
    ++  endforeach
    ++endif
    ++
    ++if get_option('b_sanitize').contains('address')
    ++  build_options_config.set('SANITIZE_ADDRESS', 'YesCompiledWithIt')
    ++else
    ++  build_options_config.set('SANITIZE_ADDRESS', '')
    ++endif
    ++if get_option('b_sanitize').contains('leak')
    ++  libgit_c_args += '-DSUPPRESS_ANNOTATED_LEAKS'
    ++  build_options_config.set('SANITIZE_LEAK', 'YesCompiledWithIt')
    ++else
    ++  build_options_config.set('SANITIZE_LEAK', '')
    ++endif
    ++if get_option('b_sanitize').contains('undefined')
    ++  libgit_c_args += '-DSHA1DC_FORCE_ALIGNED_ACCESS'
    ++endif
    ++
     +executable_suffix = ''
     +if host_machine.system() == 'cygwin' or host_machine.system() == 'windows'
     +  executable_suffix = '.exe'
    @@ meson.build (new)
     +  build_options_config.set('USE_LIBPCRE2', '')
     +endif
     +
    -+curl = dependency('libcurl', version: '>=7.21.3', required: get_option('curl'), default_options: ['default_library=static', 'tests=disabled'])
    ++curl = dependency('libcurl', version: '>=7.21.3', required: get_option('curl'), default_options: ['default_library=static', 'tests=disabled', 'tool=disabled'])
     +use_curl_for_imap_send = false
     +if curl.found()
     +  if curl.version().version_compare('>=7.34.0')
    @@ meson.build (new)
     +build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
     +build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
     +
    -+if compiler.has_header('regex.h') and compiler.get_define('REG_STARTEND', prefix: '#include <regex.h>') != ''
    ++if not get_option('b_sanitize').contains('address') and get_option('regex').allowed() and compiler.has_header('regex.h') and compiler.get_define('REG_STARTEND', prefix: '#include <regex.h>') != ''
     +  build_options_config.set('NO_REGEX', '')
     +
     +  if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') != ''
     +    libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
     +    libgit_sources += 'compat/regcomp_enhanced.c'
     +  endif
    -+else
    ++elif not get_option('regex').enabled()
     +  libgit_c_args += [
     +    '-DNO_REGEX',
     +    '-DGAWK',
    @@ meson.build (new)
     +  build_options_config.set('NO_REGEX', '1')
     +  libgit_sources += 'compat/regex/regex.c'
     +  libgit_include_directories += 'compat/regex'
    ++else
    ++    error('Native regex support requested but not found')
     +endif
     +
     +# setitimer and friends are provided by compat/mingw.c.
    @@ meson.build (new)
     +  libgit_c_args += '-DHAVE_CLOCK_MONOTONIC'
     +endif
     +
    -+if compiler.compiles('''
    ++if not compiler.compiles('''
     +  #include <inttypes.h>
     +
     +  void func(void)
    @@ meson.build (new)
     +  endif
     +endif
     +
    -+if compiler.run('''
    ++if not meson.is_cross_build() and compiler.run('''
     +  #include <stdio.h>
     +
     +  int main(int argc, const char **argv)
    @@ meson.build (new)
     +  configuration: build_options_config,
     +)
     +
    ++version_def_h = custom_target(
    ++  command: [
    ++    shell,
    ++    meson.current_source_dir() / 'GIT-VERSION-GEN',
    ++    meson.current_source_dir(),
    ++    '@INPUT@',
    ++    '@OUTPUT@',
    ++  ],
    ++  input: meson.current_source_dir() / 'version-def.h.in',
    ++  output: 'version-def.h',
    ++  build_always_stale: true,
    ++)
    ++
    ++git_version_file = custom_target(
    ++  command: [
    ++    shell,
    ++    meson.current_source_dir() / 'GIT-VERSION-GEN',
    ++    meson.current_source_dir(),
    ++    '@INPUT@',
    ++    '@OUTPUT@',
    ++  ],
    ++  input: meson.current_source_dir() / 'GIT-VERSION-FILE.in',
    ++  output: 'GIT-VERSION-FILE',
    ++  build_always_stale: true,
    ++)
    ++
     +# Build a separate library for "version.c" so that we do not have to rebuild
    -+# everything when the current Git commit changes. TODO: this only gets set up
    -+# at configuration time, so we do not notice version changes unless the build
    -+# instructions get regenerated. We should refactor the source file such that we
    -+# can substitute tags in the file via `vcs_tag()`.
    ++# everything when the current Git commit changes.
     +libgit_version_library = static_library('git-version',
    -+  sources: ['version.c'],
    -+  c_args: libgit_c_args + [
    -+    '-DGIT_VERSION="' + git_version + '"',
    -+    '-DGIT_USER_AGENT="' + 'git/' + git_version + '"',
    -+    '-DGIT_BUILT_FROM_COMMIT="' + run_command('git', 'rev-parse', '-q', '--verify', 'HEAD', check: false).stdout().strip() + '"',
    ++  sources: [
    ++    'version.c',
    ++    version_def_h,
     +  ],
    ++  c_args: libgit_c_args,
     +  dependencies: libgit_dependencies,
     +  include_directories: libgit_include_directories,
     +)
    @@ meson.build (new)
     +common_main_sources = ['common-main.c']
     +common_main_link_args = [ ]
     +if host_machine.system() == 'windows'
    -+  # TODO: wire these up properly.
    -+  common_main_sources += import('windows').compile_resources('git.rc', args: [
    -+    '-DMAJOR=1',
    -+    '-DMINOR=1',
    -+    '-DMICRO=1',
    -+    '-DPATCHLEVEL=0',
    -+    '-DGIT_VERSION=\\\"' + git_version + '.GIT\\\"',
    -+  ])
    ++  git_rc = custom_target(
    ++    command: [
    ++      shell,
    ++      meson.current_source_dir() / 'GIT-VERSION-GEN',
    ++      meson.current_source_dir(),
    ++      '@INPUT@',
    ++      '@OUTPUT@',
    ++    ],
    ++    input: meson.current_source_dir() / 'git.rc.in',
    ++    output: 'git.rc',
    ++    build_always_stale: true,
    ++  )
    ++
    ++  common_main_sources += import('windows').compile_resources(git_rc,
    ++    include_directories: [meson.current_source_dir()],
    ++  )
     +  if compiler.get_argument_syntax() == 'gcc'
     +    common_main_link_args += [
     +      '-municode',
    @@ meson.build (new)
     +
     +foreach symlink : [
     +  'git',
    -+  'git-http-backend',
     +  'git-receive-pack',
     +  'git-shell',
     +  'git-upload-archive',
    @@ meson.build (new)
     +    shell,
     +    meson.project_source_root() / 'generate-perl.sh',
     +    meson.project_build_root() / 'GIT-BUILD-OPTIONS',
    -+    git_version,
    ++    git_version_file.full_path(),
     +    perl_header,
     +    '@INPUT@',
     +    '@OUTPUT@',
    @@ meson.build (new)
     +      output: fs.stem(script),
     +      command: generate_perl_command,
     +      install: true,
    -+      install_dir: get_option('datadir') / 'perl5',
    ++      install_dir: get_option('libexecdir') / 'git-core',
    ++      depends: [git_version_file],
     +    )
     +    test_dependencies += generated_script
    ++
     +    if script == 'git-cvsserver.perl'
     +      bin_wrappers += generated_script
    ++
    ++      install_symlink(fs.stem(script),
    ++        install_dir: get_option('bindir'),
    ++        pointing_to: fs.relative_to(get_option('libexecdir') / 'git-core' / fs.stem(script), get_option('bindir')),
    ++      )
     +    endif
     +  endforeach
     +
    @@ meson.build (new)
     
      ## meson_options.txt (new) ##
     @@
    ++# Configuration for how Git behaves at runtime.
     +option('default_pager', type: 'string', value: 'less',
     +  description: 'Fall-back pager.')
     +option('default_editor', type: 'string', value: 'vi',
    @@ meson_options.txt (new)
     +option('runtime_prefix', type: 'boolean', value: false,
     +  description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
     +
    ++# Features supported by Git.
     +option('curl', type: 'feature', value: 'enabled',
     +  description: 'Build helpers used to access remotes with the HTTP transport.')
     +option('expat', type: 'feature', value: 'enabled',
    @@ meson_options.txt (new)
     +  description: 'Install bundled copies of CPAN modules that serve as a fallback in case the modules are not available on the system.')
     +option('python', type: 'feature', value: 'auto',
     +  description: 'Build tools written in Python.')
    ++option('regex', type: 'feature', value: 'auto',
    ++  description: 'Use the system-provided regex library instead of the bundled one.')
     +
    ++# HTTPS backends.
     +option('openssl', type: 'feature', value: 'auto',
     +  description: 'Support access to HTTPS remotes. OpenSSL may still be pulled in if configured as SHA1 or SHA256 backend.')
     +option('CommonCrypto', type: 'feature', value: 'auto',
     +  description: 'Build tools written in Python.')
     +
    ++# Hashing backends.
     +option('sha1_backend', type: 'combo', choices: ['openssl', 'block', 'sha1dc', 'common-crypto'], value: 'sha1dc',
     +  description: 'The backend used for hashing objects with the SHA1 object format')
     +option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt', 'block'], value: 'block',
     +  description: 'The backend used for hashing objects with the SHA256 object format')
     +
    ++# Build tweaks.
     +option('macos_use_homebrew_gettext', type: 'boolean', value: true,
     +  description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
     +
    ++# gitweb configuration.
     +option('gitweb_config', type: 'string', value: 'gitweb_config.perl')
     +option('gitweb_config_system', type: 'string', value: '/etc/gitweb.conf')
     +option('gitweb_config_common', type: 'string', value: '/etc/gitweb-common.conf')
    @@ meson_options.txt (new)
     +option('gitweb_site_footer', type: 'string', value: '')
     +option('highlight_bin', type: 'string', value: 'highlight')
     +
    ++# Documentation.
     +option('docs', type: 'array', choices: ['man', 'html'], value: [],
     +  description: 'Which documenattion formats to build and install.')
     +option('default_help_format', type: 'combo', choices: ['man', 'html'], value: 'man',
     +  description: 'Default format used when executing git-help(1).')
     +
    ++# Testing.
     +option('tests', type: 'boolean', value: true,
     +  description: 'Enable building tests. This requires Perl, but is separate from the "perl" option such that you can build tests without Perl features enabled.')
     +option('test_output_directory', type: 'string',
    @@ templates/hooks/meson.build (new)
     +    input: hook,
     +    output: hook,
     +    configuration: template_config,
    ++    install: true,
    ++    install_dir: get_option('datadir') / 'git-core/templates',
     +  )
     +endforeach
     
    @@ templates/info/meson.build (new)
     +  input: 'exclude',
     +  output: 'exclude',
     +  configuration: template_config,
    ++  install: true,
    ++  install_dir: get_option('datadir') / 'git-core/templates',
     +)
     
      ## templates/meson.build (new) ##
    @@ templates/meson.build (new)
     +  input: 'description',
     +  output: 'description',
     +  configuration: template_config,
    ++  install: true,
    ++  install_dir: get_option('datadir') / 'git-core/templates',
     +)
     +
     +subdir('hooks')
19:  88a7a7e38b = 22:  3bdf6240a5 meson: fix conflicts with in-flight topics

---
base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
change-id: 20241112-pks-meson-95b665c08f06

