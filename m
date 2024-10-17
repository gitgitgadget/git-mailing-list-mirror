Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794E612C484
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 04:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729140898; cv=none; b=cugVUfZhuZ6PgOpJnu1cG0wpqAO55lXHSkBErOQlNm7IhH5aYCPM+iD1kf/Pef5jDvz1OzWNhbcCPrwXVmLCxx8Z3Cxzr0polkdlUP7xiqOTrBaMXjUVYluqqLfvB4ZSGm8edOciaADPCWXwP+LD4Yo1CutnyGoTZyKtW1LHsmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729140898; c=relaxed/simple;
	bh=QHerf8t1XK43w86PiLnYNssvY+XkAQxjpSRAN+wvXjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5bOztDwXyO3Kgwa/yXYqMwWmoAL4K+GuAWSHYueyu2CLiVAwBVtT7Thrz2KOZb2m74moYwblVtUxf50AsEyEpEj+IXw+ePkUvncqaBDSIU1U1OrmvYqOKNeShsdm3iqtB4BJFQI9ZK7b6S4WnG7W+LF7O6UvA0dUA1B2I3X0fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=rjZuJeuU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dBbHdwq3; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="rjZuJeuU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dBbHdwq3"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 817EF13802AD;
	Thu, 17 Oct 2024 00:54:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 17 Oct 2024 00:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729140894;
	 x=1729227294; bh=7k1wFkBIULwuaULCi9GuN/fSiY/kMzvIAH16kUlZd3E=; b=
	rjZuJeuUZ2qTsa2XJ1rXJppqE1jIHgV3OYcM+sZGPkSg94o9ZBk2xTG/rQ9jhe6f
	8TROFXqOPSUzWQn3nzi2qjWScmpUwf80AkkSmrUloMIR6ukmFXvIdMxkvNkV95ce
	OgyP72cHinyZ/1TbkVFYJwE0stWOR1sYxqWlZ52RXrHpLS+fE2eObgBwCUlKbbtB
	2EJK3FFih1/VRL7lIIxjUAbjBMbunN/z5YNckekTyKmm/rFLciB+QYWqGAJh+JlQ
	mlBUZ2bbkqo9yleruvzx1YaF3LoJOevVknkTi21ze7VaChbmBVZupq5lV6bTHk4L
	QSP++O/9Dg7OX/4h7e8D8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1729140894; x=
	1729227294; bh=7k1wFkBIULwuaULCi9GuN/fSiY/kMzvIAH16kUlZd3E=; b=d
	BbHdwq35Lv8Mxo2h5IAglGUWH9TJQlrEpsR2fcAjn3mIk50KR8tP90tWLblppu3u
	CxFxYEqPehUMiQr3CXrfqvkIAZPWeYxkVpqONfDNud31dwuRXl9l3LHYUGz2NR67
	byDnDqggIh2b3RH76i7SFnEJWYdcFNfX2m87GDUchMAVXEwUvNx1880PgFJ2pKvs
	D9gByyEi2t3XTXWz5Sj8f+O/mqX3cV2y7zOrSod9QOdOqItBIgYEywuejKeGHvtN
	CslseqJ26AYWg8GEUI41AD3rrV2BBgFhPy1rA0Y+GyJEhISWJwsqIh8bteJo4oYk
	e/BB5lmcMv3el1bUN1QNw==
X-ME-Sender: <xms:npgQZy5h_Jz08VmexTu1r0y4hRPELPNkekvJ03-un1zUELDpQeoGvA>
    <xme:npgQZ77QIlkgIKLlNYAkdNWPbAaFdJPfNHVTOidL-ONiWnXLxf-9dukOES2AGpQ7c
    PNlrDz6C_N-t8gGBQ>
X-ME-Received: <xmr:npgQZxft5WUqS1o6nyue0WR-Qy3pTna4d09K_1On2F8nZROKYZgcelfE2OQIuFrxH5hrznEJpGqLzQq5hn5lMmEJqhrk4B_bcLps4Y7RcK8AEw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehtddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpedvfeejiedtteelheeiteekveeftdefvdehkedvveet
    ffdvveevjeejleegtedvgfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmsh
    honhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudek
    keesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:npgQZ_IIAL6vjiekDHmjFH7znhxppMX77pbwZHYNPzkbj0a1CA13pw>
    <xmx:npgQZ2L_aEXroX43isWNintgy3_py9mr5LDVuhbtlkoJ_DVhKgjC4A>
    <xmx:npgQZwxlZc6CwV1hlqyqtE0cwXI1KOpkx-uC-i_nAhyvLz9_jPT4EQ>
    <xmx:npgQZ6Jfovt-_XyPxW65bIbajL-NoVPZT3yoBtWqHDOBsbmp-oeQHg>
    <xmx:npgQZ4jHzUNnrkpfrzKBIzKHwIpwbCzwPgzg1dTUx3zE3zjEVf-taera>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Oct 2024 00:54:53 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4a6d46a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 17 Oct 2024 04:53:34 +0000 (UTC)
Date: Thu, 17 Oct 2024 06:54:51 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org,
	Edward Thomson <ethomson@edwardthomson.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 03/10] reftable/basics: provide new `reftable_buf`
 interface
Message-ID: <ZxCYk99oZLUaCkrd@pks.im>
References: <cover.1728629612.git.ps@pks.im>
 <cover.1728910726.git.ps@pks.im>
 <0ddc8c0c896a006e4cc094390125efcec0b3cdff.1728910727.git.ps@pks.im>
 <Zw2cjxpDf6MowCP+@nand.local>
 <Zw3xhwLFlznU_JvK@pks.im>
 <CAPig+cSXJaETg4Sq3Zw8=37M15CdLEUkdMb2U2X4NPSOAFwmyw@mail.gmail.com>
 <Zw7CIRoXrLr5pd5A@nand.local>
 <Zw98hKZc1pjBGGcU@pks.im>
 <ZxAolGGcndQzApPJ@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxAolGGcndQzApPJ@nand.local>

On Wed, Oct 16, 2024 at 04:56:52PM -0400, Taylor Blau wrote:
> On Wed, Oct 16, 2024 at 10:42:44AM +0200, Patrick Steinhardt wrote:
> > On Tue, Oct 15, 2024 at 03:27:29PM -0400, Taylor Blau wrote:
> > > On Tue, Oct 15, 2024 at 01:10:59AM -0400, Eric Sunshine wrote:
> > > > On Tue, Oct 15, 2024 at 12:38 AM Patrick Steinhardt <ps@pks.im> wrote:
> > > > > On Mon, Oct 14, 2024 at 06:34:55PM -0400, Taylor Blau wrote:
> > > > > > On Mon, Oct 14, 2024 at 03:02:24PM +0200, Patrick Steinhardt wrote:
> > > > > > > +/*
> > > > > > > + * Add the given bytes to the buffer. Returns 0 on success,
> > > > > > > + * REFTABLE_OUT_OF_MEMORY_ERROR on allocation failure.
> > > > > > > + */
> > > > > > > +int reftable_buf_add(struct reftable_buf *buf, const void *data, size_t len);
> > > > > >
> > > > > > Is there a reason that data is a void-pointer here and not a const char
> > > > > > *?
> > > > >
> > > > > Only that it emulates `strbuf_add()`, which also uses a void pointer.
> > > >
> > > > The reason for that is because strbuf is a generic byte-array which
> > > > may contain embedded NULs, and the `const void *` plus `len`
> > > > emphasizes this property, whereas `const char *` would imply a
> > > > C-string with no embedded NULs.
> > >
> > > Thanks, that was the explanation I was missing. Perhaps it is worth
> > > re-stating in the commit message here to avoid confusing readers like I
> > > was when I first read Patrick's patch ;-).
> >
> > Does it make sense to explicitly state how the interfaces look like
> > though? I don't do that for the other functions either, and for most of
> > the part I just reuse the exact same function arguments as we had with
> > the strbuf interface.
> 
> I don't feel very strongly about it, but I had suggested it because my
> initial read of this patch confused me, and I had wondered if others may
> be similarly confused.
> 
> For what it's worth, I was thinking something on the order of the
> following added to the patch message:
> 
>     Note that the reftable_buf_add() function intentionally takes a "const
>     void *" instead of a "const char *" (as does its strbuf counterpart,
>     strbuf_add()) to emphasize that the buffer may contain NUL characters.
> 
> But, as I said, I don't feel very strongly about it.

You know: let me amend the function documentation itself. That feels way
less out of place compared to putting this info into the commit message
and has the benefit that a future reader of the code will know why we
have types without digging into the commit history.

Patrick
