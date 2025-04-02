Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756EB23718F
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743593650; cv=none; b=JXKibE81pDQbF1Ds+7nKsEAhLXi1gpREhSd4rJ8bxUH329zxigKj2/dGpUtsk9EaBLyspwQgl/0FskOGum1oZdbXdKZ9+alNBuKmfCzz5Y1RDh8FWbFFXqyUHoQuEsCGhef+YLJ6NzCa1TWgQDSJ4dErFZd5kHQDNk0IeXmx3k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743593650; c=relaxed/simple;
	bh=1uiz6NRWgXWre0q96YMV0706LNy4jzrvUhssBjQ/hIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kTNLQKuggoOYo7X5bIcTE3kFu1LKTssU8vyUpuWJkpWctfMrK3LybpFiwqqxTzWEVUjs0XO1FI/FcmAEUKgstfGzjYSKELfkiUsBk9KmwSwBBFeVxmay8JxSBubgD5rHKF4iV+W89WqHTEaix1mPv7/qOlotKZhOOYevKq8ClFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QdzZFnmk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B90eWJdw; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QdzZFnmk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B90eWJdw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7E34B2540255;
	Wed,  2 Apr 2025 07:34:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Apr 2025 07:34:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1743593647; x=1743680047; bh=uZV8FZ+bvl
	TnwhO0ndlgYmMOC1seUdRgeJQD1NHmQEA=; b=QdzZFnmkdFIVlFOzdgOIXTO1m7
	xVAcJI/RlD4YVuoHnVoP4C1bsC0z5lY5/lXCgyVZp35voqQXI2wqE6kgATRvA1gL
	v/jUG1KrhdoBgMt9uY/r3L6RNUdoEBjfoLaAdEtGPBBKvnYVvYdPOLFUQiEVnpk+
	I3DIeHo+00k+Er8lt30QGR9p1KrkI3zMLVjaJmAEfqT9uaStiFrICT79Whecsjf/
	D6Ua06azIm/hDObYVwfbH5KxRFhnbzFZfe2d9pGy8VZJpcmc4zttczdptB1NqqCp
	oMn+vE1t61iWunGTZVcLBgc4LS5IGIewACT+ONaKzvhqHdSETa3CrzsRmiHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1743593647; x=1743680047; bh=uZV8FZ+bvlTnwhO0ndlgYmMOC1seUdRgeJQ
	D1NHmQEA=; b=B90eWJdw8ANhEfWBPLJNgTD/Hqrvs2nH4WutaciuSUNt8RTIH2U
	QZt1dXuMHpUwUtiPFeKAqUiKfJsE6kvdxYcdVv8JIt2ApTZx/eFvw26/KvWvySP7
	y60O/f/JxGbPRtqTFomPZTEbgJxyZ8+EHRCzjfMpgqVsbYL18qh7QsmDRkpIddfq
	FApYGSj1cqtsC07epVZvsnSLwVjNJk65xTdR2xOqeWsqMZZFsEQW10QDj7EA6DXz
	ST8wox2J0FYvtp4C74pS27seLh+8+ppD4mExuvBqoMBIl4eT9cLrwavntcVl72cn
	gyLcJ4nZuaXCowxhPsPorycAG3ma6cDvjfA==
X-ME-Sender: <xms:riDtZ0FZH7l4ZoWeIgK_Xn0RKLncTf2vIZpeF08R9KPXCLW99-hHDQ>
    <xme:riDtZ9WCa-qsoVfHc-Xrp0g6DvMrAnFXK2VizJIxYEZE3G4NUwToPHBVFOuNWvAoS
    xLb3zwMcJkbX8T-7A>
X-ME-Received: <xmr:riDtZ-JqDrGSf3cHXYw6Qqgh55UtN9Cc36YHf3rWcofV5_mEUzh64ERDv4FJ_Z_dWW62ns6w--dcoYZalUpNGbH32Gl8FlkC3pFpdZOMG0INpg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgv
    ihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekff
    fhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpd
    hnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhishhtshdoghhithesrg
    hkshhhrgihrdhishdprhgtphhtthhopehtmhiisehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:riDtZ2H6ZSAGFAJKPaKzbQqvCOk3aVUuhC4be9Lx_ySLGYC1tMRfNA>
    <xmx:riDtZ6WFDpbCNBxz9bIPj1ua9qRBm95V-N5QRW5-Co6nbMBijIwI1g>
    <xmx:riDtZ5PBQ7usIJpfdBAoJfqctNNVJY8o_AZeuR9FusGj8KWQuroqXw>
    <xmx:riDtZx0P5fujHAyBQQqj6k0NSRtc4cRyjBXSJRAbvhFe1mNEe2AXug>
    <xmx:ryDtZ8qODUul1MHf30wqz-sleFCH0GAxsDGUAOT7gnSR8bQViRX8I-HH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:34:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aacd414d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:34:04 +0000 (UTC)
Date: Wed, 2 Apr 2025 13:33:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Todd Zullinger <tmz@pobox.com>
Cc: Akshay Hegde <lists+git@akshay.is>, git@vger.kernel.org
Subject: Re: meson: Installing completions
Message-ID: <Z-0gpxXBmt8G72Z9@pks.im>
References: <Z-uLqQd7QHZq-tB7@akshay.is>
 <Z-u42Sm613hMj1Ft@pks.im>
 <Z-wltqWraESmb-Lm@akshay.is>
 <Z-yLvgkJnGm0CkG3@teonanacatl.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-yLvgkJnGm0CkG3@teonanacatl.net>

On Tue, Apr 01, 2025 at 08:58:38PM -0400, Todd Zullinger wrote:
> Akshay Hegde wrote:
> > On 2025-04-01 11:58 +0200, Patrick Steinhardt wrote:
> >>The biggest question though is whether distros are aligned enough for us
> >>to provide standard installation paths. That is, do all distros end up
> >>installing bash completion into "/usr/share/bash-completion"? What are
> >>the desired directories for tcsh and zsh completion?
> >>
> >>If there is enough standardization then yes, I totally think we should
> >>start installing completion scripts automatically.
> > 
> > Well I can't speak from any sort of authoritativeness here, but for zsh,
> > they are usually installed underneath the datadir (usually /usr/share),
> > then under zsh/site-functions. Of course, I don't know if that's true
> > for all distros.
> > 
> > Could we extend meson_options to allow specification of bash/tcsh/zsh
> > completion directories? If they are not empty, I think it would be
> > reasonable to have meson install it automatically.
> 
> Having the ability to specify the install path seems like
> the way to go, even if the default is used by most systems.
> For Fedora, only the bash and tcsh completions are
> installed.  The latter is simply placed in:
> 
>     /usr/share/git-core/contrib/completion/git-completion.tcsh
> 
> and users need to make some adjustments to their startup
> scripts to use it, as documented in the file.  This was
> added to the Fedora packages in:
> 
>     commit dae8588
>     Author: Todd Zullinger <tmz@pobox.com>
>     Date:   Thu Jan 3 14:59:27 2013 -0500
> 
>         For now, this just gets the file from contrib installed.  If there are
>         enough tcsh users that want it to be more automated, that can come
>         later.  For now, the directions in the file must be followed to enable
>         tcsh completion.
> 
> In the years I maintained git in Fedora, no one asked for
> any changes for tcsh.  Apparently, either no one uses that
> or they don't mind the manual work to configure it. :)

One of the questions is whether we gain a lot by making this an option.
If packagers have to manually adapt the location they could just as well
copy the file by hand as there is no build step involved in the first
place. I also think that for Bash and zsh the locations are somewhat
stable across distros these days, so ideally we could just build on that
and not even provide an option in the first place?

I'm mostly trying to avoid to eventually end up with tons of build
options. Ideally, we should just do the right thing and install the
completion scripts into the correct location in the specified prefix.

At least if we can get away with it. It seems like the default location
would work alright for you on Fedora, and I assume that it would work
alright for most of the other distros. So I'd refrain from introducing
an option now, but if we eventually figure out that this is problematic
on some distro then we can still introduce the option at a later point
in time.

> IIRC, there are git completions installed by upstream zsh
> and installing git-completion.zsh site-wide is not generally
> agreed that everyone wants?  I'm not a zsh user, but I think
> that's why I never installed it in the Fedora git packaging.
> (It does seem like an oversight that they aren't at least
> installed similarly to the tcsh completion.)
> 
> For reference, here are the locations for bash, fish, and
> zsh which Fedora uses.  This might be helpful in determining
> reasonable defaults (after comparing to other distributions,
> of course):
> 
>     bash /usr/share/bash-completion/completions
>     fish /usr/share/fish/vendor_completions.d
>     zsh  /usr/share/zsh/site-functions

We don't have completions for the Fish shell, right? Just making sure
that I don't miss the obvious.

Patrick
