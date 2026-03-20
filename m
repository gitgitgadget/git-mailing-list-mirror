Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1297248886
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 06:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773986835; cv=none; b=b0NfD/OTi37f05Fs/s9e9CD0Sgy1LF1j7w+3w/5V9mZKrD8Q7ut3MnnCpnmENk4T2hBiqeVdhzpUJn1ZUtAWd4behRT/N+aWFRUfMoSQTZvynuIlxHZkI8yJS7XbkWHPaBHJ9jccqcD2slZ0XlGQuHAvnuSOs1exF8l+IPNaeB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773986835; c=relaxed/simple;
	bh=9rKwCHWuvWYb5eJ3CPEkJ0AJJKumJW3OOCjqkmU7zQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQUnje3jZm5IW7TRZ3fiVh2KusO5plv3WgLxxY+gna97CWlAzFo2Aj5VDiEcrt2oU8L7SfeCEh57/eeglJk2FFdgXne7fHUPF6GsMtMIZu0MlnTqDURxMpqsO1TmRFViHoNzyhzwhC2s41Efk63UhlTmn2HYJjsHkcwtz/0X2wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BmgAx1Ic; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=z3Iru3u2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BmgAx1Ic";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="z3Iru3u2"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C21E81400248;
	Fri, 20 Mar 2026 02:07:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 20 Mar 2026 02:07:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773986832; x=1774073232; bh=AN5pzhLOWv
	kViYFIxkvqpoFqyG703VSdComCKo6r85A=; b=BmgAx1IcrXWkRulpanM2z3B2yD
	8wGqrykIHsSC0OYSatiGrc2BJF09UQRBm/1T3W4XL5BZQj71q8eaxh5+dfgABEoD
	goZisLqYcnPEVlAHg0BRGaQWHzViORpWJ6mFZ81gzyHKObw/62hzM0VgFKKpJixe
	UiIZySgD7wla8MV7R1YKe/T/aJJ89eu4pAsrs/GMLBdTt0ob/NdAbolCgY1OyoFP
	EMK1MqA89KmkgVEarI3mKLQdWo0GfkPl5+2zU18ihHKV2tvrqeSY5XR2OpbS6PYO
	xI1Jwg9uClsuSUMrQd0t1ceNLGYKv1mIcLKtF1KKqe67KJc3agA2rg8fuIjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773986832; x=1774073232; bh=AN5pzhLOWvkViYFIxkvqpoFqyG703VSdCom
	CKo6r85A=; b=z3Iru3u2jvDkIMZUieQR11ppHmQKFsNjeHvVl/vzU2zXKTN6kqu
	4GRdAL2qrOHBpdLQmrwrYiZXga/Lu37o4BOVEUmDXKNWYuYREbiIv1tCJ+BiZWJK
	LGxALYdLkg2TwxHeHFgMnfHwlHmLJk7FK7tUMsAqks7nzb11kdvyN815F2sHn9bY
	7+3GhKzY0mmFRw/VbTs19fKQfOExDL52rXgMwaCqRCQhJClQxU+D3DksZe9ZmYRl
	k3qm8l0XyDJPpu5wYsqs54/F3gwtXMXdWwlIbpYH4NKGzORJzp+btJGl1DICDzGl
	znaRLyiyhllyceiNFljkm3BDUnEthwd4tFw==
X-ME-Sender: <xms:EOS8aVCpd7qL0Gav0Vw-5JFphgetFbUac5yHfXdGNHdfyApRq1m--A>
    <xme:EOS8aa_uog5xXtb0qCLTARBuCk11DS5ZN6ia7f_dKn9aPb4Vzjt6mM1RYOyexOTYE
    Z4ODyHDTa6j2oYjrDw728GMaNUxarpa8kcGYWzpB71g5gjZE52liA>
X-ME-Received: <xmr:EOS8ad_iop0JEdrfTlBMkr2CmsuaxV0zdHnSVb7urQS1-FYLUzYfvFjRkHrIUsl0sr9i2wQEs1Ib4O3Qf-sguYVB_gQXp3QqrdKbahE6Uc2j>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeluddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptggrthesmhgrlhhonhdruggvvhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EOS8aZd2jebENwV2_14r8JhZ8nJN_faSanWcjZNitaE26_XJVM7UjA>
    <xmx:EOS8aeGjXPI1Yexyl8qce0-lTnk3iOKwtp9OIgmU-PNlvFgO4fedhw>
    <xmx:EOS8afdtq6jaZQgrkeaL2HTfmkqqdANM4p7uSrTA6EdITzb5BqRlSQ>
    <xmx:EOS8aQHGUNXEwaQRzRg0ZUqbnmUWp3S5OlHzAROuD9fRbp-g4Pa2Vw>
    <xmx:EOS8aXKItXkwtU9m8xW65fwxskpTEc2YbUla948N3HMVHUgjGhkMhIbt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Mar 2026 02:07:11 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d4c9cc2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Mar 2026 06:07:09 +0000 (UTC)
Date: Fri, 20 Mar 2026 07:07:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <cat@malon.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Git <git@vger.kernel.org>
Subject: Re: [Question] check_repository_format_gently() is not
 side-effect-free
Message-ID: <abzkC9uLwZz_nmgv@pks.im>
References: <c0bb931a-3ee6-416b-8ceb-9fab013a621e@malon.dev>
 <xmqqfr5vlmlu.fsf@gitster.g>
 <00d622d4-cfb8-41ff-b2df-5fb58a492a75@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00d622d4-cfb8-41ff-b2df-5fb58a492a75@malon.dev>

On Fri, Mar 20, 2026 at 08:24:09AM +0800, Tian Yuchen wrote:
> On 3/20/26 02:07, Junio C Hamano wrote:
> > The verb "check" does not imply side-effect-free.  By checking, each
> > of these functions tries to achieve something, and the way the
> > result of their work is conveyed back to the caller may not
> > necessarily be only by their return values.
> > 
> > The adverb "gently" in this codebase typically means "the variant
> > without gently signals problems by dying.  Instead of dying, return
> > to the caller with error code, so that the caller can decide to
> > die".
> 
> Ah, I see. I guess I took it too literally. Thank you for clarification!
> 
> Setting the semantics aside, the problem remains: I still think the setup
> method here isn't quite right. It creates a bottleneck for eventually
> handling multiple repositories in the same process without data races.
> 
> Do you think this is worth a patch?

Yes, I think that the whole of "setup.c" is something we will want to
refactor eventually so that it does not modify global state anymore. So
it's not only `check_repository_format_gently()`, but also lots of other
functionality in that file. The motivation is not only being able to set
up multiple repositories, but also making the code overall easier to
understand.

That being said, I'll give a small warning that it's probably
non-trivial to refactor this subystem :)

Thanks!

Patrick
