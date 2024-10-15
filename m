Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33BD81CFEA9
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992713; cv=none; b=XVrA/BgTMMtj2GfDyYphD07lU9/LqJ12hTcYNBP6H4lv4tQOw0lCAoeQd7Df5pM4sqSS/xcRE52cKa2fFqm189y9Iocww5VeVM3mNmO5goW9+etM7w26LPYbcsUq9uLqydbPA7BN5O6eCH8yP2vj0I4VDd7QRVzdjXYuJpg7hS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992713; c=relaxed/simple;
	bh=BxH4USwdXcCun1NBiSsUzInt2472G7WaTIMVag65wLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t7x2oaD4GCKrjlcQfuY25s8RyY3fTNA203FGeKcQGw8Nvo4MzPyQoNORFsIgfoWc7haS+V+1AriHVvZ+nQ3hHZWm3cr2r3SoaGLXU4pT7wCi10PZF9dRP7tptF656L0lbICJBdNST9Sy0GOtk5NpKHkeICJjy8I44odsDva356Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VzrHSSXH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEHeKMBK; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VzrHSSXH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEHeKMBK"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D30F611400B7;
	Tue, 15 Oct 2024 07:45:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 15 Oct 2024 07:45:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728992709; x=1729079109; bh=aRpmiLFDSb
	IfpTVFgefd9JqIAl5qUcOU+NBrwlIv/LM=; b=VzrHSSXH0Q0xrioH7hu2ONq3qu
	54vh30sAA4WUazk2ZTybt4WlCgQv0Z3diQCfsaEKsgXcA6G/uxGctODQrZIPXPwh
	FUo2VIElBzs4hLeBbZVMLFRyozxIAaOcUSWCoRrlwHXTO4/C6BsXflyQYj1Rj246
	qvaFYOQ5iB80h9jhC/8K2FT2UzIW+c80cAzewC0NRIb/IpaDFWM/oTk8R8HHauxH
	C/Myj8K5ucplKK5Vy8168G2fRJxsj+zQfGdkp/gSwtAHgm/fPm/AEjseFUmm7Owy
	gMV5FmkW4zBd4SVJyXA+0PmfestLZuu/1YQW0J/s+Q3FJE3Ud22CVqU+6fnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728992709; x=1729079109; bh=aRpmiLFDSbIfpTVFgefd9JqIAl5q
	UcOU+NBrwlIv/LM=; b=FEHeKMBKqwSfyuCfz5f7bgCQj54cVff4UfpXacRkXoox
	ey6UA0YxslttCRoOcg0tquImMZK9ktlenkqOCwFxi+I23//BIk8bqEj5jtOG/PUC
	ZRGPGdrhHTl1q8qjVLY2NnTStFxqiOIytG1ChbDrO0h3rqwKz9ZtCMIJAQhvKJ6L
	X4MDQOLpgAzi61QZ2Q9q7srJoFwFt0UV+o7V/qrQr4gi0+1T2rZ2e2rIUvLks6JX
	6inLH+TNUL0a03J1MdwjdYmYyb8/uFQr4DSGxfrrMR1sAKYOhoOQ92KN+aAaWUrV
	eNUPRAGpp+H1OCWUciHGm+Ev9UwRq0pftZtK1UpLyw==
X-ME-Sender: <xms:xVUOZ_nwX-SZbWgexBvHjCeeH6F3910scexb_d64f7JTqtJ_tT2WzQ>
    <xme:xVUOZy1s28pcM4ba8oN18yYJuDedyhBRgyHGWCfxjjxnjleqFx8_febDt68d7tKze
    KJqaZlCoDiGys6SiQ>
X-ME-Received: <xmr:xVUOZ1rVeTmh9umwI3_IWIsVhYu3Xm5Eh1ShEtjcsvwol3YuDXopniu732XwGh7H5X3xo40t3An2vJI4amxuyF9TTyV0VctFXgB2YkwUGoDWJQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgeffffdvvdffvdejleejueetvddtuefgvdeuffehiedv
    ffdvtedvteduudekvddunecuffhomhgrihhnpegtuddtqdhtlhhisgdqghhithifvggsrd
    hshhdphhhtthhpqdhfvghttghhqdguuhhmsgdrshhhnecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpth
    htohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:xVUOZ3kfau4Y_4pgStEGPWCRb6TlQlqnbVzQ4qBrnY--7_1iaB_LVA>
    <xmx:xVUOZ93gRQn7HHqKwGywVluxq5pt3PFmho6v9x-k7_AmXDONQqfcIw>
    <xmx:xVUOZ2voaS2LYrsnClk6iBBba4kmmtDVFoNbDzjA2iELMQbppDbmVA>
    <xmx:xVUOZxWpKfxx3odhhuGGlNdgnfiMO7ydJJ9_8aaTudSX5A-vbTJY7A>
    <xmx:xVUOZ2zQIJQxXUm5iTIbkdv94s_0fej1UvgqyzRpQe1X-P6p6O04R_Dv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Oct 2024 07:45:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f05431dc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 15 Oct 2024 11:43:53 +0000 (UTC)
Date: Tue, 15 Oct 2024 13:45:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 00/10] Platform compatibility fixes
Message-ID: <cover.1728992306.git.ps@pks.im>
References: <cover.1728906490.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728906490.git.ps@pks.im>

Hi,

this is the second version of my patch series that includes various
different platform compatibility fixes.

Changes compared to v1:

  - Provide a more in-depth explanation of the gitweb fix.

  - Fix up a stale comment in "lib-gitweb.sh".

  - Add a missing signoff.

Thanks!

Patrick

Patrick Steinhardt (10):
  t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
  t/test-lib: wire up NO_ICONV prerequisite
  t/lib-gitweb: test against the build version of gitweb
  t/lib-gpg: fix setup of GNUPGHOME in MinGW
  t1401: make invocation of tar(1) work with Win32-provided one
  t3404: work around platform-specific behaviour on macOS 10.15
  t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
  t7300: work around platform-specific behaviour with long paths on
    MinGW
  builtin/credential-cache: fix missing parameter for stub function
  http: fix build error on FreeBSD

 Makefile                                     |   1 +
 builtin/credential-cache.c                   |   3 +-
 contrib/buildsystems/CMakeLists.txt          |   6 ++
 http.c                                       |  10 +-
 t/lib-gitweb.sh                              |   4 +-
 t/lib-gpg.sh                                 |   2 +-
 t/t0028-working-tree-encoding.sh             |   6 ++
 t/t1401-symbolic-ref.sh                      |   2 +-
 t/t2082-parallel-checkout-attributes.sh      |   2 +-
 t/t3404-rebase-interactive.sh                |  26 +++--
 t/t3434-rebase-i18n.sh                       |   6 ++
 t/t3900-i18n-commit.sh                       |   6 ++
 t/t3901-i18n-patch.sh                        |   6 ++
 t/t4041-diff-submodule-option.sh             |  16 ++-
 t/t4059-diff-submodule-not-initialized.sh    |  16 ++-
 t/t4060-diff-submodule-option-diff-format.sh |  17 ++--
 t/t4201-shortlog.sh                          |   8 +-
 t/t4205-log-pretty-formats.sh                | 102 +++++++++++--------
 t/t4210-log-i18n.sh                          |   6 ++
 t/t4254-am-corrupt.sh                        |   6 ++
 t/t5100-mailinfo.sh                          |  14 ++-
 t/t5500-fetch-pack.sh                        |  14 ++-
 t/t5550-http-fetch-dumb.sh                   |   4 +-
 t/t5601-clone.sh                             |  11 +-
 t/t6006-rev-list-format.sh                   |  54 ++++++----
 t/t7102-reset.sh                             |  40 +++++---
 t/t7300-clean.sh                             |   2 +-
 t/t8005-blame-i18n.sh                        |   6 ++
 t/t9300-fast-import.sh                       |   2 +-
 t/t9350-fast-export.sh                       |  10 +-
 t/test-lib.sh                                |   3 +-
 31 files changed, 274 insertions(+), 137 deletions(-)

Range-diff against v1:
 1:  601670912ee =  1:  a514f5d14a7 t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
 2:  f1d74c46aa2 =  2:  f6a8582c34a t/test-lib: wire up NO_ICONV prerequisite
 3:  eda73d81139 !  3:  2e2d208ef1b t/lib-gitweb: test against the build version of gitweb
    @@ Commit message
         t/lib-gitweb: test against the build version of gitweb
     
         When testing gitweb we set up the CGI script as "gitweb.perl", which is
    -    the source file of the build target "gitweb.cgi". This works alright as
    -    long as we run in-tree tests. But we're about to make out-of-tree tests
    -    a reality, and there things will break because "gitweb.perl" will not be
    -    found in the build directory.
    +    the source file of the build target "gitweb.cgi". This file doesn't have
    +    a patched shebang and still contains `++REPLACEMENT++` markers, but
    +    things generally work because we replace the configuration with our own
    +    test configuration.
     
    -    Fix this by using "gitweb.cgi" instead.
    +    But this only works as long as "$GIT_BUILD_DIR" actually points to the
    +    source tree, because "gitweb.cgi" and "gitweb.perl" happen to sit next
    +    to each other. This is not the case though once you have out-of-tree
    +    builds like with CMake, where the source and built versions live in
    +    different directories. Consequently, "$GIT_BUILD_DIR/gitweb/gitweb.perl"
    +    won't exist there.
    +
    +    While we could ask build systems with out-of-tree builds to instead set
    +    up GITWEB_TEST_INSTALLED, which allows us to override the location of
    +    the script, it goes against the spirit of this environment variable. We
    +    _don't_ want to test against an installed version, we want to use the
    +    version we have just built.
    +
    +    Fix this by using "gitweb.cgi" instead. This means that you cannot run
    +    test scripts without building that file, but in general we do expect
    +    developers to build stuff before they test it anyway.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## t/lib-gitweb.sh ##
     @@ t/lib-gitweb.sh: EOF
    + 		test -f "$SCRIPT_NAME" ||
      		error "Cannot find gitweb at $GITWEB_TEST_INSTALLED."
      		say "# Testing $SCRIPT_NAME"
    - 	else # normal case, use source version of gitweb
    +-	else # normal case, use source version of gitweb
     -		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.perl"
    ++	else # normal case, use built version of gitweb
     +		SCRIPT_NAME="$GIT_BUILD_DIR/gitweb/gitweb.cgi"
      	fi
      	export SCRIPT_NAME
 4:  f5700647839 =  4:  cc94f6fa648 t/lib-gpg: fix setup of GNUPGHOME in MinGW
 5:  d082cd92af3 !  5:  58691dd652b t1401: make invocation of tar(1) work with Win32-provided one
    @@ Commit message
         Drop the trailing slash. Other tests that use tar(1) work alright, this
         is the only instance where it has been failing.
     
    +    Signed-off-by: Patrick Steinhardt <ps@pks.im>
    +
      ## t/t1401-symbolic-ref.sh ##
     @@ t/t1401-symbolic-ref.sh: reset_to_sane() {
      test_expect_success 'setup' '
 6:  a82a6b3df70 =  6:  1daadd82766 t3404: work around platform-specific behaviour on macOS 10.15
 7:  e1b9617f943 =  7:  374f47bf3de t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 8:  b94fd876adb =  8:  13c06a8129b t7300: work around platform-specific behaviour with long paths on MinGW
 9:  8cce69e5ba6 =  9:  5fd78b6d535 builtin/credential-cache: fix missing parameter for stub function
10:  deb30e12a58 = 10:  9963dc73988 http: fix build error on FreeBSD

base-commit: ef8ce8f3d4344fd3af049c17eeba5cd20d98b69f
-- 
2.47.0.72.gef8ce8f3d4.dirty

