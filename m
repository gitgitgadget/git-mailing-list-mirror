Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AF0215F73
	for <git@vger.kernel.org>; Fri, 20 Dec 2024 15:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707986; cv=none; b=lUVVYO4sQKGf36s/gVZHYDnDj9wwZGUdAyj/t4Qt6+SuCWp/U0rN2DcGUOvdfOxiPYiPdxlFtHikMyMQLwCZxQYNNEA/4himRH6sK73RU3pl0fS5CRjeC75tIeUGHQJUtyxiACdzADiwybtd5S6eSqDbkMKqETJbIGUAr9dEKdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707986; c=relaxed/simple;
	bh=T92kCfjVQRlsDQzIJac4Rcftn4wMeyGj3CX/Sf4s/Ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SFNZB/QzqkV4Rej3LOy+nuumUiseLgQKj/FOKzNn24UnC0JOdhq0ijpKZMJbqiP056lKmfBbOnwVXVFr0XJMwQwxpMTcJqdAboeM59eCiXktz///m/se1PghYxQ4hvFLbUOlFgGfeAGW+nLlozi7srSzZ/p2KywhkZV+GetJCA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gedFc+q2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=krD1Jtk8; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gedFc+q2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="krD1Jtk8"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id F150113801FF;
	Fri, 20 Dec 2024 10:19:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 20 Dec 2024 10:19:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734707982; x=1734794382; bh=DeMq2pQwfJ
	5DY4zhBrvtLBPweNB2VgzmwgM/UiCkD6U=; b=gedFc+q2fXJNMEJ58Q1urVP6mY
	iT28RLHD58sNXF+zNwcmk7FjKLqbk7iKYuUI4+kxXGHJBWUyKhhec/rgQMLmmHy7
	qMy7eJzbdrU9BymX/T0ijGJLqwfzCRxUD8CkODInYpyhDoyAvCwEjsXWx+6bJ08R
	GhZaujgWJtb7rBu8EZ2oWDtiYG63YbW8LxqMdpfC+6Np8/2PfMKZL9Y4G4HMlo/o
	k74D1mmzbQejSBsmhjG5qlBavaPANCHwDOJownLFxWT6BQA2GsJ+XvpW54eJWfHs
	DNhlEAL0iDOJsPAlaxKldXTbzlgTXCEUTBkPCQ/p4e+rP4hAGWN0W6Z0g6Xg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734707982; x=1734794382; bh=DeMq2pQwfJ5DY4zhBrvtLBPweNB2VgzmwgM
	/UiCkD6U=; b=krD1Jtk8JS9GqKfuKHHrSS7K3OVwYBg/L/uIDNdndwRLxGhy7K9
	oFtXumLmM/0SjhqRZFc1zu6eJbtMCdW/5HvIZE3Z1kzex5mGgtiOd/FgrzwjZCtS
	SRBvY8h+pmA8N5wXqK/gIYfrNfectFdGUYOQKXRnEM6aLK9eZkAXz4s2zFND8oCd
	Ft0Qes3SI+GBhbgT2sGw6h+sbHFlk12/iIdSKwW2zAtBU/3ioRo5+FYvcqpr0+bR
	mr7Sehy2rR3xxjIrY/VtOUFny/ys8g+XnD68hTZqGQcNuD+nn8Ye80tGf5rJA5zC
	XdFdfB1tWf6TdwUGs7tDQXmAg7iD8fXal9w==
X-ME-Sender: <xms:DotlZ0xw-WPDDuYn3jmFmdW6UoaBqm-fg-g2j6eZEfR8TKjMGawP_g>
    <xme:DotlZ4Q0H2JclA7RuTP9mlcjWcbze_n2cBbi_bgFiPX0jllFH1xLIgZQnIZbR7c3z
    ihLJXEfUdH5JtIunQ>
X-ME-Received: <xmr:DotlZ2VMiKkMLZ3RX45uKWmzEZfxbfldyJsC154ILhpX5tyr3Pf1VT0VuisNwDwAk65sU9T5CAU6NnGSc_Vn8upIfX4j_eg8HiVXJCobS250gRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegurghnihgvlhdrvghnghgsvghrghdrlhhishhtshesphih
    rhgvthdrnhgvth
X-ME-Proxy: <xmx:DotlZyixquslTml0lk7vc8_ps-g-OSseFlhOJWV--kroFE9Y3JLxjw>
    <xmx:DotlZ2Ai--_TYirtz-05x2RiH4cVLVMps5QnfdMw2z2whIVyi1c9ZA>
    <xmx:DotlZzJ_NkAFzp9C7kxDvIznSfls_vr1smEEtMFnGdS2ezQz8oSZMw>
    <xmx:DotlZ9ClMF60LsR9OxaBmY1Q9aiqmAuzNAAJ19EQi8at4KUoDJSnRA>
    <xmx:DotlZxPZ6HVhsnuFdL9mhJN3mjD6zewgTf1n7WX9pjqjgpy-d5W0Hzze>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:19:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2072a917 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 20 Dec 2024 15:17:46 +0000 (UTC)
Date: Fri, 20 Dec 2024 16:18:01 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Daniel Engberg <daniel.engberg.lists@pyret.net>
Subject: Re: [PATCH] meson: skip gitweb build when Perl is disabled
Message-ID: <Z2WKnAh2BVWr063E@pks.im>
References: <20241220-b4-pks-meson-fix-gitweb-wo-perl-v1-1-41039ad8d8d4@pks.im>
 <xmqq4j2ygzwk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq4j2ygzwk.fsf@gitster.g>

On Fri, Dec 20, 2024 at 07:03:23AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > -if get_option('tests')
> > +if get_option('tests') or get_option('gitweb').enabled()
> >    perl_required = true
> >  endif
> 
> OK, so we use "perl_required" to keep track of the fact that
> something else wants Perl to be usable.
> 
> > +# Gitweb requires Perl, so we disable the auto-feature if Perl was not found.
> > +# We make sure further up that Perl is required in case the gitweb option is
> > +# enabled.
> > +gitweb_option = get_option('gitweb').disable_auto_if(not perl.found())
> 
> Hopefully before we reach this point, we would have figured out if
> perl is avialable, to allow us do this.

Yup.

> There seem to be too many "perl" related variables, interaction
> among which smells way too complex for their worth.  For example,
> 
>     perl = find_program('perl', ..., required: perl_required);
>     perl_features_enabled = perl.found() and get_option('perl').allowed()
> 
> and only when the latter is true, we'd do further configuration to
> make perl usable.  Does that mean the condition you wrote above to
> automatically disable gitweb somewhat incorrect?  Even if we may
> have found perl, the builder may deliberately have disallowed use of
> it, in which case we just know perl is there without figuring out
> what other things (like where the localedir is) that are needed to
> use it correctly.

I don't think it's incorrect. The Perl features are those that the Git
distribution itself uses, including all the Perl modules in "perl/". The
gitweb subsystem, as far as I can see, uses none of those functions and
thus the data we configure in case `perl_features_enabled` is true is
irrelevant for gitweb.

Now I don't disagree with your statement that there are too many
Perl-related variables, but it simply reflects the fact that Git uses it
for multiple different things: testing, git-instaweb, the Perl library,
several Perl-based commands and gitweb. And I think it's not entirely
unreasonable to let users configure these independently of one another,
and that brings some complexity with it.

That being said I'd also be okay to not introduce the separate "gitweb"
option and instead just use the existing "perl" option for it. I don't
mind it all that much.

> > +option('gitweb', type: 'feature', value: 'auto',
> > +  description: 'Build Git web interface. Required Perl.')
> 
> I do not know the convention in the meson world, but to me, this
> would sound more natural with "Required" -> "Requires".

Oh, yes, indeed. I'll wait a bit for your opinion on the above before
sending a simple typo fix for this.

Patrick
