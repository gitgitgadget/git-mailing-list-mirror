Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3929F2C6BD
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526566; cv=none; b=kxe0tXekTiOE8sNvB40+b+HqukTEoTLhsbq1QZr3vtcXRAqEuQq6mNewI3itP0JBt60Go9P8puVi9zfMr0qyL3uEucVQx2uRJAXP6+xecBXD4TTvQ/ViOlfInfs0EwsyxUqfzE6Us0NRsqBZZIj0q2StJdFfq4UYm2rJf9uhKXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526566; c=relaxed/simple;
	bh=VW4NT0vRAY0PiRwJOf8iDNoVFYNiEURrDuHafZiMDDE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NMKekD5gtd3ew+4xZUe3Xl2sYoj8nkm+lucVXz5euypP19O42MykgwBHgcgBYSguC/0EcTar9Krx2tMp41VYgpgDIizUSCLNluCLrcwZCNOpRPt8vLZ0pTksVtCCW8MM0v3tknoKlnSXbe27EArL4jmv8Tq3q4yuA+6Qb681qsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N6I9rnjc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n6QB3lty; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N6I9rnjc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n6QB3lty"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 3C44A114010E;
	Wed, 27 Mar 2024 04:02:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 27 Mar 2024 04:02:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711526562; x=1711612962; bh=AaXSqt8ewl
	Ld2ri194ghbPLOznmqIWGhZSpzq4fHuoE=; b=N6I9rnjcDFwkdqqUZM0DCJX3H0
	PB8zuGknIfoxYv3rtokAl8aoivwJ75CJPPqRqM2uk4ATEHS4/FY9Qp1NXbkVHdpW
	xM60sM29zWC0zWv0MiHEkUM6YbvvaAD6YZJDq5nL32Zg1C9WAjZgBlcftKZzvMSv
	nqvndNjkB4A0mbbIJMk+pH7BjC2ZupbqUt/ro2QQIPUBbHm+v1x3ws4QOiC1GU+A
	KnxLyI6yr06w8jQPbxh973q6tL8m0STYbvK9GtLOHj5eYdEo/60EFyxZoxHIhRlR
	MbI6GdMS89LNFlR6XqyFlYINYLPAgtWzTeSHp7GKfh9iKTzLD2uGnKdsbblg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711526562; x=1711612962; bh=AaXSqt8ewlLd2ri194ghbPLOznmq
	IWGhZSpzq4fHuoE=; b=n6QB3ltyduY+GRbNktK5eydK/HH4ZB0HNVCmaubEW/tE
	71qg2SgRmtHCCJzuH8jeTBU8I4s6QlsrqVkbMMOh00gl6LItn6z+ZsS6ForfgNnf
	579rVVOhnbVywEtypWgsVmXBKI12VKYBSnSNELEdauTct+YzXUZ/c2pbgmABFaul
	lVZ14BwXydmHrsiu1uYzv0qe4dF9eVX2Mi5dHVFqr4rbvfbPIR5dgT5c6u1op8nC
	77oSRZKmop0PNEwo37YYIBwZ2747y2KYGQPdPN9NL4NSrDkAhRzCmopdzXoQRcAJ
	c0eIrOB8/mih0k6i0MJBKam0uW+I4QfdNGO2+nqrSw==
X-ME-Sender: <xms:otIDZsfriAz-7DN3QIijyGTpNjt3zihlLvS1xjd_kwMvw3DEwDBQVQ>
    <xme:otIDZuNJi4__L7XfstNwP41nKxNyZGPmK2GHBG7YpmDZV46eKKiMZVp77x5ZDvC43
    dsleFR63u05Ycj3tg>
X-ME-Received: <xmr:otIDZti_VDHwq7HdD-uEvF6fH8v2Jss-3bAPJYHsKAJKcIWPElv_6cFrmlkh83W0DgwYuNhWnAQIKRvKDQeR6F1jYHWYP04k4d50EhBQ62n0eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedgudduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetjeekudeghedtteeuledtlefgjedujeekgfevfeekhfdvieduheehheekhfff
    keenucffohhmrghinhephhhtthhptghouggvrdhinhdptgegqdhtthdtfedttddqtghrvg
    guvghnthhirghlshdrshhhpdhhthhtphhhohhsthgvgigrmhhplhgvrdgtohhmpdhhthht
    phhvvghrsggrthhimhdqtghrvgguhhhoshhtvgigrghmphhlvgdrtghomhdphhhtthhpuh
    hsvghlvghsshhhohhsthgvgigrmhhplhgvrdgtohhmpdhhthhtphhvvghrsggrthhimhhh
    ohhsthgvgigrmhhplhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:otIDZh8rdZWcaQvR1yeqpkgSumQQgQAzd6uQzUTBxeEpnCAj9ohf7Q>
    <xmx:otIDZov6eMadsCDx2s9UuP6AHyVy-PO6ygTdXG5Z6RB9XF8_MxpriA>
    <xmx:otIDZoErpjW3_xOVzdFUUZmugrkUc6yDQRyXh4-bbg797x-ZDmiK5Q>
    <xmx:otIDZnP9X47MqWrOZeRLhUAf1i4kacSke1cifmzSglIYPaQ_bN6nqg>
    <xmx:otIDZsjQNGIkd5lzrlDgiR6c0Qw4xMkUdP6UWi7PjWMNdhWZralaBA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:02:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4ddf7e57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:02:27 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:02:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Matthew John Cheetham <mjcheetham@outlook.com>,
	M Hickford <mirth.hickford@gmail.com>
Subject: Re: [PATCH 05/13] credential: gate new fields on capability
Message-ID: <ZgPSn_D8luXQyZGf@tanuki>
References: <20240324011301.1553072-1-sandals@crustytoothpaste.net>
 <20240324011301.1553072-6-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fILdsWSlBgfju45K"
Content-Disposition: inline
In-Reply-To: <20240324011301.1553072-6-sandals@crustytoothpaste.net>


--fILdsWSlBgfju45K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 01:12:53AM +0000, brian m. carlson wrote:
> We support the new credential and authtype fields, but we lack a way to
> indicate to a credential helper that we'd like them to be used.  Without
> some sort of indication, the credential helper doesn't know if it should
> try to provide us a username and password, or a pre-encoded credential.
> For example, the helper might prefer a more restricted Bearer token if
> pre-encoded credentials are possible, but might have to fall back to
> more general username and password if not.
>=20
> Let's provide a simple way to indicate whether Git (or, for that matter,
> the helper) is capable of understanding the authtype and credential
> fields.  We send this capability when we generate a request, and the
> other side may reply to indicate to us that it does, too.
>=20
> For now, don't enable sending capabilities for the HTTP code.  In a
> future commit, we'll introduce appropriate handling for that code,
> which requires more in-depth work.
>=20
> The logic for determining whether a capability is supported may seem
> complex, but it is not.  At each stage, we emit the capability to the
> following stage if all preceding stages have declared it.  Thus, if the
> caller to git credential fill didn't declare it, then we won't send it
> to the helper, and if fill's caller did send but the helper doesn't
> understand it, then we won't send it on in the response.  If we're an
> internal user, then we know about all capabilities and will request
> them.
>=20
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/credential-cache--daemon.c |   2 +-
>  builtin/credential-store.c         |   2 +-
>  builtin/credential.c               |   6 +-
>  credential.c                       |  58 ++++++++++++++--
>  credential.h                       |  30 +++++++-
>  http.c                             |  10 +--
>  imap-send.c                        |   2 +-
>  remote-curl.c                      |   4 +-
>  t/t0300-credentials.sh             | 107 ++++++++++++++++++++++++++++-
>  9 files changed, 197 insertions(+), 24 deletions(-)
>=20
> diff --git a/builtin/credential-cache--daemon.c b/builtin/credential-cach=
e--daemon.c
> index 3a6a750a8e..ccbcf99ac1 100644
> --- a/builtin/credential-cache--daemon.c
> +++ b/builtin/credential-cache--daemon.c
> @@ -115,7 +115,7 @@ static int read_request(FILE *fh, struct credential *=
c,
>  		return error("client sent bogus timeout line: %s", item.buf);
>  	*timeout =3D atoi(p);
> =20
> -	if (credential_read(c, fh) < 0)
> +	if (credential_read(c, fh, CREDENTIAL_OP_HELPER) < 0)
>  		return -1;
>  	return 0;
>  }
> diff --git a/builtin/credential-store.c b/builtin/credential-store.c
> index 4a492411bb..494c809332 100644
> --- a/builtin/credential-store.c
> +++ b/builtin/credential-store.c
> @@ -205,7 +205,7 @@ int cmd_credential_store(int argc, const char **argv,=
 const char *prefix)
>  	if (!fns.nr)
>  		die("unable to set up default path; use --file");
> =20
> -	if (credential_read(&c, stdin) < 0)
> +	if (credential_read(&c, stdin, CREDENTIAL_OP_HELPER) < 0)
>  		die("unable to read credential");
> =20
>  	if (!strcmp(op, "get"))
> diff --git a/builtin/credential.c b/builtin/credential.c
> index 7010752987..5123dabcf1 100644
> --- a/builtin/credential.c
> +++ b/builtin/credential.c
> @@ -17,12 +17,12 @@ int cmd_credential(int argc, const char **argv, const=
 char *prefix UNUSED)
>  		usage(usage_msg);
>  	op =3D argv[1];
> =20
> -	if (credential_read(&c, stdin) < 0)
> +	if (credential_read(&c, stdin, CREDENTIAL_OP_INITIAL) < 0)
>  		die("unable to read credential from stdin");
> =20
>  	if (!strcmp(op, "fill")) {
> -		credential_fill(&c);
> -		credential_write(&c, stdout);
> +		credential_fill(&c, 0);
> +		credential_write(&c, stdout, CREDENTIAL_OP_RESPONSE);
>  	} else if (!strcmp(op, "approve")) {
>  		credential_approve(&c);
>  	} else if (!strcmp(op, "reject")) {
> diff --git a/credential.c b/credential.c
> index c521822e5a..f2a26b8672 100644
> --- a/credential.c
> +++ b/credential.c
> @@ -34,6 +34,11 @@ void credential_clear(struct credential *c)
>  	credential_init(c);
>  }
> =20
> +static void credential_set_all_capabilities(struct credential *c)
> +{
> +	c->capa_authtype.request_initial =3D 1;
> +}
> +
>  int credential_match(const struct credential *want,
>  		     const struct credential *have, int match_password)
>  {
> @@ -210,7 +215,39 @@ static void credential_getpass(struct credential *c)
>  						 PROMPT_ASKPASS);
>  }
> =20
> -int credential_read(struct credential *c, FILE *fp)
> +static void credential_set_capability(struct credential_capability *capa=
, int op_type)
> +{
> +	switch (op_type) {
> +	case CREDENTIAL_OP_INITIAL:
> +		capa->request_initial =3D 1;
> +		break;
> +	case CREDENTIAL_OP_HELPER:
> +		capa->request_helper =3D 1;
> +		break;
> +	case CREDENTIAL_OP_RESPONSE:
> +		capa->response =3D 1;
> +		break;
> +	}
> +}
> +
> +static int credential_has_capability(const struct credential_capability =
*capa, int op_type)
> +{
> +	/*
> +	 * We're checking here if each previous step indicated that we had the
> +	 * capability.  If it did, then we want to pass it along; conversely, if
> +	 * it did not, we don't want to report that to our caller.
> +	 */
> +	switch (op_type) {
> +	case CREDENTIAL_OP_HELPER:
> +		return capa->request_initial;
> +	case CREDENTIAL_OP_RESPONSE:
> +		return capa->request_initial && capa->request_helper;
> +	default:
> +		return 0;
> +	}
> +}

I think I'm missing the bigger picture here, so please bear with me.

What you provide here is simply an `op_type` that indicates the phase we
are currently in and thus allows us to check whether all of the
preceding phases had the capability set. But to me it seems like a phase
and the actual capability should be different things. So why is it that
the capability seems to be a mere boolean value instead of something
like a bitfield indicating whether a specific capability is supported or
not? Or is all of this infra really only to support a single capability,
namely the credential capability?

I'm mostly coming from the angle of how capabilities work with remote
helpers. When asked, the helper will announce a set of capabilities that
it supports, e.g. "capabilities stateless-connect". So from thereon the
client of the helper knows that it can assume "stateless-connect" to be
understood by the helper.

I would have expected capabilities to work similarly for the credential
helper, where it announces "I know to handle pre-encoded credentials".
But given that I have basically no clue at all for how the credential
helper works there may very well be good reasons why things work so
differently here.

> +int credential_read(struct credential *c, FILE *fp, int op_type)
>  {
>  	struct strbuf line =3D STRBUF_INIT;
> =20
> @@ -249,6 +286,8 @@ int credential_read(struct credential *c, FILE *fp)
>  			c->path =3D xstrdup(value);
>  		} else if (!strcmp(key, "wwwauth[]")) {
>  			strvec_push(&c->wwwauth_headers, value);
> +		} else if (!strcmp(key, "capability[]") && !strcmp(value, "authtype"))=
 {
> +			credential_set_capability(&c->capa_authtype, op_type);
>  		} else if (!strcmp(key, "password_expiry_utc")) {
>  			errno =3D 0;
>  			c->password_expiry_utc =3D parse_timestamp(value, NULL, 10);
> @@ -288,14 +327,18 @@ static void credential_write_item(FILE *fp, const c=
har *key, const char *value,
>  	fprintf(fp, "%s=3D%s\n", key, value);
>  }
> =20
> -void credential_write(const struct credential *c, FILE *fp)
> +void credential_write(const struct credential *c, FILE *fp, int op_type)
>  {
> +	if (credential_has_capability(&c->capa_authtype, op_type)) {
> +		credential_write_item(fp, "capability[]", "authtype", 0);
> +		credential_write_item(fp, "authtype", c->authtype, 0);
> +		credential_write_item(fp, "credential", c->credential, 0);
> +	}
>  	credential_write_item(fp, "protocol", c->protocol, 1);
>  	credential_write_item(fp, "host", c->host, 1);
>  	credential_write_item(fp, "path", c->path, 0);
>  	credential_write_item(fp, "username", c->username, 0);
>  	credential_write_item(fp, "password", c->password, 0);
> -	credential_write_item(fp, "credential", c->credential, 0);
>  	credential_write_item(fp, "oauth_refresh_token", c->oauth_refresh_token=
, 0);
>  	if (c->password_expiry_utc !=3D TIME_MAX) {
>  		char *s =3D xstrfmt("%"PRItime, c->password_expiry_utc);
> @@ -304,7 +347,6 @@ void credential_write(const struct credential *c, FIL=
E *fp)
>  	}
>  	for (size_t i =3D 0; i < c->wwwauth_headers.nr; i++)
>  		credential_write_item(fp, "wwwauth[]", c->wwwauth_headers.v[i], 0);
> -	credential_write_item(fp, "authtype", c->authtype, 0);
>  }
> =20
>  static int run_credential_helper(struct credential *c,
> @@ -327,14 +369,14 @@ static int run_credential_helper(struct credential =
*c,
> =20
>  	fp =3D xfdopen(helper.in, "w");
>  	sigchain_push(SIGPIPE, SIG_IGN);
> -	credential_write(c, fp);
> +	credential_write(c, fp, want_output ? CREDENTIAL_OP_HELPER : CREDENTIAL=
_OP_RESPONSE);
>  	fclose(fp);
>  	sigchain_pop(SIGPIPE);
> =20
>  	if (want_output) {
>  		int r;
>  		fp =3D xfdopen(helper.out, "r");
> -		r =3D credential_read(c, fp);
> +		r =3D credential_read(c, fp, CREDENTIAL_OP_HELPER);
>  		fclose(fp);
>  		if (r < 0) {
>  			finish_command(&helper);
> @@ -367,7 +409,7 @@ static int credential_do(struct credential *c, const =
char *helper,
>  	return r;
>  }
> =20
> -void credential_fill(struct credential *c)
> +void credential_fill(struct credential *c, int all_capabilities)
>  {
>  	int i;
> =20
> @@ -375,6 +417,8 @@ void credential_fill(struct credential *c)
>  		return;
> =20
>  	credential_apply_config(c);
> +	if (all_capabilities)
> +		credential_set_all_capabilities(c);
> =20
>  	for (i =3D 0; i < c->helpers.nr; i++) {
>  		credential_do(c, c->helpers.items[i].string, "get");
> diff --git a/credential.h b/credential.h
> index 9db892cf4d..2051d04c5a 100644
> --- a/credential.h
> +++ b/credential.h
> @@ -93,6 +93,25 @@
>   * ---------------------------------------------------------------------=
--
>   */
> =20
> +/*
> + * These values define the kind of operation we're performing and the
> + * capabilities at each stage.  The first is either an external request =
(via git
> + * credential fill) or an internal request (e.g., via the HTTP) code.  T=
he
> + * second is the call to the credential helper, and the third is the res=
ponse
> + * we're providing.
> + *
> + * At each stage, we will emit the capability only if the previous stage
> + * supported it.
> + */
> +#define CREDENTIAL_OP_INITIAL  1
> +#define CREDENTIAL_OP_HELPER   2
> +#define CREDENTIAL_OP_RESPONSE 3

Is there any specific reason why you're using defines instead of an enum
here? I think the latter would be more self-explanatory when you see
that functions take `enum credential_op` as input instead of an `int`.

Patrick

> +struct credential_capability {
> +	unsigned request_initial:1,
> +		 request_helper:1,
> +		 response:1;
> +};
> =20
>  /**
>   * This struct represents a single username/password combination
> @@ -136,6 +155,8 @@ struct credential {
>  		 use_http_path:1,
>  		 username_from_proto:1;
> =20
> +	struct credential_capability capa_authtype;
> +
>  	char *username;
>  	char *password;
>  	char *credential;
> @@ -174,8 +195,11 @@ void credential_clear(struct credential *);
>   * returns, the username and password fields of the credential are
>   * guaranteed to be non-NULL. If an error occurs, the function will
>   * die().
> + *
> + * If all_capabilities is set, this is an internal user that is prepared
> + * to deal with all known capabilities, and we should advertise that fac=
t.
>   */
> -void credential_fill(struct credential *);
> +void credential_fill(struct credential *, int all_capabilities);
> =20
>  /**
>   * Inform the credential subsystem that the provided credentials
> @@ -198,8 +222,8 @@ void credential_approve(struct credential *);
>   */
>  void credential_reject(struct credential *);
> =20
> -int credential_read(struct credential *, FILE *);
> -void credential_write(const struct credential *, FILE *);
> +int credential_read(struct credential *, FILE *, int);
> +void credential_write(const struct credential *, FILE *, int);
> =20
>  /*
>   * Parse a url into a credential struct, replacing any existing contents.
> diff --git a/http.c b/http.c
> index 1c2200da77..4f5df6fb14 100644
> --- a/http.c
> +++ b/http.c
> @@ -569,7 +569,7 @@ static void init_curl_http_auth(CURL *result)
>  		return;
>  	}
> =20
> -	credential_fill(&http_auth);
> +	credential_fill(&http_auth, 0);
> =20
>  	curl_easy_setopt(result, CURLOPT_USERNAME, http_auth.username);
>  	curl_easy_setopt(result, CURLOPT_PASSWORD, http_auth.password);
> @@ -596,7 +596,7 @@ static void init_curl_proxy_auth(CURL *result)
>  {
>  	if (proxy_auth.username) {
>  		if (!proxy_auth.password)
> -			credential_fill(&proxy_auth);
> +			credential_fill(&proxy_auth, 0);
>  		set_proxyauth_name_password(result);
>  	}
> =20
> @@ -630,7 +630,7 @@ static int has_cert_password(void)
>  		cert_auth.host =3D xstrdup("");
>  		cert_auth.username =3D xstrdup("");
>  		cert_auth.path =3D xstrdup(ssl_cert);
> -		credential_fill(&cert_auth);
> +		credential_fill(&cert_auth, 0);
>  	}
>  	return 1;
>  }
> @@ -645,7 +645,7 @@ static int has_proxy_cert_password(void)
>  		proxy_cert_auth.host =3D xstrdup("");
>  		proxy_cert_auth.username =3D xstrdup("");
>  		proxy_cert_auth.path =3D xstrdup(http_proxy_ssl_cert);
> -		credential_fill(&proxy_cert_auth);
> +		credential_fill(&proxy_cert_auth, 0);
>  	}
>  	return 1;
>  }
> @@ -2191,7 +2191,7 @@ static int http_request_reauth(const char *url,
>  		BUG("Unknown http_request target");
>  	}
> =20
> -	credential_fill(&http_auth);
> +	credential_fill(&http_auth, 0);
> =20
>  	return http_request(url, result, target, options);
>  }
> diff --git a/imap-send.c b/imap-send.c
> index f2e1947e63..8c89e866b6 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -944,7 +944,7 @@ static void server_fill_credential(struct imap_server=
_conf *srvc, struct credent
>  	cred->username =3D xstrdup_or_null(srvc->user);
>  	cred->password =3D xstrdup_or_null(srvc->pass);
> =20
> -	credential_fill(cred);
> +	credential_fill(cred, 1);
> =20
>  	if (!srvc->user)
>  		srvc->user =3D xstrdup(cred->username);
> diff --git a/remote-curl.c b/remote-curl.c
> index e37eaa17b7..f96bda2431 100644
> --- a/remote-curl.c
> +++ b/remote-curl.c
> @@ -926,7 +926,7 @@ static int post_rpc(struct rpc_state *rpc, int statel=
ess_connect, int flush_rece
>  		do {
>  			err =3D probe_rpc(rpc, &results);
>  			if (err =3D=3D HTTP_REAUTH)
> -				credential_fill(&http_auth);
> +				credential_fill(&http_auth, 0);
>  		} while (err =3D=3D HTTP_REAUTH);
>  		if (err !=3D HTTP_OK)
>  			return -1;
> @@ -1044,7 +1044,7 @@ static int post_rpc(struct rpc_state *rpc, int stat=
eless_connect, int flush_rece
>  	rpc->any_written =3D 0;
>  	err =3D run_slot(slot, NULL);
>  	if (err =3D=3D HTTP_REAUTH && !large_request) {
> -		credential_fill(&http_auth);
> +		credential_fill(&http_auth, 0);
>  		curl_slist_free_all(headers);
>  		goto retry;
>  	}
> diff --git a/t/t0300-credentials.sh b/t/t0300-credentials.sh
> index 400f6bdbca..8477108b28 100755
> --- a/t/t0300-credentials.sh
> +++ b/t/t0300-credentials.sh
> @@ -12,7 +12,13 @@ test_expect_success 'setup helper scripts' '
>  	IFS=3D=3D
>  	while read key value; do
>  		echo >&2 "$whoami: $key=3D$value"
> -		eval "$key=3D$value"
> +		if test -z "${key%%*\[\]}"
> +		then
> +			key=3D${key%%\[\]}
> +			eval "$key=3D\"\$$key $value\""
> +		else
> +			eval "$key=3D$value"
> +		fi
>  	done
>  	IFS=3D$OIFS
>  	EOF
> @@ -35,6 +41,16 @@ test_expect_success 'setup helper scripts' '
>  	test -z "$pass" || echo password=3D$pass
>  	EOF
> =20
> +	write_script git-credential-verbatim-cred <<-\EOF &&
> +	authtype=3D$1; shift
> +	credential=3D$1; shift
> +	. ./dump
> +	echo capability[]=3Dauthtype
> +	test -z "${capability##*authtype*}" || return
> +	test -z "$authtype" || echo authtype=3D$authtype
> +	test -z "$credential" || echo credential=3D$credential
> +	EOF
> +
>  	write_script git-credential-verbatim-with-expiry <<-\EOF &&
>  	user=3D$1; shift
>  	pass=3D$1; shift
> @@ -64,6 +80,26 @@ test_expect_success 'credential_fill invokes helper' '
>  	EOF
>  '
> =20
> +test_expect_success 'credential_fill invokes helper with credential' '
> +	check fill "verbatim-cred Bearer token" <<-\EOF
> +	capability[]=3Dauthtype
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	--
> +	capability[]=3Dauthtype
> +	authtype=3DBearer
> +	credential=3Dtoken
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	--
> +	verbatim-cred: get
> +	verbatim-cred: capability[]=3Dauthtype
> +	verbatim-cred: protocol=3Dhttp
> +	verbatim-cred: host=3Dexample.com
> +	EOF
> +'
> +
> +
>  test_expect_success 'credential_fill invokes multiple helpers' '
>  	check fill useless "verbatim foo bar" <<-\EOF
>  	protocol=3Dhttp
> @@ -83,6 +119,42 @@ test_expect_success 'credential_fill invokes multiple=
 helpers' '
>  	EOF
>  '
> =20
> +test_expect_success 'credential_fill response does not get capabilities =
when helpers are incapable' '
> +	check fill useless "verbatim foo bar" <<-\EOF
> +	capability[]=3Dauthtype
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	--
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	username=3Dfoo
> +	password=3Dbar
> +	--
> +	useless: get
> +	useless: capability[]=3Dauthtype
> +	useless: protocol=3Dhttp
> +	useless: host=3Dexample.com
> +	verbatim: get
> +	verbatim: capability[]=3Dauthtype
> +	verbatim: protocol=3Dhttp
> +	verbatim: host=3Dexample.com
> +	EOF
> +'
> +
> +test_expect_success 'credential_fill response does not get capabilities =
when caller is incapable' '
> +	check fill "verbatim-cred Bearer token" <<-\EOF
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	--
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	--
> +	verbatim-cred: get
> +	verbatim-cred: protocol=3Dhttp
> +	verbatim-cred: host=3Dexample.com
> +	EOF
> +'
> +
>  test_expect_success 'credential_fill stops when we get a full response' '
>  	check fill "verbatim one two" "verbatim three four" <<-\EOF
>  	protocol=3Dhttp
> @@ -99,6 +171,25 @@ test_expect_success 'credential_fill stops when we ge=
t a full response' '
>  	EOF
>  '
> =20
> +test_expect_success 'credential_fill thinks a credential is a full respo=
nse' '
> +	check fill "verbatim-cred Bearer token" "verbatim three four" <<-\EOF
> +	capability[]=3Dauthtype
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	--
> +	capability[]=3Dauthtype
> +	authtype=3DBearer
> +	credential=3Dtoken
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	--
> +	verbatim-cred: get
> +	verbatim-cred: capability[]=3Dauthtype
> +	verbatim-cred: protocol=3Dhttp
> +	verbatim-cred: host=3Dexample.com
> +	EOF
> +'
> +
>  test_expect_success 'credential_fill continues through partial response'=
 '
>  	check fill "verbatim one \"\"" "verbatim two three" <<-\EOF
>  	protocol=3Dhttp
> @@ -175,6 +266,20 @@ test_expect_success 'credential_fill passes along me=
tadata' '
>  	EOF
>  '
> =20
> +test_expect_success 'credential_fill produces no credential without capa=
bility' '
> +	check fill "verbatim-cred Bearer token" <<-\EOF
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	--
> +	protocol=3Dhttp
> +	host=3Dexample.com
> +	--
> +	verbatim-cred: get
> +	verbatim-cred: protocol=3Dhttp
> +	verbatim-cred: host=3Dexample.com
> +	EOF
> +'
> +
>  test_expect_success 'credential_approve calls all helpers' '
>  	check approve useless "verbatim one two" <<-\EOF
>  	protocol=3Dhttp
>=20

--fILdsWSlBgfju45K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD0p4ACgkQVbJhu7ck
PpSsQQ//WWtvkGkYOWkZAEWZjso7IIRIwKIui1fPO0rGW498a425EEKqn4MN2D8P
kNacVi7/0XepTAlQcmWZBw1kffZOG1jlEy3xhAMA74d6bAdP4irjlGCEywj+9mml
/XuuL2am21VvoiZPH4NAr+tuNrNogozOHUQlTUrKbQlwpZJjo9qWLgjn7bW14ZVY
l0MZweklqN6/VWVeCR8dkhijiXEhdo25taVLAjWQGYBC3uCSWbW4kE+7heRdBmON
yYnD3mbCQ3vWaoW6vPK132KppG8VvWMWemu46sAfLjWsBvsQlcUsKp9X8lbRxtuX
TYKT/sH2Pjw4l98ycR37Tql46i9zHSgO7MSANCmp2UWGLqr2HC2PIx03MUhE9Fgi
SJ3fiHAl+7j1ILQdzLWhVXSaud0HUWzAx9QgyxRhrPsuM6bKmNWU5Uq8FU1wAEo9
Af1IE6NGUdJs7Sif7KcNbytUgS/wJHlkxcHHr13nv8NcwxPbNJCPxO++ARhcIuqg
AGRqAYn80PibpcfsB4/ciYQAYdPBcG0aDRg2JdqVbbBIBvG50bArgZJUktnr5NDv
xS9JSxJwGn0Zm7DrVhF1/Boc6rs3++WEUim8QYOYbk669nfEk+M1QIPBX7EYtkpn
PpL2Vub6GCO97vt3ivU78rEGGWgBzxXFu1YKXlc+ct3DDA2sNbI=
=F6fC
-----END PGP SIGNATURE-----

--fILdsWSlBgfju45K--
