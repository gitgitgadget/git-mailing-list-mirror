Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF3026F467
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 11:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765021151; cv=none; b=Xn13SZW5w4EWd2G3QDPbxWO1fDCZyezogMIpYBnOE3XGIt4JpFERRzIic2F9HPz61xV5CzRo/i1gFILQI5WHSwWmZlTqhfvhYAd8M10rI5gSg/2mac1Y7I9qm1nA/dwz/KNfgVP79tPfgNDoEebbm4zASVin1EgF0Zkdl0twp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765021151; c=relaxed/simple;
	bh=Ap5FUfwTohuHokDwpg5ItBZ8s1chgCx+AYSkj1ELtLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7gQxsF0bGlsArzw1SmQ9CU9YQZF1Qu8dGbwUdyIyV5j0zjuWSYyg5NImDmDlcnqTYlFApb2/PwS2twEiGFhHBpresRJMH32iw1cV1ecK6bPcl5rQhRHOHJuKo3MT4ayGOFNWGuHYGfd15zoOeHlkkLNPW12GFe6tDN6iN6hrzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BjkI8v5h; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a/s+9nKL; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BjkI8v5h";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a/s+9nKL"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 722147A00A4;
	Sat,  6 Dec 2025 06:39:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 06 Dec 2025 06:39:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765021147; x=1765107547; bh=URgczsVnIl
	p6GCA51PvUGx9rGNG33c50W1eChj/YBWI=; b=BjkI8v5hRMsy5iDpokYIX99y1u
	MOtTy3tbPoPbZQKoeQy3R7LNzryTVKpPGPiuZeB5yTb1Wp1FjWooVsWnjamF3Ux3
	jYWtG3wWwVz0YllHxHeL3LMibivHDCH0vb0oHFWKPRuSakorhx+MWfcHm9Xh5+V1
	vK8Gm4HT9Cle0tAAxh5WJpzJ3A5zjmETO5N6Boum7ZpnCr9Vba8LS5aqL2KbBUj/
	p7NIQu2mXsDZU5vPt1Qu2cKpeD4LvAKcyuik3W2BFsqmSvefu/9JTSQnYYKSnb8e
	1tGxXjKACV5T/UCQazdUDI/HImcEFOZxx2edIQcrfBVrB7S/Tnri9SnfXnHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765021147; x=1765107547; bh=URgczsVnIlp6GCA51PvUGx9rGNG33c50W1e
	Chj/YBWI=; b=a/s+9nKLZVBZc9FH4qBWgODc7bRHHT08GeuraxnD7Hi16AlqqhO
	iTigVXZL4rE+nF/EW2CWhNMjK2bqg7KsXci6weeSFglkJoGsnx4FSfW9xCk22I/P
	L8wpY61On41L9Pcu7rTUUwJ2WSupKAwuCFbah6hwUiz1jPaHbjn5+/MSJym2hXTN
	CQc3zI05FgK+iOOyJqhRk9xSL8yyh72pVLVDFGOQru/laEqSlbTfCeZuKIW9m59O
	29nYYnv8xxyRgvPnH850m0kDK48jA7hPqhijZfVXN5wn+zTEBm5HDz2XDdH49ESZ
	gJyjge4wjXL4WAnemR9t340OVOyoZ4QioYw==
X-ME-Sender: <xms:2xU0abO5_rnY6l27ajPaIME9y9Ua2y7A_7JYHJW22qUbZm9T9Rw4hA>
    <xme:2xU0adbaISneZHNyTnmeecHzmmtkooP30Nb0il32l53R9iPDVxks_yxgA84ZbtK87
    TIk8PPAHMKKksxff6YXT05TJVEk-HVVbHYG0QRXP0QDAzOPSmhu7g>
X-ME-Received: <xmr:2xU0aXp5zHNc27WO51PoKtr2bozPNYc0m6kGwFUn8IabA5etLjVgy_BH731KwixvJxk_xyQIaWo6UA8G-Ihqps_1boxjmMLjpGvPTQM4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:2xU0aZbYdbTmERkvBb7WK4WKZ8XlkKT_aM-d7d9jmCmDfiIUXIYFgA>
    <xmx:2xU0aXR3bd8IOkABCdbqElMngKfkd97zuEpQuhXGxsU4WZDF16ACLA>
    <xmx:2xU0aY6Vbzyv107eLHWE-NeAPc7mrMegcMxGkIDDtw9H7zbMNoZfBQ>
    <xmx:2xU0aUxLm2w3rCHbfe7IUGmtXq-erP0bdYqzPvxPt5KWGOSKygDh2w>
    <xmx:2xU0aRHyir_MPPIdixWJ2F8KF61pmYEkRxT_nfVmS18nhLRhZ6HRi9df>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 06:39:06 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 468f4e90 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 11:39:05 +0000 (UTC)
Date: Sat, 6 Dec 2025 12:39:00 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH 1/2] t/unit-tests: update clar to 39f11fe
Message-ID: <aTQV1B_7s11Cad9w@pks.im>
References: <20251205-b4-pks-clar-update-v1-0-fd70aac2ab90@pks.im>
 <20251205-b4-pks-clar-update-v1-1-fd70aac2ab90@pks.im>
 <20251205184020.GB33447@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205184020.GB33447@coredump.intra.peff.net>

On Fri, Dec 05, 2025 at 01:40:20PM -0500, Jeff King wrote:
> On Fri, Dec 05, 2025 at 01:57:52PM +0100, Patrick Steinhardt wrote:
> > +#define cl_assert_equal_i_fmt(i1, i2, fmt) cl_assert_compare_i_(i1, i2, CLAR_COMPARISON_EQ, #i1 " == " #i2,  fmt " != " fmt, (int)(i1), (int)(i2))
> 
> Here we still cast to int. I guess we have to in order to keep custom
> "%o" and friends working. They probably ought to be using PRIoMAX, but
> that would require changes to the tests to do so (and I wonder if we
> might hit any portability issues).

It certainly is the oddball in this context, yes. I would honestly just
want to drop it entirely, but I can't because it would potentially break
other users. libgit2 for example uses it :/

Patrick
