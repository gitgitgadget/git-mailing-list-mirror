Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A192C64E75
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 07:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C32C1206E5
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 07:06:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ekZGrFZO";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RNgkmgEn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgKYHG2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 02:06:28 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:39377 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727130AbgKYHG1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 25 Nov 2020 02:06:27 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 181235C013C;
        Wed, 25 Nov 2020 02:06:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 25 Nov 2020 02:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=e56Qr1D6Q0JN4rMrfeGzT4AFV7j
        tQdKJQ4sStziYIhk=; b=ekZGrFZOe/BnJgVKTavprX8fR8NMA2MeblvoLTTYvgj
        NxmYgb1jwoEtSgRzAx6Xuxj2b1ZXANwm4+7BsowflFUciZkfFQ195YmYXUm4dDXS
        lDe0WTX5ThTynIpyVAzkkHrwv/LFsZuTeJL2lFErnEzoTU6ORLjZyowMSKwwcGWj
        jgY2MIxeoquRiGkaMWc5YTewxL1zZVBZR6/+zgr6Yd8irYpS474/CuVGih+H5IUI
        CohPo7hKWJQs+RWiLqmfEGELF13v200hYu9ORsME6tTqKtDS7GYZwjfdZ7fHRSoW
        pocZ11JPG9+EaJyWnvSZCCjAGOCb1Sr8nupDBdxgk6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=e56Qr1
        D6Q0JN4rMrfeGzT4AFV7jtQdKJQ4sStziYIhk=; b=RNgkmgEnq+BE7oE51wQJ8P
        Evh/AA3yUPEF5xkTGsctM+PLY+QUj9H3ujceX2eJo4kTcf7cGHBURh2780+fB9Ho
        Cd5IUCcwhtyUCQu/RQkUFAew8dyF53ce1G5XJ+e+MactG4eY473nOz/a83p8wCWA
        nflHBh9vEgjgRCD/Aa6DuI1hYT9PX5o+d33A/e4AWVplvDn4kmEsnvpZaFQxtS7G
        h44lkr7xbIlcV4SZRj4NlWa2Hq/kEB54rzLK2cr4cFKfoD86AIbQ+EXVXYAHLKor
        1+5p9EZuODsPhjyzyzsiHT86WJ/ngUnuwInKVLGdltedUrxbG8UBELsd+zktJQpw
        ==
X-ME-Sender: <xms:cQK-X1Y0w9BM98oB4x1xcMxE6HZtOG5v2NSfqzerHfvj2TnxCO5mVQ>
    <xme:cQK-X8aoYF-N8qacssLOGR7s5vfNRfmV2VzRlXcjxsGmHcT6vRpuQgiD8rna588CG
    lJlNApO47DLexiVCg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudegledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejjedrudeluddrfeelrddvfeehnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:cQK-X38YsrU-LJD8bH5Qczk4BjpGx9TE7SFkS_3-IIUCUByaenhk4w>
    <xmx:cQK-Xzr0zVqQuxQdDUuI6jma0A-eaN6FGEH1oNpYBRRQYEwHLuZJpQ>
    <xmx:cQK-Xwrd2GAjmPuixgLjmmn0mOQWKKA8-hKasi1FYBrk6htfN-pv8Q>
    <xmx:cgK-X7W5VfxnMCu5Xq0BraXlaYxNp_uGjyqaMBIMv7eDZ7Vho_495Q>
Received: from vm-mail.pks.im (x4dbf27eb.dyn.telefonica.de [77.191.39.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 7C2513280065;
        Wed, 25 Nov 2020 02:06:24 -0500 (EST)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c0c1ada7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 25 Nov 2020 07:06:20 +0000 (UTC)
Date:   Wed, 25 Nov 2020 08:06:50 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v2 2/2] config: allow specifying config entries via
 envvar pairs
Message-ID: <X74CigYS7AUtMo9Q@tanuki>
References: <cover.1606214397.git.ps@pks.im>
 <97740ada840a1e2f151003e695de9f2efa5a7e62.1606214397.git.ps@pks.im>
 <xmqqtutef6kb.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/fyQ+076vi/VL8Zy"
Content-Disposition: inline
In-Reply-To: <xmqqtutef6kb.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/fyQ+076vi/VL8Zy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2020 at 07:39:48PM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > +GIT_CONFIG_COUNT,GIT_CONFIG_KEY_<n>,GIT_CONFIG_VALUE_<n>::
>=20
> I think we write a header with multiple/related items like this
> instead:
>=20
>     GIT_CONFIG_COUNT::
>     GIT_CONFIG_KEY_<n>::
>     GIT_CONFIG_VALUE_<n>::
>=20
> See how -f/--file is marked up in an earlier part of the same file.

Ah, thanks. I wondered how to format these but didn't spot other
examples.

> > +	If GIT_CONFIG_COUNT is set to a positive number, all environment pairs
> > +	GIT_CONFIG_KEY_<n> and GIT_CONFIG_VALUE_<n> up to that number will be
> > +	added to the process's runtime configuration. The config pairs are
> > +	zero-indexed. Any missing key or value is treated as an error. An emp=
ty
> > +	GIT_CONFIG_COUNT is treated the same as GIT_CONFIG_COUNT=3D0, namely =
no
> > +	pairs are processed. Config entries set this way have command scope,
> > +	but will be overridden by any explicit options passed via `git -c`.
> > +
> >  See also <<FILES>>.
>=20
> Doesn't this <<FILES>> refer to GIT_CONFIG and GIT_CONFIG_NOSYSTEM
> that are described earlier?  It certainly looks out of place to see
> it after the KEY/VALUE thing.

Right, my fault.

> > +		for (i =3D 0; i < count; i++) {
> > +			const char *key, *value;
> > +
> > +			strbuf_addf(&envvar, "GIT_CONFIG_KEY_%d", i);
> > +			key =3D getenv(envvar.buf);
> > +			if (!key) {
> > +				ret =3D error(_("missing config key %s"), envvar.buf);
> > +				goto out;
> > +			}
> > +			strbuf_reset(&envvar);
> > +
> > +			strbuf_addf(&envvar, "GIT_CONFIG_VALUE_%d", i);
> > +			value =3D getenv(envvar.buf);
> > +			if (!value) {
> > +				ret =3D error(_("missing config value %s"), envvar.buf);
> > +				goto out;
> > +			}
> > +			strbuf_reset(&envvar);
>=20
> Didn't we got bitten by number of times that the string returned by
> getenv() are not necessarily nonvolatile depending on platforms?  I
> think the result of getenv() would need to be xstrdup'ed.
>=20
> cf. 6776a84d (diff: ensure correct lifetime of external_diff_cmd,
> 2019-01-11)

We did, but do we have to in this case? There is no interleaving calls
to getenv(3P), so we don't depend on at least $n getenv(3P) calls
succeeding without clobbering old values. It's true that it could be
that any other caller in the callchain clobbers the value, but as far as
I can see none does.

Anyway, I'm not opposed to changing this if you think it to be
necessary.

> > +			if (config_parse_pair(key, value, fn, data) < 0) {
> > +				ret =3D -1;
> > +				goto out;
> > +			}
> > +		}
> >  	}
> > =20
> > -	for (i =3D 0; i < nr; i++) {
> > -		if (git_config_parse_parameter(argv[i], fn, data) < 0) {
> > -			ret =3D -1;
> > +	env =3D getenv(CONFIG_DATA_ENVIRONMENT);
>=20
> > +	if (env) {
> > +		int nr =3D 0, alloc =3D 0;
> > +
> > +		/* sq_dequote will write over it */
> > +		envw =3D xstrdup(env);
> > +
> > +		if (sq_dequote_to_argv(envw, &argv, &nr, &alloc) < 0) {
> > +			ret =3D error(_("bogus format in %s"), CONFIG_DATA_ENVIRONMENT);
> >  			goto out;
> >  		}
> > +
> > +		for (i =3D 0; i < nr; i++) {
> > +			if (git_config_parse_parameter(argv[i], fn, data) < 0) {
> > +				ret =3D -1;
> > +				goto out;
> > +			}
> > +		}
> >  	}
> > =20
> >  out:
> > +	strbuf_release(&envvar);
> >  	free(argv);
> >  	free(envw);
> >  	cf =3D source.prev;
>=20
> With re-indentation this patch does, it is a bit hard to see the
> correspondence between common lines in preimage and postimage, but I
> think the patch adds the support of the new style environments
> before the existing support of the GIT_CONFIG_DATA, but when there
> is no compelling reason not to, new code should be added near the
> bottom, not before the existing code, in the function.
>=20
> Otherwise, this part of the patch looks OK to me.
>=20
> Thanks.

It is required as this is what sets precedence of GIT_CONFIG_PARAMETERS
and thus `git -c` over GIT_CONFIG_COUNT. It's easy enough to split this
into two patches though, with a first refactoring which does the
indentation and a second one which adds the new code.

Patrick

--/fyQ+076vi/VL8Zy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl++AokACgkQVbJhu7ck
PpThFQ//bFnc1FCkeVUc64gY71PHUIu/iLfVe11D+ISWd0w14Sz3/KCozx0fe6Bt
fAGvcEICH20x27C88Cz+loAhNQPAywCt906Zi0QLrsl3JRL26gE89dFgYKajXmBm
EugED/ztMmqUa3zALmN0ITqlSU9xdMmtZlplxvl20de7y1xbPRwGns5KnSF2U2QG
Z9Gc2O3fuoJl9yJi9qy8MVKKIha524d5kVc8Obt7x628o8SdEnlFsmQR1fLusXlp
14fMPm4qeHcdRcfISkOdAeiOc0PUzs3oMWXtVizMTmr7gUzdE++JpgWBSQQqajj/
ubwEXbqXr0rsUShkbNshUIV/pVyrPoJTR50DCMWDx7FE+ydKvrLuWVq9Ep1CTIZV
7ENvF1z2a9f/oOhu57Va3xd81Q125bg+46aDpee/TAgyFtq5KiIbG+2pnqahUmHg
XsHGa/wQ5LrM2FWMOqjjZZh+UCITX3V/V6bDKYXJ7NNZPoXcxi+gfY2ezZkNV8zu
lrpXSHwr+q1uxtp2XGidEQKvIj0TCN02hzGgAk5YCGn9COtqAhlJ5RMboV0NcBfz
iF8HKyaW9Dx9QghEk4gDT8ZBt40pJJ69yJDSMTPxIzDb9yJrfh7izKPxJb1g+KaH
5Ijotdh0rs20kiDZ6n5oKfewzbA0t7hKDWLtIU4qPHmuJ8bdclQ=
=qyim
-----END PGP SIGNATURE-----

--/fyQ+076vi/VL8Zy--
