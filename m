Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6575227
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656761; cv=none; b=jjpVzmYsiQhm+DX/hKMppQ5iAhPes4bOCB54yZYlNjZSQMTRFbEJI6niRgn4JfbO2NtlVbK5+df7RDRTJFFOpZatJX7+jwTp1EWcjMbbXhHEQxhB40aRjRJ/xQu+K2Uva4qa35I2R2y4cWlvZ7DkHQEaKcfra9Jz6JOIQe9Ty+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656761; c=relaxed/simple;
	bh=37M5i4h3eNQ3VlC3sALDGoFHuSiYlFrorh2fZhlpGug=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=sbGp6oWU0tJm2TujcoIkXQRVDZgnYNnnB+r9JUr04BdrS3ac6ws6KTcdr9y13tGQGeG9Sz/GTDqLI1L0MXavuhjjFhp1jZ2gR6w8LMvUf0sFbsxxsU7cHSAjTkov6an/Ix1nHv2slTadq286BxQyMl3vsDtIG0dssz+DhkFhX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Y9Dq4i/v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R4mGjQEs; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Y9Dq4i/v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R4mGjQEs"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 42133114019D;
	Thu,  3 Apr 2025 01:05:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 03 Apr 2025 01:05:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656757;
	 x=1743743157; bh=G8YVsJQfYX9ZwXSmFElCg9lL7Mt8tKL+YlQm8S5AlCE=; b=
	Y9Dq4i/vvp3S2+nQmJE00zAywvIqiDV3VXE9tTUV9gojeKSq3e1R6VItMfBmqfF1
	yjGhd9T7Jg4NJWcCExKUUdECTZdwVX5CG3GlM2X+BRF5XGJ74x1GMDsoB3ZYtSqx
	/C8bkSFGj8YBp4AeqTyVCtmMBbyN92NYyOMSFqqMAjYJ8WWt+G+nJ652ExFoISlp
	gZTyP9i/sEftiGSCFfcZWXIhIqZTD+kQl1D3qqGT+xhRRAncJk0jyHqpkLmkfHFM
	oVVIrELHK4AugjpHFlzqmsYvNCDyAkXiVe1esrxAf9nK1Bbscj9leNkGbHh1NglP
	bnfvyU69tG5ziyPda+Hv+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656757; x=
	1743743157; bh=G8YVsJQfYX9ZwXSmFElCg9lL7Mt8tKL+YlQm8S5AlCE=; b=R
	4mGjQEszJQIINdtW2rxQ7OikRxY4d+LnoJ2xNpc2J8why7F7dMuX9lu7HIiJD//6
	bpa6fDteSXH9ePM0cOtUuncKsv9ryuSJaF8F8ofsbrTXuYug5PwRk3JZS2R2p+OZ
	gxTeL6pUjIOxOlwggevfIllq8xhBhQcgwIZTNU7vkSK6GzCt+VeKuGW64K8pPy/D
	flP+mLuDsOzGT2mmAfLMJ6l0ezqfVrOGATmGCNfbsz1lsGpEXbSyqymIbrSofeJ3
	PXj+5zJPV5IK/bxHdujpEY918GHHrMNyUD0UFxnya5DEpsSlEmo+8NLjWGN5bjil
	kv8Ab7K6u42ci6kPlNgJw==
X-ME-Sender: <xms:NBfuZ9-2QV9E7X_zbsSa3m0-vBuR2CRWL3ZLdA2WdYv_aII2OW0W3w>
    <xme:NBfuZxtT0dgFBewxeU_JE5k-WtwRHh0icNoOGuS-0uhINpa7hzr94CNxLzElTLZXo
    5gYpA-R9Fx__A-EkQ>
X-ME-Received: <xmr:NBfuZ7D8DmBmcudQ9TGc4LEjefrvivPZ96Z3pvh3X0OO4903yBr4Cn3p4xWMnqashaCUVOSij0Is6AAPfhGbm7j4Be_tSAPBWyJSJ1fRJOXxRO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeeltdekffduvdeiheeuueetffelkedthfeiieff
    geeileefkeehheefjeeuhfevieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhhth
    htphgurdhshhdphhhtthhpqdhfvghttghhqdhsmhgrrhhtrdhshhdphhhtthhpqdgsrggt
    khgvnhguqdgtohhnthgvnhhtqdhlvghnghhthhdrshhhnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfi
    hoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhu
    nhhshhhinhgvtghordgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehg
    mhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NBfuZxcjizQbZzV_rZ1b1DnWHsIf6sCPSKXJeSniHIqrnosDwYtXaw>
    <xmx:NBfuZyNfPOh3y3tzafftB6BFHuWa0Vg9nIkD6DLuT8qeXdtsxW2qnA>
    <xmx:NBfuZzmQWK71_Kqdj0XELd3SS_MJsOPArtDolz5jCpKSbY4vhV71NA>
    <xmx:NBfuZ8svcqIoakFywohBIUmQ4GoRvl3CehAIo9vqXbEWbi66xjQZyg>
    <xmx:NRfuZ1AgItrIii5rZO4_FLddZVbSRmxXajD_wYv44HSCUjXf1zm-Le1p>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:05:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 11c719f8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:05:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 00/20] t: drop Perl as a mandatory prerequisite
Date: Thu, 03 Apr 2025 07:05:51 +0200
Message-Id: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC8X7mcC/22PywqDMBBFf0Wybkreia76H6ULo2MNtSqJhBbx3
 xulFAsu72XOucyMAngHARXZjDxEF9zQpyBOGarasr8DdnXKiBEmCacaW4HHR8ATHsF3HYSAKTd
 VkwuVK2tQ4kYPjXttzust5daFafDvbSLStf3aGDmwRYpTTQEaYLqspLykg7N7olUV2R6XRzhLu
 LBGW0M0U5r84XyPH/0S+bouuKohr0tqzQ9fluUD/7N87C0BAAA=
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

Changes in v4:
  - Improve a couple of commit messages to better explain the changes.
  - Link to v3: https://lore.kernel.org/r/20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im

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

Range-diff versus v3:

 1:  9a500263cea =  1:  cd553f570b7 t: skip chain lint when PERL_PATH is unset
 2:  3cc409f35ab =  2:  bd2b95c2fa5 t: refactor environment sanitization to not use Perl
 3:  46bba778281 =  3:  81b99adaf5b t: adapt character translation helpers to not use Perl
 4:  72f65ee6f3d =  4:  ef624217370 t: adapt `test_copy_bytes()` to not use Perl
 5:  57b4e5e0b2c =  5:  4e6c4b654f5 t: adapt `test_readlink()` to not use Perl
 6:  61230a9f7e5 !  6:  cbefcec77f9 t: introduce PERL_TEST_HELPERS prerequisite
    @@ Commit message
     
           - git-send-email(1), which can be used to send mails.
     
    +      - git-request-pull(1), which is used to request somebody to pull from
    +        a URL by sending an email.
    +
    +      - git-filter-branch(1), which uses Perl with the `--state-branch`
    +        option. This command is typically recommended against nowadays in
    +        favor of git-filter-repo(1).
    +
           - Our Perl bindings for Git.
     
           - The netrc Git credential helper.
 7:  37a944f2295 =  7:  8d08fe26be3 t: adapt existing PERL prerequisites
 8:  58513ff9510 =  8:  c4451024f2d meson: stop requiring Perl when tests are enabled
 9:  68cdf732fe7 =  9:  2d3c3d10c00 Makefile: stop requiring Perl when running tests
10:  acba0e69f8f = 10:  25737787f61 t: refactor tests depending on Perl transliteration operator
11:  888b283db98 ! 11:  863e029c0d3 t: refactor tests depending on Perl substitution operator
    @@ Commit message
         t: refactor tests depending on Perl substitution operator
     
         We have a bunch of tests that use Perl to perform substitution via the
    -    "s/" operator. These usecases can be trivially replaced with sed(1).
    +    "s/" operator. These usecases can be trivially replaced with sed(1) and
    +    tr(1).
     
         Refactor the tests accordingly so that we can drop a couple of
         PERL_TEST_HELPERS prerequisites.
12:  e2fbbad39e3 ! 12:  ba13f633705 t: refactor tests depending on Perl to print data
    @@ Commit message
             use a combination of `test-tool genzeros` and sed(1).
     
           - Print data in reverse. These usecases can be converted to use
    -        awk(1).
    +        awk(1) or `sort -r`.
     
         Refactor the tests accordingly so that we can drop a couple of
         PERL_TEST_HELPERS prerequisites.
13:  12950479b79 ! 13:  80bda885e4d t: refactor tests depending on Perl for textconv scripts
    @@ Commit message
         Refactor these tests to instead be implemented via shell utilities so
         that we can drop a couple of PERL_TEST_HELPERS prerequisites.
     
    -    Note that not all of the conversions are a one-to-one equivalent to the
    -    previous textconv scripts. But that's not really needed in the first
    -    place: we only care that the textconv script does something, and that
    -    can be verified trivially without having a full-blown invocation of
    -    hexdump. So at times, the implementation of the textconv scripts is
    -    reduced to their bare minimum and the expectations of those tests are
    -    adapted accordingly.
    +    Note that the conversion in t4030 is not a one-to-one equivalent to the
    +    previous textconv script. Before this change we used to essentially do a
    +    hexdump via Perl. The obvious conversion here would be to use `test-tool
    +    hexdump` like we do for the other tests. But this would lead to a ripple
    +    effect where we would have to adapt a bunch of other tests with a bunch
    +    of seemingly unrelated changes, which would be somewhat awkward.
    +
    +    Instead, we're going with the minimum viable change: the test files we
    +    write contain "\001" and "\000", and the test's expectation is that
    +    those get translated into proper ASCII characters. So instead of doing a
    +    full hexdump, we simply use tr(1) to translate these specific bytes.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
14:  e3fe9e7292f ! 14:  da8e5e89029 t/lib-gpg: refactor `sanitize_pgp()` to not depend on Perl
    @@ Commit message
         t/lib-gpg: refactor `sanitize_pgp()` to not depend on Perl
     
         The `sanitize_pgp()` test helper uses Perl to strip PGP signatures from
    -    stdin. Refactor it to instead use awk(1) so that we drop the
    +    stdin. Refactor it to instead use sed(1) so that we drop the
         PERL_TEST_HELPERS prerequisite in users of this library.
     
         Note that we have to add PERL_TEST_HELPERS to a subset of tests in t6300
15:  8c180723c5d = 15:  98afe2b4f71 t/lib-t6000: refactor `name_from_description()` to not depend on Perl
16:  9e5d5fc4d57 = 16:  a7d26d221cb t/lib-httpd: refactor "one-time-perl" CGI script to not depend on Perl
17:  4e5431788b0 = 17:  4b36ae2a602 t0021: refactor `generate_random_characters()` to not depend on Perl
18:  f7fd16661ca = 18:  27c720a3952 t0210: refactor trace2 scrubbing to not use Perl
19:  ee8d1bed611 = 19:  e08ed2f2c64 t5316: refactor `max_chain()` to not depend on Perl
20:  740009a2d0c = 20:  710158c13a7 t5703: refactor test to not depend on Perl

---
base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250317-b4-pks-t-perlless-138cf94696b8

