Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC830161320
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082005; cv=none; b=hBbMFiywXvqbSqB5g8TiOc0uVtuux2zqRM2ggEk6FFwNcnWpO+SFLMtxEoUIljfwVtQPCtMPr1ASpa5SpEtXMcPNWLmNMM/RFv4/juhNR/BlQgg6qBf+BuI7MSZHIzP8PXCthkj4K5OY8x+kJw1YGfNPDvVB4aoBa91HAx9pYRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082005; c=relaxed/simple;
	bh=FEr8ardXQayQ2TphZ73DWd5/HmhupTNwRaduRG4G6dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j+DI6DzbS+a9YW//WpJ+t/ysfF1wwOUNT7nsaxUCQ7z6/BrtVof1xm9mI7wA+67CX36prcqIvDsKKeGhJ+elxh2lVwR6cu9PPyhGzlbRTLkWK7stAIAl+lS6Izjrknsvd0vpb23SkccIQPKqVMGsmao5laOgHNYsboXmxle+eOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QOi/aqaS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MiEKK922; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QOi/aqaS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MiEKK922"
Received: from phl-compute-08.internal (phl-compute-08.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id D86F8138FC3F;
	Mon, 19 Aug 2024 11:40:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 19 Aug 2024 11:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724082002; x=1724168402; bh=iTJegvQEzg
	opvHU7GaYWJs0yY5xgDY2Vv5QJY921bUk=; b=QOi/aqaSDIiFPZXj31le+a/wEi
	fpQGYt8cJ27PcgMOcD0uxyruvWmr1C5qByjdm/M0j576eCWJHS6TJ0S1wLcUz0sp
	qKxDmyeh4fshsXLlQPtWqRvB5ti0pdJ2emXIVdw0D4BcgAPh/PejxsPUHBnqbrsy
	uXRY2UQsLWxwlXtmUYMYyseFkTbh9i+t8rGbsJTOkz/EWMTy2mnczS9NEa1fqqcZ
	lATf5xCJHDZ4bywMge7rn9LO3fUgby5l6ww/MIms+zxqvO1UwDCqvn6X6SCDQzQx
	ny0QpLS5JLl/kG2DzsoaVktvNemozzHB2ADtepLJxYpM5YEDrXyleGt5P3Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724082002; x=1724168402; bh=iTJegvQEzgopvHU7GaYWJs0yY5xg
	DY2Vv5QJY921bUk=; b=MiEKK922FV1QvhFymyAeN0c5L+KuWjaS/TjCQa0gE5Cd
	pxuG5ca8txw8Ox3HYRPHBKgSBe7OgTlbCr//zqi+W/uEp/vewdrHEbzp3wQ39900
	6OnGZwK9IlOPRG0kwrOvckOeY2PJRinHJgOFyXEDMO8OatBkn30mlTdV8T81Lddh
	BQvH3OPLYxmVW4QIyeHlif3ZNS1kR+TJWuSR1NPMIYW0XgzKoHg4f3S1kOpAiw8u
	uLO59elBt8Trb/5WMsgFW7sA7fL7dlkqc4ncYAEdiR7/4JlNTM8sQhi9NUWIoM8m
	X7BJB+8Xz7Vrm1talWwMWEIW3ipuuhC9wM05Eg4HrA==
X-ME-Sender: <xms:UmfDZlhsltXB_XkXAGH8FStA4y2u_yS4q0V3dwtd-XltE4NKvzN-oQ>
    <xme:UmfDZqBNeY_R6FXQERVvNmOyJAH1EjRe-WhXRMp_LoU-fP45Qxjy1RtrLyfQ8ifwj
    CjWaWJlI_osQMA2eA>
X-ME-Received: <xmr:UmfDZlElRFlribG12mmmrdLpjIKjJwHeBEh_PlChH62OS9FVCUZ21og1xxsntV7e-46yaopS6JYS-GRNTGckNbTP5QaBa9ANcrRxgbT_hJVX3vc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:UmfDZqQVGiUWoOvPXu78bNDyYRGNDRJt6yDND80UzVVu5N19vG2aVw>
    <xmx:UmfDZixTAKM47JHA8FdqiT_ZsBvcxAx13I7baMdSCdy-cVXPmRP6QQ>
    <xmx:UmfDZg6OUwdtT7NbymCpbnenKREWcMZ2m9wK6QTmoG8BY3VfT8qxmw>
    <xmx:UmfDZnyhubtdV5CzvCG0CioF0RIa8s9M0wuvvJv1sxs5KCJYvJJNbw>
    <xmx:UmfDZt8Z2kzColDT6OSSvL0EZ-NMkoypSPdvBnoTzSrkKRHDjDYg0-Sz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Aug 2024 11:40:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1c538200 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 19 Aug 2024 15:39:32 +0000 (UTC)
Date: Mon, 19 Aug 2024 17:40:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 06/10] reftable/stack: fix broken refnames in
 `write_n_ref_tables()`
Message-ID: <4965402e7bf5a09da551a8cdc8c12dd87515e2ba.1724080006.git.ps@pks.im>
References: <cover.1724080006.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724080006.git.ps@pks.im>

The `write_n_ref_tables()` helper function writes N references in
separate tables. We never reset the computed name of those references
though, leading us to end up with unexpected names.

Fix this by resetting the buffer.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 42044ed8a3..de0669b7b8 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -125,6 +125,7 @@ static void write_n_ref_tables(struct reftable_stack *st,
 			.value_type = REFTABLE_REF_VAL1,
 		};
 
+		strbuf_reset(&buf);
 		strbuf_addf(&buf, "refs/heads/branch-%04u", (unsigned) i);
 		ref.refname = buf.buf;
 		set_test_hash(ref.value.val1, i);
-- 
2.46.0.164.g477ce5ccd6.dirty

