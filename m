Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD1E26B95A
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 11:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356948; cv=none; b=cZ92qwGQopXvwJUzvduqhMVzWnn3VZnPgzGDUYZ77X3yTHBk1nDDD3b9gnUwD+MBJDZPQ/lVelJBuukfwGNjTMbkWGcI54vxOK0GGk3T4AdDGROC9hKfi492Bz4Oixuqte39ec5Y/R2AgNYAjRAu28ggju6M2l6zMNIEi9Zq+Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356948; c=relaxed/simple;
	bh=DfMb7amshUtM5RpATJCbLG7yKjKkL1UJ6zG7QDTQd3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0JSOnOZExXF/bHgvwC7FQmytVrvCmHQ840IHt+enqCoiMvDh5Ke7ECBt7SSqNGCg+Y3Zhg2IdKF1TLrhlWTBbd1ecDdNaPBx9RHWITXkdq/TLZhAxiG5v4DX2ZBdfvQIG0LnhSdnZNk+/qUEbMIV50ILaKGIBl8L/cDIXl5H28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t/lsWgcb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VWuw9kr6; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t/lsWgcb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VWuw9kr6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4ECF67A0135;
	Thu, 24 Jul 2025 07:35:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 24 Jul 2025 07:35:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753356945; x=1753443345; bh=Uupzg6peYh
	OKUg9wpz3fQtKypT5LiSMWKnuA9afUHso=; b=t/lsWgcbZVpx25GJi5zqGlQ3xc
	IMy710KQbrLDo8jCddxGcshz0sUDjkXSIw/YXYAF6wfARdctRjAC8jjW/5wow+2J
	oRgZZ0IsVtjgUhu7wVyNZjklFvK6erOqV0kFvNIw86jup3Y94C20RCEA8416QlKD
	zLwcAI7mddfS6TbUDRgFLiRFIRXghnuypj0Gi3HMUimI3FAKQdUj7Axh91M0ki2K
	QAdOGFohdARsykRz7BRYEqMH6pJQ6M0vntA+fdjYZ2e/OUfiVqiNr7fMckkrx+VO
	vZJzKrhiJnzuPgQt5VKELHstpbpyemDiGfXCzUcBk0gvZUEmaNyNA+Q0YjJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753356945; x=1753443345; bh=Uupzg6peYhOKUg9wpz3fQtKypT5LiSMWKnu
	A9afUHso=; b=VWuw9kr6GUr6KpBIvgl8xDmkTSA7IAf52Jug5WyGzPVZY0LQHiV
	XFJuDpZ1tYsW4ONky73+JZqX09Pr39qxwHNw+hYFMU5jZgAJmH4zixGOMUXBYkFM
	qJ1hK9yO9kBzd0trRkp2i43QTfGySNEuUqGysev0In3OjViGAA/tbjW8CJhJm8ni
	C73dzOzqh+p8lrBqlMT7b/YApJY2zSCKLf08uASS45+npya45fqLWXc40oxaZXjG
	2xUMiawJeyzBvcq0aYgQoIOyt2OV5WyCRvusbu2dsqX5IP9J3wPX4N0BfV4aoN+w
	H+DaJZJ4QtOHV7wh2zlC/2jACHigCMppcFA==
X-ME-Sender: <xms:kRqCaAcA-duJEoFWBRy_YAb0Lbk1_oGWS8EDUqEHIdN96-YhhLKIbA>
    <xme:kRqCaCZDyKvF4DP7X4BoHI20hv_IgywyiLIkAsRV-uAS_Pr7Y5TvWJ4lo8r2WsGxM
    mbci5wlnoy2gXBntQ>
X-ME-Received: <xmr:kRqCaDUEexMvgwpqrxjldDi_2uZSHYmPSVAgF5BknAPCMIv8wa094VqTkXwA5HNou_lLd1V_w05FnIrvW4JRtlGG3d0y1lSmCfTf1BjQyTs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:kRqCaEjmypER3-zpcUtbqWs7l7R6VdU5-eoEuGMazeKmJkSH4RgTXw>
    <xmx:kRqCaBWoQLZy8g8ubAFcpi-9XDHyES3cZGGtEM2JdKyYWoNvjqmP5A>
    <xmx:kRqCaLMhe7WPtGRYVETwpHwuTN0ggBkxN6ITSwB2DEh8QXDHrswVIw>
    <xmx:kRqCaNYiiuIbA-2F9hwX_Fk3YK1izYsIVsisaXubWfCFnU5GenwGQQ>
    <xmx:kRqCaEv1Y0LyFUz2k85zFAYct9uzQ8v2f81Xr5H710Vv1Etum3WvdZsq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 07:35:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b770ab5f (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 24 Jul 2025 11:35:42 +0000 (UTC)
Date: Thu, 24 Jul 2025 13:35:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 7/8] refs: stop unsetting REF_HAVE_OLD for log-only
 updates
Message-ID: <aIIahlqPJSn_ZVYl@pks.im>
References: <20250722-pks-reflog-append-v1-0-183e5949de16@pks.im>
 <20250722-pks-reflog-append-v1-7-183e5949de16@pks.im>
 <CAOLa=ZTRGyypAMcevy2+CMbKQWe5PFqZrv9m5mOeaOAJSDV4kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTRGyypAMcevy2+CMbKQWe5PFqZrv9m5mOeaOAJSDV4kg@mail.gmail.com>

On Thu, Jul 24, 2025 at 03:21:30AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > diff --git a/refs.c b/refs.c
> > index 64544300dc3..c78d5be6e20 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -3310,7 +3305,7 @@ int repo_migrate_ref_storage_format(struct repository *repo,
> >
> >  int ref_update_expects_existing_old_ref(struct ref_update *update)
> 
> Nit: Wonder if we should update the comment for the function to reflect
> how this works with reflog only entries.

Yeah, let's.

> >  {
> > -	return (update->flags & REF_HAVE_OLD) &&
> > +	return (update->flags & (REF_HAVE_OLD | REF_LOG_ONLY)) == REF_HAVE_OLD &&
> >  		(!is_null_oid(&update->old_oid) || update->old_target);
> >  }
> >
> 
> Okay this is check now says, if this is a reflog only entry, we don't
> expect the reference to exist.
> 
> Nit: I wonder if can make this a bit more readable, perhaps:
> 
>   int ref_update_expects_existing_old_ref(struct ref_update *update)
>   {
>       /* reflog only entries may not match on-disk status of a reference */
>       if (update->flags & REF_LOG_ONLY)
>           return 0;
> 
>       return (update->flags & REF_HAVE_OLD &&
>           (!is_null_oid(&update->old_oid) || update->old_target);
>   }
> 
> I'm okay with the current version too.

I think yours reads more straight-forward though.

Patrick
