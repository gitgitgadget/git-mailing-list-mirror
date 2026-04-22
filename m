Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C4973C3C06
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 11:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776856549; cv=none; b=ePU8j/jnz0vubJw2pKY0oDIs1VqqOWClsmb6MYRe/KQ2tn7Spfr64XwZ+w+HxV+IFtxVxUYLsNwG3utL6ncEszhdVCAWMdi5q8/QSl4NAMjbB4HZ0uDPzoi+KcMKhoPd1sxJPGsho/LO2Ppwx8Z1X0oRzfHtEbyi71w6J4UxDyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776856549; c=relaxed/simple;
	bh=cEsCibI6FXsBQZ911buIDefKFwdvqpUWkQ76TGSg/ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mNjK9CnhJTp+C+bVGPWzaZPndocJnIToE7pEjZVFIVO9pJ/afKqQpYVZUSxMq1ikmjzmkngQ5zebJGyLP6LpecT2vyh4Tg1ggivxEh1vcbntXJPNzAvi1mR4q4V5JyyCcFzRlhXeCE2n7Vv8rYGnqMYBaqt5G40L+JjgNbjvZaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kR0OCmye; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DO+2uxC4; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kR0OCmye";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DO+2uxC4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 197237A0154;
	Wed, 22 Apr 2026 07:15:46 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 22 Apr 2026 07:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776856545; x=1776942945; bh=cEsCibI6FX
	sBQZ911buIDefKFwdvqpUWkQ76TGSg/ck=; b=kR0OCmye4dYL3svMj/VEFBGXJn
	U6nxbLu4BOF2KvzosrrmE18FxLrAAkOl3IPmdfG4M7CmKd9tT50POsG8oGAUO/fb
	SYXas4K6XMJLK4IROh2/+qfG9kpmLH5PRhx3neevDHiQTnnfeR0qjcMNsRIaKn4V
	rJFSWHyNpIl0GKjugAl/nRffMJGNgO1V0k69dajzIwIb5Ty+BR/XnFhoF5iV222p
	IVBjUgmXWLQ1i6Y4HDakzc3M8HBfhSoozUOpie5VHpwS98PwRbmW4S6AIvbTzV/8
	cj/klDFoG8yV8PCcHMP+KpIgJ6rf2kbW4b8TM9coYaq6ij2xnTkNHFnPXCTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776856545; x=1776942945; bh=cEsCibI6FXsBQZ911buIDefKFwdvqpUWkQ7
	6TGSg/ck=; b=DO+2uxC4kYs0CscvqkVYrsJ1vgu5SheMyJ0KInFhdfF4UmmPCHb
	mSGmtaI1WO5YF10ev7MciPRn0z4UKYqPw9zIZId4sSK7jBFQ6hiyPS6kBOJkVndo
	t1sJ22T8Nx9qwqVTqcmJNAKb+O99vw5mun5Chx/L9nHH83+lCprItK+668J/5c3w
	TVLNs4N1xH7EeUrAV7pVvmBBcZkPTjOiu3y3abE9eO/Gr9wJ38cEZPipIRp3j1C/
	+zAEgCx5lzfahBZyR5O9+A/7onxwiuT+63+OkRTrBjzXgTx1vgm8WiZutP+OQBfj
	TIqlWGdQN2sPuKat5//ewWNiFQ8Q3IVvnYA==
X-ME-Sender: <xms:4a3oafhyN5x9662TtrNcVsDj9g5QoQDByhp5DFCVaKzICjtgNGNduQ>
    <xme:4a3oaSBjGjqOLHu-uLSxmo3bsVEHi25885n25-YWTIJuN2pTBioURUf8hU8_pHwt2
    sSaCBBnAucDGH7nYwf9JygcI4ahfyzsYLA4-0baRLgKpI40SyIA_g>
X-ME-Received: <xmr:4a3oacvqE8h2wC9nOYU6sAN00dQaY8KSY74XA2LWzmHtpLQ_mn40H2G9Oyy-fkaVHQCL3PaxbJ5zKhbm5dCKmn9XRDUe_qbzc-RKOe2tA-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeigedufecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4a3oaXaja7rioU6dqEK0TBjkvFNQuqO-lslnMNUx5YgAB6sdymkCnw>
    <xmx:4a3oafUaPwM_6Nip1dKx75F-yGc99FmTQWFBH90y7zTI50B2LyhjTg>
    <xmx:4a3oab6DigHLR6lnJa5PcryZjFr05TlqGYDRY_DY8h5Wpi5N83-acw>
    <xmx:4a3oaah-Ey2-Nq7f9_ceXvbEW0EVohXBNiGH6VLmK8ZiYOo1f-chRg>
    <xmx:4a3oaXTdCo4o7Jom9osfAYJtTc2zewTVGJfHJ0hhycG5vuHXitztGGVe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 07:15:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e53fd924 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 22 Apr 2026 11:15:44 +0000 (UTC)
Date: Wed, 22 Apr 2026 13:15:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/8] update-ref: move `print_rejected_refs()` up
Message-ID: <aeit3RVFhX680NfZ@pks.im>
References: <20260420-refs-move-to-generic-layer-v1-0-513e354f376b@gmail.com>
 <20260420-refs-move-to-generic-layer-v1-4-513e354f376b@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-refs-move-to-generic-layer-v1-4-513e354f376b@gmail.com>

On Mon, Apr 20, 2026 at 12:12:02PM +0200, Karthik Nayak wrote:
> The `print_rejected_refs()` is used to print any rejected refs when

Seems like a word is missing here. Maybe "The `print_rejected_refs()`
function"?

Patrick
