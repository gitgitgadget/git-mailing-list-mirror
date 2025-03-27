Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DA513C8EA
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071832; cv=none; b=IFj9/yIfcpwsFMoB1Mm4yhZ/r6Y/BTM8C1/GOijkX/UmIw2+A/tk37RivEJ/oZo6qR9q5VCgRuhL7CBN0P28fm0+FFyvbNdQT82OCHFfN9JQrSwgeYMiEdCuoLHJddvMTPkw7YLtEgcbjEOTI6wzIj0ixiZIGfSTkxEMwjciGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071832; c=relaxed/simple;
	bh=iPIe0sSAcr0ydKgN/lomRQ93D5WqRLMj4aQSrGgLdsc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=nnKVVGyzrPuQXpcvz1vp7LOAI6PrzALGrE+LLzXnbI8U5D4idyJDNcsPueHcl6uf+/OUjrcFJfmEmM7khdkRXAsfxfDS/m+RZwCcx46rGKwlYKwCAL1MA9TRxyQ/2VvXGXEOpRV+RpR+IeAM7X+PJIeTvgYlsqfsMf9Zq4uYv/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JXOZWVe8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NwVIW/g3; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JXOZWVe8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NwVIW/g3"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 3235913839B1;
	Thu, 27 Mar 2025 06:37:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 27 Mar 2025 06:37:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071829;
	 x=1743158229; bh=rDQYJRv55xHtwn2UQ5mWOtG1xUWmtZ6iVEioWm5AVLU=; b=
	JXOZWVe8GIWZ+ypueN/fKsDXRIErYkfH/lcyAivw5Mhaq2WNZn4JdkDLpl8M1cWX
	+vZrt75zE8EYfsrdvJofCeyt8aZGtIgMu86cEougPLfzlKqYUIxYu6cZQ3h5jJGX
	lCAAZ4IgAzVLlhQFl82M2yQf9qNmta8q0XxVdQeqD1DvUP5bmzM6RKbZyZvXkHdz
	XSkYGu7S+bXwyqcGsMMTv6CI97wxD/Yuw18NavguN50ZOQGKr13orkFpkbUrlxt4
	gyCHcw9SLp0awcVOuwVDCmbZMmRUplJlbN7K87/VK0L5MCr7GbG03MeQwoaYmTjR
	G5PQ/x3e1Acps9mKEERaHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071829; x=
	1743158229; bh=rDQYJRv55xHtwn2UQ5mWOtG1xUWmtZ6iVEioWm5AVLU=; b=N
	wVIW/g3teeTTBFbXRf2KhKQenRBiNbOJWUVz9CgQyoEMFbmOQxhhy6CnQE1fdau2
	R977XIviVcupmF6mKUjZZka42e9utzQpwL2WCgBNKs09W2Qqye/tLRRh/TP9ee+4
	DVySgGy5wIBcG09z7fVEyTj1JoSCuKaDSEIOchkNzFrQsXELkPANuVajj8V5Ijk2
	ZiJX64MC7gaVrCWEhT1RS2FKeOqQyX/Ne7DrEEbeW1TYPZVUrByBdaHfcpROtvV6
	wHAQBDWcFBWFO5iGmAtHJ7JVAognAG3TvOo42UeIETNoWExsrcnlm5KFzY4qHj32
	WKf9jjCut4EU1mN9l4OtQ==
X-ME-Sender: <xms:VCrlZz1go6cS6v7q12RMTUSk9OJ5TRwOODvOVBKMVVtQdOMw4kAUzw>
    <xme:VCrlZyHkOA9ZGJ96xmfL6eMyp43lY9w8Ch3EzkU-9-Pv_OmsVXbhCT6cv0GHDIWxE
    CjgfSCiFlrvAXMEmQ>
X-ME-Received: <xmr:VCrlZz4g-3vdIYjmFnsO97zfP3mQ-zhOpok19E0IEAT1kIP5LQ0xLQcp1Unhj3hxjvgL5pu4VJq9S7dAUnn5grgpqhp-nioSJbNGud5M2w4RbQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpefgheffjeefueevjedvjeettdefjeeitdehtdei
    keetheevffekvefhveelieelieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhhth
    htphgurdhshhdphhhtthhpqdhfvghttghhqdhsmhgrrhhtrdhshhdphhhtthhpqdgsrggt
    khgvnhguqdgtohhnthgvnhhtqdhlvghnghhthhdrshhhpdhtthehjedtvddqphhrohhtoh
    gtohhlqdhvvddrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghi
    lhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtph
    htthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:VCrlZ43a7yoBdiewl_GWcMdJSp1I9RF8dJrSzLXKjOlmCvfQvAdw0Q>
    <xmx:VSrlZ2GAusLFwdRCynnWvGXp0cj2Qq1AauyS2doDsQubwpJQBNJE7w>
    <xmx:VSrlZ59rEnHL_bZtEmnzZnY2fAb0NFLGiGy6QMpt_S3mnk5SG4geGA>
    <xmx:VSrlZzk-ujzQwPAqTYgJXZKymjb16M-DYnVPCft1cALz6nwDJ0kEyg>
    <xmx:VSrlZzPW6rmINqYYJN0NLZIHgh59Ht5qgTOZ2bOVFOPoLuYsVWWYl094>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:07 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2851b372 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 00/20] t: drop Perl as a mandatory prerequisite
Date: Thu, 27 Mar 2025 11:36:58 +0100
Message-Id: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEsq5WcC/22NQQ6CMBBFr0K6tqYdKC2uvIdxQXGQiQhNSxoN4
 e4WYowLlu9n3puZBfSEgZ2ymXmMFGgcEuSHjDVdPdyR0y0xAwFK5FJzW3D3CHziDn3fYwhc5qZ
 pq6KsSmtY8pzHll5b83JN3FGYRv/eXkS5rt8aiJ1alDzNErFF0HWj1DkdHOnJ1lSEf13t6ZD0w
 hptjdBQavHTl2X5AGS3AKzuAAAA
X-Change-ID: 20250317-b4-pks-t-perlless-138cf94696b8
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

Hi,

while Git was initially building on Perl quite a lot, the significance
of Perl has been dwindling over the years as more and more functionality
was converted into C builtins. Nowadays, an installation with Perl-based
features disabled is almost fully functional, only a handful of features
remain that require Perl:

  - gitweb, a read-only web interface.

  - A couple of scripts that allow importing repositories from GNU Arch,
    CVS and Subversion.

  - git-send-email(1), which can be used to send mails.

  - Our Perl bindings for Git.

  - The netrc Git credential helper.

None of these features really are critical for day-to-day usage of Git,
and most users probably wouldn't even notice if those features were not
installed. Perl is thus very much optional nowadays.

There is one big exception though: it is impossible to run our test
suite without a Perl interpreter, so it is not easily possible to verify
that a Perl-less installation actually works as expected. For most of
the part though our test suite doesn't use all that much Perl, either.
It is present in a couple of critical paths, but those are easy to adapt
to not use Perl anymore.

This is exactly what this patch series does: it refactors a couple of
central parts in our test suite to not use Perl anymore so that it
becomes possible to run most of our tests entirely without Perl. Tests
that still depend on Perl are marked with a new PERL_TEST_HELPERS prereq
so that they only execute when a Perl interpreter is available.

With this patch series, 30342 out of 31358 tests pass, which is around
97% of our tests.

Changes in v2:
  - Improve a couple of conversions based on feedback.
  - Clarify the commit message of the textconv conversion.
  - Fix a copy-paste error when it comes to skipping tests in t4103.
  - Link to v1: https://lore.kernel.org/r/20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im

Changes in v3:
  - Remove more useless indirections for sed(1).
  - Link to v2: https://lore.kernel.org/r/20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (20):
      t: skip chain lint when PERL_PATH is unset
      t: refactor environment sanitization to not use Perl
      t: adapt character translation helpers to not use Perl
      t: adapt `test_copy_bytes()` to not use Perl
      t: adapt `test_readlink()` to not use Perl
      t: introduce PERL_TEST_HELPERS prerequisite
      t: adapt existing PERL prerequisites
      meson: stop requiring Perl when tests are enabled
      Makefile: stop requiring Perl when running tests
      t: refactor tests depending on Perl transliteration operator
      t: refactor tests depending on Perl substitution operator
      t: refactor tests depending on Perl to print data
      t: refactor tests depending on Perl for textconv scripts
      t/lib-gpg: refactor `sanitize_pgp()` to not depend on Perl
      t/lib-t6000: refactor `name_from_description()` to not depend on Perl
      t/lib-httpd: refactor "one-time-perl" CGI script to not depend on Perl
      t0021: refactor `generate_random_characters()` to not depend on Perl
      t0210: refactor trace2 scrubbing to not use Perl
      t5316: refactor `max_chain()` to not depend on Perl
      t5703: refactor test to not depend on Perl

 meson.build                               |  2 +-
 t/Makefile                                | 16 +++++++--
 t/helper/test-path-utils.c                | 13 ++++++++
 t/helper/test-sha1.sh                     |  4 +--
 t/lib-diff.sh                             |  4 +--
 t/lib-gpg.sh                              |  6 +---
 t/lib-httpd.sh                            |  2 +-
 t/lib-httpd/apache.conf                   |  6 ++--
 t/lib-httpd/apply-one-time-perl.sh        | 27 ---------------
 t/lib-httpd/apply-one-time-script.sh      | 26 +++++++++++++++
 t/lib-t6000.sh                            | 13 ++++----
 t/t0008-ignores.sh                        |  4 +--
 t/t0021-conversion.sh                     | 13 ++++----
 t/t0090-cache-tree.sh                     |  4 +--
 t/t0210-trace2-normal.sh                  | 55 ++++++++++++++++++++++++-------
 t/t0210/scrub_normal.perl                 | 54 ------------------------------
 t/t0211-trace2-perf.sh                    |  6 ++++
 t/t0610-reftable-basics.sh                |  5 ++-
 t/t0613-reftable-write-options.sh         |  2 +-
 t/t1006-cat-file.sh                       | 16 +++++----
 t/t1007-hash-object.sh                    |  6 ++--
 t/t1010-mktree.sh                         |  4 +--
 t/t1450-fsck.sh                           |  6 ++--
 t/t3300-funny-names.sh                    |  6 ++--
 t/t4013-diff-various.sh                   |  6 ++++
 t/t4014-format-patch.sh                   | 30 ++++++++---------
 t/t4020-diff-external.sh                  |  2 +-
 t/t4029-diff-trailing-space.sh            |  3 +-
 t/t4030-diff-textconv.sh                  |  9 ++---
 t/t4031-diff-rewrite-binary.sh            | 17 ++++------
 t/t4058-diff-duplicates.sh                |  6 ++++
 t/t4103-apply-binary.sh                   |  6 ++--
 t/t4116-apply-reverse.sh                  |  4 +--
 t/t4150-am.sh                             |  8 ++---
 t/t4200-rerere.sh                         |  8 ++---
 t/t4205-log-pretty-formats.sh             |  6 ++--
 t/t4216-log-bloom.sh                      |  8 ++---
 t/t5004-archive-corner-cases.sh           |  6 ++++
 t/t5300-pack-object.sh                    | 10 +++---
 t/t5303-pack-corruption-resilience.sh     |  6 ++--
 t/t5310-pack-bitmaps.sh                   |  2 +-
 t/t5316-pack-delta-depth.sh               | 10 +++---
 t/t5318-commit-graph.sh                   | 12 +++----
 t/t5319-multi-pack-index.sh               | 16 ++++-----
 t/t5324-split-commit-graph.sh             |  2 +-
 t/t5326-multi-pack-bitmaps.sh             |  4 +--
 t/t5328-commit-graph-64bit-time.sh        |  2 +-
 t/t5333-pseudo-merge-bitmaps.sh           | 12 +++----
 t/t5400-send-pack.sh                      |  2 +-
 t/t5410-receive-pack-alternates.sh        |  2 +-
 t/t5503-tagfollow.sh                      |  6 ++++
 t/t5504-fetch-receive-strict.sh           |  2 +-
 t/t5510-fetch.sh                          |  6 ++++
 t/t5532-fetch-proxy.sh                    |  6 ++++
 t/t5534-push-signed.sh                    |  2 +-
 t/t5537-fetch-shallow.sh                  | 15 ++++-----
 t/t5551-http-fetch-smart.sh               |  7 ++++
 t/t5562-http-backend-content-length.sh    |  6 ++++
 t/t5601-clone.sh                          |  4 +--
 t/t5616-partial-clone.sh                  | 46 ++++++++++++++------------
 t/t5701-git-serve.sh                      |  5 ++-
 t/t5702-protocol-v2.sh                    | 21 +++++++-----
 t/t5703-upload-pack-ref-in-want.sh        | 29 ++++++++--------
 t/t5710-promisor-remote-capability.sh     |  6 ++++
 t/t6011-rev-list-with-bad-commit.sh       | 14 +++++---
 t/t6013-rev-list-reverse-parents.sh       | 10 +++---
 t/t6102-rev-list-unexpected-objects.sh    |  6 ++++
 t/t6115-rev-list-du.sh                    |  2 +-
 t/t6300-for-each-ref.sh                   | 15 ++++++---
 t/t7006-pager.sh                          |  6 ++--
 t/t7416-submodule-dash-url.sh             |  3 +-
 t/t7501-commit-basic-functionality.sh     |  6 ++--
 t/t7508-status.sh                         |  2 +-
 t/t7815-grep-binary.sh                    |  9 ++---
 t/t8001-annotate.sh                       |  6 ++++
 t/t8002-blame.sh                          |  8 ++++-
 t/t8006-blame-textconv.sh                 |  2 +-
 t/t8011-blame-split-file.sh               |  6 ++--
 t/t8012-blame-colors.sh                   |  6 ++++
 t/t9137-git-svn-dcommit-clobber-series.sh | 10 +++---
 t/t9350-fast-export.sh                    |  2 +-
 t/t9850-shell.sh                          |  2 +-
 t/test-lib-functions.sh                   | 20 +++--------
 t/test-lib.sh                             | 49 +++++++++++++++++----------
 84 files changed, 471 insertions(+), 373 deletions(-)

Range-diff versus v2:

 1:  8c98b24fe4c =  1:  f2fe08ef0ff t: skip chain lint when PERL_PATH is unset
 2:  f140153954c =  2:  9dd2edd0a1a t: refactor environment sanitization to not use Perl
 3:  94b5591f666 =  3:  c77424e6907 t: adapt character translation helpers to not use Perl
 4:  a5880fdb8ef =  4:  476d1b15932 t: adapt `test_copy_bytes()` to not use Perl
 5:  3b64c99c061 =  5:  14badee2551 t: adapt `test_readlink()` to not use Perl
 6:  a3536260e4c =  6:  9a88a46bd10 t: introduce PERL_TEST_HELPERS prerequisite
 7:  98961b0e065 =  7:  e7413bf28ae t: adapt existing PERL prerequisites
 8:  bbdd1fe6c7c =  8:  581a9bedd22 meson: stop requiring Perl when tests are enabled
 9:  bda7e7922ce =  9:  cfe1797ae74 Makefile: stop requiring Perl when running tests
10:  d95d50c4b73 = 10:  99e678b83a6 t: refactor tests depending on Perl transliteration operator
11:  f5b30cc3f8f ! 11:  93a98d3e3cf t: refactor tests depending on Perl substitution operator
    @@ t/t4029-diff-trailing-space.sh: test_expect_success PERL_TEST_HELPERS "$test_des
      	git diff f > actual &&
      	test_cmp exp actual &&
     -	perl -i.bak -p -e "s/^\$/ /" exp &&
    -+	sed "s/^\$/ /" <exp >exp.munged &&
    ++	sed "s/^\$/ /" exp >exp.munged &&
     +	mv exp.munged exp &&
      	git config --bool diff.suppressBlankEmpty false &&
      	git diff f > actual &&
    @@ t/t4200-rerere.sh: test_expect_success 'activate rerere, old style (conflicting
      	test_must_fail git merge first &&
      
     -	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
    -+	sha1=$(sed "s/	.*//" <.git/MERGE_RR) &&
    ++	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
      	rr=.git/rr-cache/$sha1 &&
      	grep "^=======\$" $rr/preimage &&
      	! test -f $rr/postimage &&
    @@ t/t4200-rerere.sh: test_expect_success 'rerere.enabled works, too' '
      	test_must_fail git merge first &&
      
     -	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
    -+	sha1=$(sed "s/	.*//" <.git/MERGE_RR) &&
    ++	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
      	rr=.git/rr-cache/$sha1 &&
      	grep ^=======$ $rr/preimage
      '
    @@ t/t4200-rerere.sh: test_expect_success 'set up rr-cache' '
      	git reset --hard &&
      	test_must_fail git merge first &&
     -	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
    -+	sha1=$(sed "s/	.*//" <.git/MERGE_RR) &&
    ++	sha1=$(sed "s/	.*//" .git/MERGE_RR) &&
      	rr=.git/rr-cache/$sha1
      '
      
    @@ t/t5303-pack-corruption-resilience.sh: test_expect_success '... and loose copy o
      	git prune-packed &&
      	chmod +w ${pack}.pack &&
     -	perl -i.bak -pe "s/ base /abcdef/" ${pack}.pack &&
    -+	sed "s/ base /abcdef/" <${pack}.pack >${pack}.pack.munged &&
    ++	sed "s/ base /abcdef/" ${pack}.pack >${pack}.pack.munged &&
     +	mv ${pack}.pack.munged ${pack}.pack &&
      	test_must_fail git cat-file blob $blob_1 > /dev/null &&
      	test_must_fail git cat-file blob $blob_2 > /dev/null &&
    @@ t/t5303-pack-corruption-resilience.sh: test_expect_success '... and then a repac
      	git prune-packed &&
      	chmod +w ${pack}.pack &&
     -	perl -i.bak -pe "s/ delta1 /abcdefgh/" ${pack}.pack &&
    -+	sed "s/ delta1 /abcdefgh/" <${pack}.pack >${pack}.pack.munged &&
    ++	sed "s/ delta1 /abcdefgh/" ${pack}.pack >${pack}.pack.munged &&
     +	mv ${pack}.pack.munged ${pack}.pack &&
      	git cat-file blob $blob_1 > /dev/null &&
      	test_must_fail git cat-file blob $blob_2 > /dev/null &&
    @@ t/t5310-pack-bitmaps.sh: test_bitmap_cases () {
      			# mark the commits which did not receive bitmaps as preferred,
      			# and generate the bitmap again
     -			perl -pe "s{^}{create refs/tags/include/$. }" <before |
    -+			sed "s|\(.*\)|create refs/tags/include/\1 \1|" <before |
    ++			sed "s|\(.*\)|create refs/tags/include/\1 \1|" before |
      				git update-ref --stdin &&
      			git -c pack.preferBitmapTips=refs/tags/include repack -adb &&
      
    @@ t/t5534-push-signed.sh: test_expect_success GPG,PERL_TEST_HELPERS 'inconsistent
      	# different, then replay it on a fresh dst, checking that ff is not
      	# deleted.
     -	perl -pe "s/([^ ])bar/\$1baz/" push >push.tweak &&
    -+	sed "s/\([^ ]\)bar/\1baz/" <push >push.tweak &&
    ++	sed "s/\([^ ]\)bar/\1baz/" push >push.tweak &&
      	prepare_dst &&
      	git -C dst config receive.certnonceseed sekrit &&
      	git -C dst config receive.advertisepushoptions 1 &&
    @@ t/t6011-rev-list-with-bad-commit.sh: test_expect_success 'verify number of revis
     +test_expect_success 'corrupt second commit object' '
     +	for p in .git/objects/pack/*.pack
     +	do
    -+		sed "s/second commit/socond commit/" <"$p" >"$p.munged" &&
    ++		sed "s/second commit/socond commit/" "$p" >"$p.munged" &&
     +		mv "$p.munged" "$p" ||
     +		return 1
     +	done &&
    @@ t/t7416-submodule-dash-url.sh: test_expect_success 'fsck accepts protected dash'
      
      test_expect_success 'remove ./ protection from .gitmodules url' '
     -	perl -i -pe "s{\./}{}" .gitmodules &&
    -+	sed "s|\./||" <.gitmodules >.gitmodules.munged &&
    ++	sed "s|\./||" .gitmodules >.gitmodules.munged &&
     +	mv .gitmodules.munged .gitmodules &&
      	git commit -am "drop protection"
      '
    @@ t/t8006-blame-textconv.sh: find_blame() {
      #!/bin/sh
      grep -q '^bin: ' "$1" || { echo "E: $1 is not \"binary\" file" 1>&2; exit 1; }
     -"$PERL_PATH" -p -e 's/^bin: /converted: /' "$1"
    -+sed 's/^bin: /converted: /' <"$1"
    ++sed 's/^bin: /converted: /' "$1"
      EOF
      chmod +x helper
      
    @@ t/t9137-git-svn-dcommit-clobber-series.sh: test_expect_success 'initialize repo'
      	(cd tmp &&
     -		perl -i.bak -p -e "s/^58$/5588/" file &&
     -		perl -i.bak -p -e "s/^61$/6611/" file &&
    -+		sed -e "s/^58$/5588/" -e "s/^61$/6611/" <file >file.munged &&
    ++		sed -e "s/^58$/5588/" -e "s/^61$/6611/" file >file.munged &&
     +		mv file.munged file &&
      		poke file &&
      		test x"$(sed -n -e 58p < file)" = x5588 &&
    @@ t/t9137-git-svn-dcommit-clobber-series.sh: test_expect_success 'some unrelated c
     -	perl -i.bak -p -e 's/^7\$/7777/' file &&
     +	sed -e 's/^4\$/4444/' \
     +	    -e 's/^7\$/7777/' \
    -+		<file >file.munged &&
    ++		file >file.munged &&
     +	mv file.munged file &&
      	test x\"\$(sed -n -e 4p < file)\" = x4444 &&
      	test x\"\$(sed -n -e 7p < file)\" = x7777 &&
12:  e978d8ecfde ! 12:  17f862eaba3 t: refactor tests depending on Perl to print data
    @@ t/t5300-pack-object.sh: test_expect_success 'pack-object <stdin parsing: --stdin
      # e.g.: check_deltas stderr -gt 0
      check_deltas() {
     -	deltas=$(perl -lne '/delta (\d+)/ and print $1' "$1") &&
    -+	deltas=$(sed -n 's/Total [0-9][0-9]* (delta \([0-9][0-9]*\)).*/\1/p' <"$1") &&
    ++	deltas=$(sed -n 's/Total [0-9][0-9]* (delta \([0-9][0-9]*\)).*/\1/p' "$1") &&
      	shift &&
      	if ! test "$deltas" "$@"
      	then
    @@ t/t5326-multi-pack-bitmaps.sh: test_midx_bitmap_cases () {
      
     -			perl -ne "printf(\"create refs/tags/include/%d \", $.); print" \
     -				<before | git update-ref --stdin &&
    -+			sed "s|\(.*\)|create refs/tags/include/\1 \1|" <before |
    ++			sed "s|\(.*\)|create refs/tags/include/\1 \1|" before |
     +			git update-ref --stdin &&
      
      			rm -fr $midx-$(midx_checksum $objdir).bitmap &&
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_pseudo_merges_reused () {
     -	perl -lne '
     -		print "create refs/tags/" . $. . " " . $1 if /([0-9a-f]+)/
     -	' <in | git update-ref --stdin
    -+	sed 's|\(.*\)|create refs/tags/\1 \1|' <in |
    ++	sed 's|\(.*\)|create refs/tags/\1 \1|' in |
     +	git update-ref --stdin
      }
      
    @@ t/t5333-pseudo-merge-bitmaps.sh: test_expect_success 'pseudo-merge pattern with
      			git rev-list HEAD~16.. >in &&
     -
     -			perl -lne "print \"create refs/remotes/$r/tags/\$. \$_\"" <in |
    -+			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" <in |
    ++			sed "s|\(.*\)|create refs/remotes/$r/tags/\1 \1" in |
      			git update-ref --stdin || return 1
      		done &&
      
    @@ t/t8002-blame.sh: test_expect_success 'set up abbrev tests' '
      		echo $sha1 | cut -c 1-$expect >expect &&
      		git blame "$@" abbrev.t >actual &&
     -		perl -lne "/[0-9a-f]+/ and print \$&" <actual >actual.sha &&
    -+		sed -n "s/^[\^]\{0,1\}\([0-9a-f][0-9a-f]*\).*/\1/p" <actual >actual.sha &&
    ++		sed -n "s/^[\^]\{0,1\}\([0-9a-f][0-9a-f]*\).*/\1/p" actual >actual.sha &&
      		test_cmp expect actual.sha
      	}
      '
13:  905c25c9fb2 = 13:  7b03d096ccd t: refactor tests depending on Perl for textconv scripts
14:  1fe67bba30f = 14:  195c0bf2445 t/lib-gpg: refactor `sanitize_pgp()` to not depend on Perl
15:  9e572c3ba67 = 15:  e92d178b96b t/lib-t6000: refactor `name_from_description()` to not depend on Perl
16:  24abcffe96e ! 16:  0f2c9ad276b t/lib-httpd: refactor "one-time-perl" CGI script to not depend on Perl
    @@ t/t5537-fetch-shallow.sh: test_expect_success PERL_TEST_HELPERS 'shallow fetches
     -	       "$(git -C "$REPO" rev-parse HEAD^)" \
     -	       >"$HTTPD_ROOT_PATH/one-time-perl" &&
     +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF &&
    -+	sed "$(printf "$(test_oid perl)" "$(git -C "$REPO" rev-parse HEAD)" "$(git -C "$REPO" rev-parse HEAD^)")" <"\$1"
    ++	sed "$(printf "$(test_oid perl)" "$(git -C "$REPO" rev-parse HEAD)" "$(git -C "$REPO" rev-parse HEAD^)")" "\$1"
     +	EOF
      	test_must_fail env GIT_TEST_SIDEBAND_ALL=0 git -C client \
     -		fetch --depth=1 "$HTTPD_URL/one_time_perl/repo" \
    @@ t/t5616-partial-clone.sh: intersperse () {
     +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF
     +	if grep packfile "\$1" >/dev/null
     +	then
    -+		sed '/packfile/q' <"\$1" &&
    ++		sed '/packfile/q' "\$1" &&
     +		# The protocol requires that the packfile be sent in sideband
     +		# 1, hence the extra \001 byte at the beginning.
     +		printf "%04x\001" \$((\$(wc -c <"$PWD/one-time-pack") + 5)) &&
    @@ t/t5702-protocol-v2.sh: test_expect_success PERL_TEST_HELPERS 'when server sends
     -	printf "\$ready = 1 if /ready/; \$ready && s/0001/0000/" \
     -		>"$HTTPD_ROOT_PATH/one-time-perl" &&
     +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
    -+	sed "/ready/{n;s/0001/0000/;}" <"$1"
    ++	sed "/ready/{n;s/0001/0000/;}" "$1"
     +	EOF
      
      	test_must_fail git -C http_child -c protocol.version=2 \
    @@ t/t5702-protocol-v2.sh: test_expect_success PERL_TEST_HELPERS 'when server does
     -	printf "\$ack = 1 if /acknowledgments/; \$ack && s/0000/0001/" \
     -		>"$HTTPD_ROOT_PATH/one-time-perl" &&
     +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
    -+	sed "/acknowledgments/,//{s/0000/0001/;}" <"$1"
    ++	sed "/acknowledgments/,//{s/0000/0001/;}" "$1"
     +	EOF
      
      	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
    @@ t/t5702-protocol-v2.sh: test_expect_success 'http:// --negotiate-only' '
     -	echo "s/ wait-for-done/ xxxx-xxx-xxxx/" \
     -		>"$HTTPD_ROOT_PATH/one-time-perl" &&
     +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
    -+	sed "s/ wait-for-done/ xxxx-xxx-xxxx/" <"$1"
    ++	sed "s/ wait-for-done/ xxxx-xxx-xxxx/" "$1"
     +	EOF
      
      	test_must_fail git -c protocol.version=2 -C client fetch \
    @@ t/t5703-upload-pack-ref-in-want.sh: inconsistency () {
      	oid2=$(git -C "$REPO" rev-parse $2) &&
     -	echo "s/$oid1/$oid2/" >"$HTTPD_ROOT_PATH/one-time-perl"
     +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-EOF
    -+	sed "s/$oid1/$oid2/" <"\$1"
    ++	sed "s/$oid1/$oid2/" "\$1"
     +	EOF
      }
      
    @@ t/t5703-upload-pack-ref-in-want.sh: test_expect_success 'server loses a ref - re
      	cp -r "$LOCAL_PRISTINE" local &&
     -	echo "s/main/rain/" >"$HTTPD_ROOT_PATH/one-time-perl" &&
     +	write_script "$HTTPD_ROOT_PATH/one-time-script" <<-\EOF &&
    -+	sed "s/main/rain/" <"$1"
    ++	sed "s/main/rain/" "$1"
     +	EOF
      	test_must_fail git -C local fetch 2>err &&
      
17:  ce5adbd4818 = 17:  9857b461ed6 t0021: refactor `generate_random_characters()` to not depend on Perl
18:  e183c397da9 = 18:  7924b5bd9bf t0210: refactor trace2 scrubbing to not use Perl
19:  156bdc4d62d = 19:  5d6996a1412 t5316: refactor `max_chain()` to not depend on Perl
20:  3b181d0a203 = 20:  0c3afb70128 t5703: refactor test to not depend on Perl

---
base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250317-b4-pks-t-perlless-138cf94696b8

