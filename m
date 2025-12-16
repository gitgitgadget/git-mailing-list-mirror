Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBA832B9A6
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 09:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765877438; cv=none; b=fTZFjap0QQPK5ZLBB6ZOsGc1DStQhjUG3wkdE0HAQLZVRnmRQL7GbECVXwjrivSER/CSRgL1taRSP09pu9U2z4V7hyEuoWEkEze4n0+A2dIrsDnzdYQGc8T282vNPKzDINCTFnJimBVKgv3SMWa1JGpxWzQFMpDiz/4wrpph/8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765877438; c=relaxed/simple;
	bh=8TNOKG+t/Vuv1X3jCfbIMf1DxnfbvolmyfrrXF9OoM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3n8TC3vUbmfVpIosxjDPrzX3egKBnY1+pUZFZvDe6pLIB66cYlrvSIgSLgxHJJ2jQPWUk/Kd1RKRbyA6KWfmlgDYuCH0Ue6yw+vfY4qEJsxtakRZ+R5lmfFS0AoSBHu1d0xgM5nNnp4SO9dQvKRtjb+/Zks0ME5v4sHLZrZmGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jgT9jaVD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DMcBSs54; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jgT9jaVD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DMcBSs54"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E78367A011F;
	Tue, 16 Dec 2025 04:30:35 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 16 Dec 2025 04:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765877435; x=1765963835; bh=1KYomI+qIm
	BDZYxeo3gyhb+vPz1qPEHLOTm5S8eQ4LU=; b=jgT9jaVDoTpbc4TYbPnmHAT42+
	vLmg9V7sSeUvn+GT4AQlPkuL3S1GbWPUJ9wHecQGpiKOKIVWbqFC5Kxk0gL9SjyM
	d2ytH5UOK8hCtMog+uG2QvVlKjWkcKuxtO/Hl63oiu8N2KIgGxxaxO33CVCJdTdN
	CgdjsYMEHakGZaDCtQs9jAvcnD9kDJMxc+wuFGnKX0z4cMiFkVV+v9oVEM/rf+ha
	M8QQo4A8MLg9uSsGkv0Og3UYhhXbxnvYfKs1YV2qaVKHJO9CbJriCng0ZgFycyyP
	OP2uZIiOz1BhSpqZMcOo7YWirctha1ZoNiSYuu5bYkqW1/wfyGznwBMYND8w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765877435; x=1765963835; bh=1KYomI+qImBDZYxeo3gyhb+vPz1qPEHLOTm
	5S8eQ4LU=; b=DMcBSs54QEYHoEt1J5fUqjAVeP6b4Mq9eAvshzQ4Sw0cSwo0ImG
	kA43C348DnZYPRLwtAjphHxLK/O5+NNTIavwjWoBJV6M1cqP2g6fvzwZAkErwTt0
	qwt3pQT/0F13EcCkta3L/yLpEtnD5AfIT1gE+qJtYHcXlDmd6C3cnytlA/OYfYPa
	vMTO/CnGe4Sr4Bb8yeaNTfnPbVQZt3PfOWWl26XsPiOojgkwIH1XTJRo3R+H5NBS
	9njdttiP/K4l0vBhGHrgTjrwzDyUAQczNK3hQmJazGZhO8vE9SEmxIdA27Puzm2w
	dvYsPx/OLKCnC8MZpXWnxZkuQlH5+esIlvg==
X-ME-Sender: <xms:uyZBaW93wX69oM0V62HeaiRFa04MAH622l9nl-tCpFbtMRQZd3aVlA>
    <xme:uyZBaTR7zZ0AR50d-4L08M-29ukGEmKA2qfrrhqjt_tcBDjUlh0_DGkvpS8DtgoVN
    K51LfPJRF3WVZZBzP2WkqoERM3sK7NRnsnjsC1FUPOu6Uo8cJ5_>
X-ME-Received: <xmr:uyZBaQdmxOwUUc6xiUifsk6s2rgjk5mRrHyT85fKin2GUwJFnR5okRm9FWThTfN5_JXt1B03CymNERBPSAdhD_r23A8vmoFoFYuZhR_vdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefleefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgs
    rghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfhhfvg
    hrsehgohhoghhlvgdrtghomhdprhgtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtgho
    mhdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomh
    dprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    sggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:uyZBaVS8MpRpPbSLdvGKesMqUI_QUhyy8ZkaM6Mvjnb0SklqwF8Rtw>
    <xmx:uyZBacJ_W4ByxbNr6eEOLTd3Ii9OW3ZLyW9GXOJKqiG4qbHhVIpqRw>
    <xmx:uyZBaSIpmLd-RRSSpS3pGyEwjwHBy1f4-Q_4gjFZ5NiyywTq8ymEBA>
    <xmx:uyZBaXh41tvXJtlCQ_VrXkRjhIy_5HWipfLYll3p5e6vDxB02m06Dg>
    <xmx:uyZBaTAs2HDXO9Lp5_IljOdQrOnT0tPvlt1Ysx7TOC77od042h2JpNMo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 04:30:34 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 236fef37 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 09:30:32 +0000 (UTC)
Date: Tue, 16 Dec 2025 10:30:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 05/11] transport: convert pre-push to hook API
Message-ID: <aUEmtv09kkEZ2cJ4@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-6-adrian.ratiu@collabora.com>
 <aUETgWJ5DJaEpugO@pks.im>
 <87a4zihjxb.fsf@gentoo.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a4zihjxb.fsf@gentoo.mail-host-address-is-not-set>

On Tue, Dec 16, 2025 at 11:09:52AM +0200, Adrian Ratiu wrote:
> On Tue, 16 Dec 2025, Patrick Steinhardt <ps@pks.im> wrote:
> > On Thu, Dec 04, 2025 at 04:15:29PM +0200, Adrian Ratiu wrote:
> >> diff --git a/transport.c b/transport.c
> >> index c7f06a7382..047f2cefba 100644
> >> --- a/transport.c
> >> +++ b/transport.c
> >> @@ -1316,65 +1316,71 @@ static void die_with_unpushed_submodules(struct string_list *needs_pushing)
> > [snip]
> >> -	if (start_command(&proc)) {
> >> -		finish_command(&proc);
> >> -		return -1;
> >> +	switch (r->status) {
> >> +	case REF_STATUS_REJECT_ALREADY_EXISTS:
> >> +	case REF_STATUS_REJECT_FETCH_FIRST:
> >> +	case REF_STATUS_REJECT_NEEDS_FORCE:
> >> +	case REF_STATUS_REJECT_NODELETE:
> >> +	case REF_STATUS_REJECT_NONFASTFORWARD:
> >> +	case REF_STATUS_REJECT_REMOTE_UPDATED:
> >> +	case REF_STATUS_REJECT_SHALLOW:
> >> +	case REF_STATUS_REJECT_STALE:
> >> +	case REF_STATUS_UPTODATE:
> >> +		return 0; /* skip refs which won't be pushed */
> >> +	default:
> >> +		break;
> >>  	}
> >>  
> >> -	sigchain_push(SIGPIPE, SIG_IGN);
> >> +	if (!r->peer_ref)
> >> +		return 0;
> >>  
> >> -	strbuf_init(&buf, 256);
> >> +	strbuf_reset(&data->buf);
> >> +	strbuf_addf(&data->buf, "%s %s %s %s\n",
> >> +		    r->peer_ref->name, oid_to_hex(&r->new_oid),
> >> +		    r->name, oid_to_hex(&r->old_oid));
> >>  
> >> -	for (r = remote_refs; r; r = r->next) {
> >> -		if (!r->peer_ref) continue;
> >> -		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
> >> -		if (r->status == REF_STATUS_REJECT_STALE) continue;
> >> -		if (r->status == REF_STATUS_REJECT_REMOTE_UPDATED) continue;
> >> -		if (r->status == REF_STATUS_UPTODATE) continue;
> >
> > The new code looks a lot nicer in my opinion. But one thing I wonder
> > about is how these statements translate to the above switch statement.
> > We ignore a lot more `status` values now compared to previously, and
> > the reason for this is never explained.
> >
> > Am I missing anything obvious?
> 
> I thought it was obvious when writing the code :) it might not be.
> 
> The reason is the list was not exhaustive: for refs which we know
> beforehand will not be pushed (status rejected), there is no need to
> feed the pre-push hook stdin. It's saving a few cpu cycles in some
> rejection corner cases, which were missed previously.
> 
> I could:
> 1. Split the extra *_REJECT_* case aditions into a separate commit,
>    highlighting and explaining this better.
> 2. Drop the new cases since they are just a minor improvement in this
>    series, not very important for the series overall.
> 
> Any preference?

I'd personally learn towards (2) unless it is fixing an actual bug that
can be demonstrated. In that case it might make sense to do (1) and
explain why this wasn't an issue until now.

Thanks!

Patrick
