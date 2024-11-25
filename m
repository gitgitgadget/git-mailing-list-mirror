Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010C5192D6C
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528636; cv=none; b=FN6cNE5DY1ejlvCma+BbKYC50Zel5uDfzHKg//NaIXgq+/3UKNilrdFR0ztYzo2wcbk1nlHreaNWc+4dPIo4cILClUNOYLAcUpcQDlb5v9HMtoPqUjUigQn/5AFO270oXj1UoPO1XfI+smku85eq0ElVRntC6PVbRe0a/sWoMPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528636; c=relaxed/simple;
	bh=EDJwrSJoKCym4dfa7hA7bBxPHANDTpiVovw4PjW39eo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=d5kOJYFhSbzf5SnVgIvcqHVhAzX+PuG8+hkgktJnuWm/iHJl28aEZwo+AvzMwljsTQ4G8to1tu4a6ldKpYdWtZ5Cd4UK9kiNcgzfkPRovq/K5RuJDJK3YNtdmC9hSRE9Ja9U3qPLJwaJNSZfQeUJROedI/ejcq6hjLpOpEjJ+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KEs8XbCL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IENVrSKa; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KEs8XbCL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IENVrSKa"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C6A9F2540130;
	Mon, 25 Nov 2024 04:57:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 25 Nov 2024 04:57:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732528631;
	 x=1732615031; bh=JAUxHkRbSsV2uKwcsZv0Tf1IhtnfXnIjIFu+uhBo8Io=; b=
	KEs8XbCLHWzOeVRV74PqhkaqboSTOzawVrmMP3/pu53SGaxx2FNCONe6k0Z0/5TK
	uo3sk8c/dMmXKhGRZns/L0baeub+2Rk9wgb2xeAGfdXwlet0bV3E8ox57t9XLtKN
	GJ9h1sovZyaZ5Mm6SGkvHqs3pjnMyKr1DhhHpqULe6BCwEY8+x8HnI6JdJzmJjAJ
	PfZgiGz9SWtvFdhDS9hijVvDT6ivrFKqdtAunl81LjiabRC9W7Bjj97bcob7CTB4
	hdFBnfz1/paqnHGAxkwhDAaFGo9m/S3RXJaPS0W5OqjjT2sOnM98t7Jvp6oUv4cZ
	t2rwsOsT+wuxKM4m0z6GTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732528631; x=
	1732615031; bh=JAUxHkRbSsV2uKwcsZv0Tf1IhtnfXnIjIFu+uhBo8Io=; b=I
	ENVrSKaF8Qvj7Jm4Wj4yvA20iCotWQX09HVz1w4FDTWCj8JC1e7kgtfj8OXb+swV
	s6u/SIAuFJWL9u4JC5AeLjtXAgVnTkPnPEcD4riXt2x6DjMxmlDUsV5kiGiJhW3B
	oZQClfSaV2+CCJnZZxbAuLDng+qE76F3cXphzpB9CkiTfiaND6y5Pi0CxI5yvt22
	c5Zg2HjjrEjQ6SYblPT/uwKU66BoPpGYBCzldJZMpTQvvhuBQlt05mIiH36Q8bBv
	0OCxFxVc1bgkoc4Wy6SVely29FuERlhh5Y4kAySbn5IBy+6OygKQ6pHT6WQ3hSqL
	fnRbadLLtzJnIqn6agCpA==
X-ME-Sender: <xms:9klEZwHxhO4U8dIFcg7qblCVZKsdliZDaLNEL1wUtzX5hqy8GgkURw>
    <xme:9klEZ5WfA1J91U5u1AlkD_c9853ZTuMpZe0dwl4BdtW-NwpMgyNriA6VI3A8t9ATl
    MyhqSpceHk8KoVPlA>
X-ME-Received: <xmr:9klEZ6Iop3cPG0Ej90aYTVGjJf0SI28FM05P5E5AtLxYzlMnMJCe6MFw8ClHhiAHRoVHexEXk2j_BoJZkzvk7dfOMttCYg7clxZ5_nwGpdUv0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeehgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhufffkfggtgfgjghfvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveegffefgeetfedtveehudefudfgheefiefhfeetkeel
    hfefffekkeekffekfffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptghonhhfrd
    hinhdprhgsrdhinhdprhgtrdhinhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeduuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohho
    rdhorhhgpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoheprhgrmh
    hsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegthhhr
    ihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepshhunhhshhhinh
    gvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtphhtthho
    pehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:9klEZyFF6VbS_XBl85-V84tqJb9mSeHHoVuFzscFUaNgJO55oUVUaQ>
    <xmx:9klEZ2XZHSrKRKWLHLAjhzi32Xjmpphk14Xn1dm7DQWnM5lqSpV-dw>
    <xmx:9klEZ1PqCECEGorDwwGXhtiKZqrg3ujulyrhNWICvq09Ze-bszNDXg>
    <xmx:9klEZ93oc7eqdkoH61b-JBbozssi3XlzVZTE8vVnxjZi9ZhGIWFPIg>
    <xmx:90lEZ9M3SuBap7uMCmS0BUFpN45NSYm4ifqYEb5RnwaeYYqy_1E_1UOK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 04:57:08 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 005626cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 09:56:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v9 00/23] Modernize the build system
Date: Mon, 25 Nov 2024 10:56:48 +0100
Message-Id: <20241125-pks-meson-v9-0-1c6cf242a5f1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOFJRGcC/22Ry26DMBBFfyXyukYzfs04q/5HlUWhJrGqALUpS
 hXx73VoVUHF8o7OuYu5d5FDiiGL4+EuUphijn1Xgn86iOby2p2DjG8lCwXKIKKSw3uW15D7Tnp
 bO2cb4BacKPyQQhtvS9fLqeRLzGOfvpbqCR9X0fRTSBWSImZEZ6pzHKshP5fSKl7Fw5rUlmTDF
 rXfI/WW9MoaINgjzT+SCB3YPdJuSI1aW695j3QLufOXyUmQznCtwXvHijYarTW71qhohkKDvia
 GWm00Xmt+rXHRGHzdUgtGtfpPm382SeHjs8w6/g4zz9/L4W3a9AEAAA==
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

Changes in v9:

  - The series is now built on top of 6ea2d9d271 (Sync with Git 2.47.1,
    2024-11-25) with ps/clar-build-improvement at 5dac35bbde (Makefile:
    let clar header targets depend on their scripts, 2024-11-15) merged
    into it. This is done to address semantic merge conflicts with that
    series, which has been merged to 'next' by now.

  - Drop unnecessary changes to gitk.

  - A couple of small tweaks to the refactored GIT-VERSION-GEN script.

  - Extend GIT-VERSION-GEN with additional placeholders in the commits
    where they are first used instead of introducing them ahead of time.
    This makes it easier to see that the refactoring is faithful to the
    original.

  - Use "echo >&2 $MSG" instead of "echo $MSG >&2".

  - Fix another dependency when building technical docs via AsciiDoctor.

  - Remove generated version files via `make clean`.

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
  - Link to v8: https://lore.kernel.org/r/20241119-pks-meson-v8-0-809bf7f042f3@pks.im

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
 t/meson.build                                      | 1117 ++++++++++++
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
 97 files changed, 4939 insertions(+), 499 deletions(-)

Range-diff versus v8:

 1:  b4845f3a9e =  1:  ec060ce948 Makefile: use common template for GIT-BUILD-OPTIONS
 2:  1289899424 !  2:  86dc8b411e Makefile: consistently use @PLACEHOLDER@ to substitute
    @@ git-svn.perl
      use Carp qw/croak/;
      use File::Basename qw/dirname basename/;
     
    - ## gitk-git/po/vi.po ##
    -@@
    - #
    - msgid ""
    - msgstr ""
    --"Project-Id-Version: gitk @@GIT_VERSION@@\n"
    -+"Project-Id-Version: gitk @GIT_VERSION@\n"
    - "Report-Msgid-Bugs-To: \n"
    - "POT-Creation-Date: 2015-05-17 14:32+1000\n"
    - "PO-Revision-Date: 2015-09-15 07:33+0700\n"
    -
      ## gitweb/Makefile ##
     @@ gitweb/Makefile: GITWEB_JSLIB_FILES += static/js/blame_incremental.js
      
 3:  91f8b36d50 !  3:  779ff8e71f Makefile: refactor GIT-VERSION-GEN to be reusable
    @@ Commit message
         While at it, change the format of the version file by removing the
         spaces around the equals sign. Like this we can continue to include the
         file in our Makefiles, but can also start to source it in shell scripts
    -    in subsequent steps. Furthermore, we already start to replace some
    -    placeholders that are not yet of relevance in this commit. These are
    -    going to become relevant in subsequent steps, as well.
    +    in subsequent steps.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    @@ GIT-VERSION-GEN
      
     +if test "$#" -ne 3
     +then
    -+    echo "USAGE: $0 <SOURCE_DIR> <INPUT> <OUTPUT>" >&2
    ++    echo >&2 "USAGE: $0 <SOURCE_DIR> <INPUT> <OUTPUT>"
     +    exit 1
     +fi
     +
    @@ GIT-VERSION-GEN
     +
     +if ! test -f "$INPUT"
     +then
    -+	echo "Input is not a file: $INPUT" >&2
    ++	echo >&2 "Input is not a file: $INPUT"
     +	exit 1
     +fi
     +
    ++# Protect us from reading Git version information outside of the Git directory
    ++# in case it is not a repository itself, but embedded in an unrelated
    ++# repository.
     +GIT_CEILING_DIRECTORIES="$SOURCE_DIR/.."
     +export GIT_CEILING_DIRECTORIES
     +
    @@ GIT-VERSION-GEN
     -elif { test -d "${GIT_DIR:-.git}" || test -f .git; } &&
     -	VN=$(git describe --match "v[0-9]*" HEAD 2>/dev/null) &&
     +	VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
    -+elif { test -d "$SOURCE_DIR/.git" || test -d "${GIT_DIR:-.git}" || test -f "$SOURCE_DIR"/.git; } &&
    ++elif {
    ++		test -d "$SOURCE_DIR/.git" ||
    ++		test -d "${GIT_DIR:-.git}" ||
    ++		test -f "$SOURCE_DIR"/.git;
    ++	} &&
     +	VN=$(git -C "$SOURCE_DIR" describe --match "v[0-9]*" HEAD 2>/dev/null) &&
      	case "$VN" in
      	*$LF*) (exit 1) ;;
    @@ GIT-VERSION-GEN: else
      fi
      
     -VN=$(expr "$VN" : v*'\(.*\)')
    -+GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
    -+GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as')
     +GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
    -+if test -z "$GIT_USER_AGENT"
    -+then
    -+	GIT_USER_AGENT=git/$GIT_VERSION
    -+fi
     +
    -+read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trailing <<EOF
    -+$(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
    ++read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION trailing <<EOF
    ++$(echo "$GIT_VERSION" 0 0 0 | tr '.a-zA-Z-' ' ')
     +EOF
     +
     +sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
    -+	-e "s|@GIT_DATE@|$GIT_DATE|" \
     +	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
     +	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
     +	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
    -+	-e "s|@GIT_PATCH_LEVEL@|$GIT_PATCH_LEVEL|" \
    -+	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
    -+	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
     +	"$INPUT" >"$OUTPUT"+
      
     -if test -r $GVF
 4:  d4cf7696df !  4:  c6553540c3 Makefile: propagate Git version via generated header
    @@ .gitignore
      *.dsc
      *.deb
     
    + ## GIT-VERSION-GEN ##
    +@@ GIT-VERSION-GEN: else
    + fi
    + 
    + GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
    ++GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
    ++if test -z "$GIT_USER_AGENT"
    ++then
    ++	GIT_USER_AGENT="git/$GIT_VERSION"
    ++fi
    + 
    + read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION trailing <<EOF
    + $(echo "$GIT_VERSION" 0 0 0 | tr '.a-zA-Z-' ' ')
    +@@ GIT-VERSION-GEN: sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
    + 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
    + 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
    + 	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
    ++	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
    ++	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
    + 	"$INPUT" >"$OUTPUT"+
    + 
    + if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null
    +
      ## Makefile ##
     @@ Makefile: PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
      pager.sp pager.s pager.o: EXTRA_CPPFLAGS = \
    @@ Makefile: PAGER_ENV_CQ_SQ = $(subst ','\'',$(PAGER_ENV_CQ))
      
      $(BUILT_INS): git$X
      	$(QUIET_BUILT_IN)$(RM) $@ && \
    +@@ Makefile: clean: profile-clean coverage-clean cocciclean
    + 	$(RM) $(FUZZ_PROGRAMS)
    + 	$(RM) $(SP_OBJ)
    + 	$(RM) $(HCC)
    ++	$(RM) version-def.h
    + 	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
    + 	$(RM) -r po/build/
    + 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
     
      ## contrib/buildsystems/CMakeLists.txt ##
     @@ contrib/buildsystems/CMakeLists.txt: add_compile_definitions(PAGER_ENV="LESS=FRX LV=-c"
 5:  4864744286 !  5:  1683e96248 Makefile: generate "git.rc" via GIT-VERSION-GEN
    @@ .gitignore
      *.exe
      *.[aos]
     
    + ## GIT-VERSION-GEN ##
    +@@ GIT-VERSION-GEN: then
    + 	GIT_USER_AGENT="git/$GIT_VERSION"
    + fi
    + 
    +-read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION trailing <<EOF
    +-$(echo "$GIT_VERSION" 0 0 0 | tr '.a-zA-Z-' ' ')
    ++# While released Git versions only have three numbers, development builds also
    ++# have a fourth number that corresponds to the number of patches since the last
    ++# release.
    ++read GIT_MAJOR_VERSION GIT_MINOR_VERSION GIT_MICRO_VERSION GIT_PATCH_LEVEL trailing <<EOF
    ++$(echo "$GIT_VERSION" 0 0 0 0 | tr '.a-zA-Z-' ' ')
    + EOF
    + 
    + sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
    + 	-e "s|@GIT_MAJOR_VERSION@|$GIT_MAJOR_VERSION|" \
    + 	-e "s|@GIT_MINOR_VERSION@|$GIT_MINOR_VERSION|" \
    + 	-e "s|@GIT_MICRO_VERSION@|$GIT_MICRO_VERSION|" \
    ++	-e "s|@GIT_PATCH_LEVEL@|$GIT_PATCH_LEVEL|" \
    + 	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
    + 	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
    + 	"$INPUT" >"$OUTPUT"+
    +
      ## Makefile ##
     @@ Makefile: $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
      	$(QUIET_GEN)$(cmd_munge_script) && \
    @@ Makefile: $(SCRIPT_LIB) : % : %.sh GIT-SCRIPT-DEFINES
      
      # This makes sure we depend on the NO_PERL setting itself.
      $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
    +@@ Makefile: clean: profile-clean coverage-clean cocciclean
    + 	$(RM) -r .build $(UNIT_TEST_BIN)
    + 	$(RM) GIT-TEST-SUITES
    + 	$(RM) po/git.pot po/git-core.pot
    +-	$(RM) git.res
    ++	$(RM) git.rc git.res
    + 	$(RM) $(OBJECTS)
    + 	$(RM) headless-git.o
    + 	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB)
     
      ## contrib/buildsystems/CMakeLists.txt ##
     @@ contrib/buildsystems/CMakeLists.txt: list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
 6:  48feeec815 !  6:  517a961056 Makefile: generate doc versions via GIT-VERSION-GEN
    @@ Documentation/Makefile: ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFL
      endif
      
      ASCIIDOC_DEPS += docinfo.html
    +@@ Documentation/Makefile: clean:
    + 	$(RM) SubmittingPatches.txt
    + 	$(RM) $(cmds_txt) $(mergetools_txt) *.made
    + 	$(RM) GIT-ASCIIDOCFLAGS
    ++	$(RM) asciidoc.conf asciidoctor-extensions.rb
    + 
    + docinfo.html: docinfo-html.in
    + 	$(QUIET_GEN)$(RM) $@ && cat $< >$@
     @@ Documentation/Makefile: manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
      %.xml : %.txt $(ASCIIDOC_DEPS)
      	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
    @@ Documentation/Makefile: manpage-cmd = $(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $
      	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d book -o $@ $<
      
      technical/api-index.txt: technical/api-index-skel.txt \
    +@@ Documentation/Makefile: technical/api-index.txt: technical/api-index-skel.txt \
    + 
    + technical/%.html: ASCIIDOC_EXTRA += -a git-relative-html-prefix=../
    + $(patsubst %,%.html,$(API_DOCS) technical/api-index $(TECH_DOCS)): %.html : %.txt \
    +-	asciidoc.conf GIT-ASCIIDOCFLAGS
    ++	$(ASCIIDOC_DEPS)
    + 	$(QUIET_ASCIIDOC)$(TXT_TO_HTML) $*.txt
    + 
    + SubmittingPatches.txt: SubmittingPatches
     
      ## Documentation/asciidoc.conf => Documentation/asciidoc.conf.in ##
     @@ Documentation/asciidoc.conf.in: tilde=&#126;
    @@ Documentation/asciidoctor-extensions.rb.in: module Git
                output = output.sub(/<\/refmeta>/, new_tags + "</refmeta>")
              end
              output
    +
    + ## GIT-VERSION-GEN ##
    +@@ GIT-VERSION-GEN: fi
    + 
    + GIT_VERSION=$(expr "$VN" : v*'\(.*\)')
    + GIT_BUILT_FROM_COMMIT=$(git -C "$SOURCE_DIR" rev-parse -q --verify HEAD 2>/dev/null)
    ++GIT_DATE=$(git -C "$SOURCE_DIR" show --quiet --format='%as' 2>/dev/null)
    + if test -z "$GIT_USER_AGENT"
    + then
    + 	GIT_USER_AGENT="git/$GIT_VERSION"
    +@@ GIT-VERSION-GEN: sed -e "s|@GIT_VERSION@|$GIT_VERSION|" \
    + 	-e "s|@GIT_PATCH_LEVEL@|$GIT_PATCH_LEVEL|" \
    + 	-e "s|@GIT_BUILT_FROM_COMMIT@|$GIT_BUILT_FROM_COMMIT|" \
    + 	-e "s|@GIT_USER_AGENT@|$GIT_USER_AGENT|" \
    ++	-e "s|@GIT_DATE@|$GIT_DATE|" \
    + 	"$INPUT" >"$OUTPUT"+
    + 
    + if ! test -f "$OUTPUT" || ! cmp "$OUTPUT"+ "$OUTPUT" >/dev/null
 7:  bc92451eb5 =  7:  d5f0d9b3ca Makefile: consistently use PERL_PATH
 8:  bdb6dd42d3 !  8:  38ca197462 Makefile: extract script to massage Perl scripts
    @@ generate-perl.sh (new)
     +
     +if test $# -ne 5
     +then
    -+	echo "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION_FILE> <PERL_HEADER> <INPUT> <OUTPUT>" >&2
    ++	echo >&2 "USAGE: $0 <GIT_BUILD_OPTIONS> <GIT_VERSION_FILE> <PERL_HEADER> <INPUT> <OUTPUT>"
     +	exit 1
     +fi
     +
 9:  d8eef36b36 =  9:  d7c9edc4ab Makefile: use "generate-perl.sh" to massage Perl library
10:  b9280e87d8 ! 10:  45352a2964 Makefile: extract script to massage Shell scripts
    @@ generate-script.sh (new)
     +
     +if test $# -ne 3
     +then
    -+	echo "USAGE: $0 <INPUT> <OUTPUT> <GIT-BUILD-OPTIONS>" >&2
    ++	echo >&2 "USAGE: $0 <INPUT> <OUTPUT> <GIT-BUILD-OPTIONS>"
     +	exit 1
     +fi
     +
11:  bf399eb934 ! 11:  d3a886a2e8 Makefile: extract script to generate gitweb.cgi
    @@ gitweb/generate-gitweb-cgi.sh (new)
     +
     +if test $# -ne 4
     +then
    -+	echo "USAGE: $0 <GITWEB-BUILD-OPTIONS> <GIT-VERSION-FILE> <INPUT> <OUTPUT>" >&2
    ++	echo >&2 "USAGE: $0 <GITWEB-BUILD-OPTIONS> <GIT-VERSION-FILE> <INPUT> <OUTPUT>"
     +	exit 1
     +fi
     +
12:  38d4103b1f ! 12:  bb33f5c943 Makefile: extract script to generate gitweb.js
    @@ gitweb/generate-gitweb-js.sh (new)
     +
     +if test "$#" -lt 2
     +then
    -+	echo "USAGE: $0 <OUTPUT> <INPUT>..." >&2
    ++	echo >&2 "USAGE: $0 <OUTPUT> <INPUT>..."
     +	exit 1
     +fi
     +
13:  7ff4832b1f ! 13:  22c54e4e4b Makefile: refactor generators to be PWD-independent
    @@ generate-configlist.sh
     +
     +if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
     +then
    -+	echo "USAGE: $0 <SOURCE_DIR> <OUTPUT>" >&2
    ++	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
     +	exit 1
     +fi
      
    @@ generate-hooklist.sh
     +
     +if test -z "$SOURCE_DIR" || ! test -d "$SOURCE_DIR" || test -z "$OUTPUT"
     +then
    -+	echo "USAGE: $0 <SOURCE_DIR> <OUTPUT>" >&2
    ++	echo >&2 "USAGE: $0 <SOURCE_DIR> <OUTPUT>"
     +	exit 1
     +fi
     +
14:  89d260e6d9 ! 14:  8ace5376ec Makefile: allow "bin-wrappers/" directory to exist
    @@ Makefile: test_bindir_programs := $(patsubst %,bin-wrappers/%,$(BINDIR_PROGRAMS_
      	     -e 's|@BUILD_DIR@|$(shell pwd)|' \
      	     -e 's|@PROG@|$(patsubst test-%,t/helper/test-%,$(@F))$(if $(filter-out $(BINDIR_PROGRAMS_NO_X),$(@F)),$(X),)|' < $< > $@ && \
     @@ Makefile: clean: profile-clean coverage-clean cocciclean
    - 	$(RM) $(FUZZ_PROGRAMS)
      	$(RM) $(SP_OBJ)
      	$(RM) $(HCC)
    + 	$(RM) version-def.h
     -	$(RM) -r bin-wrappers $(dep_dirs) $(compdb_dir) compile_commands.json
     +	$(RM) -r $(dep_dirs) $(compdb_dir) compile_commands.json
     +	$(RM) $(test_bindir_programs)
15:  0f53ade4b8 = 15:  68f4dcfbda Makefile: simplify building of templates
16:  6b8d5bc612 = 16:  2ae9c4d2f4 Documentation: allow sourcing generated includes from separate dir
17:  66e7a00010 = 17:  f70ce79687 Documentation: teach "cmd-list.perl" about out-of-tree builds
18:  00a894ea08 ! 18:  31d4d55c7e Documentation: extract script to generate a list of mergetools
    @@ Documentation/generate-mergetool-list.sh (new)
     +
     +if test "$#" -ne 3
     +then
    -+	echo "USAGE: $0 <SOURCE_DIR> <MODE> <OUTPUT>" >&2
    ++	echo >&2 "USAGE: $0 <SOURCE_DIR> <MODE> <OUTPUT>"
     +	exit 1
     +fi
     +
19:  41c0f2d3f6 = 19:  482e166556 t: better support for out-of-tree builds
20:  a548eaa6be = 20:  c13463c792 t: allow overriding build dir
21:  c270bf16b8 = 21:  e32a07da87 Documentation: add comparison of build systems
22:  f006635102 ! 22:  bd09f835a5 Introduce support for the Meson build system
    @@ meson.build (new)
     +  program_path += [ 'C:/Program Files/Git/bin', 'C:/Program Files/Git/usr/bin' ]
     +endif
     +
    -+awk = find_program('awk', dirs: program_path)
     +cygpath = find_program('cygpath', dirs: program_path, required: false)
     +diff = find_program('diff', dirs: program_path)
     +shell = find_program('sh', dirs: program_path)
    @@ t/meson.build (new)
     +clar_decls_h = custom_target(
     +  input: clar_test_suites,
     +  output: 'clar-decls.h',
    -+  command : [shell, meson.current_source_dir() + '/unit-tests/generate-clar-decls.sh', '@OUTPUT@', '@INPUT@'],
    ++  command : [
    ++    shell,
    ++    meson.current_source_dir() + '/unit-tests/generate-clar-decls.sh',
    ++    '@OUTPUT@',
    ++    '@INPUT@',
    ++  ],
     +  env: script_environment,
     +)
     +clar_sources += clar_decls_h
    @@ t/meson.build (new)
     +clar_sources += custom_target(
     +  input: clar_decls_h,
     +  output: 'clar.suite',
    -+  feed: true,
    -+  capture: true,
    -+  command : [awk, '-f', meson.current_source_dir() + '/unit-tests/clar-generate.awk'],
    ++  command : [
    ++    shell,
    ++    meson.current_source_dir() + '/unit-tests/generate-clar-suites.sh',
    ++    '@INPUT@',
    ++    '@OUTPUT@',
    ++  ],
    ++  env: script_environment,
     +)
     +
     +clar_unit_tests = executable('unit-tests',
23:  00a3db6810 ! 23:  ff646a148a meson: fix conflicts with in-flight topics
    @@ Commit message
     
           - cc/promisor-remote-capability adds t5710.
     
    -      - ds/path-walk adds t6601 as well as "path-walk.c" and
    +      - ds/path-walk-1 adds t6601 as well as "path-walk.c" and
             "test-path-walk.c".
     
           - ps/reftable-detach adds "reftable/system.c".
     
           - js/libgit-rust adds "common-exit.c" and "common-init.c".
     
    -      - ps/clar-build-improvement adapts the awk(1) script that generates
    -        "clar.suites" to instead be a shell script.
    -
           - ds/full-name-hash adds "t/helper/test-name-hash.c".
     
           - cw/worktree-extension deletes t2408.
    @@ t/helper/meson.build: test_tool_sources = [
        'test-proc-receive.c',
     
      ## t/meson.build ##
    -@@ t/meson.build: clar_sources += clar_decls_h
    - clar_sources += custom_target(
    -   input: clar_decls_h,
    -   output: 'clar.suite',
    --  feed: true,
    --  capture: true,
    --  command : [awk, '-f', meson.current_source_dir() + '/unit-tests/clar-generate.awk'],
    -+  command : [shell, meson.current_source_dir() + '/unit-tests/generate-clar-suites.sh', '@INPUT@', '@OUTPUT@'],
    -+  env: script_environment,
    - )
    - 
    - clar_unit_tests = executable('unit-tests',
     @@ t/meson.build: integration_tests = [
        't1014-read-tree-confusing.sh',
        't1015-read-index-unmerged.sh',

---
base-commit: dbfa873276ccefac0b426e46f31101ecdbcf4f40
change-id: 20241112-pks-meson-95b665c08f06

