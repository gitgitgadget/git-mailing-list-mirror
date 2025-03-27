Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5A212F8F
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071851; cv=none; b=Xu5ZeGzPhGp4XsMS5kRf6Ud8Tl83Llw3ykGMrU2/JJvDrWrCwGyj3AFNhYbNcZFcYnusnn6NbN0VgRWFwJj7VXPJQdQnjZv+eLW1SPdOMVz0GLlEq8xBSD7i+UkpuwtqRf9f3Fk/qsJTRAxqocKgyughSyH8BdJrHR5jos6xfMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071851; c=relaxed/simple;
	bh=VOGHVEB5DBeBsc1IOz0MKfPvuvyDiSI9QbAo+vfau2E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W4mt9Jc6Up5BHCBhaETFKeP5iN6AOuFbar1YAeKk0dULv8ZhOOTrbSBgA4bg63ocUDPZVt3cvKAVNMq4eui+sGz9zA78ThD3N+CfcnBRlEp3eyUq71OVVEsAS7Ayu+Fsa45vZWccQRCY9VxlIzhFxPs65M1kBGhLEpOfr9aEUs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M1sjyehU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cAIS9JFR; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M1sjyehU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cAIS9JFR"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id A4B9D1383844;
	Thu, 27 Mar 2025 06:37:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 27 Mar 2025 06:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071848;
	 x=1743158248; bh=0JV8nY16uI93FpC8oc8O/Ba/p4JfeYQlUD8rsognpdk=; b=
	M1sjyehULbK6OixhX5xeUBLIPlVhLDX5ToGoD1F6H1e+u8tYUZJer5Ts90Gl+oB5
	2+o+BDoTtQYdbL/PO9ccnOyMtdlzVfFyt9trvDsJ1Hn31+Gz+QSCs/ObK1m/9Ged
	xDXI9Dh/r7S1BKm8jv4EA4TuBzQABbcsLr/WJghmLKBwLirEgytmWxwIhbeacpvN
	G84y4TuSeMfuyRvBURSOry94/APiXeEFMtkXz7N/F2pElwezYyagxYedVRNCrnwF
	AoVxNM0VVTh9efgXaDwxKv9B6veyQbsO7tGGcMRnDGaJex6OWHoYDPaqdugQh6E+
	+M7qO8fqWDbcB0SNtqxT9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071848; x=
	1743158248; bh=0JV8nY16uI93FpC8oc8O/Ba/p4JfeYQlUD8rsognpdk=; b=c
	AIS9JFRfZ1wu5BtaBW4bqEQBbGL+r9lxWsfuBvpDbCqyEOHJLFU7ckOjAMcbqQLe
	aOsOrThkTGaH7NaQ4UKfTTpHi0m4mgrg+Eg5cjS8+xhEtxos1SIlmb8gZNOzq75f
	nntIaD0uX5wZZ6aP55F3QQGACNEUadXPYPHqTXTS3rG1KFW3/EGgQRv2WzsqAcJE
	l7hKsUD4Zfmpi+LnXshLf6Mwl8xBGI2UvCJ8GQ9UpvGefiCWrD/AxC5VKV9f0KKC
	8LsULxsQytBrnsWgoarAeZuiOkTdA73w/qbgETX3LMGWJfI4jEm+KzmAmUB5fQ7M
	XnJAsJkxmL/PLH6cHq1nA==
X-ME-Sender: <xms:aCrlZzDhRZoTJoRXKs0YxZvKA4bJHfbjnF5x-FHT_syIS9arvY728w>
    <xme:aCrlZ5gdSPgbBSb-mKjJf4lbv-3W23IY2eritkMCxFhFARUa-p0kyPjj1OSgNqa9P
    o0vzQ207IrhmiVayQ>
X-ME-Received: <xmr:aCrlZ-mBy5BSS1tOkzRqe98uU5qhXWfJx5PQq-5Xt-PGFFfnGu1Hy5k1Sa-ZVEe1C7dct_4ZmNTLvdOwZWwCN9c1DORjAdGpJHS895ViysEyAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdr
    tghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aCrlZ1wSDZO243GIvSYkRdz3ZcV3uLcNmrZ8roNwJMK1HuKPqk-hWw>
    <xmx:aCrlZ4Q9I0xzpx9mbvWOqG4p5T85avIHk57wWTURpA944iQHqqaBNA>
    <xmx:aCrlZ4Zl3MJW9dj7tK8rrpN1VLm2EwFHeBg_GF8LH0qUeiqyJXf7Xg>
    <xmx:aCrlZ5QvMznAhkr5RmIL9frZswhL--GpBp_todrNJXbsMktE6DMp7w>
    <xmx:aCrlZ9K0IuLjar4qtJiJQcH7zTs06jEaGHBhnpbshvTVvKY2q55IO-gK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:27 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2cd40d7e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:17 +0100
Subject: [PATCH v3 19/20] t5316: refactor `max_chain()` to not depend on
 Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-19-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `max_chain()` helper function is used to extract the maximum delta
chain of a packfile as printed by git-index-pack(1). The script uses
Perl to extract that data, but it can be trivially refactored to use
awk(1) instead.

Refactor the helper accordingly so that we can drop a couple of
PERL_TEST_HELPERS prerequisites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5316-pack-delta-depth.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t5316-pack-delta-depth.sh b/t/t5316-pack-delta-depth.sh
index cd947b5a5ef..defaa06d650 100755
--- a/t/t5316-pack-delta-depth.sh
+++ b/t/t5316-pack-delta-depth.sh
@@ -76,18 +76,18 @@ test_expect_success 'create series of packs' '
 
 max_chain() {
 	git index-pack --verify-stat-only "$1" >output &&
-	perl -lne '
-	  BEGIN { $len = 0 }
-	  /chain length = (\d+)/ and $len = $1;
-	  END { print $len }
-	' output
+	awk '
+		BEGIN { len=0 }
+		/chain length = [0-9]+:/{ len=$4 }
+		END { print len }
+	' <output | tr -d ':'
 }
 
 # Note that this whole setup is pretty reliant on the current
 # packing heuristics. We double-check that our test case
 # actually produces a long chain. If it doesn't, it should be
 # adjusted (or scrapped if the heuristics have become too unreliable)
-test_expect_success PERL_TEST_HELPERS 'packing produces a long delta' '
+test_expect_success 'packing produces a long delta' '
 	# Use --window=0 to make sure we are seeing reused deltas,
 	# not computing a new long chain.
 	pack=$(git pack-objects --all --window=0 </dev/null pack) &&
@@ -96,21 +96,21 @@ test_expect_success PERL_TEST_HELPERS 'packing produces a long delta' '
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS '--depth limits depth' '
+test_expect_success '--depth limits depth' '
 	pack=$(git pack-objects --all --depth=5 </dev/null pack) &&
 	echo 5 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS '--depth=0 disables deltas' '
+test_expect_success '--depth=0 disables deltas' '
 	pack=$(git pack-objects --all --depth=0 </dev/null pack) &&
 	echo 0 >expect &&
 	max_chain pack-$pack.pack >actual &&
 	test_cmp expect actual
 '
 
-test_expect_success PERL_TEST_HELPERS 'negative depth disables deltas' '
+test_expect_success 'negative depth disables deltas' '
 	pack=$(git pack-objects --all --depth=-1 </dev/null pack) &&
 	echo 0 >expect &&
 	max_chain pack-$pack.pack >actual &&

-- 
2.49.0.472.ge94155a9ec.dirty

