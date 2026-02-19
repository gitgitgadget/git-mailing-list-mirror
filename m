Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703402AD2C
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 08:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488803; cv=none; b=bQMc8gFJBABA5fy88BVGuund9zwrcnNBqK+zQzUZNN4BEjv9cEAzYsbOPC97VS7RxIBbRGjLlWJUQ64+vhXU84Qh+xv0KdCo0OnkwM8NBr2SwqBMRIDDW5A6mMlsnT8DQ/v2sJFX65vl8ctPVNxVTLjPkRrOxivvtlwnuJGbb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488803; c=relaxed/simple;
	bh=xpEFIClz98kQ2Nazr66+lSqz23dzVhjM8IRg04csyTQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sRRYdZDaCL2dE9XwtGlR4UFznMusKh3To8hGmmbw+/Gl/Ivp4hM4zoTrjvXXLqmpyitFoeuucJvHvP25Pl5+7FCSuvQUlqj+AzxmY6tLW6D6/hplxFN8EPhg975CXaf3HqrCrus4nHsh6EYuXkF9jcjWDty70Z7oz3WpjO+kaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cr18KYoe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=prU1F60K; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cr18KYoe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="prU1F60K"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 9EE73EC0585;
	Thu, 19 Feb 2026 03:13:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 19 Feb 2026 03:13:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771488801;
	 x=1771575201; bh=JJ6u2N5yVQJnpuDqsdzciX97JEwOIXlozqiTu8PEvGM=; b=
	Cr18KYoe/GaoszRiamAdUGR0VTfwK6a/slGEZfIQWXnRIr3IThZrFRGZmPhteHsf
	ZjlQD2Egf2iqjpF3FmNDI9P24PGGBtdx4GexRF7cn7fFmAN3kp+oh1uxUl68pMBL
	5cEhBU7B3BkTEj4n77uRMNnmG9zBB73j1xVVGLY8jGCwjUO+Hm6BPgAhFZcGZip/
	BqIwP6FB527v77iGxvdln1udy7m2L+gIutod3KkhTTNdJieVlhK6KFVRzOxMPuhD
	VPP/8b9TsFsliEEWfIyHHVxczJrbC12NLWikW6XTJqMElOG7aflgtcXLRKfFc+++
	cfcCyvuRo6VTF6TVHBaNzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771488801; x=
	1771575201; bh=JJ6u2N5yVQJnpuDqsdzciX97JEwOIXlozqiTu8PEvGM=; b=p
	rU1F60KA84dw4oSG+IYCyBjslxUBAziM6KZyFBFoTUBuw6xYIDcV11ImTBydKtGg
	FxUU+xHIyaCWT65PQWybW/GSlLfVFwv4OBIgLTHChlkAiF3GZInVZJfwXDnRSb5k
	FegFs6vnGQdtFaS5cMxSO/W7RnFt//I1mrIqZOJGplF+OTSnnZPfQEBBZH0FKJDu
	PIgXi6fGXv/xCOP7S/a9nxY4h8ArGNT9oeW2Eu54QVMSLebJAk0L6KNN/5WMi4KC
	vXl83a1lWrCKIiz0B4AVsDx5Yx983Nvqy4VRGx3My6uOAMvHDQAHhO+Q7oivV3CT
	oQgFt5Oi5SFBgKKPw6DJg==
X-ME-Sender: <xms:IcaWabEIZjuJDyvWy9hmxIUp6HLx4y6UzGwA6Q7qZzD69X28qunMMQ>
    <xme:IcaWafV5m9o7EfpzqjiASDAtz3MJaNrDYQ-fFbKMRfpy8NIQpBei7GXhE5Dvs7E1h
    ZuCRK0mfe4Yk9msXwJ7OpOpstApcZZt_G0rsQZ3mR6VOysIGPWC>
X-ME-Received: <xmr:IcaWaSIZixX4IpvldPfVf3Vlk8qmcf_R2Q6IBv0byNfeOjCHE8ymAXP33DPCwkAoUyfw5HICyqnLw_AJLAUURYRXAWpggvgH7JCCaeNmQA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhn
    vght
X-ME-Proxy: <xmx:IcaWaX9NRqWabqE9dhxi39KXlBCfBI97-scl1tJiI3aypVcm2Tpb0w>
    <xmx:IcaWadJO5Mh-Je3uQLZPJdvTV5f-L03wrBUf5PRTT2pMDVSyPVX8NQ>
    <xmx:IcaWaUmJNLziZjix47knbLstWR1zAWmblAjdAWGSsBM7mg8o-bDJ5g>
    <xmx:IcaWaZMd7bpWF539TMtZuL72Ii28BAYmOalLRLvhrr89qKsTmGvNVA>
    <xmx:IcaWaQmwjradbxisEu4Hd84ugY3PJxOQidDPL4QR6qoCbNOSRhdGzJy->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 03:13:20 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1d692845 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 08:13:20 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 08:57:52 +0100
Subject: [PATCH v4 4/4] bisect: simplify string_list memory handling
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-4-57ac30172fae@pks.im>
References: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
In-Reply-To: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

From: Jeff King <peff@peff.net>

We declare the refs_for_removal string_list as NODUP, forcing us to
manually allocate strings we insert. And then when it comes time to
clean up, we set strdup_strings so that string_list_clear() will free
them for us.

This is a confusing pattern, and can be done much more simply by just
declaring the list with the DUP initializer in the first place.

It was written this way originally because one of the callsites
generated the item using xstrfmt(). But that spot switched to a plain
xstrdup() in the preceding commit. That means we can now just let the
string_list code handle allocation itself.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/bisect.c b/bisect.c
index 4f0d1a1853..268f5e36f8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1180,8 +1180,7 @@ int estimate_bisect_steps(int all)
 static int mark_for_removal(const struct reference *ref, void *cb_data)
 {
 	struct string_list *refs = cb_data;
-	char *bisect_ref = xstrdup(ref->name);
-	string_list_append(refs, bisect_ref);
+	string_list_append(refs, ref->name);
 	return 0;
 }
 
@@ -1190,16 +1189,15 @@ int bisect_clean_state(void)
 	int result = 0;
 
 	/* There may be some refs packed during bisection */
-	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
+	struct string_list refs_for_removal = STRING_LIST_INIT_DUP;
 	refs_for_each_fullref_in(get_main_ref_store(the_repository),
 				 "refs/bisect/", NULL, mark_for_removal,
 				 &refs_for_removal);
-	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
-	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
+	string_list_append(&refs_for_removal, "BISECT_HEAD");
+	string_list_append(&refs_for_removal, "BISECT_EXPECTED_REV");
 	result = refs_delete_refs(get_main_ref_store(the_repository),
 				  "bisect: remove", &refs_for_removal,
 				  REF_NO_DEREF);
-	refs_for_removal.strdup_strings = 1;
 	string_list_clear(&refs_for_removal, 0);
 	unlink_or_warn(git_path_bisect_ancestors_ok());
 	unlink_or_warn(git_path_bisect_log());

-- 
2.53.0.414.gf7e9f6c205.dirty

