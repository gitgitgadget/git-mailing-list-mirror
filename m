Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673D71E1027
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500304; cv=none; b=ktcuw0/NiQm8HQ1QxFT7WIKuVjbjKk3NsZbXq0ZZ/NQNtMb/0djQmseaJhnkbmifLU5YhLJ/OU0lhrFbyOyYt+aQPz2ygrLc+jTcQBr7VUuKzyDi9s9jsF0zPaHdAs/uOWVDVZhP96rCUAPaB8vDyKmSHeytbCobRLlLabeX2dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500304; c=relaxed/simple;
	bh=mO+RTnNhE+wGK3kVPNt3MK8JuO/LP723UaUsLHAb3z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLjHvsE8dyJ1bi8XWbyPq7TfLz/WFox4wcR9O5i7eZeaBT1C3LxQPsY7Rjqe6GGeAOMHYg0CEm8rRKSrle95jnLnUpdJMMWSeJsFo6cUmZ74nl8JrhBPOe1hcSnKJJnOug6/NPFRMsZeg81o+7RPzMzEBW8Z5D0+8iP6m4ZUuPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JxU1hV5d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eO7quV44; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JxU1hV5d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eO7quV44"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 527441380198;
	Mon, 21 Oct 2024 04:45:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 04:45:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729500301; x=1729586701; bh=5XR6Da9I5M
	+iDVOB8+uLcmVHR6NiUDluDufzLaecXoA=; b=JxU1hV5dgxtjHYfjhgA1zSrGAc
	ReTiXfRGiYHo4c+otPHyzr4FKbMG2R/cl/CQQnS3p0Is3dqLUCH6o3D4cSUROZtn
	NwpfeWLW/YXsp7pYHrWGRCcrqACGYc1QzWCEXwL1ceUDOqd/8JZ9YYSfHsa+ZY8A
	hpEiDJDg+LmIQp66A4I7AsrhbOs4mYaBo/8bYsd2w7O14Q9KJ6kMGN1iwx12qnOl
	p1JfplXfNQbjA8pAClEkdYj/DtJwBzhjhI4XEtFQ2eNn4j3zlRoPjwbLjKSMTVmy
	PWlVC1CIU4vrzrY5ZiVf6BhVadhQ6PoQjTszwkP6nTgrITpkS6vkwMtBzfVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729500301; x=1729586701; bh=5XR6Da9I5M+iDVOB8+uLcmVHR6Ni
	UDluDufzLaecXoA=; b=eO7quV44Sl+W7C9HrB2+6pFEQZpSjn9CD2B6vOgoT+t3
	0fwwerITXzGIaQ7i/LiIKv3ZrbZ2Jl4UGcpCsZ8yw/ISS70aj5lwTx07PjvU1zr8
	flfKOKHsK4igJS8UwlIXDl73PiYXxtdWwWTGEgyPxYHav99S8KRZ0jpqffC/iOWZ
	cxUODj1ojTyeH5CScgfJ6l0wGK3BAxyVbmQbHAQFSTUGzd2buPeCyRDN95sCqfiS
	DJXYVlIWraVbA5ABOedpzpUYFt91VlDXfhlX+G86wHhPGHD3XxBELa2kODrDDnCL
	qq/mjtcyAFwGqgIGE9b4xxDtW0LSWuSLbx9V2YiynQ==
X-ME-Sender: <xms:jRQWZwz5yw5303cu54-_tI1szK_bM2HGmg9zTRExzbKq1MldoDhflQ>
    <xme:jRQWZ0Tun9XaEeYD0Zh-kkdF5Bnmy6Gh1Ny29hxb6niwDRT8QPaAbNA6cba5eMGHZ
    RfTvSDJ7P_aO-gxJw>
X-ME-Received: <xmr:jRQWZyXjOTvVtRpz0mQ0eUnFr3inB8b1xfuceyw4NMV5UQ27wvPH7oAe5rGhCAFfRrdueGSzBLmTDBtpUpNNHgjuxhmLBG_iHHk-ReY09bVG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgtdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehtohhonhesihhothgtlhdrtghomh
X-ME-Proxy: <xmx:jRQWZ-hguPpM2gIq5RGqXizNyvkX_5Q9af6YSAYctNhHv0fvD7RJcQ>
    <xmx:jRQWZyB3tSl5SfrZV-GY9aZ9AZUhpWg4FBvVj-lF7mnFtJPFBW59wA>
    <xmx:jRQWZ_IUsd35g2bienX3FOd8-0i6VALG9oKV29pbXdRR4dkgpsXYAw>
    <xmx:jRQWZ5Do7BqOhX2E8YniP6HfrGgBoQHEjzEC8tWAwt_iByloF0HUQw>
    <xmx:jRQWZ1NIzOk1jFM1YrJFbP45XXf3TgfO-v3x7Kf33DbzejS1Bebicu9r>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 04:45:00 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7021a61b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 08:43:32 +0000 (UTC)
Date: Mon, 21 Oct 2024 10:44:57 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/21] trailer: fix leaking trailer values
Message-ID: <ZxYUiZ16qbPGi2S-@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <ca5370d572d5750e5fb21c84d4a4134669e7e3c1.1728624670.git.ps@pks.im>
 <878quld3e9.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878quld3e9.fsf@iotcl.com>

On Fri, Oct 18, 2024 at 02:03:26PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Fix leaking trailer values when replacing the value with a command or
> > when the token value is empty.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >
> > diff --git a/trailer.c b/trailer.c
> > index 682d74505bf..5c0bfb735a9 100644
> > --- a/trailer.c
> > +++ b/trailer.c
> > @@ -1124,7 +1131,7 @@ void format_trailers(const struct process_trailer_options *opts,
> >  			 * corresponding value).
> >  			 */
> >  			if (opts->trim_empty && !strlen(item->value))
> > -				continue;
> > +				goto next;
> 
> While this is technically correct, I found it rather hard to understand
> what's happening. What do you think about instead turning the `if` below
> in an `else if` ?

An even better idea is to lift the buffers outside of the loop. Like this
we don't have to reallocate them on every iteration and can easily
release them once at the end of the function.

Patrick
