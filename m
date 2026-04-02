Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA973254B0
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112686; cv=none; b=sdwEeiYcaCOiZbZmPcckefBuXqlDUrlYRtMz9zO+Ep4LATM+dO0YM7XVBb5tDtFKIYZV1qC3WJnlNwMBcdE1NER9PWVyJMNquHBLjZ4GRy0pmAaYg+rd368lcaWB+aw7C5eVNhsLnp4zKcVBrPvAPbfZPIugaY92ZAQ3hSsD/Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112686; c=relaxed/simple;
	bh=RdpChB8ZqKZNZdlh6iixJ91R4kQ5QVquQzDYiKBoJBs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=DGWDUU/Gztq7o0UCH1MWVKp3O4kthHbEP4D+oZZD5uq35vP+6F/Y8YcrbRpKOfkiziwRg1Mqcqelmhjn6q8pjutpVlGwqe7+PlLa13EssASz8z6Rpn1BwCfVcmtqboQLxOUQtpaw8kim0awK/EIhegv3NrttkQ0Fd+sByJDj9Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IF95Clzf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XENHwjYE; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IF95Clzf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XENHwjYE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E9B71D003CA;
	Thu,  2 Apr 2026 02:51:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Thu, 02 Apr 2026 02:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775112684;
	 x=1775199084; bh=IgaC05I15zEsvWPKooeT2CUMM+8t6iRGf4Opge7h4g0=; b=
	IF95Clzf/XSE2L7Jdb+BuGaVBr8rH7sZuyIJy/ZH6bXAZNOfaEJgBchkx7o/vNm5
	I79iMNZ8noYNUVa8GyQY33KKwHRDZ+0Uun6XOaQ875PenTJayeiMvewd8yQ74/yt
	p5Yp9gWViKndsJiLY8mXgOr/GeToFn/B2uvDXRnOk5rlQXBEYAysOslAq+B+EcPu
	TTlIsqDzQM/JlbO+txXP3AUWOFCTBgR00aWu9QO2C1ohY6zDgjGYB3teSz0dDr/o
	FbXeHO7m5jOPeEKWilLasaTODyquG4kRB6i4qAc/LizUXpO4USpv1W77Zfej1pWL
	BpGW0uUQQtp6JOOjDP461A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775112684; x=
	1775199084; bh=IgaC05I15zEsvWPKooeT2CUMM+8t6iRGf4Opge7h4g0=; b=X
	ENHwjYE/dhqxH33h38NMiha0gL1d07qAkwqWSu5CKww3MBDXQG6QHMaMJnTcwmvu
	IYnz5Azqk7qshVlMKSwpOqk1J8OKjwqaESFiNClYPs4AIuWyvvB1DhbdJsPfp7jY
	QNPtuUQJSs/lSQLbq630zc9PtWmfcjXW7DZO5VEqt3/enjJr1q7sp4K/N/SmoT4W
	Qrz2YHpehoZDUuZrk816X4vQllFuVtvKO6MBRNdWl7Kge4RZQVHO1QjxaFw98s7i
	WHeiuiYTQNso8xtQ6e024r0Sy5CGExHiriH5MpWP1z3KHJXYtESapYhlOQacmofc
	EgSztexfdNAyy1G9bXd8g==
X-ME-Sender: <xms:6xHOaf9Run_VrZsxykw5RadZa3gqdpxAe-BZW1t6TQNntWRpDc7Ijg>
    <xme:6xHOab2EpYs-sUH5J24uI10SUrByyw9JJFddtluBqffjLEdrPLTg5BlE6BQf5pEhm
    BJv6ALsKqFNS7wu505Z6jf8BIGYjyU-cGo62cm4F9K1v7AqlkBQ8w>
X-ME-Received: <xmr:6xHOaU9cytw5d-nn1pcePSwXKGWPN_-jsOjzM3mtQo-TZorfalr-MMA9HNFYrbEUF40Cm_UcVrSn6J0rBzlzsRS-qyMa4e-zSnrY2nxy3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffufffkgggtgfgjfhfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    dtgfelgefftdeiieetffevudefieefveejffeuueeiledvhffhvdeiueeuuedtueenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhkpdgvgigrmhhplhgvrdgtohhmnecuvehluhhsth
    gvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdp
    nhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhvghrsggvrhhtsehgohhn
    ughorhdrrghprghnrgdrohhrghdrrghupdhrtghpthhtohepshhunhhshhhinhgvsehsuh
    hnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:6xHOaTsIG8_VM0AD1fVX2_Xe3Q3DIktH5A1KUnaM8ciTtjJfTGGiYA>
    <xmx:6xHOafCQNabra0r34awrrjitEGPdbcWpJf0teefBokXkE7v_SXV7XQ>
    <xmx:6xHOaTVkZnsbLk-JWKCwiStEMNg-sB6Q0cQpoZ4tskLP4vbaCvgE6Q>
    <xmx:6xHOaVB-vYwNQp810noaMCqinHU1WIPdMQIt8gh4LzDslFty1RkUnQ>
    <xmx:7BHOaYeMgzfqdtoQ9YNonVIoXOM0W0Z_N1INHsUuRfwPk1R9BpEn0ba7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 02:51:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0c27f4f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 06:51:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/2] t: work around bugs in Dash v0.5.13
Date: Thu, 02 Apr 2026 08:51:17 +0200
Message-Id: <20260402-pks-tests-with-dash-v2-0-cd7ab11dabc0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOURzmkC/32NQQ6CMBBFr0Jm7ZgWBZSV9zAsWjra0QikU1FDu
 LsF9y5f8v77EwgFJoE6myDQyMJ9lyDfZNB6010J2SWGXOWl2iuNw10wkkTBF0ePzohHMpVurd2
 Vx+IAaTkEuvB7rZ6bH8vT3qiNS2oxPEvsw2e9HfXi/X8YNSp0lbJFUowp3ClZW35AM8/zF2Hxd
 T7FAAAA
X-Change-ID: 20260401-pks-tests-with-dash-ea71cbb36958
In-Reply-To: <20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im>
References: <20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im>
To: git@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.15.1

Hi,

while testing my `set -e` change for our test suite I was also playing
around with Dash v0.5.13.1 and noticed that multiple of our tests fail
with that version. As it turns out, some of these test failures are
actual bugs in Dash itself that have been introduced in v0.5.13.

There's ultimately two bugs:

  - Dash inserts CTLMBCHAR byte sequences into heredocs around multibyte
    characters. This bug still exists with the current "master" branch
    of Dash.

  - Dash may swallow some bytes when reading data, which has already
    been fixed.

I've Cc'd Herbert, maintainer of Dash.

Changes in v2:
  - Add comment to heredocs explaining why they should never be quoted.
  - Link to v1: https://patch.msgid.link/20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im

Thanks!

Patrick

---
Patrick Steinhardt (2):
      t: work around multibyte bug in quoted heredocs with Dash v0.5.13
      t9300: work around partial read bug in Dash v0.5.13

 t/t0300-credentials.sh   |  4 +++-
 t/t3430-rebase-merges.sh |  6 ++++--
 t/t3902-quoted.sh        | 16 +++++++++-------
 t/t4014-format-patch.sh  | 16 ++++++++++++----
 t/t4201-shortlog.sh      |  4 +++-
 t/t9001-send-email.sh    | 12 +++++++++---
 t/t9300-fast-import.sh   | 32 ++++++++++++++------------------
 7 files changed, 54 insertions(+), 36 deletions(-)

Range-diff versus v1:

1:  192b5b4330 ! 1:  5367e05e0f t: work around multibyte bug in quoted heredocs with Dash v0.5.13
    @@ t/t0300-credentials.sh: test_expect_success 'match percent-encoded values' '
      	test_config credential.https://example.com.useHttpPath true &&
      	test_config credential.https://example.com/perú.git.helper "$HELPER" &&
     -	check fill <<-\EOF
    ++	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++	# that contain multibyte chars.
     +	check fill <<-EOF
      	url=https://example.com/per%C3%BA.git
      	--
    @@ t/t3430-rebase-merges.sh: test_expect_success 'octopus merges' '
      	test "Hank" = "$(git show -s --format=%an HEAD)" &&
      	test "$before" != $(git rev-parse HEAD) &&
     -	test_cmp_graph HEAD^^.. <<-\EOF
    ++	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++	# that contain multibyte chars.
     +	test_cmp_graph HEAD^^.. <<-EOF
      	*-.   Tüntenfüsch
     -	|\ \
    @@ t/t3902-quoted.sh: With SP in it
      EOF
      
     -cat >expect.raw <<\EOF
    ++# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++# that contain multibyte chars.
     +cat >expect.raw <<EOF
      Name
     -"Name and a\nLF"
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch wraps extremely long
      '
      
     -cat >expect <<'EOF'
    ++# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++# that contain multibyte chars.
     +cat >expect <<EOF
      From: Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar
       Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo
    @@ t/t4014-format-patch.sh: test_expect_success 'format-patch wraps extremely long
      '
      
     -cat >expect <<'EOF'
    ++# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++# that contain multibyte chars.
     +cat >expect <<EOF
      Subject: [PATCH] Foö
      EOF
    @@ t/t4014-format-patch.sh: test_expect_success 'subject lines are unencoded with -
      '
      
     -cat >expect <<'EOF'
    ++# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++# that contain multibyte chars.
     +cat >expect <<EOF
      Subject: [PATCH] Foö
      EOF
    @@ t/t4014-format-patch.sh: test_expect_success 'in-body headers trigger content en
      	test_when_finished "git reset --hard HEAD^" &&
      	git format-patch -1 --stdout --from >patch &&
     -	cat >expect <<-\EOF &&
    ++	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++	# that contain multibyte chars.
     +	cat >expect <<-EOF &&
      	From: C O Mitter <committer@example.com>
      	Content-Type: text/plain; charset=UTF-8
    @@ t/t4201-shortlog.sh: test_expect_success 'output from user-defined format is re-
      
      test_expect_success !MINGW,ICONV 'shortlog wrapping' '
     -	cat >expect <<\EOF &&
    ++	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++	# that contain multibyte chars.
     +	cat >expect <<EOF &&
      A U Thor (5):
            Test
    @@ t/t9001-send-email.sh: test_expect_success $PREREQ 'To headers from files reset
      
      test_expect_success $PREREQ 'setup expect' '
     -cat >email-using-8bit <<\EOF
    ++# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++# that contain multibyte chars.
     +cat >email-using-8bit <<EOF
      From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
      Message-ID: <bogus-message-id@example.com>
    @@ t/t9001-send-email.sh: test_expect_success $PREREQ '--8bit-encoding overrides se
      
      test_expect_success $PREREQ 'setup expect' '
     -	cat >email-using-8bit <<-\EOF
    ++	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++	# that contain multibyte chars.
     +	cat >email-using-8bit <<-EOF
      	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
      	Message-ID: <bogus-message-id@example.com>
    @@ t/t9001-send-email.sh: test_expect_success $PREREQ '--8bit-encoding also treats
      
      test_expect_success $PREREQ 'setup expect' '
     -	cat >email-using-8bit <<-\EOF
    ++	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
    ++	# that contain multibyte chars.
     +	cat >email-using-8bit <<-EOF
      	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
      	Message-ID: <bogus-message-id@example.com>
2:  db99459b3f = 2:  364d37fcc7 t9300: work around partial read bug in Dash v0.5.13

---
base-commit: 270e10ad6dda3379ea0da7efd11e4fbf2cd7a325
change-id: 20260401-pks-tests-with-dash-ea71cbb36958

