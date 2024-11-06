Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98779202F96
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905837; cv=none; b=OCUcxVu05ir+BrvjxS2VU7Y9SoQ4ZzWivC72GJH35UjEGCedJdJpZMc9BKEchY0d/3+JJPnKTJ1RaLyBBVwR22L81fK+yHH1vr6kccer36yivgCMTe71IT2yDs51ci5o3NJ4cs5Gxlum9tGR0bzqcxE1icB2Vqyfaw3a9siLcjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905837; c=relaxed/simple;
	bh=DSQuuFGovHcsYu0/Xd1zeF+EvEq4FgNF8vGRNuPVNDU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJ9UONWmbMB8WiA66rpocdlSMdRonjCr86nBWe1uEL7C2Sw/pLh70SIzdUsbkwE+hEIne8VANn78bTQhIye8T0BAmvr4fDukwaBoP/r9ihWeGpLZnB8mkm/QHz9Oysbh3EX3aLotgX/saGknDjzUY9jRboXHIADPA1QJhfJtio4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zL9zGrAa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I2RW14LD; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zL9zGrAa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I2RW14LD"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 9FB7A13800E3
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:34 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 06 Nov 2024 10:10:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905834; x=1730992234; bh=TF12vISPeD
	19HsaWqXQS5sg2wM3jMkRaYj9UlQ6nnyo=; b=zL9zGrAahcaThfVz7O/ybtEpCK
	w9y8IJckA7lBB3TKn1Dbk0lHdhp0XGxYqhPY0kTQv3zhFAQQCBLiArBFfoKmO2XP
	t6buRT26cQEo8V6iO7tP3+UgOt/xDTMmTWvERfA88JytAVp9t71IvDTy/OoLXDNX
	V9CDRISkhBNdNa39GCIU4ZJy/3s6eHbtaqQK/P1c0F5403U0Mhx4sygaZ1a5ZW/o
	nLzH6EqzNB+Jqfl1OqZCvY+PQqgZpTORhW0aoCJ6Bih4RIbQgUigGOpAvtkh8h/q
	DyUazTwHsMu8U+OUrSdTDD2ty+J/+m4WBHqcqIn7pTcLomCEs/Oop+9HZqPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905834; x=1730992234; bh=TF12vISPeD19HsaWqXQS5sg2wM3jMkRaYj9
	UlQ6nnyo=; b=I2RW14LDKQr40OgW4/WaMlY0JUvVMF2otcQPJiCNT71TwsmwHX7
	QlE+R8Eh9IoEtD2qn9CPXfT7LCV14HlpxKR8NQwzplL+tJjDjzFxDvhH0G3vvIVK
	hpI+zVVlZgXkravyaQoJfloxCuFyUDe4ao2qPZcqlf9o/aFR8GK2OQSxXBksqafh
	78MwsvbW8a62DNBddq/sYUb9Tk4UDDPdoUIKvkXcl7+/qDes1d6m2Y3tDIkZ010o
	GK01cBfFJ3Sa2VgewbsfrVEzLeOxxsLc9D1BAWhikNUvWEb1Y/FiBiV7xlzxK6rL
	Rs9mfZc0p56sgA5HBPsA4LC+4GHSmAj+wFg==
X-ME-Sender: <xms:6oYrZyzsIu_2bcNQukIW5TSZrtaKcuyayV-PFWKJOEBuOQlNB5u2Yw>
    <xme:6oYrZ-QylFr-WFuBTyHFb2SDTINXqI0xXRnIWxzCFfmsySTSXH6vuujduc5SwIgL9
    eqAuV1p0uInXSUEdw>
X-ME-Received: <xmr:6oYrZ0XbYlCmDyd_hQ3RS17ZWk9qMswIfrXepVdBLRlIKadLR2iXOnGyjzFVg-073Dkz2GNQnCGcKSQDctY12f5h83bwn2sofq6VdzjmcU6CIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:6oYrZ4jGlkloA040x_zswPFXLb83_rI0JctZ-9byzFWVRWGoEcJjkg>
    <xmx:6oYrZ0B8NP21qt2rDQXc0qp7rCekOqpjjat36Dky8t0P_07315CoaQ>
    <xmx:6oYrZ5ID4YLemULV8npzRaHElINuklyRarOlQMofLNOqHiePV0lCAQ>
    <xmx:6oYrZ7BCOTwCGEf0ysOvHuUWfXe1M6AIqD5tEXpk-d-2-ybCwK6XuA>
    <xmx:6oYrZ94avWaRv1hx0pQtOJS5o12xE0U6Jl_W2eJiVicVcW_K191BkAUG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:33 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f92ed68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:09 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 03/26] bisect: fix leaking string in `handle_bad_merge_base()`
Message-ID: <4a554ab10409e4cfb3c42b817cae3d026284663c.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

When handling a bad merge base we print an error, which includes the set
of good revisions joined by spaces. This string is allocated, but never
freed.

Fix this memory leak. Note that the local `bad_hex` varible also looks
like a string that we should free. But in fact, `oid_to_hex()` returns
an address to a static variable even though it is declared to return a
non-constant string. The function signature is thus quite misleading and
really should be fixed, but doing so is outside of the scope of this
patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/bisect.c b/bisect.c
index 9c52241050c..e9e603877eb 100644
--- a/bisect.c
+++ b/bisect.c
@@ -801,6 +801,8 @@ static enum bisect_error handle_bad_merge_base(void)
 				"between %s and [%s].\n"),
 				bad_hex, term_bad, term_good, bad_hex, good_hex);
 		}
+
+		free(good_hex);
 		return BISECT_MERGE_BASE_CHECK;
 	}
 
-- 
2.47.0.229.g8f8d6eee53.dirty

