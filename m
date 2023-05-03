Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83728C77B75
	for <git@archiver.kernel.org>; Wed,  3 May 2023 11:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjECLhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 07:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjECLg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 07:36:57 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F455FE4
        for <git@vger.kernel.org>; Wed,  3 May 2023 04:36:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9E3695C037C;
        Wed,  3 May 2023 07:36:28 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 03 May 2023 07:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683113788; x=1683200188; bh=6o
        FU6Np7W0P7rT78gfXoJ3bcZrWUkrqbBEWewOjKPQo=; b=AANJqgAKFpjw6m1lcK
        QLEpr4qHMXh7uDepsnQtIQ6lpz/PDd29cW9ttldT6PF0Nf5+ZVfHuWUdXaPVBlVL
        A2oKjVbH7t+3pb/BqucCT6wo2B6+N8INIPpHsokOXgw7Yeoy9FvXh8NEfxhRrVOC
        9zF7fX+KHtGMFkrIf6J+TNbvaLyNbemHpn1j2eFxZ9lWWsvT9E+2OmUM7BHxYmoP
        MB7CfJvuqXobh9+UPPos6uzdqh80pmLuBhFLHFh2oE5/3XngbzCqNufZ6uxE1BPE
        QM3SVW7tsg4kVVEM9o7ceZdniPH5Jp6XEjvYAov17bCU1+pbo7NuWv/fZAOTa6Wa
        03gQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683113788; x=1683200188; bh=6oFU6Np7W0P7r
        T78gfXoJ3bcZrWUkrqbBEWewOjKPQo=; b=ABSsJmqBq7/zS7WgJcSyDQUHlUKNi
        768ORVtKygBHpohjaiCEnmrI5BQi2sdmo3CbGhMqJ0JSlycIYfFv5oA5JEp+zbed
        vbYgLZQtI+eGjfXDQZojux7lMMPoIV+s2Fdca/71yfHxlU8Xy0FZBMSKA1yDunoj
        mRNgbbODrHKmOPqUEX/7z1qca1vuKKxsuPKABZ3pP0NyQxUfXQKcMuBJN87QZXVD
        ylQjz0GIUAqGMV2jfyhGeREn/wHR68r3NJNPVAdfHxLnNSW7fifWrIagxLIVNupJ
        PqyKGLge+3wkhzDLM+z4S6rbdi1uZVn62THyb+uOCnp8Vj7dM+jUri7fQ==
X-ME-Sender: <xms:PEdSZM_HuLsFH-knZVNaO2LX-_hxbWw6CSHGcWXD8n8kENVeXy18WQ>
    <xme:PEdSZEsp--10lD4CRMvNp_NmG8VNa83zlqC7QIiakMtHIobpSUPZ2qZx296jZswPz
    dDcuwfXguZoKxf8gg>
X-ME-Received: <xmr:PEdSZCBPjg2cA9hQR-I0QiZnF5gEJmQQAFeLsAJKZfecxpg_pn11jPqbWLSzdqttrfD_7NqkCYZ2_VVSUUHwOXeztsTuDREfi_aJA4q0fO3y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:PEdSZMfcEZex8W0E58pxT8YwyCPIrwWHHzdWIY-5GrVcdb7WjhZE5Q>
    <xmx:PEdSZBOPrbSEAdEVxhx2QVQ0cS6xTnVSyBThs-1-xh21lxIvuohwjA>
    <xmx:PEdSZGmZ27yZSi2y14PWf8STP4MmG-NiSfzvyJ6clAEQx4_aIiKc3g>
    <xmx:PEdSZGqUiV8qh0ggXmRIczz8e_5dGWl9LMc8RfJHJ8nEvFcOeIVwkw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 May 2023 07:36:26 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id dcdfef32 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 3 May 2023 11:35:45 +0000 (UTC)
Date:   Wed, 3 May 2023 13:36:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 7/8] fetch: introduce new `--output-format` option
Message-ID: <ZFJHOLCQpyeWEPB7@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1682593865.git.ps@pks.im>
 <0335e5eeb4ded336c5ff7c8888c8aab9dfed2505.1682593865.git.ps@pks.im>
 <kl6l5y9f3ahf.fsf@chooglen-macbookpro.roam.corp.google.com>
 <ZFIsw94SBxRVkWmz@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HIQamP2Ej+x7iBG+"
Content-Disposition: inline
In-Reply-To: <ZFIsw94SBxRVkWmz@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--HIQamP2Ej+x7iBG+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 03, 2023 at 11:43:31AM +0200, Patrick Steinhardt wrote:
> On Fri, Apr 28, 2023 at 03:31:08PM -0700, Glen Choo wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > > @@ -1894,6 +1902,9 @@ static int fetch_multiple(struct string_list *l=
ist, int max_children)
> > >  		     "--no-write-commit-graph", NULL);
> > >  	add_options_to_argv(&argv);
> > > =20
> > > +	if (format !=3D DISPLAY_FORMAT_UNKNOWN)
> > > +		strvec_pushf(&argv, "--output-format=3D%s", display_formats[format=
]);
> > > +
> >=20
> > I think these lines belong inside add_options_to_argv(), since that's
> > also used to prepare argv for fetch_submodules(), so we'd also get
> > support for --recurse-submodules. (I wish I had spotted that in v1,
> > sorry. Thankfully they use the same helper function, so we only have to
> > do this once.)
> >=20
> > ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
> >   diff --git a/builtin/fetch.c b/builtin/fetch.c
> >   index 422e29a914..7aa385aed5 100644
> >   --- a/builtin/fetch.c
> >   +++ b/builtin/fetch.c
> >   @@ -1796,8 +1796,11 @@ static int add_remote_or_group(const char *nam=
e, struct string_list *list)
> >     return 1;
> >   }
> >=20
> >   -static void add_options_to_argv(struct strvec *argv)
> >   +static void add_options_to_argv(struct strvec *argv,
> >   +				enum display_format format)
> >   {
> >   /* Maybe this shouldn't be first, idk */
> >   +	if (format !=3D DISPLAY_FORMAT_UNKNOWN)
> >   +		strvec_pushf(argv, "--output-format=3D%s", display_formats[format]=
);
> >     if (dry_run)
> >       strvec_push(argv, "--dry-run");
> >     if (prune !=3D -1)
> >   @@ -1908,10 +1911,7 @@ static int fetch_multiple(struct string_list *=
list, int max_children,
> >     strvec_pushl(&argv, "-c", "fetch.bundleURI=3D",
> >           "fetch", "--append", "--no-auto-gc",
> >           "--no-write-commit-graph", NULL);
> >   -	add_options_to_argv(&argv);
> >   -
> >   -	if (format !=3D DISPLAY_FORMAT_UNKNOWN)
> >   -		strvec_pushf(&argv, "--output-format=3D%s", display_formats[format=
]);
> >   +	add_options_to_argv(&argv, format);
> >=20
> >     if (max_children !=3D 1 && list->nr !=3D 1) {
> >       struct parallel_fetch_state state =3D { argv.v, list, 0, 0 };
> >   @@ -2403,7 +2403,7 @@ int cmd_fetch(int argc, const char **argv, cons=
t char *prefix)
> >       if (max_children < 0)
> >         max_children =3D fetch_parallel_config;
> >=20
> >   -		add_options_to_argv(&options);
> >   +		add_options_to_argv(&options, display_format);
> >       result =3D fetch_submodules(the_repository,
> >               &options,
> >               submodule_prefix,
> >=20
> > ----- >8 --------- >8 --------- >8 --------- >8 --------- >8 ----
> >=20
> > I tested the result of that locally with --recurse-submodules, and
> > it works.
>=20
> Unfortunately it doesn't quite work alright: while the porcelain format
> does indeed get inherited to the child process correctly, the parallel
> process API will cause us to group output per submodule-fetch. This has
> the consequence that stdout will be redirected into stderr, and that
> then breaks the assumption that all machine-parseable output goes to
> stdout.
>=20
> My initial reflex is to just outright reject porcelain mode when
> submodule fetches are enabled. But that would require the caller to
> always explicitly pass `--recurse-submodules=3Doff`, which isn't exactly
> great usability-wise.
>=20
> The alternative would be to ungroup the output so that we can continue
> to print to the correct output streams. That works alright, and I've got
> a working version that does exactly that. But now we have the issue that
> the porcelain output is misleading: you cannot tell whether a specific
> reference update happens in the parent repository or in the submodule as
> that information is not part of the output.
>=20
> I consider the second option to be much worse than the first option
> because it can cause scripts do to the wrong thing. So I'll send v3 with
> the first option, even though it's kind of an awful workaround. I'd be
> happy to hear any alternative proposals though.
>=20
> Patrick

I've gone with a slightly different variant of the first option that is
inspired by `--negotiate-only`: instead of refusing to run, we disable
submodule-fetches unless explicitly specified on the command line. In
that case we return an error.

Patrick

--HIQamP2Ej+x7iBG+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRSRzcACgkQVbJhu7ck
PpS0MBAAgK1lIvgWWwf/FYQLkGbIYSXivfHu2E6qrC+GrIbHrlR7lHFzyqPfAWNh
FGzwGGU3mUEbfGdv6dg9GVQftx07zO0wYWj1PcU+3MUFgZv6QfGEDZIegFEAuoLJ
h+fBzuFM6Nwe43BJRJDdDM705C2wRMjHijU/keBNWF0u8dLpgIcmVmWKUpRVKAT2
yh7hM+9zsGKVGg1Let28yxGiFCVaeJLb7yrNtomY9qQlmueljSI1XEjUbxT++8Vh
DACPcA0heHH+3VZdHwnBGKEFyvKY9UyImQ52CZLoDcHGLaDxRQiGEHjg5sgmrOyg
jkX+9PbT3M5WrIbXWj4lEvgm5ZQCjY5HloXrfLH2432a7xYGirUQvS5jguCzo1JL
Pw9tJljqqwYruljhvSOz5Oe2IwcjAOUk5adYzjqF9LKWipbucUQDCk4qu200L0ka
zDcSQcF1ByENbz6P/LJbgXDJOTbqvAINSM/u0SdSqM6zvRfh3DG7B3/afR1b272G
9VQfUqmgY3LWjRlLwzWHO4RkYjBahMsheRDtAsU2gDHrMKHuk9wRTaBDDnaTrMli
Ohm9u14xl+01OM3qYcSPbGrpMXwSD4zRfoeeRroRqu59Jl4MHp7tuBuZcfLcb7sg
VZ6+TYSLvywRgondETAOUrW1m2E08/pmG2TFQbIvzWLScIig1yI=
=UrbY
-----END PGP SIGNATURE-----

--HIQamP2Ej+x7iBG+--
