Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109D20C019
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463336; cv=none; b=K7KwS+95dxATOn6oEp1zpGsdcqWSj0xcXbQRGzEf0EmVBfrvAJUuTj/77lLeJiOlB+9rrWpO07BPCDYz48NbqKdP855inllXU5qh0aPIAccqnHZV43xkwW3TaMIgmDHzWduShhioimaGNTjS2FJ3xdadJ/Jow1FPiYH3bE8PC7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463336; c=relaxed/simple;
	bh=d+5ewKi9u5vK3XT7fv2l3X5awZYlEAWVvdjPt+36Aj8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rddrEjUMjhuBbxY6nFI1zd0oasoJdvbsbWIMhou/vh0gLuAnBl333HGoBz1bzu2pJY7DVQtp6P7rDiEYaZg1WoVUW2EPBKvfHoCo56vmC/yUuzwayReKMRSQ0XI8V/pniLnNNvn9/FwiI3dUJpVQb+vlKhJJcuBTjDtzRYFVbRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FyFtQ1m7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BYC3lJ5t; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FyFtQ1m7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BYC3lJ5t"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 20FA32540099;
	Thu, 20 Mar 2025 05:35:33 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 20 Mar 2025 05:35:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm1; t=1742463332; x=1742549732; bh=roVvoYhom9
	6mcr9jMa9zTfSWFp+kqrdwSMu8KDARQSg=; b=FyFtQ1m7OR6bX7KLBiOpbz2q3d
	8gJTH/19viUUr6kUvMZQOrFuC1f8eusXL4LR2gxUTb6rUReYicTB8PfROpqemzvO
	EGy1ixunQ8PLiIxKOaT8mc8LVV+ouVfBcXF9eqomVuIDMX9+pDihxwKaovwNttVe
	xprw8Bq1rnjZR8IBvw7Z4VGiMqZh2C8VaoKeMw9RcX+OsIRRuarXMoWE6HacWho6
	jRs07mqFUoEG1JP2tEdCkbW73UlcuOA4CyTQAqfKRsIb34h6CxLANc4UaJjApuSR
	RjJrNiEiZ7puTpMkBntdtDyMWCSUAXy+DiD05X4K+syYXsI7o4t6HpHeDIXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1742463332; x=1742549732; bh=roVvoYhom96mcr9jMa9zTfSWFp+k
	qrdwSMu8KDARQSg=; b=BYC3lJ5t52DzwfAOQN+lFf87k8JeoRpfAxgMAXxG1SEX
	3pKLUd49JvuvtRGiOigcj+2go7n/zVZmO9mLuiCHnuaqNTRJ+5rKvALbFtp2ii02
	8UNKSnqAofqzVmAHBTtauNecvjV/JqpD58gQ7VgePGZKWU2b0mX//H6qjFBM6a0j
	zyYG76X2u1kN901H8/WeIi+Ib5m/FzI55w1NTN/P9AUV6mTlrea59AkU2Ra4rPqH
	ROaMCpiPNptaUONgv+VExQEYwELaN+NFEPMq58wLJBEr9lhpKaSJKTUFo4YEAxwR
	0AY85xbqjcs3vuA99A7+XGcmShCs6vtoqt7vpZtQIw==
X-ME-Sender: <xms:ZOHbZ4fOb4PX6qNRuBXCG46jewnKuQa-Rm43Dq1H2P5fwpLF73gg4g>
    <xme:ZOHbZ6NVkiiXRYLy2mQau1ZjuznM9pPELkh9AISVVAXpBqXLplQc2On_Xu7Dc9wqN
    -DkKgqDGtA2kjex8g>
X-ME-Received: <xmr:ZOHbZ5hA4wIVrctnt42P1grNAI2qSH_ZkJB3YDY9BJaiqMhQVhl6bPPAmLW05WY3-hgT1lWfogrxHbiFWTO11H4h9lihtCujdpaDECcjCzQ79so>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffufffkgggtgffvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeeuleejjeffleejjedtjeevgedtueejheehkeeugedt
    lefgleejffeuveelvdeugfenucffohhmrghinhephhhtthhpugdrshhhpdhhthhtphdqfh
    gvthgthhdqshhmrghrthdrshhhpdhhthhtphdqsggrtghkvghnugdqtghonhhtvghnthdq
    lhgvnhhgthhhrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:ZOHbZ998zgfA8hTNfDIaJkCj3qEOg9HXLkgZhFSKwieVKPHce8fYsQ>
    <xmx:ZOHbZ0tJ85IfOpHmkBbnUzxV-AscHk0KkCxTrNv9N9GejghSRwJ7FQ>
    <xmx:ZOHbZ0EzekH0vuKdAAPiRFdGseCp7OVNm6aTt1cXR6znGNulkOcGpg>
    <xmx:ZOHbZzPKnbsXk_oJoPEd4hHqu8JxDrYQt5JS9iUYpgTXVqfzUHQg9w>
    <xmx:ZOHbZ94UhPWuaYqB1rVvKXou-c1wcKVjyUUl40Y89ZZ4yRyJ75TIc8vN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:32 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id fb65d343 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/20] t: drop Perl as a mandatory prerequisite
Date: Thu, 20 Mar 2025 10:35:27 +0100
Message-Id: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF/h22cC/x3MTQ5AMBBA4avIrE2iVP1cRSyoKRNC0xGRiLtrL
 L/Few8IBSaBNnkg0MXCxx6h0gTsMuwzIU/RkGd5mRWqwlGjXwVP9BS2jURQFbV1jTaNGWuInQ/
 k+P6fXf++Hzt4SG5jAAAA
X-Change-ID: 20250317-b4-pks-t-perlless-138cf94696b8
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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


---
base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
change-id: 20250317-b4-pks-t-perlless-138cf94696b8

