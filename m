Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C9125EF8D
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908467; cv=none; b=unfbTCFKhAfDzVgTHp8GMMzvCTKvUgsBlWDA3MC5lpXjRZRwpT16TmUOexGmD6R8NYZRf2Ot8qp2HoteYUI18rSgO+098VOpJUt2aUZETMTRO3oORmnXP87i56uFXIoe2lwqu+p5lEWf/V/ztV15w/iwfbhXbHZEbgFS6ZLhoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908467; c=relaxed/simple;
	bh=NYdQ4gGHNml5Skpga0bCJB/t/XvVwSCBhbLlJK2wg+w=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=rC3v1KIjrk/306r+T70AFvNmj8Cpcjq7jQXzucj+d5pSlhUR+JrIvgPU4IatagmlccpLTwYHrIivqqstC2ulhS8CwzzWO1O76A+pIAhMau9vowq0r/VH3iCV+pmxFWTN4UdJQ2liH1F5CFj9dXQBR0J6HEs3aAd1eLgl2PUGCr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fklnI+xa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b+uLEqMQ; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fklnI+xa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b+uLEqMQ"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 267B7114028E;
	Tue, 25 Mar 2025 09:14:24 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 09:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908464;
	 x=1742994864; bh=HvxIarNnm+ZkCRqTMML+PFf2KaMid1qipTwHcTZUdqo=; b=
	fklnI+xaCYPhLI8V7SiS/9zwOVEKpnku+I3j+v3HZr7A4jbmjTDDWMPsFyXoa6fQ
	Yrz/41aXIxZB66Gsj6Zun/cKe0dVnQqwwjw7bSFmGIazwCd3pvA7gNfayp1r/C15
	M8wNYDl3Z4t2OUpALE8fxHrhHIXf5J+a6x2X6LgkcrHyZLwVaBzajjMaJQvjWZIL
	BtqzYbn1ryCaDfLE2i+JuSiwKEuRqwdEWx2rg2RgTnz0Qmp1jmzoEeHa677x38G3
	HsyEoml9VWeTJhpXitLPTrNVXJMOh0jz+VBWPsd6GJZZDteGq6dHtNs2sNEDXCgl
	Z95JzS909io3ri1QqSVNDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908464; x=
	1742994864; bh=HvxIarNnm+ZkCRqTMML+PFf2KaMid1qipTwHcTZUdqo=; b=b
	+uLEqMQl/i5S4Dc0fmEjpvm1D5O12BTKFA+Xau/DsPsU6EBMzQboVj9kDSuo+dEv
	wobIJoB0rcCOe69Gxf+iC6uzbD0gv/PvO6bPqqTbq1psLevRikys9N/RYGJX+P+S
	zBHmRuno4PlAkSh80WXQS8fY98p//r60pZMPji1EmLLHyvCgSOaNmmlYcBO4f7AL
	ykNzIucUOku2D+lCLNOJggwycIk0iEp+3sPxTQAM0RzyxlNNbXMR92YVKbHtL1aU
	EU+Q+9i2GHcPJKZ9yUyyZqUPTO5PGWAba99k3HAv0yyDULq3T9+JdqLYXol5gEMb
	OwsG7KLb7XG0IirSvPPBg==
X-ME-Sender: <xms:L6ziZ8M2beX2QxRlOVdXCqecfPIfXalYneNZtxJCyp8LWjMeOxRU5g>
    <xme:L6ziZy-fbazlGvpfnSJRtBgpeFJcc7nk94QeZh6z_aA4DW5KWFAG8CkB7EyPBqRew
    QmKzkVHyv7VJdo1-w>
X-ME-Received: <xmr:L6ziZzRZZWDDr5LftHBuBo1C9kPeIpCmJASm7kLOjVUUQsRHj_CKg2Gp_oOfDjkfy1UGpt6vEIX2cfKV6apj_vJJd-tOIOOrWOrMJ-n--mkQvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgfgjfhfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeeltdekffduvdeiheeuueetffelkedthfeiieff
    geeileefkeehheefjeeuhfevieenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhhth
    htphgurdhshhdphhhtthhpqdhfvghttghhqdhsmhgrrhhtrdhshhdphhhtthhpqdgsrggt
    khgvnhguqdgtohhnthgvnhhtqdhlvghnghhthhdrshhhnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:L6ziZ0sfH7KGlVPzsoEmGPhTYukGFdZMU_RbxebLSkYlbWv-M794yg>
    <xmx:L6ziZ0d5xezA4_dMipOZSR-2kruYIVspLlZn7fmSMEVH1Mefrd6zSQ>
    <xmx:L6ziZ40JZRvdTYJiyx7Ft7vGAThS6Rs8ATimNxDOgz-7JjDTQOOLlQ>
    <xmx:L6ziZ49QM_fKcvn7LOVR1LX_w5q7eV2PT8LaU9rIMBQYzqJcx0FZvw>
    <xmx:MKziZ5FeYZt4kijeGLu8s3VakBMygMWNZs_Ih9zU1SD8hAkky7jJ1eYh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ddcb491 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/20] t: drop Perl as a mandatory prerequisite
Date: Tue, 25 Mar 2025 14:14:18 +0100
Message-Id: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACqs4mcC/22NSw6CQBBEr0J6bRtm+LPyHoYFjI10RJhME6Ih3
 N2WuHT5KlWvNhAKTAJ1tEGglYXnScGeInBDO90J+aYMNrZZnJgCuxT9Q3BBT2EcSQRNUrq+SvM
 q70rQnQ/U8+twXhvlgWWZw/u4WM03/dls/Me2GtTYEPVki9Zl2UULZ35Cs+/7B8Oejm2vAAAA
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

Range-diff versus v1:

 1:  83596f2aa05 !  1:  658a45496a3 t: skip chain lint when PERL_PATH is unset
    @@ Metadata
      ## Commit message ##
         t: skip chain lint when PERL_PATH is unset
     
    -    Our chainlint scripts verify that test files have proper '&&' chains.
    -    These scripts are written in Perl and are executed for every test file
    -    before executing the test logic itself.
    +    Our chainlint script verifies that test files have proper '&&' chains.
    +    This script is written in Perl and executed for every test file before
    +    executing the test logic itself.
     
         In subsequent commits we're about to refactor our test suite so that
         Perl becomes an optional dependency, only. And while it is already
 2:  67e9859721d =  2:  12a618f141a t: refactor environment sanitization to not use Perl
 3:  6ebfa6a8581 =  3:  37b5ee501c7 t: adapt character translation helpers to not use Perl
 4:  01e9fce3751 =  4:  df0e1185b3b t: adapt `test_copy_bytes()` to not use Perl
 5:  1f291160713 =  5:  badfad15e0c t: adapt `test_readlink()` to not use Perl
 6:  ab15650ca76 !  6:  ae30c6a1524 t: introduce PERL_TEST_HELPERS prerequisite
    @@ t/t4103-apply-binary.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
     +if ! test_have_prereq PERL_TEST_HELPERS
     +then
    -+	skip_all='skipping ignores tests; Perl not available'
    ++	skip_all='skipping apply-binary tests; Perl not available'
     +	test_done
     +fi
     +
 7:  d278b3c6d90 =  7:  8084db771c1 t: adapt existing PERL prerequisites
 8:  bb8b13b2669 =  8:  87b58043c59 meson: stop requiring Perl when tests are enabled
 9:  6b2a77c2dc4 =  9:  b9831e97fca Makefile: stop requiring Perl when running tests
10:  0af780a491b ! 10:  4b3a4f5a1e5 t: refactor tests depending on Perl transliteration operator
    @@ t/t4103-apply-binary.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
      
     -if ! test_have_prereq PERL_TEST_HELPERS
     -then
    --	skip_all='skipping ignores tests; Perl not available'
    +-	skip_all='skipping apply-binary tests; Perl not available'
     -	test_done
     -fi
     -
11:  c57d1a1dc14 ! 11:  20ccdb34dc8 t: refactor tests depending on Perl substitution operator
    @@ t/t0008-ignores.sh: test_stderr () {
      
      broken_c_unquote () {
     -	"$PERL_PATH" -pe 's/^"//; s/\\//; s/"$//; tr/\n/\0/' "$@"
    -+	<"$1" sed -e 's/^"//' -e 's/\\//' -e 's/"$//' | tr '\n' '\0'
    ++	sed -e 's/^"//' -e 's/\\//' -e 's/"$//' "$1" | tr '\n' '\0'
      }
      
      broken_c_unquote_verbose () {
     -	"$PERL_PATH" -pe 's/	"/	/; s/\\//; s/"$//; tr/:\t\n/\0/' "$@"
    -+	<"$1" sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' | tr ':\t\n' '\000'
    ++	sed -e 's/	"/	/' -e 's/\\//' -e 's/"$//' "$1" | tr ':\t\n' '\000'
      }
      
      stderr_contains () {
12:  4cf1615b49a ! 12:  a6c15a4b619 t: refactor tests depending on Perl to print data
    @@ t/t0610-reftable-basics.sh: test_expect_success 'basic: commit and list refs' '
     -		print \"this is a long commit message\" x 50000
     -	" >commit-msg &&
     +
    -+	awk "BEGIN { for (i = 0; i < 50000; i++) print \"this is a long commit message\" }" >commit-msg &&
    ++	awk "BEGIN { for (i = 0; i < 50000; i++) printf \"%s\", \"this is a long commit message\" }" >commit-msg &&
      	git -C repo commit --allow-empty --file=../commit-msg
      '
      
13:  de36109ff9f ! 13:  4e6c4c88d4c t: refactor tests depending on Perl for textconv scripts
    @@ Commit message
         place: we only care that the textconv script does something, and that
         can be verified trivially without having a full-blown invocation of
         hexdump. So at times, the implementation of the textconv scripts is
    -    reduced to their bare minimum.
    +    reduced to their bare minimum and the expectations of those tests are
    +    adapted accordingly.
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
14:  ac0537394ab = 14:  28d6a862403 t/lib-gpg: refactor `sanitize_pgp()` to not depend on Perl
15:  96486f46150 ! 15:  17fbc84e23c t/lib-t6000: refactor `name_from_description()` to not depend on Perl
    @@ t/lib-t6000.sh: check_output () {
     +		-e 's/[^A-Za-z0-9.]/-/g' \
     +		-e 's/--*/-/g' \
     +		-e 's/-$//' \
    -+		-e 's/^-//' |
    -+	tr 'A-Z' 'a-z'
    ++		-e 's/^-//' \
    ++		-e 'y/A-Z/a-z/'
      }
      
      
16:  2b418ae8d8f = 16:  de58d23e7ab t/lib-httpd: refactor "one-time-perl" CGI script to not depend on Perl
17:  8eb9b127db6 = 17:  517094e41a6 t0021: refactor `generate_random_characters()` to not depend on Perl
18:  8d0e583f741 = 18:  0eecfc633bd t0210: refactor trace2 scrubbing to not use Perl
19:  7c5dc0d66b1 = 19:  8a2b080c949 t5316: refactor `max_chain()` to not depend on Perl
20:  8a35ab947b5 = 20:  118b00003ea t5703: refactor test to not depend on Perl

---
base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250317-b4-pks-t-perlless-138cf94696b8

