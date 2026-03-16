Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB510269B1C
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 06:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773643291; cv=none; b=l/c99ltNmg6Q/97yfDoFeLsp4c26mKGFrDq12FTdAMne0jqi+LGWQG1o3VyqYyvjlt3kcWoH8TjVLp2slQ1rQfrywDmtaHzrxljFz8PQNlEM4yt+Is39g5x8gaSttR9agykbstvVoJgM63Pafdjud4azuxmhIt/HbwOcOtjbmwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773643291; c=relaxed/simple;
	bh=f15Kk3Ns29/BxZdFkA3hWhXFPxLlAKX/IKj7yo9/gx0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhGol5k5y7C5OhcbNcMe/D/ij6SLUSmF0o047NBCz2c1s15OPsI8nFwXdWorD7snwipQOcOXbVAD9FURJK3IkxSEOtUCd4OqGYGvOVOXBaU/iWK2Wen1bIzDJG3/aLk4ERS7bilt+xRsiL9xQPtXbs5afDTo9hykkziNqn7K+cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Di/bRA1n; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=so+FPVE1; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Di/bRA1n";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="so+FPVE1"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id ECE9FEC056A;
	Mon, 16 Mar 2026 02:41:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 16 Mar 2026 02:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773643288; x=1773729688; bh=ZifquYCKPN
	9QGVQWvcJQ0gHk07VPhwbAGU5PgMdJbow=; b=Di/bRA1nduaordNJt/meqCEs53
	rMHzJXKX4LxmO13YuTkD6613R7gib4K92iy5CX/30hu5t94QiS2pmdkf/rKa/XCc
	e1T+9gJnJSLV7iQiK5ykPFub0QhihLy3xKfRJfd96dTvukF42Iy4oOyCJBS+Z96S
	dlbzcRM4aE2T4x2keW8qPFXuYzGxZoSRjzu+naTpiIcuo6slqrF9AlZmdiHLnGNy
	Dkwr1bSJlLyATaNpX0qD2RCBlSkAz3SNB4cmlu+VbZIoMkT5I3bgnpp/lbdQgTJy
	OVg0diGpiMLudLj3Jm1bzYbOr32u5yGoA3/UApb2I1QZkdD3WIIvkHfQVapg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773643288; x=1773729688; bh=ZifquYCKPN9QGVQWvcJQ0gHk07VPhwbAGU5
	PgMdJbow=; b=so+FPVE1q2rTrEP/6dptIkbARcIQH0WXEryPSXrwRUvX8cPKZgU
	uo83fX7IJG7vQkSJXMAAUD/guZIgSZ0VPcnJ/VgDUpsfge1JJnJlplTOEUADi+5F
	sVXNix5G+uTGmklVF5PAGId78X51Vb/2yTYM7+HVrqXGTs3J/p6M07FgOoXi2aYC
	cGuxmGSuPir+Y29YUQqEhOqIyyi0RWY1gXMldy1euTxQvReVrwXVt1kQpgI2oR8R
	DkXVUMkAZDpmvMoSduvyVG+O+/qfGna9SK2exf8KQ/0OD9ckcplVqQcbX/XEw+S3
	jF7cdl1IapwjCZemdWNEgS1lJPiv3j4kD9A==
X-ME-Sender: <xms:GKa3aYShlw6JZArJmutceQh3DYF9tFLW90FzovEFksVVFIi2cigLAw>
    <xme:GKa3adNULoE2M1XBAxlTugwyN1r8fIQp139AilvZBSBSX7SqLqdkmE1cwram4OBts
    ZtIJx2I--TVwQMajmJtzUYxHgA6d-tpJyt-q5KwZ-GhP2Kivl7V>
X-ME-Received: <xmr:GKa3aTO48QH46O__FVBqBLQKxgJtM0Bb6XCVXre13VQjUe3uRtowRwiUQxzZs6HfxpvSJYHgEyrqsAFUaMICKtA98B27cAx6DaY8OvJQlwU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleejieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    efveefudejvdfhudehkeeiieejgeffvdetuedvvdekvedvjefhleekhfffieegvdenucff
    ohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepshgrmhhuvghlrdhthhhisggruhhlthesvghnshdqlhihohhnrdhorhhg
X-ME-Proxy: <xmx:GKa3aVvDN_HLDDMtxJuIkDlXG79uMRtuYcLgGRSI552cvzq8VqR1eA>
    <xmx:GKa3aVVrhzpRvOnFZZwJrJHIqN5xggy-CnlDf3GPHR8m8vv8TiMVmg>
    <xmx:GKa3aVuSBEn296sfvwhcIqbcyT4BSV3GGrjOrojeD2CTk120JyAjxA>
    <xmx:GKa3aZUcJ3Y9vWGEJxPdV6E5uET26bXw_9KL9V5UvkZpezAqZpivUA>
    <xmx:GKa3aXYvdHYwgf4WEK04tlsMo_HN9G2_yTKS3PTk7xgqwNwKiYCjU9zS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Mar 2026 02:41:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 00aaff73 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Mar 2026 06:41:26 +0000 (UTC)
Date: Mon, 16 Mar 2026 07:41:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] Fix GNU/Hurd build
Message-ID: <abemE08uzRwB-xwp@pks.im>
References: <20260312191901.174808-1-samuel.thibault@ens-lyon.org>
 <xmqqbjgsdbr6.fsf@gitster.g>
 <abOxLFNGgZjo1dyi@pks.im>
 <abRIXE2es5A-4VLv@end>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abRIXE2es5A-4VLv@end>

On Fri, Mar 13, 2026 at 06:24:44PM +0100, Samuel Thibault wrote:
> Patrick Steinhardt, le ven. 13 mars 2026 07:39:40 +0100, a ecrit:
> > On Thu, Mar 12, 2026 at 01:38:21PM -0700, Junio C Hamano wrote:
> > > Samuel Thibault <samuel.thibault@ens-lyon.org> writes:
> > > 
> > > > GNU/Hurd does not have a PATH_MAX limitation
> > > 
> > > Thanks.  clar folks might prefer to take it upstream and have us as
> > > a downstream to import from them, so I'll forward it first before
> > > taking it for ourselves.
> > > 
> > > It makes me wonder if an organization like this is easier to follow,
> > > i.e., platform specific settings first and then catch-all default at
> > > the end:
> > > 
> > > 	#if defined(CLAR_LONGPATHS)
> > > 	#define CLAR_MAX_PATH 4096
> > > 	#elif defined(PATH_MAX)
> > > 	#define CLAR_MAX_PATH PATH_MAX
> > > 	#elif deifned(MAX_PATH)
> > > 	#define CLAR_MAX_PATH MAX_PATH
> > > 	#fi
> > > 
> > > 	#if !defined(CLAR_MAX_PATH)
> > > 	#define CLAR_MAX_PATH 4096
> > > 	#fi
> > > 
> > > but that is a separate issue best handled by the clar folks.
> > 
> > Agreed, something like this would read better indeed.
> 
> Ah, actually Pino already contributed a fix in december:)

Oh, you're right! I'll send an update to the latest clar version later
today.

> > Samuel, do you
> > want to maybe create a pull request in [1] to fix this in clar itself?
> 
> > [1]: https://github.com/clar-test/clar
> 
> It would be useful to put this github url in the README, I have
> submitted
> https://github.com/clar-test/clar/pull/135
> so it'll eventually end up in the git source for people to find out
> where to send clar patches.

Makes sense, thanks.

Patrick
