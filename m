Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D026350D6F
	for <git@vger.kernel.org>; Fri,  5 Sep 2025 14:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757082623; cv=none; b=tkxdad1mZv+M+Fqotms7hHBi16zzfgQA8nkTwGiwc6CpArCUG6ToUA1DHSieqAqMmizth2MTj+agDNMb6i0XVHRE3Q6Fc5G5e0mAnDtODRU1kRrjqRkymMSCetKR6M/czddAnR+v4EQE7a1+/JkNBUWa+EHuFVvczxzJIRce/c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757082623; c=relaxed/simple;
	bh=PknRRElu/kJ5ubGNGpn+tfHUDbi4HTKYQVpKfSRWCAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvhwKntPyhVNNj/E7VSNwEfdipDZxL1sdgeFmAM+tDQ/FhP1kfjhistLiouDCCaXOBbkaoWAEgvj0k5fVhXqcu6MvDx02Uy9Jevx11NVQl1XrVO3xMqpCVPu9EsErRxE+lWyHFqDNjDCMHMZwyugH9g9goUIjHo7hovD2jgyqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Zq7MrnIf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d05zoj/2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Zq7MrnIf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d05zoj/2"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3894F14003EE;
	Fri,  5 Sep 2025 10:30:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Fri, 05 Sep 2025 10:30:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1757082620; x=1757169020; bh=rCDn6ryw0H
	gRnYLsegOMuO+/9uOV1aVc+4/JZtS4PwE=; b=Zq7MrnIfnxib1a5hryoIzL0FKk
	fvRyH59cC93mBAO3flnGcZfESG9GbA3nVbdys2opVizxFFY7qQaXg98wHTX7+lWu
	u6zDsvxOYoYAYwKfFUdF8vOhBSo/fKdyqInxnx9JxHg8d2lGLQt+hIUqlHpLSFxv
	3WSWDKYHsdkdRgHXal/iFdICJL26IHRXPNHamZHVA3EYqQKKCtCnqLLZH095tlEO
	85xfp2ry2IUpFcvPE1PpgDozga/zTLHqtcmrd0m/9XQpgio6qSlFkFpTGcyWPsw3
	Omx4f8mgJW70G1exCMa/rYCFlILR3e1dsVdGpHk8iq1bNI5tSnd6ULh3+V3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757082620; x=1757169020; bh=rCDn6ryw0HgRnYLsegOMuO+/9uOV1aVc+4/
	JZtS4PwE=; b=d05zoj/2P//Ih+j8G1shxiOl+4d4tpYXRjMOiy9NolqC88JLjh5
	sseb4/6SMZwaEeLfXgPF+jejqGqrPFv98TO9tHx6k/C9AdglNgZGN8wMdtL5Ddbq
	O9HiM3q6UNprWUxlGk+QENqWjlq43MP0ONoQzxJ4c186uOXGUVdG23lIQZhrVfSp
	1jJoST/qqRdf8BElafskDJTNUlIUyQmq6y5RAl4Y/GKvcYX2pztnRXO3OP8xfc3p
	C+/HIfIwcchXxxHHMUDIhU2ClyB0tOCMvzqeX7tytRNETEsXWnb11vGhA7ceSyd7
	FeXw7opjCMMXi1HVFXQ7F5EbPTdMjW21fNg==
X-ME-Sender: <xms:-_O6aMFqLxkI-wZ9CXAXgeZlLfsnQHDgYsLtFEzfc3MJilxoigHyZw>
    <xme:-_O6aP7n74inF7PbAqr4XMNiss4Mfa7Afb7s3_Z1bmsFw7rrZji39G3ZImfVzKW8g
    H7wUV3dff7a6UWDCA>
X-ME-Received: <xmr:-_O6aCsJ3NPK0zSKBtzx6RpzyyqJfynX_eLBZr_plEq0dQDp4r7ln8yFirccEzLZZGTFfGsBhanUmSiMrrmCs19KkY8Fup5ToMhcGcwh_IN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeludegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeguihhlhigrnhdrph
    grlhgruhiiohhvsegrvghgvggvrdhorhhgpdhrtghpthhtohepkhhrihhsthhofhhfvghr
    hhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhtohhlvg
    gvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:-_O6aA6_0U93G9iCROHk0z9xVg7QXx959OHZR2PE-SOCFQyu2Pn1ng>
    <xmx:-_O6aNU6cwEGrrj8GgD5-qoz3UUWkFeuUrVy7N8YEsD-_JE9kZgDOA>
    <xmx:-_O6aC9-Mp_EULYRVNX-317WwEDOIAV4b7WGM5OqFjnncedkZ56UWw>
    <xmx:-_O6aJnaXlamP8FHxhie9qOgYSjoOpSu1-gGEAwCOiCDiDXf-gtt8A>
    <xmx:_PO6aKxEF5yPoeutE4r7JumZsGHE4SVeec5-kqeMgzENnjt7maRuglt8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Sep 2025 10:30:19 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2e7d2e62 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 5 Sep 2025 14:30:18 +0000 (UTC)
Date: Fri, 5 Sep 2025 16:30:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee <stolee@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>,
	git <git@vger.kernel.org>
Subject: Re: Doing blobless clone by default; switching between blobless,
 treeless and full clones by a command
Message-ID: <aLrz9j8pUmHawNcz@pks.im>
References: <79ed51fbd94ec2793ab0388b33963b366e48c590.camel@aegee.org>
 <2ebdff4d-8adf-45d9-8cb5-6d7ee39f218d@app.fastmail.com>
 <7713256d-e258-4356-b303-128fdb417972@gmail.com>
 <aLrWUhtCqp1hMcQS@pks.im>
 <a1f72b71-2068-4526-920b-bab82137a509@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1f72b71-2068-4526-920b-bab82137a509@gmail.com>

On Fri, Sep 05, 2025 at 09:40:49AM -0400, Derrick Stolee wrote:
> On 9/5/2025 8:23 AM, Patrick Steinhardt wrote:
> > On Thu, Sep 04, 2025 at 08:19:59AM -0400, Derrick Stolee wrote:
> 
> > So in general, the recommendation I typically give is to not use
> > treeless clones at all.
> 
> Rather, I'd say that treeless clones are useful if you want the
> speed of a shallow clone with some need to analyze commit history
> (with no path history) for an ephemeral scenario like a CI build.
> 
> Treeless clones are not a good approach for doing ongoing work as
> a human. They are a tool for a very narrow case, so don't use them
> unless you understand how to avoid their pitfalls.

Ah, yes. I should've quantified my statement a bit more carefully.
Thanks for adding in this angle.

Patrick
