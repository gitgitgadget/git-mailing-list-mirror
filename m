Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35976224B00
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 09:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742463348; cv=none; b=KlvDpWh/V0eUimqldRAt6uI/ikJWgRVn/rcI4SK1DQC+zYR9eAxC7KL7Mq9/d9rqu/je7hIOnmD9YcMztAiGrfCLtGoZjDbbsXj9yXYqOZjJnJbaQcmNAgRGKHQ/4nWc6ejTpwsvmyAfBlial2JlKf0C0DT7pHE1DAq9Z0VLCuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742463348; c=relaxed/simple;
	bh=lzWknO6X1mMVCkHaZkEgZjRtyG8bzYdgsitbGKD34mI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ChB0psET1aZJTxxxBHyunCBXdwpCOVYz4c5gbsxfYi2JQybkB4rROLBqOvs4i0xnwdCoR3RJ8NMH6JS/mjj5ajfhfgXraHO+rJcq3DdSVkxAPSi18d7ptH2KaiFV9/1qbwTk5E4kSGMwcB0zms42sRRmdBwgAeBf4CxIFLwYTVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cr8PNxri; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=3RA7Zb9T; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cr8PNxri";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="3RA7Zb9T"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 2F7DB11401B1;
	Thu, 20 Mar 2025 05:35:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Thu, 20 Mar 2025 05:35:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742463346;
	 x=1742549746; bh=u6ynafakCZ+tDrPExwMcFwIXK+6NvEei5uAhTIqdjIs=; b=
	cr8PNxrii8pUcWeRzT5wg/DsTEe+ye/YOU27cA61sBAhDX3lfPt+ew48gTtaGro1
	2w67FoG0VHTeBvwtiASLIXJ8DTvmnQUG0dtpvTCHARmrllMbLPT82OxwYmQqmrCu
	K9WVsEBOp8IeZPrvFbTJvbMSOQHlBxcAAMpwfrUJ8s3Ve7n2q+kFjVysNnzZOMJb
	n4+mdTX7mVtlc8nE8WfMIXwO2qCosuJqukJMuXpvRs7fgIr+FQpTxZ9tXKh6JKJ0
	nfMFMfSL0eGUKrjQZQ9b3j2Af/NmGIMvCogZDVY596k1BYoWnl+0LpA0rP0EVHWt
	oht+7GgDdyqqiOgsHt/AAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742463346; x=
	1742549746; bh=u6ynafakCZ+tDrPExwMcFwIXK+6NvEei5uAhTIqdjIs=; b=3
	RA7Zb9TasWEU4ItneqKLlrcuVc/CnkCohckP3OKYlQ5HZDM1y3PsiPsjlSZ00Tni
	wz9G6iGkyLuurYgjdmhpgyMSg2vmXkeiPybDhGP5F2L5wzBD4sdN8HkCB25X/AqO
	9xmawEnMMhMaaG8gizcaGM0337nR1iqdQZb1gl4i3xFajEg/rnpGi9Ex0PtNm9Ek
	/Y3XvLg+sZ815wJAUvkilLXPMAftRlfB4vkbrFBWlAKUJWQK9e/Rz3OsesmHVjv1
	vV3TVKhqQqdyDEOqtG5Up16fBSHXZuZF5QOHVr82ntpZO/CA9+Kx62YiOObq+ORh
	B3G5vOXrsbmDWWAlvoIgw==
X-ME-Sender: <xms:ceHbZzK7C_0V83MRmzoZqPym4T1u5NkFpbg7rPKvy9vFl0IfAEtYng>
    <xme:ceHbZ3K8O37Bd-hGifUcioB-Z2Z3QHhlM1A1WGo7XcTQiKUMNwBihDbapVyLxJ-mC
    sdpW5nEWchi7uK2Mw>
X-ME-Received: <xmr:ceHbZ7sANvcif2gIt8BMKI58IzlJDrfHa5TQnUIm291N-_zkXCbBn1o-R59Ca_QRns_pHzLB5zEo9o43p6Gppw1Jkuk_h4Ca7iM6WXa2Gh-cZ0E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:ceHbZ8a97eEDOvRzEqTc7he9yQJYEKXort4tXi9FhIen2O3fNQH0qQ>
    <xmx:ceHbZ6Z1ha2U8UYM5XwTApcgS3NeVsMAe4_ryy38z30o4Uzh-jV5FQ>
    <xmx:ceHbZwDYdLPYGwgDAxhMfjmXuLVwt3DlF-O1daYhCUgafxSmaPaGRA>
    <xmx:ceHbZ4aJbfUl9SX55nZ-UXk_b6bxba6ru1ew5dI55aDA1a0HY1u04Q>
    <xmx:cuHbZ5lRDxocpiodASn7lznGpkCCsvoIKbf_ns6Uf4-TCFtAicQYE-c0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Mar 2025 05:35:45 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d8b76a64 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Mar 2025 09:35:45 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 20 Mar 2025 10:35:42 +0100
Subject: [PATCH 15/20] t/lib-t6000: refactor `name_from_description()` to
 not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250320-b4-pks-t-perlless-v1-15-b1eefe27ac55@pks.im>
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
index fba6778ca35..5191ebb30b8 100644
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
+		-e 's/^-//' |
+	tr 'A-Z' 'a-z'
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

