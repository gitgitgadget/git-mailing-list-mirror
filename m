Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8EB2222B2
	for <git@vger.kernel.org>; Thu, 19 Feb 2026 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771488800; cv=none; b=e3iPmXVNC352FElYLvbKERl0lT3AjD2tPPwlB+y+CPWLd/dBuN7XbBnIoNDuebkZIffyOVutUUDywEKe71vUwjLkzTaIf9OwmClbSnTS4CORwAJGEqfJHJs36b2ODGZfVblNegMD56U/6RGbhBqlrnxbyeWdBEsTMGtMdwIfOac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771488800; c=relaxed/simple;
	bh=TPiox9HpzSTLCTbFJCC1zry3o8S5ZT/ZNloX4Rf0Ll8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=db6wmvdhGC67FKftIDaVbyj2ZH62CyG943DQKfBddIUC7Gbyv8msOi+A3XHZW/6cLO1rgnjmKjmMLdIf6phul5Am/AG6HL46bs35KjgzX6snoOnwSKgn7dlyJNaj6m+YplzcIX+MQJcAS+z4Ux9RSZeqeJ68cOJR16AL/2+U49w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Vm5xnBap; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oo37l1E6; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Vm5xnBap";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oo37l1E6"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0B8FDEC00C3;
	Thu, 19 Feb 2026 03:13:18 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 19 Feb 2026 03:13:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771488798;
	 x=1771575198; bh=FYy260f+IBe8KzSKIJvwS3HVCS4o0NTk72DWF8p44WI=; b=
	Vm5xnBapNceKyOfcFSsVtMSclbgudeuhObqXaMNT31mMFCv9QRCIhUf5DgqcACYr
	m5fwalaDVlljaV8sBXf7k2Fk+oh9m5QS/KtLho+mAeWwJWBv83O9gCYmXaIgTHnH
	+3bc8Uu35JXRCm1aY4gDKHS0R7yLX8kAQqsYWxq56a8fbSVmGZdFJ4zpwC8gVcrl
	Ce4BkL3xOZHPN0EMbkkyHbHu7gYiNkkE6QaGYq1ZFeo7irhoz3xi106kBlllCneC
	sULPgi1HYKVO0f86LajqH4k4q2fGO17ca+JlffUnf452u4b+E3yb1+1tkYZtE5VO
	jmPzgT9r6d0k8v7Hj/IOsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771488798; x=
	1771575198; bh=FYy260f+IBe8KzSKIJvwS3HVCS4o0NTk72DWF8p44WI=; b=O
	o37l1E6lrM7EltmVxsEbxNVQx7mOHC/2X0i4qsJEIYuPBFBfPB4xmXxAVFTeablj
	ua9sO7HMUWHcnRoUcT6TMwNxIan/mA1Abz01xTxzbuomJqTDGUsTMNohvZaZRmj1
	R0MW+PzIOwsttuydiW/5zXepDnEtYWjNmY4u2gN0FrcZOtdS3cRBHilmKe65IunH
	slbpcZHmMSDxoit0b02NPbkWNQDG3ty3hfDQZ9S0egFEzars5oPVSK6rFLXvRnmR
	5feOBCxzxRpwCiLoH1U8G1A/wferrffZq79KwMj7dfFr8qk3WQIUWkbEFjxTACyT
	w//HsxwscibpgCv+BJJ1Q==
X-ME-Sender: <xms:HcaWaeTkwof7ikna7GELSKhggwg9a4zKSkkJooNh77-Aa9660Uw1kw>
    <xme:HcaWaawN_wTnQ3uAAoqqqdAzomcFSP6qeTZNlxX36klQDI-Z92Jxx4EeU_SehM6zm
    s4i89SenGU29DlT7mkqNw9GJG3ZEXmDUZml8sIpSjv6qC-DGt-n6A>
X-ME-Received: <xmr:HcaWaQ1oW3fjTfwOD_lp-tRd_rXxHk2ziXIQHKUIr0TmoBgC-3SCV-94QINLFQsvYJcMB605Js__s7OV50lbcgzljph81aFRIpM0M-5iiw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdehtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfh
    hfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:HcaWaY4Jg_xMJxw4UMxVnYWrNxDMswk2myLjW2CEhOmFn0gP3-eSDg>
    <xmx:HcaWaTXbid5F3GjZ04MDQHOniWwf1vb6ioM_c_7n1ps3SOMPfEbOiA>
    <xmx:HcaWaXBBFvXOdoqHsfAeBRY5eUEyrsdTevM_4RCLsbT9WXzKtuSWFw>
    <xmx:HcaWaS6Qb1RO26HKQmC80l2E0et823v2Ncz-RHfWieYvbbO53rTrZQ>
    <xmx:HsaWaYVAH-UMUrXLkEa-koZmnTos4NjOFjZkHmrBz9PyXduPWqlkSLcZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Feb 2026 03:13:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id debf43e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 19 Feb 2026 08:13:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 19 Feb 2026 08:57:51 +0100
Subject: [PATCH v4 3/4] bisect: fix misuse of `refs_for_each_ref_in()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-3-57ac30172fae@pks.im>
References: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
In-Reply-To: <20260219-b4-pks-fix-for-each-ref-in-misuse-v4-0-57ac30172fae@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
 Jeff King <peff@peff.net>
X-Mailer: b4 0.14.3

All callers of `refs_for_each_ref_in()` pass in a string that is
terminated with a trailing slash to indicate that they only want to see
refs in that specific ref hierarchy. This is in fact a requirement if
one wants to use this function, as the function trims the prefix from
each yielded ref. So if there was a reference that was called
"refs/bisect" as in our example, the result after trimming would be the
empty string, and that's something we disallow.

Fix this by adding the trailing slash.

Furthermore, taking a closer look, we strip the prefix only to re-add it
in `mark_for_removal()`. This is somewhat roundabout, as we can instead
call `refs_for_each_fullref_in()` to not do any stripping at all. Do so
to simplify the code a bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/bisect.c b/bisect.c
index 326b59c0dc..4f0d1a1853 100644
--- a/bisect.c
+++ b/bisect.c
@@ -1180,7 +1180,7 @@ int estimate_bisect_steps(int all)
 static int mark_for_removal(const struct reference *ref, void *cb_data)
 {
 	struct string_list *refs = cb_data;
-	char *bisect_ref = xstrfmt("refs/bisect%s", ref->name);
+	char *bisect_ref = xstrdup(ref->name);
 	string_list_append(refs, bisect_ref);
 	return 0;
 }
@@ -1191,9 +1191,9 @@ int bisect_clean_state(void)
 
 	/* There may be some refs packed during bisection */
 	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
-	refs_for_each_ref_in(get_main_ref_store(the_repository),
-			     "refs/bisect", mark_for_removal,
-			     (void *) &refs_for_removal);
+	refs_for_each_fullref_in(get_main_ref_store(the_repository),
+				 "refs/bisect/", NULL, mark_for_removal,
+				 &refs_for_removal);
 	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
 	string_list_append(&refs_for_removal, xstrdup("BISECT_EXPECTED_REV"));
 	result = refs_delete_refs(get_main_ref_store(the_repository),

-- 
2.53.0.414.gf7e9f6c205.dirty

