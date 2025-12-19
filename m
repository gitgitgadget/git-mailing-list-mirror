Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDCF32E751
	for <git@vger.kernel.org>; Fri, 19 Dec 2025 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766145094; cv=none; b=qjOoc4rBorabFU7YoG/h8QhTxcsA4rMdqkBdLzCXQOwTSqpRD4JGXN+V9s7OtwE7RLlqis7twE2PxxUuNN1TDj4ay7FRmKFE6ftiv/98nS+qzQKKf4SWO6PJ0CjFnp5bruXbbPNw+jvl/9kPqUvcu8Sqg+C5Pl8MQe/Nt4saL+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766145094; c=relaxed/simple;
	bh=D3okEbnkNIog41YsGWcch6W4Xr9l3Sae/evA/LH7vxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxZlZMXFLhcYwPRcAVqxrp2kG6PR8hMYM9wWkkA9cPK1dIa3GYibRs60NSNWmsQo7ng1N/+WsOWx2WYE1NzthH5a2JR6nsGjaLS/+Og3AGKBflG3jB3f4loitBaNm4ro04n/KVJFnvtHGtpFxBUZsQ41tjP1KVn+kd60J4U/1mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uWSiJB7C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mc4ok6RT; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uWSiJB7C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mc4ok6RT"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 945EC7A0120;
	Fri, 19 Dec 2025 06:51:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 19 Dec 2025 06:51:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1766145090; x=1766231490; bh=513UXa0Hbc
	siAVlaB/23CqQPMZVPxPuI4zvVrwIKkLI=; b=uWSiJB7CoLvAcc4usCF3Nvu/d+
	k6zRn5GHPfrqYR10963QUMoSzershRK5K5Omhepn+Io9L0OPHeRJpIFqdXPZlxwo
	Txn4qu29mCYoJQR2DrmYmvKAcmAPVUNrLCzfsxfpHGd8aW0Ms1eV/+fcG0S2q/dH
	NgPaHlYShvHooGOQjG/xkAN/hG21XBp95twShbdUs4wUoEwrSEt2HYzERp6aKJIZ
	c9IUaXECzLAEUBvuO0AOhnM0BVfKBdlz/7RI6TYfn8qTynzudMgcAqYXk3dilVHL
	iemV/An3UO2BZKk9i9j9QnIaYBAKIPTSTjr3s6PtqMgp/vfdqYMJqeGBu/nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766145090; x=1766231490; bh=513UXa0HbcsiAVlaB/23CqQPMZVPxPuI4zv
	VrwIKkLI=; b=mc4ok6RT2uah7XcC30PC+1ukrJ1h0k+CXD06yEZseMnztkRtaYR
	BG98kqu/hh8a7GJLAZ/Ae7Az5J6e4cc9R0kIXAYkqTC3bSMKN79bG4K72OfLvbNY
	lLGThph+2KWNGyZHOsyjW144+OTGDzU53UDzwD1Z/zZnaRgad5KNCA38Yn96VLaF
	n8ATKdRvqwtxhO1i1A89nbHF0nOb+g1fkuNv14LIYmmoymPzTpRCatgjzACDqBGh
	5O7hl6ybjq0MGasUtOV5GRfjSkcoIiW+x5uNgiquZsWTq9rFGDN5iS3NFmEKNe0I
	r09QAIHHiwiA3yXPk5+6MERhqbO6KGcxxVg==
X-ME-Sender: <xms:QjxFad7RiQeT1pEy9D4mNCJNChAMrftaAB9tA1Wh91cr_NHoonkspw>
    <xme:QjxFaR6QEmjujattRU7nxVXW8sj92L1ravFtGjb4Hyn_q-JGEUwc9tHX-c7owfe-L
    ztg6RvzGVC9BuX_7akGK1NnSGztzDGW7Z4Np48byEEPV-S7ZhuCRGA>
X-ME-Received: <xmr:QjxFaZde9ErT_EVbjn6aIxkViOLq0KdH_ozFOxImqlhTb_EREbsCiiFJqZEyZv04iP1ePVtSqTzL4VKEt59STfvkrBBJHKeErWhuvTpa27xJdA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegkedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ejheffudffueefleduleelieevvdffleduueehuedutddulefgteegffffudekgeenucff
    ohhmrghinhepmhhitghrohhsohhfthdrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvth
    esghhmrghilhdrtghomhdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghl
    ihhnsehgmhigrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepkhgrrhhsthgvnhdrsghlvggvshesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:QjxFaVD-W3WtsKuEouCMtiANB2zkh33la10RsL61BnQMmyGiqzbm0Q>
    <xmx:QjxFac9dqB2VzYHB_Mzxc1JwrkcD_RA06opLjlSveAoTFo9dDXJysQ>
    <xmx:QjxFaQI5YjD1gWwPUWldl0XFQfydy3BkVVqrvfAPj97auwfYapUlNw>
    <xmx:QjxFaVglzarH_wRjzwhq_ScHMjLjGdGXuTuzldmE8aUb6Z0RoiFoFQ>
    <xmx:QjxFaUAW3ZPM5YNNoYA1NcFCxGrnpNP-gG_oegZ23ANNs8-OCsCjfc0X>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Dec 2025 06:51:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d6256da7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 19 Dec 2025 11:51:26 +0000 (UTC)
Date: Fri, 19 Dec 2025 12:51:23 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH 4/5] strbuf_readlink(): support link targets that exceed
 PATH_MAX
Message-ID: <aUU8O6ltrNj-FmjZ@pks.im>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
 <db1feb2293d20532f9468ab63ede43d4fc620203.1765899229.git.gitgitgadget@gmail.com>
 <aULB3wCFGsbZbuSw@pks.im>
 <5778a03b-2e33-9224-e051-664c2d530fc3@gmx.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5778a03b-2e33-9224-e051-664c2d530fc3@gmx.de>

On Fri, Dec 19, 2025 at 09:50:15AM +0100, Johannes Schindelin wrote:
> Hi Patrick,
> 
> On Wed, 17 Dec 2025, Patrick Steinhardt wrote:
> 
> > On Tue, Dec 16, 2025 at 03:33:48PM +0000, Karsten Blees via GitGitGadget wrote:
> > > diff --git a/strbuf.c b/strbuf.c
> > > index 44a8f6a554..fa4e30f112 100644
> > > --- a/strbuf.c
> > > +++ b/strbuf.c
> > > @@ -566,8 +566,6 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
> > >  	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
> > >  }
> > >  
> > > -#define STRBUF_MAXLINK (2*PATH_MAX)
> > > -
> > >  int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
> > >  {
> > >  	size_t oldalloc = sb->alloc;
> > > @@ -575,7 +573,7 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
> > >  	if (hint < 32)
> > >  		hint = 32;
> > >  
> > > -	while (hint < STRBUF_MAXLINK) {
> > > +	for (;;) {
> > >  		ssize_t len;
> > >  
> > >  		strbuf_grow(sb, hint + 1);
> > 
> > This makes me wonder whether we have a better way to figure out the
> > actual size of the buffer that we ultimately need to allocate. But
> > reading through readlink(3p) doesn't indicate anything, and I'm not sure
> > whether we can always rely on lstat(3p) to return the correct size for
> > symlink contents on all platforms.
> > 
> > One thing that _is_ noted though is that calling the function with a
> > buffer size larger than SSIZE_MAX is implementation-defined. It does
> > make me a bit uneasy in that light to grow indefinitely.
> > 
> > Which makes me wonder whether Windows has a limit for the symlink
> > contents that we could enforce in theory so that we can reasonably turn
> > this into a bounded loop again?
> 
> https://learn.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation
> suggests that the maximum permissible target path should be 32,768. But
> that's not _quite_ correct, as
> `../t/../Documentation/RelNotes/../../README.md` is a perfectly valid (if
> awkward) symlink target.
> 
> Still, I would say that 32,768 would make for a fine (still insanely high,
> but not so high as to allow malicious symlinks to cause memory problems)
> limit.
> 
> Sound good?
> Johannes

Sounds good to me, thanks!

Patrick
