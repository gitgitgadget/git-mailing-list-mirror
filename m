Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973D93793DC
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 07:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776669237; cv=none; b=fFasnWLoNihdIKq2nBNon0l5ZX3ZROPXI9s6kz6pFxsNdg2BixA4O2mTyRf/z5vybKYNbMiuDmP55RZVkox8ndS0urMRacj7zYZa6FQFKgyC2AH5qD4bPeErPF34bHyOExXljp33ZypnwLTNwAdACu5DZGEQLE5lYZFWRPO+eEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776669237; c=relaxed/simple;
	bh=jAijbz+PajhuSPZ5xISvvHg/ij12XMndxPyg/jLN5/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AACED9MIwQ3i1mrqDgcfgTd4QhYao12SB2vlDrg+8AupLUlrdUHGG9VHuzKLDsHBHKaiHWDWeS5GON4sdvI4j3Ckzwa9cgybB11/EVp9nBYv54zTb6Pana4NpVaRyH6ETQdt2ACDCCz5YD9FL0dco30h+kKrKDikMaeWb+QOH+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b01dDq5/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fVHMWqhx; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b01dDq5/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fVHMWqhx"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EAC98140016B;
	Mon, 20 Apr 2026 03:13:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 20 Apr 2026 03:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1776669235; x=1776755635; bh=qzL065nF8H
	sia5MpgrKVY2ahBsd7yygPu3mFY0Hckvk=; b=b01dDq5/HIF3y1FcZfKk8foyQM
	yVr1ECwHDkhd1ZOWU4nBbU03Ge+cD6Ha0vpRTya0+pp+t5OUP92SJv2h+bgeYenN
	+7/DOWb2DPqCAhLJnEsFvKAzA1Hpq9oR5qaXUoarorOq2KEbU4iCSuGhxi4norld
	2mwIX/FwcAuYBKAvGYupJR/U0sR0VovTBGI3qK4nRKlJ7i+QGAZy6z8rbmdB1Yli
	mkdkpDzYsur1Br70rz7iio4Lof4YjWSVMSN9jddgNQ8rYSCeYVixAQnlGmhVqpua
	oNLhBZzgkJ2SHdyvVmnuZXKdIPtGaQk6Y9tgI3Ci/m9JwFVBcIGOI46DQoRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776669235; x=1776755635; bh=qzL065nF8Hsia5MpgrKVY2ahBsd7yygPu3m
	FY0Hckvk=; b=fVHMWqhxlOMkCNVoNYi7EGMuUjZpx6EW6zjwkYyjyApFqjRO14H
	hd9CN4sxMT9MS/v/LGDfZijONcJGC+6TfAcghKsHAlk9phomfrXT0xPFZFrumJ5Y
	qi2Lrh21VvPM6iF4SJ6hd8G4RpKM003+A3AEgZVg+4T67z8hZG+rd+GoSGgZ8sEo
	R+uyKOHKvb5FIsNhgDqS4XNr2MYlJLD83UCGBKyYGiRU5jOHZCBTEt/Rry3fXCOY
	J0/++Kre+T7SoDcOZTA3RkzJE8WSM80VKa6coYqEK3xUgWaCZVK466lsSZF5MaYB
	TT79pyjtJvP8iVydTS01k8ckDTxX3COq2Ug==
X-ME-Sender: <xms:M9LlaSLMNohdNjHxxlkANdNADuHFRJIiZJuZsK4WsEDURE7uSbhMDg>
    <xme:M9Llad23hN2lSUTaIp_F1pIwDDh-dSWlIetMwySKf2WKnKFbP5CiBOVZ0juHP-7AO
    1NzJ7tw3wFQqLvdAIekhKYkhlpIrEWWHrdrFVuY0nA4NBKRIWk>
X-ME-Received: <xmr:M9LlacgxMv17qFT0zccnrjPNimMB72WNH6dtrh0tCEu7FBZntsbNA4O2fpuZ6ckXYIg7YXbXUdjTEENuqPF6ciJ5H2WTtQ8DDXIU6iVG1OMr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehjeeklecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegrsgguohgsnhhgrggusehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhohhhnrdgrrd
    hprghsshgrrhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhgtvgesfhgvrhgu
    ihhnrghnugihrdgtohhmpdhrtghpthhtoheprhdrshhiugguhhgrrhhthhdrshhhrhhimh
    grlhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:M9LlaeVRZh8OXfzMG-p4RlDPotpIJy4eZfCaC79vZqRxSqN5Nnke3w>
    <xmx:M9LlabVrtsftvvNbTxnZPfDv4D9E-AVKeJlVUNIF-fHyYoHCEyQz-g>
    <xmx:M9LlaeiYfL2vux3ifs2URFLGQgaLkta3in54AmX8Y8ZsrHxrrZO5wg>
    <xmx:M9LlaWYBVtMujEc61qBpAY-mFgJ5NKDocuu9zpi1qFupudbmHrRJ5Q>
    <xmx:M9LlaQUPb2KFYo9Vx8X1itPcEtA5lcF8TsAXEIzzX3yssxvsHUYxFqt->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Apr 2026 03:13:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 807add01 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 20 Apr 2026 07:13:52 +0000 (UTC)
Date: Mon, 20 Apr 2026 09:13:49 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>,
	git@vger.kernel.org, abdobngad@gmail.com, bence@ferdinandy.com,
	john.a.passaro@gmail.com
Subject: Re: [PATCH 1/3] t7004: drop hardcoded tag count in invalid name test
Message-ID: <aeXSLcVl_eGFkagr@pks.im>
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
 <20260414141828.27576-2-r.siddharth.shrimali@gmail.com>
 <xmqqmrz5bhz4.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqmrz5bhz4.fsf@gitster.g>

On Tue, Apr 14, 2026 at 09:54:23AM -0700, Junio C Hamano wrote:
> Siddharth Shrimali <r.siddharth.shrimali@gmail.com> writes:
> 
> > The test 'trying to create a tag with a non-valid name should fail',
> > checked that exactly one tag existed in the repository before and after
> > attempting to create invalid tags.
> >
> > As pointed out by Junio, this makes the test brittle by relying on a
> > specific global tag count. If future tests are added or removed before
> > this test, the expected state changes and this test would break for
> > completely unrelated reasons.
> >
> > Since we already use 'test_must_fail' to guarantee that the invalid
> > tags are rejected by Git, counting the tags before and after is redundant.
> >
> > Drop the 'test_line_count = 1' checks so the test doesn't rely on the
> > exact number of tags left behind by earlier tests.
> 
> The only thing I suggested was that relying on exact state before
> this test makes this test brittle.  I do not necessarily think
> "redundant" is bad.  Having belt-and-suspenders sometimes help.
> 
> Alternatively, if we wanted to catch a bug where "git tag" exits
> with a non-zero status, satisfying test_must_fail, but still creates
> the requested tag, then we could do
> 
> 	git tag -l >tags-before &&
> 	test_must_fail git tag "" &&
> 	... random attempts to create with invalid names ...
> 	test_must_fail git tag "other~tag" &&
> 	git tag -l >tags-after &&
> 	test_cmp tags-before tags-after
> 
> instead.   And that is a belt-and-suspenders approach.
> 
> Having said that, the patch is already an improvement, so let's take
> it as is.  Unless there are other things we may want to improve in
> this or other patches in the series, that is.

Hm. We now rely on exit code alone, without verifying that the exit code
actually results in the expected behaviour. I'm a bit torn myself
whether this is sensible and a step into the right direction, and I
would have preferred the `test_cmp` piece above that you propose.

Patrick
