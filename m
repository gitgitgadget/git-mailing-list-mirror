Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C73234CE8
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855782; cv=none; b=oqDi7UNbE8tdOiAAg1AL3ficP/jgvAY3CajTOqVbkrH0dj0KlypgSBzKHP9UV2vY89Zxbh6JwwgCHRfhxASOWfq3UsaspmH0aS+XW4LkEJExvWhklEWdeGnoLLVNdGA1YlYdQK8IiZYmtD/VM2AmOptHxVQRWgaxYx+ql4/me4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855782; c=relaxed/simple;
	bh=VTbpr2LwkcRxrSlcZ8d+CkkRJftoDiMtNGcnThBYjhs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=FQ/Rp1wm860GJ/ez4GmPUywXUHbmDJZZ/BK0SD/SNMxr6/84NXVprbZdhVTwlopOYM7CpMKStxw6ysfQNjz8I72LJELvkteZU4zkMaUqP4D5Sra66svHQj420oo3Hi029jXGa4Uw0HW3pu+V26P7TAlZxbr2Cjd1zGw3AfOz0PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mRPRCePQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h/EFYYnu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mRPRCePQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h/EFYYnu"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id ED57D13801EC;
	Tue, 14 Jan 2025 06:56:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 14 Jan 2025 06:56:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1736855777;
	 x=1736942177; bh=DYGT90pelgdoWq7iObBCSXFkt9Hw0Yzio3dJMdHHB/0=; b=
	mRPRCePQiHSOxYFMs/rjIFiZih6pisL5Kn5m4apFCLuGAEOu5/S4dY+idZbwFigc
	UkehMAwhkJ+fQA2sdNnw96ATaM1aQ/H93msxPncieceN4uwzZ2xA0TEDXNkwPNeh
	m+7bpWYva3BQIXfpEGUWSrHFFtYv9qqWWk1cdfFpovRf56nJ7nUQY9Cnzjdw93ri
	KgoaJ5ZACTYwEcPfc5EE8woUh1U7XoNfUW43tv8FCzAz7xDmFMb2fAn2Q9lJCxzU
	MQuJKQ9oj9QuTHcEAOU+Y5ToO6A6Me3Aq52sAXwOTZok9X6VvGrpFnYJMng+Zjy3
	I61IPf8ftl/IBTb/VoqySA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736855777; x=
	1736942177; bh=DYGT90pelgdoWq7iObBCSXFkt9Hw0Yzio3dJMdHHB/0=; b=h
	/EFYYnubN6hRD/Zrv1g5EUs5gC79r6/iSgapxCcLigxDmELiODnd2YOUiWlnKqoP
	dBom6EgpdUXQDo0TjZOITRnnKvPlxOazU9332gfqRNfti3fM5mR71piIvlThZSsc
	NpS+ioK0vfGSnRUHSY49Cniyan9yqAPLyeFVQ3BJKV3qpPTrqnRaPUKt1+vHcDaI
	MttP1N/ABEIWBHPsUafMUvlQe1t8/FBg07JPlrwrGYBoipcT/kSN4MJEVmNPa1io
	ee3l6P+d/GjpYJ0ceHQghA+tbBNcmGEPknXE1fdfb7sZBCGFCjUKGpT+YPfZWDwJ
	wc32DS2+FPf8N6nECcr+w==
X-ME-Sender: <xms:4VCGZ_Qm-H6vcXUVSqpoGhq6sETfCr_kwWTUdg3PqNAKsYoryKK5Hw>
    <xme:4VCGZwzqjctRP4LQGtS4PvZwFq4Ml9AB22u7JaXlcea8m_DTrkVzLUy-JEA9g6hmC
    eHc-BlonbheW0RqeQ>
X-ME-Received: <xmr:4VCGZ03HI05O58xqungdjQwkRuQd6lMMOwgaGVPMG9-AJyMaxSIvr5HHBFBSTL4bz6l0kGPyFmyeVV6vIBDKdfLPZYkR-6U4B-hYrC2CSs_p6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevjeefheeggeeljeduffetveehgfeiueehgffgudff
    ffffgeeifeetveejleeuvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgihhtlh
    grsgdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephe
    dpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghvrghnrdhmrghrthhinhesghhm
    rghilhdrtghomhdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhoohdrohhrgh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehmihhrthhhrdhhihgtkh
    hfohhrugesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:4VCGZ_B1KjAojTTg8mVHXFFm92fthGckZZT7GKycLuN8CIsqyQ4KzA>
    <xmx:4VCGZ4ibjb19fXaoD0k_SgA94qc0_TZjwD77tpbNZh6EfzMN94MiSw>
    <xmx:4VCGZzoFTsGcprgVMbQ__8nuBMozodbPhZtPsJuMbGttcuwElruDaA>
    <xmx:4VCGZzjn__Zup14bUwJr7yPZOYBdhkGZcx4YhkKHZ6LzJFG9qe0PTw>
    <xmx:4VCGZyYEC_7cG-NFw9e9ms2ZdiZp8npqq77fKyD-u9fFkYd6lbURRxy1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 06:56:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b3ff3c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 11:56:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/11] meson: a couple of additions
Date: Tue, 14 Jan 2025 12:56:10 +0100
Message-Id: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANpQhmcC/3WNywrCMBBFf6XM2pE8TEtd+R/SRdMkdpA+yJSgl
 Py7sbh1eS73nrsD+0ie4VrtEH0ipmUuoE4VDGM/PzySKwxKKCOkaNBecH0yTp6XGXvnaCsLRmH
 MIGurhVEWyniNPtDrEN+7wiPxtsT38ZPkN/0ppf6nTBIFtk2o+1aHupXuVlpnmqDLOX8AboyAT
 7kAAAA=
X-Change-ID: 20250107-b4-pks-meson-additions-055c16b3052b
In-Reply-To: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
To: git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, 
 Eli Schwartz <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, 
 M Hickford <mirth.hickford@gmail.com>
X-Mailer: b4 0.14.2

Hi,

this small patch series backfills in a couple of missing features into
Meson. It also improves test coverage of our Meson-based CI jobs so that
we compile with Meson with Visual Studio and compile fuzzers. CI runs
for GitLab and GitHub can be found at [1] and [2], respectively.

The series is built on top of fbe8d3079d (Git 2.48, 2025-01-10) with
ps/meson-weak-sha1-build at 6a0ee54f9a (meson: provide a summary of
configured backends, 2024-12-30) merged into it.

Changes in v2:
  - Consistently use `meson.has_header_symbol()` to fix warnings for
    features not yet available in Meson 0.61, which is our minimum
    required version.
  - Add another patch that makes use use `--fatal-meson-warnings` so
    that such warnings will cause the build to fail.
  - Fix a bug that made GIT-VERSION-GEN always return tags as version.
  - Adapt the approach we use to populate the project and distribution
    tarball versions.
  - Link to v1: https://lore.kernel.org/r/20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im

Thanks!

Patrick

[1]: https://gitlab.com/gitlab-org/git/-/merge_requests/280
[2]: https://github.com/git/git/pull/1870

---
Patrick Steinhardt (11):
      GIT-VERSION-GEN: simplify computing the dirty marker
      GIT-VERSION-GEN: allow running without input and output files
      meson: populate project version via GIT-VERSION-GEN
      meson: fix dependencies for generated headers
      meson: wire up development environments
      meson: wire up generation of distribution archive
      meson: wire up fuzzers
      meson: make the CSPRNG backend configurable
      meson: fix compilation with Visual Studio
      ci: raise error when Meson generates warnings
      ci: wire up Visual Studio build with Meson

 .github/workflows/main.yml | 52 +++++++++++++++++++++++++++
 .gitlab-ci.yml             | 38 ++++++++++++++++++++
 GIT-VERSION-GEN            | 50 ++++++++++++++++----------
 ci/run-build-and-tests.sh  |  4 ++-
 meson.build                | 87 +++++++++++++++++++++++++++++++++++++---------
 meson_options.txt          |  4 +++
 oss-fuzz/meson.build       | 20 +++++++++++
 7 files changed, 219 insertions(+), 36 deletions(-)

Range-diff versus v1:

 1:  9cceb5db4d !  1:  a546dd43be GIT-VERSION-GEN: simplify computing the dirty marker
    @@ GIT-VERSION-GEN: then
      			test -f "$SOURCE_DIR"/.git;
      		} &&
     -		VN=$(git -C "$SOURCE_DIR" describe --match "v[0-9]*" HEAD 2>/dev/null) &&
    -+		VN=$(git -C "$SOURCE_DIR" describe --match --dirty "v[0-9]*" 2>/dev/null) &&
    ++		VN=$(git -C "$SOURCE_DIR" describe --dirty --match="v[0-9]*" 2>/dev/null) &&
      		case "$VN" in
      		*$LF*) (exit 1) ;;
     -		v[0-9]*)
 2:  00b9586887 <  -:  ---------- GIT-VERSION-GEN: move default version into a separate file
 -:  ---------- >  2:  3079bcc87a GIT-VERSION-GEN: allow running without input and output files
 -:  ---------- >  3:  aab1945e47 meson: populate project version via GIT-VERSION-GEN
 3:  a7712e6874 =  4:  782b9677c3 meson: fix dependencies for generated headers
 4:  0b30d76c7a =  5:  a9efaebe7b meson: wire up development environments
 5:  71081feccf !  6:  92913a6b20 meson: wire up generation of distribution archive
    @@ Metadata
      ## Commit message ##
         meson: wire up generation of distribution archive
     
    -    Meson knows to generate distribution archives via `meson dist`. Despite
    -    generating the archive itself, this target also knows to compile and
    -    execute tests from that archive, which helps to ensure that the result
    -    is an adequate drop-in replacement for the versioned project.
    +    Meson knows to generate distribution archives via `meson dist`. In
    +    addition to generating the archive itself, this target also knows to
    +    compile and execute tests from that archive, which helps to ensure that
    +    the result is an adequate drop-in replacement for the versioned project.
     
         While this already works as-is, one omission is that we don't propagate
         the commit that this is built from into the resulting archive. This can
    @@ Commit message
         version into the "version" file, which GIT-VERSION-GEN knows to read if
         present.
     
    -    Use GIT-VERSION-GEN itself to populate that file. There are two smallish
    -    gotchas:
    -
    -      - The script is executed in the build directory, not in the directory
    -        where we generate the archive. The target directory is propagated
    -        via the "MESON_DIST_ROOT" environment variable, but because we don't
    -        use a shell to execute GIT-VERSION-GEN we cannot populate the envvar
    -        into its arguments. We thus adapt GIT-VERSION-GEN to handle this for
    -        us.
    -
    -      - We use the "GIT-VERSION-FILE.in" template to generate the version,
    -        which contains a "GIT_VERSION=" prefix that we need to strip after
    -        reading the "version" file. We could avoid this extra logic if we
    -        used a template that only had the `@GIT_VERSION@` placeholder, but
    -        it would require us to add one more template file.
    +    Use GIT-VERSION-GEN to populate that file. As the script is executed in
    +    the build directory, not in the directory where we generate the archive,
    +    we have adapt it to honor the "MESON_DIST_ROOT" environment variable.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## GIT-VERSION-GEN ##
    -@@ GIT-VERSION-GEN: then
    - 	exit 1
    - fi
    +@@ GIT-VERSION-GEN: case "$2" in
    + esac
      
    + OUTPUT="$3"
     +if test -n "$OUTPUT" && test -n "$MESON_DIST_ROOT"
     +then
     +    OUTPUT="$MESON_DIST_ROOT/$OUTPUT"
     +fi
    -+
    - DEF_VER=$(cat "$SOURCE_DIR"/GIT-VERSION)
      
      # Protect us from reading Git version information outside of the Git directory
    -@@ GIT-VERSION-GEN: then
    - 	# then try git-describe, then default.
    - 	if test -f "$SOURCE_DIR"/version
    - 	then
    --		VN=$(cat "$SOURCE_DIR"/version) || VN="$DEF_VER"
    -+		VN=$(cat "$SOURCE_DIR"/version) && VN=${VN#GIT_VERSION=} || VN="$DEF_VER"
    - 	elif {
    - 			test -d "$SOURCE_DIR/.git" ||
    - 			test -d "${GIT_DIR:-.git}" ||
    + # in case it is not a repository itself, but embedded in an unrelated
     
      ## meson.build ##
     @@ meson.build: devenv.set('GIT_BUILD_DIR', meson.current_build_dir())
    @@ meson.build: devenv.set('GIT_BUILD_DIR', meson.current_build_dir())
     +  shell,
     +  meson.current_source_dir() / 'GIT-VERSION-GEN',
     +  meson.current_source_dir(),
    -+  meson.current_source_dir() / 'GIT-VERSION-FILE.in',
    ++  '--format=@GIT_VERSION@',
     +  'version',
     +)
     +
 6:  5dd6be9be7 =  7:  4bde8aee4c meson: wire up fuzzers
 7:  88e2935e52 !  8:  2f33403322 meson: make the CSPRNG backend configurable
    @@ meson.build: else
      endif
      
     -if compiler.has_header_symbol('stdlib.h', 'arc4random_buf')
    ++# Backends are ordered to reflect our preference for more secure and faster
    ++# ones over the ones that are less so.
     +if csprng_backend in ['auto', 'arc4random'] and compiler.has_header_symbol('stdlib.h', 'arc4random_buf', required: csprng_backend == 'arc4random')
        libgit_c_args += '-DHAVE_ARC4RANDOM'
     -elif compiler.has_header_symbol('bsd/stdlib.h', 'arc4random_buf')
    @@ meson.build: else
        libgit_c_args += '-DHAVE_ARC4RANDOM_BSD'
     -elif compiler.has_function('getrandom', prefix: '#include <sys/random.h>')
     +  csprng_backend = 'arc4random_bsd'
    -+elif csprng_backend in ['auto', 'getrandom'] and compiler.has_function('getrandom', prefix: '#include <sys/random.h>', required: csprng_backend == 'getrandom')
    ++elif csprng_backend in ['auto', 'getrandom'] and compiler.has_header_symbol('sys/random.h', 'getrandom', required: csprng_backend == 'getrandom')
        libgit_c_args += '-DHAVE_GETRANDOM'
     -elif compiler.has_function('getentropy', prefix: '#include <unistd.h>')
     +  csprng_backend = 'getrandom'
    -+elif csprng_backend in ['auto', 'getentropy'] and compiler.has_function('getentropy', prefix: '#include <unistd.h>', required: csprng_backend == 'getentropy')
    ++elif csprng_backend in ['auto', 'getentropy'] and compiler.has_header_symbol('unistd.h', 'getentropy', required: csprng_backend == 'getentropy')
        libgit_c_args += '-DHAVE_GETENTROPY'
     -elif compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>')
     +  csprng_backend = 'getentropy'
    -+elif csprng_backend in ['auto', 'rtlgenrandom'] and compiler.has_function('RtlGenRandom', prefix: '#include <windows.h>\n#include <ntsecapi.h>', required: csprng_backend == 'rtlgenrandom')
    ++elif csprng_backend in ['auto', 'rtlgenrandom'] and compiler.has_header_symbol('ntsecapi.h', 'RtlGenRandom', prefix: '#include <windows.h>', required: csprng_backend == 'rtlgenrandom')
        libgit_c_args += '-DHAVE_RTLGENRANDOM'
     -elif openssl.found()
     +  csprng_backend = 'rtlgenrandom'
 8:  f6ee13d6dc <  -:  ---------- meson: fix compilation with Visual Studio
 -:  ---------- >  9:  d56a24e15a meson: fix compilation with Visual Studio
 -:  ---------- > 10:  c624f1d554 ci: raise error when Meson generates warnings
 9:  946c31f452 = 11:  c7f7e2309a ci: wire up Visual Studio build with Meson

---
base-commit: 35a417ddf0eab983e4d5eb69e628aa198114bb05
change-id: 20250107-b4-pks-meson-additions-055c16b3052b

