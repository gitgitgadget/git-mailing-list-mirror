Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931F3C0A10
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 07:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783667327; cv=none; b=g+TMecoGxpzrRVRNxcC/pHiEB574hnlmYoG7iUlqIkrHB8as84E2O7axnsjxcwJNYnzmyPJsplwIWdHmwkQ6wzJS9KphFLs21mLAPkf8BQpx0Kg9A2h0kcLDRz/FuyjZ47lRyPCIWMs2ZfqwKbmVLr/ZAStK5V33+vrVU1c2VyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783667327; c=relaxed/simple;
	bh=QBRDqueu/TjzSi3YOb6jZ6PFL/2r2M6R1ikcwUSnt5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q37f3TfLq8cpdEYXZAWEitPKk4qbWj3do9YsRB914jq2EHo/DL6ev6s6Q7OArOjE2BWOR8ndxYEgWwryd8euir252C3C18IZxs5BGCE/Coil+zy8mVjmRgkEkDOXa66I0CynF3S/3W0TXAdv8bohxhQZ0d2VP/PaGUjmoPdS2iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Aldf6avD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BYgCgQdL; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Aldf6avD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BYgCgQdL"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0324E14000E3;
	Fri, 10 Jul 2026 03:08:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 10 Jul 2026 03:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783667324; x=1783753724; bh=+PiobdGOuQ
	T2Gpdm2uppGWkHH6ewlhjY0gQd+fejzTo=; b=Aldf6avDiFquqlAQAinvppU+k5
	svl4P0C4CLFTWkQ2o5Nu6kmKu/NsY/zhnPUetV9JaGRa8QAWJmGPam6iMMtECze9
	V8/0Yrr5++f0AXsTkJaCdsjdHKGN4q/yoZJEwpVeGHmQtWNO88wAQoxm8a6fEURC
	tP8uu40DbSnsJUdSM0lRD33S982D2cr4H0mwYnBSn370IIfu9fINvd6YyWH2wzLy
	L9HVMCWvQmAazm5KlwdwQsqJf++SKrFbC+8G8Os5PWPFLIEl39QbQSH7ZjXSaDSO
	31RMhv/zY3qqxyG3glNiZosrixMUSr4sGjNCAvZmZVSdP9y2i52y24xI0/OA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783667324; x=1783753724; bh=+PiobdGOuQT2Gpdm2uppGWkHH6ewlhjY0gQ
	d+fejzTo=; b=BYgCgQdLcSW2izOJbJI644Ws57UIVHdEcUYA53g+aCok0JyZtgZ
	ISSI4peUu5j20t+F1K5lQ+olbCcg88c9sS12HvEtF2D2vBdUl/gCrFB6Jb9LDYNF
	+sXQ9Mdi5JXHAc2YaNP/coYDvHj1lEwNPF8ZAyB+yfqXDegdAcfWMWMZXbRek15n
	2G2xdkRAE2I3zF6SxjjuzNXCtv4P/jvpyH2zlL1GD1gHR8gjVA/rWh2X0XRec3LX
	IH1yZkgAUX4mJxhNX5IYfwisHpBA4Yb0whPhMbuDI4+FJLrKFHk8JGLD+mPuDQ8v
	594O07sAHHanlAon2DZoZFCXx11DCE0jnAg==
X-ME-Sender: <xms:fJpQaq2mWaG1YJ_jM4T3qTl9xAWTtXfSS-QMzUf-IMIySzNHMnY1vQ>
    <xme:fJpQajEF-8Q-7STICokYFlHcnT0aMoEIG0TJ1ZvCBG_VNy2E0wjuw5Ql-cq5tbkxK
    ZSnbGeZubHtP114DLCNKj_kX3DvmdrItIC4psUDFMT6-EeqYNE1bw>
X-ME-Received: <xmr:fJpQaggyAOFf_nvYF2YVjJH8X8QqDYi3nFxvbmCC-6pxVE3_P14ExUc0Z6Pt9miw7RmsddMUVHY63mSqz33jZfgqdaEyQqa-igOwjzwtiQMHCw>
X-ME-Proxy-Cause: dmFkZTEGzWF0KumW2c+ke85oX0TErXRs9sqhW8ursPvJjv+whhfnVn3GAZczbwBG6Ays9X
    YucgkxvtFpJhiMajQeeOC1jFUVacskPLHdU0EI7R1tXz/jLkBV51LNuJfguqn8i/GsZ6JN
    SvmM5YX3du48dcK6cntyvi4AWMrXgRJpom6tv8SJKB1LaP1bk7n+CwOo2A+lP7/ZepUtef
    P0BnMVuyZQjp32LQ4EXVJTeniQF37BY8sYdAqNfdWDRt/GAdBpKT6b6GeIRhXS61bedCS8
    /lcvPzebmnYRGnYpXNfbRglNbhO+0bz9Tnv0NKfEKgiwEUNWpv9IfOLtxF6Scrqvm5iGtb
    ApZDvCsu3Fvrx2IasIIa6GQ/MUNlsXHrClDL6wZaJQnU9aKyHBCKnXRZtoJLFG8k+AzrOp
    FZ84YYTW4MsK5pjfaDmawV8ZRB0LGtja8OnNuL6KNizkWU6sDawywnnakVLFLAU9dbcvNQ
    SADlD6pjDaTz+Si7vnu6HiLuwmmq65/TpzZ1ONt+4fPF0B4fQFNQYv/yMIsX4DmgpfAP8V
    58RsRcPS7NeEuMKwnmGL43HuS2FWo/sr3whBC51idRjChmn6/yMOUgEFN2SAdDO+HSUtAW
    SELK7CdrLYQv95snph7JCV2DbaRlrJFECT+A4f6ih3PBWTQEiWN8AWyOWfVQ
X-ME-Proxy: <xmx:fJpQam_GQjE_r7VNYPu1n58AyTAvrCC1xRw8p9HUKmMgOmPgLTDumw>
    <xmx:fJpQavq00BFldQUWyr2osmX2yt6_Jvuifqyh8XuMZuGOfxd509w2zQ>
    <xmx:fJpQat-VhViLS-4l0SNlkXFoYJONM16fmXjGLTcOMAP7MHqw6o3QVg>
    <xmx:fJpQarXcrxxKmMOxn6Qdf0-vZtuw-noDbkEKrfL5LD2IDs5RTUgU9Q>
    <xmx:fJpQanmEPt-NUjM7LCBAqEeCbUWDtJEvSE1gAKety41fL_62WWHydnnQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 03:08:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0cd88d80 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 10 Jul 2026 07:08:41 +0000 (UTC)
Date: Fri, 10 Jul 2026 09:08:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/7] odb/source-packed: improve lookup when enumerating
 objects
Message-ID: <alCacqAl9gItMKo7@pks.im>
References: <20260709-pks-odb-for-each-object-filter-v1-0-82fe014b12b3@pks.im>
 <20260709-pks-odb-for-each-object-filter-v1-1-82fe014b12b3@pks.im>
 <ak_uXc0UxB_9Vk9z@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak_uXc0UxB_9Vk9z@denethor>

On Thu, Jul 09, 2026 at 02:54:17PM -0500, Justin Tobler wrote:
> On 26/07/09 10:35AM, Patrick Steinhardt wrote:
> > When iterating through packed objects via `odb_for_each_object()` we
> > do so via two different mechanisms:
> > 
> >   - When a multi-pack index is available we use that one to efficiently
> >     loop through all objects.
> > 
> >   - We then loop through all packfiles that aren't covered by a
> >     multi-pack index.
> 
> To be specific, we are talking only about the for_each_object callback
> for the packed source `odb_source_packed_for_each_object()` correct?
> Also, this appears to only matter when we are enumerating OIDs with a
> specific prefix.

Yeah, true. I'll clarify this a bit.

> > Regardless of which mechanism we use, we then iterate through all the
> > objects indexed by the respective data structure. Curiously though,
> > while we use the indices for enumerating the objects, we completely
> > ignore it for the actual object lookup. Instead, we call into the
> > generic `odb_source_read_object_info()` function, which will itself
> > consult the indices to figure out where the object in question even
> > lives.
> > 
> > This has two consequences:
> > 
> >   - It's inefficient, as we basically have to figure out the position of
> >     the object a second time.
> 
> Since we already have the position from the index, there is no need to
> start over. Makes sense.
> 
> >   - It's subtly wrong, as it may now happen that a specific object will
> >     be looked up via a different pack in case it exists multiple times.
> 
> Naive question: Is there any real harm in reading the same object, but
> from a different packfile here?

The answer is probably "no". At least I cannot think of any case where
it'd really matter, but semantically it's the wrong thing to do anyway.

> > diff --git a/odb/source-packed.c b/odb/source-packed.c
> > index 0edea5356d..9cfa02b7a2 100644
> > --- a/odb/source-packed.c
> > +++ b/odb/source-packed.c
> > @@ -177,9 +178,8 @@ static int for_each_prefixed_object_in_midx(
> >  			if (!match_hash(len, opts->prefix->hash, current->hash))
> >  				break;
> >  
> > -			if (opts->flags) {
> > +			if (opts->flags || data->request) {
> 
> I'm not sure I follow why the above condition needed to change.

This needs to change because we now require access to the pack so that
we can call `packed_object_info()`. Otherwise the pack would be not be
populated if we're invoked without any flags.

Patrick
