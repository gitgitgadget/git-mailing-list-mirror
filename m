Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68F61E9B03
	for <git@vger.kernel.org>; Tue, 13 May 2025 09:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129727; cv=none; b=Q1kcevk2Rzybcag1wkiX5IDijbQqK9gY/2K4je1Krcgsu9WWmRel6zETNuTPGndcbP3XuxRWb6dR5E5h0XyJXQhWgbMhTAxXMgSZO0cB8J4TGwCnCEXRebvQgszJh6qiOTz5a01zycJ91yXO3WUK/8z6LgpS0AxV520szLAP3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129727; c=relaxed/simple;
	bh=aNo79fH2FgJ5SUuSDfNNNsGyYrgZ0lBrHRKto6LIuGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRkYReeHNyo0ROZ1ZpaXbVe1geG5gLpNsQbIdf7nAGDTmPNzWU0YMOzxhzgCLPGcSJmd7Vt7sGltCQez252ls9yf6S705lub57TTUVvvIaHYCeNV+z2g2fGWBs0T0yWxxA+blj0P1X1+FgQp+07Zpkw8JNxUFqPIIRN2ioxqkVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=p6xZ68f5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uJGFYKaD; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="p6xZ68f5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uJGFYKaD"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C478611400EE;
	Tue, 13 May 2025 05:48:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 13 May 2025 05:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1747129723; x=1747216123; bh=BL6pNlYBGC
	JjKHuAw3LLdFHFbZLlf1TwYFPH6AhEmZE=; b=p6xZ68f5E7G4PC5f4CsSyC4cOr
	iPHgskTZDanwOUOA2EGxW3/yv63cudJPfLh5QqmzxImhCjc/vWLcIB+onjlfl1rv
	Fqt4pk/OsHzFF3p3/D73w3QKwMfGyUmzIbRTWZcjouyT/Jgqdk2Ia5JUTLij3RPC
	pSQPK5s9dwQqiZYHZVsjKt9nJ4mZeZbebFO/iFV1C1N+VeckeiqKhLOtva+DTdDy
	4Zdz7AoVGTdF2Ue6/V4QMOEy6nAmG9AQ4OEPEdsGcoMFu4f0schEokT7osoWXpi7
	fKNLl3dknAHABI2L2EH9H9+2IAMrkwJRNnBEbk3CwW32KvDqWQlTeTe6UGPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747129723; x=1747216123; bh=BL6pNlYBGCJjKHuAw3LLdFHFbZLlf1TwYFP
	H6AhEmZE=; b=uJGFYKaDRp+P9rSC8R2KcT5xKj5nYBEh4fugI/NgzZZRhIRG1c+
	2XbL6Droj5AFUrOYWyn+sTuOio6D3HTIIRrQM6eY1GRPItg0mtRxq+bTG3njrMnB
	nS/DPraba3c/3ZEsO11bD3mv/esCA0r76/PvVyrJSoRMc9BujBpw05HzJnpuPRAh
	BfjZvyeVjZtuZ6mUgb0dJf7+7FAkxRSvo1qxs8OLf+aG7+nWEbg0W7knfbJunkJ3
	YegdMhFM/rHVEg09DiRFbCipq4SKWyl8J91M9xnEAe8IRmbhTWUYS7Htpwtio/xX
	Y2H4/mIn7AnlNKEc/0D1rTZfQnA8Yi8Lyxg==
X-ME-Sender: <xms:exUjaJ3IEeW-hSCgKSwF0w3Z_YlZGb9sJ3Ni334FIrHpspkf3ZR-fQ>
    <xme:exUjaAGVgeGApEOSqbRYkd005x5dd9DHzgrD74UaorJYoPEXMoM4slN6kwhxYlKdR
    Vl9O0E5oautmfvi0g>
X-ME-Received: <xmr:exUjaJ6vV6LmFAWREBNxCgFPNpAYb9lt14c7gZKoB67p99JNYXH-PXsG7JriaTyVVIGA248AIbbGJCRNXESCzsWDlBksiJvaoBHqXxzECi_NoQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdefkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghf
    fhesphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:exUjaG0mqRXFbmpgmAtw95xNFXbs_N4bXf2qmjBTH7RKpfA7SsIpXA>
    <xmx:exUjaMEOS2AYsdyiIRdyO3RYp8dw-mOpNnF3mWygR8EpaqzgFEPYLQ>
    <xmx:exUjaH9KCej9dOXuGYoVkBRWOLRYQ6-SazZhmuR40T-EDjy3G01tQQ>
    <xmx:exUjaJljlGaLOtL-AVcvZEFNmAqRRC7vOzNjVs_kS7Qu5A5j-5MXyQ>
    <xmx:exUjaK8_TwOlv2Rma_nrU2wU9NSJtbN8UpPYEDTFgcRuB-SEfACcAUVW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 May 2025 05:48:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7efc50cf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 13 May 2025 09:48:41 +0000 (UTC)
Date: Tue, 13 May 2025 11:48:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] oidmap: add size function
Message-ID: <aCMVdEg8d6BHo7AA@pks.im>
References: <20250512185006.GA1275914@coredump.intra.peff.net>
 <20250512185130.GB1276214@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512185130.GB1276214@coredump.intra.peff.net>

On Mon, May 12, 2025 at 02:51:30PM -0400, Jeff King wrote:
> Callers which want to know how many items are in an oidmap have to look
> at the underlying hashmap struct, leaking an implementation detail.
> Let's provide a type-appropriate wrapper and use it.
> 
> Note in the call from lookup_replace_object(), the caller was actually
> looking at the hashmap's tablesize parameter (the allocated size of the
> table) rather than hashmap_get_size(), the number of items in the table.
> This probably should have been checking the number of items all along,
> but the two are functionally equivalent here since we only add to the
> map and never remove anything. Thus if there was any allocation, it was
> because there is at least one item.

I was a bit puzzled by this explanation initially. The two sizes aren't
functioally equivalent -- the table size will typically be larger than
the number of contained entries. But the thing is that we don't care for
the actual size, we only care whether the map is empty or not. And for
that those are indeed equivalent in this specific case.

Patrick
