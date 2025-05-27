Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A931FDA
	for <git@vger.kernel.org>; Tue, 27 May 2025 07:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748332269; cv=none; b=Yg5DYx78jU2jqnPF5FgNGd4DvGtr6UXpNC+gtdl/AdBp9EwAFYnXPjRZWhe3d4v1H3XtlgYsXmScM19MDvSK1EIn1+clk8B39D8GtDdGEpIse6wnWQC9Npc86vcFtyFkIQDxD7B5gVWVRbGYE63fiGf4tWqB9cceU4KercET0ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748332269; c=relaxed/simple;
	bh=HoD59KBbWvrcyUHNfV3S3E6JZ0mrK/ksVPtqYzkbTWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFN0vOtCSw5NF997RvCUrJl9oJIqcpMXErRbsWAu57rW+kfpFgHf0Fz2OUXdRO36ePU0ZLT1JRuDEcfpsFaeIYGCU/jACMEvqNCULzDhec9cP9W9kT5ghB0EdkaG5hVdk4V4w9VgVOlMIokzniI3fH4ZNjdFkLtBR/ymh2L6xVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=r5ffamRR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FIFnIQi6; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="r5ffamRR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FIFnIQi6"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 1176D1140102;
	Tue, 27 May 2025 03:51:05 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 03:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748332264;
	 x=1748418664; bh=oedWvuzCUjLQfMvPvM9Fs8rC2spCI1sW/QhKF7r3WLg=; b=
	r5ffamRRtJW8uw5f3biq8x7UvEu9hDc1cacDvIvPnyFjoVl0WNRuvEw1FFBLKtGj
	SI2ttIVJZEQGS4c4YDVsOIN237iXlsdd/rdCBudhcPv0OizwhdJ5Fj8wwSUqzJPj
	0efdA7psMgSSp1tMx0r/tp6XFRr2OTh+e7OVvVTifTqr9wpdr6Ubkt3/eaM9sBKp
	exFasqEW3kZU4+Kl+mBletVvg/NgJyJ3FFkqb0T4AiQR1c8kYx+MSSkDTBPIWH+Y
	DLouWQIUQ7Ntgd2Z26cUJEArK9SwUuFKLFMPqKMa/pg58cSuMFlTwuXUKOkyEr1d
	vQUA3pS6jPUaqWO1jhI1ZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748332264; x=
	1748418664; bh=oedWvuzCUjLQfMvPvM9Fs8rC2spCI1sW/QhKF7r3WLg=; b=F
	IFnIQi6BqerdyjwuvgYFE78Txos/7JDEnupMuEzYFDlgiI3+/D04W18nW+MufMo0
	MnhaNp589k//8L0mlOexWKD08LjYv0tKIfrY6napFYgwJzuDmsfokF5a6/Fwi7Jf
	wfd5BFIzMTX1OVNqvdkJ9U/Ww5AIZTSMjLFCSttpY3oH8n8kma5myeQq8ooE0r4F
	nlzpqLb8j2X/N7+a58qDwgFbBXSv+TKX3vKEaZxRvzWrTnCtLC0mzt4H9aVveqCD
	O00DQeSP1G2S8B0fDEAncCGqig1oX4YlnNt1CxaFLwyT8jpXVxCvDT/OoUPNmElj
	p5KfCqGy/VZ6k6RIbzXcw==
X-ME-Sender: <xms:6G41aIzG35xYQlfo4Y8sHd-kX7ajIShM08tl5LD5RS-RPk00kgDBSQ>
    <xme:6G41aMRtr5B0xRfckOu2ls6asMOYpu5Md8MfpiQiCdBGn54L-_Irm8S8W_bn82_Jh
    L9niv6_CmDrW_7mxg>
X-ME-Received: <xmr:6G41aKUsYFe68DtcJu1N84Zn0C-ItGh8D-XamOPaCDvhO9aLOX2YIBW-EU0DNMZTbW7PDeP7_qejD8duMlhQ0sQP9lrOBbJBS-nBzpjy4HWzkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleekfeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhf
    gggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleeh
    ieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    tghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmh
    gvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:6G41aGisDh_VM1OqVgZC7cJ_i8O8TMaCgH4IDtsZewmqxIXanLu3cg>
    <xmx:6G41aKCcSMRz4PJ9NX_sDOGkG-eBVRuE1yjgc5E8CFQqGAib7arP3w>
    <xmx:6G41aHIMCXQGBRLl6qexOE6T510AWIXS1A_Ml134HXmQhlsOHrTh6g>
    <xmx:6G41aBBKvlC8E7wFSsS7eywkxf2N9eY8mEFeYMYUdP4e3iwl7oIdrg>
    <xmx:6G41aElfIs669o72DAQ3-dlMvIFvwo8OidI7LcEzOnGLNJysHTIzdj4y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 03:51:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 675b6eaf (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 07:51:01 +0000 (UTC)
Date: Tue, 27 May 2025 09:50:56 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/3] promisor-remote: allow a server to advertise more
 fields
Message-ID: <aDVu4JmTU7Wz32Z7@pks.im>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com>
 <20250429145243.992252-3-christian.couder@gmail.com>
 <aBsZBytP6TzMYCxl@pks.im>
 <CAP8UFD1+c11JgSKzs=A39-5EP2Senob-NxSXB7orU0usSLT83A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1+c11JgSKzs=A39-5EP2Senob-NxSXB7orU0usSLT83A@mail.gmail.com>

On Mon, May 19, 2025 at 04:11:18PM +0200, Christian Couder wrote:
> On Wed, May 7, 2025 at 10:25 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > On Tue, Apr 29, 2025 at 04:52:42PM +0200, Christian Couder wrote:
> > > diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> > > index 2638b01f83..71311b70c8 100644
> > > --- a/Documentation/config/promisor.adoc
> > > +++ b/Documentation/config/promisor.adoc
> > > @@ -9,6 +9,24 @@ promisor.advertise::
> > >       "false", which means the "promisor-remote" capability is not
> > >       advertised.
> > >
> > > +promisor.sendFields::
> > > +     A comma or space separated list of additional remote related
> > > +     fields that a server will send while advertising its promisor
> > > +     remotes using the "promisor-remote" capability, see
> > > +     linkgit:gitprotocol-v2[5]. Currently, only the
> > > +     "partialCloneFilter" and "token" fields are supported. The
> > > +     "partialCloneFilter" field contains the partial clone filter
> > > +     used for the remote, and the "token" field contains an
> > > +     authentication token for the remote.
> > > ++
> >
> > Should we maybe convert this into a list of accepted fields? Makes it
> > easier to extend going forward.
> 
> I am not sure I understand what you mean. This promisor.sendFields
> config variable is for the server side which advertises remotes. The
> server advertises its remotes (if it wants to) before receiving
> information from the client, so it cannot know what the client
> accepts.

In the current form you need to reflow this whole paragraph every time a
new field is supported, and it's easy to miss the exact supported
fields. So my idea was to maybe move the supported fields into a
bulleted list. E.g.:

    promisor.sendFields::
         A comma or space separated list of additional remote related
         fields that a server will send while advertising its promisor
         remotes using the "promisor-remote" capability, see
         linkgit:gitprotocol-v2[5]. The following fields are supported:
    +
    * "partialCloneFilter": contains the partial clone filter used for
      the remote.
    * "token": contains the authentication token for the remote.

> > Furthermore, should we maybe refactor this to match the restrictive
> > design where valid fields are explicitly specified? In other words,
> > should we have separate config keys for each of the accepted fields now?
> 
> Maybe I don't understand what you mean with "accepted fields".

I think I had a misunderstanding on my side. I didn't get that this is
only configuring field _names_ that we'll end up sending to the remote
side. So I thought that the user is expected to configure name-value
pairs here that are then sent to the client, not only the name.

I guess this is mostly because the config documentation talks about
"fields", but that term is used elsewhere to indicate a name-value pair.

> > Also, shouldn't this setting be per promisor remote that we want to
> > advertise? I expect that servers will want to send different partial
> > clone filters for each of the advertised remotes, and they may also want
> > to send different tokens. So it seems a bit too inflexible to only have
> > a single, global "sendFields" configuration that covers all promisors.
> 
> First this setting already allows servers to send different partial
> clone filters for each of the advertised remotes. For each remote it
> advertises, a server would send the partial clone filter that is
> already configured for this remote on the server. Same for tokens.
> 
> Also we can extend this setting to be per promisor remote later if
> there is a need for it. I don't think it would be difficult to do. And
> I don't think it's necessary right now, because it's likely that for
> simplicity most servers will manage all their promisor remotes in the
> same way (at least until usage of promisor remotes grows a lot).

Yeah, with my fixed understanding I agree that it's not necessary to
configure this per remote as of now.

[snip]
> > Does
> > it mean that this promisor remote should only be used in case we do have
> > the exact same filter passed to git-clone(1)?
> 
> It's up to the client to decide, but yeah it will likely work better
> if the same filter is used. It should still work if a different filter
> is used though. In case the promisor remote doesn't have an object,
> there should be a fallback to ask the main server for that object.
> 
> Also the filter mechanism already exists for a long time and this
> series doesn't change how it works. It's already possible to have
> different repos using the same promisor remote with different filters.
> So documentation about what happens when they do that should not be
> specific to this patch series.

That's fair enough, but spelling this out somewhere and drawing the
bigger picture helps the reviewer understand the vision that you've got
here.

Patrick
