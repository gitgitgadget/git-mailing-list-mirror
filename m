Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E53232
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732810347; cv=none; b=lpmHk7fMXEkpN+mls68K+638Sy0zzyygR7Uev4ZBoaLKgIS0lZ407Qh2ncPforGlWWXVQCC91T7Oq9ntHgXt2CGTk75CbxIaQWkltYMMLoCI9reCLgbkkBD9PpXh/c46+WpfMdkYQrswKbRG9iYCg2sroyR6H5trV3FWnmNFmAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732810347; c=relaxed/simple;
	bh=oMQolSUbfoUihOKLPsQV9t1nVIjr2Ph5zQ/vqSAp2GQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=kY3zyIRLFCjun6JsK6kDvFgjz7rlyNCa6iXd3lVZ3XGoeEyg+d8vVsQBCJw7AUAOK5xRGgnxn7ZnAKRf6Reuux2KD84K/qWPF84TeaeARHP3Foezgllzl7QBP0dxPQ5hIqCVFEUTKagb1clAqrXPCmVa+LEROAfnE01RKtMub90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=H6bU5wfR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gmcbrwlW; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="H6bU5wfR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmcbrwlW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E274B138020F;
	Thu, 28 Nov 2024 11:12:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Thu, 28 Nov 2024 11:12:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732810341;
	 x=1732896741; bh=qrL4FkWjdGwc76X4vPVbOlVyZH4k9kpkYqgwCOHtWmc=; b=
	H6bU5wfRXUCvESV7YbDicVEox+qsYJbUFLfMJc0fpfk6ikTXbBifZkIiFplP8C4u
	Jov/P6kiWV+vxLCxXza5CrfGjGNwGit4Eo+P7DcYQXGP9dZPs393KMphGhXSHxD4
	TiDn0EPfcOoJ09F0+zDlUpH7mX4qRb5mHyyBAdGPbgWboidBNP8o7k5oRe2wpDYW
	PpwNk6iTTTdOtwKlk2b7b52lmzsxcOirIpawNaP5M6lm4EXNF5ZBxGwc+2OL1GAN
	XPmqDfABBfn9W7sHC/LBKoqpuyNJByJH/d4LfSNV/0d4veQ1lNcXp4cCj5GJlMOV
	xqFDYZGf5kVGwxfoEbhlsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732810341; x=
	1732896741; bh=qrL4FkWjdGwc76X4vPVbOlVyZH4k9kpkYqgwCOHtWmc=; b=g
	mcbrwlWmohBLmbidAQ+KoVBpiea4go4FUrJPA0PtdfUVqeP5nxfTyUc5siQDFitr
	kl4mJlixIOdeKS+XsTRlFZLXgKfMBwa6i7M/CACrJIdWXAsWQhJrK9u5CT3WyTZ+
	GCtx3kRr2sjk0Jbr0H9czcr8YS0BsiE8wVVx6EiZwIvvO0EOTIu+gyw54GvA+uEq
	PUM9vVhvu8G6yZPeIM/O1mJQUp8Han1hKbPauicyj9vX2ywOF/mJxf2nChE9mNZK
	WyWqt7VQ+QzSBFpjNf3oPBa9iUke5+N8RUM/Uga2yfc18WsLeN0k1CeqhjaoTKYA
	8NdPqI6ACkcvwSuKc4aeA==
X-ME-Sender: <xms:ZJZIZ9oOBBukcv2ZPM16iuwYgadcFNFnNKvcz-NiZYSqAZv6GxiCZQ>
    <xme:ZJZIZ_pKACuoNVp0XSalnQX97JUPyqP48rZJtfN3HD87qlxCLCtiNuouBLat8Ebbk
    JqWxa1bR_-9S6DhNQ>
X-ME-Received: <xmr:ZJZIZ6PgVHStUHkW4YJHXGYO-Dzhz9-vgt0N52WPsV8E2rW0IWEYNoZBZ2omw7Et6QTPPdNqwcgjreT75K90EOiHPQFHCmNwa-2gwGrFefLDBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedugdekgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepledvkeelffettedujeduleeugfetueejgedvleevhefg
    teffgedtfefhteeiieeunecuffhomhgrihhnpegtohhnfhdrihhnpdhrsgdrihhnpdhrtg
    drihhnpdhhthhtphdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddupdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhope
    hgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhht
    iiesghgvnhhtohhordhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmsh
    grhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:ZJZIZ46DHX9OQjZLwSbpWh0MNlNnzM3UDK1CfQDYuH4NsW5GyXTx2Q>
    <xmx:ZJZIZ85b7kptqxx2VQCdle1dPAhe9blMQFpYINecqA8bSiCkMCJKlQ>
    <xmx:ZJZIZwjHxtQk4tMA2-CSnZDwlskQ9ANmBfYXQ9zH0OiIDqyTS8VPtQ>
    <xmx:ZJZIZ-5_cQ3Eor5Fp-E_GzAO-Sd-nmm5eK0Jbz4RjRrt4a-H-gaxcw>
    <xmx:ZZZIZ8irPAKou-UC088fJk9dBZKRIFGrnMFgfKJMwszgN4l0Cle6ktln>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 11:12:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f63ed668 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Nov 2024 16:11:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v10 00/23] Modernize the build system
Date: Thu, 28 Nov 2024 17:12:01 +0100
Message-Id: <20241128-pks-meson-v10-0-79a3fb0cb3a6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFKWSGcC/23SzU7EIBDA8VfZcJZmhs/Bk+9hPGwRdonZbYXaa
 DZ9d9lqTDE9Qv6/IQFurIScQmGPhxvLYU4lDde6QHg4MH8+Xk+Bp9e6wQQIhYiCj2+FX0IZrtz
 p3hjtgSIYVvsxh5g+12HPL3V9TmUa8tc6e8b7LvPDHHKHVlgiRKO6U5q6sTzVoV26sLuaRVuSI
 o3S7ZWyLZ3QCizslepfaS0a0HulbkqJUmonaa80a7lzL7PhwI2iXoJzhoRtmN0yvWW2MmWDR9d
 bgl40jLbMbRlVRuD6aCMoEWXD3IaJ5jRXGXrjo1DiqCP+seXnKXN4/6jfYfp9z2X5BgyNOBssA
 gAA
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
 Johannes Sixt <j6t@kdbg.org>, Christian Couder <chriscool@tuxfamily.org>
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
broken. Eventually, the plan is to also replace CMake and our Makefiles
in case we figure out that this replacement is indeed a net benefit for
the project, but all of this would happen over the course of multiple
releases.

Changes in v10:

  - Fix installation of templates, which all installed into the template
    root directory by accident.

  - Fix symlinks for git-receive-pack and git-upload-{archive,pack}.

  - Dropped the compatibility fix with cc/promisor-remote-capability,
    which has been removed from "seen".

As before, the tip of this patch series catches up with what is
happening in "seen" and should thus not be merged to "next". If you want
to test it without topics in "seen" you have to revert it.

Thanks!

Patrick

---
Patrick Steinhardt (23):
      Makefile: use common template for GIT-BUILD-OPTIONS
      Makefile: consistently use @PLACEHOLDER@ to substitute
      Makefile: refactor GIT-VERSION-GEN to be reusable
      Makefile: propagate Git version via generated header
      Makefile: generate "git.rc" via GIT-VERSION-GEN
      Makefile: generate doc versions via GIT-VERSION-GEN
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
 Documentation/.gitignore                           |    2 +
 Documentation/CodingGuidelines                     |    2 +-
 Documentation/Makefile                             |   49 +-
 Documentation/{asciidoc.conf => asciidoc.conf.in}  |    3 +
 ...-extensions.rb => asciidoctor-extensions.rb.in} |    8 +-
 Documentation/build-docdep.perl                    |    2 +
 Documentation/cmd-list.perl                        |   23 +-
 Documentation/config/diff.txt                      |    2 +-
 Documentation/config/merge.txt                     |    2 +-
 Documentation/generate-mergetool-list.sh           |   17 +
 Documentation/git.txt                              |   24 +-
 Documentation/meson.build                          |  324 ++++
 Documentation/technical/build-systems.txt          |  224 +++
 GIT-BUILD-OPTIONS.in                               |   47 +
 GIT-VERSION-FILE.in                                |    1 +
 GIT-VERSION-GEN                                    |   74 +-
 Makefile                                           |  241 ++-
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
 gitweb/GITWEB-BUILD-OPTIONS.in                     |   24 +
 gitweb/Makefile                                    |   62 +-
 gitweb/generate-gitweb-cgi.sh                      |   47 +
 gitweb/generate-gitweb-js.sh                       |   12 +
 gitweb/gitweb.perl                                 |   44 +-
 gitweb/meson.build                                 |   79 +
 meson.build                                        | 1893 ++++++++++++++++++++
 meson_options.txt                                  |   81 +
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
 t/meson.build                                      | 1116 ++++++++++++
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
 97 files changed, 4938 insertions(+), 499 deletions(-)

Range-diff versus v9:

 1:  b2615d9610 =  1:  da33c9c584 Makefile: use common template for GIT-BUILD-OPTIONS
 2:  afba38c430 =  2:  65a99e0be3 Makefile: consistently use @PLACEHOLDER@ to substitute
 3:  1f5dcbb860 =  3:  cae4617b14 Makefile: refactor GIT-VERSION-GEN to be reusable
 4:  1b2da30065 =  4:  7ae8540ae5 Makefile: propagate Git version via generated header
 5:  d88a943419 =  5:  79fe87e027 Makefile: generate "git.rc" via GIT-VERSION-GEN
 6:  0ad3eb80a7 =  6:  ad3b326a61 Makefile: generate doc versions via GIT-VERSION-GEN
 7:  d615b64ebf =  7:  21cd6d1751 Makefile: consistently use PERL_PATH
 8:  788b49edca =  8:  3bda1aaf94 Makefile: extract script to massage Perl scripts
 9:  3ade250267 =  9:  406c0e8769 Makefile: use "generate-perl.sh" to massage Perl library
10:  ec30fe9652 = 10:  90796b17b9 Makefile: extract script to massage Shell scripts
11:  69eb45ea9f = 11:  7b5e7fc222 Makefile: extract script to generate gitweb.cgi
12:  ab8c2e7369 = 12:  eda2a5fafa Makefile: extract script to generate gitweb.js
13:  c88ee27d88 = 13:  709ab3b5f5 Makefile: refactor generators to be PWD-independent
14:  105bb4c1bd = 14:  e79f104d7f Makefile: allow "bin-wrappers/" directory to exist
15:  f3f7db5c82 = 15:  aa816a6cb9 Makefile: simplify building of templates
16:  1262542641 = 16:  864296d108 Documentation: allow sourcing generated includes from separate dir
17:  31f53f3570 = 17:  960d1782a7 Documentation: teach "cmd-list.perl" about out-of-tree builds
18:  9f4fdec5dc = 18:  fc803341f4 Documentation: extract script to generate a list of mergetools
19:  8a88e5fb35 = 19:  17f0e185df t: better support for out-of-tree builds
20:  296db4ba81 = 20:  60d746f329 t: allow overriding build dir
21:  f47bc0535b = 21:  3f7df3af22 Documentation: add comparison of build systems
22:  99258d7e4f = 22:  7db23c5fdb Introduce support for the Meson build system
23:  584b0ef151 ! 23:  1a0c47c47f meson: fix conflicts with in-flight topics
    @@ Commit message
     
           - ej/cat-file-remote-object-info adds t1017 and "fetch-object-info.c".
     
    -      - cc/promisor-remote-capability adds t5710.
    -
           - ds/path-walk-1 adds t6601 as well as "path-walk.c" and
             "test-path-walk.c".
     
    @@ meson.build: libgit_sources = [
        'reftable/tree.c',
        'reftable/writer.c',
        'remote.c',
    +@@ meson.build: foreach alias : [ 'git-receive-pack', 'git-upload-archive', 'git-upload-pack' ]
    + 
    +   install_symlink(alias + executable_suffix,
    +     install_dir: get_option('libexecdir') / 'git-core',
    +-    pointing_to: 'git-remote-http',
    ++    pointing_to: 'git',
    +   )
    + endforeach
    + 
     
      ## t/helper/meson.build ##
     @@ t/helper/meson.build: test_tool_sources = [
    @@ t/meson.build: integration_tests = [
        't2500-untracked-overwriting.sh',
        't2501-cwd-empty.sh',
        't3000-ls-files-others.sh',
    -@@ t/meson.build: integration_tests = [
    -   't5703-upload-pack-ref-in-want.sh',
    -   't5704-protocol-violations.sh',
    -   't5705-session-id-in-capabilities.sh',
    -+  't5710-promisor-remote-capability.sh',
    -   't5730-protocol-v2-bundle-uri-file.sh',
    -   't5731-protocol-v2-bundle-uri-git.sh',
    -   't5732-protocol-v2-bundle-uri-http.sh',
     @@ t/meson.build: integration_tests = [
        't6500-gc.sh',
        't6501-freshen-objects.sh',
    @@ t/meson.build: integration_tests = [
        't6700-tree-depth.sh',
        't7001-mv.sh',
        't7002-mv-sparse-checkout.sh',
    +
    + ## templates/hooks/meson.build ##
    +@@ templates/hooks/meson.build: foreach hook : hooks
    +     output: hook,
    +     configuration: template_config,
    +     install: true,
    +-    install_dir: get_option('datadir') / 'git-core/templates',
    ++    install_dir: get_option('datadir') / 'git-core/templates/hooks',
    +   )
    + endforeach
    +
    + ## templates/info/meson.build ##
    +@@ templates/info/meson.build: configure_file(
    +   output: 'exclude',
    +   configuration: template_config,
    +   install: true,
    +-  install_dir: get_option('datadir') / 'git-core/templates',
    ++  install_dir: get_option('datadir') / 'git-core/templates/info',
    + )

---
base-commit: dbfa873276ccefac0b426e46f31101ecdbcf4f40
change-id: 20241112-pks-meson-95b665c08f06

