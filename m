Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E75137750
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723618378; cv=none; b=E6VbSncs5nELVmZ+RMgVHW5QUa4M91g7U7qfpNInPxJCdsxx21PDDfHRcnb71B0aKypyKyQj6Yhwoo2qBNhE3o6VcfFJQJFoog7lzVyhvmOw7zHBV4PzKykgCCyY9mDrQlATtStP56iUxWHG1u3SDdlntBn9UnuctsgDm1M8Q64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723618378; c=relaxed/simple;
	bh=TmEjKLmjA0mqFrxvgEVteiUKLolDNrmW1BAbjtK2mrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKhEIzMF8ti2vPbeUlQFwkSBIsVTa2lYPpjxWXvU5w34LcrYeI+VoquqkOrHsh0HN01iF/oJpq3woewC9dimpdAb0lqHD1HKnLzoe8ogUdhKG0JBdwiw/uS3RahyKK53cDqhXYoDo90KvrhPPjqgEF9vuFzX6LYwphJ7tCgpdfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lgT3DEnM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XBcDQO8V; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lgT3DEnM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XBcDQO8V"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 723D7114EADE;
	Wed, 14 Aug 2024 02:52:56 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 14 Aug 2024 02:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723618376; x=1723704776; bh=2wPc6NW96L
	5u32zLjneWJJc5WDAlYRqzZ6i4JGJsI5U=; b=lgT3DEnMETRBa2nFUwlrCemTIt
	+gMGwVh92dO1SRzYHo3A2AUaXtAoIXEWkEFGsVow2WKeHQw+uINnjR0U5K7D/Z7T
	yzsXQCcYrLxxYYhee64rDlauT8twLh5Np6ixujXel0Wosv0G2nQwuoIA8ocofnBT
	FqV/4pzKmjozy4oIklCWe+Vvt1XLzW4BHYz+OOqUnGB38yJLaHbLjsm6RDzn5jr6
	WEig2ArjGyrtj4P4NdC5bSf9bXj3SIYgFd6LXU5UJ7hWgKm77TLHaKuRN7gdXXM0
	JOQcNx4oYKmAgGj2XB0xQ+wJKRsL7yMNbTLO3CFGlubal5r3P5fHxJ76ShIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723618376; x=1723704776; bh=2wPc6NW96L5u32zLjneWJJc5WDAl
	YRqzZ6i4JGJsI5U=; b=XBcDQO8VFnn5kNmJishf5jMba5Pt0+Tc5A5MiXLiVubV
	4D6spddnH826WeYH4dy56BBeAR9HTVy2LPZqkk8CdGihDHo4PYXs8Thhk2zf8cGH
	vpmjhThEiq/CQWsFW7OwW/xvMuoe8SPzPPM9bFH4pVJufuN+9b0DxhpXL9MVvLwA
	d3r4F+JGi5/uVeyfMOYtUmbpOXpMVPUWVX/bPrZPn2LEnbaSAd83rkawPQ4V4F5o
	e58aAsedUWB/IFrai3OLxlQy9fk3rN+nNICNe+URllYGuugionib/b8iK733cKaI
	kBtvlCOBbCCRez1ZCyOV9/9yOdDTxBEieGpKbK3HLQ==
X-ME-Sender: <xms:SFS8Zmot08ttcPt7tHBqkyobhmmYaKtcM2Sg2lRQo-3xj-v8eeuDsQ>
    <xme:SFS8ZkquZZXgmUKhaU8lsR0SD6HwfPLg1fhEj4FaCm2XQDo595Pl3fJX2R4Yl1yhw
    nx3Y0Hs6uBCw1VTtg>
X-ME-Received: <xmr:SFS8ZrMJesYg6MhySXRoJyTQbq5_dHLuY-AcWJxj-E-BzZotSIKoH7fqdYxknH_Re4LQiAPtwJC3IUejTZsS-lg8POrvRKLWbAcFJzlikqc9dQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpeegnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeipdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjrghm
    vghssehjrghmvghslhhiuhdrihhopdhrtghpthhtohepphhhihhllhhiphdrfihoohguud
    dvfeesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhm
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:SFS8Zl5flJanXgp0YlKVPtwHfQJkPqJ8ahMsOl6iSikEUDmuQVU38Q>
    <xmx:SFS8Zl7TxhXk2m8OpoRqHvghdiVqBOOTeqKRGgZnv-gG6jhjv8T-Ug>
    <xmx:SFS8ZlgPHceAER6K3tXnhCGIcORWS3N7_pqvL_Me0leEQZ_Ur24HGA>
    <xmx:SFS8Zv4p5sore-prTBocNoqSEJy-aMIwcL7pIKvjbiSlSEh-qlzMDA>
    <xmx:SFS8ZivBbmYzZgYCr70HNcO39CDwbFxDV8JP3kKqT73k-zG8pryUJEvt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 02:52:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2b7776fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 06:52:36 +0000 (UTC)
Date: Wed, 14 Aug 2024 08:52:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: James Liu <james@jamesliu.io>, karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v4 20/22] builtin/log: fix leak when showing converted blob
 contents
Message-ID: <0e2d3e523f7debf121bf4c1e62e485577b77e9de.1723614263.git.ps@pks.im>
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

In `show_blob_object()`, we proactively call `textconv_object()`. In
case we have a textconv driver for this blob we will end up showing the
converted contents, otherwise we'll show the un-converted contents of it
instead.

When the object has been converted we never free the buffer containing
the converted contents. Fix this to plug this memory leak.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/log.c            | 1 +
 t/t4030-diff-textconv.sh | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index f5cb00c643..36769bab3b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -707,6 +707,7 @@ static int show_blob_object(const struct object_id *oid, struct rev_info *rev, c
 
 	write_or_die(1, buf, size);
 	object_context_release(&obj_context);
+	free(buf);
 	return 0;
 }
 
diff --git a/t/t4030-diff-textconv.sh b/t/t4030-diff-textconv.sh
index a39a626664..29f6d610c2 100755
--- a/t/t4030-diff-textconv.sh
+++ b/t/t4030-diff-textconv.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='diff.*.textconv tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 find_diff() {
-- 
2.46.0.46.g406f326d27.dirty

