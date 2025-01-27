Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773761DEFE7
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738021695; cv=none; b=AvgpRD6UonaVq77m7dDAsMYpQGqpGuXJBs9TG2rmlp1fVmxxsMSgWQ9EEg+6T2+H8DFE5eZPEMdHTncFa2JTATnBKG7AdQQN4D3VEKfWXUCg2ToPWq1SJZqvphR3L0zAxKVhmyv2lnuLXp/wI4UbJLC0Scu0JLk/3XnIu3xK9+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738021695; c=relaxed/simple;
	bh=8ECAnD6YyuGw7L4gKpnB822l9w4VpaJef3ivMaNUMx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ws2YJOI/6G4GZQk7eMlK3hYJSuDD3um8fAk1T3tC99xb4tHXYChLwA1Dh9ijCs9Kxy5jeBOiFy+08qeHbE9V/E5enRTEdCrreveMMYosxlntowH+AODv2eG0bnHKoK6qbpoU2PeloDY1rwxiLPiZnb3JCWeXVLwWjmMfpLQajWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=f6gx/ENs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VcyPr6mr; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="f6gx/ENs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VcyPr6mr"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00B1B2540205;
	Mon, 27 Jan 2025 18:48:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 27 Jan 2025 18:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738021690; x=1738108090; bh=7pXzSFMRfZ
	JPHAFeZdjLKRDO9IXaJtiKWKwMewkuQnA=; b=f6gx/ENsduK0/tLD2Ha+q2r935
	2laRUTPXFrS/YH/afnpfzUpDjm8bTK/NNKvWoVJjQX2VcLWdLBVLtupL9a1EanWR
	zPw6TrFsn6UqToeX4Ceaex/IkjvBJVYOXynhXyFvp18JMR7PJj4L6MeSMCiIunZk
	L5YUz0IyD2GkoBq8ZEf7wHNeagvvWlk88zuRl8aRdm0mn2u6Hbtny0n5n/fud4Lz
	4ECFUhPMW4TYfxou7xzfCiISqPiOviywCGDEJdthVmzLc3qtMbdgp+IohRxqUKGf
	V40Jj07wdzae8rCN+a7B26tz6aPvyE3nT1+6awjf8tpytFSgxUTeUlI55WXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738021690; x=1738108090; bh=7pXzSFMRfZJPHAFeZdjLKRDO9IXaJtiKWKw
	MewkuQnA=; b=VcyPr6mrNyMDmlfZ62ozG+v2zm0rfKt+jk4oNmxpwkCiev1euDD
	HL7YtvWAOeDpzSScXgpUuvFfMOCpe7s++J02noNjkyWO9UmaWlBp7OtLY8sApiYK
	GzKrMP8DJaPoXmGBV/kFQbGzCSmlpHqmxa3AViIwRHBKbYAGsokdQ16lrwAJogQj
	jRehltz/aeQFyGEH1MPzcj67BZV1WDBdqFwgKIeIvqLcuPr+aOlr2hobaqUCT2BL
	TBP6idm+RhwwE7+NGsf8LXGM+LFnTHBxaXK/yD7V+D1ezOOqqf1sLkhYKTlCZIlz
	9Bw+vukY8Zmfieti/3GEJFLYtC8LC3ODAbw==
X-ME-Sender: <xms:OhuYZz-a4H57BGWLTQmGfkAP6Fsy6nwtAnIuIUgjsga3FCEG-vB7nw>
    <xme:OhuYZ_tiQOy1GOVgSOeE8y5xeWr75OgQLWXbDWu-0syHLSfHtFkXCexQfbuGJAVJg
    ZZIYsxBRI1bAfxb-Q>
X-ME-Received: <xmr:OhuYZxD_G1FOaPAV522EqFMFE6Uzcb5n_f0pxgdCeB8qJnSsRgXmKCvpxFAtDKiz6EUv5123AaRuCpT6HesQg0G2P5dhEixuDevg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudegheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsth
    hirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtth
    hopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepshhunhhshhhinhgvsehs
    uhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhes
    fhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtoheprhhssggvtghkvghrsehnvgigsghr
    ihgughgvrdgtohhm
X-ME-Proxy: <xmx:OhuYZ_dlt_cou0n7u5QKmhrsONEWyyZcq528Q3cZJfMqL7hqtGOuRw>
    <xmx:OhuYZ4MYqqwHSPDwFD7NgCN7iimmtP5TkD_91zYplJurXRn6e6jcXQ>
    <xmx:OhuYZxm-HAoXO8Wf5ztQqO_W7aeEk4SQHgBSZunvg5u8FxaoXO4wVA>
    <xmx:OhuYZyv4sIDBohLthKZAU3BA8UN8YdWwlTQX0iL6NgE0qKOeaVVBRw>
    <xmx:OhuYZxmJsowHsM-4qsGsFZGeMEUizrJOPuevLLfPuBIWuCKoa29B1t3h>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 18:48:09 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Karthik
 Nayak <karthik.188@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>,  "Randall S . Becker"
 <rsbecker@nexbridge.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 5/6] promisor-remote: check advertised name or URL
In-Reply-To: <20250127151701.2321341-6-christian.couder@gmail.com> (Christian
	Couder's message of "Mon, 27 Jan 2025 16:17:00 +0100")
References: <20241206124248.160494-1-christian.couder@gmail.com>
	<20250127151701.2321341-1-christian.couder@gmail.com>
	<20250127151701.2321341-6-christian.couder@gmail.com>
Date: Mon, 27 Jan 2025 15:48:08 -0800
Message-ID: <xmqqa5bbq0nb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A previous commit introduced a "promisor.acceptFromServer" configuration
> variable with only "None" or "All" as valid values.
>
> Let's introduce "KnownName" and "KnownUrl" as valid values for this
> configuration option to give more choice to a client about which
> promisor remotes it might accept among those that the server advertised.

OK.

>  promisor.acceptFromServer::
>  	If set to "all", a client will accept all the promisor remotes
>  	a server might advertise using the "promisor-remote"
> -	capability. Default is "none", which means no promisor remote
> -	advertised by a server will be accepted. By accepting a
> -	promisor remote, the client agrees that the server might omit
> -	objects that are lazily fetchable from this promisor remote
> -	from its responses to "fetch" and "clone" requests from the
> -	client. See linkgit:gitprotocol-v2[5].
> +	capability. If set to "knownName" the client will accept
> +	promisor remotes which are already configured on the client
> +	and have the same name as those advertised by the client. This
> +	is not very secure, but could be used in a corporate setup
> +	where servers and clients are trusted to not switch name and
> +	URLs.

I wonder if the reader needs to be told a bit more about the
security argument here.  I imagine that the attack vector behind the
use of "secure" in the above paragraph is for a malicious server
that guesses a promisor remote name the client already uses, which
has a different URL from what the client expects to be associated
with the name, thereby such an acceptance means that the URL used in
future fetches would be replaced without the user's consent.  Being
able to silently repoint the remote.origin.url at an evil repository
you control is indeed a powerful thing, I would guess.  Of course,
in a corp environment, such a mechanism to drive the clients to a
new repository after upgrading or migrating may be extremely handy.

Or does the above paragraph assumes some other attack vectors,
perhaps?

> +	If set to "knownUrl", the client will accept promisor
> +	remotes which have both the same name and the same URL
> +	configured on the client as the name and URL advertised by the
> +	server. This is more secure than "all" or "knownUrl", so it
> +	should be used if possible instead of those options. Default
> +	is "none", which means no promisor remote advertised by a
> +	server will be accepted.

OK.

> diff --git a/promisor-remote.c b/promisor-remote.c
> index 5ac282ed27..790a96aa19 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -370,30 +370,73 @@ char *promisor_remote_info(struct repository *repo)
>  	return strbuf_detach(&sb, NULL);
>  }
>  
> +/*
> + * Find first index of 'vec' where there is 'val'. 'val' is compared
> + * case insensively to the strings in 'vec'. If not found 'vec->nr' is
> + * returned.
> + */
> +static size_t strvec_find_index(struct strvec *vec, const char *val)
> +{
> +	for (size_t i = 0; i < vec->nr; i++)
> +		if (!strcasecmp(vec->v[i], val))
> +			return i;
> +	return vec->nr;
> +}

Hmph, without the hardcoded strcasecmp(), strvec_find() might make a
fine public API in <strvec.h>.  

Unless we intend to create a generic function that qualifies as a
part of the public strvec API, we shouldn't call it strvec_anything.
This is a great helper that finds a matching remote nickname from
list of remote nicknames, so

    remote_nick_find(struct strvec *nicks, const char *nick)

may be more appropriate.  When we lift it out of here and make it
more generic to move it to strvec.[ch], perhaps 

	size_t strvec_find(struct strvec *vec, void *needle,
		 int (*match)(const char *, void *)) {
		for (size_t ix = 0; ix < vec->nr, ix++)
			if (match(vec->v[ix], needle))
				return ix;
		return vec->nr;
	}

which will be used to rewrite remote_nick_find() like so:

	static int nicks_match(const char *nick, void *needle)
	{
		return !strcasecmp(nick, (conat char *)needle);
	}

	remote_hick_find(struct strvec *nicks, const char *nick)
	{
		return strvec_find(nicks, nick, nicks_match);
	}

it would be better to use a more generic parameter name "vec", but
until then, it is better to be more specific and explicit about the
reason why the immediate callers call the function for, which is
where my "nicks" vs "nick" comes from (it is OK to call the latter
"needle", though).

>  enum accept_promisor {
>  	ACCEPT_NONE = 0,
> +	ACCEPT_KNOWN_URL,
> +	ACCEPT_KNOWN_NAME,
>  	ACCEPT_ALL
>  };
>  
>  static int should_accept_remote(enum accept_promisor accept,
> -				const char *remote_name UNUSED,
> -				const char *remote_url UNUSED)
> +				const char *remote_name, const char *remote_url,
> +				struct strvec *names, struct strvec *urls)
>  {
> +	size_t i;
> +
>  	if (accept == ACCEPT_ALL)
>  		return 1;
>  
> -	BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
> +	i = strvec_find_index(names, remote_name);
> +
> +	if (i >= names->nr)
> +		/* We don't know about that remote */
> +		return 0;

OK.

> +	if (accept == ACCEPT_KNOWN_NAME)
> +		return 1;
> +
> +	if (accept != ACCEPT_KNOWN_URL)
> +		BUG("Unhandled 'enum accept_promisor' value '%d'", accept);

I can see why this defensiveness may be a good idea than not having
any, but I wonder if we can take advantage of compile time checks
some compilers have to ensure that case arms in a switch statement
are exhausitive?

> +	if (!strcasecmp(urls->v[i], remote_url))
> +		return 1;

This is iffy.  The <schema>://<host>/ part might want to be compared
case insensitively, but the rest of the URL is generally case
sensitive (unless the material served is stored on a machine with
case-insensitive filesystem)?

Given that the existing URL must have come by either cloning from
this server or another related server or by an earlier
acceptFromServer behaviour, I do not see a need for being extra lax
here.  We should be more careful about our use of case-insensitive
comparison, and I do not see how this URL comparison could be
something the end users would expect to be done case insensitively.

> -static void filter_promisor_remote(struct strvec *accepted, const char *info)
> +static void filter_promisor_remote(struct repository *repo,
> +				   struct strvec *accepted,
> +				   const char *info)
>  {
>  	struct strbuf **remotes;
>  	const char *accept_str;
>  	enum accept_promisor accept = ACCEPT_NONE;
> +	struct strvec names = STRVEC_INIT;
> +	struct strvec urls = STRVEC_INIT;
>  
>  	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
>  		if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))

Not a fault of this step, but is it sensible to even expect
!accept_str in an error case?  *accept_str could be NUL, but
accept_str be either left uninitialized (because this caller does
not initialize it) when the get_string_tmp() returns non-zero, or
points at the internal cached value in the config_set if it returns
0 (and the control comes into this block).

>  			accept = ACCEPT_NONE;
> +		else if (!strcasecmp("KnownUrl", accept_str))
> +			accept = ACCEPT_KNOWN_URL;
> +		else if (!strcasecmp("KnownName", accept_str))
> +			accept = ACCEPT_KNOWN_NAME;
>  		else if (!strcasecmp("All", accept_str))
>  			accept = ACCEPT_ALL;
>  		else

Ditto about icase for all of the above.

> +test_expect_success "clone with 'KnownUrl' and different remote urls" '
> +	ln -s server2 serverTwo &&
> +
> +	git -C server config promisor.advertise true &&
> +
> +	# Clone from server to create a client
> +	GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
> +		-c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
> +		-c remote.server2.url="file://$(pwd)/serverTwo" \
> +		-c promisor.acceptfromserver=KnownUrl \
> +		--no-local --filter="blob:limit=5k" server client &&
> +	test_when_finished "rm -rf client" &&
> +
> +	# Check that the largest object is not missing on the server
> +	check_missing_objects server 0 "" &&
> +
> +	# Reinitialize server so that the largest object is missing again
> +	initialize_server 1 "$oid"
> +'

Nice ;-)

Here, I also notice that we are not testing that serverTwo and
servertwo are considered the same thanks to the use of icase
comparison.  We shouldn't compare URLs with strcasecmp().

Thanks.
