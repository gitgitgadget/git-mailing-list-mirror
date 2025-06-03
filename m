Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB4B17996
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748947626; cv=none; b=QcK4+nbiB0FeQve6pl5aoEdJG8LfIfvxGiukhfr5EHK9erao07onVENPCwFC0oowD7eP/gS8iiJM/thJTEe0loEA+a+j4XAR/rRhz6YasULj6JXXmvMiuuwcRvenB2ZhZAo1Avl14n7oik+2z71MW1zTcdFzV8/mnHH0a9roxZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748947626; c=relaxed/simple;
	bh=ddJPupwEdz8MBq9sUN7xEIPuDIEhEVCTMJF4Nlo+/ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3JFK0vuJfDtcSmkElQ45SOa2oziMBAG1gtuq7FdfhpJXRLfUV/OIK/7K1oRyiSgVrPmkmVyZ5WDAEduOvZrACP7JvF5k3F5NE+Q+mXKodfq1eBfyxA9FHi5OFRoueakS/UCP9h1TsmxqHOPPOyfarxWvmHIc2TL0iOrNh4ANnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=WR21MOId; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E2V+lQlB; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="WR21MOId";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E2V+lQlB"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 034DE114014F;
	Tue,  3 Jun 2025 06:47:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 03 Jun 2025 06:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748947622;
	 x=1749034022; bh=egnpfm1fzaD8GXLTX+h+O58mpAQ8r5/fSkfIwkKRl7Y=; b=
	WR21MOIdekgPzqlPrNPUKP9qzt9r0MPaeg83tZANlSp37YOSehcZ+vXsK5FNXaVX
	ebcj5/vHiOgdbvuYBcZSXzrh4oT2WabNtS0GV2YX/qyIZYmzh+5yPcrAXpbXIVn2
	gT3Y9C5Y7nEs/GrLPB9yF02ZV+zlR6Csgm6KmzwNGJBP/vN1P5o07BjBaKScMGT4
	+xutuddg/BEcXMLHaV9IlIG4mTY6HvWvgOWFxoRKBKgy9DVKqLTotKI4iodPcLf0
	D5Ntc5Tk/9mNSUJQnKcTU7f8sFUQxde1KqTI70cdSWUzEYMA848gLkLEwD1Xf/QC
	I6s1US68PGTibxEQnG8OvQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748947622; x=
	1749034022; bh=egnpfm1fzaD8GXLTX+h+O58mpAQ8r5/fSkfIwkKRl7Y=; b=E
	2V+lQlBXwVDCGejGBaSUG54JwIVyB1w4riKGCSmxKzCikWhxaBQahMOwQmrPOPsd
	aOYMbhnQDMHzfFD0Ndtz3wiF6EmEBvzNmCsACCDWBn7PYPQL6r64pcRu7qWouGP+
	fJIfzXLB3S6ZPZk56p+l9Zk4hfzoXdAMQeVTHjESDyGK2aZ0FArs6IRGbQd8/XzV
	UQWRkOAU97vlk9PcCmnYo7GxU/L47QK4vU7vrUB0oco7aVfEfnLPSIKdy1XpZfZ3
	bD7QlWH0k0pbv/65l4H7cXLC5UqI2nNsshkgGbmOxFKPXdl1xGznM4l+CVEFSwlo
	cIFK9wydnfl94I97f1mGA==
X-ME-Sender: <xms:pdI-aMA_KgSfw8o3c-iF7uRbVv-umyLEu4OR24xUFRE3BfkUeiwaEQ>
    <xme:pdI-aOjAOUiXU4TVfrvuE488-46sBqSbEcSKZ_TkpbYHpU_rURrbBy4i8OjeaCRxi
    m5xMa7VCoqi-961ng>
X-ME-Received: <xmr:pdI-aPnqJ6HsX_StzFpet4lSnyUzBFzfbGFOAshb6ouu1JcusSBXPnU6w2Q3JWZ7aoK9feKaiNnyKioOBjGFSRSO4IG8pk_moqYRbLtzUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkh
    hsrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhope
    hrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdr
    tghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsth
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:pdI-aCwuikui9MVCfKkRjtAbmrKbhZNrdTYrfYR1ZQGGCu1pYhrMLw>
    <xmx:pdI-aBT1JESlzgtTf0LxCJkgwZutGpaBpemLUUqoqg8jbh5dH54MDA>
    <xmx:pdI-aNbtQv-Iyvpocsr4DEm2L6qJTQW_5Gkbs2r_f2bgjBHl4ZJQ0g>
    <xmx:pdI-aKQZExn9Hz0I72DkWYxEC-sYKxNUmNPTvvhk18vSpvhFYbRbhg>
    <xmx:ptI-aITiL4IkSy6djPNnwiESMUdW5LC4akRxpTG_k99xzIgK5JNfvvDJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 06:47:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 732429af (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 10:46:58 +0000 (UTC)
Date: Tue, 3 Jun 2025 12:46:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org, Yonatan Roth <yroth@paloaltonetworks.com>,
	david asraf <dasraf9@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v3 10/12] usage: allow dying without writing an error
 message
Message-ID: <aD7SoaRg4UV6ktJL@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
 <20250602-b4-pks-maintenance-ref-lock-race-v3-10-587d44252dcb@pks.im>
 <CAOLa=ZTLvL52UpZZbXtMefHPE+s5PWhUR4ZLgB6T_JMFjqfBZg@mail.gmail.com>
 <256e9e60-fdea-461b-b43c-8e6024b773a2@app.fastmail.com>
 <CAOLa=ZQTYTNiUhFW+kOqMro0rpWVTkyKop7az_6h7zgM8njRhw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOLa=ZQTYTNiUhFW+kOqMro0rpWVTkyKop7az_6h7zgM8njRhw@mail.gmail.com>

On Tue, Jun 03, 2025 at 11:04:56AM +0200, Karthik Nayak wrote:
> On Tue, Jun 3, 2025 at 10:34 AM Kristoffer Haugsbakk
> <kristofferhaugsbakk@fastmail.com> wrote:
> >
> > On Tue, Jun 3, 2025, at 10:31, Karthik Nayak wrote:
> > > Patrick Steinhardt <ps@pks.im> writes:
> > >
> > >> Sometimes code wants to die in a situation where it already has written
> > >> an error message. To use the same error code as `die()` we have to open
> > >> code the code with a call to `exit(128)` in such cases, which is easy to
> > >
> > > Nit: This reads a little weird.
> >
> > Maybe s/to open code the code/to open-code the code/
> 
> Ah, that makes so much difference.

That reads better, but I guess we can improve it even further. How about
this instead:

    To retain the same error code as `die()` we have to use `exit(128)`,
    which is easy to get wrong and leaves magical numbers all over our
    codebase.

Patrick
