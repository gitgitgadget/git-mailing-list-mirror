Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D861D5AAC
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 12:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773598; cv=none; b=AxwTQL6zyi2Rad0EgFfj9exfR749IeG3KwqbC7XWdgMVFVYOhDJgZrZpIlEuDmWQw6KvyXzW+G36dk81jAxqwOFnLysBgU0IKHLOPLiWgEabVaPnAgx2kerUUw9wIjAi4dQuPrAu3enzoBo5ew8r0gkV10xpGSlleJH9vzI9pqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773598; c=relaxed/simple;
	bh=7//UDdpXNmXVkaT3U6DO5E2jEILQfD8GJ9iumLsTI6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iP1My3vL7VlMDSaoACAbXyr65aMsWE1sIf4J6Da4Uio7GcdE9DG3aOPLEsyDw8jlTYcQCg3pEjIQUp4UXCwXpiiQF6I50hhWWXl4IZ9elVJtHbpmTMv+6qbBY2KRzdjQrHlcbXNZqfw3d4M8/jZmRK+hghBDDb7xNjbjy29wL9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=eOqlLTqW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K0bqNxTw; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="eOqlLTqW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K0bqNxTw"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5B21225400C8;
	Thu, 24 Oct 2024 08:39:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 24 Oct 2024 08:39:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729773592; x=1729859992; bh=Flt4zK9wKF
	ZsP1WuMvpyRh9QAupD7WiQmWec3Y6ffWM=; b=eOqlLTqWPA0G+QPI6D0UkhiqlY
	+A2jPgJE3wW7egZOXCxXaagh6RhKAP21FqE9PKOOVNKNoe9B1MaE6F/6LZs+VdaY
	SbwnkyAhTjmTTHecP4dGG6Q9wLarEB845TZzNGT4A616R43CyZJQe7lb45ww+flW
	gfoPv2A7TPRMt4KPCgPs0+xHIdyAl4WyDX2PQ4QwKL3ckk5hniD+F/4iEoc1ly6S
	nm4cDLD1riOtTfbESs7e8dQ+M26MbdgheA7+PQT0GjYk5pY3kX/HnzVKIFU0q7e3
	dU7LMb6RfuhZcuSZBODmxUbXWXHR2aCNMIqb0oXoYBkQelNK58+qxRt4GnNg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729773592; x=1729859992; bh=Flt4zK9wKFZsP1WuMvpyRh9QAupD
	7WiQmWec3Y6ffWM=; b=K0bqNxTwkSQ6Td7wBwibT2zjQDuKmlvHVHPEzg0nMhiA
	o1qIgdU5UUE+j0bT1giBwj4qZsJGKJxL59HfpY6IMZB2ZSBBQlAnoZACICYTrXQW
	NnmOLZXJVMrYeFXeadKGe6NtBIy2p71y29pwA85mUCNBeEyIkTb5IXjjuhdXODD7
	zyx5vvPnqfcqgvWYL7yb9v2c6wpVqXLYRUvwwUGrv/L4Y2dqZKgcu0MuiIjRnAWl
	K8PzmB80BEXnqTEe470V2oGcTvCSEQtKwZsZ016ygBIBiQ3A/rsLkIUxhClcfufQ
	xaqSrhmuMKRXiVq5Nbv7ZWMGspMim+aYLQSZNDb3EA==
X-ME-Sender: <xms:F0AaZ5_R2pDa1zhL9dodX2VEs_0dU71240p17b0VukEc3Wa6bxlaKQ>
    <xme:F0AaZ9s2Cq7x8rj3D_rDqLFpFp0seJ0bciDFDfPPwBqjrxFHk6NR8tPKN-l9gYckn
    srzqWCUwDJlVQieUg>
X-ME-Received: <xmr:F0AaZ3B15rqFs7BCvtf0TKaQDm2Yxx1ZjGYAOAEQT89K_1zWdPW6wQEFfOQ9KkfLDp5Y_fKwytfbrhI2t0ZSbtm2Wdj4nvMn5q8_rNALlTf6qYVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdejtddgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    mhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhg
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:F0AaZ9cMxkn9yixIGrfAihzlXsRuFt52SB51h1zbaIJ6AT4tTMsLjw>
    <xmx:F0AaZ-NlVN2l6gjpf4DA-NDYvI2r0IMjvXr5BlWcsK9NPEVsdkpyAw>
    <xmx:F0AaZ_nvo1gSrk6Gy_BcFmj-vi2kJ4jl4mbgmLjMJtdZrnCOfpEM-w>
    <xmx:F0AaZ4t0kKGPxsU2y1Hif1i1lGbez7AVVQjIuj3bbi9sspHNcUWfdA>
    <xmx:GEAaZ9ctqzIjB4YRRHVTMLNOE9LS-uYYNEROPA_vkr-UO5n4jrWHDc6h>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Oct 2024 08:39:50 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7bd781ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 24 Oct 2024 12:39:51 +0000 (UTC)
Date: Thu, 24 Oct 2024 14:39:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [RFC PATCH v4 00/19] Modernize the build system
Message-ID: <cover.1729771605.git.ps@pks.im>
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

this is the fourth version of my patch series that modernizes our build
system. It refactors various parts of it to make it possible to perform
out-of-tree builds in theory and then wires up Meson.

Changes compared to v3:

  - Various typo fixes.

  - Our Makefile now detects unsubstituted build options in the newly-
    introduced "GIT-BUILD-OPTIONS.in" template.

  - I've wired up support for building and installing manpages. This was
    the last important bit missing to get a fully functioning Git
    installation. We generate the same set of manpages that our Makefile
    would and also render a subset of the HTML pages we generate. Not
    wired up are our technical docs, but doing those shouldn't be all
    that involved.

    Documentation is not built by default, but can be enabled by passing
    any combination of `-Ddocs=html,man`.

  - I've dropped the target names for `custom_target()` invocations.
    Those are auto-derived from the first output anyway, so they only
    add unnecessary noise.

  - The last patch is a compatibility patch for "seen". There are a
    couple of topics that interact with this series, and I didn't want
    to make all of them a strict dependency. So I've decided to just
    create a fixup-style commit that does the necessary changes in order
    to work with "seen". Like this, you can test without "seen" by
    simply dropping that last commit, and you can test with "seen" by
    merging it into this topic.

    @Taylor: I didn't really have a better idea than this. There are
    six additional topics that this branch interacts with, and building
    the branch with eight dependencies in total didn't feel sensible.
    Ideally, the topic branch itself shouldn't have the last commit, but
    once it gets merged into 'seen' we should have it. Let me know in
    case you have a better idea though.

This topic is built on top of fd3785337b (The third batch, 2024-10-22)
with the following two branches merged into it:

  - ps/upgrade-clar at 30bf9f0aaa (cmake: set up proper dependencies for
    generated clar headers, 2024-10-21). This is currently in 'seen'.

  - ps/platform-compat-fixes at 80ebd91b83 (http: fix build error on
    FreeBSD, 2024-10-16). This has been merged to 'next'.

I was pondering a bit whether I should split this topic up even further.
I've already evicted other parts out of it such that they can land
separately, and landing the Makefile refactorings independently would
reduce the overall review load. These steps also make sense even if we
don't have Meson, as those are all either simplifications, improvements
for CMake or a necessary step towards out-of-tree builds. Let me know
your thoughts!

Thanks!

Patrick

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

 .gitignore                                    |    1 -
 Documentation/CodingGuidelines                |    2 +-
 Documentation/Makefile                        |   28 +-
 Documentation/build-docdep.perl               |    2 +
 Documentation/cmd-list.perl                   |   23 +-
 Documentation/config/diff.txt                 |    2 +-
 Documentation/config/merge.txt                |    2 +-
 Documentation/generate-mergetool-list.sh      |   17 +
 Documentation/git.txt                         |   24 +-
 Documentation/meson.build                     |  317 ++++
 Documentation/technical/build-systems.txt     |  224 +++
 GIT-BUILD-OPTIONS.in                          |   47 +
 GIT-VERSION-GEN                               |   12 +-
 Makefile                                      |  209 +--
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
 meson.build                                   | 1618 +++++++++++++++++
 meson_options.txt                             |   73 +
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
 po/meson.build                                |   27 +
 subprojects/.gitignore                        |    1 +
 subprojects/curl.wrap                         |   13 +
 subprojects/expat.wrap                        |   13 +
 subprojects/openssl.wrap                      |   15 +
 subprojects/pcre2.wrap                        |   16 +
 subprojects/zlib.wrap                         |   13 +
 t/helper/meson.build                          |   92 +
 t/lib-gettext.sh                              |    4 +-
 t/meson.build                                 | 1110 +++++++++++
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
 88 files changed, 4428 insertions(+), 447 deletions(-)
 create mode 100755 Documentation/generate-mergetool-list.sh
 create mode 100644 Documentation/meson.build
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

Range-diff against v3:
 1:  800fb080f45 !  1:  8c481cb9e01 Makefile: use common template for GIT-BUILD-OPTIONS
    @@ Makefile: GIT-LDFLAGS: FORCE
     +		-e "s|@GIT_TEST_PERL_FATAL_WARNINGS@|\'$(GIT_TEST_PERL_FATAL_WARNINGS)\'|" \
     +		-e "s|@RUNTIME_PREFIX@|\'$(RUNTIME_PREFIX)\'|" \
     +		GIT-BUILD-OPTIONS.in >$@+
    ++	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
      	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
      	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
      
 2:  1a4a23c66ca =  2:  308dcbe0bd4 Makefile: consistently use @PLACEHOLDER@ to substitute
 3:  8261f108968 =  3:  20e77ffc5f5 Makefile: consistently use PERL_PATH
 4:  4894179b948 =  4:  50b607a412a Makefile: extract script to massage Perl scripts
 5:  b40bc302291 =  5:  eddafe1cf89 Makefile: use "generate-perl.sh" to massage Perl library
 6:  c13ce99be3a !  6:  2cf8cf86218 Makefile: extract script to massage Shell scripts
    @@ Makefile: GIT-BUILD-OPTIONS: FORCE
     +		-e "s|@LOCALEDIR@|\'$(localedir_SQ)\'|" \
     +		-e "s|@BROKEN_PATH_FIX@|\'$(BROKEN_PATH_FIX)\'|" \
      		GIT-BUILD-OPTIONS.in >$@+
    + 	@if grep -q '^[A-Z][A-Z_]*=@.*@$$' $@+; then echo "Unsubstituted build options in $@" >&2 && exit 1; fi
      	@if cmp $@+ $@ >/dev/null 2>&1; then $(RM) $@+; else mv $@+ $@; fi
    - 	@if test -f GIT-BUILD-DIR; then rm GIT-BUILD-DIR; fi
     
      ## contrib/buildsystems/CMakeLists.txt ##
     @@ contrib/buildsystems/CMakeLists.txt: set(git_shell_scripts
 7:  ebffd855836 =  7:  e8abda661cf Makefile: extract script to generate gitweb.cgi
 8:  d2cdfad10f5 =  8:  0e682b68e25 Makefile: refactor GIT-VERSION-GEN to be reusable
 9:  9be0719ce1b !  9:  46b7760fbcd Makefile: refactor generators to be PWD-independent
    @@ Commit message
         We have multiple scripts that generate headers from other data. All of
         these scripts have the assumption built-in that they are executed in the
         current source directory, which makes them a bit unwieldy to use during
    -    out-of-tree builds. This makes them a bit unwieldy to use. Refactor them
    -    to instead take the source directory as well as the output file as
    -    arguments.
    +    out-of-tree builds.
    +
    +    Refactor them to instead take the source directory as well as the output
    +    file as arguments.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
10:  93869e53178 = 10:  ec4a9e65ec3 Makefile: allow "bin-wrappers/" directory to exist
11:  1c37d6d1f19 ! 11:  b330fd783d4 Makefile: simplify building of templates
    @@ Commit message
     
         When we install Git we also install a set of default templates that both
         git-init(1) and git-clone(1) populate into our build directories. The
    -    way the pristine templates are layed out in our source directory is
    +    way the pristine templates are laid out in our source directory is
         somewhat weird though: instead of reconstructing the actual directory
         hierarchy in "templates/", we represent directory separators with "--".
     
 -:  ----------- > 12:  fb7231ae4c7 Documentation: allow sourcing generated includes from separate dir
 -:  ----------- > 13:  cf1743667e9 Documentation: teach "cmd-list.perl" about out-of-tree builds
 -:  ----------- > 14:  6926a282a80 Documentation: extract script to generate a list of mergetools
12:  c45d2df6b8d = 15:  ed3affb794c t: better support for out-of-tree builds
13:  542b01515e1 ! 16:  205b038f961 t: allow overriding build dir
    @@ Commit message
         using build systems that support out-of-tree builds.
     
         In commit ee9e66e4e7 (cmake: avoid editing t/test-lib.sh, 2022-10-18),
    -    we have introduce support for overriding the GIT_BIULD_DIR by creating
    +    we have introduce support for overriding the GIT_BUILD_DIR by creating
         the file "$GIT_BUILD_DIR/GIT-BUILD-DIR" with its contents pointing to
         the location of the build directory. The intent was to stop modifying
         "t/test-lib.sh" with the CMake build systems while allowing out-of-tree
14:  bd59e31bb55 = 17:  bef26dd67c5 Documentation: add comparison of build systems
15:  ac327d98e9c ! 18:  780180568d9 Introduce support for the Meson build system
    @@ Commit message
         Introduce support for the Meson build system
     
         Introduce support for the Meson build system, a "modern" meta build
    -    system that supports many different plaforms, including Linux, macOS,
    +    system that supports many different platforms, including Linux, macOS,
         Windows and BSDs. Meson supports different backends, including Ninja,
         Xcode and Microsoft Visual Studio. Several common IDEs provide an
         integration with it.
    @@ Commit message
         strongly favor Meson over CMake. In my opinion, it feels significantly
         easier to use with a syntax that feels more like a "real" programming
         language. The second big reason is that Meson supports Rust natively,
    -    which may prove to be important given that the project is likely to pick
    -    up Rust as another language eventually.
    +    which may prove to be important given that the project may pick up Rust
    +    as another language eventually.
     
         Using Meson is rather straight-forward. An example:
     
    @@ Commit message
             # Running `meson test` without any arguments will execute all tests,
             # but the syntax supports globbing to select only some tests.
             $ meson test 't-*'
    -        # Execute single test interactively to allow fordebugging.
    +        # Execute single test interactively to allow for debugging.
             $ meson test 't0000-*' --interactive --test-args=-ix
             ```
     
    @@ Commit message
     
           - We do not install dashed binaries into `$libexec/git-core` anymore.
             So there won't e.g. be a symlink for git-add(1). These are not
    -        required by modern Git and there isn't really much of a usecase for
    +        required by modern Git and there isn't really much of a use case for
             those anymore. By not installing those symlinks we thus start the
             deprecation of this layout.
     
    -      - Support for installing documentation has not been wired up yet. This
    -        will follow if the project can agree on Meson as build system.
    -
           - Documentation does not yet exist. Same here, it will follow if the
             project can agree on Meson.
     
    -      - We're targeting a Meson 1.3.0, which has been released relatively
    +      - We're targeting Meson 1.3.0, which has been released relatively
             recently November 2023. The only feature we use from that version is
             `fs.relative_to()`, which we could replace if necessary. If so, we
             could start to target Meson 1.0.0 and newer, released in December
             2022.
     
    -      - The whole build instructions count around 3000 lines, half of which
    +      - The whole build instructions count around 3300 lines, half of which
             is listing all of our code and test files. Our Makefiles are around
             5000 lines, autoconf adds another 1300 lines. CMake in comparison
             has only 1200 linescode, but it avoids listing individual files and
    @@ Commit message
         Helped-by: Eli Schwartz <eschwartz@gentoo.org>
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    + ## Documentation/meson.build (new) ##
    +@@
    ++manpages = {
    ++  # Category 1.
    ++  'git-add.txt' : 1,
    ++  'git-am.txt' : 1,
    ++  'git-annotate.txt' : 1,
    ++  'git-apply.txt' : 1,
    ++  'git-archimport.txt' : 1,
    ++  'git-archive.txt' : 1,
    ++  'git-bisect.txt' : 1,
    ++  'git-blame.txt' : 1,
    ++  'git-branch.txt' : 1,
    ++  'git-bugreport.txt' : 1,
    ++  'git-bundle.txt' : 1,
    ++  'git-cat-file.txt' : 1,
    ++  'git-check-attr.txt' : 1,
    ++  'git-check-ignore.txt' : 1,
    ++  'git-check-mailmap.txt' : 1,
    ++  'git-checkout-index.txt' : 1,
    ++  'git-checkout.txt' : 1,
    ++  'git-check-ref-format.txt' : 1,
    ++  'git-cherry-pick.txt' : 1,
    ++  'git-cherry.txt' : 1,
    ++  'git-citool.txt' : 1,
    ++  'git-clean.txt' : 1,
    ++  'git-clone.txt' : 1,
    ++  'git-column.txt' : 1,
    ++  'git-commit-graph.txt' : 1,
    ++  'git-commit-tree.txt' : 1,
    ++  'git-commit.txt' : 1,
    ++  'git-config.txt' : 1,
    ++  'git-count-objects.txt' : 1,
    ++  'git-credential-cache--daemon.txt' : 1,
    ++  'git-credential-cache.txt' : 1,
    ++  'git-credential-store.txt' : 1,
    ++  'git-credential.txt' : 1,
    ++  'git-cvsexportcommit.txt' : 1,
    ++  'git-cvsimport.txt' : 1,
    ++  'git-cvsserver.txt' : 1,
    ++  'git-daemon.txt' : 1,
    ++  'git-describe.txt' : 1,
    ++  'git-diagnose.txt' : 1,
    ++  'git-diff-files.txt' : 1,
    ++  'git-diff-index.txt' : 1,
    ++  'git-difftool.txt' : 1,
    ++  'git-diff-tree.txt' : 1,
    ++  'git-diff.txt' : 1,
    ++  'git-fast-export.txt' : 1,
    ++  'git-fast-import.txt' : 1,
    ++  'git-fetch-pack.txt' : 1,
    ++  'git-fetch.txt' : 1,
    ++  'git-filter-branch.txt' : 1,
    ++  'git-fmt-merge-msg.txt' : 1,
    ++  'git-for-each-ref.txt' : 1,
    ++  'git-for-each-repo.txt' : 1,
    ++  'git-format-patch.txt' : 1,
    ++  'git-fsck-objects.txt' : 1,
    ++  'git-fsck.txt' : 1,
    ++  'git-fsmonitor--daemon.txt' : 1,
    ++  'git-gc.txt' : 1,
    ++  'git-get-tar-commit-id.txt' : 1,
    ++  'git-grep.txt' : 1,
    ++  'git-gui.txt' : 1,
    ++  'git-hash-object.txt' : 1,
    ++  'git-help.txt' : 1,
    ++  'git-hook.txt' : 1,
    ++  'git-http-backend.txt' : 1,
    ++  'git-http-fetch.txt' : 1,
    ++  'git-http-push.txt' : 1,
    ++  'git-imap-send.txt' : 1,
    ++  'git-index-pack.txt' : 1,
    ++  'git-init-db.txt' : 1,
    ++  'git-init.txt' : 1,
    ++  'git-instaweb.txt' : 1,
    ++  'git-interpret-trailers.txt' : 1,
    ++  'git-log.txt' : 1,
    ++  'git-ls-files.txt' : 1,
    ++  'git-ls-remote.txt' : 1,
    ++  'git-ls-tree.txt' : 1,
    ++  'git-mailinfo.txt' : 1,
    ++  'git-mailsplit.txt' : 1,
    ++  'git-maintenance.txt' : 1,
    ++  'git-merge-base.txt' : 1,
    ++  'git-merge-file.txt' : 1,
    ++  'git-merge-index.txt' : 1,
    ++  'git-merge-one-file.txt' : 1,
    ++  'git-mergetool--lib.txt' : 1,
    ++  'git-mergetool.txt' : 1,
    ++  'git-merge-tree.txt' : 1,
    ++  'git-merge.txt' : 1,
    ++  'git-mktag.txt' : 1,
    ++  'git-mktree.txt' : 1,
    ++  'git-multi-pack-index.txt' : 1,
    ++  'git-mv.txt' : 1,
    ++  'git-name-rev.txt' : 1,
    ++  'git-notes.txt' : 1,
    ++  'git-p4.txt' : 1,
    ++  'git-pack-objects.txt' : 1,
    ++  'git-pack-redundant.txt' : 1,
    ++  'git-pack-refs.txt' : 1,
    ++  'git-patch-id.txt' : 1,
    ++  'git-prune-packed.txt' : 1,
    ++  'git-prune.txt' : 1,
    ++  'git-pull.txt' : 1,
    ++  'git-push.txt' : 1,
    ++  'git-quiltimport.txt' : 1,
    ++  'git-range-diff.txt' : 1,
    ++  'git-read-tree.txt' : 1,
    ++  'git-rebase.txt' : 1,
    ++  'git-receive-pack.txt' : 1,
    ++  'git-reflog.txt' : 1,
    ++  'git-refs.txt' : 1,
    ++  'git-remote-ext.txt' : 1,
    ++  'git-remote-fd.txt' : 1,
    ++  'git-remote.txt' : 1,
    ++  'git-repack.txt' : 1,
    ++  'git-replace.txt' : 1,
    ++  'git-replay.txt' : 1,
    ++  'git-request-pull.txt' : 1,
    ++  'git-rerere.txt' : 1,
    ++  'git-reset.txt' : 1,
    ++  'git-restore.txt' : 1,
    ++  'git-revert.txt' : 1,
    ++  'git-rev-list.txt' : 1,
    ++  'git-rev-parse.txt' : 1,
    ++  'git-rm.txt' : 1,
    ++  'git-send-email.txt' : 1,
    ++  'git-send-pack.txt' : 1,
    ++  'git-shell.txt' : 1,
    ++  'git-sh-i18n--envsubst.txt' : 1,
    ++  'git-sh-i18n.txt' : 1,
    ++  'git-shortlog.txt' : 1,
    ++  'git-show-branch.txt' : 1,
    ++  'git-show-index.txt' : 1,
    ++  'git-show-ref.txt' : 1,
    ++  'git-show.txt' : 1,
    ++  'git-sh-setup.txt' : 1,
    ++  'git-sparse-checkout.txt' : 1,
    ++  'git-stage.txt' : 1,
    ++  'git-stash.txt' : 1,
    ++  'git-status.txt' : 1,
    ++  'git-stripspace.txt' : 1,
    ++  'git-submodule.txt' : 1,
    ++  'git-svn.txt' : 1,
    ++  'git-switch.txt' : 1,
    ++  'git-symbolic-ref.txt' : 1,
    ++  'git-tag.txt' : 1,
    ++  'git-unpack-file.txt' : 1,
    ++  'git-unpack-objects.txt' : 1,
    ++  'git-update-index.txt' : 1,
    ++  'git-update-ref.txt' : 1,
    ++  'git-update-server-info.txt' : 1,
    ++  'git-upload-archive.txt' : 1,
    ++  'git-upload-pack.txt' : 1,
    ++  'git-var.txt' : 1,
    ++  'git-verify-commit.txt' : 1,
    ++  'git-verify-pack.txt' : 1,
    ++  'git-verify-tag.txt' : 1,
    ++  'git-version.txt' : 1,
    ++  'git-web--browse.txt' : 1,
    ++  'git-whatchanged.txt' : 1,
    ++  'git-worktree.txt' : 1,
    ++  'git-write-tree.txt' : 1,
    ++  'git.txt' : 1,
    ++  'gitk.txt' : 1,
    ++  'gitweb.txt' : 1,
    ++  'scalar.txt' : 1,
    ++
    ++  # Category 5.
    ++  'gitattributes.txt' : 5,
    ++  'gitformat-bundle.txt' : 5,
    ++  'gitformat-chunk.txt' : 5,
    ++  'gitformat-commit-graph.txt' : 5,
    ++  'gitformat-index.txt' : 5,
    ++  'gitformat-pack.txt' : 5,
    ++  'gitformat-signature.txt' : 5,
    ++  'githooks.txt' : 5,
    ++  'gitignore.txt' : 5,
    ++  'gitmailmap.txt' : 5,
    ++  'gitmodules.txt' : 5,
    ++  'gitprotocol-capabilities.txt' : 5,
    ++  'gitprotocol-common.txt' : 5,
    ++  'gitprotocol-http.txt' : 5,
    ++  'gitprotocol-pack.txt' : 5,
    ++  'gitprotocol-v2.txt' : 5,
    ++  'gitrepository-layout.txt' : 5,
    ++  'gitweb.conf.txt' : 5,
    ++
    ++  # Category 7.
    ++  'gitcli.txt' : 7,
    ++  'gitcore-tutorial.txt' : 7,
    ++  'gitcredentials.txt' : 7,
    ++  'gitcvs-migration.txt' : 7,
    ++  'gitdiffcore.txt' : 7,
    ++  'giteveryday.txt' : 7,
    ++  'gitfaq.txt' : 7,
    ++  'gitglossary.txt' : 7,
    ++  'gitpacking.txt' : 7,
    ++  'gitnamespaces.txt' : 7,
    ++  'gitremote-helpers.txt' : 7,
    ++  'gitrevisions.txt' : 7,
    ++  'gitsubmodules.txt' : 7,
    ++  'gittutorial-2.txt' : 7,
    ++  'gittutorial.txt' : 7,
    ++  'gitworkflows.txt' : 7,
    ++}
    ++
    ++asciidoc = find_program('asciidoc')
    ++git = find_program('git', required: false)
    ++xmlto = find_program('xmlto')
    ++
    ++git_revdate = ''
    ++if git.found()
    ++  git_revdate = run_command(git, 'show', '--quiet', '--pretty=%as', check: false).stdout().strip()
    ++endif
    ++
    ++asciidoc_common_options = [
    ++  asciidoc,
    ++  '--conf-file=' + meson.current_source_dir() / 'asciidoc.conf',
    ++  '--attribute=manual=Git Manual',
    ++  '--attribute=mansource=Git ' + git_version,
    ++  '--attribute=revdate=' + git_revdate,
    ++  '--attribute=build_dir=' + meson.current_build_dir(),
    ++]
    ++
    ++cmd_lists = [
    ++    'cmds-ancillaryinterrogators.txt',
    ++	'cmds-ancillarymanipulators.txt',
    ++	'cmds-mainporcelain.txt',
    ++	'cmds-plumbinginterrogators.txt',
    ++	'cmds-plumbingmanipulators.txt',
    ++	'cmds-synchingrepositories.txt',
    ++	'cmds-synchelpers.txt',
    ++	'cmds-guide.txt',
    ++	'cmds-developerinterfaces.txt',
    ++	'cmds-userinterfaces.txt',
    ++	'cmds-purehelpers.txt',
    ++	'cmds-foreignscminterface.txt',
    ++]
    ++
    ++documentation_deps = [ ]
    ++
    ++documentation_deps += custom_target(
    ++  command: [
    ++    perl,
    ++    meson.current_source_dir() / 'cmd-list.perl',
    ++    meson.project_source_root(),
    ++    meson.current_build_dir(),
    ++  ] + cmd_lists,
    ++  output: cmd_lists
    ++)
    ++
    ++foreach mode : [ 'diff', 'merge' ]
    ++  documentation_deps += custom_target(
    ++    command: [
    ++      shell,
    ++      meson.current_source_dir() / 'generate-mergetool-list.sh',
    ++      '..',
    ++      'diff',
    ++      '@OUTPUT@'
    ++    ],
    ++    env: [
    ++      'MERGE_TOOLS_DIR=' + meson.project_source_root() / 'mergetools',
    ++      'TOOL_MODE=' + mode,
    ++    ],
    ++    output: 'mergetools-' + mode + '.txt',
    ++  )
    ++endforeach
    ++
    ++foreach manpage, category : manpages
    ++  if get_option('docs').contains('man')
    ++    manpage_xml_target = custom_target(
    ++      command: asciidoc_common_options + [
    ++        '--backend=docbook',
    ++        '--doctype=manpage',
    ++        '--out-file=@OUTPUT@',
    ++        meson.current_source_dir() / manpage,
    ++      ],
    ++      depends: documentation_deps,
    ++      output: fs.stem(manpage) + '.xml',
    ++    )
    ++
    ++    manpage_path = fs.stem(manpage) + '.' + category.to_string()
    ++    manpage_target = custom_target(
    ++      command: [
    ++        xmlto,
    ++        '-m',
    ++        meson.current_source_dir() / 'manpage-normal.xsl',
    ++        '-m',
    ++        meson.current_source_dir() / 'manpage-bold-literal.xsl',
    ++        '--stringparam',
    ++        'man.base.url.for.relative.links=' + get_option('prefix') / get_option('mandir'),
    ++        'man',
    ++        manpage_xml_target,
    ++        '-o',
    ++        meson.current_build_dir(),
    ++      ],
    ++      output: manpage_path,
    ++      install: true,
    ++      install_dir: get_option('mandir') / 'man' + category.to_string(),
    ++    )
    ++  endif
    ++
    ++  if get_option('docs').contains('html') and category == 1
    ++    custom_target(
    ++      command: asciidoc_common_options + [
    ++        '--backend=xhtml11',
    ++        '--doctype=manpage',
    ++        '--out-file=@OUTPUT@',
    ++        meson.current_source_dir() / manpage,
    ++      ],
    ++      depends: documentation_deps,
    ++      output: fs.stem(manpage) + '.html',
    ++      install: true,
    ++      install_dir: get_option('datadir') / 'doc/git-doc',
    ++    )
    ++  endif
    ++endforeach
    +
      ## bin-wrappers/meson.build (new) ##
     @@
     +bin_wrappers_config = configuration_data()
    @@ gitweb/meson.build (new)
     +  configuration: gitweb_config,
     +)
     +
    -+test_dependencies += custom_target(script,
    ++test_dependencies += custom_target(
     +  input: 'gitweb.perl',
     +  output: 'gitweb.cgi',
     +  command: [
    @@ meson.build (new)
     +]
     +
     +libgit_sources += custom_target(
    -+  'command-list.h',
     +  input: 'command-list.txt',
     +  output: 'command-list.h',
     +  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
    @@ meson.build (new)
     +)
     +
     +libgit_sources += custom_target(
    -+  'config-list.h',
     +  output: 'config-list.h',
     +  command: [
     +    shell,
    @@ meson.build (new)
     +)
     +
     +libgit_sources += custom_target(
    -+  'hook-list.h',
     +  input: 'Documentation/githooks.txt',
     +  output: 'hook-list.h',
     +  command: [
    @@ meson.build (new)
     +endif
     +
     +foreach script : scripts_sh
    -+  test_dependencies += custom_target(script,
    ++  test_dependencies += custom_target(
     +    input: script,
     +    output: fs.stem(script),
     +    command: [
    @@ meson.build (new)
     +  ]
     +
     +  foreach script : scripts_perl
    -+    generated_script = custom_target(script,
    ++    generated_script = custom_target(
     +      input: script,
     +      output: fs.stem(script),
     +      command: generate_perl_command,
    @@ meson.build (new)
     +endif
     +
     +subdir('bin-wrappers')
    ++if get_option('docs') != []
    ++  subdir('Documentation')
    ++endif
     
      ## meson_options.txt (new) ##
     @@
    -+option('default_help_format', type: 'combo', choices: ['man', 'html', 'info'], value: 'man',
    -+  description: 'Format of installed documentation.')
     +option('default_pager', type: 'string', value: 'less',
     +  description: 'Fall-back pager.')
     +option('default_editor', type: 'string', value: 'vi',
    @@ meson_options.txt (new)
     +option('gitweb_site_footer', type: 'string', value: '')
     +option('highlight_bin', type: 'string', value: 'highlight')
     +
    ++option('docs', type: 'array', choices: ['man', 'html'], value: [],
    ++  description: 'Which documenattion formats to build and install.')
    ++option('default_help_format', type: 'combo', choices: ['man', 'html'], value: 'man',
    ++  description: 'Default format used when executing git-help(1).')
    ++
     +option('tests', type: 'boolean', value: true,
     +  description: 'Enable building tests. This requires Perl, but is separate from the "perl" option such that you can build tests without Perl features enabled.')
     +option('test_output_directory', type: 'string',
    @@ meson_options.txt (new)
     
      ## perl/FromCPAN/Mail/meson.build (new) ##
     @@
    -+test_dependencies += custom_target('Address.pm',
    ++test_dependencies += custom_target(
     +  input: 'Address.pm',
     +  output: 'Address.pm',
     +  command: generate_perl_command,
    @@ perl/FromCPAN/Mail/meson.build (new)
     
      ## perl/FromCPAN/meson.build (new) ##
     @@
    -+test_dependencies += custom_target('Error.pm',
    ++test_dependencies += custom_target(
     +  input: 'Error.pm',
     +  output: 'Error.pm',
     +  command: generate_perl_command,
    @@ perl/FromCPAN/meson.build (new)
     
      ## perl/Git/LoadCPAN/Mail/meson.build (new) ##
     @@
    -+test_dependencies += custom_target('Address.pm',
    ++test_dependencies += custom_target(
     +  input: 'Address.pm',
     +  output: 'Address.pm',
     +  command: generate_perl_command,
    @@ perl/Git/LoadCPAN/Mail/meson.build (new)
     
      ## perl/Git/LoadCPAN/meson.build (new) ##
     @@
    -+test_dependencies += custom_target('Error.pm',
    ++test_dependencies += custom_target(
     +  input: 'Error.pm',
     +  output: 'Error.pm',
     +  command: generate_perl_command,
    @@ perl/Git/LoadCPAN/meson.build (new)
     
      ## perl/Git/SVN/Memoize/meson.build (new) ##
     @@
    -+test_dependencies += custom_target('YAML.pm',
    ++test_dependencies += custom_target(
     +  input: 'YAML.pm',
     +  output: 'YAML.pm',
     +  command: generate_perl_command,
    @@ perl/Git/SVN/meson.build (new)
     +  'Ra.pm',
     +  'Utils.pm',
     +]
    -+  test_dependencies += custom_target(source,
    ++  test_dependencies += custom_target(
     +    input: source,
     +    output: source,
     +    command: generate_perl_command,
    @@ perl/Git/meson.build (new)
     +  'Packet.pm',
     +  'SVN.pm',
     +]
    -+  test_dependencies += custom_target(source,
    ++  test_dependencies += custom_target(
     +    input: source,
     +    output: source,
     +    command: generate_perl_command,
    @@ perl/Git/meson.build (new)
     
      ## perl/meson.build (new) ##
     @@
    -+test_dependencies += custom_target('Git.pm',
    ++test_dependencies += custom_target(
     +  input: 'Git.pm',
     +  output: 'Git.pm',
     +  command: generate_perl_command,
    @@ po/meson.build (new)
     +    'zh_TW',
     +  ],
     +  install: true,
    -+  install_dir: get_option('datadir'),
     +)
     +test_dependencies += translations[0]
     
    @@ t/meson.build (new)
     +  'unit-tests/unit-test.c',
     +]
     +
    -+clar_decls_h = custom_target('clar_decls_h',
    ++clar_decls_h = custom_target(
     +  input: clar_test_suites,
     +  output: 'clar-decls.h',
     +  command : [shell, meson.current_source_dir() + '/unit-tests/generate-clar-decls.sh', '@OUTPUT@', '@INPUT@'],
    @@ t/meson.build (new)
     +)
     +clar_sources += clar_decls_h
     +
    -+clar_sources += custom_target('clar_suite',
    ++clar_sources += custom_target(
     +  input: clar_decls_h,
     +  output: 'clar.suite',
     +  feed: true,
    @@ t/meson.build (new)
     +  'unit-tests/t-reftable-block.c',
     +  'unit-tests/t-reftable-merged.c',
     +  'unit-tests/t-reftable-pq.c',
    ++  'unit-tests/t-reftable-reader.c',
     +  'unit-tests/t-reftable-readwrite.c',
     +  'unit-tests/t-reftable-record.c',
     +  'unit-tests/t-reftable-stack.c',
    @@ t/meson.build (new)
     +  't2405-worktree-submodule.sh',
     +  't2406-worktree-repair.sh',
     +  't2407-worktree-heads.sh',
    ++  't2408-worktree-relative.sh',
     +  't2500-untracked-overwriting.sh',
     +  't2501-cwd-empty.sh',
     +  't3000-ls-files-others.sh',
 -:  ----------- > 19:  45e2ab4044a meson: fix conflicts with in-flight topics
-- 
2.47.0.118.gfd3785337b.dirty

