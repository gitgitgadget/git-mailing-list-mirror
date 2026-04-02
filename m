Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F055320A0B
	for <git@vger.kernel.org>; Thu,  2 Apr 2026 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775112688; cv=none; b=KQs9BtCG2/IZRdasT2Djx36fuYjhK+achTJXsh1KmaCoz1jRe3IoTuN27keul27TBX+kNQMLm2uclREkQ0o/jUtho7RVib4akH8nW9WYpr1peyw3Ct7G384TOT8AFYaufQD48kYCmv58d6wRxPvC/K/TK0VXuBksXebPkPtQSzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775112688; c=relaxed/simple;
	bh=8egjqCHmaNhEoggGu/pdkhup4dQQ02y5MynYqcPLpmw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dGE9+1VKnZJMKOh4aBTtxLk7mb/JBebVbP8e7GewcDb4F14ab0TSs8FupG7NBeNsA1dLI+CfH1CgoMAsk5UmkX0PIlSEIwaM7gBy/x/JGFKCb/vUbMYGPwV60h8OH85zzX4hVb9XMCfcQls8vIrZzLTUxQhUoD/SdWWG2n2D8As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gOfV7Cao; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b6AmA2PI; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gOfV7Cao";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b6AmA2PI"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id E1B491D003CC;
	Thu,  2 Apr 2026 02:51:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 02:51:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775112685;
	 x=1775199085; bh=/F3QSQxQlJmPqjQFl6jCY+kyauOLetzsXVV2ORxkQ3c=; b=
	gOfV7Cao0EolyZf1W9HeLmwa/fVciI0ce+xFqfknF1ptPgHeNO93B0lJe8S8iqd9
	rKdjDIdzPk1wrNo5XS8UiwSYjDNRb1UO4WrkQwO7YOS+x2idnF2/QsYuzcVfyHtM
	bhS0WKiny/HrmQmJxfnxF8pquWl0iwqVGuGHXVJ6LP5l2q2jVYy2YhuukshGOpgl
	tb4wcVD/ui+ukdBxP0wwIyJbCFR/EiGKmNwfKQ91iI7UX0vwaImmuZJU9jOwXZfI
	W/752mFvFflrPa9KA71ezu4mzJAyKqkW3eP3W2nAiIh3lJ14FT9Z21rQMdaUucPE
	W+kngajZj046Jd+9GOLNKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775112685; x=
	1775199085; bh=/F3QSQxQlJmPqjQFl6jCY+kyauOLetzsXVV2ORxkQ3c=; b=b
	6AmA2PIArFFO79kVzIpzUPPNvDfhzekR0rS/f6+CJjopvE2ikfZRnsG4JJw2/bO/
	YFZfCVfSE2SenAxroaJUK/PNcc2LrrzjfBQ1KsoYkvlVHMqnje57YRyOcf9uhv0k
	AJgECBH1Qim+OgdnOqCI493dKK27pOt/mmTyN72F6pyv08pc2PvOI6cGpxLAlAqM
	J2GuJLDF1vG4x24h6CjLnEDrp+R87CrBfM+tqkpGUc+MofW5DQDD+f6hSa4ekzSw
	E2GH6CBRyT//1e/nUeyIgT4h5UHE77lNOp0nSXwEujJu8VhKAjX5k5O71FTqB1w8
	iY9n/tJKKymB18jAZfCzg==
X-ME-Sender: <xms:7RHOaUpT5CdPx_9cyQnIo2N2xPwKxNM_kSKaLUvfn056bUW5HBlIog>
    <xme:7RHOaaxz1R0zn8NqSk4nD1I4O1jxrf6EwOP6bbA7l_-t0S6A7CId0XpSRjbvxuM5o
    eBliFrOIo1g0R1rK3T2bpU1Dtdx5EzxOD63Gi5E2z0qgItmikLBf8w>
X-ME-Received: <xmr:7RHOaRLSMbK32gcaPv6-sDpekuI6gJGZukFSqG3nPq_5d9Vno1RmCepJD29kUJrsvQZCkbUj3LnyxZr1z1bxkEFnhKUP0GwfoMNHfTo_Bg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhhfejveduiedtgeetvdelgfetkefhueeuleeghfelveffieefvdevuefhtedtleenucff
    ohhmrghinhephhhtthhpshhhohhsthgvgigrmhhplhgvrdgtohhmpdgvgigrmhhplhgvrd
    gtohhmpdhhthhtphhsughifhhfqddqghhithgrthhtfeegfedtqdhrvggsrghsvgdqmhgv
    rhhgvghsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrgh
    drrghupdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7RHOaUJeuUnpS2lNTY-jHgZ6lJUsL-tHXzP-tcbMM5y3CSHyN7Fcsg>
    <xmx:7RHOaet7Xn1EEwR8HYiUKtUJWk3Hew56SyxoRg4nio3rmQr7ehrGOw>
    <xmx:7RHOaRTzUyQT4RU5ZKpiEzVlddzm-biqdjPKR4xo7JVAlxQwxUDM5g>
    <xmx:7RHOaUOt0_-Kt3bFSBTHgQVznlvX0flvVJ9n_JnzTTMl7FmVEY3JpA>
    <xmx:7RHOaX7jr8cJ7FUvgOnnDjYO1QyOwxGHPA3NLbE2eHQqjv2HPoyec1Gk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 02:51:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2ed5d77a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 Apr 2026 06:51:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 02 Apr 2026 08:51:18 +0200
Subject: [PATCH v2 1/2] t: work around multibyte bug in quoted heredocs
 with Dash v0.5.13
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260402-pks-tests-with-dash-v2-1-cd7ab11dabc0@pks.im>
References: <20260402-pks-tests-with-dash-v2-0-cd7ab11dabc0@pks.im>
In-Reply-To: <20260402-pks-tests-with-dash-v2-0-cd7ab11dabc0@pks.im>
To: git@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>, 
 Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.15.1

When executing our test suite with Dash v0.5.13.2 one can observe
several test failures that all have the same symptoms: we have a quoted
heredoc that contains multibyte characters, but the final data does not
match what we actually wanted to write. One such example is in t0300,
where we see the diffs like the following:

  --- expect-stdout	2026-04-01 07:25:45.249919440 +0000
  +++ stdout	2026-04-01 07:25:45.254919509 +0000
  @@ -1,5 +1,5 @@
   protocol=https
   host=example.com
  -path=perú.git
  +path=perú.git
   username=foo
   password=bar

While seemingly the same, the data that we've written via the heredoc
contains some invisible bytes. The expected hex representation of the
string is:

  7065 72c3 ba2e 6769 74                 per...git

But what we actually get instead is this string:

  7065 7285 02c3 ba02 852e 6769 74       per.......git

What's important to note here is that the multibyte character exists in
both versions. But in the broken version we see that the bytes are
wrapped in a sequence of "85 02" and "02 85". This is the CTLMBCHAR byte
sequence of Dash, which it uses internally to quote multibyte sequences.

As it turns out, this bug was introduced in c5bf970 (expand: Add
multi-byte support to pmatch, 2024-06-02), which adds multibyte support
to more contexts of Dash. One of these contexts seems to be in heredocs,
and Dash _does_ correctly unquote these multibyte sequences when using
an unquoted heredoc. But the bug seems to be that this unquoting does
not happen in quoted heredocs, and the bug still exists on the latest
"master" branch.

For now, work around the bug by using unquoted heredocs instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0300-credentials.sh   |  4 +++-
 t/t3430-rebase-merges.sh |  6 ++++--
 t/t3902-quoted.sh        | 16 +++++++++-------
 t/t4014-format-patch.sh  | 16 ++++++++++++----
 t/t4201-shortlog.sh      |  4 +++-
 t/t9001-send-email.sh    | 12 +++++++++---
 6 files changed, 40 insertions(+), 18 deletions(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 07aa834d33..64ead1571a 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -675,7 +675,9 @@ test_expect_success 'match percent-encoded values' '
 test_expect_success 'match percent-encoded UTF-8 values in path' '
 	test_config credential.https://example.com.useHttpPath true &&
 	test_config credential.https://example.com/perú.git.helper "$HELPER" &&
-	check fill <<-\EOF
+	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+	# that contain multibyte chars.
+	check fill <<-EOF
 	url=https://example.com/per%C3%BA.git
 	--
 	protocol=https
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index cc627e34a7..84b2d0e664 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -507,9 +507,11 @@ test_expect_success 'octopus merges' '
 	git rebase -i --force-rebase -r HEAD^^ &&
 	test "Hank" = "$(git show -s --format=%an HEAD)" &&
 	test "$before" != $(git rev-parse HEAD) &&
-	test_cmp_graph HEAD^^.. <<-\EOF
+	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+	# that contain multibyte chars.
+	test_cmp_graph HEAD^^.. <<-EOF
 	*-.   Tüntenfüsch
-	|\ \
+	|\\ \\
 	| | * three
 	| * | two
 	| |/
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index f528008c36..8660ec5cb0 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -60,16 +60,18 @@ With SP in it
 "\346\277\261\351\207\216\347\264\224"
 EOF
 
-cat >expect.raw <<\EOF
+# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+# that contain multibyte chars.
+cat >expect.raw <<EOF
 Name
-"Name and a\nLF"
-"Name and an\tHT"
-"Name\""
+"Name and a\\nLF"
+"Name and an\\tHT"
+"Name\\""
 With SP in it
-"濱野\t純"
-"濱野\n純"
+"濱野\\t純"
+"濱野\\n純"
 濱野 純
-"濱野\"純"
+"濱野\\"純"
 濱野/file
 濱野純
 EOF
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index bcdb944017..fc37a7ea42 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1285,7 +1285,9 @@ test_expect_success 'format-patch wraps extremely long from-header (rfc2047)' '
 	check_author "Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar"
 '
 
-cat >expect <<'EOF'
+# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+# that contain multibyte chars.
+cat >expect <<EOF
 From: Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar
  Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo
  Bar Foo Bar Foo Bar Foo Bar <author@example.com>
@@ -1300,7 +1302,9 @@ test_expect_success 'format-patch wraps extremely long from-header (non-ASCII wi
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+# that contain multibyte chars.
+cat >expect <<EOF
 Subject: [PATCH] Foö
 EOF
 test_expect_success 'subject lines are unencoded with --no-encode-email-headers' '
@@ -1312,7 +1316,9 @@ test_expect_success 'subject lines are unencoded with --no-encode-email-headers'
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+# that contain multibyte chars.
+cat >expect <<EOF
 Subject: [PATCH] Foö
 EOF
 test_expect_success 'subject lines are unencoded with format.encodeEmailHeaders=false' '
@@ -1531,7 +1537,9 @@ test_expect_success 'in-body headers trigger content encoding' '
 	test_env GIT_AUTHOR_NAME="éxötìc" test_commit exotic &&
 	test_when_finished "git reset --hard HEAD^" &&
 	git format-patch -1 --stdout --from >patch &&
-	cat >expect <<-\EOF &&
+	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+	# that contain multibyte chars.
+	cat >expect <<-EOF &&
 	From: C O Mitter <committer@example.com>
 	Content-Type: text/plain; charset=UTF-8
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 5f23fc147b..9f41d56d9a 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -105,7 +105,9 @@ test_expect_success 'output from user-defined format is re-wrapped' '
 '
 
 test_expect_success !MINGW,ICONV 'shortlog wrapping' '
-	cat >expect <<\EOF &&
+	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+	# that contain multibyte chars.
+	cat >expect <<EOF &&
 A U Thor (5):
       Test
       This is a very, very long first line for the commit message to see if
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 24f6c76aee..e7ab645a3d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1649,7 +1649,9 @@ test_expect_success $PREREQ 'To headers from files reset each patch' '
 '
 
 test_expect_success $PREREQ 'setup expect' '
-cat >email-using-8bit <<\EOF
+# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+# that contain multibyte chars.
+cat >email-using-8bit <<EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
 Message-ID: <bogus-message-id@example.com>
 From: author@example.com
@@ -1735,7 +1737,9 @@ test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 '
 
 test_expect_success $PREREQ 'setup expect' '
-	cat >email-using-8bit <<-\EOF
+	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+	# that contain multibyte chars.
+	cat >email-using-8bit <<-EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
 	Message-ID: <bogus-message-id@example.com>
 	From: author@example.com
@@ -1764,7 +1768,9 @@ test_expect_success $PREREQ '--8bit-encoding also treats subject' '
 '
 
 test_expect_success $PREREQ 'setup expect' '
-	cat >email-using-8bit <<-\EOF
+	# NOTE: do not quote this heredoc, Dash 0.5.13 has a bug with heredocs
+	# that contain multibyte chars.
+	cat >email-using-8bit <<-EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
 	Message-ID: <bogus-message-id@example.com>
 	From: A U Thor <author@example.com>

-- 
2.53.0.1323.g189a785ab5.dirty

