Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 723DC268C55
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 13:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742908481; cv=none; b=fJnaChlXr8WWAHXPDQLJxk6eiVX9K4KI1xLVhDkTElvqTjI6GEVlg3XaI7iDJDRcB3h39airwiWzigk8Z4Hs151IJTbpVIhXDXb7tgTw4QU14glNhCDy05kHBNubZ2prlGXvPA9W+OCi6J4Ckh8gPZSFNjySZrGM+jXVp8WxI5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742908481; c=relaxed/simple;
	bh=1h48IVzmJCqnPonehXdDtVit1PATRGJbnIJeE7KqacA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B35BTO3Vwkn7CiP3YMCx7IySW4EgAYibY8oAxBrEG2+9TbqoU02c0vHCjNczYNIwa0D9RT6WtiuxCleE6BzuLmgvKklsmFfC9jqtp8wLpuwsMYVIw5iXTQOZymQQKx92vP0p/tdsKk8+wPOsH46FIkYd4iuZAf0w1GsVy1B7/2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=f8s7HGTA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IOUj50A0; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="f8s7HGTA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IOUj50A0"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 282BA1383844;
	Tue, 25 Mar 2025 09:14:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 25 Mar 2025 09:14:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1742908478;
	 x=1742994878; bh=d+Ztq+x3QjSGjj5OnmS0JLh7eUizho7Qq93aRVWexJ0=; b=
	f8s7HGTAIALOW0mBQpTYqq5EZY/mDX0nFAgVO32XpKLvKG/XwC02EsfpFHYiNrVc
	ujGNRGQS3WaaNdRVu+9OrUSoPQlqv/cXOuxr1exdMWy2HkJB0iIW75pcPg9As9zy
	Jo+E1sU/foUxwoqO2pcfnNiFvk+LaGrul3bTCa1x/3yJRVlCr40e3Osi6uLEKE77
	a0b5CbxvndOuaRbT9aKMvZmhtzYnaT46KOKHVZuOupbNju5+eBk/kUIToVK/4Zgc
	sLQSBjHNn28n2zhtGPYJHM4dvw/9UI9cIWIpmHu08bi7EYUK9JCpoRbcl/nP7wKa
	kwNDakZD2lkLha9o1Xp13w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1742908478; x=
	1742994878; bh=d+Ztq+x3QjSGjj5OnmS0JLh7eUizho7Qq93aRVWexJ0=; b=I
	OUj50A0qSXGKKj09+b2uYzNt4NC0z3yvNvRStaMbv++BvimnDhI5806yfMdc6139
	2e4SY5CqJYzdMDbh86M6oDzouFvcsK25si9RTPoTwAbWcjqh7FmXZRvbq7DXmyUN
	30fREaTy0ZnDOlFRXFZxPseu0h4Ayag6R5kAh8FxXITDMjiJeoTmRuXDBwIYC/f3
	k7DURY4w7WY98Yv+2Z9bXCUhdb5fEUtdZmxne/cPzz8TNsaF/2PdZo1zkXG1sXKl
	+XY+jL2fpCo9SEm73X8XCShnJGzU/P2TBg7Z90mvTLaIRIwrPpacy/D3Z5o0C+Bj
	Gyz7DkKOuPHMTiyPcE7hg==
X-ME-Sender: <xms:PqziZ4UxNju0zjZeY08RSvvNPeQ5TN6MyzaWVUfxRTPY779fjvexCg>
    <xme:PqziZ8mvIisew-c4eZx6ULOCHpM-820k3Ahip27HvK0mOGJnkqS5LrlLvsWGoEeLX
    59u3ygsBTizdSlSNg>
X-ME-Received: <xmr:PqziZ8bGX9qXkivVbH6X0mGbnoKk5cSwWt0cMc51OdKpK78NpZXMosAkZ2z06XRahfSk_gWh1H78GU-V_S7TJwh12aUma5VQI_CAYdLTMXAZaQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedvjeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidr
    uggvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:PqziZ3XyyD7FOP5YgX80sdJP9fLBkblj9GrcomPio0Byv32jfPm8ZA>
    <xmx:PqziZykehHs72PcHTqKtEQEr4kRNyHDZXfl1kEiINO-hYcPqnI-uKg>
    <xmx:PqziZ8dJDCdEWD5tmvGWS710yCoZ8FSJ5gbCzT6vvdo6ogZ2TPjF_g>
    <xmx:PqziZ0HFlbKjE9N1cb2aKE7jfZg8QSippUlofHWkWVMxbQ15xTkomg>
    <xmx:PqziZ5vppOTAax20-Pv3OOOJSS_aGL9l2O8VdhetjgdqmAbAU7MB12AE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 09:14:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1ed2022c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 25 Mar 2025 13:14:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 25 Mar 2025 14:14:33 +0100
Subject: [PATCH v2 15/20] t/lib-t6000: refactor `name_from_description()`
 to not depend on Perl
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250325-b4-pks-t-perlless-v2-15-4b87b8072670@pks.im>
References: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
In-Reply-To: <20250325-b4-pks-t-perlless-v2-0-4b87b8072670@pks.im>
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

