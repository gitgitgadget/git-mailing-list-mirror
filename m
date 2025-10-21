Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5400F32E73E
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 11:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047048; cv=none; b=g/7fffES0oYY3xaTAFzjO7HCLlFNvJKB1modhjeyD7T8Zz4zyM0Nus3CDVJQReF+d6wGFiimDBcqYs5/PqeWtQQpzQDyRSYCEeNCBIK0IEWK1gzJ9VfMpL5VZW/ZDmNu0xpp+QkcA5O+RZ800EVHulzoXhL5M21onEAmQXPg68M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047048; c=relaxed/simple;
	bh=ts4XaDx7fNx+WRq5DA8QXTWUwRnjhitSsqTdGNUU+vY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JJMqyT6ZPUXYJz5YoSfeuTHYykA+s5dIuReBClPliUlKzQzRJ2UzlHwjCOu+PPrAL+Vhv/57XO8KrJHY8Wpkfq0YGc7fRvGOJ72Zs3xEHlp+orHY2GvVKrNkbdzG8tnZ00QGCK+26nKEKYLPLlUwTjvtPnMo4WVcciA++dVo0Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=P9Xj6BKM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PIj71ARn; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="P9Xj6BKM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PIj71ARn"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 54FF7EC00C8;
	Tue, 21 Oct 2025 07:44:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 21 Oct 2025 07:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761047045; x=1761133445; bh=MkR4fY1gk6
	g1KtwqbYJBbqx5U87NAxMRbD+ZDLI3JRY=; b=P9Xj6BKM0bazCMm/VqolzWbSVs
	a5K3ZmmCDYyAfjT3bplrfMhdYkYXwGWn+eACWEN+8cT4gZi2QJUO++eEhjdhWxIh
	MaBwRfOMb5rU4XOmztvlMuohooaRN4r9AothVzd7biEzHHZNsez4XxPYLedKWt9H
	K3tZCsse2ZiHdfzM2oIoB1sYTrF1Mp2Rq+dShVKdoQ4J6lspRggi7+iJmUBNK8M7
	6IzKWCyL3O8CAe4Lx3VvSq/WbO9+oaSlCoWvqnbs1UiSajJovDwtN7rUOfy8LMrG
	C3JsuaZO5Yhj6XacCq3727YDu6O6wZ86Vzc0Q5yBae3I1kgZSXzpk4C10E0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761047045; x=1761133445; bh=MkR4fY1gk6g1KtwqbYJBbqx5U87NAxMRbD+
	ZDLI3JRY=; b=PIj71ARnyPb0DvlEJB1lq7w0OoQM2QgEGGNswtBU49YvaT6ATL5
	kKwoar+DIAlwArVoT9leD7mt+//6PR2UVYUGw5MIBS3xryku9z8BsmWgPlT9Hm0R
	Q3LrGXd4mrNbChgZdYVK1Tdr3fE0dDi75tIU5uUZzAAhq4Reip8Is52XSoJBjIQZ
	YN9JqU6kJmBR8kc9xiEalI3wcnX4qOC/pIqYTeyO3B84RGeKvUUmwvIdW8tWYb9l
	237zNvNjaQJlbw7odVej1sT2NsV7XdiQX7lpBgJ52gyrmbUyc9lrfgWwoL6DrCT1
	yrRUMI8EdPTmW+YFnjblA4vIJgiJvEc9GZQ==
X-ME-Sender: <xms:BXL3aC7z-hXebMpISA8MGBdAwTJnSZGK3uekqS5fINA3zhCaBsPc3g>
    <xme:BXL3aOe-cBeespt7LADoFMiuMtdK8KWzPpcBNbDJsiZi2sUM6_j15C0XGRVLvjG-G
    cdZZXF90NyOWjyy1a-eQ7CoNGfDx4Tt7mBi28IEz8Ym06gPc3HeOg>
X-ME-Received: <xmr:BXL3aFGnlhxmSgRwFE8gqF1UcTCzjqVzw0cdyQxM2nfb6cZcCEk86l-s4e0SR1nkYwcVLBb3VYpKPYZ4pSUqCBX0xvhXn47NayfYPXMsbMMKzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrg
    hvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    horhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkh
    hksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhm
    rghilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:BXL3aPS4sBCb2VxAmKyimmqMGNSaTT2ss7qzclXhwby-XGvlcQFthQ>
    <xmx:BXL3aLYn2ntbaIKnL_UDGLO_J4mInMFsN45yEDQYWmA81qzIFcyfng>
    <xmx:BXL3aK0i-jyPXFEBVR3W37ZD7f-mH-gNxGoEnRh4XstTg-dCiQeXHQ>
    <xmx:BXL3aOotK3j2Mx3ETFBKmP-yOwGd3OYOBTpVIrlaQOXufoATY58Rvw>
    <xmx:BXL3aM0gbCAbwfiT0zS6gnViwFudLYfcBMSmzk-MLJcP02MCUq1QwUjN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 07:44:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5599b3db (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 11:44:02 +0000 (UTC)
Date: Tue, 21 Oct 2025 13:44:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v4 08/12] add-patch: split out `struct
 interactive_options`
Message-ID: <aPdyAOhVjSMB9Csb@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
 <20251001-b4-pks-history-builtin-v4-8-8e61ddb86317@pks.im>
 <CAOLa=ZRh8LDu=-PAxiAV9QxFtjuQtC8sOojZm-4=CgN6t4vJFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZRh8LDu=-PAxiAV9QxFtjuQtC8sOojZm-4=CgN6t4vJFg@mail.gmail.com>

On Tue, Oct 14, 2025 at 08:35:39AM -0400, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/add-patch.h b/add-patch.h
> > index 4394c74107..a4a05d9d14 100644
> > --- a/add-patch.h
> > +++ b/add-patch.h
> > @@ -1,15 +1,45 @@
> >  #ifndef ADD_PATCH_H
> >  #define ADD_PATCH_H
> >
> > +#include "color.h"
> > +
> >  struct pathspec;
> >  struct repository;
> >
> > -struct add_p_opt {
> > +struct interactive_options {
> >  	int context;
> >  	int interhunkcontext;
> >  };
> >
> > -#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
> > +#define INTERACTIVE_OPTIONS_INIT { \
> > +	.context = -1, \
> > +	.interhunkcontext = -1, \
> > +}
> > +
> > +struct interactive_config {
> > +	enum git_colorbool use_color_interactive;
> > +	enum git_colorbool use_color_diff;
> > +	char header_color[COLOR_MAXLEN];
> > +	char help_color[COLOR_MAXLEN];
> > +	char prompt_color[COLOR_MAXLEN];
> > +	char error_color[COLOR_MAXLEN];
> > +	char reset_color_interactive[COLOR_MAXLEN];
> > +
> > +	char fraginfo_color[COLOR_MAXLEN];
> > +	char context_color[COLOR_MAXLEN];
> > +	char file_old_color[COLOR_MAXLEN];
> > +	char file_new_color[COLOR_MAXLEN];
> > +	char reset_color_diff[COLOR_MAXLEN];
> > +
> > +	int use_single_key;
> > +	char *interactive_diff_filter, *interactive_diff_algorithm;
> > +	int context, interhunkcontext;
> > +};
> > +
> > +void interactive_config_init(struct interactive_config *cfg,
> > +			     struct repository *r,
> > +			     struct interactive_options *opts);
> > +void interactive_config_clear(struct interactive_config *cfg);
> >
> 
> It feels a little odd that the `interactive_*` code lies in the
> 'add-patch.h' and not in the 'add-interactive.h'.
> 
> Should we also consider moving this or renaming the structs?
> 
> Nit: might be nice to make add the 'add_' prefix to them while we're
> here.

The proper name for this struct would be `add_patch_interactive_config`,
but I decided against that name for now as it feels like a mouthful. I
think these two patches improve the status quo regardless of that, so
I'd prefer to just keep those as-is if you don't mind?

Patrick
