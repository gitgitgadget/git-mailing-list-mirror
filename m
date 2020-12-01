Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C07F3C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:49:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB16420770
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 09:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oIDtbrgn";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZ+JSmmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728799AbgLAJtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:49:14 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:56269 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727256AbgLAJtN (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 1 Dec 2020 04:49:13 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id DF4BF11F1;
        Tue,  1 Dec 2020 04:48:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 01 Dec 2020 04:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=YPRi+qtsR3wGf2hFnS7dtDF/Lze
        xZli0jhVZhL6/J6E=; b=oIDtbrgnwdbS1WrsD2f4KhBUd/dlD+ciTRuaE6vsO0V
        nXwycVX4q8qsuY5rf/D168XOHgiAjAjoG18N9SE6YYCSo/m835uLKwRnpfhClsh5
        2ZtXjFCbTwXWOoE/STjpT/Y2wO8aHiF37JOIo2/B3XBuOwqfA2YkcAaZimvycKAK
        880O4FvJg9CROY3HEDbFzVWQxzfy9wQmNBlsHeLUEvA+pu2SYdVyrkL9B2kGuRGa
        KEAH7zf2bpGDSpbXEpJKGwjDngwtrPDgxlwEea5M2862AhJnNqEPqRZpBCH7eEfC
        TaqeuPCMeG7gx8Que+k2UioCBKdSDUG5VeFpiRfwV6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=YPRi+q
        tsR3wGf2hFnS7dtDF/LzexZli0jhVZhL6/J6E=; b=iZ+JSmmy6elNxsvM/1bjho
        0gz2Wk+PePMj/L38Sw0MhJ7sT62daNHC0SGidtstqurw5LusJ5X7AiNGuTpudeY6
        1hLmZld2cGKzLH2iPmScEWOrDsp66+90ecHPU+6OUiL1ENYLU470HZmOLJv0dSXj
        C7kfGIje2O16M19Bo6QF8VnVOtW9hfwqVexBci1bJSFlnULx9GPBOMFzRUmkkBDf
        8kFJHNG0Ik01APmDJPw6TBWSD46QzsdWc3tDYUq9UYUR9TlYMTCjsuNW2gCBQwzP
        OCmuTKYL+zvgzJI0rWbAAcYP7oCasnES1mjeyvZlE7UsRzzAS8g9qkMIwB7soa/A
        ==
X-ME-Sender: <xms:UBHGX8_aDnU_8sUB_7T2IiywpFKk6XPF2mMyrpAp5oKMeny3hw42-Q>
    <xme:UBHGX0tAs7CZYQSOpF5F59whE-TC2sRk2XYWFB8lbJ9sFQ25p3Rb7I3kvLb0d7MQM
    VX9UavXhpHFRkhd8A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeivddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehgedrudegrdehjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:UBHGXyAamo6n-JBD6EopFCQRjd1LQD7lQq-_Hds9nq2l8_nnfqPgdQ>
    <xmx:UBHGX8dLeUW18jFYiYjKDQBt230ngX0MryXJcS6XEBV3b9YVh9ml5w>
    <xmx:UBHGXxPScThyTbh92L9gEGfOSygGpwmDtxyia0ZkenfgenC-lfHZEQ>
    <xmx:URHGXyrKWOW0iUtKi7lnSQV1cKZsYmylaMbF8iJBn7IVdXdf4KQOoA>
Received: from vm-mail.pks.im (dynamic-078-054-014-057.78.54.pool.telefonica.de [78.54.14.57])
        by mail.messagingengine.com (Postfix) with ESMTPA id F1E843280059;
        Tue,  1 Dec 2020 04:47:59 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 934683e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Dec 2020 09:47:57 +0000 (UTC)
Date:   Tue, 1 Dec 2020 10:47:56 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 0/2] config: allow specifying config entries via
 envvar pairs
Message-ID: <X8YRTPPfkRqo23ll@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <X740yqoYIhrqsNRE@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CYzAtfk5bmQFO3X/"
Content-Disposition: inline
In-Reply-To: <X740yqoYIhrqsNRE@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--CYzAtfk5bmQFO3X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2020 at 05:41:14AM -0500, Jeff King wrote:
> On Tue, Nov 24, 2020 at 11:50:46AM +0100, Patrick Steinhardt wrote:
>=20
> >     - I've changed priorities. The envvars are treated as command-level
> >       and as such override all values configured in files. But any
> >       explicit `git -c key=3Dvalue` will now override these envvars.
>=20
> That ordering makes sense. Those get passed through the environment,
> too, but at some point there is a process where your new ones are in the
> environment and the "-c" ones are on the command-line.
>=20
> I do still think that a "--config-env" option solves your problem in a
> much simpler way (especially in terms of interface we expose to users
> that we'll be locked into forever). I sketched out the solution below if
> it's of interest (and I'd be happy to polish it up, or hand it off to
> you if so). But if you're unconvinced, I'll stop mentioning it.
>=20
> diff --git a/config.c b/config.c
> index 8f324ed3a6..d8cf6a5d6b 100644
> --- a/config.c
> +++ b/config.c
> @@ -345,6 +345,27 @@ void git_config_push_parameter(const char *text)
>  	strbuf_release(&env);
>  }
> =20
> +void git_config_push_env(const char *spec)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	const char *env_name;
> +	const char *env_value;
> +
> +	env_name =3D strchr(spec, '=3D');
> +	if (!env_name)
> +		return; /* die or warn? */
> +	env_name++;
> +
> +	env_value =3D getenv(env_name);
> +	if (!env_value)
> +		return; /* die or warn? */
> +
> +	strbuf_add(&buf, spec, env_name - spec);
> +	strbuf_addstr(&buf, env_value);
> +	git_config_push_parameter(buf.buf);
> +	strbuf_release(&buf);
> +}

I realize that you say it's yet unpolished, but doesn't this have
parsing issues? The first strchr(3P) probably needs to be a strrchr(3P)
to correctly parse `includeIf./home/foo/=3Drepo.path=3DMY_PATH_ENV`. But
we'd also have to handle shell quoting for the user, don't we?

Anyway, I'd be happy to adopt is as part of the series if we care
enough. For now I'll send out the current state I have though.

Patrick

>  static inline int iskeychar(int c)
>  {
>  	return isalnum(c) || c =3D=3D '-';
> diff --git a/config.h b/config.h
> index 91cdfbfb41..d05651c96c 100644
> --- a/config.h
> +++ b/config.h
> @@ -138,6 +138,7 @@ int git_config_from_mem(config_fn_t fn,
>  int git_config_from_blob_oid(config_fn_t fn, const char *name,
>  			     const struct object_id *oid, void *data);
>  void git_config_push_parameter(const char *text);
> +void git_config_push_env(const char *spec);
>  int git_config_from_parameters(config_fn_t fn, void *data);
>  void read_early_config(config_fn_t cb, void *data);
>  void read_very_early_config(config_fn_t cb, void *data);
> diff --git a/git.c b/git.c
> index 4b7bd77b80..342f2fb0c9 100644
> --- a/git.c
> +++ b/git.c
> @@ -254,6 +254,8 @@ static int handle_options(const char ***argv, int *ar=
gc, int *envchanged)
>  			git_config_push_parameter((*argv)[1]);
>  			(*argv)++;
>  			(*argc)--;
> +		} else if (skip_prefix(cmd, "--config-env=3D", &cmd)) {
> +			git_config_push_env(cmd);
>  		} else if (!strcmp(cmd, "--literal-pathspecs")) {
>  			setenv(GIT_LITERAL_PATHSPECS_ENVIRONMENT, "1", 1);
>  			if (envchanged)

--CYzAtfk5bmQFO3X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/GEUsACgkQVbJhu7ck
PpRlCw/+PkheUovlK9SBO1a5PGJif+g/djhK5xTnXn9Hz6O1hf5SVaGb/gLoFwX/
8I2xge8jRFw1ULTtE+0sWMMOFxiW5rIrh3ho9F3gboYZg+dU2CW06oAOgx0IbD6q
ujksg7WlMiFUKOgmuRhNkNMaOls6RdQbHl8/CO9EdeBdMbQCD5PJR9a1EhE4ak81
fT6JUEKOKaKrOs0FTcxB/32JUeMfAGX/2TMqJF+QxRzDu9NVnBoxm+SPC6UEtk6v
UYb7b61TqXv77fur8hTNjE3W8F8uyG48u/+2UohQxqOo6x8HK3ZrHKYsnSqQzY8z
m0tsf0jVY+kySLN/GcoDLcmcHAXUsN3S5txkWPg7t+bbm/sESnwenduQNNFiNZ0K
gWQgbwhAIA2ZcbaVzY+DQWEJNCVXNQljJgtzjg42p+rIgyy9U0fv7vAgmddLH+sm
cezGN2DaPbkQpldnyZdL2Jm51pd6F+ntaFcyqXV+uh1VS5oCoG/0EnVGCuvCMVZc
KuWflBdxdmAy7i7f6OoCbEffbCGJ/27XcKglv7BOg8VQVWPk0h8q92yU9lSwBOBF
zPup8ugFSrkd00GJbLvz6ee0rQgwMnAQmiaNGVTfZLzmKfKhDcL+9b+0yAu3Byue
oiw8LglAqNtNr1QmLElISi0Z9WjbQjiv40qfrqNLyGjfPqm03TA=
=6cfx
-----END PGP SIGNATURE-----

--CYzAtfk5bmQFO3X/--
