Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA97282F1
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 12:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729254240; cv=none; b=ZhsYNowf3Lne82vGm7qqMEiCfYZ3kOnOqlrgEI7YnSwTb+hncw+p3n70VtEKvFQnqiy+r+T4kQYEkW8KcfvB4NKvFw6PBepjNlVdPlZjkSqWbiN9uqhzOSva1pRlzzvLAdtXl6J8pLi2a0mQTSbu1cgl/KU/5AIpFmLbT5JiIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729254240; c=relaxed/simple;
	bh=zpvl9jKJH24UMtdEpv2RyWVZ5Vo/rjiYdK+L3vhU004=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o7IOWWV+s3UrlwDuJ9e59HyIN2oQAGsbr+dFfqiOduzt/1rewcg+SZImkoFNolTIp+gRl2G0vi/tevQsu/5RtocVOMCXg4hlFVe2LepbBZZUWkRcuXUk1Dd2Mwi99/TTXjEEZmbW37jB2C/4eDfQpeIFx4lJyi77Bw9PZmfVHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mivEodN8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D1KOZusG; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mivEodN8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D1KOZusG"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id BB6E911400CC;
	Fri, 18 Oct 2024 08:23:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 18 Oct 2024 08:23:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729254233; x=1729340633; bh=vQ0P9RXh3Q
	ARpaks9+WGYvlmRKkpmcmsxdDSH34O/sE=; b=mivEodN8LYplJDACBI9HoBc5ps
	irTS0i1a/qjZqxLfjINF3PWZ0nyPeBdd3Y8R+R42OCBrqISSEhSmvZ9t2VuJI3eO
	lkLwpkjdAXyp3E/q4HhyYJUlbpl3i+E+n/jmCZTx2oMxRRU95c3B/p/DVb2Prodl
	UDpxhiO598ug0MyQUx3fGevptoyp/rxvTnn3Faep7ozYwMYZjXslaGRajbG8ZT/E
	t35+wRn0KIiMKqj+lAjq5iCJ3H8f4QeeyADKOJKDcXDASvNmAnU94LtjoP48r1yI
	0aQEGm4UgyCPszwZfjIk8nDj8U+lL0DHXmpCQwQuce+Esbo3AZgeD0hQeFJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729254233; x=1729340633; bh=vQ0P9RXh3QARpaks9+WGYvlmRKkp
	mcmsxdDSH34O/sE=; b=D1KOZusGE7vl/DsBZCb8+Chl8KHuEgXBGbpw/e0g/0Jc
	UPBsgRiOVu7EHq3yoMrZKlB04JDPsya29DdUac1w4yE3g0LiykR9Zrm9HxA7SLlL
	6X0wz3IQJs505IAD1bAGpoYxuIzA20+tUBtqdaP7znXYj4tmpTGPH9Mb11Bs/Ns2
	MINUgfofHOn9pb/ZP383Oxl/3iTLpn9AMDPqqs9sF0W4j7uOCK4bi3E6h/8O3MFv
	2Amfn1bmcp+7xLJ9xXLgURlMhoF5jm4aeKqxBUhXRadOR9VV9P9FWnC93hvyn99I
	yG8qzae5slTFhjMHYiYkA5G0dnCI9QFtb680V/Nvjw==
X-ME-Sender: <xms:WFMSZ2uk9JJE5wpWjyzPwxdGZEon-QJJtdopAPVREflUKduKQbhQeA>
    <xme:WFMSZ7c_fAJoBp_V6QkDXbop4UB17vVox-iLYPV1lxP-UOsXAN7QorZFQrhrPioqm
    2McOWcFLeFubTV8YQ>
X-ME-Received: <xmr:WFMSZxzjORZLrmd8I5yOHAasS-hYzDKsvRJAAjfqL0bdDBh8MG7mGc8_JYAWn-Rs3zUkFWUAVfPKEa1D1eG44ao_jvpTirjUn4UXWEumN6PH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepkedutdetheeggedvhfdukeehtedttdduvedugeeiveei
    vedtffdvkedtjedtheehnecuffhomhgrihhnpehgihhtlhgrsgdrtghomhdpghhithhfoh
    hrfihinhguohifshdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvg
    epshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhr
    tghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprh
    gtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:WFMSZxNHZGNheEybpDmWxJZu0kKUbcAXbTHX-E9oLL49sMgjNJdn_Q>
    <xmx:WFMSZ28ZVaVTiWXt9_FaYjucQVdBw8hHXXMUvYFEJuVbouFOL-scNg>
    <xmx:WFMSZ5UqUA9xggnI-bU0rJMoTjY_WzbZQgihCIoAZLQOS_WIn4hlZw>
    <xmx:WFMSZ_eQXXVDXA6T7FKI3AZccvuoDYsun-xjeZ-Q4JHAz9N4Co_4Ug>
    <xmx:WVMSZ2z6T4XlRAUWxwOFS7ap8yT1tviiewZqWqQ5GveDuItDIyl7wVjJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Oct 2024 08:23:51 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ae2a10f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 18 Oct 2024 12:22:26 +0000 (UTC)
Date: Fri, 18 Oct 2024 14:23:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH v3 00/15] Modernize the build system
Message-ID: <cover.1729254070.git.ps@pks.im>
References: <cover.1727881164.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727881164.git.ps@pks.im>

Hi,

this is the third version of my patch series that aims to modernize our
build system infrastructure. It refactors our existing build infra to be
ready for out-of-tree builds and then wires up Meson.

Changes compared to v2:

  - I have split out semi-related changes like the platform
    compatibility fixes into separate series. More on that further down
    below, where I explain the current base.

  - I have polished the CMake-related changes I've been doing as prereqs
    while refactoring our build system. Some of the changes weren't
    tested before, but now CMake works as expected.

  - Fixed up some dependencies in our Makefile, as I didn't amend them
    to depend on the new generator scripts.

  - I have extracted some more scripts to massage our Perl library code,
    shells cripts and gitweb.cgi such that they can be used by Make,
    CMake and Meson. This also fixes generation of "gitweb.cgi" on
    Meson as reported by Ramsay.

  - I have fixed the cyclic dependency in our Makefile that I have
    introduced with v2.

  - I have addressed some feedback regarding "build-systems.txt".

  - I have made things work with OpenBSD 7.6.

  - Things now work on Cygwin and MinGW64 as expected, no more test
    failures except for t9700, which also fails with our Makefile.

  - I have improved how we set up the required tooling on Windows such
    that we detect Git for Windows-provided tools as we do with CMake.
    Like this, VS Code can now trivially import the Meson project and
    configure it. Furthermore, generation of the Visual Studio solution
    is trivial as well. So overall, things work fine now on all the
    important Windows environments that I'm aware of.

  - Several smaller fixes all over the place.

I've included a range-diff, but it's quite crowded overall.

In general I think that this is in a pretty good shape now. I have
tested things on NixOS, macOS 10.15, OpenBSD 7.6, FreeBSD 14.1, Windows
10 with MSVC, VS Code, MinGW and Cygwin, and things are generally smooth
and just work. I'm sure there's still going to be weirdnesses on some
platforms regardless of that.

This series is based on 15030f9556 (The second batch, 2024-10-15) and
has the following dependencies:

  - ps/cmake-clar at c6d3e52c91 (cmake: set up proper
    dependencies for generated clar headers, 2024-10-15).

  - ps/upgrade-clar at f3501edb0e (Makefile: adjust sed command for
    generating "clar-decls.h", 2024-10-14).

  - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
    FreeBSD, 2024-10-16).

These deps are mostly just there to make tests pass on all platforms,
but I wouldn't want folks to go test things and discover breakage that
is not caused by Meson itself :) You can also find this version of the
patch series at [1], branch "pks-meson-v3". @Taylor, I'm fine with
keeping this out of "seen" if you prefer to wait for those dependencies
to land first.

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git.git

Patrick Steinhardt (15):
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
  t: better support for out-of-tree builds
  t: allow overriding build dir
  Documentation: add comparison of build systems
  Introduce support for the Meson build system

 .gitignore                                    |    1 -
 Documentation/CodingGuidelines                |    2 +-
 Documentation/Makefile                        |    1 +
 Documentation/technical/build-systems.txt     |  224 +++
 GIT-BUILD-OPTIONS.in                          |   47 +
 GIT-VERSION-GEN                               |   12 +-
 Makefile                                      |  208 +--
 bin-wrappers/.gitignore                       |    9 +
 bin-wrappers/meson.build                      |   28 +
 bin-wrappers/wrap-for-bin.sh                  |   37 +
 configure.ac                                  |    2 +-
 contrib/buildsystems/CMakeLists.txt           |  218 ++-
 contrib/completion/meson.build                |    8 +
 contrib/meson.build                           |    1 +
 generate-cmdlist.sh                           |   42 +-
 generate-configlist.sh                        |   20 +-
 generate-hooklist.sh                          |   15 +-
 generate-perl.sh                              |   36 +
 generate-script.sh                            |   34 +
 git-cvsserver.perl                            |    2 +-
 git-instaweb.sh                               |    8 +-
 git-request-pull.sh                           |    2 +-
 git-send-email.perl                           |    2 +-
 git-sh-i18n.sh                                |    6 +-
 git-sh-setup.sh                               |    6 +-
 git-svn.perl                                  |    2 +-
 gitk-git/po/vi.po                             |    2 +-
 gitweb/GITWEB-BUILD-OPTIONS.in                |   25 +
 gitweb/Makefile                               |   58 +-
 gitweb/generate-gitweb.sh                     |   45 +
 gitweb/gitweb.perl                            |   44 +-
 gitweb/meson.build                            |   63 +
 meson.build                                   | 1614 +++++++++++++++++
 meson_options.txt                             |   70 +
 perl/FromCPAN/Mail/meson.build                |    7 +
 perl/FromCPAN/meson.build                     |    9 +
 perl/Git/I18N.pm                              |    6 +-
 perl/Git/LoadCPAN.pm                          |    6 +-
 perl/Git/LoadCPAN/Mail/meson.build            |    7 +
 perl/Git/LoadCPAN/meson.build                 |    9 +
 perl/Git/SVN/Memoize/meson.build              |    7 +
 perl/Git/SVN/meson.build                      |   20 +
 perl/Git/meson.build                          |   18 +
 .../header_templates/fixed_prefix.template.pl |    2 +-
 .../runtime_prefix.template.pl                |    8 +-
 perl/meson.build                              |   12 +
 po/meson.build                                |   28 +
 subprojects/.gitignore                        |    1 +
 subprojects/curl.wrap                         |   13 +
 subprojects/expat.wrap                        |   13 +
 subprojects/openssl.wrap                      |   15 +
 subprojects/pcre2.wrap                        |   16 +
 subprojects/zlib.wrap                         |   13 +
 t/helper/meson.build                          |   91 +
 t/lib-gettext.sh                              |    4 +-
 t/meson.build                                 | 1103 +++++++++++
 t/t7609-mergetool--lib.sh                     |    2 +-
 t/test-lib.sh                                 |   22 +-
 templates/Makefile                            |   39 +-
 templates/branches--                          |    1 -
 templates/{this--description => description}  |    0
 .../applypatch-msg.sample}                    |    0
 .../commit-msg.sample}                        |    0
 .../fsmonitor-watchman.sample}                |    0
 templates/hooks/meson.build                   |   24 +
 .../post-update.sample}                       |    0
 .../pre-applypatch.sample}                    |    0
 .../pre-commit.sample}                        |    0
 .../pre-merge-commit.sample}                  |    0
 .../pre-push.sample}                          |    0
 .../pre-rebase.sample}                        |    0
 .../pre-receive.sample}                       |    0
 .../prepare-commit-msg.sample}                |    0
 .../push-to-checkout.sample}                  |    0
 .../sendemail-validate.sample}                |    0
 .../update.sample}                            |    0
 templates/{info--exclude => info/exclude}     |    0
 templates/info/meson.build                    |    5 +
 templates/meson.build                         |   13 +
 unimplemented.sh                              |    2 +-
 wrap-for-bin.sh                               |   36 -
 81 files changed, 4040 insertions(+), 406 deletions(-)
 create mode 100644 Documentation/technical/build-systems.txt
 create mode 100644 GIT-BUILD-OPTIONS.in
 create mode 100644 bin-wrappers/.gitignore
 create mode 100644 bin-wrappers/meson.build
 create mode 100755 bin-wrappers/wrap-for-bin.sh
 create mode 100644 contrib/completion/meson.build
 create mode 100644 contrib/meson.build
 create mode 100755 generate-perl.sh
 create mode 100755 generate-script.sh
 create mode 100644 gitweb/GITWEB-BUILD-OPTIONS.in
 create mode 100755 gitweb/generate-gitweb.sh
 create mode 100644 gitweb/meson.build
 create mode 100644 meson.build
 create mode 100644 meson_options.txt
 create mode 100644 perl/FromCPAN/Mail/meson.build
 create mode 100644 perl/FromCPAN/meson.build
 create mode 100644 perl/Git/LoadCPAN/Mail/meson.build
 create mode 100644 perl/Git/LoadCPAN/meson.build
 create mode 100644 perl/Git/SVN/Memoize/meson.build
 create mode 100644 perl/Git/SVN/meson.build
 create mode 100644 perl/Git/meson.build
 create mode 100644 perl/meson.build
 create mode 100644 po/meson.build
 create mode 100644 subprojects/.gitignore
 create mode 100644 subprojects/curl.wrap
 create mode 100644 subprojects/expat.wrap
 create mode 100644 subprojects/openssl.wrap
 create mode 100644 subprojects/pcre2.wrap
 create mode 100644 subprojects/zlib.wrap
 create mode 100644 t/helper/meson.build
 create mode 100644 t/meson.build
 delete mode 100644 templates/branches--
 rename templates/{this--description => description} (100%)
 rename templates/{hooks--applypatch-msg.sample => hooks/applypatch-msg.sample} (100%)
 rename templates/{hooks--commit-msg.sample => hooks/commit-msg.sample} (100%)
 rename templates/{hooks--fsmonitor-watchman.sample => hooks/fsmonitor-watchman.sample} (100%)
 create mode 100644 templates/hooks/meson.build
 rename templates/{hooks--post-update.sample => hooks/post-update.sample} (100%)
 rename templates/{hooks--pre-applypatch.sample => hooks/pre-applypatch.sample} (100%)
 rename templates/{hooks--pre-commit.sample => hooks/pre-commit.sample} (100%)
 rename templates/{hooks--pre-merge-commit.sample => hooks/pre-merge-commit.sample} (100%)
 rename templates/{hooks--pre-push.sample => hooks/pre-push.sample} (100%)
 rename templates/{hooks--pre-rebase.sample => hooks/pre-rebase.sample} (100%)
 rename templates/{hooks--pre-receive.sample => hooks/pre-receive.sample} (100%)
 rename templates/{hooks--prepare-commit-msg.sample => hooks/prepare-commit-msg.sample} (100%)
 rename templates/{hooks--push-to-checkout.sample => hooks/push-to-checkout.sample} (100%)
 rename templates/{hooks--sendemail-validate.sample => hooks/sendemail-validate.sample} (100%)
 rename templates/{hooks--update.sample => hooks/update.sample} (100%)
 rename templates/{info--exclude => info/exclude} (100%)
 create mode 100644 templates/info/meson.build
 create mode 100644 templates/meson.build
 delete mode 100644 wrap-for-bin.sh

Range-diff against v2:
 1:  6dd59db9b2b <  -:  ----------- t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
 2:  5ec91ac12da <  -:  ----------- t/test-lib: wire up NO_ICONV prerequisite
 3:  94664e2cc06 <  -:  ----------- t/lib-gitweb: test against the build version of gitweb
 4:  ffb661dad71 <  -:  ----------- t/lib-gpg: fix setup of GNUPGHOME in MinGW
 5:  958cf3a6b57 <  -:  ----------- t1401: make invocation of tar(1) work with Win32-provided one
 6:  bada3a82fdd <  -:  ----------- t3404: work around platform-specific behaviour on macOS 10.15
 7:  b4bdefe9e34 <  -:  ----------- t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 8:  48ce19d876f <  -:  ----------- t7300: work around platform-specific behaviour with long paths on MinGW
 9:  73b4362164a <  -:  ----------- t/unit-tests: update clar unit test framework
10:  161f6b063af <  -:  ----------- builtin/credential-cache: fix missing parameter for stub function
11:  e4ef4bdf1c5 <  -:  ----------- http: fix build error on FreeBSD
12:  6ea97bc92f2 <  -:  ----------- Makefile: extract script to generate clar declarations
16:  dbf9e39e3df =  1:  800fb080f45 Makefile: use common template for GIT-BUILD-OPTIONS
17:  97b9789dd68 !  2:  1a4a23c66ca Makefile: consistently use @PLACEHOLDER@ to substitute
    @@ Makefile: GIT-SCRIPT-DEFINES: FORCE
          $@.sh >$@+
      endef
      
    +@@ Makefile: $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
    + 	    -e '	r GIT-PERL-HEADER' \
    + 	    -e '	G' \
    + 	    -e '}' \
    +-	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
    ++	    -e 's/@GIT_VERSION@/$(GIT_VERSION)/g' \
    + 	    $< >$@+ && \
    + 	chmod +x $@+ && \
    + 	mv $@+ $@
     @@ Makefile: GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
      	INSTLIBDIR='$(perllibdir_SQ)' && \
      	INSTLIBDIR_EXTRA='$(PERLLIB_EXTRA_SQ)' && \
    @@ contrib/buildsystems/CMakeLists.txt: set(wrapper_test_scripts
      
      #options for configuring test options
     
    - ## generate-perl.sh ##
    -@@ generate-perl.sh: sed -e '1{' \
    -     -e "	r $PERL_HEADER" \
    -     -e '	G' \
    -     -e '}' \
    --    -e "s/@@GIT_VERSION@@/$GIT_VERSION/g" \
    -+    -e "s/@GIT_VERSION@/$GIT_VERSION/g" \
    -     "$PERL_SCRIPT" >"$OUT"
    - chmod a+x "$OUT"
    -
      ## git-cvsserver.perl ##
     @@
      use File::Basename;
18:  1ee9c61fc33 =  3:  8261f108968 Makefile: consistently use PERL_PATH
13:  7f567d7ce23 !  4:  4894179b948 Makefile: extract script to massage Perl scripts
    @@ Commit message
     
      ## Makefile ##
     @@ Makefile: endif
    + 
      PERL_DEFINES += $(gitexecdir) $(perllibdir) $(localedir)
      
    - $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
    +-$(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
     -	$(QUIET_GEN) \
     -	sed -e '1{' \
     -	    -e '	s|#!.*perl|#!$(PERL_PATH_SQ)|' \
     -	    -e '	r GIT-PERL-HEADER' \
     -	    -e '	G' \
     -	    -e '}' \
    --	    -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
    +-	    -e 's/@GIT_VERSION@/$(GIT_VERSION)/g' \
     -	    $< >$@+ && \
     -	chmod +x $@+ && \
    -+	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh $(GIT_VERSION) GIT-PERL-HEADER "$(PERL_PATH_SQ)" "$<" "$@+" && \
    ++$(SCRIPT_PERL_GEN): % : %.perl generate-perl.sh GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
    ++	$(QUIET_GEN)$(SHELL_PATH) generate-perl.sh ./GIT-BUILD-OPTIONS $(GIT_VERSION) GIT-PERL-HEADER "$<" "$@+" && \
      	mv $@+ $@
      
      PERL_DEFINES := $(subst $(space),:,$(PERL_DEFINES))
     
    + ## contrib/buildsystems/CMakeLists.txt ##
    +@@ contrib/buildsystems/CMakeLists.txt: foreach(script ${git_shell_scripts})
    + endforeach()
    + 
    + #perl scripts
    +-parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" ".perl")
    ++parse_makefile_for_scripts(git_perl_scripts "SCRIPT_PERL" "")
    + 
    + #create perl header
    + file(STRINGS ${CMAKE_SOURCE_DIR}/perl/header_templates/fixed_prefix.template.pl perl_header )
    + string(REPLACE "@PATHSEP@" ":" perl_header "${perl_header}")
    + string(REPLACE "@INSTLIBDIR@" "${INSTLIBDIR}" perl_header "${perl_header}")
    ++file(WRITE ${CMAKE_BINARY_DIR}/PERL-HEADER ${perl_header})
    + 
    + foreach(script ${git_perl_scripts})
    +-	file(STRINGS ${CMAKE_SOURCE_DIR}/${script}.perl content NEWLINE_CONSUME)
    +-	string(REPLACE "#!/usr/bin/perl" "#!/usr/bin/perl\n${perl_header}\n" content "${content}")
    +-	string(REPLACE "@GIT_VERSION@" "${PROJECT_VERSION}" content "${content}")
    +-	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
    ++	string(REPLACE ".perl" "" perl_gen_path "${script}")
    ++
    ++	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${perl_gen_path}
    ++		COMMAND ${CMAKE_SOURCE_DIR}/generate-perl.sh
    ++			${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS
    ++			${PROJECT_VERSION}
    ++			${CMAKE_BINARY_DIR}/PERL-HEADER
    ++			${CMAKE_SOURCE_DIR}/${script}
    ++			${CMAKE_BINARY_DIR}/${perl_gen_path}
    ++		DEPENDS ${CMAKE_SOURCE_DIR}/generate-perl.sh
    ++			${CMAKE_SOURCE_DIR}/${script})
    ++	list(APPEND perl_gen ${CMAKE_BINARY_DIR}/${perl_gen_path})
    + endforeach()
    ++add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
    + 
    + #python script
    + file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
    +
      ## generate-perl.sh (new) ##
     @@
     +#!/bin/sh
     +
    ++set -e
    ++
     +if test $# -ne 5
     +then
    -+	echo "USAGE: $0 <GIT_VERSION> <PERL_HEADER> <PERL_PATH> <PERL_SCRIPT> <OUT>" >&2
    ++	echo "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION> <PERL_HEADER> <INPUT> <OUTPUT>" >&2
     +	exit 1
     +fi
     +
    -+GIT_VERSION="$1"
    -+PERL_HEADER="$2"
    -+PERL_PATH="$3"
    -+PERL_SCRIPT="$4"
    -+OUT="$5"
    ++GIT_BUILD_OPTIONS="$1"
    ++GIT_VERSION="$2"
    ++PERL_HEADER="$3"
    ++INPUT="$4"
    ++OUTPUT="$5"
    ++
    ++. "$GIT_BUILD_OPTIONS"
     +
     +sed -e '1{' \
     +    -e "	s|#!.*perl|#!$PERL_PATH|" \
     +    -e "	r $PERL_HEADER" \
     +    -e '	G' \
     +    -e '}' \
    -+    -e "s/@@GIT_VERSION@@/$GIT_VERSION/g" \
    -+    "$PERL_SCRIPT" >"$OUT"
    -+chmod a+x "$OUT"
    ++    -e "s/@GIT_VERSION@/$GIT_VERSION/g" \
    ++    "$INPUT" >"$OUTPUT"
    ++chmod a+x "$OUTPUT"
 -:  ----------- >  5:  b40bc302291 Makefile: use "generate-perl.sh" to massage Perl library
 -:  ----------- >  6:  c13ce99be3a Makefile: extract script to massage Shell scripts
 -:  ----------- >  7:  ebffd855836 Makefile: extract script to generate gitweb.cgi
14:  dfc941cd18d !  8:  d2cdfad10f5 Makefile: refactor GIT-VERSION-GEN to be reusable
    @@ Commit message
         easier to compute the same version as our Makefile would without having
         to write the "GIT-VERSION-FILE".
     
    -    We should ideally refactor our CMake build instructions to stop writing
    -    into the source directory. But this step is out of scope of the current
    -    patch series.
    -
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## GIT-VERSION-GEN ##
    @@ GIT-VERSION-GEN
      #!/bin/sh
      
     -GVF=GIT-VERSION-FILE
    - DEF_VER=v2.47.0
    + DEF_VER=v2.47.GIT
      
      LF='
     @@ GIT-VERSION-GEN: fi
    @@ Makefile: include shared.mak
      # Set our default configuration.
     
      ## contrib/buildsystems/CMakeLists.txt ##
    -@@ contrib/buildsystems/CMakeLists.txt: endif()
    - if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
    - 	message("Generating GIT-VERSION-FILE")
    - 	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
    --		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
    -+		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    -+		OUTPUT_VARIABLE GIT_VERSION
    -+		OUTPUT_STRIP_TRAILING_WHITESPACE)
    -+	file(WRITE ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "GIT_VERSION = '${GIT_VERSION}'\n")
    +@@ contrib/buildsystems/CMakeLists.txt: if(NOT SH_EXE)
    + 			"On Windows, you can get it as part of 'Git for Windows' install at https://gitforwindows.org/")
      endif()
      
    +-#Create GIT-VERSION-FILE using GIT-VERSION-GEN
    +-if(NOT EXISTS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE)
    +-	message("Generating GIT-VERSION-FILE")
    +-	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
    +-		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
    +-endif()
    ++execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
    ++	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    ++	OUTPUT_VARIABLE git_version
    ++	OUTPUT_STRIP_TRAILING_WHITESPACE)
    + 
      #Parse GIT-VERSION-FILE to get the version
    +-file(STRINGS ${CMAKE_SOURCE_DIR}/GIT-VERSION-FILE git_version REGEX "GIT_VERSION = (.*)")
    +-string(REPLACE "GIT_VERSION = " "" git_version ${git_version})
    + string(FIND ${git_version} "GIT" location)
    + if(location EQUAL -1)
    + 	string(REGEX MATCH "[0-9]*\\.[0-9]*\\.[0-9]*" git_version ${git_version})
15:  e468d3751f0 !  9:  9be0719ce1b Makefile: refactor generators to be PWD-independent
    @@ contrib/buildsystems/CMakeLists.txt: set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS
     -	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh
     -			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
     -			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
    -+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/config.list)
    ++	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/config-list.h)
      endif()
      
      if(NOT EXISTS ${CMAKE_BINARY_DIR}/hook-list.h)
19:  9fd1aeb1e96 ! 10:  93869e53178 Makefile: allow "bin-wrappers/" directory to exist
    @@ Makefile: test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_
      
     -bin-wrappers/%: wrap-for-bin.sh
     -	$(call mkdir_p_parent_template)
    -+bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
    ++$(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
      	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
      	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
      	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
20:  4eda54cf0f5 ! 11:  1c37d6d1f19 Makefile: simplify building of templates
    @@ Commit message
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## contrib/buildsystems/CMakeLists.txt ##
    -@@ contrib/buildsystems/CMakeLists.txt: endforeach()
    +@@ contrib/buildsystems/CMakeLists.txt: project(git
    + #TODO Enable NLS on windows natively
      
    + #macros for parsing the Makefile for sources and scripts
    +-macro(parse_makefile_for_sources list_var regex)
    +-	file(STRINGS ${CMAKE_SOURCE_DIR}/Makefile ${list_var} REGEX "^${regex} \\+=(.*)")
    ++macro(parse_makefile_for_sources list_var makefile regex)
    ++	file(STRINGS ${makefile} ${list_var} REGEX "^${regex} \\+=(.*)")
    + 	string(REPLACE "${regex} +=" "" ${list_var} ${${list_var}})
    + 	string(REPLACE "$(COMPAT_OBJS)" "" ${list_var} ${${list_var}}) #remove "$(COMPAT_OBJS)" This is only for libgit.
    + 	string(STRIP ${${list_var}} ${list_var}) #remove trailing/leading whitespaces
    +@@ contrib/buildsystems/CMakeLists.txt: include_directories(${CMAKE_BINARY_DIR})
      
    - #templates
    --file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
    -+file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/**")
    - list(TRANSFORM templates REPLACE "${CMAKE_SOURCE_DIR}/templates/" "")
    - list(REMOVE_ITEM templates ".gitignore")
    - list(REMOVE_ITEM templates "Makefile")
    - list(REMOVE_ITEM templates "blt")# Prevents an error when reconfiguring for in source builds
    + #build
    + #libgit
    +-parse_makefile_for_sources(libgit_SOURCES "LIB_OBJS")
    ++parse_makefile_for_sources(libgit_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "LIB_OBJS")
    + 
    + list(TRANSFORM libgit_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + list(TRANSFORM compat_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + add_library(libgit ${libgit_SOURCES} ${compat_SOURCES})
    + 
    + #libxdiff
    +-parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
    ++parse_makefile_for_sources(libxdiff_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "XDIFF_OBJS")
    + 
    + list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + add_library(xdiff STATIC ${libxdiff_SOURCES})
    + 
    + #reftable
    +-parse_makefile_for_sources(reftable_SOURCES "REFTABLE_OBJS")
    ++parse_makefile_for_sources(reftable_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "REFTABLE_OBJS")
    + 
    + list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + add_library(reftable STATIC ${reftable_SOURCES})
    +@@ contrib/buildsystems/CMakeLists.txt: elseif(UNIX)
    + endif()
    + 
    + #git
    +-parse_makefile_for_sources(git_SOURCES "BUILTIN_OBJS")
    ++parse_makefile_for_sources(git_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "BUILTIN_OBJS")
      
    + list(TRANSFORM git_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
    + add_executable(git ${CMAKE_SOURCE_DIR}/git.c ${git_SOURCES})
    +@@ contrib/buildsystems/CMakeLists.txt: file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
    + string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
    + file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
    + 
    +-#templates
    +-file(GLOB templates "${CMAKE_SOURCE_DIR}/templates/*")
    +-list(TRANSFORM templates REPLACE "${CMAKE_SOURCE_DIR}/templates/" "")
    +-list(REMOVE_ITEM templates ".gitignore")
    +-list(REMOVE_ITEM templates "Makefile")
    +-list(REMOVE_ITEM templates "blt")# Prevents an error when reconfiguring for in source builds
    +-
     -list(REMOVE_ITEM templates "branches--")
     -file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/templates/blt/branches) #create branches
     -
    ++#${CMAKE_SOURCE_DIR}/Makefile templates
    ++parse_makefile_for_sources(templates ${CMAKE_SOURCE_DIR}/templates/Makefile "TEMPLATES")
    ++string(REPLACE " " ";" templates ${templates})
      #templates have @.*@ replacement so use configure_file instead
      foreach(tm ${templates})
     -	string(REPLACE "--" "/" blt_tm ${tm})
     -	string(REPLACE "this" "" blt_tm ${blt_tm})# for this--
    - 	configure_file(${CMAKE_SOURCE_DIR}/templates/${tm} ${CMAKE_BINARY_DIR}/templates/blt/${blt_tm} @ONLY)
    +-	configure_file(${CMAKE_SOURCE_DIR}/templates/${tm} ${CMAKE_BINARY_DIR}/templates/blt/${blt_tm} @ONLY)
    ++	configure_file(${CMAKE_SOURCE_DIR}/templates/${tm} ${CMAKE_BINARY_DIR}/templates/blt/${tm} @ONLY)
      endforeach()
      
     -
      #translations
      if(MSGFMT_EXE)
      	file(GLOB po_files "${CMAKE_SOURCE_DIR}/po/*.po")
    +@@ contrib/buildsystems/CMakeLists.txt: add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
    + target_link_libraries(test-fake-ssh common-main)
    + 
    + #unit-tests
    +-parse_makefile_for_sources(unit-test_SOURCES "UNIT_TEST_OBJS")
    ++parse_makefile_for_sources(unit-test_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "UNIT_TEST_OBJS")
    + list(TRANSFORM unit-test_SOURCES REPLACE "\\$\\(UNIT_TEST_DIR\\)/" "${CMAKE_SOURCE_DIR}/t/unit-tests/")
    + add_library(unit-test-lib STATIC ${unit-test_SOURCES})
    + 
    +@@ contrib/buildsystems/CMakeLists.txt: if(MSVC)
    + endif()
    + 
    + #test-tool
    +-parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
    ++parse_makefile_for_sources(test-tool_SOURCES ${CMAKE_SOURCE_DIR}/Makefile "TEST_BUILTINS_OBJS")
    + add_library(test-lib OBJECT ${CMAKE_SOURCE_DIR}/t/unit-tests/test-lib.c)
    + 
    + list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
     
      ## templates/Makefile ##
     @@ templates/Makefile: all: boilerplates.made custom
    @@ templates/Makefile: all: boilerplates.made custom
     -boilerplates.made : $(bpsrc)
     -	$(QUIET)umask 022 && ls *--* 2>/dev/null | \
     -	while read boilerplate; \
    -+TEMPLATES  = description
    ++TEMPLATES  =
    ++TEMPLATES += description
     +TEMPLATES += hooks/applypatch-msg.sample
     +TEMPLATES += hooks/commit-msg.sample
     +TEMPLATES += hooks/fsmonitor-watchman.sample
21:  1172c440600 ! 12:  c45d2df6b8d t: better support for out-of-tree builds
    @@ GIT-BUILD-OPTIONS.in: GIT_PERF_MAKE_COMMAND=@GIT_PERF_MAKE_COMMAND@
     +GIT_TEST_GITPERLLIB=@GIT_TEST_GITPERLLIB@
     +GIT_TEST_MERGE_TOOLS_DIR=@GIT_TEST_MERGE_TOOLS_DIR@
      RUNTIME_PREFIX=@RUNTIME_PREFIX@
    + GITWEBDIR=@GITWEBDIR@
    + USE_GETTEXT_SCHEME=@USE_GETTEXT_SCHEME@
     
      ## Makefile ##
     @@ Makefile: GIT-BUILD-OPTIONS: FORCE
    @@ Makefile: GIT-BUILD-OPTIONS: FORCE
     +		-e "s|@GIT_TEST_GITPERLLIB@|\'$(shell pwd)/perl/build/lib\'|" \
     +		-e "s|@GIT_TEST_MERGE_TOOLS_DIR@|\'$(shell pwd)/mergetools\'|" \
      		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
    - 		GIT-BUILD-OPTIONS.in >$@+
    - 	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
    + 		-e "s|@GITWEBDIR@|\'$(gitwebdir_SQ)\'|" \
    + 		-e "s|@USE_GETTEXT_SCHEME@|\'$(USE_GETTEXT_SCHEME)\'|" \
     @@ Makefile: all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PR
    - bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
    + $(test_bindir_programs): bin-wrappers/%: bin-wrappers/wrap-for-bin.sh
      	$(QUIET_GEN)sed -e '1s|#!.*/sh|#!$(SHELL_PATH_SQ)|' \
      	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
     +	     -e 's|@GIT_TEXTDOMAINDIR@|$(shell pwd)/po/build/locale|' \
    @@ contrib/buildsystems/CMakeLists.txt: endforeach()
      string(REPLACE "@PROG@" "git-cvsserver" content "${content}")
      file(WRITE ${CMAKE_BINARY_DIR}/bin-wrappers/git-cvsserver ${content})
      
    -@@ contrib/buildsystems/CMakeLists.txt: string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_optio
    +@@ contrib/buildsystems/CMakeLists.txt: string(REPLACE "@GIT_PERF_MAKE_COMMAND@" "" git_build_options "${git_build_optio
    + string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" "" git_build_options "${git_build_options}")
      string(REPLACE "@GIT_TEST_INDEX_VERSION@" "" git_build_options "${git_build_options}")
      string(REPLACE "@GIT_TEST_PERL_FATAL_WARNINGS@" "" git_build_options "${git_build_options}")
    - string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
     +string(REPLACE "@GIT_TEST_TEXTDOMAINDIR@" "${CMAKE_BINARY_DIR}/po/build/locale" git_build_options "${git_build_options}")
     +string(REPLACE "@GIT_TEST_POPATH@" "${CMAKE_BINARY_DIR}/po" git_build_options "${git_build_options}")
     +string(REPLACE "@GIT_TEST_TEMPLATE_DIR@" "${CMAKE_BINARY_DIR}/templates/blt" git_build_options "${git_build_options}")
     +string(REPLACE "@GIT_TEST_GITPERLLIB@" "${CMAKE_BINARY_DIR}/perl/build/lib" git_build_options "${git_build_options}")
     +string(REPLACE "@GIT_TEST_MERGE_TOOLS_DIR@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
    - if(USE_VCPKG)
    - 	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
    - endif()
    + string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
    + string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" git_build_options "${git_build_options}")
    + string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
     
      ## t/lib-gettext.sh ##
     @@
22:  b5cd5250b77 = 13:  542b01515e1 t: allow overriding build dir
23:  afa2f79d46c ! 14:  bd59e31bb55 Documentation: add comparison of build systems
    @@ Documentation/technical/build-systems.txt (new)
     +== Requirements
     +
     +The following subsections present a list of requirements that we have for any
    -+potential build system. Sections are sorted by decreasing priority, even though
    -+these priorities will naturally differ between users.
    ++potential build system. Sections are sorted by decreasing priority.
     +
     +=== Platform support
     +
    -+The build system must have support for all of our primary platforms as outlined
    -+by. These platforms are:
    ++The build system must have support for all of our platforms that we continually
    ++test against as outlined by our platform support policy. These platforms are:
     +
     +  - Linux
     +  - Windows
     +  - macOS
     +
    -+Furthermore, the build system should have support for the following secondary
    -+platforms:
    ++Furthermore, the build system should have support for the following platforms
    ++that generally have somebody running test pipelines against regularly:
     +
     +  - AIX
     +  - FreeBSD
     +  - NetBSD
    ++  - NonStop
     +  - OpenBSD
     +
     +The platforms which must be supported by the tool should be aligned with our
    @@ Documentation/technical/build-systems.txt (new)
     +  - Detection of available features.
     +  - Discovery of relevant toolchains.
     +  - Linking libraries and executables.
    ++  - Templating placeholders in scripts.
     +
     +=== Test integration
     +
    @@ Documentation/technical/build-systems.txt (new)
     +  - Track build-time dependencies for respective tests. Unit tests have
     +    different requirements than integration tests.
     +  - Allow filtering of which tests to run.
    -+  - Allow interactive tests that drop the user into a shell with `test_pause` or
    -+    `debug`.
    ++  - Allow running tests such that utilities like `test_pause` or `debug` work.
     +
     +== Comparison
     +
24:  724232b0fad ! 15:  ac327d98e9c Introduce support for the Meson build system
    @@ Commit message
     
           - Apple macOS 10.15.
     
    -      - FreeBSD 14.1, except gitweb-based tests.
    +      - FreeBSD 14.1.
     
           - NixOS 24.11.
     
    +      - OpenBSD 7.6.
    +
           - Ubuntu 24.04.
     
    -      - Windows 10 with Cygwin, using `-Dperl=disabled -Dpython=disabled`.
    +      - Windows 10 with Cygwin.
    +
    +      - Windows 10 with MinGW64, except for t9700, which is also broken with
    +        our Makefile.
    +
    +      - Windows 10 with Visual Studio 2022 toolchain, using the Native Tools
    +        Command Prompt with `meson setup --vsenv`. Tests pass, except for
    +        t9700.
     
    -      - Windows 10 with MinGW64, using `-Dperl=disabled -Dpython=disabled`.
    +      - Windows 10 with Visual Studio 2022 solution, using the Native Tools
    +        Command Prompt with `meson setup --backend vs2022`. Tests pass,
    +        except for t9700.
     
    -      - Windows 10 with MSVC 2022, using `-Dperl=disabled -Dpython=disabled
    -        -Dgettext=disabled -Diconv=disabled --wrap-mode=forcefallback`.
    +      - Windows 10 with VS Code, using the Meson plug-in.
     
         It is expected that there will still be rough edges in the current
         version. If this patch lands the expectation is that it will coexist
    @@ Commit message
             dependencies preinstalled, and Meson will fetch and build them
             automatically. This is especially helpful on Windows.
     
    +    Helped-by: Eli Schwartz <eschwartz@gentoo.org>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## bin-wrappers/meson.build (new) ##
    @@ contrib/meson.build (new)
     
      ## gitweb/meson.build (new) ##
     @@
    ++gitweb_config = configuration_data()
    ++gitweb_config.set_quoted('PERL_PATH', perl.full_path())
    ++gitweb_config.set_quoted('CSSMIN', '')
    ++gitweb_config.set_quoted('JSMIN', '')
    ++gitweb_config.set_quoted('GIT_VERSION', git_version)
    ++gitweb_config.set_quoted('GIT_BINDIR', get_option('prefix') / get_option('bindir'))
    ++gitweb_config.set_quoted('GITWEB_CONFIG', get_option('gitweb_config'))
    ++gitweb_config.set_quoted('GITWEB_CONFIG_SYSTEM', get_option('gitweb_config_system'))
    ++gitweb_config.set_quoted('GITWEB_CONFIG_COMMON', get_option('gitweb_config_common'))
    ++gitweb_config.set_quoted('GITWEB_HOME_LINK_STR', get_option('gitweb_home_link_str'))
    ++gitweb_config.set_quoted('GITWEB_SITENAME', get_option('gitweb_sitename'))
    ++gitweb_config.set_quoted('GITWEB_PROJECTROOT', get_option('gitweb_projectroot'))
    ++gitweb_config.set_quoted('GITWEB_PROJECT_MAXDEPTH', get_option('gitweb_project_maxdepth'))
    ++gitweb_config.set_quoted('GITWEB_EXPORT_OK', get_option('gitweb_export_ok'))
    ++gitweb_config.set_quoted('GITWEB_STRICT_EXPORT', get_option('gitweb_strict_export'))
    ++gitweb_config.set_quoted('GITWEB_BASE_URL', get_option('gitweb_base_url'))
    ++gitweb_config.set_quoted('GITWEB_LIST', get_option('gitweb_list'))
    ++gitweb_config.set_quoted('GITWEB_HOMETEXT', get_option('gitweb_hometext'))
    ++gitweb_config.set_quoted('GITWEB_CSS', get_option('gitweb_css'))
    ++gitweb_config.set_quoted('GITWEB_LOGO', get_option('gitweb_logo'))
    ++gitweb_config.set_quoted('GITWEB_FAVICON', get_option('gitweb_favicon'))
    ++gitweb_config.set_quoted('GITWEB_JS', get_option('gitweb_js'))
    ++gitweb_config.set_quoted('GITWEB_SITE_HTML_HEAD_STRING', get_option('gitweb_site_html_head_string'))
    ++gitweb_config.set_quoted('GITWEB_SITE_HEADER', get_option('gitweb_site_header'))
    ++gitweb_config.set_quoted('GITWEB_SITE_FOOTER', get_option('gitweb_site_footer'))
    ++gitweb_config.set_quoted('HIGHLIGHT_BIN', get_option('highlight_bin'))
    ++
     +configure_file(
    ++  input: 'GITWEB-BUILD-OPTIONS.in',
    ++  output: 'GITWEB-BUILD-OPTIONS',
    ++  configuration: gitweb_config,
    ++)
    ++
    ++test_dependencies += custom_target(script,
     +  input: 'gitweb.perl',
     +  output: 'gitweb.cgi',
    -+  configuration: {
    -+    'GIT_VERSION': meson.project_version(),
    -+    'GIT_BINDIR': get_option('prefix') / get_option('bindir'),
    -+    'GITWEB_CONFIG': get_option('gitweb_config'),
    -+    'GITWEB_CONFIG_SYSTEM': get_option('gitweb_config_system'),
    -+    'GITWEB_CONFIG_COMMON': get_option('gitweb_config_common'),
    -+    'GITWEB_HOME_LINK_STR': get_option('gitweb_home_link_str'),
    -+    'GITWEB_SITENAME': get_option('gitweb_sitename'),
    -+    'GITWEB_PROJECTROOT': get_option('gitweb_projectroot'),
    -+    'GITWEB_PROJECT_MAXDEPTH': get_option('gitweb_project_maxdepth'),
    -+    'GITWEB_EXPORT_OK': get_option('gitweb_export_ok'),
    -+    'GITWEB_STRICT_EXPORT': get_option('gitweb_strict_export'),
    -+    'GITWEB_BASE_URL': get_option('gitweb_base_url'),
    -+    'GITWEB_LIST': get_option('gitweb_list'),
    -+    'GITWEB_HOMETEXT': get_option('gitweb_hometext'),
    -+    'GITWEB_CSS': get_option('gitweb_css'),
    -+    'GITWEB_LOGO': get_option('gitweb_logo'),
    -+    'GITWEB_FAVICON': get_option('gitweb_favicon'),
    -+    'GITWEB_JS': get_option('gitweb_js'),
    -+    'GITWEB_SITE_HTML_HEAD_STRING': get_option('gitweb_site_html_head_string'),
    -+    'GITWEB_SITE_HEADER': get_option('gitweb_site_header'),
    -+    'GITWEB_SITE_FOOTER': get_option('gitweb_site_footer'),
    -+    'HIGHLIGHT_BIN': get_option('highlight_bin'),
    -+  },
    ++  command: [
    ++    shell,
    ++    meson.current_source_dir() / 'generate-gitweb.sh',
    ++    meson.current_build_dir() / 'GITWEB-BUILD-OPTIONS',
    ++    '@INPUT@',
    ++    '@OUTPUT@',
    ++  ],
     +  install: true,
     +  install_dir: get_option('datadir') / 'gitweb',
     +)
     +
    -+subdir('static')
    -
    - ## gitweb/static/meson.build (new) ##
    -@@
     +foreach asset : [
    -+  'git-favicon.png',
    -+  'git-logo.png',
    -+  'gitweb.css',
    ++  'static/git-favicon.png',
    ++  'static/git-logo.png',
    ++  'static/gitweb.css',
    ++  'static/js/adjust-timezone.js',
    ++  'static/js/blame_incremental.js',
    ++  'static/js/javascript-detection.js',
    ++  'static/js/lib/common-lib.js',
    ++  'static/js/lib/cookies.js',
    ++  'static/js/lib/datetime.js',
     +]
     +  fs.copyfile(asset,
     +    install: true,
    -+    install_dir: get_option('datadir') / 'gitweb/static',
    ++    install_dir: get_option('datadir') / 'gitweb' / fs.parent(asset),
     +  )
     +endforeach
    -+
    -+javascript_sources = [
    -+  meson.current_source_dir() / 'js/adjust-timezone.js',
    -+  meson.current_source_dir() / 'js/blame_incremental.js',
    -+  meson.current_source_dir() / 'js/javascript-detection.js',
    -+  meson.current_source_dir() / 'js/lib/common-lib.js',
    -+  meson.current_source_dir() / 'js/lib/cookies.js',
    -+  meson.current_source_dir() / 'js/lib/datetime.js',
    -+]
    -+
    -+custom_target(
    -+  input: javascript_sources,
    -+  output: 'gitweb.js',
    -+  capture: true,
    -+  command: ['cat'] + javascript_sources,
    -+  install: true,
    -+  install_dir: get_option('datadir') / 'gitweb/static',
    -+)
     
      ## meson.build (new) ##
     @@
    @@ meson.build (new)
     +  # MSVC does not support GNU99, and C99 does not define __STDC_VERSION__
     +  # on MSVC. So we instead fall back to C11 there.
     +  default_options: ['c_std=gnu99,c11'],
    -+  version: run_command('GIT-VERSION-GEN', check: true).stdout().strip(),
    ++  version: 'v2.47.GIT',
     +)
     +
     +fs = import('fs')
     +
    -+compiler = meson.get_compiler('c')
    ++program_path = []
    ++# Git for Windows provides all the tools we need to build Git.
    ++if host_machine.system() == 'windows'
    ++  program_path += [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/usr/bin' ]
    ++endif
     +
    -+cygpath = find_program('cygpath', required: false)
    -+shell = find_program('sh')
    -+tar = find_program('tar')
    -+diff = find_program('diff')
    ++awk = find_program('awk', dirs: program_path)
    ++cygpath = find_program('cygpath', dirs: program_path, required: false)
    ++diff = find_program('diff', dirs: program_path)
    ++shell = find_program('sh', dirs: program_path)
    ++tar = find_program('tar', dirs: program_path)
    ++
    ++script_environment = environment()
    ++foreach tool : ['cat', 'cut', 'git', 'grep', 'sed', 'sort', 'tr', 'uname']
    ++  program = find_program(tool, dirs: program_path)
    ++  script_environment.prepend('PATH', fs.parent(program.full_path()))
    ++endforeach
    ++
    ++git_version = run_command(shell, 'GIT-VERSION-GEN', check: false, env: script_environment).stdout().strip()
    ++if git_version == ''
    ++  git_version = meson.project_version()
    ++endif
    ++
    ++compiler = meson.get_compiler('c')
     +
     +libgit_sources = [
     +  'abspath.c',
    @@ meson.build (new)
     +  'reftable/block.c',
     +  'reftable/blocksource.c',
     +  'reftable/iter.c',
    -+  'reftable/publicbasics.c',
     +  'reftable/merged.c',
     +  'reftable/pq.c',
     +  'reftable/reader.c',
    @@ meson.build (new)
     +  'builtin/write-tree.c',
     +]
     +
    -+script_environment = environment()
    -+foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
    -+  program = find_program(tool)
    -+  script_environment.prepend('PATH', fs.parent(program.full_path()))
    -+endforeach
    -+
     +libgit_sources += custom_target(
     +  'command-list.h',
     +  input: 'command-list.txt',
    @@ meson.build (new)
     +build_options_config.set('GIT_TEST_UTF8_LOCALE', '')
     +build_options_config.set('SANITIZE_ADDRESS', '')
     +build_options_config.set('SANITIZE_LEAK', '')
    ++build_options_config.set('BROKEN_PATH_FIX', '')
    ++build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
    ++build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
     +
     +test_output_directory = get_option('test_output_directory')
     +if test_output_directory == ''
    @@ meson.build (new)
     +
     +# Note that we only set NO_PERL if the Perl features were disabled by the user.
     +# It may not be set when we have found Perl, but only use it to run tests.
    -+perl = find_program('perl', version: '>=5.8.1', required: perl_required)
    ++perl = find_program('perl', version: '>=5.8.1', dirs: program_path, required: perl_required)
     +perl_features_enabled = perl.found() and get_option('perl').allowed()
     +if perl_features_enabled
     +  build_options_config.set('NO_PERL', '')
    ++
    ++  if get_option('runtime_prefix')
    ++    build_options_config.set('PERL_LOCALEDIR', '')
    ++  else
    ++    build_options_config.set_quoted('PERL_LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
    ++  endif
    ++
    ++  if get_option('perl_cpan_fallback')
    ++    build_options_config.set('NO_PERL_CPAN_FALLBACKS', '')
    ++  else
    ++    build_options_config.set_quoted('NO_PERL_CPAN_FALLBACKS', 'YesPlease')
    ++  endif
     +else
     +  libgit_c_args += '-DNO_PERL'
     +  build_options_config.set('NO_PERL', '1')
    ++  build_options_config.set('PERL_LOCALEDIR', '')
    ++  build_options_config.set('NO_PERL_CPAN_FALLBACKS', '')
     +endif
     +
     +zlib = dependency('zlib', default_options: ['default_library=static', 'tests=disabled'])
    -+if zlib.type_name() != 'internal' and not compiler.has_function('deflateBound',
    -+  prefix: '#include <zlib.h>',
    -+  dependencies: zlib,
    -+)
    ++if zlib.version().version_compare('<1.2.0')
     +  libgit_c_args += '-DNO_DEFLATE_BOUND'
     +endif
     +libgit_dependencies += zlib
    @@ meson.build (new)
     +if intl.found()
     +  libgit_dependencies += intl
     +  build_options_config.set('NO_GETTEXT', '')
    ++  build_options_config.set('USE_GETTEXT_SCHEME', '')
     +else
     +  libgit_c_args += '-DNO_GETTEXT'
     +  build_options_config.set('NO_GETTEXT', '1')
    ++  build_options_config.set('USE_GETTEXT_SCHEME', 'fallthrough')
     +endif
     +
     +iconv = dependency('iconv', required: get_option('iconv'))
    @@ meson.build (new)
     +libgit_version_library = static_library('git-version',
     +  sources: ['version.c'],
     +  c_args: libgit_c_args + [
    -+    '-DGIT_VERSION="' + meson.project_version() + '"',
    -+    '-DGIT_USER_AGENT="' + 'git/' + meson.project_version() + '"',
    ++    '-DGIT_VERSION="' + git_version + '"',
    ++    '-DGIT_USER_AGENT="' + 'git/' + git_version + '"',
     +    '-DGIT_BUILT_FROM_COMMIT="' + run_command('git', 'rev-parse', '-q', '--verify', 'HEAD', check: false).stdout().strip() + '"',
     +  ],
     +  dependencies: libgit_dependencies,
    @@ meson.build (new)
     +    '-DMINOR=1',
     +    '-DMICRO=1',
     +    '-DPATCHLEVEL=0',
    -+    '-DGIT_VERSION=\\\"' + meson.project_version() + '.GIT\\\"',
    ++    '-DGIT_VERSION=\\\"' + git_version + '.GIT\\\"',
     +  ])
     +  if compiler.get_argument_syntax() == 'gcc'
     +    common_main_link_args += [
    @@ meson.build (new)
     +  )
     +endforeach
     +
    -+script_sh_config = configuration_data()
    -+script_sh_config.set('BROKEN_PATH_FIX', '')
    -+script_sh_config.set('DIFF', fs.as_posix(diff.full_path()))
    -+script_sh_config.set('PAGER_ENV', get_option('pager_environment'))
    -+script_sh_config.set('PERL_PATH', perl.found() ? fs.as_posix(perl.full_path()) : '')
    -+script_sh_config.set('SHELL_PATH', fs.as_posix(shell.full_path()))
    -+script_sh_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
    -+if intl.found()
    -+  script_sh_config.set('USE_GETTEXT_SCHEME', '')
    -+else
    -+  script_sh_config.set('USE_GETTEXT_SCHEME', 'fallthrough')
    -+endif
    -+script_sh_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
    -+
     +scripts_sh = [
     +  'git-difftool--helper.sh',
     +  'git-filter-branch.sh',
     +  'git-merge-octopus.sh',
     +  'git-merge-one-file.sh',
     +  'git-merge-resolve.sh',
    ++  'git-mergetool--lib.sh',
     +  'git-mergetool.sh',
     +  'git-quiltimport.sh',
     +  'git-request-pull.sh',
    ++  'git-sh-i18n.sh',
    ++  'git-sh-setup.sh',
     +  'git-submodule.sh',
     +  'git-web--browse.sh',
     +]
    -+
     +if perl_features_enabled
     +  scripts_sh += 'git-instaweb.sh'
     +endif
     +
     +foreach script : scripts_sh
    -+  configure_file(
    ++  test_dependencies += custom_target(script,
     +    input: script,
     +    output: fs.stem(script),
    -+    configuration: script_sh_config,
    -+    install: true,
    -+    install_dir: get_option('libexecdir') / 'git-core',
    -+  )
    -+endforeach
    -+
    -+scripts_lib = [
    -+  'git-mergetool--lib.sh',
    -+  'git-sh-i18n.sh',
    -+  'git-sh-setup.sh',
    -+]
    -+
    -+foreach script : scripts_lib
    -+  configure_file(
    -+    input: script,
    -+    output: fs.stem(script),
    -+    configuration: script_sh_config,
    ++    command: [
    ++      shell,
    ++      meson.project_source_root() / 'generate-script.sh',
    ++      '@INPUT@',
    ++      '@OUTPUT@',
    ++      meson.project_build_root() / 'GIT-BUILD-OPTIONS',
    ++    ],
     +    install: true,
     +    install_dir: get_option('libexecdir') / 'git-core',
     +  )
    @@ meson.build (new)
     +    },
     +  )
     +
    ++  generate_perl_command = [
    ++    shell,
    ++    meson.project_source_root() / 'generate-perl.sh',
    ++    meson.project_build_root() / 'GIT-BUILD-OPTIONS',
    ++    git_version,
    ++    perl_header,
    ++    '@INPUT@',
    ++    '@OUTPUT@',
    ++  ]
    ++
     +  foreach script : scripts_perl
     +    generated_script = custom_target(script,
     +      input: script,
     +      output: fs.stem(script),
    -+      command: [
    -+        shell,
    -+        meson.project_source_root() / 'generate-perl.sh',
    -+        meson.project_version(),
    -+        perl_header,
    -+        perl.full_path(),
    -+        '@INPUT@',
    -+        '@OUTPUT@',
    -+      ],
    ++      command: generate_perl_command,
     +      install: true,
     +      install_dir: get_option('datadir') / 'perl5',
     +    )
    @@ meson_options.txt (new)
     +  description: 'Build helpers used to access remotes with the HTTP transport.')
     +option('expat', type: 'feature', value: 'enabled',
     +  description: 'Build helpers used to push to remotes with the HTTP transport.')
    -+option('gettext', type: 'feature', value: 'enabled',
    ++option('gettext', type: 'feature', value: 'auto',
     +  description: 'Build translation files.')
    -+option('iconv', type: 'feature', value: 'enabled',
    ++option('iconv', type: 'feature', value: 'auto',
     +  description: 'Support reencoding strings with different encodings.')
     +option('pcre2', type: 'feature', value: 'enabled',
     +  description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
    -+option('perl', type: 'feature', value: 'enabled',
    ++option('perl', type: 'feature', value: 'auto',
     +  description: 'Build tools written in Perl.')
     +option('perl_cpan_fallback', type: 'boolean', value: true,
     +  description: 'Install bundled copies of CPAN modules that serve as a fallback in case the modules are not available on the system.')
    -+option('python', type: 'feature', value: 'enabled',
    ++option('python', type: 'feature', value: 'auto',
     +  description: 'Build tools written in Python.')
     +
     +option('openssl', type: 'feature', value: 'auto',
    @@ meson_options.txt (new)
     
      ## perl/FromCPAN/Mail/meson.build (new) ##
     @@
    -+configure_file(
    ++test_dependencies += custom_target('Address.pm',
     +  input: 'Address.pm',
     +  output: 'Address.pm',
    -+  configuration: perl_config,
    ++  command: generate_perl_command,
     +  install: true,
     +  install_dir: get_option('datadir') / 'perl5/FromCPAN/Mail',
     +)
     
      ## perl/FromCPAN/meson.build (new) ##
     @@
    -+configure_file(
    ++test_dependencies += custom_target('Error.pm',
     +  input: 'Error.pm',
     +  output: 'Error.pm',
    -+  configuration: perl_config,
    ++  command: generate_perl_command,
     +  install: true,
     +  install_dir: get_option('datadir') / 'perl5/FromCPAN',
     +)
    @@ perl/FromCPAN/meson.build (new)
     
      ## perl/Git/LoadCPAN/Mail/meson.build (new) ##
     @@
    -+configure_file(
    ++test_dependencies += custom_target('Address.pm',
     +  input: 'Address.pm',
     +  output: 'Address.pm',
    -+  configuration: perl_config,
    ++  command: generate_perl_command,
     +  install: true,
     +  install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN/Mail',
     +)
     
      ## perl/Git/LoadCPAN/meson.build (new) ##
     @@
    -+configure_file(
    ++test_dependencies += custom_target('Error.pm',
     +  input: 'Error.pm',
     +  output: 'Error.pm',
    -+  configuration: perl_config,
    ++  command: generate_perl_command,
     +  install: true,
     +  install_dir: get_option('datadir') / 'perl5/Git/LoadCPAN',
     +)
    @@ perl/Git/LoadCPAN/meson.build (new)
     
      ## perl/Git/SVN/Memoize/meson.build (new) ##
     @@
    -+configure_file(
    ++test_dependencies += custom_target('YAML.pm',
     +  input: 'YAML.pm',
     +  output: 'YAML.pm',
    -+  configuration: perl_config,
    ++  command: generate_perl_command,
     +  install: true,
     +  install_dir: get_option('datadir') / 'perl5/Git/SVN',
     +)
    @@ perl/Git/SVN/meson.build (new)
     +  'Ra.pm',
     +  'Utils.pm',
     +]
    -+  configure_file(
    ++  test_dependencies += custom_target(source,
     +    input: source,
     +    output: source,
    -+    configuration: perl_config,
    ++    command: generate_perl_command,
     +    install: true,
     +    install_dir: get_option('datadir') / 'perl5/Git/SVN',
     +  )
    @@ perl/Git/meson.build (new)
     +  'Packet.pm',
     +  'SVN.pm',
     +]
    -+  configure_file(
    ++  test_dependencies += custom_target(source,
     +    input: source,
     +    output: source,
    -+    configuration: perl_config,
    ++    command: generate_perl_command,
     +    install: true,
     +    install_dir: get_option('datadir') / 'perl5/Git',
     +  )
    @@ perl/Git/meson.build (new)
     
      ## perl/meson.build (new) ##
     @@
    -+perl_config = {
    -+  'LOCALEDIR': get_option('prefix') / get_option('datadir') / 'locale',
    -+  'NO_GETTEXT': iconv.found() ? '' : '1',
    -+  'NO_PERL_CPAN_FALLBACKS': get_option('perl_cpan_fallback') ? '' : '1',
    -+}
    -+
    -+configure_file(
    ++test_dependencies += custom_target('Git.pm',
     +  input: 'Git.pm',
     +  output: 'Git.pm',
    -+  configuration: perl_config,
    ++  command: generate_perl_command,
     +  install: true,
     +  install_dir: get_option('datadir') / 'perl5',
     +)
    @@ po/meson.build (new)
     +)
     +test_dependencies += translations[0]
     
    + ## subprojects/.gitignore (new) ##
    +@@
    ++/*/
    +
      ## subprojects/curl.wrap (new) ##
     @@
     +[wrap-file]
    @@ t/helper/meson.build (new)
     
      ## t/meson.build (new) ##
     @@
    -+awk = find_program('awk')
    -+
     +clar_test_suites = [
     +  'unit-tests/ctype.c',
     +  'unit-tests/strvec.c',
    @@ templates/hooks/meson.build (new)
     +  configure_file(
     +    input: hook,
     +    output: hook,
    -+    configuration: script_sh_config,
    ++    configuration: template_config,
     +  )
     +endforeach
     
    @@ templates/info/meson.build (new)
     +configure_file(
     +  input: 'exclude',
     +  output: 'exclude',
    -+  configuration: script_sh_config,
    ++  configuration: template_config,
     +)
     
      ## templates/meson.build (new) ##
     @@
    ++template_config = configuration_data()
    ++template_config.set('PERL_PATH', perl.found() ? fs.as_posix(perl.full_path()) : '')
    ++template_config.set('SHELL_PATH', fs.as_posix(shell.full_path()))
    ++template_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
    ++
     +configure_file(
     +  input: 'description',
     +  output: 'description',
    -+  configuration: script_sh_config,
    ++  configuration: template_config,
     +)
     +
     +subdir('hooks')
-- 
2.47.0.72.gef8ce8f3d4.dirty

