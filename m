Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D807183CBB
	for <git@vger.kernel.org>; Thu, 22 Aug 2024 09:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724318283; cv=none; b=Jd4YZDWuYtkzIhHq3jCCQ4saGw97+iCLb/uHkfEvLuJ7RFkv8dtGDBtJIg1znvbNOQgUtPcx5+MJehhAOANXos3eAD716nNTK6GIXzxgMvaQaWew0DL65f2Q9AdWAL6ErhrCTKK6S0h2JhWKe+e/f//ypaHuar8MjvaqPBoRb38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724318283; c=relaxed/simple;
	bh=jAXZqjKBd2lnb1NJkLguqIf3Np+pHY/i8dlkw+R1REI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwrXTef9WeJfAdM/UJY6xOZzI66pnWD60jZimq4Kmw1X4vH0X7z2JDZFS6d2CZyyHpJ3U1IYhuGtdrmnizbS1rfsdtzZ4E9NN/akK+z3zsIO7KcBRuoBQJO+rgar5tjMRUx+Aq5TqtyY0VcRLIE7tMab8O9lYrb9YKzQmxEuGQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oL21ymw2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OAskiTBL; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oL21ymw2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OAskiTBL"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id BF7711151AAF;
	Thu, 22 Aug 2024 05:18:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 22 Aug 2024 05:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724318280; x=1724404680; bh=ifLKllzCxc
	GOnMh8nEjf1em21EvBrqzrhAwyaz8Z5KM=; b=oL21ymw2ewpVMS/QvR5xWkgW4R
	vtTVdiE3Z2TN2pMGQMtVOa2CkDjHFUm7MHQr68jjzf5u7eJzEX7DQLWNaf4lNIWI
	bmuJknBFREIU/j5rr4Lzuw55Q4jV85ZhaynUu28era18y0V3EF7IzGpFhBn4kdOQ
	/B3srJ7YO4PholTsoSuZNtIqzC7nazHfkdBqGua1tf7+5bOs7RKi4f8bWixRcpnr
	Ddooqsy4i4sKDEPL4xtIdCH0a9g6GRzYRszuJ96uDOqivBTnuir1VmHcXSNG1wKl
	E6p6kjaQAn2GdhSI1E5HgonVjqiW3sD0FnsXl0vOC9UuHfPpdXAX3NfEGDtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724318280; x=1724404680; bh=ifLKllzCxcGOnMh8nEjf1em21EvB
	rqzrhAwyaz8Z5KM=; b=OAskiTBLGrQ+WRRKXSPCk7HVWHyhgfazj1Tq0v86mzO9
	7aoNPD1iyaJ1xWQn489vBLa0e54SizsroCFNpCp8u11HdD7E0TC8BgJrNoKeok+4
	xZTyTk3NIDLf4HmQx1DbLIyFXf+9jdRULffCLBrWvfrfSbDkCc4tL18FJI+eFprZ
	jt/dudbOMEbnaet+MN7MUt8CYDGMt8RDD2m0+RP1cCoKk3JgH1aDFaEhOOWvqOng
	Xr/g6o6xTQzgyb/kVG7JvYzSTszFSBPEDHQzI8TTYJGCgvfDeINWXso7xwBxgVXP
	9ynPb5G8Yb1C/otI2Vh0ZdxO5S7DLXqFQzfzsjuDNw==
X-ME-Sender: <xms:SALHZo6xVDkQF69Uq9n7To69dOIIWu2pVMWkI68P43KkNvhPjUOLnw>
    <xme:SALHZp5Jc5vhoKvjQACXpm2rgh3Xu-kDXfOYuOvWaFTJVR3WmT3ZTChx2e_uLeaNS
    4lYT5D92mbZOSde2A>
X-ME-Received: <xmr:SALHZnekQp003BXZZCzhepx_BpnkNXafTXksKGeZwRGem4y3MXJBd6-kup_1RPgsSunzGvbRCyOFm7SbUt8_EHkmfFAmc6YPLtT6HMa--rqAqb0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddvtddgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:SALHZtJcuum1gpo2rqc_KchDuwNr9lMNHM0dxeN3A7UuvccJkmPhQg>
    <xmx:SALHZsL1md1sQbobf2chRfGRZ9wKix8Rk41IVuhFKdux33JULF1c9g>
    <xmx:SALHZuyLGPlB74itWijIlsuVSEhHCkz8ukFHU4OKXWcs8zuVmP1Ogg>
    <xmx:SALHZgItVzX3L-3vdcZsB-ldsKCrqJAk7k1Q8wAbaWBFInSA_nwgLQ>
    <xmx:SALHZjU5UfDu2YTfEmwD5wi5M_Hsj1-6ClpGryjk68l__NlT9Vmg8rLR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Aug 2024 05:17:59 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cf33b870 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Aug 2024 09:17:25 +0000 (UTC)
Date: Thu, 22 Aug 2024 11:17:58 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 16/20] remote: fix leaks when matching refspecs
Message-ID: <440b3d993724c465971628e9548c4937a7cd0833.1724315484.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
 <cover.1724315484.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724315484.git.ps@pks.im>

In `match_explicit()`, we try to match a source ref with a destination
ref according to a refspec item. This matching sometimes requires us to
allocate a new source spec so that it looks like we expect. And while we
in some end up assigning this allocated ref as `peer_ref`, which hands
over ownership of it to the caller, in other cases we don't. We neither
free it though, causing a memory leak.

Fix the leak by creating a common exit path where we can easily free the
source ref in case it is allocated and hasn't been handed over to the
caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c          | 43 +++++++++++++++++++++++++++++--------------
 t/t5505-remote.sh |  1 +
 2 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/remote.c b/remote.c
index 2c52119bbb2..6ea81f9665b 100644
--- a/remote.c
+++ b/remote.c
@@ -1344,18 +1344,21 @@ static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
 			  struct refspec_item *rs)
 {
-	struct ref *matched_src, *matched_dst;
-	int allocated_src;
+	struct ref *matched_src = NULL, *matched_dst = NULL;
+	int allocated_src = 0, ret;
 
 	const char *dst_value = rs->dst;
 	char *dst_guess;
 
-	if (rs->pattern || rs->matching || rs->negative)
-		return 0;
+	if (rs->pattern || rs->matching || rs->negative) {
+		ret = 0;
+		goto out;
+	}
 
-	matched_src = matched_dst = NULL;
-	if (match_explicit_lhs(src, rs, &matched_src, &allocated_src) < 0)
-		return -1;
+	if (match_explicit_lhs(src, rs, &matched_src, &allocated_src) < 0) {
+		ret = -1;
+		goto out;
+	}
 
 	if (!dst_value) {
 		int flag;
@@ -1394,18 +1397,30 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		      dst_value);
 		break;
 	}
-	if (!matched_dst)
-		return -1;
-	if (matched_dst->peer_ref)
-		return error(_("dst ref %s receives from more than one src"),
-			     matched_dst->name);
-	else {
+
+	if (!matched_dst) {
+		ret = -1;
+		goto out;
+	}
+
+	if (matched_dst->peer_ref) {
+		ret = error(_("dst ref %s receives from more than one src"),
+			    matched_dst->name);
+		goto out;
+	} else {
 		matched_dst->peer_ref = allocated_src ?
 					matched_src :
 					copy_ref(matched_src);
 		matched_dst->force = rs->force;
+		matched_src = NULL;
 	}
-	return 0;
+
+	ret = 0;
+
+out:
+	if (allocated_src)
+		free_one_ref(matched_src);
+	return ret;
 }
 
 static int match_explicit_refs(struct ref *src, struct ref *dst,
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 08424e878e1..532035933f3 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -2,6 +2,7 @@
 
 test_description='git remote porcelain-ish'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_repository () {
-- 
2.46.0.164.g477ce5ccd6.dirty

