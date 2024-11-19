Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D932F211C
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 11:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732017063; cv=none; b=V2RHC/ZnFTY8iijRVi/OvbNgFsPeNKqnhMvJDQDpgpqYCMixksFHNsht9V2b2JBgAhYX76avU+DSVYn4fRaYqYgbIq6rnDWbywHavgg7Uvqn1Aow+Tnmq3FaUmlyeR841B+l/LPiUKZoWAiuliu1n+yAh/wNeW8FMlEGkxsjl9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732017063; c=relaxed/simple;
	bh=s3WOItD8Fi+cz120RdkT7Tc3FC3y7y33+L+GwMWFQa0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=m00TQgIFTM1N34VcAJX6r3tej6gF0nPWdIVKWfysgGIcdYrwHVFKsagh38e/hgJ3qsaEpmGh0AWVp2c+5vrQJGTvNI1UsLPCKiBUsgkh221/FCxWlgjb9azt7uz09S0wQcJ3OQo0y9aP2kawleBtVbPU/ayDhx/PL/nILKaJPqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qFwKaRYW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFnY+anL; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qFwKaRYW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFnY+anL"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DE44611400FE;
	Tue, 19 Nov 2024 06:50:57 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 19 Nov 2024 06:50:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1732017057;
	 x=1732103457; bh=6IONMI4qP/zxcp8JbIudKxMfHU9I1OczVT4SUYD79+M=; b=
	qFwKaRYW8ZJzw9qVGR5y38Ou2bH4iLH16QrJbS4vUYbFepnsxtkwOdCEWbwnL5y/
	iyi0OZgw1DvtgpIWbmpu2lNQREuEQKcuGt8LlxB78McLCNOgJ//AsQrrTon5HEao
	t+HZeVk2p2+qKZjzsgrd1pdgM3BdB+dOjwetgjqvQyPjPjbOFgYp+Bnst4EhYgYp
	ciCmPN7MO1mkj57Kd9jCScjm8sFetxHPkTJfYe3u9jTZfsmb1TOBmXWCXCzmieCH
	I7T85hFraod5xhzaulESziyIvC/b8WlXC3diKDy3L1r+75bIjw+67lLbSDckVElR
	zuQgMKx+FlwjpzhOROgF9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1732017057; x=
	1732103457; bh=6IONMI4qP/zxcp8JbIudKxMfHU9I1OczVT4SUYD79+M=; b=T
	FnY+anLK1X0d/1WWSKnWz/NH4u7S2ZaH3+VhRjFP8e99FsoHYn3sBOADSYagTYN7
	8IGkWH67NWCsH/04yvFvNhkCaQv9TukN6K8B30Kr0zXy3E5E5bkuqNsATMV4+fGO
	YJ6C0lmQEBYlZCKaGFAzlj1dVYliVJdGuaEXLOd9h3YTFKkWoQ+7/YB8sUvaYkcs
	QZzu12uSLdQWXPg6XQx1F2005JeQJLkQVt6qIvLhsQ2VXBnCe1u7+s21TPC/wZdj
	IYj9+ItVl76P1sg030d4lQqulpQsPKbYtABkGRCX0KPwb2F4aYmSxpd/u11eH9vo
	72vylk/oEbBxlhX7E2nOg==
X-ME-Sender: <xms:oHs8Z3HTeAq_phoQKPTwGSsjGf7Gebxt_R4dL9FQtlt5DykORAdT8g>
    <xme:oHs8Z0WpizU-etPkSuDYni0UjS9sHTuN1MUw_5PpPNl4kSfRtBtZFxwUVrAD3say3
    rtnf-cjlBE6IDMZAQ>
X-ME-Received: <xmr:oHs8Z5Johx-E5MPpVT-xc76LLJ8P6w7EPuuzoA0a15pcE3bUKS_MIFqT4DqtDE-NnuNGJQ-nSJb88_Ss6Ygc7_NMBblOu_pasVBVRrnpK1gX2kE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedvgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffdvkeetffekgedtkeekfeelgfefkeehkeelfeeffeff
    gfetffevjedujeeftddunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptghonhhfrd
    hinhdprhgsrdhinhdprhgtrdhinhdpmhgvshhonhdrsghuihhlugenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghh
    figrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepuggrvhhvihgusehgmhgrihhlrdgtohhmpdhrtghpthhtoheprh
    grmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgvsehtthgrhihloh
    hrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:oXs8Z1EeFlyAg_c-E1NdIRWA-HYidqaemMbSw5v5p0eBcniAuNdu7A>
    <xmx:oXs8Z9Vyl4FOkLiKeQLTFWnchoGULDqnb099wJfPVjguX7EBj_Jm3w>
    <xmx:oXs8ZwPf6VG_MgOEaL14NPjhtmen7nb0djkPO9PlXnL99HbkxZKuyw>
    <xmx:oXs8Z803UqI_2Yh9KY0KUgQpr7re8wf_p5swl6nUU6Hz27ifzVHwoQ>
    <xmx:oXs8Z2NkRI8SxVUrWHFmhWndbINRw_F7bRv8tushlJZqMHoLzDfjMBPX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 19 Nov 2024 06:50:55 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 66bc9041 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 19 Nov 2024 11:50:03 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v8 00/23] Modernize the build system
Date: Tue, 19 Nov 2024 12:50:37 +0100
Message-Id: <20241119-pks-meson-v8-0-809bf7f042f3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI57PGcC/23QTW7CMBCG4asgr+toxn8zZtV7VF00wYBVkUQ2s
 lqh3B2TBSLIy7Ge91v4JnJIMWSx391ECiXmOI314I+dGM4/4ynIeKi3UKAMIio5/2Z5CXkapbe
 9c3YAPoIT1c8pHOPfuvX1Xe9zzNcp/a/TBR+vYphKSB2SImZEZ7pTvHZz/qyjXbyIR1XUVrJhi
 9q3pN5Kr6wBgpY0b5IIHdiWtBupUWvrNbekW2XjX4qTIJ3hXoP3jhVtMnrN7GtGNTMUBvQ9MfT
 qmS3Lcgd7cVdjqAEAAA==
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

Changes in v8:

  - Fix compilation when Git is not found in PATH.

  - Fix undefined `git_version` variable when compiling docs.

  - Rework how we propagate version attributes into AsciiDoc and
    AsciiDoctor.

  - Fix indentation of `cmd_lists` array.

  - Avoid rebuilding files generated via GIT-VERSION-GEN unless
    GIT-VERSION-FILE has changed.

  - Fix RUNTIME_PREFIX value in GIT-BUILD-OPTIONS.

  - Rework the HTTPS backend selection so that it is now a choice
    instead of multiple separate options. The default value is 'auto',
    which will auto-detect available backends. Other supported values
    are 'openssl', 'CommonCrypto' or 'none'.

  - Print a summary of auto-detected features at the end of `meson
    setup`:

      Auto-detected features
        curl         : false
        expat        : true
        gettext      : true
        https        : none
        iconv        : true
        pcre2        : true
        perl         : true
        python       : true

      User defined options
        curl         : disabled
        https_backend: none
        sha1_backend : sha1dc

I consider this version to be basically complete. Of course there are
still some bits and pieces missing, like e.g. "git-gui" or "gitk". But
the base is there and works as expected. I've also started daily driving
the Meson-based build now as my main Git installation to verify that it
works as expected. I've thus removed the RFC prefix, even though the
discussion will of course still go on.

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
  - Link to v7: https://lore.kernel.org/r/20241115-pks-meson-v7-0-47ec19b780b2@pks.im

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
 Documentation/Makefile                             |   46 +-
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
 GIT-VERSION-GEN                                    |   64 +-
 Makefile                                           |  238 ++-
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
 meson.build                                        | 1894 ++++++++++++++++++++
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
 98 files changed, 4917 insertions(+), 498 deletions(-)

Range-diff versus v7:

 1:  df465921e9 !  1:  f96de8ecd6 Makefile: use common template for GIT-BUILD-OPTIONS
    @@ GIT-BUILD-OPTIONS.in (new)
     
      ## Makefile ##
     @@ Makefile: GIT-LDFLAGS: FORCE
    + 		echo "$$FLAGS" >GIT-LDFLAGS; \
    +             fi
    + 
    ++ifdef RUNTIME_PREFIX
    ++RUNTIME_PREFIX_OPTION = true
    ++else
    ++RUNTIME_PREFIX_OPTION = false
    ++endif
    ++
    + # We need to apply sq twice, once to protect from the shell
      # that runs GIT-BUILD-OPTIONS, and then again to protect it
      # and the first level quoting from the shell that runs "echo".
      GIT-BUILD-OPTIONS: FORCE
    @@ Makefile: GIT-LDFLAGS: FORCE
     +		-e "s|@GIT_INTEROP_MAKE_OPTS@|\'$(GIT_INTEROP_MAKE_OPTS)\'|" \
     +		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
     +		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
    -+		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
    ++		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX_OPTION)\'|" \
     +		GIT-BUILD-OPTIONS.in >$@+
     +	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
      	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
 2:  485c32af5b =  2:  fcc2f9c3b3 Makefile: consistently use @PLACEHOLDER@ to substitute
 3:  5801eb7d78 !  3:  2253e4834e Makefile: refactor GIT-VERSION-GEN to be reusable
    @@ GIT-VERSION-GEN: else
      
     -VN=$(expr "$VN" : v*'\(.*\)')
     +GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
    ++GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as')
     +GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
     +if test -z "$GIT_USER_AGENT"
     +then
    @@ GIT-VERSION-GEN: else
     +EOF
     +
     +sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
    ++	-e "s|@GIT_DATE@|$GIT_DATE|" \
     +	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
     +	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
     +	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
 4:  2b8806369b =  4:  955a9881d3 Makefile: propagate Git version via generated header
 5:  e42ddd2210 =  5:  6378fd066c Makefile: generate "git.rc" via GIT-VERSION-GEN
 -:  ---------- >  6:  821546aa60 Makefile: generate doc versions via GIT-VERSION-GEN
 6:  30fce16e4e =  7:  a99a36598e Makefile: consistently use PERL_PATH
 7:  1ef93ada56 =  8:  ad80ca0ef1 Makefile: extract script to massage Perl scripts
 8:  c93ce837d3 =  9:  63f09bec07 Makefile: use "generate-perl.sh" to massage Perl library
 9:  6578da265d ! 10:  0371a6b25b Makefile: extract script to massage Shell scripts
    @@ Makefile: GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
     @@ Makefile: GIT-BUILD-OPTIONS: FORCE
      		-e "s|@GIT_TEST_INDEX_VERSION@|\'$(GIT_TEST_INDEX_VERSION)\'|" \
      		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
    - 		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
    + 		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX_OPTION)\'|" \
     +		-e "s|@GITWEBDIR@|\'$(gitwebdir_SQ)\'|" \
     +		-e "s|@USE_GETTEXT_SCHEME@|\'$(USE_GETTEXT_SCHEME)\'|" \
     +		-e "s|@LOCALEDIR@|\'$(localedir_SQ)\'|" \
    -+		-e "s|@BROKEN_PATH_FIX@|\'$(BROKEN_PATH_FIX)\'|" \
    ++		-e "s!@BROKEN_PATH_FIX@!\'$(BROKEN_PATH_FIX)\'!" \
      		GIT-BUILD-OPTIONS.in >$@+
      	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
      	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
10:  0305db927c = 11:  769889f6ea Makefile: extract script to generate gitweb.cgi
11:  a5ffdebfba = 12:  574dfac309 Makefile: extract script to generate gitweb.js
12:  dffcfa67bb = 13:  b97dd455d1 Makefile: refactor generators to be PWD-independent
13:  462f856f82 = 14:  2c0e27b10c Makefile: allow "bin-wrappers/" directory to exist
14:  273ab3c03f = 15:  09451bd549 Makefile: simplify building of templates
15:  6b4d770cc6 = 16:  47769c6edc Documentation: allow sourcing generated includes from separate dir
16:  7a0ec55ee6 = 17:  4e2b664838 Documentation: teach "cmd-list.perl" about out-of-tree builds
17:  f78f810927 = 18:  6ed009b23c Documentation: extract script to generate a list of mergetools
18:  d7da37b0a2 ! 19:  42a90d1967 t: better support for out-of-tree builds
    @@ Makefile: GIT-BUILD-OPTIONS: FORCE
     +		-e "s|@GIT_TEST_TEMPLATE_DIR@|\'$(shell pwd)/templates/blt\'|" \
     +		-e "s|@GIT_TEST_GITPERLLIB@|\'$(shell pwd)/perl/build/lib\'|" \
     +		-e "s|@GIT_TEST_MERGE_TOOLS_DIR@|\'$(shell pwd)/mergetools\'|" \
    - 		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
    + 		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX_OPTION)\'|" \
      		-e "s|@GITWEBDIR@|\'$(gitwebdir_SQ)\'|" \
      		-e "s|@USE_GETTEXT_SCHEME@|\'$(USE_GETTEXT_SCHEME)\'|" \
     @@ Makefile: all:: $(TEST_PROGRAMS) $(test_bindir_programs) $(UNIT_TEST_PROGS) $(CLAR_TEST_PR
19:  235c953976 = 20:  741a526f9e t: allow overriding build dir
20:  b77e32e92d = 21:  7af31366e0 Documentation: add comparison of build systems
21:  584c56be09 ! 22:  5331e5b033 Introduce support for the Meson build system
    @@ Documentation/meson.build (new)
     +git = find_program('git', required: false)
     +xmlto = find_program('xmlto')
     +
    -+git_revdate = ''
    -+if git.found()
    -+  git_revdate = run_command(git, 'show', '--quiet', '--pretty=%as', check: false).stdout().strip()
    -+endif
    ++asciidoc_conf = custom_target(
    ++  command: [
    ++    shell,
    ++    meson.project_source_root() / 'GIT-VERSION-GEN',
    ++    meson.project_source_root(),
    ++    '@INPUT@',
    ++    '@OUTPUT@',
    ++  ],
    ++  input: meson.current_source_dir() / 'asciidoc.conf.in',
    ++  output: 'asciidoc.conf',
    ++  depends: [git_version_file],
    ++)
     +
     +asciidoc_common_options = [
     +  asciidoc,
    -+  '--conf-file=' + meson.current_source_dir() / 'asciidoc.conf',
    -+  '--attribute=manual=Git Manual',
    -+  '--attribute=mansource=Git ' + git_version,
    -+  '--attribute=revdate=' + git_revdate,
    ++  '--conf-file=' + asciidoc_conf.full_path(),
     +  '--attribute=build_dir=' + meson.current_build_dir(),
     +]
     +
     +cmd_lists = [
    -+    'cmds-ancillaryinterrogators.txt',
    -+	'cmds-ancillarymanipulators.txt',
    -+	'cmds-mainporcelain.txt',
    -+	'cmds-plumbinginterrogators.txt',
    -+	'cmds-plumbingmanipulators.txt',
    -+	'cmds-synchingrepositories.txt',
    -+	'cmds-synchelpers.txt',
    -+	'cmds-guide.txt',
    -+	'cmds-developerinterfaces.txt',
    -+	'cmds-userinterfaces.txt',
    -+	'cmds-purehelpers.txt',
    -+	'cmds-foreignscminterface.txt',
    ++  'cmds-ancillaryinterrogators.txt',
    ++  'cmds-ancillarymanipulators.txt',
    ++  'cmds-mainporcelain.txt',
    ++  'cmds-plumbinginterrogators.txt',
    ++  'cmds-plumbingmanipulators.txt',
    ++  'cmds-synchingrepositories.txt',
    ++  'cmds-synchelpers.txt',
    ++  'cmds-guide.txt',
    ++  'cmds-developerinterfaces.txt',
    ++  'cmds-userinterfaces.txt',
    ++  'cmds-purehelpers.txt',
    ++  'cmds-foreignscminterface.txt',
     +]
     +
    -+documentation_deps = [ ]
    ++documentation_deps = [
    ++  asciidoc_conf,
    ++]
     +
     +documentation_deps += custom_target(
     +  command: [
    @@ meson.build (new)
     +#   Using Meson also works with other generators though, like when the build
     +#   directory has been set up for use with Microsoft Visual Studio.
     +#
    ++#   Ninja and Samurai use multiple jobs by default, scaling with the number of
    ++#   processor cores available. You can pass the `-jN` flag to change this.
    ++#
    ++#   Meson automatically picks up ccache and sccache when these are installed
    ++#   when setting up the build directory. You can override this behaviour when
    ++#   setting up the build directory by setting the `CC` environment variable to
    ++#   your desired compiler.
    ++#
     +# 3. Execute tests. Again, you can either use Meson, Ninja or Samurai to do this:
     +#
     +#      $ meson test
    @@ meson.build (new)
     +#      # Execute single test interactively such that features like `debug ()` work.
     +#      $ meson test -i --test-args='-ix' t1400-update-ref
     +#
    ++#   Test execution is parallelized by default and scales with the number of
    ++#   processor cores available. You can change the number of processes by passing
    ++#   the `-jN` flag to `meson test`.
    ++#
     +# 4. Install the Git distribution. Again, this can be done via Meson, Ninja or
     +#    Samurai:
     +#
    @@ meson.build (new)
     +#
     +# Meson supports multiple backends. The default backend generates Ninja build
     +# instructions, but it also supports the generation of Microsoft Visual
    -+# Studio solutions as well as Xcode projects. IDEs like Eclipse and Visual
    -+# Studio Code provide plugins to import Meson files directly.
    ++# Studio solutions as well as Xcode projects by passing the `--backend` option
    ++# to `meson setup`. IDEs like Eclipse and Visual Studio Code provide plugins to
    ++# import Meson files directly.
     +#
     +# Configuration
     +# =============
    @@ meson.build (new)
     +#      # Set up a new build directory with a higher warning level. Level 2 is
     +#      # mostly equivalent to setting DEVELOPER=1, level 3 and "everything"
     +#      # will enable even more warnings.
    -+#      $ meson setup -Dwarning_level=2
    ++#      $ meson setup -Dwarning_level=2 build
     +#
     +#      # Set up a new build directory with 'address' and 'undefined' sanitizers
     +#      # using Clang.
    @@ meson.build (new)
     +# disable the feature based on the availability of prerequisites to support it.
     +# Python-based features for example will be enabled automatically when a Python
     +# interpreter could be found. The default value of such features can be changed
    -+# globally via `meson setup --auto-features={enabled,disabled,auto}`, which
    -+# will set the value of all features with a value of "auto" to the provided one
    -+# by default.
    ++# via `meson setup --auto-features={enabled,disabled,auto}`, which will set the
    ++# value of all features with a value of "auto" to the provided one by default.
     +#
     +# It is also possible to store a set of configuration options in machine files.
     +# This can be useful in case you regularly want to reuse the same set of options:
    @@ meson.build (new)
     +#   b_lto = true
     +#   b_sanitize = 'address,undefined'
     +#
    -+# These machine files can be passed to Meson via `meson setup --native-file`.
    ++# These machine files can be passed to `meson setup` via the `--native-file`
    ++# option.
     +#
     +# Subproject wrappers
     +# ===================
     +#
    -+# Subproject wrappers are a feature provided by Meson that allow the automatic
    ++# Subproject wrappers are a feature provided by Meson that allows the automatic
     +# fallback to a "wrapped" dependency in case the dependency is not provided by
     +# the system. For example if the system is lacking curl, then Meson will use
     +# "subprojects/curl.wrap" to set up curl as a subproject and compile and link
     +# the dependency into Git itself. This is especially helpful on systems like
     +# Windows, where you typically don't have such dependencies installed.
     +#
    -+# The use of subproject wrappers can be disabled by executing `meson setup
    -+# --wrap-mode nofallback`.
    ++# The use of subproject wrappers can be disabled by executing `meson setup`
    ++# with the `--wrap-mode nofallback` option.
     +
     +project('git', 'c',
     +  meson_version: '>=1.3.0',
    @@ meson.build (new)
     +tar = find_program('tar', dirs: program_path)
     +
     +script_environment = environment()
    -+foreach tool : ['cat', 'cut', 'git', 'grep', 'sed', 'sort', 'tr', 'uname']
    ++foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
     +  program = find_program(tool, dirs: program_path)
     +  script_environment.prepend('PATH', fs.parent(program.full_path()))
     +endforeach
     +
    ++git = find_program('git', dirs: program_path, required: false)
    ++if git.found()
    ++  script_environment.prepend('PATH', fs.parent(git.full_path()))
    ++endif
    ++
    ++if get_option('sane_tool_path') != ''
    ++  script_environment.prepend('PATH', get_option('sane_tool_path'))
    ++endif
    ++
     +compiler = meson.get_compiler('c')
     +
     +libgit_sources = [
    @@ meson.build (new)
     +build_options_config.set('GIT_TEST_OPTS', '')
     +build_options_config.set('GIT_TEST_PERL_FATAL_WARNINGS', '')
     +build_options_config.set('GIT_TEST_UTF8_LOCALE', '')
    -+build_options_config.set('BROKEN_PATH_FIX', '')
     +build_options_config.set_quoted('LOCALEDIR', fs.as_posix(get_option('prefix') / get_option('localedir')))
     +build_options_config.set('GITWEBDIR', fs.as_posix(get_option('prefix') / get_option('datadir') / 'gitweb'))
     +
    ++if get_option('sane_tool_path') != ''
    ++  build_options_config.set_quoted('BROKEN_PATH_FIX', 's|^\# @BROKEN_PATH_FIX@$|git_broken_path_fix "' + get_option('sane_tool_path') + '"|')
    ++else
    ++  build_options_config.set_quoted('BROKEN_PATH_FIX', '/^\# @BROKEN_PATH_FIX@$/d')
    ++endif
    ++
     +test_output_directory = get_option('test_output_directory')
     +if test_output_directory == ''
     +  test_output_directory = meson.project_build_root() / 'test-output'
    @@ meson.build (new)
     +  libgit_c_args += '-DHAVE_DEV_TTY'
     +endif
     +
    -+if get_option('openssl').enabled() and get_option('CommonCrypto').enabled()
    -+  error('Can only use one SSL backend')
    -+endif
    ++https_backend = get_option('https_backend')
     +
    -+security_framework = dependency('Security', required: get_option('CommonCrypto').disable_auto_if(host_machine.system() != 'darwin'))
    ++security_framework = dependency('Security', required: https_backend == 'CommonCrypto')
     +core_foundation_framework = dependency('CoreFoundation', required: security_framework.found())
    -+if security_framework.found()
    -+  libgit_dependencies += security_framework
    -+  libgit_dependencies += core_foundation_framework
    -+  libgit_c_args += '-DAPPLE_COMMON_CRYPTO'
    ++if https_backend == 'auto' and security_framework.found()
    ++  https_backend = 'CommonCrypto'
     +endif
     +
    -+# OpenSSL is required when requested via the 'openssl' feature or via one of
    -+# the SHA1/SHA256 backends.
    -+openssl_required = get_option('openssl').disable_auto_if(security_framework.found())
    -+if get_option('sha1_backend') == 'openssl' or get_option('sha256_backend') == 'openssl'
    -+  openssl_required = true
    ++openssl_required = https_backend == 'openssl' or get_option('sha1_backend') == 'openssl' or get_option('sha256_backend') == 'openssl'
    ++openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
    ++if https_backend == 'auto' and openssl.found()
    ++  https_backend = 'openssl'
     +endif
     +
    -+openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
    -+if openssl.found()
    ++if https_backend == 'CommonCrypto'
    ++  libgit_dependencies += security_framework
    ++  libgit_dependencies += core_foundation_framework
    ++  libgit_c_args += '-DAPPLE_COMMON_CRYPTO'
    ++elif https_backend == 'openssl'
     +  libgit_dependencies += openssl
    ++else
    ++  # We either couldn't find any dependencies with 'auto' or the user requested
    ++  # 'none'. Both cases are benign.
     +endif
     +
    -+# We may not want to use OpenSSL for anything but our SHA1/SHA256 backends, so
    -+# we cannot just set NO_OPENSSL based on whether or not the library was found.
    -+if not openssl.found() or get_option('openssl').disabled()
    ++if https_backend != 'openssl'
     +  libgit_c_args += '-DNO_OPENSSL'
     +endif
     +
    @@ meson.build (new)
     +elif sha1_backend == 'common-crypto'
     +  libgit_c_args += '-DCOMMON_DIGEST_FOR_OPENSSL'
     +  libgit_c_args += '-DSHA1_APPLE'
    ++  # Apple CommonCrypto requires chunking
     +  libgit_c_args += '-DSHA1_MAX_BLOCK_SIZE=1024L*1024L*1024L'
     +elif sha1_backend == 'openssl'
    -+  if not openssl.found()
    -+    openssl = dependency('openssl', required: true)
    -+  endif
    -+
     +  libgit_c_args += '-DSHA1_OPENSSL'
    -+  # Apple CommonCrypto requires chunking
    ++  libgit_dependencies += openssl
     +elif sha1_backend == 'block'
     +  libgit_c_args += '-DSHA1_BLK'
     +  libgit_sources += 'block-sha1/sha1.c'
    @@ meson.build (new)
     +sha256_backend = get_option('sha256_backend')
     +if sha256_backend == 'openssl'
     +  libgit_c_args += '-DSHA256_OPENSSL'
    ++  libgit_dependencies += openssl
     +elif sha256_backend == 'nettle'
     +  nettle = dependency('nettle')
     +  libgit_dependencies += nettle
    @@ meson.build (new)
     +
     +if get_option('runtime_prefix')
     +  libgit_c_args += '-DRUNTIME_PREFIX'
    -+  build_options_config.set('RUNTIME_PREFIX', '1')
    ++  build_options_config.set('RUNTIME_PREFIX', 'true')
     +
     +  if compiler.has_header('mach-o/dyld.h')
     +    libgit_c_args += '-DHAVE_NS_GET_EXECUTABLE_PATH'
    @@ meson.build (new)
     +    libgit_c_args += '-DHAVE_WPGMPTR'
     +  endif
     +else
    -+  build_options_config.set('RUNTIME_PREFIX', '')
    ++  build_options_config.set('RUNTIME_PREFIX', 'false')
     +endif
     +
     +foreach key, value : {
    @@ meson.build (new)
     +  configuration: build_options_config,
     +)
     +
    -+version_def_h = custom_target(
    ++git_version_file = custom_target(
     +  command: [
     +    shell,
     +    meson.current_source_dir() / 'GIT-VERSION-GEN',
    @@ meson.build (new)
     +    '@INPUT@',
     +    '@OUTPUT@',
     +  ],
    -+  input: meson.current_source_dir() / 'version-def.h.in',
    -+  output: 'version-def.h',
    ++  input: meson.current_source_dir() / 'GIT-VERSION-FILE.in',
    ++  output: 'GIT-VERSION-FILE',
     +  build_always_stale: true,
     +)
     +
    -+git_version_file = custom_target(
    ++version_def_h = custom_target(
     +  command: [
     +    shell,
     +    meson.current_source_dir() / 'GIT-VERSION-GEN',
    @@ meson.build (new)
     +    '@INPUT@',
     +    '@OUTPUT@',
     +  ],
    -+  input: meson.current_source_dir() / 'GIT-VERSION-FILE.in',
    -+  output: 'GIT-VERSION-FILE',
    -+  build_always_stale: true,
    ++  input: meson.current_source_dir() / 'version-def.h.in',
    ++  output: 'version-def.h',
    ++  # Depend on GIT-VERSION-FILE so that we don't always try to rebuild this
    ++  # target for the same commit.
    ++  depends: [git_version_file],
     +)
     +
     +# Build a separate library for "version.c" so that we do not have to rebuild
    @@ meson.build (new)
     +    ],
     +    input: meson.current_source_dir() / 'git.rc.in',
     +    output: 'git.rc',
    -+    build_always_stale: true,
    ++    depends: [git_version_file],
     +  )
     +
     +  common_main_sources += import('windows').compile_resources(git_rc,
    @@ meson.build (new)
     +if get_option('docs') != []
     +  subdir('Documentation')
     +endif
    ++
    ++summary({
    ++  'curl': curl.found(),
    ++  'expat': expat.found(),
    ++  'gettext': intl.found(),
    ++  'https': https_backend,
    ++  'iconv': iconv.found(),
    ++  'pcre2': pcre2.found(),
    ++  'perl': perl_features_enabled,
    ++  'python': python.found(),
    ++}, section: 'Auto-detected features')
     
      ## meson_options.txt (new) ##
     @@
    @@ meson_options.txt (new)
     +  description: 'Path to the global git attributes file.')
     +option('pager_environment', type: 'string', value: 'LESS=FRX LV=-c',
     +  description: 'Environment used when spawning the pager')
    ++option('perl_cpan_fallback', type: 'boolean', value: true,
    ++  description: 'Install bundled copies of CPAN modules that serve as a fallback in case the modules are not available on the system.')
     +option('runtime_prefix', type: 'boolean', value: false,
     +  description: 'Resolve ancillary tooling and support files relative to the location of the runtime binary instead of hard-coding them into the binary.')
    ++option('sane_tool_path', type: 'string', value: '',
    ++  description: 'A colon-separated list of paths to prepend to PATH if your tools in /usr/bin are broken.')
     +
     +# Features supported by Git.
     +option('curl', type: 'feature', value: 'enabled',
    @@ meson_options.txt (new)
     +  description: 'Support Perl-compatible regular expressions in e.g. git-grep(1).')
     +option('perl', type: 'feature', value: 'auto',
     +  description: 'Build tools written in Perl.')
    -+option('perl_cpan_fallback', type: 'boolean', value: true,
    -+  description: 'Install bundled copies of CPAN modules that serve as a fallback in case the modules are not available on the system.')
     +option('python', type: 'feature', value: 'auto',
     +  description: 'Build tools written in Python.')
     +option('regex', type: 'feature', value: 'auto',
     +  description: 'Use the system-provided regex library instead of the bundled one.')
     +
    -+# HTTPS backends.
    -+option('openssl', type: 'feature', value: 'auto',
    -+  description: 'Support access to HTTPS remotes. OpenSSL may still be pulled in if configured as SHA1 or SHA256 backend.')
    -+option('CommonCrypto', type: 'feature', value: 'auto',
    -+  description: 'Build tools written in Python.')
    -+
    -+# Hashing backends.
    ++# Backends.
    ++option('https_backend', type: 'combo', value: 'auto', choices: ['auto', 'openssl', 'CommonCrypto', 'none'],
    ++  description: 'The HTTPS backend to use when connecting to remotes.')
     +option('sha1_backend', type: 'combo', choices: ['openssl', 'block', 'sha1dc', 'common-crypto'], value: 'sha1dc',
     +  description: 'The backend used for hashing objects with the SHA1 object format')
     +option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt', 'block'], value: 'block',
22:  abc986315e = 23:  9d4f54de6e meson: fix conflicts with in-flight topics

---
base-commit: b31fb630c0fc6869a33ed717163e8a1210460d94
change-id: 20241112-pks-meson-95b665c08f06

