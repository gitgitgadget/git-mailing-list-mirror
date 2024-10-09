Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26661925BB
	for <git@vger.kernel.org>; Wed,  9 Oct 2024 14:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485777; cv=none; b=onVRuFXEpYITfjRneK97jrOx7qGjLSjxHRPksHeu9qV8pLfWzl6/lWWLD4PG+Wor4CEQ+7Qsok9qn7W+URwhCJQTgeNbuF2E/xvr+prOBuk+Nj8B0COMmhfvTnlm2ozTZEOnAG0o8nz2ZHjsGX99kmwny+xu5YjzKe8CI6ByJ5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485777; c=relaxed/simple;
	bh=htc8mmB9EYwFidYAuovksRQ4h1NIGJFil56JXDaq1nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oauq8r0+9Pd1kqy2Z0bhgNT+H0gAUT5MpsZ+8MOAId4Mreu32v6+QpaTnjV9UuXm25VHaGr7nMxIo+bgfxFpOEqiQgs1Ny+c4t036rK4QuYEwG54UcbeVxK8R14B1FWDttQ6BhaC/iTqSyKRyAl+dWWYOxTRDH8+oRKOI8ERTsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=E7fCCIYC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RmVwVU2R; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="E7fCCIYC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RmVwVU2R"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 08A1613802BF;
	Wed,  9 Oct 2024 10:56:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 09 Oct 2024 10:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728485772; x=1728572172; bh=CkwQJHRjQA
	69kLCXlep0MrJH5xAjtOpVSqOauoPWw6s=; b=E7fCCIYCQyj3Qv2AeVg0XeUhO7
	FB4aJQOgJ8OBOPXzqZRqrZESitBYKS7TkbZ02fs/unblB2Fgg3SRPfDOML4U7jwG
	UnUnM5Tp14J9JxR787N553tVltRtssjlWbTomallKRM9iD8M612omjUk4B0XuqaZ
	TAeR4fCmxc45yjZ7utezVZruuo9X9LIhf9NvWhK7EnFkw4WjdqBqXuQW776E/DzA
	FMpSIJ62b6lRvgdqj8qhHt3onDwBoMx96TXcj3bnYDUXtUZQLyXtzkqH/hQBqcov
	3cTHnCepo4LbEBM+1gff4ayuUhgzqVzgOSc1rKY/cVhJc2EQWTGLjee48NKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728485772; x=1728572172; bh=CkwQJHRjQA69kLCXlep0MrJH5xAj
	tOpVSqOauoPWw6s=; b=RmVwVU2Rra+/6okDVkXf8Yg8rog9nR4EmzmRWnflxp9r
	oN810e6a/mH5vU6izaFzRLhNuV1KPEFZ5XTPWOBxSOeUD9ygFIXtRoNGwLe4VJKR
	yPIXFreEoXGaDTZkb1StO1iwpSo522pWBMhadldt6P865B3XlidydkrXiWv1phqH
	2jZ+DZW5BKzrKAVsgBdD7yWj+O+XMcJOeAfv+ZMATgD6gAxlMIdxMNCBI9agNe4g
	2JPmM5Up+j81T07CBixOoE/xKUIHPGLfO5WuS2k6rFE1NZ5xU2b3nD0dEs2tAd3W
	Tb/5bBfeTzvS6gJMgffB588uZvEGWB/7pqJmnYtVCg==
X-ME-Sender: <xms:i5kGZ96xFWE5pkwcDnzj9Bh3GINCE7-9ACvzS4i_vxmGTTPkaogC7Q>
    <xme:i5kGZ65LqJgREPxn08yln8WLjTemV8Ykg7Hf0IpenLUQauMfgbfsWSdgWfRYdVWyp
    KaVtwqyXkIhKjCmww>
X-ME-Received: <xmr:i5kGZ0flbtOdUvMrobEV3CeuKqnlW-lXOF7VbgnunvK0W1dcyRd82tHsoQAtWE3t9Rm2y9JJVo4bjiBD6e-blTjETAnX4RCNbHaDaWGdglRksg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeffedgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeeuvefhfeeggeejffejhefgkeetgfdvuefgvdffvdeg
    udehhfffheekkeehleevnecuffhomhgrihhnpegtuddtqdhmvghsohhnrdgsuhhilhgupd
    hhthhtphdqfhgvthgthhdqughumhgsrdhshhdpthigthdrrghuthhopdhgihhthhhusgdr
    tghomhdpmhgvshhonhgsuhhilhgurdgtohhmpdhophgvnhhsshhlrdhorhhgpdiilhhisg
    drnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhm
    pehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuth
    dprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrghdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtoh
    drtghomh
X-ME-Proxy: <xmx:i5kGZ2LVjNz1ZyaK1VqhqQ8E98KedOPkNxEfM_eetocxy2JGVDrxrw>
    <xmx:i5kGZxKrSF7D9If6sGPCQVdDDlskzRob-BBmGkfDeoe2Wsu-ISFwcw>
    <xmx:i5kGZ_yeIUD95-M3e6ft-JSOhnbTwoKSYRtIl0W-62mfaRO5VYkELA>
    <xmx:i5kGZ9KqFA6agzLS_0XDRUkbbcENVWY3rThBKQwoj_LCoSR130HlBQ>
    <xmx:i5kGZ_joW7tGj58z7tvoqYU0Vwxek5ClaYSZf99VQp72QZnJn5PGNE3b>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Oct 2024 10:56:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2f06d068 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 9 Oct 2024 14:55:05 +0000 (UTC)
Date: Wed, 9 Oct 2024 16:56:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [RFC PATCH v2 00/24] Modernize our build system
Message-ID: <cover.1728485139.git.ps@pks.im>
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

this is the second version of the patch series that modernizes our build
system by introducing Meson. This series is still in an RFC state.

Changes compared to v1:

  - I've reordered patches such that the platform-specific patches all
    come up front. This allows us to merge them independently of the
    rest of this series.

  - I've included a couple more fixes to platform-specific issues.

  - I've introduced an ICONV prerequisite. Executing tests is currently
    broken when compiling with NO_ICONV=Yes, and this prerequisite fixes
    that.

  - I've upstreamed the standalone patch to the clar framework I had in
    v1 for how we typedef `struct stat`, and adapted the commit that
    updates clar to update to the newer version that includes the patch.

  - I've fixed an issue in "generate-clar-decls.h" when the build path
    contains spaces. I found this by accident when I had a spaces in my
    source directory on Windows.

  - I've rebased on top of Git v2.47.

  - I've clarified some commit messages.

  - I've updated "build-systems.txt" based on the feedback I got.

  - I've made Meson work with the Microsoft Visual Studio compiler.

  - I've included subproject wrappers. These are small files that tell
    Meson for how to build a dependency as a fallback in case the host
    system does not have the dependency. This allows a developer to
    build Git without any system-provided dependencies and is quite
    helpful especially on Windows.

  - Various other small fixes and improvements to Meson.

Overall I've got this to a state where things are mostly working. I've
successfully built and tested stuff on Linux, macOS 10.15, Windows 10
with MSVC, MinGW and Cygwin as well as FreeBSD.

The series is structured as following:

  - Patches 1 to 11 provide various fixes to preexisting issues on
    several platforms. These fixes can be merged independently of the
    rest of this series -- so even if you don't care for the remainder
    of it, I'd be happy if those were reviewed.

    @Junio: Let me know whether this is good enough for you, or whether
    I should split those patches out into a separate series.

  - Patches 12 to 22 refactor parts of our build system to make proper
    out-of-tree builds a reality.

  - Patch 23 introdudces the "build-systems.txt" file.

  - Patch 24 introduces the Meson build system.

Thanks!

Patrick

Patrick Steinhardt (24):
  t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
  t/test-lib: wire up NO_ICONV prerequisite
  t/lib-gitweb: test against the build version of gitweb
  t/lib-gpg: fix setup of GNUPGHOME in MinGW
  t1401: make invocation of tar(1) work with Win32-provided one
  t3404: work around platform-specific behaviour on macOS 10.15
  t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
  t7300: work around platform-specific behaviour with long paths on
    MinGW
  t/unit-tests: update clar unit test framework
  builtin/credential-cache: fix missing parameter for stub function
  http: fix build error on FreeBSD
  Makefile: extract script to generate clar declarations
  Makefile: extract script to massage Perl scripts
  Makefile: refactor GIT-VERSION-GEN to be reusable
  Makefile: refactor generators to be PWD-independent
  Makefile: use common template for GIT-BUILD-OPTIONS
  Makefile: consistently use @PLACEHOLDER@ to substitute
  Makefile: consistently use PERL_PATH
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
 GIT-BUILD-OPTIONS.in                          |   41 +
 GIT-VERSION-GEN                               |   12 +-
 Makefile                                      |  187 +-
 bin-wrappers/.gitignore                       |    9 +
 bin-wrappers/meson.build                      |   28 +
 bin-wrappers/wrap-for-bin.sh                  |   37 +
 builtin/credential-cache.c                    |    3 +-
 configure.ac                                  |    2 +-
 contrib/buildsystems/CMakeLists.txt           |  135 +-
 contrib/completion/meson.build                |    8 +
 contrib/meson.build                           |    1 +
 generate-cmdlist.sh                           |   42 +-
 generate-configlist.sh                        |   20 +-
 generate-hooklist.sh                          |   15 +-
 generate-perl.sh                              |   22 +
 git-cvsserver.perl                            |    2 +-
 git-instaweb.sh                               |    8 +-
 git-request-pull.sh                           |    2 +-
 git-send-email.perl                           |    2 +-
 git-sh-i18n.sh                                |    6 +-
 git-sh-setup.sh                               |    6 +-
 git-svn.perl                                  |    2 +-
 gitk-git/po/vi.po                             |    2 +-
 gitweb/Makefile                               |   44 +-
 gitweb/gitweb.perl                            |   44 +-
 gitweb/meson.build                            |   32 +
 gitweb/static/meson.build                     |   28 +
 http.c                                        |   10 +-
 meson.build                                   | 1607 +++++++++++++++++
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
 perl/meson.build                              |   18 +
 po/meson.build                                |   28 +
 subprojects/curl.wrap                         |   13 +
 subprojects/expat.wrap                        |   13 +
 subprojects/openssl.wrap                      |   15 +
 subprojects/pcre2.wrap                        |   16 +
 subprojects/zlib.wrap                         |   13 +
 t/helper/meson.build                          |   91 +
 t/lib-gettext.sh                              |    4 +-
 t/lib-gitweb.sh                               |    2 +-
 t/lib-gpg.sh                                  |    2 +-
 t/meson.build                                 | 1105 ++++++++++++
 t/t0028-working-tree-encoding.sh              |    6 +
 t/t1401-symbolic-ref.sh                       |    2 +-
 t/t2082-parallel-checkout-attributes.sh       |    2 +-
 t/t3404-rebase-interactive.sh                 |   26 +-
 t/t3434-rebase-i18n.sh                        |    6 +
 t/t3900-i18n-commit.sh                        |    6 +
 t/t3901-i18n-patch.sh                         |    6 +
 t/t4041-diff-submodule-option.sh              |   16 +-
 t/t4059-diff-submodule-not-initialized.sh     |   16 +-
 t/t4060-diff-submodule-option-diff-format.sh  |   17 +-
 t/t4201-shortlog.sh                           |    8 +-
 t/t4205-log-pretty-formats.sh                 |  102 +-
 t/t4210-log-i18n.sh                           |    6 +
 t/t4254-am-corrupt.sh                         |    6 +
 t/t5100-mailinfo.sh                           |   14 +-
 t/t5500-fetch-pack.sh                         |   14 +-
 t/t5550-http-fetch-dumb.sh                    |    4 +-
 t/t5601-clone.sh                              |   11 +-
 t/t6006-rev-list-format.sh                    |   54 +-
 t/t7102-reset.sh                              |   40 +-
 t/t7300-clean.sh                              |    2 +-
 t/t7609-mergetool--lib.sh                     |    2 +-
 t/t8005-blame-i18n.sh                         |    6 +
 t/t9300-fast-import.sh                        |    2 +-
 t/t9350-fast-export.sh                        |   10 +-
 t/test-lib.sh                                 |   25 +-
 t/unit-tests/clar/.editorconfig               |   13 +
 t/unit-tests/clar/.github/workflows/ci.yml    |   20 +-
 t/unit-tests/clar/.gitignore                  |    1 +
 t/unit-tests/clar/CMakeLists.txt              |   28 +
 t/unit-tests/clar/clar.c                      |  111 +-
 t/unit-tests/clar/clar/print.h                |   11 +-
 t/unit-tests/clar/clar/sandbox.h              |   17 +-
 t/unit-tests/clar/clar/summary.h              |   14 +-
 t/unit-tests/clar/test/.gitignore             |    4 -
 t/unit-tests/clar/test/CMakeLists.txt         |   41 +
 t/unit-tests/clar/test/Makefile               |   39 -
 t/unit-tests/generate-clar-decls.sh           |   18 +
 templates/Makefile                            |   38 +-
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
 templates/meson.build                         |    8 +
 unimplemented.sh                              |    2 +-
 wrap-for-bin.sh                               |   36 -
 118 files changed, 4319 insertions(+), 595 deletions(-)
 create mode 100644 Documentation/technical/build-systems.txt
 create mode 100644 GIT-BUILD-OPTIONS.in
 create mode 100644 bin-wrappers/.gitignore
 create mode 100644 bin-wrappers/meson.build
 create mode 100755 bin-wrappers/wrap-for-bin.sh
 create mode 100644 contrib/completion/meson.build
 create mode 100644 contrib/meson.build
 create mode 100755 generate-perl.sh
 create mode 100644 gitweb/meson.build
 create mode 100644 gitweb/static/meson.build
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
 create mode 100644 subprojects/curl.wrap
 create mode 100644 subprojects/expat.wrap
 create mode 100644 subprojects/openssl.wrap
 create mode 100644 subprojects/pcre2.wrap
 create mode 100644 subprojects/zlib.wrap
 create mode 100644 t/helper/meson.build
 create mode 100644 t/meson.build
 create mode 100644 t/unit-tests/clar/.editorconfig
 create mode 100644 t/unit-tests/clar/.gitignore
 create mode 100644 t/unit-tests/clar/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/.gitignore
 create mode 100644 t/unit-tests/clar/test/CMakeLists.txt
 delete mode 100644 t/unit-tests/clar/test/Makefile
 create mode 100755 t/unit-tests/generate-clar-decls.sh
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

Range-diff against v1:
 2:  559b593b598 =  1:  6dd59db9b2b t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
 -:  ----------- >  2:  5ec91ac12da t/test-lib: wire up NO_ICONV prerequisite
 3:  be8ba4b9679 =  3:  94664e2cc06 t/lib-gitweb: test against the build version of gitweb
 4:  b5c116396da !  4:  ffb661dad71 t/lib-gpg: fix setup of GNUPGHOME in MinGW
    @@ Commit message
         t/lib-gpg: fix setup of GNUPGHOME in MinGW
     
         In "t/lib-gpg.sh" we set up the "GNUPGHOME" environment variable to
    -    point to a test-specific diretcory. This is done by using "$PWD/gpghome"
    +    point to a test-specific directory. This is done by using "$PWD/gpghome"
         as value, where "$PWD" is the current test's trash directory.
     
         This is broken for MinGW though because "$PWD" will use Windows-style
         paths that contain drive letters. What we really want in this context is
    -    a Unix-style path, which we can get by using `$(pwd)` instead.
    +    a Unix-style path, which we can get by using `$(pwd)` instead. It is
    +    somewhat puzzling that nobody ever hit this issue, but it may easily be
    +    that nobody ever tests on Windows with GnuPG installed, which would make
    +    us skip those tests.
     
         Adapt the code accordingly to fix tests using this library.
     
 -:  ----------- >  5:  958cf3a6b57 t1401: make invocation of tar(1) work with Win32-provided one
 -:  ----------- >  6:  bada3a82fdd t3404: work around platform-specific behaviour on macOS 10.15
 -:  ----------- >  7:  b4bdefe9e34 t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 -:  ----------- >  8:  48ce19d876f t7300: work around platform-specific behaviour with long paths on MinGW
 6:  a0eff395839 !  9:  73b4362164a t/unit-tests: update clar unit test framework
    @@ Metadata
      ## Commit message ##
         t/unit-tests: update clar unit test framework
     
    -    Update clar unit test framework to 67e689a (Merge pull request #103 from
    -    pks-t/pks-editorconfig, 2024-09-20).
    +    Update clar unit test framework to f065214 (Merge pull request #105 from
    +    pks-t/pks-win32-stat-compat, 2024-10-03), which fixes some platform
    +    compatibility issues with Windows.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ t/unit-tests/clar/clar.c
      /* required for sandboxing */
      #include <sys/types.h>
     @@
    + 
    + #	ifndef stat
    + #		define stat(path, st) _stat(path, st)
    ++		typedef struct _stat STAT_T;
    ++#	else
    ++		typedef struct stat STAT_T;
    + #	endif
    + #	ifndef mkdir
    + #		define mkdir(path, mode) _mkdir(path)
    +@@
    + #	else
      #		define p_snprintf snprintf
      #	endif
    - 
    +-
     -#	ifndef PRIuZ
     -#		define PRIuZ "Iu"
     -#	endif
    @@ t/unit-tests/clar/clar.c
     -#		define PRIxZ "Ix"
     -#	endif
     -
    - #	if defined(_MSC_VER) || (defined(__MINGW32__) && !defined(__MINGW64_VERSION_MAJOR))
    - 	typedef struct stat STAT_T;
    - #	else
    -@@
    +-#	if defined(_MSC_VER) || (defined(__MINGW32__) && !defined(__MINGW64_VERSION_MAJOR))
    +-	typedef struct stat STAT_T;
    +-#	else
    +-	typedef struct _stat STAT_T;
    +-#	endif
    + #else
    + #	include <sys/wait.h> /* waitpid(2) */
      #	include <unistd.h>
      #	define _MAIN_CC
      #	define p_snprintf snprintf
 8:  7a36ad58384 = 10:  161f6b063af builtin/credential-cache: fix missing parameter for stub function
 9:  1c1cd4d8ef9 = 11:  e4ef4bdf1c5 http: fix build error on FreeBSD
10:  b05a551b1c2 ! 12:  6ea97bc92f2 Makefile: extract script to generate clar declarations
    @@ t/unit-tests/generate-clar-decls.sh (new)
     @@
     +#!/bin/sh
     +
    -+if test $# -lt 3
    ++if test $# -lt 2
     +then
     +	echo "USAGE: $0 <OUTPUT> <SUITE>..." 2>&1
     +	exit 1
    @@ t/unit-tests/generate-clar-decls.sh (new)
     +OUTPUT="$1"
     +shift
     +
    -+for suite in $*
    ++while test "$#" -ne 0
     +do
    ++	suite="$1"
    ++	shift
     +	sed -ne "s/^\(void test_$suite__[a-zA-Z_0-9][a-zA-Z_0-9]*(void)$\)/extern \1;/p" "$suite" ||
     +	exit 1
     +done >"$OUTPUT"
11:  ccfa97bd3db = 13:  7f567d7ce23 Makefile: extract script to massage Perl scripts
12:  ada39ec21dd ! 14:  dfc941cd18d Makefile: refactor GIT-VERSION-GEN to be reusable
    @@ GIT-VERSION-GEN
      #!/bin/sh
      
     -GVF=GIT-VERSION-FILE
    - DEF_VER=v2.47.0-rc0
    + DEF_VER=v2.47.0
      
      LF='
     @@ GIT-VERSION-GEN: fi
13:  7136aeaa138 = 15:  e468d3751f0 Makefile: refactor generators to be PWD-independent
14:  a5a43ed685e ! 16:  dbf9e39e3df Makefile: use common template for GIT-BUILD-OPTIONS
    @@ GIT-BUILD-OPTIONS.in (new)
     +PYTHON_PATH=@PYTHON_PATH@
     +TAR=@TAR@
     +NO_CURL=@NO_CURL@
    ++NO_ICONV=@NO_ICONV@
     +NO_EXPAT=@NO_EXPAT@
     +USE_LIBPCRE2=@USE_LIBPCRE2@
     +NO_PERL=@NO_PERL@
    @@ Makefile: GIT-LDFLAGS: FORCE
     -	@echo PYTHON_PATH=\''$(subst ','\'',$(PYTHON_PATH_SQ))'\' >>$@+
     -	@echo TAR=\''$(subst ','\'',$(subst ','\'',$(TAR)))'\' >>$@+
     -	@echo NO_CURL=\''$(subst ','\'',$(subst ','\'',$(NO_CURL)))'\' >>$@+
    +-	@echo NO_ICONV=\''$(subst ','\'',$(subst ','\'',$(NO_ICONV)))'\' >>$@+
     -	@echo NO_EXPAT=\''$(subst ','\'',$(subst ','\'',$(NO_EXPAT)))'\' >>$@+
     -	@echo USE_LIBPCRE2=\''$(subst ','\'',$(subst ','\'',$(USE_LIBPCRE2)))'\' >>$@+
     -	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
    @@ Makefile: GIT-LDFLAGS: FORCE
     +		-e "s|@PYTHON_PATH@|\'$(PYTHON_PATH_SQ)\'|" \
     +		-e "s|@TAR@|\'$(TAR)\'|" \
     +		-e "s|@NO_CURL@|\'$(NO_CURL)\'|" \
    ++		-e "s|@NO_ICONV@|\'$(NO_ICONV)\'|" \
     +		-e "s|@NO_EXPAT@|\'$(NO_EXPAT)\'|" \
     +		-e "s|@USE_LIBPCRE2@|\'$(USE_LIBPCRE2)\'|" \
     +		-e "s|@NO_PERL@|\'$(NO_PERL)\'|" \
    @@ contrib/buildsystems/CMakeLists.txt: if(NOT PYTHON_TESTS)
     -file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "PYTHON_PATH='${PYTHON_PATH}'\n")
     -file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "TAR='${TAR}'\n")
     -file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_CURL='${NO_CURL}'\n")
    +-file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_ICONV='${NO_ICONV}'\n")
     -file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_EXPAT='${NO_EXPAT}'\n")
     -file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PERL='${NO_PERL}'\n")
     -file(APPEND ${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS "NO_PTHREADS='${NO_PTHREADS}'\n")
    @@ contrib/buildsystems/CMakeLists.txt: if(NOT PYTHON_TESTS)
     +string(REPLACE "@PYTHON_PATH@" "${PYTHON_PATH}" git_build_options "${git_build_options}")
     +string(REPLACE "@TAR@" "${TAR}" git_build_options "${git_build_options}")
     +string(REPLACE "@NO_CURL@" "${NO_CURL}" git_build_options "${git_build_options}")
    ++string(REPLACE "@NO_ICONV@" "${NO_ICONV}" git_build_options "${git_build_options}")
     +string(REPLACE "@NO_EXPAT@" "${NO_EXPAT}" git_build_options "${git_build_options}")
     +string(REPLACE "@USE_LIBPCRE2@" "" git_build_options "${git_build_options}")
     +string(REPLACE "@NO_PERL@" "${NO_PERL}" git_build_options "${git_build_options}")
15:  6aaf3263228 ! 17:  97b9789dd68 Makefile: consistently use @PLACEHOLDER@ to substitute
    @@ Commit message
         different formats: @PLACEHOLDER@, @@PLACEHOLDER@@ and ++PLACEHOLDER++.
     
         Next to being inconsistent it also creates a bit of a problem with
    -    CMake, which only supports the first syntax. To work around that we
    -    instead manually replace such strings via string operations, which is
    -    both a hassle and also removes safeguards that CMake has to verify that
    -    we didn't forget to replace any placeholders. Besides that, other build
    -    systems like Meson also support the CMake syntax.
    +    CMake, which only supports the first syntax in its `configure_file()`
    +    function. To work around that we instead manually replace placeholders
    +    via string operations, which is a hassle and removes safeguards that
    +    CMake has to verify that we didn't forget to replace any placeholders.
    +    Besides that, other build systems like Meson also support the CMake
    +    syntax.
     
         Unify our codebase to consistently use the syntax supported by such
         build systems.
16:  73417f39a5e = 18:  1ee9c61fc33 Makefile: consistently use PERL_PATH
17:  4b356c0b634 = 19:  9fd1aeb1e96 Makefile: allow "bin-wrappers/" directory to exist
18:  bf55d0c226d = 20:  4eda54cf0f5 Makefile: simplify building of templates
19:  7a0a6b996c3 = 21:  1172c440600 t: better support for out-of-tree builds
20:  c5ae59ce905 ! 22:  b5cd5250b77 t: allow overriding build dir
    @@ Commit message
         directory of "t/". While true when using our Makefile, it's not when
         using build systems that support out-of-tree builds.
     
    -    Allow such build systems to override the location of the build directory
    -    with an environment variable.
    +    In commit ee9e66e4e7 (cmake: avoid editing t/test-lib.sh, 2022-10-18),
    +    we have introduce support for overriding the GIT_BIULD_DIR by creating
    +    the file "$GIT_BUILD_DIR/GIT-BUILD-DIR" with its contents pointing to
    +    the location of the build directory. The intent was to stop modifying
    +    "t/test-lib.sh" with the CMake build systems while allowing out-of-tree
    +    builds. But "$GIT_BUILD_DIR" is somewhat misleadingly named, as it in
    +    fact points to the _source_ directory. So while that commit solved part
    +    of the problem for out-of-tree builds, CMake still has to write files
    +    into the source tree.
    +
    +    Solve the second part of the problem, namely not having to write any
    +    data into the source directory at all, by also supporting an environment
    +    variable that allows us to point to a different build directory. This
    +    allows us to perform properly self-contained out-of-tree builds.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
 1:  508e3783d28 ! 23:  afa2f79d46c Documentation: add comparison of build systems
    @@ Documentation/technical/build-systems.txt (new)
     += Build Systems
     +
     +The build system is the primary way for both developers and system integrators
    -+to interact with the Git project. As such, we consider it important to pick a
    -+build system that fulfills our requirements while being easy to use and extend.
    ++to interact with the Git project. As such, being easy to use and extend for
    ++those who are not directly developing Git itself is just as important as other
    ++requirements we have on any potential build system.
     +
     +This document outlines the different requirements that we have for the build
     +system and then compares available build systems using these criteria.
     +
     +== Requirements
     +
    -+The following subsections prevent a list of requirements that we have for any
    ++The following subsections present a list of requirements that we have for any
     +potential build system. Sections are sorted by decreasing priority, even though
     +these priorities will naturally differ between users.
     +
     +=== Platform support
     +
    -+The most important criterium is whether the build system supports all of the
    -+platforms that Git supports. The most important platforms include:
    ++The build system must have support for all of our primary platforms as outlined
    ++by. These platforms are:
     +
     +  - Linux
    -+  - macOS
     +  - Windows
    ++  - macOS
    ++
    ++Furthermore, the build system should have support for the following secondary
    ++platforms:
    ++
    ++  - AIX
     +  - FreeBSD
    -+  - OpenBSD
     +  - NetBSD
    ++  - OpenBSD
     +
     +The platforms which must be supported by the tool should be aligned with our
     +[platform support policy](platform-support.txt).
     +
     +=== Auto-detection of supported features
     +
    -+The build system MUST support auto-detection of features which are or aren't
    ++The build system must support auto-detection of features which are or aren't
     +available on the current platform. Platform maintainers should not be required
     +to manually configure the complete build.
     +
    @@ Documentation/technical/build-systems.txt (new)
     +  - Check for the existence of libraries.
     +  - Check for the existence of exectuables.
     +  - Check for the runtime behavior of specific functions.
    ++  - Check for specific link order requirements when multiple libraries are
    ++    involved.
     +
     +=== Ease of use
     +
    -+The build system SHOULD be both easy to use and easy to extend. While this is
    ++The build system should be both easy to use and easy to extend. While this is
     +naturally a subjective metric it is likely not controversial to say that some
     +build systems are considerably harder to use than others.
     +
     +=== IDE support
     +
    -+The build system SHOULD integrate with well-known IDEs. Well-known IDEs include:
    ++The build system should integrate with well-known IDEs. Well-known IDEs include:
     +
     +  - Microsoft Visual Studio
     +  - Visual Studio Code
    @@ Documentation/technical/build-systems.txt (new)
     +
     +=== Out-of-tree builds
     +
    -+The build system SHOULD support out-of-tree builds. Out-of-tree builds allow a
    ++The build system should support out-of-tree builds. Out-of-tree builds allow a
     +developer to configure multiple different build directories with different
     +configuration, e.g. one "debug" build and one "release" build.
     +
    -+=== Rust support
    ++=== Cross-platform builds
    ++
    ++The build system should support cross-platform builds, e.g. building for arm on
    ++an x86-64 host.
    ++
    ++=== Language support
    ++
    ++The following languages and toolchains are of relevance and should be supported
    ++by the build system:
    ++
    ++  - C: the primary compiled language used by Git, must be supported. Relevant
    ++    toolchains are GCC, Clang and MSVC.
    ++  - Rust: candidate as a second compiled lanugage, should be supported. Relevant
    ++    toolchains is the LLVM-based rustc.
    ++
    ++Built-in support for the respective languages is preferred over support that
    ++needs to be wired up manually to avoid unnecessary complexity. Native support
    ++includes the following features:
    ++
    ++  - Compiling objects.
    ++  - Dependency tracking.
    ++  - Detection of available features.
    ++  - Discovery of relevant toolchains.
    ++  - Linking libraries and executables.
    ++
    ++=== Test integration
    ++
    ++It should be possible to integrate tests into the build system such that it is
    ++possible to build and test Git within the build system. Features which are nice
    ++to have:
     +
    -+Many long-time Git contributors are nowadays in favor of adopting Rust as a
    -+second language next to C. The build system SHOULD thus support Rust such that
    -+we do not have to reopen the discussion once we decide to pick up Rust.
    ++  - Track build-time dependencies for respective tests. Unit tests have
    ++    different requirements than integration tests.
    ++  - Allow filtering of which tests to run.
    ++  - Allow interactive tests that drop the user into a shell with `test_pause` or
    ++    `debug`.
     +
     +== Comparison
     +
    @@ Documentation/technical/build-systems.txt (new)
     +  rules can quickly get out of hand once reaching a certain scope.
     +- IDE support: execution of Makefile targets is supported by many IDEs
     +- Out-of-tree builds: supported in theory, not wired up in practice.
    -+- Rust: can be added.
    ++- Cross-platform builds: supported in theory, not wired up in practice.
    ++- Language support:
    ++  - C: Limited built-in support, many parts need to be wired up manually.
    ++  - Rust: No built-in support, needs to be wired up manually.
    ++- Test integration: partially supported, many parts need to be wired up
    ++  manually.
     +
     +=== autoconf
     +
    @@ Documentation/technical/build-systems.txt (new)
     +- IDE support: no integration into IDEs at generation time. The generated
     +  Makefiles have the same level of support as GNU Make.
     +- Out-of-tree builds: supported in theory, not wired up in practice.
    -+- Rust: not supported.
    ++- Cross-platform builds: supported.
    ++- Language support:
    ++  - C: Limited built-in support, many parts need to be wired up manually.
    ++  - Rust: No built-in support, needs to be wired up manually.
    ++- Test integration: partially supported, many parts need to be wired up
    ++  manually.
     +
     +=== CMake
     +
    @@ Documentation/technical/build-systems.txt (new)
     +  project descriptions for Xcode. An extension is available for Visual Studio
     +  Code. Many other IDEs have plugins for CMake.
     +- Out-of-tree builds: supported.
    -+- Rust: not supported.
    ++- Cross-platform builds: supported.
    ++- Language support:
    ++  - C: Supported for GCC, Clang, MSVC and other toolchains.
    ++  - Rust: No built-in support, needs to be wired up manually.
    ++- Test integration: supported, even though test dependencies are a bit
    ++  cumbersome to use via "test fixtures". Interactive test runs are not
    ++  supported.
     +
     +=== Meson
     +
    @@ Documentation/technical/build-systems.txt (new)
     +- IDE support: Supports generating build instructions for Xcode and Microsoft
     +  Visual Studio, a plugin exists for Visual Studio Code.
     +- Out-of-tree builds: supported.
    -+- Rust: supported.
    ++- Cross-platform builds: supported.
    ++- Language support:
    ++  - C: Supported for GCC, Clang, MSVC and other toolchains.
    ++  - Rust: Supported for rustc.
    ++- Test integration: supported. Interactive tests are supported starting with
    ++  Meson 1.5.0 via the `--interactive` flag.
 5:  00fd829833c <  -:  ----------- t3404: work around platform-specific behaviour on macOS 10.15
 7:  f006545eef1 <  -:  ----------- t/clar: simplify how the clar derives `struct stat`
21:  a19af6507c0 ! 24:  724232b0fad Introduce support for the Meson build system
    @@ Commit message
             ```
     
         The build instructions have been successfully tested on the following
    -    systems. Tests are mostly passing:
    +    systems, tests are passing:
     
           - Apple macOS 10.15.
    +
           - FreeBSD 14.1, except gitweb-based tests.
    +
           - NixOS 24.11.
    +
           - Ubuntu 24.04.
    -      - Windows 10 with Cygwin, using `-Dperl=disabled -Dpython=disabled`,
    -        except for t0052, t0301, t5500, t5572, t5601.
    -      - Windows 10 with MinGW64, using `-Dperl=disabled -Dpython=disabled`,
    -        except for t7300.
    +
    +      - Windows 10 with Cygwin, using `-Dperl=disabled -Dpython=disabled`.
    +
    +      - Windows 10 with MinGW64, using `-Dperl=disabled -Dpython=disabled`.
    +
    +      - Windows 10 with MSVC 2022, using `-Dperl=disabled -Dpython=disabled
    +        -Dgettext=disabled -Diconv=disabled --wrap-mode=forcefallback`.
     
         It is expected that there will still be rough edges in the current
         version. If this patch lands the expectation is that it will coexist
    @@ Commit message
           - Support for installing documentation has not been wired up yet. This
             will follow if the project can agree on Meson as build system.
     
    -      - Support for Microsoft Visual Studio has not yet been tested, mostly
    -        because I have been fighting with the Windows-based systems for a
    -        long while already. This will follow if the project can agree on
    -        Meson as build system
    -
           - Documentation does not yet exist. Same here, it will follow if the
             project can agree on Meson.
     
    -      - We're targeting a relatively-recent Meson 1.3.0, which has been
    -        released November 2023. The only feature we use from that version is
    +      - We're targeting a Meson 1.3.0, which has been released relatively
    +        recently November 2023. The only feature we use from that version is
             `fs.relative_to()`, which we could replace if necessary. If so, we
             could start to target Meson 1.0.0 and newer, released in December
             2022.
     
           - The whole build instructions count around 3000 lines, half of which
             is listing all of our code and test files. Our Makefiles are around
    -        5000 lines of, autoconf adds another 1300 lines. CMake in comparison
    -        has only 1200 lines of code, but it avoids listing individual files
    -        and does not wire up auto-configuration as extensively as the Meson
    -        files do.
    +        5000 lines, autoconf adds another 1300 lines. CMake in comparison
    +        has only 1200 linescode, but it avoids listing individual files and
    +        does not wire up auto-configuration as extensively as the Meson
    +        instructions do.
     
    -      - I didn't yet port the workaround for the `gettext` package in
    -        Homebrew being key-only over. Users have to manually add CFLAGS and
    -        LDFLAGS for that library to work around this issue with Homebrew.
    +      - We bundle a set of subproject wrappers for curl, expat, openssl,
    +        pcre2 and zlib. This allows developers to build Git without these
    +        dependencies preinstalled, and Meson will fetch and build them
    +        automatically. This is especially helpful on Windows.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ gitweb/static/meson.build (new)
      ## meson.build (new) ##
     @@
     +project('git', 'c',
    -+  version: run_command('GIT-VERSION-GEN', check: true).stdout().strip(),
     +  meson_version: '>=1.3.0',
    ++  # MSVC does not support GNU99, and C99 does not define __STDC_VERSION__
    ++  # on MSVC. So we instead fall back to C11 there.
    ++  default_options: ['c_std=gnu99,c11'],
    ++  version: run_command('GIT-VERSION-GEN', check: true).stdout().strip(),
     +)
     +
     +fs = import('fs')
    @@ meson.build (new)
     +  'builtin/write-tree.c',
     +]
     +
    ++script_environment = environment()
    ++foreach tool : ['cat', 'cut', 'grep', 'sed', 'sort', 'tr', 'uname']
    ++  program = find_program(tool)
    ++  script_environment.prepend('PATH', fs.parent(program.full_path()))
    ++endforeach
    ++
     +libgit_sources += custom_target(
     +  'command-list.h',
     +  input: 'command-list.txt',
     +  output: 'command-list.h',
     +  command: [shell, meson.current_source_dir() + '/generate-cmdlist.sh', meson.current_source_dir(), '@OUTPUT@'],
    ++  env: script_environment,
     +)
     +
     +libgit_sources += custom_target(
    @@ meson.build (new)
     +    meson.current_source_dir(),
     +    '@OUTPUT@',
     +  ],
    ++  env: script_environment,
     +)
     +
     +libgit_sources += custom_target(
    @@ meson.build (new)
     +    meson.current_source_dir(),
     +    '@OUTPUT@',
     +  ],
    ++  env: script_environment,
     +)
     +
     +# This contains the variables for GIT-BUILD-OPTIONS, which we use to propagate
    @@ meson.build (new)
     +  build_options_config.set('NO_PERL', '1')
     +endif
     +
    -+zlib = dependency('zlib')
    -+libgit_dependencies += zlib
    -+if not compiler.has_function('deflateBound',
    ++zlib = dependency('zlib', default_options: ['default_library=static', 'tests=disabled'])
    ++if zlib.type_name() != 'internal' and not compiler.has_function('deflateBound',
     +  prefix: '#include <zlib.h>',
     +  dependencies: zlib,
     +)
     +  libgit_c_args += '-DNO_DEFLATE_BOUND'
     +endif
    ++libgit_dependencies += zlib
     +
     +threads = dependency('threads', required: false)
     +if threads.found()
    @@ meson.build (new)
     +  build_options_config.set('NO_PTHREADS', '1')
     +endif
     +
    -+intl = dependency('intl', required: get_option('gettext'))
    ++if get_option('gettext').allowed() and host_machine.system() == 'darwin' and get_option('macos_use_homebrew_gettext')
    ++  if host_machine.cpu_family() == 'x86_64'
    ++    libintl_prefix = '/usr/local'
    ++  elif host_machine.cpu_family() == 'aarch64'
    ++    libintl_prefix = '/opt/homebrew'
    ++  else
    ++    error('Homebrew workaround not supported on current architecture')
    ++  endif
    ++
    ++  intl = compiler.find_library('intl', dirs: libintl_prefix / 'lib', required: get_option('gettext'))
    ++  if intl.found()
    ++    intl = declare_dependency(
    ++      dependencies: intl,
    ++      include_directories: libintl_prefix / 'include',
    ++    )
    ++  endif
    ++else
    ++  intl = dependency('intl', required: get_option('gettext'))
    ++endif
     +if intl.found()
     +  libgit_dependencies += intl
     +  build_options_config.set('NO_GETTEXT', '')
    @@ meson.build (new)
     +iconv = dependency('iconv', required: get_option('iconv'))
     +if iconv.found()
     +  libgit_dependencies += iconv
    ++  build_options_config.set('NO_ICONV', '')
     +
     +  have_old_iconv = false
     +  if not compiler.compiles('''
    @@ meson.build (new)
     +  endif
     +else
     +  libgit_c_args += '-DNO_ICONV'
    ++  build_options_config.set('NO_ICONV', '1')
     +endif
     +
    -+pcre2 = dependency('libpcre2-8', required: get_option('pcre2'))
    ++pcre2 = dependency('libpcre2-8', required: get_option('pcre2'), default_options: ['default_library=static', 'test=false'])
     +if pcre2.found()
     +  libgit_dependencies += pcre2
     +  libgit_c_args += '-DUSE_LIBPCRE2'
    @@ meson.build (new)
     +  build_options_config.set('USE_LIBPCRE2', '')
     +endif
     +
    -+curl = dependency('libcurl', version: '>=7.21.3', required: get_option('curl'))
    ++curl = dependency('libcurl', version: '>=7.21.3', required: get_option('curl'), default_options: ['default_library=static', 'tests=disabled'])
     +use_curl_for_imap_send = false
     +if curl.found()
     +  if curl.version().version_compare('>=7.34.0')
    @@ meson.build (new)
     +  build_options_config.set('NO_CURL', '1')
     +endif
     +
    -+expat = dependency('expat', required: get_option('expat'))
    ++expat = dependency('expat', required: get_option('expat'), default_options: ['default_library=static', 'build_tests=false'])
     +if expat.found()
     +  libgit_dependencies += expat
     +
    @@ meson.build (new)
     +endif
     +
     +networking_dependencies = [ ]
    -+winsock = compiler.find_library('ws2_32', required: false)
    -+if winsock.found()
    -+  networking_dependencies += winsock
    -+endif
    -+libresolv = compiler.find_library('resolv', required: false)
    -+if libresolv.found()
    -+  networking_dependencies += libresolv
    ++if host_machine.system() == 'windows'
    ++  winsock = compiler.find_library('ws2_32', required: false)
    ++  if winsock.found()
    ++    networking_dependencies += winsock
    ++  endif
    ++else
    ++  libresolv = compiler.find_library('resolv', required: false)
    ++  if libresolv.found()
    ++    networking_dependencies += libresolv
    ++  endif
     +endif
     +libgit_dependencies += networking_dependencies
     +
    @@ meson.build (new)
     +    'compat/win32/path-utils.c',
     +    'compat/win32/pthread.c',
     +    'compat/win32/syslog.c',
    -+    'compat/win32/trace2_win32_process_info.c',
     +    'compat/win32/dirent.c',
     +    'compat/win32mmap.c',
     +    'compat/nedmalloc/nedmalloc.c',
    @@ meson.build (new)
     +
     +  libgit_dependencies += compiler.find_library('ntdll')
     +  libgit_include_directories += 'compat/win32'
    ++  if compiler.get_id() == 'msvc'
    ++    libgit_include_directories += 'compat/vcbuild/include'
    ++  endif
     +endif
     +
     +if host_machine.system() == 'linux'
     +  libgit_sources += 'compat/linux/procinfo.c'
    ++elif host_machine.system() == 'windows'
    ++  libgit_sources += 'compat/win32/trace2_win32_process_info.c'
     +else
     +  libgit_sources += 'compat/stub/procinfo.c'
     +endif
    @@ meson.build (new)
     +build_options_config.set_quoted('FSMONITOR_DAEMON_BACKEND', fsmonitor_backend)
     +build_options_config.set_quoted('FSMONITOR_OS_SETTINGS', fsmonitor_backend)
     +
    -+if compiler.get_define('REG_STARTEND', prefix: '#include <regex.h>') != ''
    ++if compiler.has_header('regex.h') and compiler.get_define('REG_STARTEND', prefix: '#include <regex.h>') != ''
     +  build_options_config.set('NO_REGEX', '')
    ++
    ++  if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') != ''
    ++    libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
    ++    libgit_sources += 'compat/regcomp_enhanced.c'
    ++  endif
     +else
     +  libgit_c_args += [
     +    '-DNO_REGEX',
    @@ meson.build (new)
     +  libgit_sources += 'compat/regex/regex.c'
     +  libgit_include_directories += 'compat/regex'
     +endif
    -+if compiler.get_define('REG_ENHANCED', prefix: '#include <regex.h>') != ''
    -+  libgit_c_args += '-DUSE_ENHANCED_BASIC_REGULAR_EXPRESSIONS'
    -+  libgit_sources += 'compat/regcomp_enhanced.c'
    -+endif
     +
     +# setitimer and friends are provided by compat/mingw.c.
     +if host_machine.system() != 'windows'
    @@ meson.build (new)
     +  openssl_required = true
     +endif
     +
    -+openssl = dependency('openssl', required: openssl_required)
    ++openssl = dependency('openssl', required: openssl_required, default_options: ['default_library=static'])
     +if openssl.found()
     +  libgit_dependencies += openssl
     +endif
    @@ meson.build (new)
     +    '-DGIT_USER_AGENT="' + 'git/' + meson.project_version() + '"',
     +    '-DGIT_BUILT_FROM_COMMIT="' + run_command('git', 'rev-parse', '-q', '--verify', 'HEAD', check: false).stdout().strip() + '"',
     +  ],
    ++  dependencies: libgit_dependencies,
     +  include_directories: libgit_include_directories,
     +)
     +
    @@ meson.build (new)
     +  sources: libgit_sources,
     +  c_args: libgit_c_args,
     +  link_with: libgit_version_library,
    ++  dependencies: libgit_dependencies,
     +  include_directories: libgit_include_directories,
     +)
     +
    @@ meson.build (new)
     +      '-Wl,-nxcompat',
     +      '-Wl,-dynamicbase',
     +      '-Wl,-pic-executable,-e,mainCRTStartup',
    -+      '-Wl,-subsystem,console',
     +    ]
     +  elif compiler.get_argument_syntax() == 'msvc'
     +    common_main_link_args += [
    -+      '/NOLOGO',
     +      '/ENTRY:wmainCRTStartup',
    -+      '/SUBSYSTEM:CONSOLE',
     +      'invalidcontinue.obj',
     +    ]
     +  else
    @@ meson.build (new)
     +common_main_library = static_library('common-main',
     +  sources: common_main_sources,
     +  c_args: libgit_c_args,
    ++  dependencies: libgit_dependencies,
     +  include_directories: libgit_include_directories,
     +)
     +common_main = declare_dependency(
    @@ meson.build (new)
     +
     +  foreach alias : [ 'git-remote-https', 'git-remote-ftp', 'git-remote-ftps' ]
     +    test_dependencies += executable(alias,
    -+      objects: git.extract_all_objects(recursive: false),
    ++      objects: git_remote_http.extract_all_objects(recursive: false),
     +      dependencies: [libgit, common_main],
     +    )
     +
    @@ meson_options.txt (new)
     +option('sha256_backend', type: 'combo', choices: ['openssl', 'nettle', 'gcrypt', 'block'], value: 'block',
     +  description: 'The backend used for hashing objects with the SHA256 object format')
     +
    ++option('macos_use_homebrew_gettext', type: 'boolean', value: true,
    ++  description: 'Use gettext from Homebrew instead of the slightly-broken system-provided one.')
    ++
     +option('gitweb_config', type: 'string', value: 'gitweb_config.perl')
     +option('gitweb_config_system', type: 'string', value: '/etc/gitweb.conf')
     +option('gitweb_config_common', type: 'string', value: '/etc/gitweb-common.conf')
    @@ po/meson.build (new)
     +)
     +test_dependencies += translations[0]
     
    + ## subprojects/curl.wrap (new) ##
    +@@
    ++[wrap-file]
    ++directory = curl-8.10.1
    ++source_url = https://github.com/curl/curl/releases/download/curl-8_10_1/curl-8.10.1.tar.xz
    ++source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/curl_8.10.1-1/curl-8.10.1.tar.xz
    ++source_filename = curl-8.10.1.tar.xz
    ++source_hash = 73a4b0e99596a09fa5924a4fb7e4b995a85fda0d18a2c02ab9cf134bebce04ee
    ++patch_filename = curl_8.10.1-1_patch.zip
    ++patch_url = https://wrapdb.mesonbuild.com/v2/curl_8.10.1-1/get_patch
    ++patch_hash = 707c28f35fc9b0e8d68c0c2800712007612f922a31da9637ce706a2159f3ddd8
    ++wrapdb_version = 8.10.1-1
    ++
    ++[provide]
    ++dependency_names = libcurl
    +
    + ## subprojects/expat.wrap (new) ##
    +@@
    ++[wrap-file]
    ++directory = expat-2.6.3
    ++source_url = https://github.com/libexpat/libexpat/releases/download/R_2_6_3/expat-2.6.3.tar.xz
    ++source_filename = expat-2.6.3.tar.bz2
    ++source_hash = 274db254a6979bde5aad404763a704956940e465843f2a9bd9ed7af22e2c0efc
    ++patch_filename = expat_2.6.3-1_patch.zip
    ++patch_url = https://wrapdb.mesonbuild.com/v2/expat_2.6.3-1/get_patch
    ++patch_hash = cf017fbe105e31428b2768360bd9be39094df4e948a1e8d1c54b6f7c76460cb1
    ++source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/expat_2.6.3-1/expat-2.6.3.tar.bz2
    ++wrapdb_version = 2.6.3-1
    ++
    ++[provide]
    ++expat = expat_dep
    +
    + ## subprojects/openssl.wrap (new) ##
    +@@
    ++[wrap-file]
    ++directory = openssl-3.0.8
    ++source_url = https://www.openssl.org/source/openssl-3.0.8.tar.gz
    ++source_filename = openssl-3.0.8.tar.gz
    ++source_hash = 6c13d2bf38fdf31eac3ce2a347073673f5d63263398f1f69d0df4a41253e4b3e
    ++patch_filename = openssl_3.0.8-3_patch.zip
    ++patch_url = https://wrapdb.mesonbuild.com/v2/openssl_3.0.8-3/get_patch
    ++patch_hash = 300da189e106942347d61a4a4295aa2edbcf06184f8d13b4cee0bed9fb936963
    ++source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/openssl_3.0.8-3/openssl-3.0.8.tar.gz
    ++wrapdb_version = 3.0.8-3
    ++
    ++[provide]
    ++libcrypto = libcrypto_dep
    ++libssl = libssl_dep
    ++openssl = openssl_dep
    +
    + ## subprojects/pcre2.wrap (new) ##
    +@@
    ++[wrap-file]
    ++directory = pcre2-10.44
    ++source_url = https://github.com/PCRE2Project/pcre2/releases/download/pcre2-10.44/pcre2-10.44.tar.bz2
    ++source_filename = pcre2-10.44.tar.bz2
    ++source_hash = d34f02e113cf7193a1ebf2770d3ac527088d485d4e047ed10e5d217c6ef5de96
    ++patch_filename = pcre2_10.44-2_patch.zip
    ++patch_url = https://wrapdb.mesonbuild.com/v2/pcre2_10.44-2/get_patch
    ++patch_hash = 4336d422ee9043847e5e10dbbbd01940d4c9e5027f31ccdc33a7898a1ca94009
    ++source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/pcre2_10.44-2/pcre2-10.44.tar.bz2
    ++wrapdb_version = 10.44-2
    ++
    ++[provide]
    ++libpcre2-8 = libpcre2_8
    ++libpcre2-16 = libpcre2_16
    ++libpcre2-32 = libpcre2_32
    ++libpcre2-posix = libpcre2_posix
    +
    + ## subprojects/zlib.wrap (new) ##
    +@@
    ++[wrap-file]
    ++directory = zlib-1.3.1
    ++source_url = http://zlib.net/fossils/zlib-1.3.1.tar.gz
    ++source_fallback_url = https://github.com/mesonbuild/wrapdb/releases/download/zlib_1.3.1-1/zlib-1.3.1.tar.gz
    ++source_filename = zlib-1.3.1.tar.gz
    ++source_hash = 9a93b2b7dfdac77ceba5a558a580e74667dd6fede4585b91eefb60f03b72df23
    ++patch_filename = zlib_1.3.1-1_patch.zip
    ++patch_url = https://wrapdb.mesonbuild.com/v2/zlib_1.3.1-1/get_patch
    ++patch_hash = e79b98eb24a75392009cec6f99ca5cdca9881ff20bfa174e8b8926d5c7a47095
    ++wrapdb_version = 1.3.1-1
    ++
    ++[provide]
    ++zlib = zlib_dep
    +
      ## t/helper/meson.build (new) ##
     @@
     +test_tool_sources = [
    @@ t/meson.build (new)
     +]
     +
     +clar_decls_h = custom_target('clar_decls_h',
    -+    input: clar_test_suites,
    -+    output: 'clar-decls.h',
    -+    command : [shell, meson.current_source_dir() + '/unit-tests/generate-clar-decls.sh', '@OUTPUT@', '@INPUT@'],
    ++  input: clar_test_suites,
    ++  output: 'clar-decls.h',
    ++  command : [shell, meson.current_source_dir() + '/unit-tests/generate-clar-decls.sh', '@OUTPUT@', '@INPUT@'],
    ++  env: script_environment,
     +)
    ++clar_sources += clar_decls_h
     +
    -+clar_suite = custom_target('clar_suite',
    -+    input: clar_decls_h,
    -+    output: 'clar.suite',
    -+    feed: true,
    -+    capture: true,
    -+    command : [awk, '-f', meson.current_source_dir() + '/unit-tests/clar-generate.awk'],
    ++clar_sources += custom_target('clar_suite',
    ++  input: clar_decls_h,
    ++  output: 'clar.suite',
    ++  feed: true,
    ++  capture: true,
    ++  command : [awk, '-f', meson.current_source_dir() + '/unit-tests/clar-generate.awk'],
     +)
     +
    -+clar_generated_sources = [
    -+  clar_decls_h,
    -+  clar_suite,
    -+]
    -+
     +clar_unit_tests = executable('unit-tests',
    -+  sources: clar_sources + clar_generated_sources + clar_test_suites,
    ++  sources: clar_sources + clar_test_suites,
     +  dependencies: [libgit, common_main],
     +)
     +test('unit-tests', clar_unit_tests)
    @@ t/meson.build (new)
     +  git_build_dir = run_command(cygpath, git_build_dir, check: true).stdout().strip()
     +endif
     +
    ++test_environment = script_environment
    ++test_environment.set('GIT_BUILD_DIR', git_build_dir)
    ++
     +foreach integration_test : integration_tests
     +  test(fs.stem(integration_test), shell,
     +    args: [ integration_test ],
     +    workdir: meson.current_source_dir(),
    -+    env: {
    -+      'GIT_BUILD_DIR': git_build_dir,
    -+    },
    ++    env: test_environment,
     +    depends: test_dependencies + bin_wrappers,
     +    timeout: 0,
     +  )
-- 
2.47.0.rc1.33.g90fe3800b9.dirty

