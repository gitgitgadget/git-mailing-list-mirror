Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1791B18BBB5
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 10:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726136542; cv=none; b=SKcbnAP64tIJVNUr4b9Npwp9UKMnThBcQ94IydMS/vKdhHeejnJRAnZ0Kym+gPtonhby+bOY43vD4Kv2QtBQxLGAHvvALxAfMTTfn6rIrps4oslBbM3T78/nnwurKL19xGcKyrGOgg/N+m4UUnZveMIi2SysTIWOjcwKWAt0DJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726136542; c=relaxed/simple;
	bh=CGj4epCLgsHZuBmYccfr1uV8Fgz5bvyQPbFapjLjAuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKMeFouzgSVM7hxBfrbWo+cAzr9yxvrrsLkU9J1EG38fkI//dlEzhV+MF8ZpaoVfVsNzzTaJlxYgMTZdSPJ4282yt4tSlqFOEiESv4mhqd1f2sthv8vpOegRV4wTutsOnRA3Dn+EWF7ymv1zaHNZGNwTwnkYLwGEa9X7krmJAzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hQVgIogB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X2y9gFVQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hQVgIogB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X2y9gFVQ"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C306138032E;
	Thu, 12 Sep 2024 06:22:20 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 12 Sep 2024 06:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726136540; x=1726222940; bh=UQbu3aWEfU
	jakS7y7FktSfJrEXdcbK0+b3X2HcvaxrE=; b=hQVgIogBDvum+MwGKcaFHkB1Bv
	XUaMmCVLfR4cJjWO7CrwYQCBPWGI76oyILC+R8q6mTI71TXP47ONFz0bLTDCJVBj
	Yr6h5pItKmMQ27aAGCRIKQNnk/M2Or2yPENRVXJLk0fMpSiW43FWb37TDkmkJ+Hj
	6sPD7Q7UYKO+JhSZK0XyOlHwiHLLGBWAlVAUYnzjvJkCkqwVpCo4+8XEq/RLpQL+
	ND31p/Gdo7XWKCccPmB8aIYfYiyhvZiVBjS8qWMVpYY4AOu9OPZptU5htBmjepjv
	9WlzV+zBDP15sqyc/Y59eGbFFvLv40LLWzoi/YR7eAEl5gruZo3BXTjZm8Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726136540; x=1726222940; bh=UQbu3aWEfUjakS7y7FktSfJrEXdc
	bK0+b3X2HcvaxrE=; b=X2y9gFVQiMN8D95WdUDq6su2eFqEAwLmwmaCIudnOdj3
	0G+7ol9LFCZ+tC7IcsO2HcK5d+WzCDN5G46c9anOk1fc/c4YrBGUU6BRyjBuqkjO
	gfb1fgLTFjXQqPHA3vd+KIyNESmoZSPGzS0TUmtu2OFFJcoxkOHOXcdDSsqwyK5C
	++yybnarYmD3xmoJiOquWWNI5F+SbRvQLa10Reaoh6wbMYji2SFQv1SgaRDV5K8N
	t32ORpYOiMJgsFVql3RPrj2cfclm6hhnzqvlVlYIeovVYsBfvDZcbqpjGQJXMUb6
	HpV2eaFj1Wv13lOydzqLT/S1OfbRJAahwGjfPRH5tA==
X-ME-Sender: <xms:28DiZobGKzNmkd96C0Kr5H-GyKgklHVtuthMBnZnwLG96uVCf0g-Ww>
    <xme:28DiZjYHfp2xqTtXCdZS89jLaqpB7m004XHxeEYki4L3wczeMcOFpuqRBgLSCkgo-
    mmdLjFzxqZ2JGfmSQ>
X-ME-Received: <xmr:28DiZi_uS7qlPn8igw76PTtkwihndYuKNQzlHKHrMnDe0dkGWzu0AzRLesnKbanEWhI4vdOlxhlb93VRvSJaTLfqELGWLDSlYAKZN3LQUj3E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepieefuddvgffhkeeugfduieelgfdukeeguefgveegtdei
    gfdtfeffkeevuefhgeefnecuffhomhgrihhnpehrvghfqdhfihhlthgvrhdrtgifnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhs
    rdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epsghrohhokhgvsegrlhgthhgvmhhishhtshdrihhopdhrtghpthhtohepghhithhsthgv
    rhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:28DiZioQiiQGWgHtfeqWIg-HPiuxEP1KA0_TgmZlPlVd5G-pniiiEg>
    <xmx:28DiZjpiSih_vkZwCt2ueAMeoGUh_mRNzt6iZwT9aTDEQuyhb67tFg>
    <xmx:28DiZgSLSla9Un_RI0VEEDciE3xlhCjxdr67GsYrgtC3ptV_xHkxog>
    <xmx:28DiZjpa8Mg4VkKThCn-FucF1dEwFU-_7krdsVQlFMJLQSdv5pkPuA>
    <xmx:3MDiZiXNL-U4BFt6LFMkEpuu9tOO3SP2KGuV0viJMxGFDUi6kMxUKnGh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 06:22:18 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 26162ecc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 10:22:08 +0000 (UTC)
Date: Thu, 12 Sep 2024 12:22:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 10/9] ref-filter: fix leak with unterminated %(if) atoms
Message-ID: <ZuLA0SBqhBbBdcd1@pks.im>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <4faf815b780218769520561ecf3abca384a2ee6c.1725951400.git.ps@pks.im>
 <xmqqseu7jvz3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqseu7jvz3.fsf@gitster.g>

On Tue, Sep 10, 2024 at 09:48:32AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > When parsing `%(if)` atoms we expect a few other atoms to exist to
> > complete it, like `%(then)` and `%(end)`. Whether or not we have seen
> > these other atoms is tracked in an allocated `if_then_else` structure,
> > which gets free'd by the `if_then_else_handler()` once we have parsed
> > the complete conditional expression.
> >
> > This results in a memory leak when the `%(if)` atom is not terminated
> > correctly and thus incomplete. We never end up executing its handler and
> > thus don't end up freeing the structure.
> >
> > Plug this memory leak by introducing a new `at_end_data_free` callback
> > function. If set, we'll execute it in `pop_stack_element()` and pass it
> > the `at_end_data` variable with the intent to free its state. Wire it up
> > for the `%(if)` atom accordingly.
> 
> Sounds good.  We diagnose unclosed "%(if)", report mismatch, and
> die() soon, so plugging this may more about "let's silence leak
> checker so that it can be more effective to help us find real leaks
> that matter", not "this is leaking proportionally to the size of the
> user data, and must be plugged".
> 
> I see this code snippet (not touched by your patch):
> 
> 	if (state.stack->prev) {
> 		pop_stack_element(&state.stack);
> 		return strbuf_addf_ret(error_buf, -1, _("format: %%(end) atom missing"));
> 	}
> 
> and wonder how this handles the case where state.stack->prev->prev
> is also not NULL.  Shouldn't it be looping while .prev is not NULL?
> 
> e.g.
> 
> diff --git c/ref-filter.c w/ref-filter.c
> index b06e18a569..d2040f5047 100644
> --- c/ref-filter.c
> +++ w/ref-filter.c
> @@ -3471,7 +3471,8 @@ int format_ref_array_item(struct ref_array_item *info,
>  		}
>  	}
>  	if (state.stack->prev) {
> -		pop_stack_element(&state.stack);
> +		while (state.stack->prev)
> +			pop_stack_element(&state.stack);
>  		return strbuf_addf_ret(error_buf, -1, _("format: %%(end) atom missing"));
>  	}
>  	strbuf_addbuf(final_buf, &state.stack->output);

Hm. It certainly feels like we should do that. I couldn't construct a
test case that fails with the leak sanitizer though. If it's a leak I'm
sure I'll eventually hit it when I continue down the road headed towards
leak-free-ness.

Patrick
