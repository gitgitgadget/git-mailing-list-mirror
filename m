Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF695212B0C
	for <git@vger.kernel.org>; Thu, 27 Mar 2025 10:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743071845; cv=none; b=fO2gwcwpX9VDWNu4tRrBNcLPMlE6PL0uiprqQ2bO9ryS4pIjF8+BMvDherGkVi0+M0gJCdkMcqPLAb79SnVHKppuLrWd7ZkuViAxtw+BZtOG0w8nS32scXiyrfPOXUStsuwzK+GGlAsXUSfAO//ADcLU+BFdKeYiEKLmtH9imOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743071845; c=relaxed/simple;
	bh=1h48IVzmJCqnPonehXdDtVit1PATRGJbnIJeE7KqacA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBt9qV9na6QlXI3PcMPiPbuLA9a7SWWsyyNejE3i6DDd8bf6Z7/rM0/dJxFp/vWLu7n/aAU34zYGL0bAsMai/2Uizr92JjBiHbTC1Q0T+D6vGoTUx3ZOB0OfaYIzM214C+AOFyEfLn3+Pjm8KAAo/cqVKOabtqjZEDqv6gPD/gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IdxOamir; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JddxhJnK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IdxOamir";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JddxhJnK"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 501DC1140141;
	Thu, 27 Mar 2025 06:37:23 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 27 Mar 2025 06:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743071843;
	 x=1743158243; bh=d+Ztq+x3QjSGjj5OnmS0JLh7eUizho7Qq93aRVWexJ0=; b=
	IdxOamir1XkaTQNboLeoQnrnPZ7XAuYvwwg84ocdw5TdQhZamNG8uGnciiIszs2T
	p+YXpjKpr/ZHSuVRyF5zyCkF57io57243+yIFZ7NPFQ0JyLVxSdH3Dmi8w5evTSu
	fK3kDWNij8XnQMSLCT/JViyiOEGEiN5ObAtiLvl6RKhWe4UVQPcXDj5Emwxgu1JL
	d3z4oTrMOqZb00Xmhx8ggJxbLDJM9ER3jpZcbkqsmdcVrqlDPNzydOo3grmguCQF
	E0N26mDHhUwZ3iRTuahdnBrCpHRBLt7aTkvzBRrS+WJ7ogOqPfTYOtTaa4pWEEtw
	LIlVUx3R4sgrEBKiXbZLsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743071843; x=
	1743158243; bh=d+Ztq+x3QjSGjj5OnmS0JLh7eUizho7Qq93aRVWexJ0=; b=J
	ddxhJnKTPyD8BOnW+d6QWWMMV53dT/oT/U46FyLG/LBQcGj62tP5MCCIQkb6qOoe
	YGXiiQpKvNdR/HrBcuXcNfDPWwGIxJ7GWOWSbC78M6t1GFpdeZyzWI8ySu8Kergu
	o9oot8bHyE6Rl7jh9Vrb79wMDRBXAQhUFnu3EZXDaQVMNzk5NWElbhUTi38D272i
	0HHc15VHCXXqWkkkGxd49jkAmSNpcAyAIxAAkn6KUGzpU2qn18tZ5AkuDchN4A6z
	d0W+1lE2zyJzRDFU9SQVbppUKT58gIJq6bVDxOKIhCitQllFG1cQOF0zuzcCEZ2M
	gP0KaD9pXT9k2m/XJ4HnA==
X-ME-Sender: <xms:YyrlZ_g3OqCd6UHtqMxeXnyc3qeaV8tUbQ_HVgDtOBj2lMBImt6WYA>
    <xme:YyrlZ8DAqHfe_dleVtpn8Bge1hZIeXSUdD4o3cUu6RD4b7W_uFbhSpgrzQ15fXQOf
    65ERlVTP1DatYwZug>
X-ME-Received: <xmr:YyrlZ_HpZrjziEDKtTKPjfWMY2NLAiVqXAG4RFAmrENyCEvJCR_IzHbCWi6c8m6WUvu0ozpvyyeg5Vxrj71rJ6reqXbmgUx-r8QRMCyIHS12Sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieekudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:YyrlZ8SND-fx5EgiOVKzN9RsEc4C-wK41EWvQoE5D0pxahbtAGHMTA>
    <xmx:YyrlZ8w48T-sp1Vh8P8qgKOXSO6cIEo6zSHrPZsCJyDpZ-YvBqAG_A>
    <xmx:YyrlZy4Ts7eDAK3t5tbzOhcXIFggPt71hZr68F75cMIYmCOg-jr_Kg>
    <xmx:YyrlZxwQgB8cPPe1UgGYCb9HpXz_hzon7wj5OVwfYXwfRjkxHNbnIQ>
    <xmx:YyrlZ7rToLmvhDl4CE6ZMmhBMqg73wX_hI2-1-Yykccfaxvc2dtYU2WS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 27 Mar 2025 06:37:22 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f0c2a9e9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 27 Mar 2025 10:37:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 27 Mar 2025 11:37:13 +0100
Subject: [PATCH v3 15/20] t/lib-t6000: refactor `name_from_description()`
 to not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250327-b4-pks-t-perlless-v3-15-b436de9da1b8@pks.im>
References: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
In-Reply-To: <20250327-b4-pks-t-perlless-v3-0-b436de9da1b8@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Eric Sunshine <sunshine@sunshineco.com>, 
 Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

The `name_from_description()` test helper uses Perl to munge a given
description and convert it into a name. Refactor it to instead use a
combination of sed(1) and tr(1) so that we drop PERL_TEST_HELPERS
prerequisites in users of this library.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/lib-t6000.sh                 | 13 ++++++-------
 t/t6002-rev-list-bisect.sh     |  6 ------
 t/t6003-rev-list-topo-order.sh |  6 ------
 3 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
index fba6778ca35..35c54724650 100644
--- a/t/lib-t6000.sh
+++ b/t/lib-t6000.sh
@@ -109,13 +109,12 @@ check_output () {
 # All alphanums translated into -'s which are then compressed and stripped
 # from front and back.
 name_from_description () {
-	perl -pe '
-		s/[^A-Za-z0-9.]/-/g;
-		s/-+/-/g;
-		s/-$//;
-		s/^-//;
-		y/A-Z/a-z/;
-	'
+	sed \
+		-e 's/[^A-Za-z0-9.]/-/g' \
+		-e 's/--*/-/g' \
+		-e 's/-$//' \
+		-e 's/^-//' \
+		-e 'y/A-Z/a-z/'
 }
 
 
diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index 5e1482aff78..daa009c9a1b 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -7,12 +7,6 @@ test_description='Tests git rev-list --bisect functionality'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping rev-list bisect tests; Perl not available'
-	test_done
-fi
-
 # usage: test_bisection max-diff bisect-option head ^prune...
 #
 # e.g. test_bisection 1 --bisect l1 ^l0
diff --git a/t/t6003-rev-list-topo-order.sh b/t/t6003-rev-list-topo-order.sh
index 02dd4127aff..0d7055d46d4 100755
--- a/t/t6003-rev-list-topo-order.sh
+++ b/t/t6003-rev-list-topo-order.sh
@@ -8,12 +8,6 @@ test_description='Tests git rev-list --topo-order functionality'
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-t6000.sh # t6xxx specific functions
 
-if ! test_have_prereq PERL_TEST_HELPERS
-then
-	skip_all='skipping rev-list topo-order tests; Perl not available'
-	test_done
-fi
-
 list_duplicates()
 {
     "$@" | sort | uniq -d

-- 
2.49.0.472.ge94155a9ec.dirty

