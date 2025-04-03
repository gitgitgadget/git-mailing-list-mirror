Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AC119E994
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656772; cv=none; b=DVlaLcjciIbgYYfYhR+KaKHGPOAWjJOmnuREeDFhC+dKFbXh50Gnqe5pJm2VESIQzhuYWfBXez2cbedozEM/lVqaAAhKoXl1k59Gb3GkZQNdPf++3+DGJPcLJIYMoeM3IoSUYKH9GoehmQb8yqF0brsCe0Wd2FU9tdC1MG4Om6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656772; c=relaxed/simple;
	bh=re7v3UERdb+eyaeo/x6QC6k1lR/98JROs2yLNe6Yx38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WRztBswqVsmqIa/lgjvv+yYIndYssd5Vk75yl80Ifn+AFxrH+1AHR2ZQG3gqkh3FpKIj4VCmKNojof//Csxf0dKqUx6MRivX+i7fLOBA02zrb2RS2hr8NV1sQ2JUGjG0PrrSLrkK+1GhhbyTOYDnBsSrgGlu4q11TbKhm377fY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LD0iyKpu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gkFkddlm; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LD0iyKpu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gkFkddlm"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6477325401D1;
	Thu,  3 Apr 2025 01:06:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 03 Apr 2025 01:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656767;
	 x=1743743167; bh=IQs8BHQGgBuO+0+bMoo+jiGP71HuGAS9jBBbt1w44f4=; b=
	LD0iyKpuPYkGJphD25r3OXGlxbhZRPW3ZSUbzH4ypDr6bxnRHk3Q/w/hA8P2w/QY
	IpFBS5ci2JSAHMJA3+VsDmV0Jxvzmbs/L2c2zmPKijwPbJY/UwyQpd0Guc9PF+c/
	VRlLwhexz8hWLL2BJbhCF9uaqovV62/dCeMfatU6B6/pTMiq5pDH+NJpTEszbYuL
	/5RXo00n9N2ZQFnA3qPiNnDpHluoxl4bhPtrhc6JGOvZ3zje82Qrpt8DFxHTZhNB
	ftLLRBDd24btlMEh8tjIWEptmWZhhTaMXtpgeaNxPIUgMLIJbh1vn8NAqXyYOJ5z
	T8zFKE4VsqKcuNQTuwuiOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656767; x=
	1743743167; bh=IQs8BHQGgBuO+0+bMoo+jiGP71HuGAS9jBBbt1w44f4=; b=g
	kFkddlm7/28bTsOJxy7qYKDHSPJQIkFWnFYW2uTTp3CLOoZlbgxA1SjoyXr0nYIs
	XZPSDnp+mpmGKs/NiAKDofAxP0ozpbI65NgXm92Qv+m4ZMT9rFtbAPqjmsWDQru8
	4MAY4EQdTsauIxmaKNkUfy56yFm+ODaiLKKYhrK5g5ZgQk6BwqKU/n/Y8Hp3iCcy
	GRskJvtDBu62Re1IcDT2uAP1OZBfJiqS6IE2o7QuU0WWxPdm822RyTlfCRvMJZ/m
	c803JufgCHNcUOpBAJpTPbGTr4gC1RPQf9gznPZoml1mle6fxg2a3xqOMKSZb67s
	2faCg+3TrNLD9LlqciyIw==
X-ME-Sender: <xms:PxfuZ1a2M5Hx3kzqMEco2w3uRFL04z373N4yyE7_oADSFwamuqVACA>
    <xme:PxfuZ8YCFDyoaAsZ8BSSUssZhgAbenujHwxLn73VMq7DAiJQHTGwyvKwLFQpuFshH
    A-2z5nhfsZYZyR6IA>
X-ME-Received: <xmr:PxfuZ39q68j_eyCRAatBBmwnlP5YWWpvUJEQdQA8kMM56cpMEm29GSguNm4MmOE1LwGoGebdqNT4-Y4KRt47ohLdh6tmaEsj_ESQ8pZg0W1LsRs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeduheffgfeugffgvdfglefgudekfeffvdevjedv
    vedugfehieeiudfgjeeiffehueenucffohhmrghinhephhhtthhpqdhfvghttghhqdhsmh
    grrhhtrdhshhdphhhtthhpqdgsrggtkhgvnhguqdgtohhnthgvnhhtqdhlvghnghhthhdr
    shhhpdhhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:PxfuZzre4aGOsqrVx3-ikwMSS25l2tNrG9XMvV0mqIScMFlOjaqjkA>
    <xmx:PxfuZwp_j0Dl9Ywhw3LLxgXogRaEuvqWKdkisRw3D0qhS_QVW6IXUA>
    <xmx:PxfuZ5SvWrNj6-uAvkckuY9ZMh5QlR_cIcCvQNVntR52Vo0-zlEEKQ>
    <xmx:PxfuZ4pLaX66wbuXxJpcnwbXjloRc9I2cb4Tn43xXybP4pl9ckRoWQ>
    <xmx:PxfuZ_MDoUhky6ZG6nFgnCcvQA9t30I80TUxx-szrvU44sMaL8kgaFzW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3f737b94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:05:57 +0200
Subject: [PATCH v4 06/20] t: introduce PERL_TEST_HELPERS prerequisite
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250403-b4-pks-t-perlless-v4-6-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In the early days of Git, Perl was used quite prominently throughout the
project. This has changed significantly as almost all of the executables
we ship nowadays have eventually been rewritten in C. Only a handful of
subsystems remain that require Perl:

  - gitweb, a read-only web interface.

  - A couple of scripts that allow importing repositories from GNU Arch,
    CVS and Subversion.

  - git-send-email(1), which can be used to send mails.

  - git-request-pull(1), which is used to request somebody to pull from
    a URL by sending an email.

  - git-filter-branch(1), which uses Perl with the `--state-branch`
    option. This command is typically recommended against nowadays in
    favor of git-filter-repo(1).

  - Our Perl bindings for Git.

  - The netrc Git credential helper.

None of these subsystems can really be considered to be part of the
"core" of Git, and an installation without them is fully functional.
It is more likely than not that an end user wouldn't even notice that
any features are missing if those tools weren't installed. But while
Perl nowadays very much is an optional dependency of Git, there is a
significant limitation when Perl isn't available: developers cannot run
our test suite.

Preceding commits have started to lift this restriction by removing the
strict dependency on Perl in many central parts of the test library. But
there are still many tests that rely on small Perl helpers to do various
different things.

Introduce a new PERL_TEST_HELPERS prerequisite that guards all tests
that require Perl. This prerequisite is explicitly different than the
preexisting PERL prerequisite:

  - PERL records whether or not features depending on the Perl
    interpreter are built.

  - PERL_TEST_HELPERS records whether or not a Perl interpreter is
    available for our tests.

By having these two separate prerequisites we can thus distinguish
between tests that inherently depend on Perl because the underlying
feature does, and those tests that depend on Perl because the test
itself is using Perl.

Adapt all tests to set the PERL_TEST_HELPERS prerequisite as needed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0008-ignores.sh                        |  6 ++++++
 t/t0021-conversion.sh                     |  4 ++--
 t/t0210-trace2-normal.sh                  |  6 ++++++
 t/t0211-trace2-perf.sh                    |  6 ++++++
 t/t0610-reftable-basics.sh                |  2 +-
 t/t0613-reftable-write-options.sh         |  2 +-
 t/t1006-cat-file.sh                       |  2 +-
 t/t1007-hash-object.sh                    |  6 +++---
 t/t1010-mktree.sh                         |  4 ++--
 t/t1450-fsck.sh                           |  6 +++---
 t/t3300-funny-names.sh                    |  6 +++---
 t/t4013-diff-various.sh                   |  6 ++++++
 t/t4014-format-patch.sh                   | 30 +++++++++++++++---------------
 t/t4020-diff-external.sh                  |  4 ++--
 t/t4029-diff-trailing-space.sh            |  2 +-
 t/t4030-diff-textconv.sh                  |  6 ++++++
 t/t4031-diff-rewrite-binary.sh            |  2 +-
 t/t4058-diff-duplicates.sh                |  6 ++++++
 t/t4103-apply-binary.sh                   |  6 ++++++
 t/t4116-apply-reverse.sh                  |  6 ++++++
 t/t4150-am.sh                             |  2 +-
 t/t4200-rerere.sh                         |  6 ++++++
 t/t4205-log-pretty-formats.sh             |  6 +++---
 t/t4216-log-bloom.sh                      |  8 ++++----
 t/t5004-archive-corner-cases.sh           |  6 ++++++
 t/t5300-pack-object.sh                    |  6 ++++++
 t/t5303-pack-corruption-resilience.sh     |  4 ++--
 t/t5310-pack-bitmaps.sh                   |  2 +-
 t/t5316-pack-delta-depth.sh               |  8 ++++----
 t/t5318-commit-graph.sh                   | 12 ++++++------
 t/t5319-multi-pack-index.sh               | 16 ++++++++--------
 t/t5324-split-commit-graph.sh             |  2 +-
 t/t5326-multi-pack-bitmaps.sh             |  2 +-
 t/t5328-commit-graph-64bit-time.sh        |  2 +-
 t/t5333-pseudo-merge-bitmaps.sh           |  6 ++++++
 t/t5400-send-pack.sh                      |  2 +-
 t/t5410-receive-pack-alternates.sh        |  4 ++--
 t/t5503-tagfollow.sh                      |  6 ++++++
 t/t5504-fetch-receive-strict.sh           |  2 +-
 t/t5510-fetch.sh                          |  6 ++++++
 t/t5532-fetch-proxy.sh                    |  6 ++++++
 t/t5534-push-signed.sh                    |  2 +-
 t/t5537-fetch-shallow.sh                  |  2 +-
 t/t5551-http-fetch-smart.sh               |  7 +++++++
 t/t5562-http-backend-content-length.sh    |  6 ++++++
 t/t5601-clone.sh                          |  4 ++--
 t/t5616-partial-clone.sh                  |  6 +++---
 t/t5701-git-serve.sh                      |  2 +-
 t/t5702-protocol-v2.sh                    |  6 +++---
 t/t5703-upload-pack-ref-in-want.sh        |  6 ++++++
 t/t5710-promisor-remote-capability.sh     |  6 ++++++
 t/t6002-rev-list-bisect.sh                |  6 ++++++
 t/t6003-rev-list-topo-order.sh            |  6 ++++++
 t/t6011-rev-list-with-bad-commit.sh       |  6 ++++++
 t/t6013-rev-list-reverse-parents.sh       |  4 ++--
 t/t6102-rev-list-unexpected-objects.sh    |  6 ++++++
 t/t6115-rev-list-du.sh                    |  6 ++++++
 t/t6300-for-each-ref.sh                   |  6 ++++++
 t/t7006-pager.sh                          |  2 +-
 t/t7416-submodule-dash-url.sh             |  6 ++++++
 t/t7508-status.sh                         |  2 +-
 t/t7815-grep-binary.sh                    |  6 ++++++
 t/t8001-annotate.sh                       |  6 ++++++
 t/t8002-blame.sh                          |  6 ++++++
 t/t8006-blame-textconv.sh                 |  6 ++++++
 t/t8011-blame-split-file.sh               |  6 +++---
 t/t8012-blame-colors.sh                   |  6 ++++++
 t/t9137-git-svn-dcommit-clobber-series.sh |  4 ++--
 t/t9350-fast-export.sh                    |  2 +-
 t/t9850-shell.sh                          |  2 +-
 t/test-lib.sh                             |  1 +
 71 files changed, 281 insertions(+), 93 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index c9376dffb58..1aaa6bf5ae8 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -5,6 +5,12 @@ test_description=check-ignore
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping ignores tests; Perl not available'
+	test_done
+fi
+
 init_vars () {
 	global_excludes="global-excludes"
 }
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 3f6433d3045..9c3738ebb3f 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -619,7 +619,7 @@ test_expect_success 'required process filter should be used only for "clean" ope
 	)
 '
 
-test_expect_success 'required process filter should process multiple packets' '
+test_expect_success PERL_TEST_HELPERS 'required process filter should process multiple packets' '
 	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 
@@ -684,7 +684,7 @@ test_expect_success 'required process filter should process multiple packets' '
 	)
 '
 
-test_expect_success 'required process filter with clean error should fail' '
+test_expect_success PERL_TEST_HELPERS 'required process filter with clean error should fail' '
 	test_config_global filter.protocol.process "test-tool rot13-filter --log=debug.log clean smudge" &&
 	test_config_global filter.protocol.required true &&
 	rm -rf repo &&
diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index 4287ed3fbb3..ba4c0442b85 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -4,6 +4,12 @@ test_description='test trace2 facility (normal target)'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping trace2 tests; Perl not available'
+	test_done
+fi
+
 # Turn off any inherited trace2 settings for this test.
 sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
 sane_unset GIT_TRACE2_BRIEF
diff --git a/t/t0211-trace2-perf.sh b/t/t0211-trace2-perf.sh
index bac90465406..760cf69087f 100755
--- a/t/t0211-trace2-perf.sh
+++ b/t/t0211-trace2-perf.sh
@@ -4,6 +4,12 @@ test_description='test trace2 facility (perf target)'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping trace2 tests; Perl not available'
+	test_done
+fi
+
 # Turn off any inherited trace2 settings for this test.
 sane_unset GIT_TRACE2 GIT_TRACE2_PERF GIT_TRACE2_EVENT
 sane_unset GIT_TRACE2_PERF_BRIEF
diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
index 4618ffc108e..5e0a1fa176d 100755
--- a/t/t0610-reftable-basics.sh
+++ b/t/t0610-reftable-basics.sh
@@ -643,7 +643,7 @@ test_expect_success 'basic: commit and list refs' '
 	test_cmp actual expect
 '
 
-test_expect_success 'basic: can write large commit message' '
+test_expect_success PERL_TEST_HELPERS 'basic: can write large commit message' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	perl -e "
diff --git a/t/t0613-reftable-write-options.sh b/t/t0613-reftable-write-options.sh
index e2708e11d5b..fa1e2f9eef8 100755
--- a/t/t0613-reftable-write-options.sh
+++ b/t/t0613-reftable-write-options.sh
@@ -139,7 +139,7 @@ test_expect_success 'small block size leads to multiple ref blocks' '
 	)
 '
 
-test_expect_success 'small block size fails with large reflog message' '
+test_expect_success PERL_TEST_HELPERS 'small block size fails with large reflog message' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 398865d6ebe..a574da3df53 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -1270,7 +1270,7 @@ extract_batch_output () {
     ' "$@"
 }
 
-test_expect_success 'cat-file --batch-all-objects --batch ignores replace' '
+test_expect_success PERL_TEST_HELPERS 'cat-file --batch-all-objects --batch ignores replace' '
 	git cat-file --batch-all-objects --batch >actual.raw &&
 	extract_batch_output $orig <actual.raw >actual &&
 	{
diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index a0481139de5..b3cf53ff8c9 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -205,7 +205,7 @@ test_expect_success 'too-short tree' '
 	grep "too-short tree object" err
 '
 
-test_expect_success 'malformed mode in tree' '
+test_expect_success PERL_TEST_HELPERS 'malformed mode in tree' '
 	hex_oid=$(echo foo | git hash-object --stdin -w) &&
 	bin_oid=$(echo $hex_oid | hex2oct) &&
 	printf "9100644 \0$bin_oid" >tree-with-malformed-mode &&
@@ -213,7 +213,7 @@ test_expect_success 'malformed mode in tree' '
 	grep "malformed mode in tree entry" err
 '
 
-test_expect_success 'empty filename in tree' '
+test_expect_success PERL_TEST_HELPERS 'empty filename in tree' '
 	hex_oid=$(echo foo | git hash-object --stdin -w) &&
 	bin_oid=$(echo $hex_oid | hex2oct) &&
 	printf "100644 \0$bin_oid" >tree-with-empty-filename &&
@@ -221,7 +221,7 @@ test_expect_success 'empty filename in tree' '
 	grep "empty filename in tree entry" err
 '
 
-test_expect_success 'duplicate filename in tree' '
+test_expect_success PERL_TEST_HELPERS 'duplicate filename in tree' '
 	hex_oid=$(echo foo | git hash-object --stdin -w) &&
 	bin_oid=$(echo $hex_oid | hex2oct) &&
 	{
diff --git a/t/t1010-mktree.sh b/t/t1010-mktree.sh
index c291a2b33d7..4977998e205 100755
--- a/t/t1010-mktree.sh
+++ b/t/t1010-mktree.sh
@@ -41,13 +41,13 @@ test_expect_success 'ls-tree piped to mktree (2)' '
 	test_cmp tree.withsub actual
 '
 
-test_expect_success 'ls-tree output in wrong order given to mktree (1)' '
+test_expect_success PERL_TEST_HELPERS 'ls-tree output in wrong order given to mktree (1)' '
 	perl -e "print reverse <>" <top |
 	git mktree >actual &&
 	test_cmp tree actual
 '
 
-test_expect_success 'ls-tree output in wrong order given to mktree (2)' '
+test_expect_success PERL_TEST_HELPERS 'ls-tree output in wrong order given to mktree (2)' '
 	perl -e "print reverse <>" <top.withsub |
 	git mktree >actual &&
 	test_cmp tree.withsub actual
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 8a456b1142d..01050453762 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -346,7 +346,7 @@ test_expect_success 'unparseable tree object' '
 	test_grep ! "fatal: empty filename in tree entry" out
 '
 
-test_expect_success 'tree entry with type mismatch' '
+test_expect_success PERL_TEST_HELPERS 'tree entry with type mismatch' '
 	test_when_finished "remove_object \$blob" &&
 	test_when_finished "remove_object \$tree" &&
 	test_when_finished "remove_object \$commit" &&
@@ -364,7 +364,7 @@ test_expect_success 'tree entry with type mismatch' '
 	test_grep ! "dangling blob" out
 '
 
-test_expect_success 'tree entry with bogus mode' '
+test_expect_success PERL_TEST_HELPERS 'tree entry with bogus mode' '
 	test_when_finished "remove_object \$blob" &&
 	test_when_finished "remove_object \$tree" &&
 	blob=$(echo blob | git hash-object -w --stdin) &&
@@ -984,7 +984,7 @@ corrupt_index_checksum () {
 
 # Corrupt the checksum on the index and then
 # verify that only fsck notices.
-test_expect_success 'detect corrupt index file in fsck' '
+test_expect_success PERL_TEST_HELPERS 'detect corrupt index file in fsck' '
 	cp .git/index .git/index.backup &&
 	test_when_finished "mv .git/index.backup .git/index" &&
 	corrupt_index_checksum &&
diff --git a/t/t3300-funny-names.sh b/t/t3300-funny-names.sh
index f5bf16abcd8..502b1572059 100755
--- a/t/t3300-funny-names.sh
+++ b/t/t3300-funny-names.sh
@@ -63,7 +63,7 @@ test_expect_success 'ls-files quotes funny filename' '
 	test_cmp expected current
 '
 
-test_expect_success 'ls-files -z does not quote funny filename' '
+test_expect_success PERL_TEST_HELPERS 'ls-files -z does not quote funny filename' '
 	cat >expected <<-\EOF &&
 	just space
 	no-funny
@@ -101,7 +101,7 @@ test_expect_success 'diff-tree --name-status quotes funny filename' '
 	test_cmp expected current
 '
 
-test_expect_success 'diff-index -z does not quote funny filename' '
+test_expect_success PERL_TEST_HELPERS 'diff-index -z does not quote funny filename' '
 	cat >expected <<-\EOF &&
 	A
 	tabs	," (dq) and spaces
@@ -111,7 +111,7 @@ test_expect_success 'diff-index -z does not quote funny filename' '
 	test_cmp expected current
 '
 
-test_expect_success 'diff-tree -z does not quote funny filename' '
+test_expect_success PERL_TEST_HELPERS 'diff-tree -z does not quote funny filename' '
 	cat >expected <<-\EOF &&
 	A
 	tabs	," (dq) and spaces
diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
index 3855d68dbc0..782d97fb7df 100755
--- a/t/t4013-diff-various.sh
+++ b/t/t4013-diff-various.sh
@@ -11,6 +11,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-diff.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping diff various tests; Perl not available'
+	test_done
+fi
+
 test_expect_success setup '
 
 	GIT_AUTHOR_DATE="2006-06-26 00:00:00 +0000" &&
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 884f83fb8a4..2782b1fc183 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -448,7 +448,7 @@ cat >>expect.no-threading <<EOF
 ---
 EOF
 
-test_expect_success 'no threading' '
+test_expect_success PERL_TEST_HELPERS 'no threading' '
 	git checkout side &&
 	check_threading expect.no-threading main
 '
@@ -466,11 +466,11 @@ In-Reply-To: <0>
 References: <0>
 EOF
 
-test_expect_success 'thread' '
+test_expect_success PERL_TEST_HELPERS 'thread' '
 	check_threading expect.thread --thread main
 '
 
-test_expect_success '--thread overrides format.thread=deep' '
+test_expect_success PERL_TEST_HELPERS '--thread overrides format.thread=deep' '
 	test_config format.thread deep &&
 	check_threading expect.thread --thread main
 '
@@ -490,7 +490,7 @@ In-Reply-To: <1>
 References: <1>
 EOF
 
-test_expect_success 'thread in-reply-to' '
+test_expect_success PERL_TEST_HELPERS 'thread in-reply-to' '
 	check_threading expect.in-reply-to --in-reply-to="<test.message>" \
 		--thread main
 '
@@ -512,7 +512,7 @@ In-Reply-To: <0>
 References: <0>
 EOF
 
-test_expect_success 'thread cover-letter' '
+test_expect_success PERL_TEST_HELPERS 'thread cover-letter' '
 	check_threading expect.cover-letter --cover-letter --thread main
 '
 
@@ -538,12 +538,12 @@ References: <1>
 	<0>
 EOF
 
-test_expect_success 'thread cover-letter in-reply-to' '
+test_expect_success PERL_TEST_HELPERS 'thread cover-letter in-reply-to' '
 	check_threading expect.cl-irt --cover-letter \
 		--in-reply-to="<test.message>" --thread main
 '
 
-test_expect_success 'thread explicit shallow' '
+test_expect_success PERL_TEST_HELPERS 'thread explicit shallow' '
 	check_threading expect.cl-irt --cover-letter \
 		--in-reply-to="<test.message>" --thread=shallow main
 '
@@ -562,7 +562,7 @@ References: <0>
 	<1>
 EOF
 
-test_expect_success 'thread deep' '
+test_expect_success PERL_TEST_HELPERS 'thread deep' '
 	check_threading expect.deep --thread=deep main
 '
 
@@ -584,7 +584,7 @@ References: <1>
 	<2>
 EOF
 
-test_expect_success 'thread deep in-reply-to' '
+test_expect_success PERL_TEST_HELPERS 'thread deep in-reply-to' '
 	check_threading expect.deep-irt  --thread=deep \
 		--in-reply-to="<test.message>" main
 '
@@ -609,7 +609,7 @@ References: <0>
 	<2>
 EOF
 
-test_expect_success 'thread deep cover-letter' '
+test_expect_success PERL_TEST_HELPERS 'thread deep cover-letter' '
 	check_threading expect.deep-cl --cover-letter --thread=deep main
 '
 
@@ -638,27 +638,27 @@ References: <1>
 	<3>
 EOF
 
-test_expect_success 'thread deep cover-letter in-reply-to' '
+test_expect_success PERL_TEST_HELPERS 'thread deep cover-letter in-reply-to' '
 	check_threading expect.deep-cl-irt --cover-letter \
 		--in-reply-to="<test.message>" --thread=deep main
 '
 
-test_expect_success 'thread via config' '
+test_expect_success PERL_TEST_HELPERS 'thread via config' '
 	test_config format.thread true &&
 	check_threading expect.thread main
 '
 
-test_expect_success 'thread deep via config' '
+test_expect_success PERL_TEST_HELPERS 'thread deep via config' '
 	test_config format.thread deep &&
 	check_threading expect.deep main
 '
 
-test_expect_success 'thread config + override' '
+test_expect_success PERL_TEST_HELPERS 'thread config + override' '
 	test_config format.thread deep &&
 	check_threading expect.thread --thread main
 '
 
-test_expect_success 'thread config + --no-thread' '
+test_expect_success PERL_TEST_HELPERS 'thread config + --no-thread' '
 	test_config format.thread deep &&
 	check_threading expect.no-threading --no-thread main
 '
diff --git a/t/t4020-diff-external.sh b/t/t4020-diff-external.sh
index f1efe482a59..189294de7ef 100755
--- a/t/t4020-diff-external.sh
+++ b/t/t4020-diff-external.sh
@@ -239,7 +239,7 @@ check_external_diff 128 empty  error 2 on  --quiet
 
 echo NULZbetweenZwords | perl -pe 'y/Z/\000/' > file
 
-test_expect_success 'force diff with "diff"' '
+test_expect_success PERL_TEST_HELPERS 'force diff with "diff"' '
 	after=$(git hash-object file) &&
 	after=$(git rev-parse --short $after) &&
 	echo >.gitattributes "file diff" &&
@@ -300,7 +300,7 @@ test_expect_success 'external diff with autocrlf = true' '
 	test $(wc -l <crlfed.txt) = $(keep_only_cr <crlfed.txt | wc -c)
 '
 
-test_expect_success 'diff --cached' '
+test_expect_success PERL_TEST_HELPERS 'diff --cached' '
 	test_config core.autocrlf true &&
 	git add file &&
 	git update-index --assume-unchanged file &&
diff --git a/t/t4029-diff-trailing-space.sh b/t/t4029-diff-trailing-space.sh
index 32b6e9a4e76..a92a42990b1 100755
--- a/t/t4029-diff-trailing-space.sh
+++ b/t/t4029-diff-trailing-space.sh
@@ -18,7 +18,7 @@ index 5f6a263..8cb8bae 100644
 EOF
 exit 1
 
-test_expect_success "$test_description" '
+test_expect_success PERL_TEST_HELPERS "$test_description" '
 	printf "\nx\n" > f &&
 	before=$(git hash-object f) &&
 	before=$(git rev-parse --short $before) &&
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index daebf9796f5..c7d8eb12453 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -4,6 +4,12 @@ test_description='diff.*.textconv tests'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping diff textconv tests; Perl not available'
+	test_done
+fi
+
 find_diff() {
 	sed '1,/^index /d' | sed '/^-- $/,$d'
 }
diff --git a/t/t4031-diff-rewrite-binary.sh b/t/t4031-diff-rewrite-binary.sh
index c4394a27b56..cbe50b15772 100755
--- a/t/t4031-diff-rewrite-binary.sh
+++ b/t/t4031-diff-rewrite-binary.sh
@@ -70,7 +70,7 @@ test_expect_success 'setup textconv' '
 	git config diff.foo.textconv "\"$(pwd)\""/dump
 '
 
-test_expect_success 'rewrite diff respects textconv' '
+test_expect_success PERL_TEST_HELPERS 'rewrite diff respects textconv' '
 	git diff -B >diff &&
 	grep "dissimilarity index" diff &&
 	grep "^-61" diff &&
diff --git a/t/t4058-diff-duplicates.sh b/t/t4058-diff-duplicates.sh
index 2fce4a98977..16266dff2af 100755
--- a/t/t4058-diff-duplicates.sh
+++ b/t/t4058-diff-duplicates.sh
@@ -13,6 +13,12 @@ test_description='test tree diff when trees have duplicate entries'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping diff duplicates tests; Perl not available'
+	test_done
+fi
+
 # make_tree_entry <mode> <mode> <sha1>
 #
 # We have to rely on perl here because not all printfs understand
diff --git a/t/t4103-apply-binary.sh b/t/t4103-apply-binary.sh
index d370ecfe0d9..59d38793ae6 100755
--- a/t/t4103-apply-binary.sh
+++ b/t/t4103-apply-binary.sh
@@ -11,6 +11,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping apply-binary tests; Perl not available'
+	test_done
+fi
+
 test_expect_success 'setup' '
 	cat >file1 <<-\EOF &&
 	A quick brown fox jumps over the lazy dog.
diff --git a/t/t4116-apply-reverse.sh b/t/t4116-apply-reverse.sh
index 0784ba033a4..6f414ad27f5 100755
--- a/t/t4116-apply-reverse.sh
+++ b/t/t4116-apply-reverse.sh
@@ -10,6 +10,12 @@ test_description='git apply in reverse
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping apply reverse tests; Perl not available'
+	test_done
+fi
+
 test_expect_success setup '
 
 	test_write_lines a b c d e f g h i j k l m n >file1 &&
diff --git a/t/t4150-am.sh b/t/t4150-am.sh
index 5e2b6c80eae..4794510d70d 100755
--- a/t/t4150-am.sh
+++ b/t/t4150-am.sh
@@ -1073,7 +1073,7 @@ test_expect_success 'am --patch-format=mboxrd handles mboxrd' '
 	test_cmp msg out
 '
 
-test_expect_success 'am works with multi-line in-body headers' '
+test_expect_success PERL_TEST_HELPERS 'am works with multi-line in-body headers' '
 	FORTY="String that has a length of more than forty characters" &&
 	LONG="$FORTY $FORTY" &&
 	rm -fr .git/rebase-apply &&
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index b0a3e849841..50fe8b0fd05 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -27,6 +27,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping rerere tests; Perl not available'
+	test_done
+fi
+
 test_expect_success 'setup' '
 	cat >a1 <<-\EOF &&
 	Some title
diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index f81e42a84d5..8f2ba98963f 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -698,7 +698,7 @@ test_expect_success '%(trailers:only=no,only=true) shows only "key: value" trail
 	test_cmp expect actual
 '
 
-test_expect_success '%(trailers:unfold) unfolds trailers' '
+test_expect_success PERL_TEST_HELPERS '%(trailers:unfold) unfolds trailers' '
 	git log --no-walk --pretty="%(trailers:unfold)" >actual &&
 	{
 		unfold <trailers &&
@@ -707,7 +707,7 @@ test_expect_success '%(trailers:unfold) unfolds trailers' '
 	test_cmp expect actual
 '
 
-test_expect_success ':only and :unfold work together' '
+test_expect_success PERL_TEST_HELPERS ':only and :unfold work together' '
 	git log --no-walk --pretty="%(trailers:only,unfold)" >actual &&
 	git log --no-walk --pretty="%(trailers:unfold,only)" >reverse &&
 	test_cmp actual reverse &&
@@ -754,7 +754,7 @@ test_expect_success '%(trailers:key=foo) handles multiple lines even if folded'
 	test_cmp expect actual
 '
 
-test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
+test_expect_success PERL_TEST_HELPERS '%(trailers:key=foo,unfold) properly unfolds' '
 	git log --no-walk --pretty="format:%(trailers:key=Signed-Off-by,unfold)" >actual &&
 	unfold <trailers | grep Signed-off-by >expect &&
 	test_cmp expect actual
diff --git a/t/t4216-log-bloom.sh b/t/t4216-log-bloom.sh
index 3f163dc3969..8910d53cac1 100755
--- a/t/t4216-log-bloom.sh
+++ b/t/t4216-log-bloom.sh
@@ -738,20 +738,20 @@ check_corrupt_graph () {
 	test_cmp expect.out out
 }
 
-test_expect_success 'Bloom reader notices too-small data chunk' '
+test_expect_success PERL_TEST_HELPERS 'Bloom reader notices too-small data chunk' '
 	check_corrupt_graph BDAT clear 00000000 &&
 	echo "warning: ignoring too-small changed-path chunk" \
 		"(4 < 12) in commit-graph file" >expect.err &&
 	test_cmp expect.err err
 '
 
-test_expect_success 'Bloom reader notices out-of-bounds filter offsets' '
+test_expect_success PERL_TEST_HELPERS 'Bloom reader notices out-of-bounds filter offsets' '
 	check_corrupt_graph BIDX 12 FFFFFFFF &&
 	# use grep to avoid depending on exact chunk size
 	grep "warning: ignoring out-of-range offset (4294967295) for changed-path filter at pos 3 of .git/objects/info/commit-graph" err
 '
 
-test_expect_success 'Bloom reader notices too-small index chunk' '
+test_expect_success PERL_TEST_HELPERS 'Bloom reader notices too-small index chunk' '
 	# replace the index with a single entry, making most
 	# lookups out-of-bounds
 	check_corrupt_graph BIDX clear 00000000 &&
@@ -760,7 +760,7 @@ test_expect_success 'Bloom reader notices too-small index chunk' '
 	test_cmp expect.err err
 '
 
-test_expect_success 'Bloom reader notices out-of-order index offsets' '
+test_expect_success PERL_TEST_HELPERS 'Bloom reader notices out-of-order index offsets' '
 	# we do not know any real offsets, but we can pick
 	# something plausible; we should not get to the point of
 	# actually reading from the bogus offsets anyway.
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index 50344e17ca1..51749951916 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -4,6 +4,12 @@ test_description='test corner cases of git-archive'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping archive corner cases tests; Perl not available'
+	test_done
+fi
+
 # the 10knuls.tar file is used to test for an empty git generated tar
 # without having to invoke tar because an otherwise valid empty GNU tar
 # will be considered broken by {Open,Net}BSD tar
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 5ac8d39094b..143856c29f1 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -7,6 +7,12 @@ test_description='git pack-object'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping pack-object tests; Perl not available'
+	test_done
+fi
+
 test_expect_success 'setup' '
 	rm -f .git/index* &&
 	perl -e "print \"a\" x 4096;" >a &&
diff --git a/t/t5303-pack-corruption-resilience.sh b/t/t5303-pack-corruption-resilience.sh
index de58ca654a1..ac5e370e1e4 100755
--- a/t/t5303-pack-corruption-resilience.sh
+++ b/t/t5303-pack-corruption-resilience.sh
@@ -99,7 +99,7 @@ test_expect_success '... and loose copy of first delta allows for partial recove
 	git cat-file blob $blob_3 > /dev/null
 '
 
-test_expect_success 'create corruption in data of first object' '
+test_expect_success PERL_TEST_HELPERS 'create corruption in data of first object' '
 	create_new_pack &&
 	git prune-packed &&
 	chmod +w ${pack}.pack &&
@@ -156,7 +156,7 @@ test_expect_success '... and then a repack "clears" the corruption' '
 	git cat-file blob $blob_3 > /dev/null
 '
 
-test_expect_success 'create corruption in data of first delta' '
+test_expect_success PERL_TEST_HELPERS 'create corruption in data of first delta' '
 	create_new_pack &&
 	git prune-packed &&
 	chmod +w ${pack}.pack &&
diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 621bbbdd26e..81987296235 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -395,7 +395,7 @@ test_bitmap_cases () {
 		)
 	'
 
-	test_expect_success 'pack.preferBitmapTips' '
+	test_expect_success PERL_TEST_HELPERS 'pack.preferBitmapTips' '
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
 		(
diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index 32cf4227451..cd947b5a5ef 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -87,7 +87,7 @@ max_chain() {
 # packing heuristics. We double-check that our test case
 # actually produces a long chain. If it doesn't, it should be
 # adjusted (or scrapped if the heuristics have become too unreliable)
-test_expect_success 'packing produces a long delta' '
+test_expect_success PERL_TEST_HELPERS 'packing produces a long delta' '
 	# Use --window=0 to make sure we are seeing reused deltas,
 	# not computing a new long chain.
 	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
@@ -96,21 +96,21 @@ test_expect_success 'packing produces a long delta' '
 	test_cmp expect actual
 '
 
-test_expect_success '--depth limits depth' '
+test_expect_success PERL_TEST_HELPERS '--depth limits depth' '
 	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
 	echo 5 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success '--depth=0 disables deltas' '
+test_expect_success PERL_TEST_HELPERS '--depth=0 disables deltas' '
 	pack=$(git pack-objects --all --depth=0 </dev/null pack) &&
 	echo 0 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success 'negative depth disables deltas' '
+test_expect_success PERL_TEST_HELPERS 'negative depth disables deltas' '
 	pack=$(git pack-objects --all --depth=-1 </dev/null pack) &&
 	echo 0 >expect &&
 	max_chain pack-$pack.pack >actual &&
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index f68f64cd85e..0b3404f58fe 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -837,7 +837,7 @@ check_corrupt_chunk () {
 	test_cmp expect.out out
 }
 
-test_expect_success 'reader notices too-small oid fanout chunk' '
+test_expect_success PERL_TEST_HELPERS 'reader notices too-small oid fanout chunk' '
 	# make it big enough that the graph file is plausible,
 	# otherwise we hit an earlier check
 	check_corrupt_chunk OIDF clear $(printf "000000%02x" $(test_seq 250)) &&
@@ -848,7 +848,7 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
 	test_cmp expect.err err
 '
 
-test_expect_success 'reader notices fanout/lookup table mismatch' '
+test_expect_success PERL_TEST_HELPERS 'reader notices fanout/lookup table mismatch' '
 	check_corrupt_chunk OIDF 1020 "FFFFFFFF" &&
 	cat >expect.err <<-\EOF &&
 	error: commit-graph OID lookup chunk is the wrong size
@@ -857,7 +857,7 @@ test_expect_success 'reader notices fanout/lookup table mismatch' '
 	test_cmp expect.err err
 '
 
-test_expect_success 'reader notices out-of-bounds fanout' '
+test_expect_success PERL_TEST_HELPERS 'reader notices out-of-bounds fanout' '
 	# Rather than try to corrupt a specific hash, we will just
 	# wreck them all. But we cannot just set them all to 0xFFFFFFFF or
 	# similar, as they are used for hi/lo starts in a binary search (so if
@@ -873,7 +873,7 @@ test_expect_success 'reader notices out-of-bounds fanout' '
 	test_cmp expect.err err
 '
 
-test_expect_success 'reader notices too-small commit data chunk' '
+test_expect_success PERL_TEST_HELPERS 'reader notices too-small commit data chunk' '
 	check_corrupt_chunk CDAT clear 00000000 &&
 	cat >expect.err <<-\EOF &&
 	error: commit-graph commit data chunk is wrong size
@@ -882,7 +882,7 @@ test_expect_success 'reader notices too-small commit data chunk' '
 	test_cmp expect.err err
 '
 
-test_expect_success 'reader notices out-of-bounds extra edge' '
+test_expect_success PERL_TEST_HELPERS 'reader notices out-of-bounds extra edge' '
 	check_corrupt_chunk EDGE clear &&
 	cat >expect.err <<-\EOF &&
 	error: commit-graph extra-edges pointer out of bounds
@@ -890,7 +890,7 @@ test_expect_success 'reader notices out-of-bounds extra edge' '
 	test_cmp expect.err err
 '
 
-test_expect_success 'reader notices too-small generations chunk' '
+test_expect_success PERL_TEST_HELPERS 'reader notices too-small generations chunk' '
 	check_corrupt_chunk GDA2 clear 00000000 &&
 	cat >expect.err <<-\EOF &&
 	error: commit-graph generations chunk is wrong size
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 0f215ad2e88..bd75dea9501 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -1120,7 +1120,7 @@ corrupt_chunk () {
 	corrupt_chunk_file $midx "$@"
 }
 
-test_expect_success 'reader notices too-small oid fanout chunk' '
+test_expect_success PERL_TEST_HELPERS 'reader notices too-small oid fanout chunk' '
 	corrupt_chunk OIDF clear 00000000 &&
 	test_must_fail git log 2>err &&
 	cat >expect <<-\EOF &&
@@ -1130,7 +1130,7 @@ test_expect_success 'reader notices too-small oid fanout chunk' '
 	test_cmp expect err
 '
 
-test_expect_success 'reader notices too-small oid lookup chunk' '
+test_expect_success PERL_TEST_HELPERS 'reader notices too-small oid lookup chunk' '
 	corrupt_chunk OIDL clear 00000000 &&
 	test_must_fail git log 2>err &&
 	cat >expect <<-\EOF &&
@@ -1140,7 +1140,7 @@ test_expect_success 'reader notices too-small oid lookup chunk' '
 	test_cmp expect err
 '
 
-test_expect_success 'reader notices too-small pack names chunk' '
+test_expect_success PERL_TEST_HELPERS 'reader notices too-small pack names chunk' '
 	# There is no NUL to terminate the name here, so the
 	# chunk is too short.
 	corrupt_chunk PNAM clear 70656666 &&
@@ -1151,7 +1151,7 @@ test_expect_success 'reader notices too-small pack names chunk' '
 	test_cmp expect err
 '
 
-test_expect_success 'reader handles unaligned chunks' '
+test_expect_success PERL_TEST_HELPERS 'reader handles unaligned chunks' '
 	# A 9-byte PNAM means all of the subsequent chunks
 	# will no longer be 4-byte aligned, but it is still
 	# a valid one-pack chunk on its own (it is "foo.pack\0").
@@ -1165,7 +1165,7 @@ test_expect_success 'reader handles unaligned chunks' '
 	test_cmp expect.err err
 '
 
-test_expect_success 'reader notices too-small object offset chunk' '
+test_expect_success PERL_TEST_HELPERS 'reader notices too-small object offset chunk' '
 	corrupt_chunk OOFF clear 00000000 &&
 	test_must_fail git log 2>err &&
 	cat >expect <<-\EOF &&
@@ -1175,7 +1175,7 @@ test_expect_success 'reader notices too-small object offset chunk' '
 	test_cmp expect err
 '
 
-test_expect_success 'reader bounds-checks large offset table' '
+test_expect_success PERL_TEST_HELPERS 'reader bounds-checks large offset table' '
 	# re-use the objects64 dir here to cheaply get access to a midx
 	# with large offsets.
 	git init repo &&
@@ -1197,7 +1197,7 @@ test_expect_success 'reader bounds-checks large offset table' '
 	)
 '
 
-test_expect_success 'reader notices too-small revindex chunk' '
+test_expect_success PERL_TEST_HELPERS 'reader notices too-small revindex chunk' '
 	# We only get a revindex with bitmaps (and likewise only
 	# load it when they are asked for).
 	test_config repack.writeBitmaps true &&
@@ -1214,7 +1214,7 @@ test_expect_success 'reader notices too-small revindex chunk' '
 	test_cmp expect.err err
 '
 
-test_expect_success 'reader notices out-of-bounds fanout' '
+test_expect_success PERL_TEST_HELPERS 'reader notices out-of-bounds fanout' '
 	# This is similar to the out-of-bounds fanout test in t5318. The values
 	# in adjacent entries should be large but not identical (they
 	# are used as hi/lo starts for a binary search, which would then abort
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index a32be3867df..49a057cc2eb 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -401,7 +401,7 @@ test_expect_success 'verify across alternates' '
 	)
 '
 
-test_expect_success 'reader bounds-checks base-graph chunk' '
+test_expect_success PERL_TEST_HELPERS 'reader bounds-checks base-graph chunk' '
 	git clone --no-hardlinks . corrupt-base-chunk &&
 	(
 		cd corrupt-base-chunk &&
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index d27557b9b04..627f8b4efdc 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -153,7 +153,7 @@ test_midx_bitmap_cases () {
 		)
 	'
 
-	test_expect_success 'pack.preferBitmapTips' '
+	test_expect_success PERL_TEST_HELPERS 'pack.preferBitmapTips' '
 		git init repo &&
 		test_when_finished "rm -fr repo" &&
 		(
diff --git a/t/t5328-commit-graph-64bit-time.sh b/t/t5328-commit-graph-64bit-time.sh
index a766a3e3f84..d8891e6a922 100755
--- a/t/t5328-commit-graph-64bit-time.sh
+++ b/t/t5328-commit-graph-64bit-time.sh
@@ -74,7 +74,7 @@ test_expect_success 'single commit with generation data exceeding UINT32_MAX' '
 	git -C repo-uint32-max commit-graph verify
 '
 
-test_expect_success 'reader notices out-of-bounds generation overflow' '
+test_expect_success PERL_TEST_HELPERS 'reader notices out-of-bounds generation overflow' '
 	graph=.git/objects/info/commit-graph &&
 	test_when_finished "rm -rf $graph" &&
 	git commit-graph write --reachable &&
diff --git a/t/t5333-pseudo-merge-bitmaps.sh b/t/t5333-pseudo-merge-bitmaps.sh
index 3905cb6e4f1..1059ff45fe4 100755
--- a/t/t5333-pseudo-merge-bitmaps.sh
+++ b/t/t5333-pseudo-merge-bitmaps.sh
@@ -6,6 +6,12 @@ GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping pseudo-merge bitmap tests; Perl not available'
+	test_done
+fi
+
 test_pseudo_merges () {
 	test-tool bitmap dump-pseudo-merges
 }
diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 3f81f16e133..571e8f1bc59 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -268,7 +268,7 @@ extract_ref_advertisement () {
 	'
 }
 
-test_expect_success 'receive-pack de-dupes .have lines' '
+test_expect_success PERL_TEST_HELPERS 'receive-pack de-dupes .have lines' '
 	git init shared &&
 	git -C shared commit --allow-empty -m both &&
 	git clone -s shared fork &&
diff --git a/t/t5410-receive-pack-alternates.sh b/t/t5410-receive-pack-alternates.sh
index 0b28e4e452f..6a009fdcd71 100755
--- a/t/t5410-receive-pack-alternates.sh
+++ b/t/t5410-receive-pack-alternates.sh
@@ -20,7 +20,7 @@ extract_haves () {
 	depacketize | perl -lne '/^(\S+) \.have/ and print $1'
 }
 
-test_expect_success 'with core.alternateRefsCommand' '
+test_expect_success PERL_TEST_HELPERS 'with core.alternateRefsCommand' '
 	write_script fork/alternate-refs <<-\EOF &&
 		git --git-dir="$1" for-each-ref \
 			--format="%(objectname)" \
@@ -33,7 +33,7 @@ test_expect_success 'with core.alternateRefsCommand' '
 	test_cmp expect actual.haves
 '
 
-test_expect_success 'with core.alternateRefsPrefixes' '
+test_expect_success PERL_TEST_HELPERS 'with core.alternateRefsPrefixes' '
 	test_config -C fork core.alternateRefsPrefixes "refs/heads/private" &&
 	git rev-parse private/branch >expect &&
 	printf "0000" | git receive-pack fork >actual &&
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index 845ca43ea0a..febe4410417 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -7,6 +7,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping tagfollow tests; Perl not available'
+	test_done
+fi
+
 # End state of the repository:
 #
 #         T - tag1          S - tag2
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index 58074506c59..438250c75ed 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -359,7 +359,7 @@ test_expect_success \
 	grep "Cannot demote unterminatedheader" act
 '
 
-test_expect_success 'badFilemode is not a strict error' '
+test_expect_success PERL_TEST_HELPERS 'badFilemode is not a strict error' '
 	git init --bare badmode.git &&
 	tree=$(
 		cd badmode.git &&
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5f350facf5e..432a2264e6f 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -8,6 +8,12 @@ test_description='Per branch config variables affects "git fetch".
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-bundle.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping fetch tests; Perl not available'
+	test_done
+fi
+
 D=$(pwd)
 
 test_expect_success setup '
diff --git a/t/t5532-fetch-proxy.sh b/t/t5532-fetch-proxy.sh
index 37558226290..95d0f33b295 100755
--- a/t/t5532-fetch-proxy.sh
+++ b/t/t5532-fetch-proxy.sh
@@ -4,6 +4,12 @@ test_description='fetching via git:// using core.gitproxy'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping fetch proxy tests; Perl not available'
+	test_done
+fi
+
 test_expect_success 'setup remote repo' '
 	git init remote &&
 	(cd remote &&
diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
index c91a62b77af..342d0423c92 100755
--- a/t/t5534-push-signed.sh
+++ b/t/t5534-push-signed.sh
@@ -177,7 +177,7 @@ test_expect_success GPGSSH 'ssh signed push sends push certificate' '
 	test_cmp expect dst/push-cert-status
 '
 
-test_expect_success GPG 'inconsistent push options in signed push not allowed' '
+test_expect_success GPG,PERL_TEST_HELPERS 'inconsistent push options in signed push not allowed' '
 	# First, invoke receive-pack with dummy input to obtain its preamble.
 	prepare_dst &&
 	git -C dst config receive.certnonceseed sekrit &&
diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 37f7547a4ca..77d20d19110 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -256,7 +256,7 @@ start_httpd
 
 REPO="$HTTPD_DOCUMENT_ROOT_PATH/repo"
 
-test_expect_success 'shallow fetches check connectivity before writing shallow file' '
+test_expect_success PERL_TEST_HELPERS 'shallow fetches check connectivity before writing shallow file' '
 	rm -rf "$REPO" client &&
 
 	git init "$REPO" &&
diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 761fdfcfe6c..b0d4ea78015 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -7,6 +7,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-httpd.sh
+
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping http fetch smart tests; Perl not available'
+	test_done
+fi
+
 test "$HTTP_PROTO" = "HTTP/2" && enable_http2
 start_httpd
 
diff --git a/t/t5562-http-backend-content-length.sh b/t/t5562-http-backend-content-length.sh
index f3b158274c4..b6ee06f5c8f 100755
--- a/t/t5562-http-backend-content-length.sh
+++ b/t/t5562-http-backend-content-length.sh
@@ -4,6 +4,12 @@ test_description='test git-http-backend respects CONTENT_LENGTH'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping http backend content tests; Perl not available'
+	test_done
+fi
+
 test_lazy_prereq GZIP 'gzip --version'
 
 verify_http_result() {
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index d0c18660e33..d743d986c40 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -649,7 +649,7 @@ test_expect_success 'GIT_TRACE_PACKFILE produces a usable pack' '
 	git -C replay.git index-pack -v --stdin <tmp.pack
 '
 
-test_expect_success 'clone on case-insensitive fs' '
+test_expect_success PERL_TEST_HELPERS 'clone on case-insensitive fs' '
 	git init icasefs &&
 	(
 		cd icasefs &&
@@ -662,7 +662,7 @@ test_expect_success 'clone on case-insensitive fs' '
 	)
 '
 
-test_expect_success CASE_INSENSITIVE_FS 'colliding file detection' '
+test_expect_success PERL_TEST_HELPERS,CASE_INSENSITIVE_FS 'colliding file detection' '
 	grep X icasefs/warning &&
 	grep x icasefs/warning &&
 	test_grep "the following paths have collided" icasefs/warning
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 46504519643..bc7e0fec8dc 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -751,7 +751,7 @@ replace_packfile () {
 	}' >"$HTTPD_ROOT_PATH/one-time-perl"
 }
 
-test_expect_success 'upon cloning, check that all refs point to objects' '
+test_expect_success PERL_TEST_HELPERS 'upon cloning, check that all refs point to objects' '
 	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
 	rm -rf "$SERVER" repo &&
 	test_create_repo "$SERVER" &&
@@ -784,7 +784,7 @@ test_expect_success 'upon cloning, check that all refs point to objects' '
 	! test -e "$HTTPD_ROOT_PATH/one-time-perl"
 '
 
-test_expect_success 'when partial cloning, tolerate server not sending target of tag' '
+test_expect_success PERL_TEST_HELPERS 'when partial cloning, tolerate server not sending target of tag' '
 	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
 	rm -rf "$SERVER" repo &&
 	test_create_repo "$SERVER" &&
@@ -825,7 +825,7 @@ test_expect_success 'when partial cloning, tolerate server not sending target of
 	! test -e "$HTTPD_ROOT_PATH/one-time-perl"
 '
 
-test_expect_success 'tolerate server sending REF_DELTA against missing promisor objects' '
+test_expect_success PERL_TEST_HELPERS 'tolerate server sending REF_DELTA against missing promisor objects' '
 	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
 	rm -rf "$SERVER" repo &&
 	test_create_repo "$SERVER" &&
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 678a346ed06..200bf06ecb3 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -220,7 +220,7 @@ test_expect_success 'refs/heads prefix' '
 	test_cmp expect actual
 '
 
-test_expect_success 'ignore very large set of prefixes' '
+test_expect_success PERL_TEST_HELPERS 'ignore very large set of prefixes' '
 	# generate a large number of ref-prefixes that we expect
 	# to match nothing; the value here exceeds TOO_MANY_PREFIXES
 	# from ls-refs.c.
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d3df81e7852..ad5e772cd72 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -1120,7 +1120,7 @@ test_expect_success 'push with http:// and a config of v2 does not request v2' '
 	! grep "git< version 2" log
 '
 
-test_expect_success 'when server sends "ready", expect DELIM' '
+test_expect_success PERL_TEST_HELPERS 'when server sends "ready", expect DELIM' '
 	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
@@ -1140,7 +1140,7 @@ test_expect_success 'when server sends "ready", expect DELIM' '
 	test_grep "expected packfile to be sent after .ready." err
 '
 
-test_expect_success 'when server does not send "ready", expect FLUSH' '
+test_expect_success PERL_TEST_HELPERS 'when server does not send "ready", expect FLUSH' '
 	rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" http_child log &&
 
 	git init "$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
@@ -1446,7 +1446,7 @@ test_expect_success 'http:// --negotiate-only' '
 	grep "$COMMON" out
 '
 
-test_expect_success 'http:// --negotiate-only without wait-for-done support' '
+test_expect_success PERL_TEST_HELPERS 'http:// --negotiate-only without wait-for-done support' '
 	SERVER="server" &&
 	URI="$HTTPD_URL/one_time_perl/server" &&
 
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 191097171bc..f59d47aa6c6 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -4,6 +4,12 @@ test_description='upload-pack ref-in-want'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping upload-pack ref-in-want tests; Perl not available'
+	test_done
+fi
+
 get_actual_refs () {
 	sed -n -e '/wanted-refs/,/0001/{
 		/wanted-refs/d
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index d2cc69a17e4..9a420cf5605 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -4,6 +4,12 @@ test_description='handling of promisor remote advertisement'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping promisor remote capabilities tests; Perl not available'
+	test_done
+fi
+
 GIT_TEST_MULTI_PACK_INDEX=0
 GIT_TEST_MULTI_PACK_INDEX_WRITE_INCREMENTAL=0
 
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index daa009c9a1b..5e1482aff78 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -7,6 +7,12 @@ test_description='Tests git rev-list --bisect functionality'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping rev-list bisect tests; Perl not available'
+	test_done
+fi
+
 # usage: test_bisection max-diff bisect-option head ^prune...
 #
 # e.g. test_bisection 1 --bisect l1 ^l0
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 0d7055d46d4..02dd4127aff 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -8,6 +8,12 @@ test_description='Tests git rev-list --topo-order functionality'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping rev-list topo-order tests; Perl not available'
+	test_done
+fi
+
 list_duplicates()
 {
     "$@" | sort | uniq -d
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index bad02cf5b83..6131c361094 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -4,6 +4,12 @@ test_description='git rev-list should notice bad commits'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping rev-list with bad commit tests; Perl not available'
+	test_done
+fi
+
 # Note:
 # - compression level is set to zero to make "corruptions" easier to perform
 # - reflog is disabled to avoid extra references which would twart the test
diff --git a/t/t6013-rev-list-reverse-parents.sh b/t/t6013-rev-list-reverse-parents.sh
index 39793cbbd66..8074185742c 100755
--- a/t/t6013-rev-list-reverse-parents.sh
+++ b/t/t6013-rev-list-reverse-parents.sh
@@ -26,7 +26,7 @@ test_expect_success 'set up --reverse example' '
 	commit five
 	'
 
-test_expect_success '--reverse --parents --full-history combines correctly' '
+test_expect_success PERL_TEST_HELPERS '--reverse --parents --full-history combines correctly' '
 	git rev-list --parents --full-history main -- foo |
 		perl -e "print reverse <>" > expected &&
 	git rev-list --reverse --parents --full-history main -- foo \
@@ -34,7 +34,7 @@ test_expect_success '--reverse --parents --full-history combines correctly' '
 	test_cmp expected actual
 	'
 
-test_expect_success '--boundary does too' '
+test_expect_success PERL_TEST_HELPERS '--boundary does too' '
 	git rev-list --boundary --parents --full-history main ^root -- foo |
 		perl -e "print reverse <>" > expected &&
 	git rev-list --boundary --reverse --parents --full-history \
diff --git a/t/t6102-rev-list-unexpected-objects.sh b/t/t6102-rev-list-unexpected-objects.sh
index 22dfd6d978e..eb98b3919c8 100755
--- a/t/t6102-rev-list-unexpected-objects.sh
+++ b/t/t6102-rev-list-unexpected-objects.sh
@@ -4,6 +4,12 @@ test_description='git rev-list should handle unexpected object types'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping rev-list unexpected objects tests; Perl not available'
+	test_done
+fi
+
 test_expect_success 'setup well-formed objects' '
 	blob="$(printf "foo" | git hash-object -w --stdin)" &&
 	tree="$(printf "100644 blob $blob\tfoo" | git mktree)" &&
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index 3385fe9f130..6a74be576a2 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -4,6 +4,12 @@ test_description='basic tests of rev-list --disk-usage'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping rev-list disk usage tests; Perl not available'
+	test_done
+fi
+
 # we want a mix of reachable and unreachable, as well as
 # objects in the bitmapped pack and some outside of it
 test_expect_success 'set up repository' '
diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index a5c77943854..732a4d3171e 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -10,6 +10,12 @@ GNUPGHOME_NOT_USED=$GNUPGHOME
 . "$TEST_DIRECTORY"/lib-gpg.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping for-each-ref tests; Perl not available'
+	test_done
+fi
+
 # Mon Jul 3 23:18:43 2006 +0000
 datestamp=1151968723
 setdate_and_increment () {
diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
index 932c26cb45b..49aae183829 100755
--- a/t/t7006-pager.sh
+++ b/t/t7006-pager.sh
@@ -661,7 +661,7 @@ test_expect_success 'setup trace2' '
 	export GIT_TRACE2_BRIEF
 '
 
-test_expect_success 'setup large log output' '
+test_expect_success PERL_TEST_HELPERS 'setup large log output' '
 	perl -e "
 		print \"this is a long commit message\" x 50000
 	" >commit-msg &&
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
index 0c605fd271a..14069600a2f 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -4,6 +4,12 @@ test_description='check handling of disallowed .gitmodule urls'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping submodule dash URL tests; Perl not available'
+	test_done
+fi
+
 test_expect_success 'setup' '
 	git config --global protocol.file.allow always
 '
diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index b2070d4e39f..14c41b2cb7c 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1064,7 +1064,7 @@ test_expect_success 'status -s submodule summary (clean submodule)' '
 	test_cmp expect output
 '
 
-test_expect_success 'status -z implies porcelain' '
+test_expect_success PERL_TEST_HELPERS 'status -z implies porcelain' '
 	git status --porcelain |
 	perl -pe "s/\012/\000/g" >expect &&
 	git status -z >output &&
diff --git a/t/t7815-grep-binary.sh b/t/t7815-grep-binary.sh
index 90ebb64f46e..b2730d200c8 100755
--- a/t/t7815-grep-binary.sh
+++ b/t/t7815-grep-binary.sh
@@ -4,6 +4,12 @@ test_description='git grep in binary files'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping grep binary tests; Perl not available'
+	test_done
+fi
+
 test_expect_success 'setup' "
 	echo 'binaryQfileQm[*]cQ*æQð' | q_to_nul >a &&
 	git add a &&
diff --git a/t/t8001-annotate.sh b/t/t8001-annotate.sh
index d7167f55397..609845aeb1e 100755
--- a/t/t8001-annotate.sh
+++ b/t/t8001-annotate.sh
@@ -7,6 +7,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping annotate tests; Perl not available'
+	test_done
+fi
+
 PROG='git annotate'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
index e98993276a6..b40199df231 100755
--- a/t/t8002-blame.sh
+++ b/t/t8002-blame.sh
@@ -7,6 +7,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping blame colors tests; Perl not available'
+	test_done
+fi
+
 PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
diff --git a/t/t8006-blame-textconv.sh b/t/t8006-blame-textconv.sh
index 07a287ffd3e..5cb16872081 100755
--- a/t/t8006-blame-textconv.sh
+++ b/t/t8006-blame-textconv.sh
@@ -4,6 +4,12 @@ test_description='git blame textconv support'
 
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping blame textconv tests; Perl not available'
+	test_done
+fi
+
 find_blame() {
 	sed -e 's/^[^(]*//'
 }
diff --git a/t/t8011-blame-split-file.sh b/t/t8011-blame-split-file.sh
index c66494f5ba7..388057245c8 100755
--- a/t/t8011-blame-split-file.sh
+++ b/t/t8011-blame-split-file.sh
@@ -81,7 +81,7 @@ do
 		git blame --root -C --$output combined >output
 	'
 
-	test_expect_success "$output output finds correct commits" '
+	test_expect_success PERL_TEST_HELPERS "$output output finds correct commits" '
 		generate_expect >expect <<-\EOF &&
 		5 base
 		1 modified
@@ -93,7 +93,7 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "$output output shows correct filenames" '
+	test_expect_success PERL_TEST_HELPERS "$output output shows correct filenames" '
 		generate_expect >expect <<-\EOF &&
 		11 one
 		11 two
@@ -102,7 +102,7 @@ do
 		test_cmp expect actual
 	'
 
-	test_expect_success "$output output shows correct previous pointer" '
+	test_expect_success PERL_TEST_HELPERS "$output output shows correct previous pointer" '
 		generate_expect >expect <<-EOF &&
 		5 NONE
 		1 $(git rev-parse modified^) one
diff --git a/t/t8012-blame-colors.sh b/t/t8012-blame-colors.sh
index c3a5f6d01ff..3d77352650f 100755
--- a/t/t8012-blame-colors.sh
+++ b/t/t8012-blame-colors.sh
@@ -7,6 +7,12 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
+if ! test_have_prereq PERL_TEST_HELPERS
+then
+	skip_all='skipping blame colors tests; Perl not available'
+	test_done
+fi
+
 PROG='git blame -c'
 . "$TEST_DIRECTORY"/annotate-tests.sh
 
diff --git a/t/t9137-git-svn-dcommit-clobber-series.sh b/t/t9137-git-svn-dcommit-clobber-series.sh
index 067b15bad25..a9d38be997c 100755
--- a/t/t9137-git-svn-dcommit-clobber-series.sh
+++ b/t/t9137-git-svn-dcommit-clobber-series.sh
@@ -15,7 +15,7 @@ test_expect_success 'initialize repo' '
 	test -e file
 	'
 
-test_expect_success '(supposedly) non-conflicting change from SVN' '
+test_expect_success PERL_TEST_HELPERS '(supposedly) non-conflicting change from SVN' '
 	test x"$(sed -n -e 58p < file)" = x58 &&
 	test x"$(sed -n -e 61p < file)" = x61 &&
 	svn_cmd co "$svnrepo" tmp &&
@@ -37,7 +37,7 @@ test_expect_success 'some unrelated changes to git' "
 	git commit -m bye-life life
 	"
 
-test_expect_success 'change file but in unrelated area' "
+test_expect_success PERL_TEST_HELPERS 'change file but in unrelated area' "
 	test x\"\$(sed -n -e 4p < file)\" = x4 &&
 	test x\"\$(sed -n -e 7p < file)\" = x7 &&
 	perl -i.bak -p -e 's/^4\$/4444/' file &&
diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index 40427883ec6..0781a8d6ace 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -610,7 +610,7 @@ test_expect_success 'directory becomes symlink'        '
 	(cd result && git show main:foo)
 '
 
-test_expect_success 'fast-export quotes pathnames' '
+test_expect_success PERL_TEST_HELPERS 'fast-export quotes pathnames' '
 	git init crazy-paths &&
 	test_config -C crazy-paths core.protectNTFS false &&
 	(cd crazy-paths &&
diff --git a/t/t9850-shell.sh b/t/t9850-shell.sh
index 36566ace21b..f619b60f226 100755
--- a/t/t9850-shell.sh
+++ b/t/t9850-shell.sh
@@ -29,7 +29,7 @@ test_expect_success 'shell allows interactive command' '
 	test_cmp expect actual
 '
 
-test_expect_success 'shell complains of overlong commands' '
+test_expect_success PERL_TEST_HELPERS 'shell complains of overlong commands' '
 	perl -e "print \"a\" x 2**12 for (0..2**19)" |
 	test_must_fail git shell 2>err &&
 	grep "too long" err
diff --git a/t/test-lib.sh b/t/test-lib.sh
index a62699d6c79..59162a3c834 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1706,6 +1706,7 @@ test -n "$USE_LIBPCRE2" && test_set_prereq LIBPCRE2
 test -z "$NO_GETTEXT" && test_set_prereq GETTEXT
 test -n "$SANITIZE_LEAK" && test_set_prereq SANITIZE_LEAK
 test -n "$GIT_VALGRIND_ENABLED" && test_set_prereq VALGRIND
+test -n "$PERL_PATH" && test_set_prereq PERL_TEST_HELPERS
 
 if test -z "$GIT_TEST_CHECK_CACHE_TREE"
 then

-- 
2.49.0.604.gff1f9ca942.dirty

