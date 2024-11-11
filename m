Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4894683
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731339054; cv=none; b=NYXtVd2a94LmVQGjZC2I+rGK7ksLU2C6FkeB6qLF37lRXtj2lAbDM8hz1NMOF2PaRQvymjtwVgSgyyu4+7fNPuyC2aI/Z9VvaY4Tlb3oEtspnPvKY3yzUwbYz8yKu0Cbm674NBLfSO/6y09gigijZ77AxKfqNrGfe1qZu+2zydw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731339054; c=relaxed/simple;
	bh=rjD916m2XRteskDrAWg7dme+anp/9ICKS/HRtSJqVao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EW6yNfh5qMOL3nVz8bUl+yplfWsnW4aEERgLrjWFO9AFxj0E9tPlCneXDJlrkNylhBs7SIMBkyS0wG/8yv0szlhp6U4B55EuqgfoeTWk+qHEOjNzqafNKgLMw4hjO7pEWoeRp+e+9gQKuBRBc8eVwRS7SGToSU/PXWh7JIUz3XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jsTR4609; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b3qyv7YI; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jsTR4609";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b3qyv7YI"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id E25A513806D8;
	Mon, 11 Nov 2024 10:30:48 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 11 Nov 2024 10:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1731339048; x=1731425448; bh=PgtJFNjd2x
	CM7NINCoX/lrQ2gO5WDGT+ZWnu+XxGXVY=; b=jsTR4609eUOFgFARJ1lrDcLfJP
	v8zSyNVJMB3h0w3kV0IWDVY/EKq6w7UmqK0TEpvDdB4VnMQbYCPw06oCY4plM04d
	KSvSw/wENYy1O1mLfsVCnH5pdx3Vf4zNgppiPm0/OnsBHUKd39WzBYem7Oe9zqAR
	LCYWGsPkm98TKypeZKFPgJQu0hnFsE3VKFDSBegzFtO2hU0o5uig32iHZJ6YwTwz
	6ffSBWYER9Ithcs67jRx0VqbTkjeud39z3ZLJPTqMHF+m/XanHcv2gkOmPxwkh2v
	vXhuD/xoW/j4bbwijO/kVDJ8uvIbPqGemkKVyqvYY9R+T1Hfb1mXQoOo7+7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731339048; x=1731425448; bh=PgtJFNjd2xCM7NINCoX/lrQ2gO5WDGT+ZWn
	u+XxGXVY=; b=b3qyv7YIqIxLbH1ci9yvIpMBXao7pT0/wLtCEdN4ZsyYQy0va3n
	gRWgO4dGWbCfcG4RzB/31ZFEF9gxl6LETE0cP4JoIj45ulv1X/MJ+tjUqoBSQhym
	h4j9EGt+SMqCUPAQrPKyn+8Nv1sjZZK9r9IGIGsOweO4VHnofSMxHPxWx3zFkqLq
	BMurcJsdXD97W67JxTyQbkbFNFETC6l4P/dxfmzTmneIl2BxXQ8B7OgfSH7n8YwM
	5Hr/pBqPFbIxoW3Rb7MJwldpWTRqWC17G5ya8gBrfpowLjaYCcTfTXVRamR8dttD
	Ts6GYQgAu+4qsAy/g1vBx67UaYOr/f1yWnA==
X-ME-Sender: <xms:KCMyZxWhBF4S95M1ppb8UrrZymHLQdE3FqPa2VVYmAEp_SQb3TcL5w>
    <xme:KCMyZxmQAy6OA70pUw9qaTAYFJ1dlSeaYnZvRWBDv6VsTTVeZBBodvXTSEWEZM5It
    sdXNcZ4ZyV7wTkKtw>
X-ME-Received: <xmr:KCMyZ9YoZ0d3Vx9vLQypWlD0oaItKftWSltyXXM71ZAnUCOTAMly7YNSLBRbRxWUQobICHmVh-7m3GgSLe2Chb6fpQYvzabUcMYGpgb4SBjCWiB8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghp
    thhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhope
    hmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegurghvvhhiugesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheprhgrmhhsrgih
    sehrrghmshgrhihjohhnvghsrdhplhhushdrtghomh
X-ME-Proxy: <xmx:KCMyZ0UTyJPmXzHi-68K3JpII9kAO7byCCUjNGobAtWg06dvr-otug>
    <xmx:KCMyZ7n2X4MUCaTLm5ZJpZineJNRJpGA2Y2YMnq1oV3iwVxFqWlLwg>
    <xmx:KCMyZxff-Ig-LgZj2Y6B6M0DfkYuWbyOUBuKuNjkNKb2NMkLCHXCdg>
    <xmx:KCMyZ1E4N_hTefo5durtvbr0FPKKK3Xyl2ydiTfZudHFua3geMR8Ng>
    <xmx:KCMyZ97yKej9iPci6Prq3IBksBJN42zidyDGSJCePc4xxkx5E-KAoHlr>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:30:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1e7002ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 15:30:09 +0000 (UTC)
Date: Mon, 11 Nov 2024 16:30:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eli Schwartz <eschwartz@gentoo.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Taylor Blau <me@ttaylorr.com>, David Aguilar <davvid@gmail.com>
Subject: [RFC PATCH v5 00/19] Modernize the build system
Message-ID: <cover.1731335938.git.ps@pks.im>
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

Changes compared to v4:

  - Improve our CMake build instructions tot use `SH_EXE` to execute
    scripts.

  - Create Perl build directories in our CMake build instructions.

  - Remove superfluous use of basename(1).

  - Remove timeout for unit tests in Meson.

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
 contrib/buildsystems/CMakeLists.txt           |  230 ++-
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
 t/meson.build                                 | 1111 +++++++++++
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
 88 files changed, 4441 insertions(+), 447 deletions(-)
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

Range-diff against v4:
 1:  8c481cb9e01 =  1:  8c481cb9e01 Makefile: use common template for GIT-BUILD-OPTIONS
 2:  308dcbe0bd4 =  2:  308dcbe0bd4 Makefile: consistently use @PLACEHOLDER@ to substitute
 3:  20e77ffc5f5 =  3:  20e77ffc5f5 Makefile: consistently use PERL_PATH
 4:  50b607a412a !  4:  44297298476 Makefile: extract script to massage Perl scripts
    @@ contrib/buildsystems/CMakeLists.txt: foreach(script ${git_shell_scripts})
     -	file(WRITE ${CMAKE_BINARY_DIR}/${script} ${content})
     +	string(REPLACE ".perl" "" perl_gen_path "${script}")
     +
    -+	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${perl_gen_path}
    -+		COMMAND ${CMAKE_SOURCE_DIR}/generate-perl.sh
    -+			${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS
    -+			${PROJECT_VERSION}
    -+			${CMAKE_BINARY_DIR}/PERL-HEADER
    -+			${CMAKE_SOURCE_DIR}/${script}
    -+			${CMAKE_BINARY_DIR}/${perl_gen_path}
    -+		DEPENDS ${CMAKE_SOURCE_DIR}/generate-perl.sh
    -+			${CMAKE_SOURCE_DIR}/${script})
    ++	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
    ++		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
    ++			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
    ++			"${PROJECT_VERSION}"
    ++			"${CMAKE_BINARY_DIR}/PERL-HEADER"
    ++			"${CMAKE_SOURCE_DIR}/${script}"
    ++			"${CMAKE_BINARY_DIR}/${perl_gen_path}"
    ++		DEPENDS "${CMAKE_SOURCE_DIR}/generate-perl.sh"
    ++			"${CMAKE_SOURCE_DIR}/${script}"
    ++		VERBATIM)
     +	list(APPEND perl_gen ${CMAKE_BINARY_DIR}/${perl_gen_path})
      endforeach()
     +add_custom_target(perl-gen ALL DEPENDS ${perl_gen})
 5:  eddafe1cf89 !  5:  87dc74adfd4 Makefile: use "generate-perl.sh" to massage Perl library
    @@ contrib/buildsystems/CMakeLists.txt: string(REPLACE "@PATHSEP@" ":" perl_header
     +foreach(script ${git_perl_scripts} ${perl_modules})
      	string(REPLACE ".perl" "" perl_gen_path "${script}")
      
    - 	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${perl_gen_path}
    ++	get_filename_component(perl_gen_dir "${perl_gen_path}" DIRECTORY)
    ++	file(MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/${perl_gen_dir}")
    ++
    + 	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${perl_gen_path}"
    + 		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-perl.sh"
    + 			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
     @@ contrib/buildsystems/CMakeLists.txt: file(STRINGS ${CMAKE_SOURCE_DIR}/git-p4.py content NEWLINE_CONSUME)
      string(REPLACE "#!/usr/bin/env python" "#!/usr/bin/python" content "${content}")
      file(WRITE ${CMAKE_BINARY_DIR}/git-p4 ${content})
    @@ generate-perl.sh: OUTPUT="$5"
          "$INPUT" >"$OUTPUT"
     -chmod a+x "$OUTPUT"
     +
    -+case "$(basename "$INPUT")" in
    ++case "$INPUT" in
     +*.perl)
     +	chmod a+x "$OUTPUT";;
     +*)
 6:  2cf8cf86218 !  6:  180655bbab8 Makefile: extract script to massage Shell scripts
    @@ contrib/buildsystems/CMakeLists.txt: set(git_shell_scripts
     +		set(shell_gen_path "${script}")
     +	endif()
     +
    -+	add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/${shell_gen_path}
    -+		COMMAND ${CMAKE_SOURCE_DIR}/generate-script.sh
    -+			${CMAKE_SOURCE_DIR}/${script}.sh
    -+			${CMAKE_BINARY_DIR}/${shell_gen_path}
    -+			${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS
    -+		DEPENDS ${CMAKE_SOURCE_DIR}/generate-script.sh
    -+			${CMAKE_SOURCE_DIR}/${script}.sh)
    ++	add_custom_command(OUTPUT "${CMAKE_BINARY_DIR}/${shell_gen_path}"
    ++		COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-script.sh"
    ++			"${CMAKE_SOURCE_DIR}/${script}.sh"
    ++			"${CMAKE_BINARY_DIR}/${shell_gen_path}"
    ++			"${CMAKE_BINARY_DIR}/GIT-BUILD-OPTIONS"
    ++		DEPENDS "${CMAKE_SOURCE_DIR}/generate-script.sh"
    ++			"${CMAKE_SOURCE_DIR}/${script}.sh"
    ++		VERBATIM)
     +	list(APPEND shell_gen ${CMAKE_BINARY_DIR}/${shell_gen_path})
      endforeach()
     +add_custom_target(shell-gen ALL DEPENDS ${shell_gen})
    @@ contrib/buildsystems/CMakeLists.txt: string(REPLACE "@GIT_INTEROP_MAKE_OPTS@" ""
      string(REPLACE "@RUNTIME_PREFIX@" "${RUNTIME_PREFIX}" git_build_options "${git_build_options}")
     +string(REPLACE "@GITWEBDIR@" "${GITWEBDIR}" git_build_options "${git_build_options}")
     +string(REPLACE "@USE_GETTEXT_SCHEME@" "" git_build_options "${git_build_options}")
    -+string(REPLACE "@LOCALEDIR@" "LOCALEDIR" git_build_options "${git_build_options}")
    ++string(REPLACE "@LOCALEDIR@" "${LOCALEDIR}" git_build_options "${git_build_options}")
     +string(REPLACE "@BROKEN_PATH_FIX@" "" git_build_options "${git_build_options}")
      if(USE_VCPKG)
      	string(APPEND git_build_options "PATH=\"$PATH:$TEST_DIRECTORY/../compat/vcbuild/vcpkg/installed/x64-windows/bin\"\n")
 7:  e8abda661cf =  7:  07d5a9c2957 Makefile: extract script to generate gitweb.cgi
 8:  0e682b68e25 !  8:  065d03468f0 Makefile: refactor GIT-VERSION-GEN to be reusable
    @@ contrib/buildsystems/CMakeLists.txt: if(NOT SH_EXE)
     -	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
     -		WORKING_DIRECTORY ${CMAKE_SOURCE_DIR})
     -endif()
    -+execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN
    -+	WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    ++execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/GIT-VERSION-GEN"
    ++	WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
     +	OUTPUT_VARIABLE git_version
     +	OUTPUT_STRIP_TRAILING_WHITESPACE)
      
 9:  46b7760fbcd !  9:  817d58cbaf9 Makefile: refactor generators to be PWD-independent
    @@ contrib/buildsystems/CMakeLists.txt: set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS
     -	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-cmdlist.sh ${EXCLUSION_PROGS} command-list.txt
     -			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
     -			OUTPUT_FILE ${CMAKE_BINARY_DIR}/command-list.h)
    -+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-cmdlist.sh ${EXCLUSION_PROGS} ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/command-list.h)
    ++	execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-cmdlist.sh"
    ++				${EXCLUSION_PROGS}
    ++				"${CMAKE_SOURCE_DIR}"
    ++				"${CMAKE_BINARY_DIR}/command-list.h")
      endif()
      
      if(NOT EXISTS ${CMAKE_BINARY_DIR}/config-list.h)
    @@ contrib/buildsystems/CMakeLists.txt: set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS
     -	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh
     -			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
     -			OUTPUT_FILE ${CMAKE_BINARY_DIR}/config-list.h)
    -+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-configlist.sh ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/config-list.h)
    ++	execute_process(COMMAND "${SH_EXE}" "${CMAKE_SOURCE_DIR}/generate-configlist.sh"
    ++				"${CMAKE_SOURCE_DIR}"
    ++				"${CMAKE_BINARY_DIR}/config-list.h")
      endif()
      
      if(NOT EXISTS ${CMAKE_BINARY_DIR}/hook-list.h)
    @@ contrib/buildsystems/CMakeLists.txt: set(EXCLUSION_PROGS_CACHE ${EXCLUSION_PROGS
     -	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-hooklist.sh
     -			WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
     -			OUTPUT_FILE ${CMAKE_BINARY_DIR}/hook-list.h)
    -+	execute_process(COMMAND ${SH_EXE} ${CMAKE_SOURCE_DIR}/generate-hooklist.sh ${CMAKE_SOURCE_DIR} ${CMAKE_BINARY_DIR}/hook-list.h)
    ++	execute_process(COMMAND "${SH_EXE}" ${CMAKE_SOURCE_DIR}/generate-hooklist.sh
    ++				"${CMAKE_SOURCE_DIR}"
    ++				"${CMAKE_BINARY_DIR}/hook-list.h")
      endif()
      
      include_directories(${CMAKE_BINARY_DIR})
10:  ec4a9e65ec3 = 10:  33c9c322853 Makefile: allow "bin-wrappers/" directory to exist
11:  b330fd783d4 = 11:  a193157a2d8 Makefile: simplify building of templates
12:  fb7231ae4c7 = 12:  46667dc608c Documentation: allow sourcing generated includes from separate dir
13:  cf1743667e9 = 13:  7079149d6a1 Documentation: teach "cmd-list.perl" about out-of-tree builds
14:  6926a282a80 = 14:  4ef7262aa04 Documentation: extract script to generate a list of mergetools
15:  ed3affb794c = 15:  565c3d149f6 t: better support for out-of-tree builds
16:  205b038f961 = 16:  8ebb9184043 t: allow overriding build dir
17:  bef26dd67c5 = 17:  a39f9a4547b Documentation: add comparison of build systems
18:  780180568d9 ! 18:  de2239fbfcd Introduce support for the Meson build system
    @@ t/meson.build (new)
     +  )
     +  test(unit_test_name, unit_test,
     +    workdir: meson.current_source_dir(),
    ++    timeout: 0,
     +  )
     +endforeach
     +
19:  45e2ab4044a = 19:  0be293e8bff meson: fix conflicts with in-flight topics
-- 
2.47.0.229.g8f8d6eee53.dirty

