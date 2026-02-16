Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8491FE45A
	for <git@vger.kernel.org>; Mon, 16 Feb 2026 06:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771225166; cv=none; b=kRN0lys6YxdWW+S2AyxVCF84mwAZwnLzl9ObjvgoiTtX7u2/CvQz6GRAdz9dqWFUo0VjuzJhvT7ocBBm91DHG3arYwIzS2ZTdc/qwdLZU74WfXyXPPRjekIzHkh3Ia/wJA1MqTAUpSdBNO6JSA3af5ZFjEXdtwF5x9m5COgZj24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771225166; c=relaxed/simple;
	bh=qHpnNGSh0a4Av/FrAtMWnUPxn6SuvlFqjqF2WmFUf+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+CYCCQU1UDWI3mg9A00rS22W2yJz4iSNzZAb/xDUereA/mAKGo25i7+O8Gf6KQPIrhM2Hk6+SC4eiHkG1E4YrdKy48VVqseVNjP8d7yLtWLyoh93fqEAIP8Y3tcrHj4IjZGxYuoJcqXBtLVCsbQJPkgJTxU5n5EbcQRKxhhVeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ddBqIpW9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y5M5dJJp; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ddBqIpW9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y5M5dJJp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C8DC37A00CD;
	Mon, 16 Feb 2026 01:59:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 16 Feb 2026 01:59:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1771225164; x=1771311564; bh=BGV7d2NCPL
	477N02Hj526/2Sz9gOL4gN6ieqzjL0/ZU=; b=ddBqIpW9TMpT6AyO2G8e/NdpOM
	xdTP3clQcLcRqFNLjCoPHLRIZrNDNz9zSrcrZ+2I1XYBP5tXOvU9pYjbAZG2KvOc
	UURtyQEXWfcT/2kiR/SM76rG18nW5kGxFV76zZZ36xDIdylEznLUVzbgrU0j7tix
	8SGcwEfSiVT+mBiLVbDFL/PyZsNDH1hQbd1yWljun5Cl0TcHIqJ6t+OobJjmixgN
	tvbxFX+BqJZRHOosZgYE1YOYf7Q00C6++fkqvI+H9bySYe7HcLAvMamkqD+aLB/r
	HV+muOfJORB1Z6lM1lBWvZTouzAx966uAuZQOOyIhI6rbB7WbeiwcsWXayPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771225164; x=1771311564; bh=BGV7d2NCPL477N02Hj526/2Sz9gOL4gN6ie
	qzjL0/ZU=; b=Y5M5dJJpnSZpHAH0ZAnJpGkp6W3MviBi9su4BqpL+DtJSAGTsg4
	DOPHV3OkQDGi6tzs8u3KxAS7FPeLnCFaRMcSKiXhN6jsDMnl+I5vzx00ooIxYKhe
	P1j+lxGKchZw41TjcRg/OvuINgj5fPptwJYmibsYKnhwliEeRtT1Zwb4a1yFdYI/
	MhmVqR0ctcK4OWxJPc8HUoS3DQhqdPx17X6kNOWw3oWEYGh7hCgV3YjHQfFaP4Jj
	fCyLBjfg57AslslZ6RLptfMxNV4ZM6sz/PhYc1LpMHu8UiV57p0RnR82/yplpVdx
	3EpUaLPq2CMqpyJWV7Q3pXDyJbb44lOuuTw==
X-ME-Sender: <xms:TMCSaVObYTT5GPHI4IIMLsr6iDmBLb_1Lbh1PZbcQ9RJchxQz8EmwQ>
    <xme:TMCSae2azET3iNqoEN3DD-AXjTq683y2bimsFY-EGzraJmxGlR_04sxrp0GTmbsSl
    A-0Z9N_spkXFjnRrvf6hLGk2OFncCBLJs2S6tKgs3ZSI-epTDGBuw>
X-ME-Received: <xmr:TMCSacl33Rm2YIC5UHZhBNWthbvq5_DFkkIYB6YYRubpjOPSCSozomdQgnHuzA-y22o7hJpfalen4WSl8qUtYKzX9FNGeHbESXajMc49tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvudeivddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegrvhhilhgrrdhjnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtgho
    mhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:TMCSadXA1z1sSTosUjOxVKMR5XsPjsvyjsZTy6uTgYZbnCqmf5SKDw>
    <xmx:TMCSaas1jtt32ICa8jCNcvWDJFpVAJ54vYpYMuyLpFIy0yN8WlhSHA>
    <xmx:TMCSaYbVZAcWK8u1fBqP9GwieXvvCespXeSm9VKJOPAyTvBXCd9O_g>
    <xmx:TMCSaRWWhh__r0UZRQJXzniQtq0fTamxMfD7PD131nqWfPHx_U8hvA>
    <xmx:TMCSaUmf6vsuPCH83EcZrGDF3GBqU8bH71xCO0XpwEzKIIVvgXm89QbM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Feb 2026 01:59:23 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b56d2293 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Feb 2026 06:59:21 +0000 (UTC)
Date: Mon, 16 Feb 2026 07:59:18 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org,
	jltobler@gmail.com, avila.jn@gmail.com
Subject: Re: [PATCH v6 0/2] repo: add --keys and rename "keyvalue" to "lines"
Message-ID: <aZLARuSCuy8wYLUA@pks.im>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260214005818.37349-1-lucasseikioshiro@gmail.com>
 <xmqq7bsfgpkv.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7bsfgpkv.fsf@gitster.g>

On Sat, Feb 14, 2026 at 10:14:24AM -0800, Junio C Hamano wrote:
> Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:
> 
> > This v6 addresses these issues raised by Patrick:
> >
> > - It renames `FORMAT_LINES` to `FORMAT_NEWLINE_TERMINATED`
> > - Change the commit messsage of the first patch (I'm using Patrick's
> >   suggestion)
> > - It capitalizes the new paragraphs
> >
> > There was a discussion about the name of the new format ("lines" vs
> > "newline") [1]. Personally I prefer "lines" instead of "newline" because
> > I understand the --format flag expects a format name (e.g. `table`,
> > `lines`) instead of the delimiter, being `nul` only a short form of
> > "nul-terminated". But, of course, I'm open to other opinions about it
> > :-).
> 
> I'll refrain from commenting on this part, as I am not good at
> naming ;-)
> 
> Changes relative to the previous round look all good.  Will replace.
> 
> Let's mark it for 'next'.

Agreed, this version looks good to me. Thanks!

Patrick
