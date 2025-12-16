Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65AB34E755
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765896566; cv=none; b=s6qDJii7Fr+ZwQ9fiD+p1N99FVv3k34stiHfXJKjnKjip5ZdOjLWK7bU6P0eaF5acKACCzeUsxbffDyR47JQLYGrwnnhPFVUJGfbszdgaeOr9rmBsnryekjsBBQVfqo8f90Lo7w1tftcRb+SbHl8ySQmbTvuPfUEMx64D6Eru1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765896566; c=relaxed/simple;
	bh=zKE9B70qgbQBIs3PzY3HFBhZTCLk/rAmgHJ3L4pWZlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0rT26Y0W7UpwRMtdR7B/BaBnyr6hplST2CddGQ+tyFiUJFrkoviKBWc5zDoeCkNUfOaflToHBf3718i2t8MNcE4QCjob3w1Yki5crWWXWwLbCabEdrcvQoKdEJkg/J5fBC+11HBBPKD0suPvJl9rqlbBJvjinCNr7xlShoFEdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=s1P00dR6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DrKSTTe1; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="s1P00dR6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DrKSTTe1"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id AF037EC0219;
	Tue, 16 Dec 2025 09:49:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 16 Dec 2025 09:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765896562; x=1765982962; bh=4vl7odJsUb
	fvScOOmjf3Mt9apV3QDlraFIXy4YnwLbk=; b=s1P00dR6aOhGCbuqMmSdDolY3z
	EIExBIXUzqwtaqnOejv1yOjhIkSUERYckFY6sptcbW82t2byvBMauFa/L7d8Z44T
	SLO/86gD9D8p2l8gsb5vvR/X6CXHmaOlAuNzougSCJt+OeIN9FnfqN5hNi0lPtF3
	PzOLaDabffNrZkNKQNGpe76Ad9/WZb+8hqen8YMLzRq2XJ+SShwAS46KQZVLSJBB
	yQTZyFToxN3GhmdixxrGiVTdn94ZTeEs04qdbEKzXRKZm4oO2QefppYCoVRLqxK1
	4V7mjfmsxzFpE4oCMQz7dkIKtgNCKX/LEeyptv6x5vZg7Cv3aFV9gWG/KsgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765896562; x=1765982962; bh=4vl7odJsUbfvScOOmjf3Mt9apV3QDlraFIX
	y4YnwLbk=; b=DrKSTTe1zQVfesv5B1akktfxISAH0eCIUUvckFlXg4FIZ/ku8Rw
	dws72H47PDyC3gJxLrM1/djGG3PewGOG5PTnytrkDgVEVgpBhCqXY5BIaSO9oMPi
	C1OKrrgamu5uuwycPX0+M7FqtlhQ8inkLtUQDQhWufvPti9ubw09IREnPxoE0AyQ
	DJixvoNARBq2Mtyo4X7/vA0XBmGLosw8o9Adj+aMB/fVVFslBiN0ENceCqKnmmzK
	2sPDhA+jRpsqtnaXX64EjY1M6Y+dTUUnRmlPs9XsrtFjfWAxIBrVPeSSGNSheFqd
	P/H/xadABVVjYCgl3/oHlNJnSRsRlTVMBOQ==
X-ME-Sender: <xms:cnFBac3m3lDclY-ApdInsBbzj7QzYX0RdvBknmNvRSDiwF88yWv4hw>
    <xme:cnFBaehqEu_RnTasPQDpOArr4AUeD3a0wDBUbZjEk1yh4FOhw2b2lUcz90KsqoTfI
    P-Z4zkxmsO1LeFiMPHKo3kJnXyzw6cqlBC18XvPFfmOyHQoMKZ44g>
X-ME-Received: <xmr:cnFBaST9QUmhZUJumRaU9-Lt_jF_nuY93FKPq5DkjkE0ajuXNznfVcsbEWN9NKZtyfZ_IfUQiFercBscFka5y60qNGBGewStLqASFNfSBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefleeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    gh
X-ME-Proxy: <xmx:cnFBafijgfjtWAN_1KrVR50aZ7RfmvbyScWVbYAzjt0Nkng66seApw>
    <xmx:cnFBaS4chetlisqeXh8uTddHreT-wEiddPSLLDgRh2_5f5XdprwaFQ>
    <xmx:cnFBacDU98dL9uU4nEtu0elju78WnxQqu-XqKy1xASVw5BH1XbTPmw>
    <xmx:cnFBaZYffdxVi22vzuHKs1LmoN-XJRr5IO7a5z7MDDnVB8ZBXxerPA>
    <xmx:cnFBaSjHc1z03j9xIjAl3C1wrhXpByUMx77lfbkEeMzd7sejNxD07N41>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 09:49:21 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7adbc4c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 14:49:20 +0000 (UTC)
Date: Tue, 16 Dec 2025 15:49:16 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] docs: clarify git-rev-list(1) --filter behavior
Message-ID: <aUFxbDPucKr42fIJ@pks.im>
References: <20251215200512.2694155-1-jltobler@gmail.com>
 <xmqqwm2n5ivh.fsf@gitster.g>
 <aUEUfQDJyPf6Mhtw@pks.im>
 <xnstt6myzzfyq65w73xuqg7cfso3bdw6tw33shrery4e4gi2zy@pfxq2pjmb2hm>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xnstt6myzzfyq65w73xuqg7cfso3bdw6tw33shrery4e4gi2zy@pfxq2pjmb2hm>

On Tue, Dec 16, 2025 at 08:36:56AM -0600, Justin Tobler wrote:
> On 25/12/16 09:12AM, Patrick Steinhardt wrote:
> > On Tue, Dec 16, 2025 at 10:13:22AM +0900, Junio C Hamano wrote:
> > > > diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> > > > index d9665d82c8..453ec59057 100644
> > > > --- a/Documentation/rev-list-options.adoc
> > > > +++ b/Documentation/rev-list-options.adoc
> > > > @@ -983,7 +983,9 @@ to name units in KiB, MiB, or GiB.  For example, `blob:limit=1k`
> > > >  is the same as 'blob:limit=1024'.
> > > >  +
> > > >  The form `--filter=object:type=(tag|commit|tree|blob)` omits all objects
> > > > -which are not of the requested type.
> > > > +which are not of the requested type. Note that explicitly provided objects
> > > > +ignore filters and are always printed unless `--filter-provided-objects` is
> > > > +also specified.
> > > 
> > > The above documents the status quo correctly, so let's queue, but it
> > > is unfortunate that we need an extra option to do this.
> > 
> > True. I didn't feel comfortable to change the default to also filter
> > provided objects when I discovered that we don't, hence the new option.
> > It's not great though as it certainly is surprising behaviour, but I'm
> > not sure whether we can really change it without breaking existing
> > users. Oh, well...
> 
> Out of curiousity, are there any known use-cases where a user _would_
> want the provided objects printed along with the filtered ones? From my
> naive perspective it almost doesn't even sound useful and appears to
> just be a sharp edge. This maybe not worthing worrying too much about
> though.

I don't really have an idea, but that's exactly the problem here.
Filters are for example used by partial clones, and I don't want to
break those because I'm not aware of some of the intricacies. Which
doesn't mean that there _are_ use cases where this is actually the
desired behaviour, but rather that there needs to be some research to
come to a conclusion here.

Patrick
