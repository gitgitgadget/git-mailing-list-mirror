Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D363C944F
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040187; cv=none; b=k4MjEEjrqVGReyXuVbZ6Bs1wnTPsceGoZHCOhcDEEBl1fskDhGj2w/3pK3g91rNSoOr+5gE1/wMIGeS08srhqMomrAe+SmFgJxPHJKwXeEvtkr9qDdIhzFTRHR//mepc0X26eEpBIhsl0tPOFDC4xG7br6ZlvFWdfBx6DD/dpHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040187; c=relaxed/simple;
	bh=DV65t0QO95xZMQWDzDPUicVEIoU8/L/H1u7XJ90fbqI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UsC2ii1SLgQEEr/n5dn3KSdcwrmQWWR1RIgwDS8oC+dOibroDsXP3slOQHB9hbAcKKHPu/tf/ni71WhM3XdXwZYmzPP65FliT1v4VrLtfAMNcPoQYWhIX6u1E3WcXwBIjlkBCr/3S62AxKBmjj4/mMLqiUDS7kmu2AbBrMX9tu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=doGf3ebN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Hy33VBwC; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="doGf3ebN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Hy33VBwC"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 570DF7A030D;
	Wed,  1 Apr 2026 06:43:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 01 Apr 2026 06:43:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1775040185;
	 x=1775126585; bh=PTvMs6RNTWqYfY1f27DeaG8PJzglLkZ0Furk8ReFGS4=; b=
	doGf3ebN5Pe1nucdy9hj9YRSq1kGImwd87nD5Okz7jHZBmelwkMr+0TLC4kHj1aa
	S9BDupJCpX8kc8aroniRPfiQP8XMSdGJK77DSawaGUtUHf2pgyATnM5VwBOt8OKj
	dGTe6YQdCHwm2Hi2fWhOI2VtqvYcTnz5huynf5aLoj9gS+0/Ct5UP/SkXyvTF7Fb
	GSygGs6L11U3byb3L/ByNO95hSk86bY4l/gjAcTGsBX06PSQ15up2KQ/F738OFqI
	Z6uRMO57CgaRpEJvOXme+sbpaZDv9CRQ4vKjNA8L/oAurDcU0Mu15gkC7DiHsMZJ
	y0aq/PCyu0MQ6I/N4eV4Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775040185; x=
	1775126585; bh=PTvMs6RNTWqYfY1f27DeaG8PJzglLkZ0Furk8ReFGS4=; b=H
	y33VBwCGZXCrqmeK6lTZqUBJ5ujvx3XVdQwngpEihYQH5iLfunroBJ6ZtxZobCg9
	i5ttpQxY1f9pCuKzx8VOIBBEFcLOtGYIVCuNR5a4zIQV4OZIdE46J67JIs9YOUkg
	PZR5xtZY7t9fx8v9d2I/2WhfotKY4q7mZGV/j1LZdKHYe8z2HdbLht5UUdwJb8IT
	c0EAhUJkFh6DOC5KLhtL0DmRjMFlLHYbUrJkR5zz2qJPKP+2boLWNv5UGNbLVpvM
	sQs0IcQ48msBLeX9S6EqIBaoJRf1BNAOErgK1D8x4htg901Es7HZu+z1Gqp6RwaW
	Yns7PbE+R58tEmERdJEkA==
X-ME-Sender: <xms:ufbMacHJJM6Uxz-IW6bd3AMG7ULbcSySl_n3sGt5JIUNUkFIaw6keA>
    <xme:ufbMaZo4ccwViiIab2pn5ODLvxxvnbq_qR-BB4RCB8MzeIrAdmxIbKng0yVClPBkD
    RyMrui1Ph93BfTUuv9sFMJUjLxlaolTMIoqmfWXJLVs5oVznCnxcQ>
X-ME-Received: <xmr:ufbMaVQonFor_lvfVMQcOkcYGnOOfoFr_pgm1v9pOvbnkyFdHMZTivTQVHK6-RcENb2Q0AU_RbUBhOGnaqLIlPoZKsbDV_HLgXr2On1QEIk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    fhhfejveduiedtgeetvdelgfetkefhueeuleeghfelveffieefvdevuefhtedtleenucff
    ohhmrghinhephhhtthhpshhhohhsthgvgigrmhhplhgvrdgtohhmpdgvgigrmhhplhgvrd
    gtohhmpdhhthhtphhsughifhhfqddqghhithgrthhtfeegfedtqdhrvggsrghsvgdqmhgv
    rhhgvghsrdhshhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopehhvghrsggvrhhtsehgohhnughorhdrrghprghnrgdrohhrgh
    drrghupdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:ufbMaWOb-pdo5SEgDTulWrdHjhrkShRrcphkNZNm3gGoC0vzW6YZbg>
    <xmx:ufbMaYMjESuXc7lap-SL9P_TCHBM0J1xxR-Y1jxbrj1RyWs56rgXeg>
    <xmx:ufbMaWtUwvsDt5jNLW4_jZOlRHY2O6MGNEzHy1QPHgBevzWEYZkbaA>
    <xmx:ufbMaSWPm9BSemIA_un64kKdV5hH6nA3VyBqyG-uUqydkGg3O_VzrQ>
    <xmx:ufbMaY0GEPPW295HGkC019ou3uyxLUCTQ40qgvHw0QkubRmcRELiB4-T>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 06:43:04 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d1f2bfbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Apr 2026 10:43:04 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Apr 2026 12:42:58 +0200
Subject: [PATCH 1/2] t: work around multibyte bug in quoted heredocs with
 Dash v0.5.13
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-pks-tests-with-dash-v1-1-d70b5040aa5d@pks.im>
References: <20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im>
In-Reply-To: <20260401-pks-tests-with-dash-v1-0-d70b5040aa5d@pks.im>
To: git@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: b4 0.15.0

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
 t/t0300-credentials.sh   |  2 +-
 t/t3430-rebase-merges.sh |  4 ++--
 t/t3902-quoted.sh        | 14 +++++++-------
 t/t4014-format-patch.sh  |  8 ++++----
 t/t4201-shortlog.sh      |  2 +-
 t/t9001-send-email.sh    |  6 +++---
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
index 07aa834d33..fda6760955 100755
--- a/t/t0300-credentials.sh
+++ b/t/t0300-credentials.sh
@@ -675,7 +675,7 @@ test_expect_success 'match percent-encoded values' '
 test_expect_success 'match percent-encoded UTF-8 values in path' '
 	test_config credential.https://example.com.useHttpPath true &&
 	test_config credential.https://example.com/perú.git.helper "$HELPER" &&
-	check fill <<-\EOF
+	check fill <<-EOF
 	url=https://example.com/per%C3%BA.git
 	--
 	protocol=https
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index cc627e34a7..d3dffbb830 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -507,9 +507,9 @@ test_expect_success 'octopus merges' '
 	git rebase -i --force-rebase -r HEAD^^ &&
 	test "Hank" = "$(git show -s --format=%an HEAD)" &&
 	test "$before" != $(git rev-parse HEAD) &&
-	test_cmp_graph HEAD^^.. <<-\EOF
+	test_cmp_graph HEAD^^.. <<-EOF
 	*-.   Tüntenfüsch
-	|\ \
+	|\\ \\
 	| | * three
 	| * | two
 	| |/
diff --git a/t/t3902-quoted.sh b/t/t3902-quoted.sh
index f528008c36..c3b45d991e 100755
--- a/t/t3902-quoted.sh
+++ b/t/t3902-quoted.sh
@@ -60,16 +60,16 @@ With SP in it
 "\346\277\261\351\207\216\347\264\224"
 EOF
 
-cat >expect.raw <<\EOF
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
index bcdb944017..d22b7f348e 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1285,7 +1285,7 @@ test_expect_success 'format-patch wraps extremely long from-header (rfc2047)' '
 	check_author "Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar"
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 From: Foö Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar
  Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo Bar Foo
  Bar Foo Bar Foo Bar Foo Bar <author@example.com>
@@ -1300,7 +1300,7 @@ test_expect_success 'format-patch wraps extremely long from-header (non-ASCII wi
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 Subject: [PATCH] Foö
 EOF
 test_expect_success 'subject lines are unencoded with --no-encode-email-headers' '
@@ -1312,7 +1312,7 @@ test_expect_success 'subject lines are unencoded with --no-encode-email-headers'
 	test_cmp expect actual
 '
 
-cat >expect <<'EOF'
+cat >expect <<EOF
 Subject: [PATCH] Foö
 EOF
 test_expect_success 'subject lines are unencoded with format.encodeEmailHeaders=false' '
@@ -1531,7 +1531,7 @@ test_expect_success 'in-body headers trigger content encoding' '
 	test_env GIT_AUTHOR_NAME="éxötìc" test_commit exotic &&
 	test_when_finished "git reset --hard HEAD^" &&
 	git format-patch -1 --stdout --from >patch &&
-	cat >expect <<-\EOF &&
+	cat >expect <<-EOF &&
 	From: C O Mitter <committer@example.com>
 	Content-Type: text/plain; charset=UTF-8
 
diff --git a/t/t4201-shortlog.sh b/t/t4201-shortlog.sh
index 5f23fc147b..d73c9f5204 100755
--- a/t/t4201-shortlog.sh
+++ b/t/t4201-shortlog.sh
@@ -105,7 +105,7 @@ test_expect_success 'output from user-defined format is re-wrapped' '
 '
 
 test_expect_success !MINGW,ICONV 'shortlog wrapping' '
-	cat >expect <<\EOF &&
+	cat >expect <<EOF &&
 A U Thor (5):
       Test
       This is a very, very long first line for the commit message to see if
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 24f6c76aee..3612d32d39 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1649,7 +1649,7 @@ test_expect_success $PREREQ 'To headers from files reset each patch' '
 '
 
 test_expect_success $PREREQ 'setup expect' '
-cat >email-using-8bit <<\EOF
+cat >email-using-8bit <<EOF
 From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
 Message-ID: <bogus-message-id@example.com>
 From: author@example.com
@@ -1735,7 +1735,7 @@ test_expect_success $PREREQ '--8bit-encoding overrides sendemail.8bitEncoding' '
 '
 
 test_expect_success $PREREQ 'setup expect' '
-	cat >email-using-8bit <<-\EOF
+	cat >email-using-8bit <<-EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
 	Message-ID: <bogus-message-id@example.com>
 	From: author@example.com
@@ -1764,7 +1764,7 @@ test_expect_success $PREREQ '--8bit-encoding also treats subject' '
 '
 
 test_expect_success $PREREQ 'setup expect' '
-	cat >email-using-8bit <<-\EOF
+	cat >email-using-8bit <<-EOF
 	From fe6ecc66ece37198fe5db91fa2fc41d9f4fe5cc4 Mon Sep 17 00:00:00 2001
 	Message-ID: <bogus-message-id@example.com>
 	From: A U Thor <author@example.com>

-- 
2.53.0.1185.g05d4b7b318.dirty

