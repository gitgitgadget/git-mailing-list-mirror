Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A13377ABE
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 06:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791960969; cv=none; b=bi4J+XoL0fsDxbQaUBxl1pQb+vPLXYtFDm1+/hGTOkSq5lfgR2d0u38oV+LISoWwV3SkHUJzMSB8iA+ZTa0VbdejOFcKKScb3ikpZtzr7kG1NWKOuUX28nIhYYKgRr1O0lR3LGoxJ6SCtjBDc8ge8xjUQKzdTCuJrs383p+/hXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791960969; c=relaxed/simple;
	bh=yeBqD1f9UjWZHWvxqU9geztIbV6GH8/hh0NHHofQioY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hrDYCRbAMpWgzhGzThEXZPbp//qXVpXX7OymaTQe/dIEWQlWiuAZEsUHdpT7e5VEfgNfZ2mszOOQXDdE3gaKg18EdzqBOsyYAxJfFYC8SJFfxaV09rYCb5N23XXYN9A4lYdfXrn5tHS5UcV9GUsvgxrJD1ott2sQWszMbXD2ev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=tFNho/8T; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j7tI/7B3; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="tFNho/8T";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j7tI/7B3"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3166D140014B
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 02:56:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 14 Oct 2026 02:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1791960966; x=1792047366; bh=Q6KxiQy1+q
	KWGkDjc+QKs3HCAm7apM6CAOQSNHNQStA=; b=tFNho/8ToZCgRcQ1nkNWS3wY/8
	0ph8z9lfeIKcn7LBJ5Wxy9Kpl/m/3F9VByaeyGhBcpx/MT8aLcZlDspfnTEtLSqa
	6DuTuJiqQA7/3xPJfO1tGSB6rw0xx0v+bctJNuxvFtWGBxeI7HgJ6oxsnkZVkI29
	zyTTuS8A2vqj8eFE5Vxs93hXicJ4o5GzeuTMjvgQPs72LXvw1HvmaEMSKSWWiYW8
	yeL0tVKffjrgGLXm/SI46t9qme0NYY/hzF5UL3Q1ndnnBhScOo/zhNV7cPSYjJgz
	cQVd8jvFYP6Ots0KHWcvYhbWsENaV2IgZ8HCDSIpdlHJZUg4hW8pvPI4nWKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791960966; x=1792047366; bh=Q6KxiQy1+qKWGkDjc+QKs3HCAm7apM6CAOQ
	SNHNQStA=; b=j7tI/7B3jHV0S/RHYw4TgZLXnbAnAHYjjowTPMZQwibflcFU5rU
	+XWdbLc46Fhs4Lx7584tXXfqFYe9om+81nT25Q/tguI8oAQb+FzDhm+Q5t3RBqIv
	qjsKCKXnaD5YeQG5xXy2ZoV1uO8oJxO/1jNslqloCjLi4pK4HNmPMTTwgDtgyhoq
	F+TyAj1RlRJVvedfGcNw1zH9gl/J0/+NY/1/tLR9oH9iYyeaOEb1q3ygUp6/DyDR
	Vq9rHkOXTqaHBTPsSXG813nggHB4UjWUZ5CZomDNak6o1AbNV+lHTOFczXxpNybD
	QdnnE0ObCAda9v91YweD0V4QSV7/LthG1yQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791960966; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VPOIP4aS2cJQdOtg1huj2iKuUkK6c4FCtVmsdpsFsP8QAQp
	rRB64rlyESDNnkqRM6yXgMCT3pdsVWU6GuGUkjtEQZaydG/8CRK7/RrWU0cjH4S/
	8iTwhTgSM/4fpYDa4Nddw9FkB1rvkTXBa/I851CMh7JXMaDV7wMYkjLkb15RBc9k
	OdCvLuHc/wC7xbtpGRo/SjMtLUmhMRCPuX07BtHnYX5iAxaze+ThyF0pXOuGNS/b
	eytFat+dTV9o4r42bZJEw532I+bawoWgfoBVAWDfXJa+tfx0/UB0MTvh7sWVTQ1h
	99pkW0TGxGKzU7nslurxQE442QAIaehLQoP+zrw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/vALxUGmKNZKirOOezFgigZikTH6gFuR2BiMUtd14o0=:yeBqD1f9UjWZHWvxqU9geztIbV6GH8/hh0NHHofQioY=;
X-ME-Sender: <xms:hifPaoGKDVYc0H9hP1mHZvnbKLV7kVsSE1xDlKTPEagvWwRpnn7oFQ>
    <xme:hifPaoWfTr7TKISeEAIBTGgv1zM4jDLNAWIgj5oMh4gETHrXTRGhJuiS_qU-1Okon
    1DDgdfhLvMEcb25dVuXZUUar0rsjv4x9YHRbOAskWBtVbEyuwaspI8>
X-ME-Received: <xmr:hifPanJ3UX0gN9ZRlSoUXG_6rldqXHQSaXip1_n8olVxOhfFvt3MFg>
X-ME-Proxy-Cause: dmFkZTFiiqtB0t+an60FPzLpSYKqX2O+iMAK3UTUxVDwFAvOD5w/Tg3sGEpof0CMTxdwP7
    nZY5+jxw+l7pX3tKFXauTcrfsIz00UxTGz1nuvUJnH+3giwptKSB9j0cz2falH+zZbNLVN
    /YyXVy8jT6M4hm0mAREH3YjRmIteft9dKkjgu6Jfk02AL036j1O9OBS1Kd1jQt9Lj79Uy6
    guF2bpvIF8/tN4pVz2G3Jlc38fl1Ztyf3z/OVp3zWaRV2R2eeSZYbwGVnHR/AeVFuNBY4U
    wpKsN6Ri90ap+dOFDouZfXc5NJWgVz2LwAQ/9hikek9aofgpiuBv66UlgyF+HntWOBqiJq
    SxplpZbRmtUsBI6wHEynbJt0E1dc/j/+xBri7WKHJw5OMv7icBspLW/wetKMyl7UgAtPd3
    eZt2UhvBHZDEORZmOCU0xeDkxGla7a8mxtLU9p6MxngJFbmZbMH94zwqIcCv0Gub4EJ45X
    rXWvLiU3yW7YgaQQBz3ViVRiAsQxXTuvI5ZHu7yNcHKOuxwdD115EG1+iurmJswp6fAnil
    /6jPXicYM0G7INdg5KspdN2DTjXAkUv57wScFwMCnPqcaMPoiVs7yCzdU5ic1AfYDtxDHD
    rSuC/3w943hQ6iRBgvIUgyhNBXJQBDsf+50fTj4XPsS7Yj7w/VoiyeTrvjeg
X-ME-Proxy: <xmx:hifPao9VOF_DIhLD1-TI-SKfJKtJbaZ6D1Drg3d6rKmafosv1RtSxg>
    <xmx:hifPaqId8Lbj1CZ9jDb1NPz4DqVVvkj-4aY5X920akR4d67QepCIiQ>
    <xmx:hifPatl3yrqerFQ0IjJESwgU6JQOmsq5yKaQEpujFNtN_OgXH1w35w>
    <xmx:hifPauMQ2aGnIikk8jSnEqo51oOVZs_WLMmFmkHBbuce3-XvEFQ0gw>
    <xmx:hifPasaoM1HjeGRxXN2iVnwYOYAmB_GtQOTJTWEsnimJCH3EAG4i_SEf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Oct 2026 02:56:05 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5f8bf5b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Oct 2026 06:56:02 +0000 (UTC)
Date: Wed, 14 Oct 2026 08:55:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Wolfgang Kritzinger <wkritzinger@atlassian.com>
Subject: Re: [PATCH 3/5] odb/source-files: make the second read an
 implementation detail
Message-ID: <as8ne87RmBCl10ng@pks.im>
References: <20261013-pks-odb-files-alternates-cleanups-v1-0-b7030ff2b26f@pks.im>
 <20261013-pks-odb-files-alternates-cleanups-v1-3-b7030ff2b26f@pks.im>
 <as6al15q80dII-bk@denethor>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as6al15q80dII-bk@denethor>

On Tue, Oct 13, 2026 at 04:28:37PM -0500, Justin Tobler wrote:
> On 26/10/13 09:36AM, Patrick Steinhardt wrote:
> > Note that the "packed" source also used this flag to figure out whether
> > it should try to surface an object via a packfile that should have the
> > object as determined by a multi-pack index, but where the packfile has
> > vanished. The multi-pack index is stale in that case, and that scenario
> > should really only happen when the process is racing with a concurrent
> > maintenance task.
> > 
> > This code is adapted to instead use `OBJECT_INFO_QUICK`, which means
> > that the fallback may trigger on the first read already, but not in a
> > case where callers know to handle false negatives already. In the worst
> > case this could cause another scan through all packfiles covered by the
> > multi-pack index. But that scan should be fast enough anyway, and it
> > only triggers when we hit the race. So the effect thereof should be
> > limited.
> 
> Would it be more correct to say that we are now using the absence of the
> OBJECT_INFO_QUICK flag trigger the fallback?

I dunno. Whether we check for absence or presence, in either case we use
the flag. So I'm inclined to leave this as-is as it starts to read a bit
awkward otherwise.

Let me know in case you feel strongly though.

> > diff --git a/odb/source-files.c b/odb/source-files.c
> > index 54235821d5..9788a5adf4 100644
> > --- a/odb/source-files.c
> > +++ b/odb/source-files.c
> > @@ -444,6 +449,9 @@ static enum odb_read_status odb_source_files_read_object_info(struct odb_source
> >  	}
> >  
> >  	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
> > +		if (retry)
> > +			break;
> 
> IIUC, we don't need to bother checking the loose objects a second time
> so we exit the look early.
> 
> Nit: Mostly just a style preference, but instead of entering the loop
> just to break out early for retries, could we just return early prior
> the loop starting? It looks like the rest of the function is skipped on
> the second read anyways.

Yes. But I've got a follow-up patch series that has some fixes for how
we reload alternates, and as part of that I'll start to iterate over
loose object directories that have been added after re-reading
".git/objects/info/alternates". So this is a bit awkward right now, but
makes the follow-up series a bit easier.

Patrick
