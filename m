Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63113FFD
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772600851; cv=none; b=KX6rUWVUxERL2EhUfFIU0rpZAxUFeLL4Iqyg/UZJOusqlOBIcfMY8xWbj1qte9k72GiFIxAXwV6aK8O/YodorGQPrmShyM0dpanPnkYQfLPZOF3cic0DHJEUWFKEZgUQrBUKGV8Ojn04avbzKL0Pxt+ub9gVFgkELUGzOmIdjXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772600851; c=relaxed/simple;
	bh=JdtfA40GauDkpypMCXh2ZHFjlX/G5AYuvX+QwjtpDAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBvJ7RxOPeXqUf8eKj1smUpIcX1hn1D6FDPJoOeTlnitqzqypNyZNR9/l5Z2cLmv83iQdVIbnt1z16s50gxn396RHqOowhtNRux81zTFBnPEk+zkxGpXBdkAW/6jgqUemC+NoSI8PYoTuLxXuyS1c2rL9MU3JqmZAt7SnwAM0W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=F+q7Edrb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qE96ZBp7; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="F+q7Edrb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qE96ZBp7"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 91AC91D001AD;
	Wed,  4 Mar 2026 00:07:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Wed, 04 Mar 2026 00:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772600848; x=1772687248; bh=2Jke/uy5Un
	+EFk+OEhzByukMYgfhMoyCA6cPTKAXdBU=; b=F+q7EdrbfFrm85J+mqlWwl/z+J
	GU+/nU/VYTehP+TbZO2uotJ/fRpPLRB6ahQBZ9WVy33PcxjYpelE/beVRFJMfg8k
	6ynfzgrM/dLneWePaAaiMQO+zqnvuWGXMTZmckCfpNMaFy5ntc4tbWtH1ZlHKAbH
	w0PNRo+2mUQ1H5vuemA7z//xvShtHaEN6jkVXSHc0PbipWXSLWC4qBXUbvp/ZKhl
	usDdtPYOATxL9ybkQzwz+P5GagwVWIfd+MnOkcd/Ct0lCW0pPlE1r0nrtUcV+Hjg
	JF9UBKJR+20ds/ZhwbfE6cBe04HB4TDuWBFuvF1YGoJ7yePxUZKJv9HVdQBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772600848; x=1772687248; bh=2Jke/uy5Un+EFk+OEhzByukMYgfhMoyCA6c
	PTKAXdBU=; b=qE96ZBp78vwFZnX8IESObqeOF2CljewXvcbmWw8CDLWiJMaraBP
	Jw5q6QYODNKhsaGEGNYq8HxKPwICukzd670x8O57D1/FGnBIIswn4ZMTazBFBacI
	gFkGZ50JTE2nR44fQtPx2j8l/oNcyzOjppqfom/w+OX0pTPCQDGknGtY0/c3IxVR
	LcT2H95Ywd9eb2zAIEZhGMkgOzvncKAxQYpqXFhdDXu0v9M9d2WMHT7b++ynrhV6
	L5lBseq2DzmM/0dV3jnt2DTOh+fJX3fQs9RbZR0ItsNenBAcdG2RmmKNnZQNbTaU
	7YoPpFYFDmc0c+YUiLJoIruXfY3pF3qu5Lg==
X-ME-Sender: <xms:D76naR_rCggANoI2tIHCalRv1rJnDsEVgo8R_pD3A7PSjIoZQNZHcA>
    <xme:D76naZY36dU2ZcPRNgxpICnbBcixXuq8q3gkoPtWgY5b1rjz2Zsrv5dgzVFxSqEo5
    xGMIZFYvVXhCql_wfoduqqQHEExxA9TVzY8QjdnfZgw_zbv05iC1w>
X-ME-Received: <xmr:D76naY3JSDd3uPvKOS1ySRdJFvuYSpXC1BoMgCgHLpHU1lK8qZKrI6doT2g7a9OTjZOsiIlFVPpu62UHCsNBhpbUXL3aXYi7Nk9aRvZdmz7wjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedvheelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epvefhfeeftdetleeugfdtuefgtdekuefgleektdehgeeikeduudeuveeghedukeffnecu
    ffhomhgrihhnpehgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeei
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrlhgrnhessghrrghithhhfigrih
    htvgdruggvvhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthht
    oheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhg
X-ME-Proxy: <xmx:D76nacbu--bORNWaJhIaJOIQEFnqEvS7dBUT5krH_18nkSoYcNaj7A>
    <xmx:D76naYJdyOqQXXRMBOrOnVNVGYNJDT-5KJGll1SfqdwXTh2jKXEutg>
    <xmx:D76naTG7Wnp8i5tfJzm9EGm7CAf12eCwkIn7cNU4N5PnDpCgcSSdNA>
    <xmx:D76naXswBLpJNKg9WdfXRyLxAuLrkLbgK8W_sEvAkmkHHM1CteCPyA>
    <xmx:EL6naV60T2UBRh06LoucCZyk85XdgYgcJwXHo-KHLHzyc6q6Uk0ggJ0B>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 00:07:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0df63199 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Mar 2026 05:07:24 +0000 (UTC)
Date: Wed, 4 Mar 2026 06:07:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Alan Braithwaite <alan@braithwaite.dev>,
	Alan Braithwaite <gitgitgadget@gmail.com>, git@vger.kernel.org,
	christian.couder@gmail.com, me@ttaylorr.com
Subject: Re: [PATCH] fetch, clone: add fetch.blobSizeLimit config
Message-ID: <aae-CboMNIPRmKts@pks.im>
References: <pull.2058.git.1772383499900.gitgitgadget@gmail.com>
 <aaV6PLJCrpb2mQnq@pks.im>
 <xmqq342i12ky.fsf@gitster.g>
 <a3e064fe-9f0d-448f-b034-4a95dcd3fe97@app.fastmail.com>
 <aaaACBJVAZPypVtn@pks.im>
 <d4e2aa7e-6c6e-43a5-96ad-848d9447d194@app.fastmail.com>
 <aab5iICOAMrH2aQZ@pks.im>
 <xmqqtsuwdccu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqtsuwdccu.fsf@gitster.g>

On Tue, Mar 03, 2026 at 09:58:09AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > I think using something like "clone.<url>.defaultObjectFilter" would be
> > a more sensible design. The idea is that we'd only honor this filter on
> > the initial clone to basically be equivalent to `git clone --filter=`. I
> > don't think any subsequent fetches should be impacted at all, as turning
> > a full clone into a partial clone would need more consideration.
> 
> Yup, I like this one.  Should <url> be giving a repository fully, or
> be some pattern that groups similar repositories together?  You
> would not be wanting to clone exactly the same repository so many
> times for a configuration variable to matter in general.

I'd propose that it should work the same as our "http.<url>.*" config:

  - You can enable partial clones for a complete domain, like for
    example "github.com" or "gitlab.com".

  - You can specify a namespace, like "gitlab.com/example", so that all
    projects in there would be using the filter.

  - You can specify a project, like "gitlab.com/example/project.git".

I'd say that this should be sufficient for most usecases.

Patrick
