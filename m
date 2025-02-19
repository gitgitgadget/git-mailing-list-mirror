Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5431E7C25
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739969963; cv=none; b=RZiMSJefiOjnG95+nNVNRZas6nSSvCwAlt0xLXpRVyWJs2YPFBYJ7jVNO+acUUlWFrB7rAxGHc49qr4+x1p2lSOgBDKVUtDPCyk5Go4WQfo6+pnH/HnifKYwwfDVN1elWEQj1VDPJ8LG8h0RiieYqLKs+VcB3K5zTalury2ROBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739969963; c=relaxed/simple;
	bh=80R1LeWFh90CP09/e0fwd6187O9xUTEkMexosY1EXZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t8cci+LDuCGDgGf8aeqA05IG/V3Pk0ZAXfV12J8tVXS7jy7WAQd3NeG3uPNHvJzaFk2xPUt2IvY3an0Ngqs6MfO20wPSTFzMVF0nZwlMXwaFTTrjMYjw8n03OdHjBIDpcWqidb0eGmwWLcFhKPxXv8NNKToIPLD/pEIuggsKQJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JrZ7t0Ah; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jB+VkIG9; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JrZ7t0Ah";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jB+VkIG9"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 42D7825400D5;
	Wed, 19 Feb 2025 07:59:20 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 19 Feb 2025 07:59:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1739969960; x=1740056360; bh=CWvbO4k7gR
	L4pG82kvd9g5D/Cc9k/kcQ0okLcqHS7W8=; b=JrZ7t0Ahl3GQkGhLncKdExJr7j
	X1EKb9Kys50ep5PIiqkTB+eUHOuN9ANSsAwzb/4RpcyGAtFWvdHjP08d8hREcqFP
	tGnyPUfC/2pUUtBATPZ4S1pDsdLx4TU9kfwhUfRnsdhCIjyoDzvfi65bCw4mfSCm
	NN0/IHEYynWfpbgM7ZNUJ3ZHv3d03orZzjiqSNroEboixNefrV5Woq2EYrR+aOJ+
	P9aZabwwZ6kEeE2SsMAlf7GoynIl+jVdgQ2CRZgOskvh5+hDMSQI4h1AZIl/R6p2
	d69JDPBXX1Cvy/BGhkhdnmzY9PysLvuSJkbVwXxNLjZ6oD5EmkfCLpeOCu5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739969960; x=1740056360; bh=CWvbO4k7gRL4pG82kvd9g5D/Cc9k/kcQ0ok
	LcqHS7W8=; b=jB+VkIG9dKLFS+KGj3aumgql7Te/r0FGHORS5puWbx0Ka6h4bkF
	EyyaLgLsXNRLC/NUP7T8qZXOSkxHRuPCA8muPofqUkphDGn9TVDwbaJLydpKXbXc
	FiSPb46HjWz/wtW/Wdjzrqqvzrf+fn7dxA31u4F8PigYXMXcwjDlevUogmiVZOx5
	VtqWwqEaLZJcDogQ/Mg/dSJR+5YzhHCozb5RlN8tAaxZsWmFlP8q3RVFzz//KF+u
	nfPqBGJbtcdq0j/k6XkB0/8yM9SJPlFTrqHjiAHfNqw96BOyq4rH6enDDJz9Ryip
	4zvnh28SNnUWxfwLCnbxNW6k8968oQOqJsw==
X-ME-Sender: <xms:p9W1Z_KA0wljGnl71EPyPYR-k--ytfasCasth7hYW8F-QG321VwGwg>
    <xme:p9W1ZzJv9TfIffvq5R2kA-n3w7EdCFQbXaRF2Xf7cwr8YWOppO1RvechSaSJnrgOL
    OMFk8XPZGgz3x6UYw>
X-ME-Received: <xmr:p9W1Z3uc3yrmf6Bt4mHJs6wia2wuV8S2J8lmnPGLgWYSRnk-wCEu85_CPiDKn-EWNwSiF6L73Tt5DQEoNTLXlD6FM0tct7fdQ8Jw20sFdBr0Q5k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeigeeftdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehshhgv
    jhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishgtohholhesth
    hugihfrghmihhlhidrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgr
    ihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvth
X-ME-Proxy: <xmx:p9W1Z4aOE1iG_fOM7z0-KBG1QmoTEcPlMQqBFoTu5MOyX2b2-Zq0jQ>
    <xmx:p9W1Z2bXK-aE6Kx4rfDQquzfocZeuzNbda3TKdhguF9vLUMAlIq_EQ>
    <xmx:p9W1Z8D2HuuVLLb8mNQxRx9vDRZUtm1oku50vb5ep5COZnRsHJPjNw>
    <xmx:p9W1Z0YhfVkb7cpyB0Fx_gvmzCmPCZl8mnUxAEfzf5yT21dneFFP-A>
    <xmx:qNW1Z-4pQTUM96NWyX3gITb9UjSLl9jEWusZU2qp_A0XOFrN4vkO75Jf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Feb 2025 07:59:18 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 908eb3d9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 19 Feb 2025 12:59:14 +0000 (UTC)
Date: Wed, 19 Feb 2025 13:59:13 +0100
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 07/14] refs/iterator: separate lifecycle from iteration
Message-ID: <Z7XVoeNMjXJnlrmX@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
 <20250217-pks-update-ref-optimization-v1-7-a2b6d87a24af@pks.im>
 <Z7S6xzmPb3lK-SdT@ArchLinux>
 <Z7XF5pGsa42jrIcN@pks.im>
 <Z7XRX1gfo942QdNR@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7XRX1gfo942QdNR@ArchLinux>

On Wed, Feb 19, 2025 at 08:41:03PM +0800, shejialuo wrote:
> But there is one thing I want to argue with. I don't think we need to
> rename "abort" callback to "release" and also "ref_iterator_abort" to
> "ref_iterator_free" for the following reasons:
> 
> 1. We never call "release" expect in the "ref_iterator_free" function.
> For other exposed functions "ref_iterator_advance", "ref_iterator_peel"
> and the original "ref_iterator_abort". We will just call the registered
> callback "advance", "peel" or "abort" via virtual table. I somehow think
> we should follow this pattern. But I don't know actually.
> 2. When I read the patch yesterday, I really wonder what is the
> difference between "release" and "free". Why do we only change the
> "ref_iterator_abort" to "ref_iterator_free" but for the callback, we
> rename "abort" to "release". I know that you want to distinguish to
> emphasis that we won't free the iterator but only release its resource
> for ref iterator. But could abort also mean this?

The difference between "release" and "free" is explicitly documented in
our CodingGuidelines. Quoting the relevant parts:

    - `S_release()` releases a structure's contents without freeing the
      structure.

    - `S_free()` releases a structure's contents and frees the
      structure.

So following these coding guidelines, we have to call the underlying
implementations that are specific to the iterators `release()` because
they don't free the iterator itself. And because the generic part _does_
free the iterator itself in addition to releasing its state, it has to
be called `free()`.

Regarding the question why to even rename `ref_iterator_abort()` itself:
this is done to avoid confusion going forward. Previously it really only
had to be called when you actually wanted to abort an ongoing iteration
over its yielded references. This is not the case anymore, and now you
have to call it unconditionally after you're done with the iterator. So
while the naming previously made sense, now it doesn't anymore.

Patrick
