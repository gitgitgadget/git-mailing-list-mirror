Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07709221730
	for <git@vger.kernel.org>; Wed,  7 May 2025 08:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746606350; cv=none; b=LupNFEG4yTadMSXUOGCLNKnmN1zsiPLSYKKpPrmwE5yQE5aoyYAQfONSakQjXA0VkIOGcTDKWtWAntoZTOAS6GaIKbeewZIfXgcnreCj1AUt/TbJwnVvHFGlrc4UrVrT5QsyLLFECAQ9xC6ObQ4STvDz9bEoHdeoORtCatxbl1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746606350; c=relaxed/simple;
	bh=13f+rj+OUPprxIC1btD9S3irmFN6z8BIgFly7qFWKUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0OFLBxZHX/MZgsZDEIeCw2ZIp5yjG+H0ABhyzv8DP+f1tmyPFRi2NuwHZ65rWud+tmGw6O4KNZayqZxZPK7d60vkUrkJjXTltAe+3ATO7Rly481VE60PiloCR486Uwko3jTIYwmwoU0B+J85+qv5mvxHJ21aRfOBX6H7iLeJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vEdjRYs7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P2lVIRm6; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vEdjRYs7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P2lVIRm6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DC29C2540193;
	Wed,  7 May 2025 04:25:46 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 07 May 2025 04:25:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746606346; x=1746692746; bh=dlRz+kANiH
	e+uBG6bipxawdtoSeiRtOajavNMOb+6Ro=; b=vEdjRYs7PEBCgL7gnAPdaVqcfW
	YCJxKnssY4AF2WvuLwiWTaIgKip1JfgcFHvDF7Qn+ImobDcTBiVxti0llh+w8w3m
	65hYIbbndEEalXg7+OBzIErfWN2ctEOvQoWQFprGONISittY1NxFThm3FbWgJoBR
	XT31V7SULF6dbi//lBnCaJjFqJ8I9i9BCCVuyVQI+QLWhXcqutHSlW86eHixxDpk
	+RlLXL2UhSCP0MC5ppKE4VbR0IGxPpuV5dzNEXsQ/O6LHkW3BLjqsU8b6Fe1n0UW
	sEl9WXHYiHnErITN2QrA1ChP16MlvFgnFINPbuG1m10nKCkfOT8S7Bz9TBpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746606346; x=1746692746; bh=dlRz+kANiHe+uBG6bipxawdtoSeiRtOajav
	NMOb+6Ro=; b=P2lVIRm6EwCN3ou8qPz8elGd/qWHg4jKEVevybHPvmFiKZ0eJI2
	lxzLB1OMq9Mh2H8Gu2Y/cXt0amykFgi+j8Z/dZLrYh9uizk6x/iR3hUMzu8Ek/kz
	anqWNArFaDUK+pCgI7ZdMLjGH2PUW2gnopfCf6wl57qRrHkp7UE79//f/+HFQRv/
	np8/0wu1+WOQWIz5EnL7+JpCM7FSLQs203YAeFnt/LXgZWhS2zueOUz8XvVgJscw
	i7nqydVR/eAgaRdOlOtWPd8fQmV4EaRvNBh8g9RrlqlBoBhDem3g6mxZVsYFSTTa
	YMlXxR5iZrN4nX+ZAjXx8wUva/xNFJjwiFA==
X-ME-Sender: <xms:ChkbaI7uzr2tb0bpRrEIEWKYgxtLaw1ekDdhNs2s98jzE5l8vkzrkg>
    <xme:ChkbaJ5CTRLuRmLGpax2QWQNYYZKobO_Xh7UKmEzzO_WgysuPnv4olwRTCwdc4KlH
    nR2EuHoZT4p3kYYxA>
X-ME-Received: <xmr:ChkbaHepx5nU00J3ESEDYj5SfXr2rgMiWrpyXT4UtM4kMDJGhIVx570HedIBTEqP2mUgRKIVyiPDvqw2IEGKuyNbWAif-oUnzFDvKgdA8B87jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeeifeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrh
    hishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:ChkbaNJ924wJCS7zBGdcvdbpjB0ZO0_9Yt9v9RTdYtBwsghjHAVYRg>
    <xmx:ChkbaMICW4JTB7sA2Cjij5owd9NYbPhHkZuh5FGChcK3S_p1vzSDqQ>
    <xmx:ChkbaOwU-YxPqse18O35KPkEINTrZrtWGBn7W-qROUEqc7iKYSsQ7w>
    <xmx:ChkbaAKCBzMUoe_-lNMbjkBjEugJyOL8vQ78h77oXU6-UJ63XbVBhQ>
    <xmx:ChkbaIvpVQDPhdGlr7cNMRD6-HdZum9UqEFUKaFR4He0ICzcj-AaSJpq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 04:25:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57796597 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 7 May 2025 08:25:41 +0000 (UTC)
Date: Wed, 7 May 2025 10:25:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 2/3] promisor-remote: allow a server to advertise more
 fields
Message-ID: <aBsZBytP6TzMYCxl@pks.im>
References: <20250414160343.2216312-1-christian.couder@gmail.com>
 <20250429145243.992252-1-christian.couder@gmail.com>
 <20250429145243.992252-3-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429145243.992252-3-christian.couder@gmail.com>

On Tue, Apr 29, 2025 at 04:52:42PM +0200, Christian Couder wrote:
> diff --git a/Documentation/config/promisor.adoc b/Documentation/config/promisor.adoc
> index 2638b01f83..71311b70c8 100644
> --- a/Documentation/config/promisor.adoc
> +++ b/Documentation/config/promisor.adoc
> @@ -9,6 +9,24 @@ promisor.advertise::
>  	"false", which means the "promisor-remote" capability is not
>  	advertised.
>  
> +promisor.sendFields::
> +	A comma or space separated list of additional remote related
> +	fields that a server will send while advertising its promisor
> +	remotes using the "promisor-remote" capability, see
> +	linkgit:gitprotocol-v2[5]. Currently, only the
> +	"partialCloneFilter" and "token" fields are supported. The
> +	"partialCloneFilter" field contains the partial clone filter
> +	used for the remote, and the "token" field contains an
> +	authentication token for the remote.
> ++

Should we maybe convert this into a list of accepted fields? Makes it
easier to extend going forward.

Furthermore, should we maybe refactor this to match the restrictive
design where valid fields are explicitly specified? In other words,
should we have separate config keys for each of the accepted fields now?

Also, shouldn't this setting be per promisor remote that we want to
advertise? I expect that servers will want to send different partial
clone filters for each of the advertised remotes, and they may also want
to send different tokens. So it seems a bit too inflexible to only have
a single, global "sendFields" configuration that covers all promisors.

> diff --git a/Documentation/gitprotocol-v2.adoc b/Documentation/gitprotocol-v2.adoc
> index 5598c93e67..b4648a7ce6 100644
> --- a/Documentation/gitprotocol-v2.adoc
> +++ b/Documentation/gitprotocol-v2.adoc
> @@ -785,33 +785,52 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>  
> -promisor-remote=<pr-infos>
> +promisor-remote=<pr-info>
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
>  The server may advertise some promisor remotes it is using or knows
>  about to a client which may want to use them as its promisor remotes,
> -instead of this repository. In this case <pr-infos> should be of the
> +instead of this repository. In this case <pr-info> should be of the
>  form:
>  
> -	pr-infos = pr-info | pr-infos ";" pr-info
> +	pr-info = pr-fields | pr-info ";" pr-info
>  
> -	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
> +	pr-fields = fld-name "=" fld-value | pr-fields "," pr-fields

Tiny nit, but can we maybe spell out "fld" fully? It doesn't buy us that
much to abbreviate "field", and it did cause my reading to trip.

> -where `pr-name` is the urlencoded name of a promisor remote, and
> -`pr-url` the urlencoded URL of that promisor remote.
> +where all the `fld-name` and `fld-value` in a given `pr-fields` are
> +field names and values related to a single promisor remote.
>  
> -In this case, if the client decides to use one or more promisor
> -remotes the server advertised, it can reply with
> -"promisor-remote=<pr-names>" where <pr-names> should be of the form:
> +The server MUST advertise at least the "name" and "url" field names
> +along with the associated field values, which are the name of a valid
> +remote and its URL, in each `pr-fields`.
>  
> -	pr-names = pr-name | pr-names ";" pr-name
> +The server MAY advertise the following optional fields:
> +
> +- "partialCloneFilter": Filter used for partial clone, corresponding
> +  to the "remote.<name>.partialCloneFilter" config setting.
> +- "token": Authentication token for the remote, corresponding
> +  to the "remote.<name>.token" config setting.

I think we should define semantics of these fields more closely. What
exactly is the consequence of a partial clone filter being defined? Does
it mean that this promisor remote should only be used in case we do have
the exact same filter passed to git-clone(1)? Does it mean that the
remote only contains objects that would've been filtered _out_ by such a
filter?

Furthermore, we should specify how the token is supposed to be passed to
the remote.

> +No other fields are defined by the protocol at this time. Clients SHOULD
> +ignore fields they don't recognize to allow for future protocol extensions.

Shouldn't we require clients to ignore unknown fields? Otherwise, if
it's only optional to ignore them, we still can't introduce new fields
in the future without breaking existing clients that chose to ignore
this guidance.

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 24d0e70132..70abec4c24 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -314,6 +314,84 @@ static int allow_unsanitized(char ch)
>  	return ch > 32 && ch < 127;
>  }
>  
> +/*
> + * List of field names allowed to be used in the "promisor-remote"
> + * protocol capability. Each field should correspond to a configurable
> + * property of a remote that can be relevant for the client.
> + */
> +static const char *allowed_fields[] = {
> +	"partialCloneFilter", /* Filter used for partial clone */
> +	"token",              /* Authentication token for the remote */
> +	NULL
> +};
> +
> +/*
> + * Check if 'field' is in the list of allowed field names for the
> + * "promisor-remote" protocol capability.
> + */
> +static int is_allowed_field(const char *field)
> +{
> +	const char **p;
> +
> +	for (p = allowed_fields; *p; p++)
> +		if (!strcasecmp(*p, field))
> +			return 1;
> +	return 0;
> +}

Nit: it is a bit funny that we talk about allowed fields here, but
the recommendation is to just ignore unknown fields. So maybe this
should instead be called "known_fields".

Patrick
