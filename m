Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727B235063
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772717011; cv=none; b=CPhERNPPKJNj3EM34FYkKXPoJtKoZ5sviqCoGx122dOSj/rmEM3i7dMGhohLWx3HHzO6FM/FaceNct+a4a9ublfA4kSguBDDUbIix/M8Bw6Hf2i4BwBXWqApQ3ZzbgjlPduGQa5WrbSidQLQ6naVlsuQdebwJ/HFaWmB7Yw5th4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772717011; c=relaxed/simple;
	bh=wM7rzTanBO6Esu108tS7q9UmfPGMrAZLevsampbLGmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3uSZqW8TBUX6fqqKT9/o5YgK+gSRzkYmwgWNzBPmlj4th5Bx+X84GS8EQhDtIpeAplWPFAd2vlRnRaiKfvsL5I4V5as4Y86sTZDY7QvXxlPgS2en1k7AkV30iP/klW/vJrb5AUsyNEJOBPJCBtXCyYjcNimJFjCUA9QVubrMH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Yp79yF8D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0xSI5e8n; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Yp79yF8D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0xSI5e8n"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 51ECB7A01AE;
	Thu,  5 Mar 2026 08:23:30 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Thu, 05 Mar 2026 08:23:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1772717010; x=1772803410; bh=BsjnKiGSCR
	NJwySLlUemtZn9rHF3OZ3tb61riNpcq2E=; b=Yp79yF8DlW3hqoOdhLa0Omka3S
	CLaSVjxAHCOc6CXUo9K20J64SnSUOHifN9PN1AbGdCI9Aq1VjcxljBgIg39e8uu0
	43X6WOV2G8Pzz9T6i3nT4dfPsukFBLlUdOFhXe4TC+PE0WCLAtu5LYU1wla9/SBq
	9PWD7L+x0wpGBYc0j0/J5Tg0kXb9UA4DROdyLjnMSyvZOClU9EuSeKojcy0h8Jhu
	yQQfjt6ov+qIba//QL55eV7EMiHOlxi4Ey7/i2Tgdmg9N8N68H56h+uRSWJEYSjp
	LIhzl/eX4AuHprGwY+F+r/rtHyekkeCPam5gtjdSI55UBK2PQZzSDMlkXC2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772717010; x=1772803410; bh=BsjnKiGSCRNJwySLlUemtZn9rHF3OZ3tb61
	riNpcq2E=; b=0xSI5e8nb3AqlzPGXfT8tHaKirca1kThgMYYwZVal/k6rnNz53G
	ANWGoC+4voXOJkVcYbc95wpdf34kX1akuqNVIUov+xDmBBDHqyPzvUA1yD+7RaCw
	ygFogXMcDvAFTpx7TdXB20cjocR6xkqGn2C7GYoQo9/X3BHyVM2e2cUjV2+Jn3++
	PTC65qQjoKbxUYpWwo6roC9hgiFbXAIzHLAvNVpf46PHUA2H5y9JOV0Otytj6OuK
	UCsN8FxsieRh+dS/6f58kEySPkvoS4Lqza0W+wmN+k0oJg5NOhRj1oOm464N4Gml
	loAg1GfR4icsFW76CsW+SYNgojOp8vczNJw==
X-ME-Sender: <xms:0oOpaRqFJBPCmcWF9z8rL8ojYB8f0tJJ-iid7P6bZxarYiYmd51MSA>
    <xme:0oOpaZqnrQ59gSFUVrQaMMUKcD_2IL-HGTINYv1An_YF8Lhha_gMzpFaEbClSboJH
    TTCSqLEgL2JXSkG-Nu0DLZUTGs9LBlFcHRp1Q6HNAFOZpiMLRne>
X-ME-Received: <xmr:0oOpab2uxYYSIaWGq0vhstIRxnas9wJkOt1wOBM_hsMsaxtOeKn2_PunbCXwK4oYNNUyYBv3yxAYfXkwm3VH6wW6Xs2CFvgr2A8TRQSxR4q4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeigeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0oOpaYB9PyGOmYqwFSMNgffZ8sImgcWdccvxmQKUNIrbgTiKgYClEg>
    <xmx:0oOpaTftj84-rGldGuzpavRqv-2hvp3ajwcCi6fBxk_PGx0jCuYgOA>
    <xmx:0oOpadhVs0Ayd_liSfH-tnD_wV20JjMQOMrSeyHCTA12_F8QbM_gcQ>
    <xmx:0oOpabpPMPqL5fgfT70NYDdGn8574_ZOrZ4g38ZMwS-LbW_nqAPutg>
    <xmx:0oOpaQ6eFQCuYq9U6_cgGlbJ0iqL2QwO5tRvCsbSQjEcTSY0nP--LxtQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Mar 2026 08:23:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e71aa001 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 5 Mar 2026 13:23:28 +0000 (UTC)
Date: Thu, 5 Mar 2026 14:23:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/17] odb: embed base source in the "files" backend
Message-ID: <aamDzR_8oTaqRlhT@pks.im>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-3-253bac1db598@pks.im>
 <CAOLa=ZSY8WE_BiWF0TZpV1-bf6p3z8zV4F_o4xo-V1ZC5ZiQLA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSY8WE_BiWF0TZpV1-bf6p3z8zV4F_o4xo-V1ZC5ZiQLA@mail.gmail.com>

On Thu, Mar 05, 2026 at 10:45:07AM +0000, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > Refactor our "files" object database source to do the same and embed the
> > `struct odb_source` in the `struct odb_source_files`.
> >
> > There are still a bunch of sites in our code base where we do have to
> > access internals of the "files" backend. The intent is that those will
> > go away over time, but this will certainly take a while. Meanwhile,
> > provide a `odb_source_files_downcast()` function that can convert a
> > generic source into a "files" source.
> >
> > As we only have a single source the downcast succeeds unconditionally
> > for now. Eventually though the intent is to make the cast `BUG()` in
> > case the caller requests to downcast a non-"files" backend to a "files"
> > backend.
> >
> 
> Do we also plan to add read/write permissions check within the downcast
> logic? Similar to the refs DB? Doesn't have to be in this patch, just
> curious if that is something we plan to include.

I didn't plan to. I guess we could have such a check eventually though
to for example keep somebody from writing to secondary ODB sources. I
don't have anything cooking here though.

> > diff --git a/odb/source.c b/odb/source.c
> > index 9d7fd19f45..d8b2176a94 100644
> > --- a/odb/source.c
> > +++ b/odb/source.c
> > @@ -1,5 +1,6 @@
> >  #include "git-compat-util.h"
> >  #include "object-file.h"
> > +#include "odb/source-files.h"
> >  #include "odb/source.h"
> >  #include "packfile.h"
> >
> > @@ -7,20 +8,31 @@ struct odb_source *odb_source_new(struct object_database *odb,
> >  				  const char *path,
> >  				  bool local)
> >  {
> > -	struct odb_source *source;
> > +	return &odb_source_files_new(odb, path, local)->base;
> > +}
> >
> 
> Since we only have one source right now (files), we directly call the
> internals of that source, I guess once we add more this would be more
> modular.

Yeah. This will eventually be handled via a new object storage
extension, similar to how we do this for the reference backends.

Patrick
