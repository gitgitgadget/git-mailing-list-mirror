Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193EB19EED4
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 06:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731392955; cv=none; b=XNy3T0GVvZew+YioIjP1v7sdb4B0dwZABpitF1RpHdStt4FzJB9JGsb9GxDdZjNt2nkLtyLNAGelb6BFMRPwlO+JPcPMpnN1cAA6U0llzBLDSMnA6D0QDXs1916R+XXiH/PF7sXkQ5D/Z5KsgBHP1KD10dxpal94HPSYtyhww18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731392955; c=relaxed/simple;
	bh=jfMR8IP9OFpLttAitH8dav33sjW9TBn32Ws9M9w7VFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kKx1Rhr0AAyK4akYEywhV7GpZtwaFb95aex5ruD8C2UjD88laOdofTjCBqodeYoBmc0bhuhQ0Zspm+rV4qUm9F5gjjjwAoqh7iSXByXzNOGbzj4je3eqC2y2Rb6+cP5tR081HzOViAuXxvKPrrq2CoeNXM9QBELzh3I/PgasaPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=zaMp8jTJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CwM4w90g; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="zaMp8jTJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CwM4w90g"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 063E21140166;
	Tue, 12 Nov 2024 01:29:11 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 12 Nov 2024 01:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731392951;
	 x=1731479351; bh=6mA2Icd8GSL9TPE0QYtOp6ctBjUCUaqF6J/vJipy7yI=; b=
	zaMp8jTJsOh/RaQONkx4W934aoLCwmS1n0zhF4Qf+vGNvubF1n/55ES3D2W4FQdX
	vrWT6Zub5J7Oh5Wq7VgVZllAUK7xxIDM86tfixA3xRcsvW2xLGTBy2DXFZLwWbNB
	fnME1HtjxRCPGfViCT/EogsNoD+OnmdVx7bgqIRWdvUD8oZfbAqgWQt6yoXKRV4e
	EMrh+OwivkduN2KiCMyOMBDfgHW3+WSYfHimQbbiILOsIML/sME1Y8xS6Gi7Zx6B
	msTvSxl/T0yIAmd6gDkdc5Wcz9P/uEB6QDFWugnjuuLj8uk3djDot2fibZTmEvF7
	teJtMRIgl13mUfsE29x6VA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731392951; x=
	1731479351; bh=6mA2Icd8GSL9TPE0QYtOp6ctBjUCUaqF6J/vJipy7yI=; b=C
	wM4w90gg3ZItfzEX8EwnpyEyJ10109O6gh4vLMML3rs04BFF8SwfTGXlATnYkbqc
	LMCyl147Q2VwPc8iEGjOu3kTU0jq6+i4tNp36VdXt9a0guddcD3bZhwQ/TSaqBjK
	hIXLvGWrOzezd4u/SdI/jBexiMZ8DP7/u+niXcIjrrQY78wRIk+FkqOsyh0+jdK8
	O/l7FPt5GkyNKMM1HE5JhkWtIVDWrmqQdYURB2fOO621pdlqDqASE64mrPsKng7o
	LdW/bbImCIgVsdNhSM+tyhale9QZtrlLE1gBYb2KnKKYE4VNFWjewvTBkcCcn3dU
	gQCVQNMD57ydm+0UHgtgQ==
X-ME-Sender: <xms:t_UyZ1L-ZHosiEFQObPNIinF1TWIDkDpyQ1ppUSwzZANjaVcQhqs9Q>
    <xme:t_UyZxIRDLEYiQnXSE-zShkWjOHnClyyxShNqRWged-ft5etsZkBi6c_TFxf-AJQs
    YOY1K8vSdN3MJqiIg>
X-ME-Received: <xmr:t_UyZ9vIcYly8c0VrujzqMh25c4EX-Op5e2MP9E2FL5hIJ0aEc1MzQaSEbF7NoJ7LEmn3h6PXUS2WyyxetISNiZx8OJcBcHKv8lcro43STxZOkI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudefgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdevteff
    vdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhtvggrmhguohhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopegtrghlvhhi
    nhifrghnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegvmhhrrghsshesghhoohhglhgvrdgtohhm
X-ME-Proxy: <xmx:t_UyZ2azrhiDpGvpsBwEIA8lb10gJtZBN8c5aEwXVsh7b51JvraTBQ>
    <xmx:t_UyZ8bK24lh0dTpV2yNhSK6OtXNJqy13ILE9eEnULbYnUV5V9TFUA>
    <xmx:t_UyZ6DWMU5GMaHuaXSvcDADvmwTdUWIYz4XmwfN-4zzfxLVl5gGxw>
    <xmx:t_UyZ6azKSBUAeApiw5449XZrJmnqNVjghMjVHrucEE-keP6EleiYA>
    <xmx:t_UyZxOcNoYVxadk47gO0GSTfdcgDiR5eVh53cz8WQhXnksbnsoY8-p_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 01:29:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 94773969 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 12 Nov 2024 06:28:32 +0000 (UTC)
Date: Tue, 12 Nov 2024 07:28:59 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, steamdon@google.com, emrass@google.com,
	me@ttaylorr.com, stolee@gmail.com
Subject: Re: [RFC PATCH 1/1] maintenance: separate parallelism safe and
 unsafe tasks
Message-ID: <ZzL1jy3plVeld_3m@pks.im>
References: <20241108173112.1240584-1-calvinwan@google.com>
 <20241108173112.1240584-2-calvinwan@google.com>
 <ZzGtD4Jz9Wj6n0zH@pks.im>
 <CAFySSZCzxfqpMWH5ORv8fYb7f5WU3Fc2N99fW33wD9JOcYVrVA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFySSZCzxfqpMWH5ORv8fYb7f5WU3Fc2N99fW33wD9JOcYVrVA@mail.gmail.com>

On Mon, Nov 11, 2024 at 10:06:10AM -0800, Calvin Wan wrote:
> On Sun, Nov 10, 2024 at 11:07 PM Patrick Steinhardt <ps@pks.im> wrote:
> > >       [TASK_LOOSE_OBJECTS] = {
> > >               "loose-objects",
> > >               maintenance_task_loose_objects,
> > >               loose_object_auto_condition,
> > > +             SAFE,
> > >       },
> > >       [TASK_INCREMENTAL_REPACK] = {
> > >               "incremental-repack",
> > >               maintenance_task_incremental_repack,
> > >               incremental_repack_auto_condition,
> > > +             SAFE,
> > > +     },
> > > +     [TASK_UNSAFE_GC] = {
> > > +             "unsafe-gc",
> > > +             maintenance_task_unsafe_gc,
> > > +             need_to_gc,
> > > +             UNSAFE,
> > > +             0,
> > > +     },
> > > +     [TASK_SAFE_GC] = {
> > > +             "safe-gc",
> > > +             maintenance_task_safe_gc,
> > > +             need_to_gc,
> > > +             SAFE,
> > > +             0,
> > >       },
> >
> > Hm. I wonder whether we really want to expose additional tasks to
> > address the issue, which feels like we're leaking implementation details
> > to our users. Would it maybe be preferable to instead introduce a new
> > optional callback function for every task that handles the pre-detach
> > logic?
> 
> This does sound like a good idea. However, would there be any issue
> with running all pre-detach logic before running post-detach logic?
> I'm thinking if pre-detach logic from a different function could
> affect post-detach logic from another. If not, I do agree this would
> be the best solution going forward.

Sure, in theory these can interact with each other. But is that any
different when you represent this with tasks instead? The conflict would
still exist there. It's also not any different to how things work right
now: the "gc" task will impact the "repack" task, so configuring them
both at the same time does not really make much sense.

Patrick
