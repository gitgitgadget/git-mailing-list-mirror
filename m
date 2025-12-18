Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B280330B25
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766040537; cv=none; b=SK+58gOtowCfNJDIQSMgMFnsDH5tfr7DTuC2H3jd2YOhWQxp9wwBLo2ruya/FW3Ds3AuqUlY3isBXTewyWbbXGVUAYX81i8oKOWlUv0+dYA5Z6U/HcWJ+r+LeamKDP2GKbrb2Ajgwv3P29jOO/4wzg5aSd5rJiUPByaAhfNdxcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766040537; c=relaxed/simple;
	bh=Cm/7G+LqGM6mEotTcAQt/IbjKser/6BWrQdMD43U9yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/XDQ6Y9xSQ+CLn0/beYFOzGjk8n53gwXfcU/MfC8JF2qhQYXEjSDzgOo50dlIDEzJP18SPMjMdt5u2vy5sHluh3LW10BP4d9BEVUgsvumh11A0IqdYh4YsHGNmTygljeuWzxNV3UDPy2oLZlrhjjmEHD2vgvH9MZgzlojU0Y5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JZ5Lj1yJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=igYWYO6o; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JZ5Lj1yJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="igYWYO6o"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 383211D0009F;
	Thu, 18 Dec 2025 01:48:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 18 Dec 2025 01:48:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766040535; x=1766126935; bh=cS3sCdrxFc
	LNp6ppS8R9IpBSZuaJx3Z/aDdCI97GSqo=; b=JZ5Lj1yJG77cOOvKuSnPnuSL5/
	MkwrXf1/uxcHEXDwF9ms5UBVuN1ra32M929+xl17T9wdWcJ9uw8/6Vd7b7W8Lpkp
	/LgenKU7Tldx5J2YST0FjmLt1Wot+AkPn2Q/PxODrmJonKhRfbtigfNrSYnCN5Bi
	3eJ+CDHD3cJpn7CcpMtPJ4P5E8TuFHb32bsvQz5kjBXKqdvspq3069uqL3ZUaTQH
	b0d8mR1BPdLZ1MnxArCcYJh2LVoO6+Or/TLwi2i8cupNj+W2xWVv+hVUxzOLNTi7
	Px4VD72gAirx2kgg81/3unRKV7NFovgpi+ktW7kv7h3vfL62dWPEXSjaVPHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766040535; x=1766126935; bh=cS3sCdrxFcLNp6ppS8R9IpBSZuaJx3Z/aDd
	CI97GSqo=; b=igYWYO6o5KLRHutRs/VUtDx7SdmKc3hR7cNDEWno/Z2dnBq5pyp
	IUbM01m9CRNcES8gKdgKqpnncG99rfJgsEoSkVQFKBbdaPIOLyGK3n254F/8imHM
	31iwNnsEXTJQanJXBClAj8+c9Mz9aIwPXHV4a3gVYA1zNOXF/SVq06pqoztnrta8
	M+4aIXyWH2XKmtD1qa/dTsZybmq4Ut6+dlHeUBznA6GCYr+f73GnsgwaQhN8J91d
	s+cIF1/qtYX88tk3JWXh5Qc9Q2MNfYLiDNN/h94Jo+D8NFZV6xc5GqT4mC98/7J6
	sqVjEhOcRRjHskzyNfcKoFVGJZCiZKQOLIw==
X-ME-Sender: <xms:16NDaS5sWlWhm_TyWV5RBGD_aLwk5EzdCpuTPicTeRR0Ymcu77WA-Q>
    <xme:16NDaR4DrQvbGg9G0ShSx7KB8kNpmItb7e4DUKFcrVOO-96SQK9VcdTBojCy4NxcT
    VEXYoMZxMY6Q2_dB7KGGTFvmtKT_ZsVgz08GPxrVQT3r_aRfFXm9A>
X-ME-Received: <xmr:16NDafE9aIFIsYwpESOdoNy7wrestRuG4qQZr1kIMADSbPJsEONUpBliOitIzvjp-RFEDN_jtJPEneP3oZKDGA1weTFndAySmlH9cOY8lA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeggeejgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvg
    hrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:16NDaaQuDwFRSbAp0GEG4d4VDFXFGUqr4FfOwh5h0-K8vrEEwAXopQ>
    <xmx:16NDaYuxVDhlENlqnfRyclurARw8dY9dLZjXyg8WflglJJZ5AjG7dQ>
    <xmx:16NDaZxlTufVcJeshkcb6Gj0TrqMv-p-IkGWhl-j8SOl1dAlntsBNw>
    <xmx:16NDaS4eELu77ncDj-gfhibc2H8uEa871x2jonpjWeTKQI-AQ9UMOw>
    <xmx:16NDaQr6t8P-jW2CwsBvchtePufP9Y7BRUgs1RrMJKu0H_XMZ1feizOu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Dec 2025 01:48:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3d9fbb48 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Dec 2025 06:48:52 +0000 (UTC)
Date: Thu, 18 Dec 2025 07:48:49 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/10] packfile: inline `find_kept_pack_entry()`
Message-ID: <aUOj0RIyBni17_f-@pks.im>
References: <20251215-b4-pks-pack-store-via-source-v1-0-433aac465295@pks.im>
 <20251215-b4-pks-pack-store-via-source-v1-8-433aac465295@pks.im>
 <qoh5ew72t4pdzdfu5slsc3lqnlai5crudrixu6ohn55cuy2c5s@lzxjijg4ho3p>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qoh5ew72t4pdzdfu5slsc3lqnlai5crudrixu6ohn55cuy2c5s@lzxjijg4ho3p>

On Wed, Dec 17, 2025 at 07:06:02PM -0600, Justin Tobler wrote:
> On 25/12/15 08:36AM, Patrick Steinhardt wrote:
> > The `find_kept_pack_entry()` function is only used in
> > `has_oject_kept_pack()`, which is only a trivial wrapper itself. Inline
> > the latter into the former.
> > 
> > Furthermore, reorder the code so that we can drop the declaration of the
> > function in "packfile.h". This allow us to make the function file-local.
> 
> s/allow/allows/
> 
> The changes in this patch look good though.

Thanks for your review!

Patrick
