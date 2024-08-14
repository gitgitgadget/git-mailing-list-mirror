Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9530E13AA3F
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618385; cv=none; b=AadTxAKONkBrZoNUhpRVmAnpv6md0DxOBt2a+Ogqv4zqCeT9Bi7UyyQ37FBkTuG4xcxpTS7DI6A9OO3xw3cnz1LR+tKNTPXD8EBhZwwYsEfFylfg7YR1lz0hphTwWQh4/Xths6mORAJw8b5NZaSb0PyQvcBK0G/1hQNlAnQGyaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618385; c=relaxed/simple;
	bh=KL6DdFe9xWlazNi4VrJ/s4mP4DpkcuV3NuegcZtU2d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtLk7Z/dL3oD1nknBjzDtX64GfOd1rJTMBmzaafzrkv0IVAKux0JJkUrgKDW/omnKd956iWC0xttTgb8eye3jQSsahXANa3VoKweud+bxnNLkHfwCnFZnm7PUwD8W2XL+NGog+11wqakYzXlTMq44PNsJbijfpMgGp9M2rTFfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o63qjLoa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vbIQupay; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o63qjLoa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vbIQupay"
Received: from phl-compute-07.internal (phl-compute-07.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id C2F7D138946B;
	Wed, 14 Aug 2024 02:53:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Wed, 14 Aug 2024 02:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618381; x=1723704781; bh=fpd5A/T0i0
	ePaCQ8LacHSAeCVf4iiGWIgmhqFp2aUTg=; b=o63qjLoa8LxijNfP5cmrXSHonu
	7JK9poEjVCisvejq0/DbYJGwUd/cj4qVEikeymONGfKCvaKb4Ce5P/ybhJzQIkOJ
	Pp59GREm7irESkW7IfUq+AXQhulLYoW11hd5Um/YPKOvlh2tpt8E12LVRB5wDiRz
	jr9VBelOOr/EC6mKoidshqbDSh5vBgxD2AGJjXTDlisz5t6coKDHylWZT21bxrj/
	wV8u1pQlpHEWIuhdiodP5vtwbFP4OkfEQoM9wEBUegEw//BBCdl51viM50BFmTXd
	DP4tC4TVncZDdGZK7V/He+sR9RGOoQy0NXLTfJwGJEQLE4pA2xJD362J1yyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618381; x=1723704781; bh=fpd5A/T0i0ePaCQ8LacHSAeCVf4i
	iGWIgmhqFp2aUTg=; b=vbIQupayBtmYRtmZLAzOqq5S2HbKJ0z/7NC0ZUcH+H7+
	nsC0SlaWA5n5sE/+Iip6QIPxl+QBvHlta4wSHHw57voqUabD2Qyzqw/DGDjxR40T
	KgMTCWu0jAthE2b7Bj0q6fCoxuXb19PMg/NNNdNcBD7GIUBkNDpT7FMkFrXl/oro
	0W1a3JoOn0oEzpADzyWsQtifmR+lqe4GmHd1+nuu7GL9uqNlnyE+NSwKf6l5QCZP
	YG+QJFxEDVJs0e/xUJfbN4t1zGQ91Qz0rAEtFBpLmmKRYzBGAO18wNWV5pR9qpD2
	r0LyNBZyY1kDNDT1poCknHKyFGp2EQb0kc55YQRmYQ==
X-ME-Sender: <xms:TVS8ZtkbbDaxsziiHhpv1dajN49l7c8Pimre7v3xytOGx-MINNeFGw>
    <xme:TVS8Zo3tDm_EU-KPkVwAZsh9deEaz78_XQYFWNEL-4fdWRCRsK2QpnHIuctVvaCzm
    ByTlUkDw7WEmXIu2g>
X-ME-Received: <xmr:TVS8ZjorJO71B1JeuX3P9zy1ELzFVOYwA6j1ftmL0SRIqPaNRNrUXdocJnq__rUdR9AIgHe5ZzSlwl7GkFgB7N2XjWdnTRZBoKtvh6DMyZPMTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehjrghmvghssehjrghmvghslhhiuhdrihhopdhrtg
    hpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:TVS8Ztnvl04nJvouVbP8p10ejhk5Zk_kK485XPhcVnBrM8nsqDTNqQ>
    <xmx:TVS8Zr3ZfX6CK8fKdELO2hxZgKa8oeSKNZZ5Ljc6bvYJLxEPNHrydA>
    <xmx:TVS8ZssfWA4_wdYOC4ZhXA9vbIX73gO037y4sJJJ7Zzx2AKyV-GkpA>
    <xmx:TVS8ZvV81xN063BR0eaclC888cSuDsftvgcXH3HWV2GpOKF34y6W6w>
    <xmx:TVS8ZlopbFObwU_2BE3hzb2rIpEsmeYKug7B6i-m-8bkls1rBeVhbFVp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:53:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a5ae68a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:41 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 22/22] builtin/diff: free symmetric diff members
Message-ID: <ee252e752c7bee0dea6767c5a53dd6656b4c35db.1723614263.git.ps@pks.im>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723614263.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723614263.git.ps@pks.im>

We populate a `struct symdiff` in case the user has requested a
symmetric diff. Part of this is to populate a `skip` bitmap that
indicates which commits shall be ignored in the diff. But while this
bitmap is dynamically allocated, we never free it.

Fix this by introducing and calling a new `symdiff_release()` function
that does this for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/diff.c                       | 6 ++++++
 t/t4068-diff-symmetric-merge-base.sh | 1 +
 t/t4108-apply-threeway.sh            | 1 +
 3 files changed, 8 insertions(+)

diff --git a/builtin/diff.c b/builtin/diff.c
index 9b6cdabe15..6eac445579 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -388,6 +388,11 @@ static void symdiff_prepare(struct rev_info *rev, struct symdiff *sym)
 	sym->skip = map;
 }
 
+static void symdiff_release(struct symdiff *sdiff)
+{
+	bitmap_free(sdiff->skip);
+}
+
 int cmd_diff(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -619,6 +624,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		refresh_index_quietly();
 	release_revisions(&rev);
 	object_array_clear(&ent);
+	symdiff_release(&sdiff);
 	UNLEAK(blob);
 	return result;
 }
diff --git a/t/t4068-diff-symmetric-merge-base.sh b/t/t4068-diff-symmetric-merge-base.sh
index eff63c16b0..4d6565e728 100755
--- a/t/t4068-diff-symmetric-merge-base.sh
+++ b/t/t4068-diff-symmetric-merge-base.sh
@@ -5,6 +5,7 @@ test_description='behavior of diff with symmetric-diff setups and --merge-base'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # build these situations:
diff --git a/t/t4108-apply-threeway.sh b/t/t4108-apply-threeway.sh
index c558282bc0..3211e1e65f 100755
--- a/t/t4108-apply-threeway.sh
+++ b/t/t4108-apply-threeway.sh
@@ -5,6 +5,7 @@ test_description='git apply --3way'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 print_sanitized_conflicted_diff () {
-- 
2.46.0.46.g406f326d27.dirty

