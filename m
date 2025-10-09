Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74A296BB8
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 06:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759989846; cv=none; b=nUNWbIfy1k9X9AVDLPWDnnlqH8NiJ8m9TMVMpsrywiuu7cAUQwF73op5GPo6z6jkSOJZLDBUQywVZWISPlboMNSmYjM5zAyozZ5maQ8QVU6v0OjoJwMCpQY87+WOAcQnFAN7HVyn6knTfmIx/15geCeqiTryJDb3ThImumFj5QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759989846; c=relaxed/simple;
	bh=t1vNjrmqGJ7jrJKasG3V2vGfLeYriy4w2wl+TlYqEIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqYtBgakk0RqNhe+LyV0Fz4xeuIW8rN6Ue3HjtBz1Sd2Q6B69rYoKfj979fNHxebNNtKIecLyua6WsKSaC7SE3/Pb2QtO9DfTJxmDAT+AaiiLRPX6UeQYTjhZtqzu9srIsV3D2y3Cpub3VaxdZQBLy4AQUscDxLc1aeUeYpAxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fg9V4IIV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h3pZof3u; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fg9V4IIV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h3pZof3u"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77E337A00D7;
	Thu,  9 Oct 2025 02:04:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 09 Oct 2025 02:04:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759989843; x=1760076243; bh=kO7Hcnups4
	9GIB8hHNWShtO9E4sLepZrcoPMQ2kmcSg=; b=fg9V4IIViTiGvcGVdWRblcnXhn
	5POx80xB9RspqGf1/GO0XbLs507jr0yTM378sKV1fvAv2AfvurCxVXRYeQpPluNE
	rKKdhjvQTXdTyqIGYLC8fXzJN8m+XPYRGl01+7ZxAJjF7IjeYMIVeVSdoUjWMoDC
	aZHab03d1jJ/yZQFJlE5AVxfy2w+F4GKB4k1j3qhFk6ul+VwryXVQowH2e4jLJa3
	wBK8/mumIz99Cilq3WWpVAwXjrH/yngj2c+mED7EnRsS3VQy4LNhEO0aHMZvIHoc
	GPaKfkMFP6LK7I/P7CVKjToq2Ja5pyOKFncxE97sooW2lDmRsasOT+3NEhjA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759989843; x=1760076243; bh=kO7Hcnups49GIB8hHNWShtO9E4sLepZrcoP
	MQ2kmcSg=; b=h3pZof3uaRnPU5kkQzqo7FJxTh2SGrbQlFpZdjU4gsg5e7BxBrP
	lR3WSYm8C720F65PdY57G1hOU3KA8tF5TFgknj9Pl2Vp1kamwMVdzQEXwJOHkf0w
	GPxxS4UoCDer2m43vjq0Xe7VQX/Pnh56DxuYCEPy9aSlbddABLD7MTZPdtAv0tul
	jvRD0hzACa6pxkifZVpSoKcDx6NC9wS74XAxUvlH0/VakG06gYwN4YjPEnh6Cj9o
	aEmMlrKuOf2NMgtoo8VB6DJhp2A0C+JCm+JJ47RNmMijdaoH+UCIM7X/5mTYb422
	/N0qGW3aHBSzNgQEHcNXxkcbK22cxscJxTA==
X-ME-Sender: <xms:U1DnaPCunfv5Uz1SdvJYNiqCQn1tZlgTfh2np-SeHrJ-LcUsF4H-Wg>
    <xme:U1DnaLi7IgukPFsp2BZqA1XRCFnFVXVpEa2yhVdWyb7tzdIY_OVn689NPA04HL5pG
    VbkToHsIjVmo0Ppeapi2b7wJyKdXAvtP0Ir1DKwrPiQLXWAP3EGPw>
X-ME-Received: <xmr:U1DnaIMzWsTBWXP631U-mrjzNPfs71LfGVtgCaHAQsZOHvz4t9ZHwZQnUqguBgd7OicvWjLt-2gxfIi4fukC7YkVsMXTyi66wLIYfpNo9zE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdehgeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:U1DnaM7pTeOcj09zdU_1QwPpPOHBbMkszOKQ43-j9H9kACwrIxgp6Q>
    <xmx:U1DnaG0e6t-F2KE9Y6R8_SHTmAn0ZHJ43GFskQ8d2ya61p1lYcXgxw>
    <xmx:U1DnaNbNGN65tzSdq55HbB392Re44fSEPBCoIgdX0ZdRGeLLOlTJbA>
    <xmx:U1DnaOCaWgpx6kTxQE7lv8JDGdta6ZFr1jRNnoNzZ-_TkNTrnEf1fg>
    <xmx:U1DnaOwYMuQEDd20rEEOaE8BWDMSlNrtes_OO_9T_piz6hGQCYJMY-jM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Oct 2025 02:04:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id fce44468 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 9 Oct 2025 06:04:01 +0000 (UTC)
Date: Thu, 9 Oct 2025 08:03:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 01/13] refs: introduce wrapper struct for `each_ref_fn`
Message-ID: <aOdQTcH_ik3si29C@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-1-916cc7c6886b@pks.im>
 <aOaIuji6EDFi-Yg5@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOaIuji6EDFi-Yg5@ArchLinux>

On Wed, Oct 08, 2025 at 11:52:26PM +0800, shejialuo wrote:
> On Tue, Oct 07, 2025 at 12:58:38PM +0200, Patrick Steinhardt wrote:
> > diff --git a/refs.h b/refs.h
> > index 4e6bd63aa86..2b24a3d9974 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -355,14 +355,32 @@ struct ref_transaction;
> >   */
> >  #define REF_BAD_NAME 0x08
> >  
> > +/* A reference passed to `for_each_ref()`-style callbacks. */
> > +struct reference {
> > +	/* The fully-qualified name of the reference. */
> > +	const char *name;
> > +
> > +	/* The target of a symbolic ref. `NULL` for direct references. */
> > +	const char *target;
> > +
> 
> I have a question here, why do we name this `target` instead of
> `referent`? Oh, I somehow know your motivation as we already create a
> structure `struct reference`, it is redudant that we use `referent` as
> the name.

I don't really have a strong reason to be honest, I think both "target"
and "referent" would be fine.

Patrick
