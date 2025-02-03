Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26941863E
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738561269; cv=none; b=RTgq2TTUIxq9PSGdqzCFPRz4oyw6sDggd4IPaLXEBd4L0unaFiInJdDt2177VDHUnaFLEcpuYIuC4Gt0p2vZiZmQ0Igl9iZItQFGH5Ypz0I0/DQqvkWk+/3M5x535wRkewgah21cisDvKof1He5cyR9ozJNW+zy5pGQNpH5GsGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738561269; c=relaxed/simple;
	bh=SJ+YpPdtXrVF8iyWl7BsOrnvuYKfEgYIa2zyrvS6Z4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6e8G9zuvcP/0DcTBOY4T9xvWBNq0lHK2M7cvgnvWUc5HqXZJg+7vCZOgPXb3J5NCPGMorjQCTMgeABl8GMsz9/+e6DGdqeQ26oOKXQR5NVfthvcrmvA6ilOUdRsINg2n70pcE0oRpHKa13hRm9PVTqKmj4SMGp+lHgPIm/iBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=B2iZ0v2Q; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cdaXQAW9; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="B2iZ0v2Q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cdaXQAW9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AF88C254013A;
	Mon,  3 Feb 2025 00:41:06 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 03 Feb 2025 00:41:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738561266; x=1738647666; bh=GD3Mj6Xjab
	8htGruJaTfBflgZ7CsJXk1HF/Gz3QV0Fc=; b=B2iZ0v2QdZe+SYzzw80sTq1Pl5
	82BkC2MrpYE2F2jxlbc1+ej3V2ErOD+Xk6sgp0ey+J71PAp4ddC0oJBm2YBYAI30
	+ZcOPOfKy9azYz4o+HBlpihBgDv1F5xGZVET43S+NFbIX8BONH5lHiLcdMH0Imce
	LwT2vHNj6ACD8TxPSNR6D9RAbzS4FjV1gPzCr3i84RwROqezcIGB6ODr1yXOKTvm
	U4Wis8QGVa01DLmSzhawQZbSUwbX4RF7k+TDdLNxY7O0++/LQ2GYBa27rAhppJjg
	1hEZcyAGLJ+DX2JnNposN6OzKJ/YxbVYN5o5FDnrZva7VmbQNq1yZdFoQgfw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738561266; x=1738647666; bh=GD3Mj6Xjab8htGruJaTfBflgZ7CsJXk1HF/
	Gz3QV0Fc=; b=cdaXQAW9a4AO6Cr3Yu9PoBczf1Anli8QC9snzioy0gN7o8KQff2
	zI9TSbCTEGWNpOp75tRTG1f6ZRSH6FLx/o2cIW6RH+fgYnFZot4erxOcA+zyvgSU
	T4z+c/pfT8i8F+8NniLvFA9NXV4R1exU490fHjsa28Gd6myPxqDubi96Xwz0olSc
	5RNn/6dLqsBPt0ghxRSPIN+7MFx2+pg52zXfccg1/r5Ge5P+gQ5IhCN/Fsy9clmu
	Av07DaR95k2sTxmPu9YsLZS/HeeRGtgLw5I4OHn54wKjaoFVVlLGHUAgD9pta/ig
	X3VwWT/0NnhpZ8zJZbiRyhyYq+qDXAHBE5A==
X-ME-Sender: <xms:8lagZ448ghCDZVxud7LF19XTg_gZrItxsCe5h6hUNGfovauwRxvOYQ>
    <xme:8lagZ554uUhPwkBVYmWoLMt1-Fj3TJUKkaB5ZXVceQfNEDRW4UlKIAdWZ7ovSamcE
    N5k1KL-Ik5l5gtbvw>
X-ME-Received: <xmr:8lagZ3enXsYbd1dOJE0dRiYUVu9Qt9gyHxtRXgdAJ4ybp6fG2vk19FU2jZ5-mYFFeEmnnPf6dtNbdJOvxEbdH0JTfkLj76wp5J2nJYQ4Oedn5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieejhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeu
    gedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguse
    guuhhnvghlmhdrohhrghdruhhk
X-ME-Proxy: <xmx:8lagZ9KjWVm9af-xYOaXAKBqGSLS5xTNvL6F99r-TvYHv0s4r5ZPdw>
    <xmx:8lagZ8IwNfJbESCL8m-q7xmYfDGKSx2RsbPkDz_uZAW7gUm3JHrdsg>
    <xmx:8lagZ-yqMppGv3HzVhWVOg90HbVuI-VgOHqyCBC_HIlXu1xJAa6frw>
    <xmx:8lagZwJgUNk3R8yQOelLitCdCKlA0OCyREtJpFp5Zwe_wwtAutUXNw>
    <xmx:8lagZxEtOWJ9fcYlzKBOTA8X88y1eq8YYgIky9cZHSUnsgSXjWODtL35>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 00:41:05 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1df8b303 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 05:41:04 +0000 (UTC)
Date: Mon, 3 Feb 2025 06:41:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: phillip.wood@dunelm.org.uk
Cc: Jeff King <peff@peff.net>, Karthik Nayak <karthik.188@gmail.com>,
	git@vger.kernel.org
Subject: Re: undefined behavior in unit tests, was Re: [PATCH v3 3/3]
 reftable: prevent 'update_index' changes after adding records
Message-ID: <Z6BW7_aj4C7B-g9P@pks.im>
References: <20250122-461-corrupted-reftable-followup-v3-0-ae5f88bf04fa@gmail.com>
 <20250122-461-corrupted-reftable-followup-v3-3-ae5f88bf04fa@gmail.com>
 <20250201022409.GA4082344@coredump.intra.peff.net>
 <425859d1-d42e-42ee-b59c-723a519f0ad8@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <425859d1-d42e-42ee-b59c-723a519f0ad8@gmail.com>

On Sat, Feb 01, 2025 at 10:33:13AM +0000, Phillip Wood wrote:
> Hi Peff
> 
> On 01/02/2025 02:24, Jeff King wrote:
> > On Wed, Jan 22, 2025 at 06:35:49AM +0100, Karthik Nayak wrote:
> > 
> > Coverity complains that this function may have undefined behavior. It's
> > an issue we have in a lot of other tests that have moved to the
> > unit-test framework. I've mostly been ignoring it, but this is a pretty
> > straight-forward example, so I thought I'd write a note.
> > 
> > The issue is that reftable_new_stack() might fail, leaving "st" as NULL.
> > And then we feed it to reftable_stack_new_addition(), which dereferences
> > it.
> > 
> > In normal production code, we'd expect something like:
> > 
> >    if (err)
> > 	return -1;
> > 
> > to avoid running the rest of the function after the first error. But the
> > test harness check() function doesn't return. It just complains to
> > stdout and keeps running!
> 
> That is to allow the test to add more context with test_msg() or do things
> like check all the members of a struct before returning. It is a bug in the
> test if it does not return after finding a NULL pointer, the correct usage
> is
> 
> 	if (!check(ptr))
> 		return;
> 
> As we're in the process of switching to using clar which does exit the text
> function if a check fails (that means there may be leaks on failure but if
> the test is failing then I don't think we should be worrying about leaks) I
> don't know if it is worth fixing these or not. I guess it depends if there
> are the list of targets for Seyi's Outreachy project.

Ah, yes, should've read your mail first, as you're saying basically the
same as I did :)

Patrick
