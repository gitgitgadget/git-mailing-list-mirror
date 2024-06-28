Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B857E56444
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719612043; cv=none; b=GKi3dFQyR9QmGvE2n38jpFaODPGAOgl6p4dpDq9qxrePw3tBAuf0iSXO3bxhiWu4G6RYfc71/PxJTP0+xSNzyJqCc7R9n5b9gjsWhk9lJshaplmcup1iiHVyWGt53RFtUzdBolr68cCsJydh9QesnSCt/wDFO0PlN9KEKXE/jtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719612043; c=relaxed/simple;
	bh=7qTaDVE4Pxa1MZ7yrn4yYG1tO/vK20GL3GK66nB/bgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDX+6HSuFWOUwIefuYxmzXNuW4gDmixmTZuXXH6cwTQdQ5bmVxvaXk89scZ4YN6SqF5bxPoiQdciugen8R08qRwMFRfWxJcOb1im3Z4rLEsNHL3GA1VVn5mRQ/n6/bWDUCCcfmNuljiwHWP4L1M7L63OUHwI+SVXp6loWnaxBUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=Zb4aP4lg; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="Zb4aP4lg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1719612039;
	bh=7qTaDVE4Pxa1MZ7yrn4yYG1tO/vK20GL3GK66nB/bgo=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=Zb4aP4lgQq2ARVCPEiCqRligIL+O6UxPMjui5PVMaoedbPpL6Hruk7W+Ni24zXk5+
	 n9ddA4R3kR2pHZURSBvSFU9Hebc/WKv025dZ3kOBRDaX97XLFF06GqI6Fc9OLt3pzA
	 VYisZU9gGmzbPSnFm/xspGK76aIe5TM+SuKS59LseX7AgfynH5exnGC4k8zxXgjuwj
	 yajg+xYvtoJOUUfcxIbIlBFNzss3N1wIzNu7A846jJYsuebYEduz+Irw+4i1cL4kmA
	 lPkBM0vg/Czk7JAKMMIr02zePA8cuplYh6mlUR+QMFUCY+j78SU/T6ipmGsDWxTmKc
	 PPuapAa5BlbNiYIJKh3OKAVEjknURJn6JxB7F/lhLJbTjzlm+u5vOUqM8GbrYSwbtH
	 SAt3pkqi5gZx8SNoojgxPkFok2DBzuHcAXqz+iiZSB8yFcFBLYWBqVI2YZb8seEK57
	 /d4OVSyWTjAtSQXqq/vGVDBb2WvjrBmcDBuqdnywMbMWKlz7kZY
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 70A982638C;
	Fri, 28 Jun 2024 22:00:39 +0000 (UTC)
Date: Fri, 28 Jun 2024 22:00:37 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] http: allow authenticating proactively
Message-ID: <Zn8yhdN6henrIqgD@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
 <20240628002742.3421311-2-sandals@crustytoothpaste.net>
 <xmqqa5j53pbo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vw4UJzN5NiDNPGT8"
Content-Disposition: inline
In-Reply-To: <xmqqa5j53pbo.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--vw4UJzN5NiDNPGT8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-28 at 18:16:43, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>=20
> > diff --git a/Documentation/config/http.txt b/Documentation/config/http.=
txt
> > index 2d4e0c9b86..2bacb2b862 100644
> > --- a/Documentation/config/http.txt
> > +++ b/Documentation/config/http.txt
> > @@ -56,6 +56,21 @@ http.emptyAuth::
> >  	a username in the URL, as libcurl normally requires a username for
> >  	authentication.
> > =20
> > +http.proactiveAuth::
> > +	Attempt authentication without first making an unauthenticated attemp=
t and
> > +	receiving a 401 response. This can be used to ensure that all request=
s are
> > +	authenticated. If `http.emptyAuth` is set to true, this value has no =
effect.
>=20
> Well written.
>=20
> > ++
> > +If the credential helper used specifies an authentication scheme (i.e.=
, via the
> > +`authtype` field), that value will be used; if a username and password=
 is
> > +provided without a scheme, then Basic authentication is used.  The val=
ue of the
> > +option determines the scheme requested from the helper. Possible value=
s are:
> > ++
> > +--
> > +* `basic` - Request Basic authentication from the helper.
> > +* `auto` - Don't request any scheme from the helper.
> > +--
>=20
> What does "don't request" exactly mean?  It is not like we are
> telling the helper "Don't give us anything", right?  Are we telling
> the helper "Give us any username/password for the URL in any
> authentication scheme you know about?"

It means we don't send a `wwwauth[]` entry in the request.  We are
giving the helper carte blanche to decide what scheme is best (maybe it
knows we want Bearer, for example).

> As we are not getting an initial "401 Unauthorized", which is a good
> channel to convey WWW-Authenticate, Digest is not available to us in
> this context; we may end up using Basic---if the other side then
> says "No, I do not like basic, please use Diest in this realm with
> this nonce" with a "401 Unauthorized" with WWW-Authenticate, then
> all we gained was a chance to expose the username/password in
> plaintext (ok, that's still TLS protected in practice so it may not
> be a huge deal).  Hopefully that wouldn't be a problem, but perhaps
> we would want to suggest that this mechanism should primarily be
> used when the user _knows_ that the other side is happy accepting
> you with Basic, or something, in the documentation?

I think it might suffice to say that TLS should always be used with this
configuration.  The documentation is very clear that it will use Basic
if no scheme is provided, so presumably the user is either very
confident in their helper configuration (e.g., they know for certain
that the helper will always emit an `authtype` field because they've so
configured it), or they're willing to accept the risk that the password
is sent with basic auth.

> PROACTIVE_AUTH_NONE being at the first position to be assigned 0
> in this enum has significance, because ...
>=20
> >  static struct credential proxy_auth =3D CREDENTIAL_INIT;
> >  static const char *curl_proxyuserpwd;
> >  static char *curl_cookie_file;
> >  static int curl_save_cookies;
> >  struct credential http_auth =3D CREDENTIAL_INIT;
> > -static int http_proactive_auth;
> > +static enum proactive_auth http_proactive_auth;
>=20
> ... this implicitly initializes the variable to *_NONE and we do
> rely on that value.  It may clarify what we are doing, if we are a
> bit more explicit, i.e.,
>=20
>         enum proactive_auth {
>                 PROACTIVE_AUTH_NONE =3D 0,
> 		...
>=20
> It would give a hint to future developers that they shouldn't
> reorder the enum def without thinking.

Sure, that seems like a good idea.

> > +static int always_auth_proactively(void)
> > +{
> > +	return http_proactive_auth !=3D PROACTIVE_AUTH_NONE && http_proactive=
_auth !=3D PROACTIVE_AUTH_IF_CREDENTIALS;
> > +}
>=20
> An overly long line.

Will fix.

> >  size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buf=
fer_)
> >  {
> >  	size_t size =3D eltsize * nmemb;
> > @@ -537,6 +549,18 @@ static int http_options(const char *var, const cha=
r *value,
> >  		return 0;
> >  	}
> > =20
> > +	if (!strcmp("http.proactiveauth", var)) {
> > +		if (value && !strcmp(value, "auto"))
> > +			http_proactive_auth =3D PROACTIVE_AUTH_AUTO;
> > +		else if (value && !strcmp(value, "basic"))
> > +			http_proactive_auth =3D PROACTIVE_AUTH_BASIC;
> > +		else if (!value)
> > +			http_proactive_auth =3D PROACTIVE_AUTH_NONE;
>=20
> This is how you "reset" the variable that is set in lower-precedence
> configuration source back to the default, but use of "I exist
> therefore I represent true without giving any value" for that
> purpose is rather unusual.  Even if this were about resetting a
> multi-valued configuration variable to empty, don't we usually allow
> an empty string to serve that purpose as well?
>=20
> And more importantly we apparently do not use this variable as
> multi-valued one---the above callback is a bog-standard "last one
> wins" single value variable.
>=20
> So instead of using the "I exist" true, I think it is a lot easier
> to see if you used an explicit string "none" for this purpose.

Okay, I think that seems reasonable.

> >  	credential_fill(&http_auth, 1);
> > =20
> >  	if (http_auth.password) {
> > +		if (always_auth_proactively()) {
>=20
> But when http.proactiveauth is set to either "auto" or "basic",
> always_auth_proactively() returns true (because it is not set to
> *_NONE and it is not *_IF_CREDENTIALS) and we come here, to do
> curl_easy_setop() to use basic anyway.

Yes, iff there's a password.  The reason is that it isn't sufficient for
libcurl to have a username and password to send authentication.  Either
we have to explicitly fill in the Authorization header (which we do with
`authtype` and `credential`) or we have to specify exactly one
authentication scheme; otherwise, libcurl doesn't auth.  Note that
entire branch is not taken if we have `authtype` and `credential`; that
is handled elsewhere.

This is subtle, so I'll mention it in the commit message on a reroll.

> > +			/*
> > +			 * We got a credential without an authtype and we don't
> > +			 * know what's available.  Since our only two options at
> > +			 * the moment are auto (which defaults to basic) and
> > +			 * basic, use basic for now.
> > +			 */
> > +			curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
>=20
> So users with "auto" will not see "Basic" in .wwwauth_headers
> strvec, while those with "basic" will.  Is this intended?  What is
> the expected difference in behaviour coming from this difference?

Yes.  The difference is that a credential helper supporting multiple
schemes will (or at least _should_) read the `wwwauth[]` entry and say,
"Oh, the server only supports Basic auth, so I must send Basic auth",
whereas not sending anything tells it that it may choose freely.  For
example, a helper might legitimately return Bearer for the case where we
don't send a `wwwauth[]` entry (which would be handled differently),
whereas it probably would not want to do that when the option is set to
`basic`.

> > @@ -1292,7 +1331,8 @@ void http_init(struct remote *remote, const char =
*url, int proactive_auth)
> >  	if (curl_global_init(CURL_GLOBAL_ALL) !=3D CURLE_OK)
> >  		die("curl_global_init failed");
> > =20
> > -	http_proactive_auth =3D proactive_auth;
> > +	if (proactive_auth && http_proactive_auth =3D=3D PROACTIVE_AUTH_NONE)
> > +		http_proactive_auth =3D PROACTIVE_AUTH_IF_CREDENTIALS;
>=20
> The webdav http-push is the only caller of http_init() with the
> proactive_auth parameter set to true.  In such a case, if we do not
> see the configuration variable left/set to the default, we force the
> "if-credentials" behaviour.  IOW, if http.proactive_auth is set to
> some value, we leave it as-is even for http-push (which wants to use
> the "if-credentials" behaviour).

Correct.  When this option was a boolean, the if-credentials behaviour
was what happened when the option was true.

> I wonder if there are cases where you would want to do the
> proactive-auth for fetches (which you couldn't do before), but you
> want to drive http-push with if-credentials, and if so, if this
> changes the behaviour in a way that is visible to the end-user.

I think that's remarkably unlikely.  Pushing effectively always requires
some sort of authentication because you don't want random people
modifying your codebase/writing project/other collection of bits.
That's like security 101.

Therefore, you're _going_ to authenticate sooner or later on push.  The
only case where if-credentials is helpful is what I mentioned about
t5540, where we actually have an open push.  That isn't a real world use
case for security reasons, but using TLS certificates to authenticate
and not otherwise sending credentials, which _looks_ the same to this
code, is legitimate.

However, you wouldn't configure TLS certificates for push only and use
regular auth for fetch, since you'd already have the TLS certificate on
the client and you'd have already requested the certificate when
establishing the TLS connection.  Moreover, there's no reason that you
_would_ want to auth for fetches or clones and not for pushes; if your
goal is to make it easier to throttle heavy users, say, pushes are more
expensive because you have to run pre-receive hooks and fsck the data.

Perhaps someone has come up with such an unusual use case and is still
using the WebDAV approach, and in such a case, we can simply let them
send a nice patch to implement http.pushProactiveAuth for that case.  In
the mean time, I'm happy to let one option control both.

> Or perhaps http-push over webdav outlived its usefulness and we
> should send a patch to Documentation/BreakingChanges.txt to declare
> its deprecation and removal, in which case there is nothing to
> wonder or be worried here ;-)

I think cgit still supports it because it's easier to implement in a
CGI-style piece of code, and maybe that's useful.  While I don't use it,
it can be easier to set up in certain environments, and I don't really
want to be the one to announce its demise.

Anyway, thanks for the review, and I'll try to get a reroll out
relatively soon.  I have a couple days of vacation with the Canada Day
holiday, so hopefully I can find some time to get one out then.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--vw4UJzN5NiDNPGT8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZn8yhQAKCRB8DEliiIei
gVirAQCLYCiLqZDOrDz5WQh6dJyo2LicwbQ9uxTqCSI/GDw2gwEArGEgirmVFsxC
hurC+Az0KDmhJ0EgPM1ypIjfqBdhzQQ=
=rCCt
-----END PGP SIGNATURE-----

--vw4UJzN5NiDNPGT8--
