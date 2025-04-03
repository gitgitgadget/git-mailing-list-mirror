Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FD51A5B86
	for <git@vger.kernel.org>; Thu,  3 Apr 2025 05:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743656775; cv=none; b=A0IY+B0ZbSPyQJmYsebS20+p7bHjyDqb6YhVfHybyXMd1HEv41J9beYD8WJKU4Ad9+afJse1nmh2WtRI22sLvI2NTLtwqfHHRJc9Wkt+9qKEHSJ8kjBeRKu+lBkfjwK0Ihmj9THwRcntza48ayfh6ykHCOXcX5g7n6RPw6eibTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743656775; c=relaxed/simple;
	bh=dODQYpPU5a4fpeAU9fHLvNr1v0H+2X34n3c94Reo42Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVZC37oZH55LbI4RzNjoqcuJqYtC/TB1BoyznevcOdtKKGSC0AWMjGV2Nlgvh4P4p8tGAPPIBGcWD+jTNOaLgt2U8H1MulhUKvB0D0uxUz3vUFrVRZqeN5ezBQ4Gln7RBZka/ZVdU+m5LmYPAznbR9yW70k++vvKjUCqOUOiDzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F5EmLXRY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beesfAql; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F5EmLXRY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beesfAql"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DD2BA254021A;
	Thu,  3 Apr 2025 01:06:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 03 Apr 2025 01:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743656772;
	 x=1743743172; bh=cMLlelci6h78QKIQuXI5J9cHv4IEc79yrG3uJzVyoOY=; b=
	F5EmLXRYKCd2XWObo1udRZxGbk8hhC432TbmsJCFNGIKIk76RvnVxrXZn/r0yD5H
	s5JbvZny5TroVWbgTGvwm4Ez7GjmOvF8lHH5uOesk4zg9CMxpxahGX9Z3S+RLSmm
	KUABL2SKefrLLt0jB5ywxNaX0ZDN2NDfz55zvw4guTaul8K/FFhOz5SG71Y/WFER
	7zeECScvpl/1GeO65vkMKPXtHuLBORUCV//VgWrbLKruxXDYJCQ1ztcyENPfsHZh
	9xnST0BSWrYq3whM85V4IeVlIlCd6MhYby4sAQB3NbsDIqZTMHxbQq9a0Gns/SbR
	dSFHs9rMLhPeO1pFZHG8Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743656772; x=
	1743743172; bh=cMLlelci6h78QKIQuXI5J9cHv4IEc79yrG3uJzVyoOY=; b=b
	eesfAqlPILtML+ndjyCBG/1zRMTC7pA1/Qvc7/Brxe9F8Awxr3P1pfNB2e2dSp7J
	mDdkdgdpPi7XQ1Jek+L+3B87jlEpGRcfpEnRCCbZ8W/a1q4P63z3oBrC4xcJtfuQ
	Tqou4L4ldsrfmcOMbFEFzYs6DuKjxemKMwXa+rIafUpxYvykPQcnTLhaJRgG27+u
	iyi16xmuxNJwNWrBD2WhbTPNI4pHjJO0H+//Zj50ya+MgjviC9v298lln4BUNVfU
	Nou9XCkdvNf+5cacUUs4nugwq1yeBysiHblbTkfWs1kdJZz2fNKMj0Pe7bRfD0Ew
	Da0TpWFXmJVJpehtXETuA==
X-ME-Sender: <xms:RBfuZ0_kqtEfj3pX8WlEAxT4JE6sAMAuwnFHX8GXGewl4qtP3odMKA>
    <xme:RBfuZ8tLrBHOY9SEMbO4R3NigB_Qx_TVXb1JBMzgCxHJCJvKHcT_iyeTVLWXzuWG8
    fHF0i_SmCFzojoXqw>
X-ME-Received: <xmr:RBfuZ6D_-DJT4zmyXcEJU_7c8JmoD8Bh9EEmSlrkPS5vFHhj2uJdev-tKxL2h2o404iEEzI1lzPc9XK6MB5Z3AU5k4AIE6IlcPLsuq3Gx7ZSVFA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlih
    hnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:RBfuZ0cDEhYAO88kcntj3jYXNnkw0UIhBtZ1wQuKvj5lWA3au1Crvg>
    <xmx:RBfuZ5PzVGi1lzXwZj0sA8_ndzZPe3dLa9DpYFjSxyuYsmXZ8OrVCw>
    <xmx:RBfuZ-ljbEXCPX3dfjJXfFaO51UA-pyaov7PfMa5t30_eoF5kMxOkQ>
    <xmx:RBfuZ7txU4yAR2FMlm51uFJqm4SgFCGKJPxdrljPKy2Rvycv-4AhIw>
    <xmx:RBfuZ4CIOKIJfm-kzbfyuu4ZNJg4x_u78jDV1IZ5V9F8jsV3t0PMu-ZI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Apr 2025 01:06:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 87e2861b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Apr 2025 05:06:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 03 Apr 2025 07:06:06 +0200
Subject: [PATCH v4 15/20] t/lib-t6000: refactor `name_from_description()`
 to not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250403-b4-pks-t-perlless-v4-15-be20ac3db39a@pks.im>
References: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
In-Reply-To: <20250403-b4-pks-t-perlless-v4-0-be20ac3db39a@pks.im>
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
2.49.0.604.gff1f9ca942.dirty

