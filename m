Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6CFC4361B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 15:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AA01207A4
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 15:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404196AbgLKOtT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 09:49:19 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:49311 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394973AbgLKOs5 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 11 Dec 2020 09:48:57 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 62758B09;
        Fri, 11 Dec 2020 09:47:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 11 Dec 2020 09:47:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=pbUBn0Pvi7uLjz9KwoYES1UfTQ/
        F/UXHa0Pwqn2g8vM=; b=jWq0GpyqyHqUXIOhsCwdblLGa1VtfZre6MaCDFkKEYa
        s0MUAbnXaC9IvPxSajkbSmoqL14kpqeauZ+utBI8TWGmQpmTftmDk7E9Oiujo5bZ
        AE47Y3JUdMkqHlSVDUwNrj3CD649Wtc8o3DIKj9eIDRzJ1qYP95te1w4zsS8GTDz
        cGpEFIpfRn8Lm/Z8MjDBQTZFKDdSVy7i+pK/ECjfWdaz2GWEhhJtJ3alpzbTyzDA
        1CTnZbntxIUv3jR46lKp87vu5eTwg8vVCcixqg3Mcbf0PYXAyfx+ClAfyazd17nt
        FbAa+vfBL1sWGQ4rUTzvp2E7dWsMJxJkoR8SB3XgMCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=pbUBn0
        Pvi7uLjz9KwoYES1UfTQ/F/UXHa0Pwqn2g8vM=; b=YQWVfzXdDTx4f21DAXp+SR
        Welr9HSBZAjtnvt6x/k+a5mFmk5dTXIeST7aEuP41vjI8D/zv3hn64YfRGGlZCfi
        N87KyF5fZon+o0blWXX3auQ1JB4ayRijVfCxxjDZKkZo4CA2kHhYBfgOqtYvWfVx
        Xf6dKW7lt6IWeEwgDjbiwF4LhOjnaxeWEtyOqTmaJOyz4QLd2ink/3lbUacRKNPf
        tH3n96MQ3rFcU5s+ZEMxv+ydzH/dQlvLHxW6kASPHdnBKxmUz14/2lwUL0BFEmf9
        ik7mz6IM0CPgN1hxYKJf9IBqL7V6lkElgLeyK9CukoW0mQAcOJUAxhr+HU0Vd10g
        ==
X-ME-Sender: <xms:kYbTX1768Qz_sZRDY__QmFwLaiEmTys8vu5g9BQ2_tmtrSUE1nOpRA>
    <xme:kYbTXy4qloSmAl9sEZR6ujNQyYfbREmv1AQF3ZYqNM6uv_ooHASLzS9lFJjmIC-pu
    jXb9E5icjuuK8rMtA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudekvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddunecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeftedugedviefghffhfeffueegteffkedtjeffvdekjeefgedugeeuieevvddvheen
    ucffohhmrghinhepghhithhlrggsrdgtohhmnecukfhppeejjedrudekfedrhedvrdduvd
    einecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimh
X-ME-Proxy: <xmx:kYbTX8ehnRthUhtqWGkRJ9PoXSe6nSrxLws19UPbFA82bZyiEXhNCQ>
    <xmx:kYbTX-IXzluxPpSaECpAVwmjTjXqYZm6xx82y-CD1_mvMmOLj5a30A>
    <xmx:kYbTX5L70Hw88zkPdUMdW7oj8GtMl9PLgiE0r1H1jleo0tgQSmuCpA>
    <xmx:kobTX53-d6PBcWXzJETezQU8UUIrHsbZU2YMd6odlrmvVBwWiPOO6g>
Received: from vm-mail (x4db7347e.dyn.telefonica.de [77.183.52.126])
        by mail.messagingengine.com (Postfix) with ESMTPA id 37DD124005C;
        Fri, 11 Dec 2020 09:47:44 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id e54d2751 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Dec 2020 14:47:39 +0000 (UTC)
Date:   Fri, 11 Dec 2020 15:47:38 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/6] config: allow specifying config entries via env
Message-ID: <X9OGiuUUcVw83obp@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
 <87y2i7vvz4.fsf@evledraar.gmail.com>
 <X9N1hcGl2rKH+CUU@ncase>
 <X9OB7ek8fVRXUBdK@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Xzn0YIXmjerRcoXV"
Content-Disposition: inline
In-Reply-To: <X9OB7ek8fVRXUBdK@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Xzn0YIXmjerRcoXV
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 11, 2020 at 09:27:57AM -0500, Jeff King wrote:
> On Fri, Dec 11, 2020 at 02:35:01PM +0100, Patrick Steinhardt wrote:
>=20
> > > E.g. IIRC this whole series is because it's a hassle to invoke
> > > core.askpass in some stateful program where you'd like to just provid=
e a
> > > transitory password. I think some brief cross-linking or explanation
> > > somewhere of these various ways to pass sensitive values around would=
 be
> > > relly helpful.
> >=20
> > It had been the original intention, yes. And it still is, but in fact
> > the usecase has broadened to also use it to get rid of our global git
> > config in Gitaly. Which is a little bit awkward to do with
> > `--config-env` or `-c`, as now a ps(1) would first show a dozen of
> > configuration values only to have the real command buried somewhere at
> > the back. It would have been easy to implement though with the
> > GIT_CONFIG_ envvars.
>=20
> I don't know what kinds of variables you want to set exactly, but
> another possible option here is some mechanism to point Git to an extra
> config file. This would work if you are setting a bunch of options in
> some static way, but not if you're setting them to custom values for
> each command invocation (because then you'd be dealing with a temp file,
> which is annoying and error-prone).
>=20
> I'm thinking something like a $GIT_CONFIG_ENV_FILE that is parsed after
> repo config but before $GIT_CONFIG_PARAMETERS.
>=20
> Or alternatively, add an includeIf directive that lets you do something
> like:
>=20
>   [includeIf "env:FOO"]
>   path =3D foo.gitconfig
>=20
> which triggers if $FOO is set. But again, that's only useful if you have
> certain "profiles" of config you're trying to set, and not custom
> values.
>=20
> -Peff

The issue we have is that the config file isn't necessarily under our
control. It is in most cases, like e.g. when Gitaly gets deployed via
Omnibus. But we also allow for source-based installations, where the
user configures most things manually. And in that case, we have to ask
the user to "Please set config variables A, B and C". Naturally, this is
easy to forget, will drift apart in future releases and so on.

To fix this, the plan is to move all required configuration items into
Gitaly itself, which GIT_CONFIG_COUNT would've allowd to do quite
nicely. Something like =C6var's proposal to allow reading the config from
a file descriptor would also work, and just putting the whole
configuration into an environment variable (similar to your
GIT_CONFIG_ENV_FILE, but containing contents instead of a path). And
finally, using `-c` would also work, with the downside of making it
harder to see what's going on with all the git processes.

With regards to what we require from the config, you can have a look
e.g. at [1]. It doesn't contain much, but we expect the following ones
to be set:

    - core.autocrlf=3Dinput
    - gc.auto=3D0
    - repack.writeBitmaps=3Dtrue
    - receive.advertisePushOptions=3Dtrue
    - core.fsyncObjectFiles=3Dtrue

Anyway, this is all rather specific to Gitaly and may thus not be too
interesting for other. So in the end, we'll just live with the tradeoffs
of whatever solution we end up with.

Patrick

[1]: https://docs.gitlab.com/ee/install/installation.html#configure-it

--Xzn0YIXmjerRcoXV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/ThokACgkQVbJhu7ck
PpTOkQ//ZqpFvreVpILzs0Ua80c9zjKfG1gQ3pKMWJyzojVMkJTxlQytio6GiLLa
Jby1ARcuUj6FMQyXlcePkgU0K6+c3DtAO+OXD+vqs+q5yOoSk+/Ls0CbPAnuK8IN
+veFrwI9qzCLlGo94Y8hunxqF6HdsLqvCle8BGSdrDRERx0hz7RnfW3lkqR9p2u6
3aBw3RyNAz8vqYhqYC/HVCsJrayCa2qzgpME6IN9OEMF2cJupZE9sAoELNruQNB4
g3nlfNa3VX0kuWV8+TbC/tDX0pb39mULFAVPPCMd2XwoZ0OQGrV29qD4Vi8JtZXc
f3biq6xB+hwF9i0SGsjVmszkOgrgFYu4CT7Y77jH0VDDR4FElUQ2pVI8X6iGKXWa
htF13hyPWsaNL+fx9tlvbD8i7fB6lRkB2Zn3Y3697a+OCW712SrcbJiM33XPPbno
iQGyQOFtpkA9NLLIUccWIkjurbcahyR3opGN/9Ue4saQfIspd4bJJJBR8JA/4h7N
apxlO4IWqMJKVv+7DW/96BbsF2O5n7fVw80zDWIOBEGRmG9lyldCVj0Aurl+0NyZ
bnrqW8OvFbAdY//x5PjmnZO+5/tp6HzrWdKH74SW/cyPGoXG5QHAMvAjqbnD5jQ8
lNasi2OG+VZNCC/SHyT9LsWKPTsnYAMxsR3QXpTDtolJWKbKdm0=
=1Z60
-----END PGP SIGNATURE-----

--Xzn0YIXmjerRcoXV--
