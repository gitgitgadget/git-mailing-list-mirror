Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA89187850
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066378; cv=none; b=oELraL5b0+dIjs9oPVbeCWkBFBnApMFa3mKypdMLH/ywlFSohZZaryXaqDtAw6bdHuOsVsIm0lDC3ywuTfdKVA9G6c5aIxfEgdnH/UnZqArQbplKfwQA/ooCB2kJ5FGS+yJYMjWQmMpoae9zPJugERnRZX34ihJtXT6eXoKaEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066378; c=relaxed/simple;
	bh=8/ajlvQuRI+hNoSV8DMZDr1fjJnLDpMmIqsGQAj5ceU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqMVacOORuAkk+MunLHbu7x7BiAOgwe07jHrahFVrJgSmJbKAGydst9BlntC0VGrpk6X0h/+LTkDEwl5Li9CWXNRt/KgjlV11kEMqJpD5PSLN+LZe3MD680U9s8SAdi1hvrnXPicgoDSWOMhOAuOYJeGPa9D7I+1iCtCmnTEBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=sJU0segJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QYJgIAyp; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="sJU0segJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QYJgIAyp"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 66FFF1140134;
	Wed, 16 Oct 2024 04:12:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 16 Oct 2024 04:12:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1729066374; x=1729152774; bh=DHFpk8HUsi
	E+Pj1oJYeeiPIvkfqAAOM+MenZV5vsklI=; b=sJU0segJE09t+8CxyBRLDDvcmL
	ULDSVBhNxGaMyun9qFiqZ19b0Nac+guybuMYy/F5N0qNAfYX3/HD9ATy2ITzpQ7Q
	ZJGl/7Wg1LawNups6oqRatgqsn1HIlz5oPHHn82oxr0Evj36DFrJ9vohJolhBxn4
	Bk8fYpzchsLsMX6xePDALrRf7nruYbbRQ9WKpGxFd2VLUxl0nHshV/KERv1Mf08h
	OGt2V52fe4g7jMi4jmG+lg+jr1P4Uv5jQwDiUIk6aB+aK7iLzRvdoD2ofzQhrNBN
	w1xQ/wRQAZTM1eeSPSYxSqdhgUSG0LyPgHJp7060yjFOkPy0VljnYjZT8tyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1729066374; x=1729152774; bh=DHFpk8HUsiE+Pj1oJYeeiPIvkfqA
	AOM+MenZV5vsklI=; b=QYJgIAypDDtH4JUT9ztDj2Xc8gcjr4cnKeeL8exggw6O
	HIkqzvmIWj9azTF9cgF/zFh3aOCF9fHPQtfbUIq0MVk8aArk5h9aMFZ2yNvubsqZ
	mTU77PW1C9/HwF+iFKEpmx2zpkHTStE2BGTKqRuuLZPykh97ziq+3r01jUOzVG/K
	opAomgSNzcOjtXKR8JKeJWwrifkyH3C3XzM93ZlnfbgvNbp+4zr0cSjXUwksEorD
	mepf2v/9PvVDnkA4RZZXrDCADdhvwPqDgGkQX5EsP6VTAEAVhmbwLHNKX87Vso2k
	pgP9GSyC6TB4je4mu+4MxGsJNyU+WGtQC58bQWblJA==
X-ME-Sender: <xms:hnUPZ6NY7zgXd8niZ-cN52mAdcMeJ8owDnsz1WZCqx_t4qZtOiN4FA>
    <xme:hnUPZ49LxZ_E6_iWURNhfAd6kCzGaPlSD2seVkFdm3Cke_-pxgMS60U-Hzw8i6C50
    OI7cG28c4nc7EhoWw>
X-ME-Received: <xmr:hnUPZxT-F-r0Gd6UMb04Ek87F_k34oKbaDM6g_5557EyUCS7oxpD_DcSD2I7DQFzn2AE_apxDa17ExF7P5WORr4HyQ833RaAbwJJjX_jobKI8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegledgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepgfffvdetheegueetgfekhfeufeetkedtvdduveefjefg
    ueffgfejgfevveevudegnecuffhomhgrihhnpehgihhthhhusgdrtghomhdptgdutddqth
    hlihgsqdhgihhtfigvsgdrshhhpdhhthhtphdqfhgvthgthhdqughumhgsrdhshhenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhg
X-ME-Proxy: <xmx:hnUPZ6uS0BFJARgBK3qG0wpm1DpIHr8xlIAami7RQuXUoM7KV-grXQ>
    <xmx:hnUPZyfZe7VyYXuMboy7w4ezTX3bskaKsxtLXvRkwQ5CZ8fOJGpy6g>
    <xmx:hnUPZ-0brw1Lw-aRjiXs78eam9KoJzlbe9ECZIBfPv8V8KbPX7reGA>
    <xmx:hnUPZ29jv92mo2uuJNQaX_K7SlWEqLlhva1C9DvBH9c1tERyL4Q1OQ>
    <xmx:hnUPZy4y1Kc_r5DAhdalSJBEujG75q1jDopg2hbzjP5ZFY9w6RiS47JA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Oct 2024 04:12:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a9c4e077 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Oct 2024 08:11:32 +0000 (UTC)
Date: Wed, 16 Oct 2024 10:12:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 00/10] Platform compatibility fixes
Message-ID: <cover.1729060405.git.ps@pks.im>
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

this is the third version of this series that fixes various different
issues on more or less esoteric platforms.

There's only a single change compared to v2, namely that I restore the
`!MINGW` prerequisite in t4201. I've been a bit overeager to convert it
to use `ICONV` as that platform is seemingly still broken here.

I've kicked off another pipeline at GitHub [1] while the GitLab CI
support for Windows hasn't yet landed to verify that things work as
expected now. Tests pass now.

Thanks!

[1]: https://github.com/git/git/pull/1815

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

Range-diff against v2:
 1:  a514f5d14a7 =  1:  a514f5d14a7 t/test-lib: fix quoting of TEST_RESULTS_SAN_FILE
 2:  f6a8582c34a !  2:  c046e5f03bf t/test-lib: wire up NO_ICONV prerequisite
    @@ Commit message
         assess whether the failure is expected or not. Most of the tests do
         smell like the expected kind of failure though.
     
    -    Further note that there are several "!MINGW" conditions in t4201, and
    -    all of these fail due to iconv-related errors. This is quite likely a
    -    leftover from times before dce7d29551 (msvc: support building Git using
    -    MS Visual C++, 2019-06-25), which switched Windows-based builds over
    -    from "NO_ICONV=YesPlease" to "NEEDS_LIBICONV=YesPlease". Consequently,
    -    adapt those tests to also use the new ICONV prerequisite.
    -
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
      ## Makefile ##
    @@ t/t4201-shortlog.sh: test_expect_success 'output from user-defined format is re-
      '
      
     -test_expect_success !MINGW 'shortlog wrapping' '
    -+test_expect_success ICONV 'shortlog wrapping' '
    ++test_expect_success !MINGW,ICONV 'shortlog wrapping' '
      	cat >expect <<\EOF &&
      A U Thor (5):
            Test
    @@ t/t4201-shortlog.sh: EOF
      '
      
     -test_expect_success !MINGW 'shortlog from non-git directory' '
    -+test_expect_success ICONV 'shortlog from non-git directory' '
    ++test_expect_success !MINGW,ICONV 'shortlog from non-git directory' '
      	git log --no-expand-tabs HEAD >log &&
      	GIT_DIR=non-existing git shortlog -w <log >out &&
      	test_cmp expect out
      '
      
     -test_expect_success !MINGW 'shortlog can read --format=raw output' '
    -+test_expect_success ICONV 'shortlog can read --format=raw output' '
    ++test_expect_success !MINGW,ICONV 'shortlog can read --format=raw output' '
      	git log --format=raw HEAD >log &&
      	GIT_DIR=non-existing git shortlog -w <log >out &&
      	test_cmp expect out
    @@ t/t4201-shortlog.sh: $DSCHO (2):
      EOF
      
     -test_expect_success !MINGW 'shortlog encoding' '
    -+test_expect_success ICONV 'shortlog encoding' '
    ++test_expect_success !MINGW,ICONV 'shortlog encoding' '
      	git reset --hard "$commit" &&
      	git config --unset i18n.commitencoding &&
      	echo 2 > a1 &&
 3:  2e2d208ef1b =  3:  52d0b252a1c t/lib-gitweb: test against the build version of gitweb
 4:  cc94f6fa648 =  4:  89957caf6ad t/lib-gpg: fix setup of GNUPGHOME in MinGW
 5:  58691dd652b =  5:  df2fb1b9607 t1401: make invocation of tar(1) work with Win32-provided one
 6:  1daadd82766 =  6:  29fffa5d86b t3404: work around platform-specific behaviour on macOS 10.15
 7:  374f47bf3de =  7:  de4c0c786bd t5500, t5601: skip tests which exercise paths with '[::1]' on Cygwin
 8:  13c06a8129b =  8:  ee67336621c t7300: work around platform-specific behaviour with long paths on MinGW
 9:  5fd78b6d535 =  9:  aaa6b5a175d builtin/credential-cache: fix missing parameter for stub function
10:  9963dc73988 = 10:  c22a94bab41 http: fix build error on FreeBSD
-- 
2.47.0.72.gef8ce8f3d4.dirty

