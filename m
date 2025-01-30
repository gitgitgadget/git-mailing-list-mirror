Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7952F20318
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738234282; cv=none; b=GLToy4LC2MPceV5uQ9+rZIHifGut/hkMdxh2r7nDXkCcAxGngYiBrLoimcphC5ZG9yCpSqnTgNbYUUJ+Ggc0e0HC+H6wqJpZTJ0XMabyh+vE7I9IkaSwWw5X9g5T0M600OjuXj8vJiIpPMj1Jlepte63FwstoSw18mlmeAYJaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738234282; c=relaxed/simple;
	bh=nLyLid4wrj0zk6nthqnZkSYrimCK+hkNUvxSi2GNVH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U7Bq+TMbSi6J7DGfMXOJKtUkRehAaFFq7V0b1d8vrbFYFFMJQK/94Nry18cq7dkU8ftLqIT3Y4i5wqQZMkPe2rwjsGPvzNSmK1WDcL5bA1GMJhYu/Kkz25EQOHL/q8u8+3mFbIh9uX+vLS95TZs+SkRqL+edhbHIEC39HiiywR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D3DoTrM/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PdtjPL9P; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D3DoTrM/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PdtjPL9P"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3554F25400C3;
	Thu, 30 Jan 2025 05:51:17 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jan 2025 05:51:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1738234277; x=1738320677; bh=2XQSzVuUsB
	/gPmHg/UY4b8OI7fkioEiRiJ5SVj7wlRA=; b=D3DoTrM/qhtHAXFD+0nPjb0c5h
	NzlAO2iobDpfXHSOAlTbcokkBgBnT+RI9FXDqhLmtcD0w2S47qIlYcqKMmLLfSdC
	mPK5kJySJRskdvP2Ou2LwNTjZLYSRAqN64wrCC7u33OimLksPhvn7sfl6cDX/t8C
	YqKlkHCGhEEE95UPljDv4jGe+FP9l/HM2/6ZPvJgoCPmVyV+NjvJOZolUIuxdi92
	o1yEO1LNVFeydDZqrqcpTTb3IrycpiUm0BqDv9YH26W72AaZ+8Lgvtmpdjnovb0S
	CcI0GdLX+5M9YtRPW9F8vlRv6hfj4DepGK2oLrGlLr2dUin9qS+5MdECY8oA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738234277; x=1738320677; bh=2XQSzVuUsB/gPmHg/UY4b8OI7fkioEiRiJ5
	SVj7wlRA=; b=PdtjPL9PRNC6a7evDf385Qjn7Y18p5CMqXGqL+oSrPQ6wXrdCkO
	kgWSbhitnbel2zroHLXFXXieIQOQCph903PQ83c1++cj7nqRzwyxco7E24G0jGVd
	Zws54kux6kgmXINHmnTfHkuXeoaOhqpDbaiZ0EHAl1tUwXPMKQay0E/XqI6KJHAv
	HG+bdpP/WZZFkId9/rx/y0rltMSpIhuCqyE+8SmsHNQpx+l2Ld4vKT7nGRu1KVNy
	8jpv032tb+GFyyZXHGTU0Vbc9fkfJSbmGIURAL5h2dID/tXx4sTtv6yGs+6/0r7S
	H/3dNowZEpxDDh1aQW06JwXa1l9aO+nlwaQ==
X-ME-Sender: <xms:o1mbZ2OkCgqwVkVZA18UEITeHlCSM9f871JVgYc4rFlArdLsvMcBsw>
    <xme:o1mbZ08Mc4NYhzqIuX49P0jucxet2d7XVyAefjyAJbFjAmLt505yHBYu2_oSsH-xC
    zkSHmbStpAkb3cKbw>
X-ME-Received: <xmr:o1mbZ9SPPyczvrLDBqleNBX6onxLqY6Zhfp3h11oQLm5xaBe_Nhn7lrUWnd2TijgL2B-p8Sikf49xojMawBTDAbucCpCHoYSLiNLsA72dBOe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpth
    htoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgtphhtthhopegt
    hhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehrsh
    gsvggtkhgvrhesnhgvgigsrhhiughgvgdrtghomhdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthihtoh
    hothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhi
    nhgvtghordgtohhm
X-ME-Proxy: <xmx:o1mbZ2shnIXiTvgaIsaS_ewQ9-8C2EGpkUlP5yp67ZTuR1yEIl3wCQ>
    <xmx:o1mbZ-cgaP60c8Bd0exYcKLkwdpa3mDa8UFuLWdYRlqV0EUNnRwfZw>
    <xmx:o1mbZ60owAfwc-pC5Rh9BycVGR4oji8ysgKbVlhJztVwBKkZD34wuQ>
    <xmx:o1mbZy9Rdunm56cPfpm5IsOtCaXpqZ7mdXZX9zL0HEOYbC3R-hO6tw>
    <xmx:pVmbZ_W6xIHmPL_w8HE8Ovzjrw18eUNmu7HH2wlT74Oq4PRRfndBRlVF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jan 2025 05:51:13 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b358aa5a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 Jan 2025 10:51:11 +0000 (UTC)
Date: Thu, 30 Jan 2025 11:51:07 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	"Randall S . Becker" <rsbecker@nexbridge.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v4 4/6] Add 'promisor-remote' capability to protocol v2
Message-ID: <Z5tZm2dNCPt6Y37D@pks.im>
References: <20241206124248.160494-1-christian.couder@gmail.com>
 <20250127151701.2321341-1-christian.couder@gmail.com>
 <20250127151701.2321341-5-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127151701.2321341-5-christian.couder@gmail.com>

On Mon, Jan 27, 2025 at 04:16:59PM +0100, Christian Couder wrote:
> When a server S knows that some objects from a repository are available
> from a promisor remote X, S might want to suggest to a client C cloning
> or fetching the repo from S that C may use X directly instead of S for
> these objects.

A lot of the commit message seems to be duplicated with the technical
documentation that you add. I wonder whether it would make sense to
simply refer to that instead of repeating all of it? That would make it
easier to spot the actually-important bits in the commit message that
add context to the patch.

One very important bit of context that I was lacking is what exactly we
wire up and where we do so. I have been searching for longer than I want
to admit where the client ends up using the promisor remotes, until I
eventually figured out that the client-side isn't wired up at all. It
makes sense in retrospect, but it would've been nice if the reader was
guided a bit.

> diff --git a/Documentation/gitprotocol-v2.txt b/Documentation/gitprotocol-v2.txt
> index 1652fef3ae..f25a9a6ad8 100644
> --- a/Documentation/gitprotocol-v2.txt
> +++ b/Documentation/gitprotocol-v2.txt
> @@ -781,6 +781,60 @@ retrieving the header from a bundle at the indicated URI, and thus
>  save themselves and the server(s) the request(s) needed to inspect the
>  headers of that bundle or bundles.
>  
> +promisor-remote=<pr-infos>
> +~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The server may advertise some promisor remotes it is using or knows
> +about to a client which may want to use them as its promisor remotes,
> +instead of this repository. In this case <pr-infos> should be of the
> +form:
> +
> +	pr-infos = pr-info | pr-infos ";" pr-info
> +
> +	pr-info = "name=" pr-name | "name=" pr-name "," "url=" pr-url
> +
> +where `pr-name` is the urlencoded name of a promisor remote, and
> +`pr-url` the urlencoded URL of that promisor remote.
> +
> +In this case, if the client decides to use one or more promisor
> +remotes the server advertised, it can reply with
> +"promisor-remote=<pr-names>" where <pr-names> should be of the form:
> +
> +	pr-names = pr-name | pr-names ";" pr-name
> +
> +where `pr-name` is the urlencoded name of a promisor remote the server
> +advertised and the client accepts.
> +
> +Note that, everywhere in this document, `pr-name` MUST be a valid
> +remote name, and the ';' and ',' characters MUST be encoded if they
> +appear in `pr-name` or `pr-url`.
> +
> +If the server doesn't know any promisor remote that could be good for
> +a client to use, or prefers a client not to use any promisor remote it
> +uses or knows about, it shouldn't advertise the "promisor-remote"
> +capability at all.
> +
> +In this case, or if the client doesn't want to use any promisor remote
> +the server advertised, the client shouldn't advertise the
> +"promisor-remote" capability at all in its reply.
> +
> +The "promisor.advertise" and "promisor.acceptFromServer" configuration
> +options can be used on the server and client side respectively to

s/respectively//, as you already say that in the next line.

> +control what they advertise or accept respectively. See the
> +documentation of these configuration options for more information.
> +
> +Note that in the future it would be nice if the "promisor-remote"
> +protocol capability could be used by the server, when responding to
> +`git fetch` or `git clone`, to advertise better-connected remotes that
> +the client can use as promisor remotes, instead of this repository, so
> +that the client can lazily fetch objects from these other
> +better-connected remotes. This would require the server to omit in its
> +response the objects available on the better-connected remotes that
> +the client has accepted. This hasn't been implemented yet though. So
> +for now this "promisor-remote" capability is useful only when the
> +server advertises some promisor remotes it already uses to borrow
> +objects from.

I'd leave away this bit as it doesn't really add a lot to the document.
It's a possibility for the future, but without it being implemented
anywhere it's not that helpful from my point of view.

> diff --git a/promisor-remote.c b/promisor-remote.c
> index c714f4f007..5ac282ed27 100644
> --- a/promisor-remote.c
> +++ b/promisor-remote.c
> @@ -292,3 +306,185 @@ void promisor_remote_get_direct(struct repository *repo,
>  	if (to_free)
>  		free(remaining_oids);
>  }
> +
> +static int allow_unsanitized(char ch)
> +{
> +	if (ch == ',' || ch == ';' || ch == '%')
> +		return 0;
> +	return ch > 32 && ch < 127;
> +}

Isn't this too lenient? It would allow also allow e.g. '=' and all kinds
of other characters. This does make sense for URLs, but it doesn't make
sense for remote names as they aren't supposed to contain punctuation in
the first place. So for these remote names I'd think we should be way
stricter and return an error in case they contain non-alphanumeric data.

> +static void promisor_info_vecs(struct repository *repo,
> +			       struct strvec *names,
> +			       struct strvec *urls)

I wonder whether it would make more sense to track these as a strmap
instead of two arrays which are expected to have related entries in the
same place.

> +{
> +	struct promisor_remote *r;
> +
> +	promisor_remote_init(repo);
> +
> +	for (r = repo->promisor_remote_config->promisors; r; r = r->next) {
> +		char *url;
> +		char *url_key = xstrfmt("remote.%s.url", r->name);
> +
> +		strvec_push(names, r->name);
> +		strvec_push(urls, git_config_get_string(url_key, &url) ? NULL : url);
> +
> +		free(url);
> +		free(url_key);
> +	}
> +}
> +
> +char *promisor_remote_info(struct repository *repo)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +	int advertise_promisors = 0;
> +	struct strvec names = STRVEC_INIT;
> +	struct strvec urls = STRVEC_INIT;
> +
> +	git_config_get_bool("promisor.advertise", &advertise_promisors);
> +
> +	if (!advertise_promisors)
> +		return NULL;
> +
> +	promisor_info_vecs(repo, &names, &urls);
> +
> +	if (!names.nr)
> +		return NULL;
> +
> +	for (size_t i = 0; i < names.nr; i++) {
> +		if (i)
> +			strbuf_addch(&sb, ';');
> +		strbuf_addstr(&sb, "name=");
> +		strbuf_addstr_urlencode(&sb, names.v[i], allow_unsanitized);
> +		if (urls.v[i]) {
> +			strbuf_addstr(&sb, ",url=");
> +			strbuf_addstr_urlencode(&sb, urls.v[i], allow_unsanitized);
> +		}
> +	}
> +
> +	redact_non_printables(&sb);

So here we replace non-printable characters with dots as far as I
understand. But didn't we just URL-encode the strings? So is there ever
a possibility for non-printable characters here?

> +	strvec_clear(&names);
> +	strvec_clear(&urls);
> +
> +	return strbuf_detach(&sb, NULL);
> +}
> +
> +enum accept_promisor {
> +	ACCEPT_NONE = 0,
> +	ACCEPT_ALL
> +};
> +
> +static int should_accept_remote(enum accept_promisor accept,
> +				const char *remote_name UNUSED,
> +				const char *remote_url UNUSED)
> +{
> +	if (accept == ACCEPT_ALL)
> +		return 1;
> +
> +	BUG("Unhandled 'enum accept_promisor' value '%d'", accept);
> +}
> +
> +static void filter_promisor_remote(struct strvec *accepted, const char *info)
> +{
> +	struct strbuf **remotes;
> +	const char *accept_str;
> +	enum accept_promisor accept = ACCEPT_NONE;
> +
> +	if (!git_config_get_string_tmp("promisor.acceptfromserver", &accept_str)) {
> +		if (!accept_str || !*accept_str || !strcasecmp("None", accept_str))
> +			accept = ACCEPT_NONE;
> +		else if (!strcasecmp("All", accept_str))
> +			accept = ACCEPT_ALL;
> +		else
> +			warning(_("unknown '%s' value for '%s' config option"),
> +				accept_str, "promisor.acceptfromserver");
> +	}
> +
> +	if (accept == ACCEPT_NONE)
> +		return;
> +
> +	/* Parse remote info received */
> +
> +	remotes = strbuf_split_str(info, ';', 0);
> +
> +	for (size_t i = 0; remotes[i]; i++) {
> +		struct strbuf **elems;
> +		const char *remote_name = NULL;
> +		const char *remote_url = NULL;
> +		char *decoded_name = NULL;
> +		char *decoded_url = NULL;
> +
> +		strbuf_strip_suffix(remotes[i], ";");
> +		elems = strbuf_split(remotes[i], ',');
> +
> +		for (size_t j = 0; elems[j]; j++) {
> +			int res;
> +			strbuf_strip_suffix(elems[j], ",");
> +			res = skip_prefix(elems[j]->buf, "name=", &remote_name) ||
> +				skip_prefix(elems[j]->buf, "url=", &remote_url);
> +			if (!res)
> +				warning(_("unknown element '%s' from remote info"),
> +					elems[j]->buf);
> +		}
> +
> +		if (remote_name)
> +			decoded_name = url_percent_decode(remote_name);
> +		if (remote_url)
> +			decoded_url = url_percent_decode(remote_url);

This is data we have received from a potentially-untrusted remote, so we
should double-check that the data we have received doesn't contain any
weird characters:

  - For the remote name we should verify that it consists only of
    alphanumeric characters.

  - For the remote URL we need to verify that it's a proper URL without
    any newlines, non-printable characters or anything else.

We'll eventually end up storing that data in the configuration, so these
verifications are quite important so that an adversarial server cannot
perform config-injection and thus cause remote code execution.

[snip]
> +void mark_promisor_remotes_as_accepted(struct repository *r, const char *remotes)
> +{
> +	struct strbuf **accepted_remotes = strbuf_split_str(remotes, ';', 0);
> +
> +	for (size_t i = 0; accepted_remotes[i]; i++) {
> +		struct promisor_remote *p;
> +		char *decoded_remote;
> +
> +		strbuf_strip_suffix(accepted_remotes[i], ";");
> +		decoded_remote = url_percent_decode(accepted_remotes[i]->buf);
> +
> +		p = repo_promisor_remote_find(r, decoded_remote);
> +		if (p)
> +			p->accepted = 1;
> +		else
> +			warning(_("accepted promisor remote '%s' not found"),
> +				decoded_remote);

My initial understanding of this code was that it is about the
client-side accepting a remote, but this is about the server-side and
tracks whether a promisor remote has been accepted by the client. It
feels a bit weird to modify semi-global state for this, as I'd have
rather expected that we pass around a vector of accepted remotes
instead.

But I guess ultimately this isn't too bad. It would be nice though if
it was more obvious whether we're on the server- or client-side.

> diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
> new file mode 100755
> index 0000000000..0390c1dbad
> --- /dev/null
> +++ b/t/t5710-promisor-remote-capability.sh
> @@ -0,0 +1,244 @@
[snip]
> +initialize_server () {
> +	count="$1"
> +	missing_oids="$2"
> +
> +	# Repack everything first
> +	git -C server -c repack.writebitmaps=false repack -a -d &&
> +
> +	# Remove promisor file in case they exist, useful when reinitializing
> +	rm -rf server/objects/pack/*.promisor &&
> +
> +	# Repack without the largest object and create a promisor pack on server
> +	git -C server -c repack.writebitmaps=false repack -a -d \
> +	    --filter=blob:limit=5k --filter-to="$(pwd)/pack" &&
> +	promisor_file=$(ls server/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
> +	>"$promisor_file" &&
> +
> +	# Check objects missing on the server
> +	check_missing_objects server "$count" "$missing_oids"
> +}
> +
> +copy_to_server2 () {

Nit: `server2` could be renamed to `promisor` to make the relation
between the two servers more obvious.

> diff --git a/upload-pack.c b/upload-pack.c
> index 728b2477fc..7498b45e2e 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -319,6 +320,8 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  		strvec_push(&pack_objects.args, "--delta-base-offset");
>  	if (pack_data->use_include_tag)
>  		strvec_push(&pack_objects.args, "--include-tag");
> +	if (repo_has_accepted_promisor_remote(the_repository))
> +		strvec_push(&pack_objects.args, "--missing=allow-promisor");

This is nice and simple, I like it.

Patrick
