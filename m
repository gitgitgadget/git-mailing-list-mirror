Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CA81853
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 07:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743578499; cv=none; b=J6cMZ6pliMdDa6eRK5+zpZ39Q/yOzMA09BIXNXBPHAEA5Au4HlvC5N8lsNEQd2K5/mCuxSoJCfuNDhIQojkofuh0+sajJJjLdPTUp9gNPApZrYGQB5zWtXay+Uk0u6Ip+ixR0DcAsfEzMPmrXdxdUFlhxrL/dQmB0wY3rKPfFQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743578499; c=relaxed/simple;
	bh=nEZvNh12DRw7c+maLikxzlkoYE4SyXKdohZ5xZTh2z0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gAle1J1DCCUfWMF7PSD5Tm74pPKNLr+lcpncIrHaM3a85cS7KD5lcL2iXHQ0Wpwxs34/eHweE1OnC2wEkfBF8V9l2HoWgv8mUCpe06mNnwo4LDxKnvOQfjkI27EtnbOvufhyqY3MlwpO6RP3CHLYjqP27PtNpSIgnfotYtI9LhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rn8MKJuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tSQLxVMf; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rn8MKJuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tSQLxVMf"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 763BA1140107;
	Wed,  2 Apr 2025 03:21:36 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 02 Apr 2025 03:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743578496; x=1743664896; bh=x14GPs4ggT
	FndL1SBqyBBNdm6K6Y7fIb7TML+TZNPR4=; b=rn8MKJuXoRe1SG6izqAG/zq039
	npB6NO00CXSzMdORNaKbGYbJASTj027VSSCZEwFlyCassyV3/ASJzWNciZPbXBNF
	OalcXtHrdaXAP+As+U10C72MfgSXNrhssb2t6dgfmy1kJobmefkbZWmTr53oYP/j
	l8URcRbwLMJR6l9WBPOODNYatYkGrFeaT/jEX1loHG1diBgPwP1YP/DUqbAi2Cky
	BDDnC0QtaFGRHR80xOAkQpjHXm+WBkDTq9IolpUuNkJjhGygHu/hJM1OCMb2bJQV
	1QtnjYJEoP62mRcofbsKACZaJuqDBPhLDWoVgyrrgrilKHrBCrNyDy7xoJtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743578496; x=1743664896; bh=x14GPs4ggTFndL1SBqyBBNdm6K6Y7fIb7TM
	L+TZNPR4=; b=tSQLxVMfoLXqb6DE3yy4y7wmpnzTNkSmgcok+/DDTBHlV9KXq7v
	BNsJGiwpYWubL/7Oc3qmq5yRlnyoAC5nxFnkLpXMPx4+TkSEo3pmcc4Wu5Zb9Mx9
	VEuxqhCF1o+lTtB2ahquYUZoQyxeRS1G3MTMXyDu4rffH8MRbAxZaiNhDQya3FYu
	N6JTjiJaTAurS7/YjcSK6IExh1ssGA3MpyADCYcGBqqsrGHrVDAoShvqds9QifUF
	DWWl7tdNFwE/fxQ/gzEjcn2CsVX0yC44L+AYPp1eO7NCmdnjYRzKUrA65gph4v4i
	jFaHYe8+hf2eciQyVmLPVoRFtTl3BUzGk0A==
X-ME-Sender: <xms:gOXsZ9iA4d0nnG_7g-R5SMrP0Iw5QhR92ewl0BxJWmyd34JvxCuT7g>
    <xme:gOXsZyAI3HEUIg3om2wNZFhEi8T_CofAoYuOXGmcBLcSyYK3EBmerhL5k7jXygUDF
    8WswF1BeX-Sqpq0tg>
X-ME-Received: <xmr:gOXsZ9GN3F4543SwCm_kQ4FBalXGt-NGq7rYOZ0xbOqcXh4dS6fo0QAw2YBnTB63_tT-jmta54I19ic7y4wm8UCcbEa90I_suMJc_uMIs3sPdw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosg
    hogidrtghomh
X-ME-Proxy: <xmx:gOXsZySU4cpgBmAm752WqxaylD5DcSShkq4RJcWTYHCC_HnqfFgcwA>
    <xmx:gOXsZ6wvmBIqJ6N6r3AWYROce9z5oU2PVVcNXtbLOgK-6EXsoKIBIw>
    <xmx:gOXsZ45wF0HspQYJBvNEhc8iG6-r7xOhp7SDFAlAkkQvXkY-b4-BjA>
    <xmx:gOXsZ_wRoB-WXlf27EdLA1wJoqJfls30OW4RuNTWINQLdS6h7gMU4A>
    <xmx:gOXsZxjnn7APy258xCh7x6RxtpDg3zbac8pxDoP1O0o3Ds-Oi_sbRvxl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 03:21:35 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id acb52d5a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 07:21:33 +0000 (UTC)
Date: Wed, 2 Apr 2025 09:21:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 14/16] reftable/table: introduce iterator for table blocks
Message-ID: <Z-zlfVIRRrMmHU-Y@pks.im>
References: <20250331-pks-reftable-polishing-v1-0-ebed5247434c@pks.im>
 <20250331-pks-reftable-polishing-v1-14-ebed5247434c@pks.im>
 <xmqq8qoja62n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq8qoja62n.fsf@gitster.g>

On Tue, Apr 01, 2025 at 03:08:00PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > +	for (size_t i = 0; i < nrecords; i++) {
> > +		records[i].value_type = REFTABLE_REF_VAL1,
> 
> -Wcomma,error

Hah, good that we've now got the warning.

> > +		records[i].refname = xstrfmt("refs/heads/branch-%03"PRIuMAX, (uintmax_t) i);
> > +	}
> 
> An overlong line.

Thanks for these two, fixed both of them locally. Will wait a bit for
more reviews though before sending out a new version.

Patrick
