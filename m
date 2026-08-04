Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9749C427F84
	for <git@vger.kernel.org>; Tue,  4 Aug 2026 07:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828089; cv=none; b=mWQuWFi0S7nX88RprFFExmvaFlRMR8d5OROORn4Bv2yIDly/5hpxERgHDYLBS6X0AfATtCBkZGvhliwQNO+RDC+jSZEGxcK8iqj+YXB2OW90q0AF8CJAA9qiAfLYJzQY8zyouTbI6wdOIiv6AuqaHvuL4xArm67c0nPGkXD9v5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828089; c=relaxed/simple;
	bh=562dTBZleGJcgAmsKr+ic884/kHlVYd3fiCNVKwu9Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bWHnYZKgKWYNBwVFs1PgNd2WVb/d6f+sdn2rya6cSFWl4TC/Fl5Hkn3xTd1+egm6W7bTPGPdLs89WEaGj55Oib/FbcnwNu+N0U0TslJfo84azR+O2EL3CQEWPu+rK6T23xI0awN2zw0fXXgkOB7hLPexV7bmrI79amf+DiHRUJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oP4hbmyq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ijzitftJ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oP4hbmyq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ijzitftJ"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9E817A0144;
	Tue,  4 Aug 2026 03:21:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 04 Aug 2026 03:21:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1785828086; x=1785914486; bh=sJJI6WjPJk
	mziSJxDHF+EgCU0VIw6gA1GadMXwZXjgE=; b=oP4hbmyqIiKrsSvzrV90qeWt5c
	Fex+6b0ME7AnjKEmB0gAQsbmYLdgcEH3TgfhO/S5FoOiTHMikxK8wZR6+/iUy4H0
	c50vCfNKXszttJsWW0rXh5ckyJDsB4yK0nB1kZ5G9J+/w+UT0PYLPpy8rGyyD644
	hhN+b8v4ONBlKvdKuUMd/ICMXIJVvuVunoIhVC1I1HDV8xwfW6rmFkxXav1RBrGT
	sLX9gTMgcvPzhtDRoJ1Ai9p3quUdxwmODbXTHeHVwdCG8M7tv9cYzYTNra3vws0P
	VQt0aAYmVp38MHGrKqu8GYRug40I6qk9y+2OxhuF9od0nk1M8vejLmMR9RiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1785828086; x=1785914486; bh=sJJI6WjPJkmziSJxDHF+EgCU0VIw6gA1Gad
	MXwZXjgE=; b=ijzitftJu6GonczY+LbxtjlLJqLwE1/s6MQOV/8ZQrd19nUX2Nw
	+gOk5NHR3FZ/Z5ATya0cC/CkVSpR1PDmU9MV2dDwTXuIQSQB5pX59C+UFLpY6S4w
	Fq3a6EbNGR+Wz2euo4QsWM/q3jfwRoZi+THNSbtGOb1EeO514Vn50Tw8ccbLqt2S
	lho2hTdfXvjSVCmlJidX3kSTTgP/sMYXBF7sFZyDeU4JeZOoJVq8tQ2YOBo3tH6S
	C2Oxq1Dw/I6gF188tXYMULwDZTCGvJZXDJCYTua+zjpxvi/VJuaW+TApe8IzKAfT
	fXyhLXVyW4dqqqWzbhZbsGzXv0fiQ2fBJWQ==
X-ME-Sender: <xms:9pJxah3PRiGAb9jx2zREncma7ToOlwXl1t6f6xLlcSvbma1EQ57ZdQ>
    <xme:9pJxauHcibZdw58loqGXnGnxqPEFCfi63Q_gsBqAnew53bl1Xdu4Ta3b-UhqfvyAF
    Dw_0Os6Gy-1diO6yJ1FnbIceFPqzrxtMbEsz2EjgcuKfSBDezkloA>
X-ME-Received: <xmr:9pJxavgn2obVGWhsw5pZABfghyDKA18sNYgn5d8q_Pmsay4MCiv7yPLIkRRGetloeKIraBptBZbBJx4bw__IMs6cpMHVM-ER98C5N0V7>
X-ME-Proxy-Cause: dmFkZTGdM6jpBGZhzGMeQuy374uz75V+gHLRV9Ekqz689qKkzsSrlSeOAdb5ajEbF1ADvZ
    aKHz+UqItg9eOBUZzQLX30I+y8dByine6J+JuyBCqa5+dApg1SLbjKwh7txknVAHrnlb1o
    vGTi+lkqwLGopOwdnxxGdhw6JxwTAczw6VYSB/5MBvYYIXm12wX+SB9/WSHHWgtVJnIBLT
    eIeb+2VKNnQINhFj5bHPozqcS6IFe+HaWy0gZTjRUVXWwZuP+eV/kfasJtvQdwktRwCQGj
    fGWnparXTfRW6OIicMtsa86HUHe3Nqr75cwUYC5cG/RNSylYzj57UR1LbMCDqbDxsRX/Ob
    7ZH4Gi/OgsCD+0wSj78HCKkn0SQFYSpkXoxjoObM421n3NSGzVT0/jb01nMFlL9mK34agQ
    VU/hy1XR3H4x3Hl6upIncbsLxsGhXWo6Hz85aWCPYkVGZfUW17MUJVaeFnXqNxL3yFLFB+
    7l/6iElCuuu2TWhn0+09b/QFdSFf215LPxM29xaQx5plfS8ozrVCDm04lYqfBS9RPXni0Z
    btPKB5vQZhn4C8hgiVEq20UDyW6FgS4KPU+qQ0kpuh3uhnP5xUGG9WWGy4u8Js9hUGrgE1
    D6BC10mj/x2BnqblzP7C53f0dXi9nY6iFkiGmUOtnt0MZ1EFnh4j7o2yAi1A
X-ME-Proxy: <xmx:9pJxap8dRnuzPu9925RLwD7_pW4yuxvV9m3_iMIpdLld2pu9TrgUKg>
    <xmx:9pJxamr00ZUGS9mLK9zWG0LXgXgmqqmD0LATMdZ3gFxJpq2WgHgyZQ>
    <xmx:9pJxao84TEfMgoqsQ5QW_zZXaBc6MHedmFJUQaL5msOGWfKitslUgA>
    <xmx:9pJxaqVBrddbzFTPKUwf_azYwlm4eKiKqPofe-edXtlNYPDaEQfQ3g>
    <xmx:9pJxatOvCpM_2DLY5140LoqxqTgGCriZ2ciB5d1iad2-cRckrv_BxD_S>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Aug 2026 03:21:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25f996fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Aug 2026 07:21:25 +0000 (UTC)
Date: Tue, 4 Aug 2026 09:21:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/5] odb/source: introduce function to map source type to
 name
Message-ID: <anGS8aD_j6rq5YeT@pks.im>
References: <20260724-pks-odb-create-on-disk-v1-0-3b3d265d979b@pks.im>
 <20260724-pks-odb-create-on-disk-v1-4-3b3d265d979b@pks.im>
 <xmqqfr15v6ba.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfr15v6ba.fsf@gitster.g>

On Sun, Jul 26, 2026 at 01:34:17PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Introduce a new function that maps an object source's type to a
> > human-readable name. Use the function to provide better human-readable
> > error messages for the downcasting functions.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  odb/source-files.h    |  4 +++-
> >  odb/source-inmemory.h |  4 +++-
> >  odb/source-loose.h    |  4 +++-
> >  odb/source-packed.h   |  4 +++-
> >  odb/source.c          | 19 +++++++++++++++++++
> >  odb/source.h          |  6 ++++++
> >  6 files changed, 37 insertions(+), 4 deletions(-)
> 
> OK.
> 
> > +static const char * const odb_source_names_by_type[] = {
> > +	[ODB_SOURCE_UNKNOWN] = "unknown",
> > +	[ODB_SOURCE_FILES] = "files",
> > +	[ODB_SOURCE_LOOSE] = "loose",
> > +	[ODB_SOURCE_PACKED] = "packed",
> > +	[ODB_SOURCE_INMEMORY] = "inmemory",
> > +};
> 
> This is a trivially obvious implementation for mapping in either
> direction.
> 
> 'inmemory' should probably be spelled 'in-memory', though.

Fair, that reads better indeed. Will adapt.

Patrick
