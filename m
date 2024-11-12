Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CAE2101BE
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731431014; cv=none; b=J4GC4EfJ1nBgcvNYPLVEA9JqdMzmYu91RUQ0YGMDgwcAzhotKU4JBiaFMKuSvQGwacaZ9D4oeBQZm27s9waVIe1oVFRNNonJBpGwnYb2o3vlsyMOpV0xAcQPn6Xq+erJxOL5qdjNmd8KQ3D2bYeTudFpX5kpFAdFAjtPBgzf5fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731431014; c=relaxed/simple;
	bh=BScegW2iuUivUA05HgQklL2Jb19S78bzAB0RqDOxpqk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=g0052X6GMBc43mdPWqWeE07lt4Wao4nReDZFQn4zT6KlrFDh1cw81mQVwN9CFZh+6lkLnTfob7O1oCUVD5ytd4sXDpoy+B3M3QloOQabWvI0asipavkJZSDfPRJiuoHfLHow5qdAJrKtnPzt35JPwr5zRL6xRCQsU3syg+BcXFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FUaU7lzL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XILIAZjp; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FUaU7lzL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XILIAZjp"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AAB982540143;
	Tue, 12 Nov 2024 12:03:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 12 Nov 2024 12:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731431009;
	 x=1731517409; bh=cZvnjg+gblskuuRPW5CTFajwoIy2c6rhm1zaAwqErmw=; b=
	FUaU7lzL31p+CjNmWaNfBv7KRmzWoYy9/QBptJEiDaX8gEEZlGUAXv2QtOtJTK9e
	CqrA72PhU1C0p+F4bcQANKDujRf23HPJu7y6bO2acMz93OQf3gRvMiNarHm4P7bE
	2z3x6HpWRUa+R+lQfEG0HsTxY0VhOdFcneqthz0ACgW5wWyJg8Z6cCFtOD8vf5aD
	sdqH8qhiVnR02SQu5A13IHT2RhYRuXezOFsp3ewwD6f3xRGPbw9D7/+FTO/2wqPX
	NmbUwtS36fRqSIvARQlJRcZq2Zn27Wx295Id2GqUw+/Utgg8bdio1SJ3rq964ch4
	2+2pIUBh9Kl4/arT7dwFCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731431009; x=
	1731517409; bh=cZvnjg+gblskuuRPW5CTFajwoIy2c6rhm1zaAwqErmw=; b=X
	ILIAZjpait4FaeT+83SW/cDwyNmbgHb8NVdt8rB/7DVf9LCuNb8SuIiJ3K5R66N7
	ZZvPskMq/tpl0q+m+kGr/rtWMHDRDZV/NfDqL1lY5xQg54Mnw+hc56KF8ZOxbZ4Q
	BetwqwDx+esM7yz6VDVaIwNN9qUjq4aCtCElKb8BamkRonS14Ju60bz6kLKw75bZ
	1X5PLyooJRqRL2y1wJ6a+B29rMsgKCa0BjhJEn/V3q1x+P1HZAett1YgRvXuBjws
	ZCNCU+uPAxEHRpRi4bxzZMxt7WKwWUYpcBvgxPhU+J5FDtuNVZ6GM9NvcrwM+B3C
	99RGCCmo9iU20C+XXg1YA==
X-ME-Sender: <xms:YIozZ-2CSMepA-XQH-nBBmH04o34gHbFJnNT_x4ZxBM4Y9EuOSx9gA>
    <xme:YIozZxHJ8n_xP0M1SlCtP_zPvP4PQcEUK_8HjJx-3XoSTFl1lcRKJwFDvlMQumUq4
    GLXE-h1LLf8DSwPlA>
X-ME-Received: <xmr:YIozZ246Eaw7rrBD_cXrbxpW5zKKbYj4LGsgWMe9sjAZpPQ4vtdRzbKi_0bETwblEK_J29OcAO7ZJA0M-kEoaRLoE4P680jpK_na1lm8MxN1uwI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeikeevgfeftdfhtddtfeevteeugefguefhteduteeg
    ffefgfelkeduvdeuteegnecuffhomhgrihhnpehgihhthhhusgdrtghomhdpkhgvrhhnvg
    hlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehr
    rghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohepph
    hhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegurghv
    vhhiugesghhmrghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnth
    hoohdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdr
    nhgvth
X-ME-Proxy: <xmx:YIozZ_0gIERWWMaRd1nILZMuvjCOcC2z6ggo929yfzb0c1BGqhyFow>
    <xmx:YIozZxEe0eoplr2wkf9gztMZRv4Bd3McZpJ3g8noSx3FByw65lSAgw>
    <xmx:YIozZ4-vn9J84FjNuIZ71zstDQcMD_Fem2migRkJ1jd0DG_qVKBF8g>
    <xmx:YIozZ2nLKXIcqkbBCz1hyCKtsXInFb7rqwVMDQBqlIG5MY9s_YWmTQ>
    <xmx:YYozZwB7I3xNMhLdc3RikU4mSjebRNmPRiPrqxlw5MzEo9D5CYN8zqLK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 12:03:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c4d922ac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 17:02:48 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH RFC v6 00/19] Modernize the build system
Date: Tue, 12 Nov 2024 18:02:43 +0100
Message-Id: <20241112-pks-meson-v6-0-648b30996827@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADSKM2cC/23MTQrCMBAF4KuUrE3I5L+uBMEDuBUXWtMapE1JS
 lBK727IrqXLN/O9N6Nog7MRHasZBZtcdH7IQR0q1LwfQ2exe+WMGGUCABgePxH3NvoB1/KplGy
 oaalC2Y/Btu5btm7oejmjez6+XZx8+JX9BOXV+GQDAc20MQBKkM5NZIynvExcX1qJraURRgKv9
 yRfy5pJQTXdk2IjtQZF5Z6UK8mBc1lzs5XLsvwBYBuenT8BAAA=
X-Change-ID: 20241112-pks-meson-95b665c08f06
In-Reply-To: <cover.1727881164.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, Taylor Blau <me@ttaylorr.com>, 
 David Aguilar <davvid@gmail.com>, Jeff King <peff@peff.net>
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

Changes in v6:

  - Add documentation for how to use Meson.

  - Fix compilation in case libintl exists, but required tools like
    msgfmt and related don't. Instead of failing, we now automatically
    compile with the equivalent of NO_GETTEXT=YesPlease.

  - Update last patch that fixes semantic merge conflics with in-flight
    topics in "seen".

  - I've changed the series to be based on "master" at b31fb630c0 (Merge
    https://github.com/j6t/git-gui, 2024-11-11) as all prereqs of this
    series have since landed. This doesn't make any difference though
    as there aren't any merge conflicts or additional changes caused by
    this. I mostly mention this so that there is no confusion around the
    changed base commit.

As before, the tip of this patch series catches up with what is
happening in "seen". If you want to test it without topics in "seen" you
have to revert it.

Links to previous versions:

  - Link to v1: https://lore.kernel.org/r/cover.1727881164.git.ps@pks.im
  - Link to v2: https://lore.kernel.org/r/cover.1728485139.git.ps@pks.im
  - Link to v3: https://lore.kernel.org/r/cover.1729254070.git.ps@pks.im
  - Link to v4: https://lore.kernel.org/r/cover.1729771605.git.ps@pks.im
  - Link to v5: https://lore.kernel.org/r/cover.1731335938.git.ps@pks.im

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

Patrick Steinhardt (19):
      Makefile: use common template for GIT-BUILD-OPTIONS
      Makefile: consistently use @PLACEHOLDER@ to substitute
      Makefile: consistently use PERL_PATH
      Makefile: extract script to massage Perl scripts
      Makefile: use "generate-perl.sh" to massage Perl library
      Makefile: extract script to massage Shell scripts
      Makefile: extract script to generate gitweb.cgi
      Makefile: refactor GIT-VERSION-GEN to be reusable
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

 .gitignore                                         |    1 -
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
 GIT-VERSION-GEN                                    |   12 +-
 Makefile                                           |  209 +--
 bin-wrappers/.gitignore                            |    9 +
 bin-wrappers/meson.build                           |   28 +
 bin-wrappers/wrap-for-bin.sh                       |   37 +
 configure.ac                                       |    2 +-
 contrib/buildsystems/CMakeLists.txt                |  230 +--
 contrib/completion/meson.build                     |    8 +
 contrib/meson.build                                |    1 +
 generate-cmdlist.sh                                |   42 +-
 generate-configlist.sh                             |   20 +-
 generate-hooklist.sh                               |   15 +-
 generate-perl.sh                                   |   36 +
 generate-script.sh                                 |   34 +
 git-cvsserver.perl                                 |    2 +-
 git-instaweb.sh                                    |    8 +-
 git-request-pull.sh                                |    2 +-
 git-send-email.perl                                |    2 +-
 git-sh-i18n.sh                                     |    6 +-
 git-sh-setup.sh                                    |    6 +-
 git-svn.perl                                       |    2 +-
 gitk-git/po/vi.po                                  |    2 +-
 gitweb/GITWEB-BUILD-OPTIONS.in                     |   25 +
 gitweb/Makefile                                    |   58 +-
 gitweb/generate-gitweb.sh                          |   45 +
 gitweb/gitweb.perl                                 |   44 +-
 gitweb/meson.build                                 |   63 +
 meson.build                                        | 1780 ++++++++++++++++++++
 meson_options.txt                                  |   73 +
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
 t/test-lib.sh                                      |   22 +-
 templates/Makefile                                 |   39 +-
 templates/branches--                               |    1 -
 templates/{this--description => description}       |    0
 .../applypatch-msg.sample}                         |    0
 .../commit-msg.sample}                             |    0
 .../fsmonitor-watchman.sample}                     |    0
 templates/hooks/meson.build                        |   24 +
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
 templates/info/meson.build                         |    5 +
 templates/meson.build                              |   13 +
 unimplemented.sh                                   |    2 +-
 wrap-for-bin.sh                                    |   36 -
 88 files changed, 4600 insertions(+), 447 deletions(-)

Range-diff versus v5:

 1:  ed28e754e8 =  1:  687ae57464 Makefile: use common template for GIT-BUILD-OPTIONS
 2:  178ba0e5d6 =  2:  53d5f0103a Makefile: consistently use @PLACEHOLDER@ to substitute
 3:  66b82c152b =  3:  15a4864450 Makefile: consistently use PERL_PATH
 4:  8382a6b840 =  4:  ed09cc6027 Makefile: extract script to massage Perl scripts
 5:  51491b778d =  5:  56caa7a075 Makefile: use "generate-perl.sh" to massage Perl library
 6:  c3946a69db =  6:  ee2135d178 Makefile: extract script to massage Shell scripts
 7:  a58c901466 =  7:  13fbeee749 Makefile: extract script to generate gitweb.cgi
 8:  a9b886b27a =  8:  f0073e58c8 Makefile: refactor GIT-VERSION-GEN to be reusable
 9:  f2eccc7d65 =  9:  fd412ba3a0 Makefile: refactor generators to be PWD-independent
10:  c891e56e32 = 10:  2e3833a0a3 Makefile: allow "bin-wrappers/" directory to exist
11:  4e9525f64e = 11:  7d93c8afa0 Makefile: simplify building of templates
12:  b209ab75b5 = 12:  8dad1314b2 Documentation: allow sourcing generated includes from separate dir
13:  5e8be2473c = 13:  90d6e0b4eb Documentation: teach "cmd-list.perl" about out-of-tree builds
14:  621d18d281 = 14:  0911b47694 Documentation: extract script to generate a list of mergetools
15:  f56eb0cd86 = 15:  3861eab108 t: better support for out-of-tree builds
16:  9618c7745e = 16:  2226f932d3 t: allow overriding build dir
17:  568287b16a = 17:  a9686e2940 Documentation: add comparison of build systems
18:  42bc858172 ! 18:  a7a7f7efe3 Introduce support for the Meson build system
    @@ Commit message
             symbolic links pointing to the former. This rule is consistent in
             itself and thus easier to reason about.
     
    -      - We do not install dashed binaries into `$libexec/git-core` anymore.
    -        So there won't e.g. be a symlink for git-add(1). These are not
    +      - We do not install dashed binaries into `$libexec/git-core` anymore,
    +        so there won't e.g. be a symlink for git-add(1). These are not
             required by modern Git and there isn't really much of a use case for
             those anymore. By not installing those symlinks we thus start the
             deprecation of this layout.
     
    -      - Documentation does not yet exist. Same here, it will follow if the
    -        project can agree on Meson.
    -
           - We're targeting Meson 1.3.0, which has been released relatively
             recently November 2023. The only feature we use from that version is
             `fs.relative_to()`, which we could replace if necessary. If so, we
    @@ gitweb/meson.build (new)
     
      ## meson.build (new) ##
     @@
    ++# Meson build system
    ++# ==================
    ++#
    ++# The Meson build system is an alternative to our Makefile that you can use to
    ++# build, test and install Git. Using Meson results in a couple of benefits:
    ++#
    ++#  - Out-of-tree builds.
    ++#  - Better integration into IDEs.
    ++#  - Easy-to-use autoconfiguration of available features on your system.
    ++#
    ++# To use Meson from the command line you need to have both Meson and Ninja
    ++# installed. Alternatively, if you do not have Python available on your system,
    ++# you can also use Muon instead of Meson and Samurai instead of Ninja, both of
    ++# which are drop-ins replacement that only depend on C.
    ++#
    ++# Basic usage
    ++# ===========
    ++#
    ++# In the most trivial case, you can configure, build and install Git like this:
    ++#
    ++#  1. Set up the build directory. This only needs to happen once per build
    ++#     directory you want to have. You can also configure multiple different
    ++#     build directories with different configurations.
    ++#
    ++#      $ meson setup build/
    ++#
    ++#     The build directory gets ignored by Git automatically as Meson will write
    ++#     a ".gitignore" file into it. From hereon, we will assume that you execute
    ++#     commands inside this build directory.
    ++#
    ++# 2. Compile Git. You can either use Meson, Ninja or Samurai to do this, so all
    ++#    of the following invocations are equivalent:
    ++#
    ++#      $ meson compile
    ++#      $ ninja
    ++#      $ samu
    ++#
    ++#   The different invocations should ultimately not make much of a difference.
    ++#   Using Meson also works with other generators though, like when the build
    ++#   directory has been set up for use with Microsoft Visual Studio.
    ++#
    ++# 3. Execute tests. Again, you can either use Meson, Ninja or Samurai to do this:
    ++#
    ++#      $ meson test
    ++#      $ ninja test
    ++#      $ samu test
    ++#
    ++#   It is recommended to use Meson in this case though as it also provides you
    ++#   additional features that the other build systems don't have available.
    ++#   You can e.g. pass additional arguments to the test executables or run
    ++#   individual tests:
    ++#
    ++#      # Execute the t0000-basic integration test and t-reftable-stack unit test.
    ++#      $ meson test t0000-basic t-reftable-stack
    ++#
    ++#      # Execute all reftable unit tests.
    ++#      $ meson test t-reftable-*
    ++#
    ++#      # Execute all tests and stop with the first failure.
    ++#      $ meson test --maxfail 1
    ++#
    ++#      # Execute single test interactively such that features like `debug ()` work.
    ++#      $ meson test -i --test-args='-ix' t1400-update-ref
    ++#
    ++# 4. Install the Git distribution. Again, this can be done via Meson, Ninja or
    ++#    Samurai:
    ++#
    ++#      $ meson install
    ++#      $ ninja install
    ++#      $ samu install
    ++#
    ++#    The prefix into which Git shall be installed is defined when setting up
    ++#    the build directory. More on that in the "Configuration" section.
    ++#
    ++# Meson supports multiple backends. The default backend generates Ninja build
    ++# instructions, but it also supports the generation of Microsoft Visual
    ++# Studio solutions as well as Xcode projects. IDEs like Eclipse and Visual
    ++# Studio Code provide plugins to import Meson files directly.
    ++#
    ++# Configuration
    ++# =============
    ++#
    ++# The exact configuration of Git is determined when setting up the Git
    ++# directory. Unless told otherwise, Meson will automatically detect the
    ++# availability of various bits and pieces. There are two different kinds of
    ++# options that can be used to further tweak the build:
    ++#
    ++#   - Built-in options provided by Meson.
    ++#
    ++#   - Options defined by the project in the "meson_options.txt" file.
    ++#
    ++# Both kinds of options can be inspected by running `meson configure` in the
    ++# build directory, which will give you a list of the current value for all
    ++# options.
    ++#
    ++# Options can be configured either when setting up the build directory or can
    ++# be changed in preexisting build directories:
    ++#
    ++#      # Set up a build directory with optimized settings that will be
    ++#      # installed into an alternative prefix.
    ++#      $ meson setup --buildtype release --optimization 3 --strip --prefix=/home/$USER
    ++#
    ++#      # Set up a build directory with 'address' and 'undefined' sanitizers
    ++#      # using Clang.
    ++#      $ CC=clang meson setup -Db_sanitize=address,undefined
    ++#
    ++#      # Disable tests in a preexisting build directory.
    ++#      $ meson configure -Dtests=false
    ++#
    ++#      # Disable features based on Python
    ++#      $ meson configure -Dpython=disabled
    ++#
    ++#      # Disable features based on Python
    ++#      $ meson configure -Dpython=disabled
    ++#
    ++# Options have a type like booleans, choices, strings or features. Features are
    ++# somewhat special as they can have one of three values: enabled, disabled or
    ++# auto. While the first two values are self-explanatory, "auto" will enable or
    ++# disable the feature based on the availability of prerequisites to support it.
    ++# Python-based features for example will be enabled automatically when a Python
    ++# interpreter could be found. The default value of such features can be changed
    ++# globally via `meson setup --auto-features={enabled,disabled,auto}`, which
    ++# will set the value of all features with a value of "auto" to the provided one
    ++# by default.
    ++#
    ++# It is also possible to store a set of configuration options in machine files.
    ++# This can be useful in case you regularly want to reuse the same set of options:
    ++#
    ++#   [binaries]
    ++#   c = ['clang']
    ++#   ar = ['ar']
    ++#
    ++#   [project options]
    ++#   gettext = 'disabled'
    ++#   default_editor = 'vim'
    ++#
    ++#   [built-in options]
    ++#   b_lto = true
    ++#   b_sanitize = 'address,undefined'
    ++#
    ++# These machine files can be passed to Meson via `meson setup --native-file`.
    ++#
    ++# Subproject wrappers
    ++# ===================
    ++#
    ++# Subproject wrappers are a feature provided by Meson that allow the automatic
    ++# fallback to a "wrapped" dependency in case the dependency is not provided by
    ++# the system. For example if the system is lacking curl, then Meson will use
    ++# "subprojects/curl.wrap" to set up curl as a subproject and compile and link
    ++# the dependency into Git itself. This is especially helpful on systems like
    ++# Windows, where you typically don't have such dependencies installed.
    ++#
    ++# The use of subproject wrappers can be disabled by executing `meson setup
    ++# --wrap-mode nofallback`.
    ++
     +project('git', 'c',
     +  meson_version: '>=1.3.0',
     +  # MSVC does not support GNU99, and C99 does not define __STDC_VERSION__
    @@ meson.build (new)
     +  build_options_config.set('NO_PTHREADS', '1')
     +endif
     +
    -+if get_option('gettext').allowed() and host_machine.system() == 'darwin' and get_option('macos_use_homebrew_gettext')
    ++msgfmt = find_program('msgfmt', dirs: program_path, required: false)
    ++gettext_option = get_option('gettext').disable_auto_if(not msgfmt.found())
    ++if not msgfmt.found() and gettext_option.enabled()
    ++  error('Internationalization via libintl requires msgfmt')
    ++endif
    ++
    ++if gettext_option.allowed() and host_machine.system() == 'darwin' and get_option('macos_use_homebrew_gettext')
     +  if host_machine.cpu_family() == 'x86_64'
     +    libintl_prefix = '/usr/local'
     +  elif host_machine.cpu_family() == 'aarch64'
    @@ meson.build (new)
     +    error('Homebrew workaround not supported on current architecture')
     +  endif
     +
    -+  intl = compiler.find_library('intl', dirs: libintl_prefix / 'lib', required: get_option('gettext'))
    ++  intl = compiler.find_library('intl', dirs: libintl_prefix / 'lib', required: gettext_option)
     +  if intl.found()
     +    intl = declare_dependency(
     +      dependencies: intl,
    @@ meson.build (new)
     +    )
     +  endif
     +else
    -+  intl = dependency('intl', required: get_option('gettext'))
    ++  intl = dependency('intl', required: gettext_option)
     +endif
     +if intl.found()
     +  libgit_dependencies += intl
19:  f483916825 ! 19:  8315d432f1 meson: fix conflicts with in-flight topics
    @@ Commit message
         conflicts with topics in "seen". The following conflicts are being
         addressed in this commit:
     
    -      - ej/cat-file-remote-object-info adds t1017.
    +      - ej/cat-file-remote-object-info adds t1017 and "fetch-object-info.c".
     
           - cc/promisor-remote-capability adds t5710.
     
           - ds/path-walk adds t6601 as well as "path-walk.c" and
             "test-path-walk.c".
     
    -      - am/git-blame-ignore-revs-by-default adds t8015 and t8016.
    -
           - ps/reftable-detach adds "reftable/system.c".
     
           - js/libgit-rust adds "common-exit.c" and "common-init.c".
     
    +      - ps/clar-build-improvement adapts the awk(1) script that generates
    +        "clar.suites" to instead be a shell script.
    +
    +      - ds/full-name-hash adds "t/helper/test-name-hash.c".
    +
    +      - cw/worktree-extension deletes t2408.
    +
         This is somewhat painful in the current state where Meson is not yet
         part of the main tree, but we'll have to live with that for the time
         being.
    @@ meson.build: libgit_sources = [
        'compat/nonblock.c',
        'compat/obstack.c',
        'compat/terminal.c',
    +@@ meson.build: libgit_sources = [
    +   'ewah/ewah_rlw.c',
    +   'exec-cmd.c',
    +   'fetch-negotiator.c',
    ++  'fetch-object-info.c',
    +   'fetch-pack.c',
    +   'fmt-merge-msg.c',
    +   'fsck.c',
     @@ meson.build: libgit_sources = [
        'parse-options.c',
        'patch-delta.c',
    @@ meson.build: libgit_sources = [
     
      ## t/helper/meson.build ##
     @@ t/helper/meson.build: test_tool_sources = [
    +   'test-match-trees.c',
    +   'test-mergesort.c',
    +   'test-mktemp.c',
    ++  'test-name-hash.c',
    +   'test-online-cpus.c',
    +   'test-pack-mtimes.c',
    +   'test-parse-options.c',
        'test-parse-pathspec-file.c',
        'test-partial-clone.c',
        'test-path-utils.c',
    @@ t/helper/meson.build: test_tool_sources = [
        'test-proc-receive.c',
     
      ## t/meson.build ##
    +@@ t/meson.build: clar_sources += clar_decls_h
    + clar_sources += custom_target(
    +   input: clar_decls_h,
    +   output: 'clar.suite',
    +-  feed: true,
    +-  capture: true,
    +-  command : [awk, '-f', meson.current_source_dir() + '/unit-tests/clar-generate.awk'],
    ++  command : [shell, meson.current_source_dir() + '/unit-tests/generate-clar-suites.sh', '@INPUT@', '@OUTPUT@'],
    ++  env: script_environment,
    + )
    + 
    + clar_unit_tests = executable('unit-tests',
     @@ t/meson.build: integration_tests = [
        't1014-read-tree-confusing.sh',
        't1015-read-index-unmerged.sh',
    @@ t/meson.build: integration_tests = [
        't1020-subdirectory.sh',
        't1021-rerere-in-workdir.sh',
        't1022-read-tree-partial-clone.sh',
    +@@ t/meson.build: integration_tests = [
    +   't2405-worktree-submodule.sh',
    +   't2406-worktree-repair.sh',
    +   't2407-worktree-heads.sh',
    +-  't2408-worktree-relative.sh',
    +   't2500-untracked-overwriting.sh',
    +   't2501-cwd-empty.sh',
    +   't3000-ls-files-others.sh',
     @@ t/meson.build: integration_tests = [
        't5703-upload-pack-ref-in-want.sh',
        't5704-protocol-violations.sh',
    @@ t/meson.build: integration_tests = [
        't6700-tree-depth.sh',
        't7001-mv.sh',
        't7002-mv-sparse-checkout.sh',
    -@@ t/meson.build: integration_tests = [
    -   't8012-blame-colors.sh',
    -   't8013-blame-ignore-revs.sh',
    -   't8014-blame-ignore-fuzzy.sh',
    -+  't8015-blame-default-ignore-revs.sh',
    -+  't8016-blame-override-ignore-revs.sh',
    -   't9001-send-email.sh',
    -   't9002-column.sh',
    -   't9003-help-autocorrect.sh',

---
base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
change-id: 20241112-pks-meson-95b665c08f06

