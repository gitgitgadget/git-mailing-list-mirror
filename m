Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65231F667A
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 06:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094234; cv=none; b=SGK5CYLdH7QxcMlorJ7cJGxT9q6+R27XgXkBj0VUwt9Qj9foUk4Hr6NHphllqufM7qLp/6AhTxUX2v8i+sDxpRvFgT9MByxJ//s/7DjORMYQMbvO3h5ibKIzuMjVQEJkSAH+WK7zG88FgssncGyHtuD4JqJH7N4Kq7p9KTocIfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094234; c=relaxed/simple;
	bh=4cx5kizZSXQbs24L096fYPqI6WVoVFoFZ5tLy92GOGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5NQWvQFK4ChA+FFEVhuEC6041WScc01TQfZgZ4zBRVh6OAiVnBqdxdiRmLMjWCi03mObQbTHC8EOtoTwZJ0+Uz03wIH101eMeohkzReex+oOrojcabQUR9rHogV58h7ZNDWKFilpXui7iTecqH7Q2ctDkHh8XU4gkjbWl5oKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hb2V8UMA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D2rcaG7d; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hb2V8UMA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D2rcaG7d"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id C3E1413801DC;
	Fri, 17 Jan 2025 01:10:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Fri, 17 Jan 2025 01:10:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1737094229; x=1737180629; bh=f7FkbgaPtS
	h5fv2Mc9GruwPGTlV/WRINtxnnxoR3FJw=; b=hb2V8UMAgpTAaE6ZcLMBipG53J
	dTkfU6bVEyJwiaryFE6EkebY5MFHDfKQxk6IcPOWDadvAjSZaBXxvf/VDCCfqNzd
	4UW1VWbbdR4ZrLY52aYEWw446PhXbiobeChpk2LPj7hRiVhNi2Yp8HkDmDlclgjc
	Ydj9VKHgAXhKtHNCy+u3J/YIZ8i1LBj7JFML9Xj4ZehSGkXdbjTqyDjPJ71M0I49
	U31fieMO1/uFSMeYq/a8HyVWAJH6iIL+zERL+UCGVhnEDKiFschpUue56vtRLWBZ
	2bCe+kdcIWg1bvitD7uWwoEkx+dUhfCXNnrr264A+mhKAVXxhS9+g9xQUvLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1737094229; x=1737180629; bh=f7FkbgaPtSh5fv2Mc9GruwPGTlV/WRINtxn
	nxoR3FJw=; b=D2rcaG7dVIi3ji64I8ZiuWLShwR/9TJDIck/pQ6LH/0P4HiuILX
	zymz8KP5pSzeXU16lLwg9U8Cmcav88Lg8uUOPwxksi9qiU852weMD5juZx0EPT8G
	uHQci7wge7rEvZN3YHE39grjtJRRvnjZjYKEagl2cg1lbBb7pMlo5tOVGzZ75yMh
	o/NhsfheJgth8pBbrC8sYoow/gitZy7eWb/0+6jT8dEIQE19ahl3yFxGIscpNdKY
	lubpYM1X2s5EOGswz+3WQ5Af95Yd8HAz47yiI8m2GsMkgsKj7rtK/A9aGEzJgpf0
	AH+GHP1UodkWezv4+VyIuWnoy3y3rHR19zA==
X-ME-Sender: <xms:VfSJZ3DzM0ZacCrjILnt5zJ2erEgp5PCJ50oPUnXucX488pX6jifPA>
    <xme:VfSJZ9hiC2TVjAjNAc1yY1-VaWyTHFKSVpFYNynbrfR2T26zlJEksR93WXOAwFzvO
    xmPUxXbfkQnCtQALw>
X-ME-Received: <xmr:VfSJZyl-Jzo7Xlg1DrFllMoyjRRTxnIs8OmzmYKuOr5GVsahaqoBzxKmxDq6uy3t476TPmPN8GeIQXLHiELZXSgFeFYYBfD4Cx2z2D8BrZqrGus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeivddgledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvve
    fukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhie
    dtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:VfSJZ5z52F4sK3XY3B3FSeVFVlGDLwfLuWKKliwRUHLXx9JbD3aukw>
    <xmx:VfSJZ8QzuPLA-UOhL756DXS5bY3M7axb0cGJ3xLNDp_IebLqG7q5OA>
    <xmx:VfSJZ8a-hgh1P-8ghvMmTH6CQ_seTPmUxqhsUWyNTDHZoKnEv_VY5w>
    <xmx:VfSJZ9Sv6rWYP5xrgF4RNtdk7DmJn9ZeQZ9Q4XYQpfgIgXBGRPxWAQ>
    <xmx:VfSJZ3d1BKZfzGUBO1aRSuuXeNnNep8C30Xb5QtBa2R_l0HeHhqD59cv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Jan 2025 01:10:28 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 84a51b99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Jan 2025 06:10:27 +0000 (UTC)
Date: Fri, 17 Jan 2025 07:10:27 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] reftable: address trivial -Wsign-compare warnings
Message-ID: <Z4n0U62eBD4UiC8n@pks.im>
References: <20250116-b4-pks-reftable-sign-compare-v1-0-bd30e2ee96e7@pks.im>
 <20250116-b4-pks-reftable-sign-compare-v1-10-bd30e2ee96e7@pks.im>
 <xmqqldvapfvy.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqldvapfvy.fsf@gitster.g>

On Thu, Jan 16, 2025 at 02:12:33PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/reftable/writer.c b/reftable/writer.c
> > index 4e6ca2e368..91d6629486 100644
> > --- a/reftable/writer.c
> > +++ b/reftable/writer.c
> > @@ -577,7 +577,7 @@ static int writer_finish_section(struct reftable_writer *w)
> >  
> >  struct common_prefix_arg {
> >  	struct reftable_buf *last;
> > -	int max;
> > +	size_t max;
> >  };
> 
> This is dubious.  write.c:update_common() uses this to keep track of
> the maximum value returned by common_prefix_size(), which returns
> an int.  writer.c:writer_dump_object_index() assigns the value
> comparable to this member to reftable_stats.object_id_len that is of
> type int.
> 
> I may be more sympathetic if we were making common_prefix_size()
> return size_t instead of "int" and dealing with all the fallouts
> from such a change, but this smells more like somebody _else_ is
> using size_t on something that is not an allocation size, and such
> mixed use is cascading down to contaminate this member, which would
> be perfectly fine with platform native "int".
> 
> Ah, OK, an earlier patch does change these other things to size_t,
> so this must change to size_t to be consistent.  Shouldn't it be
> done in the same patch, then, though?

Good point indeed. I'll move the change around, thanks!

Patrick
