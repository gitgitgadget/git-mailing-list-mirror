Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28073C11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08D2061DA6
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 06:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhF2GVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 02:21:02 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:55203 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232027AbhF2GU5 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jun 2021 02:20:57 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 6E6263200913;
        Tue, 29 Jun 2021 02:18:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 29 Jun 2021 02:18:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=SWkoMCdu1pCujG+lx4L3CAlt29S
        k34QxWvtf76t+36U=; b=FvqB3+2W5t/YBNt2GDHMP4EzD2mscI5W0neO6n6qDo3
        HS1AtpHzcD8sS/DeIUIQ+vaBQcWFJGlaX9Thhtd04NmoLA9H2rVqT91wtJ1l4e4G
        fojNu7oOgv4rUnvfbkmmXoH9FwR+Q/KMgBo728t73iQDoV09a4noSRcHJSQG97AL
        UN72BefVx6WWrvPZNbsEfBWULlKON79DumhobdnPHeY2/vEbAhg9tGVqTjte0m75
        WOHXWD5vev7RFVORJH7OLatLSlEHvT4fvIKRV/N5VFmLVO8m2EGbwZrvMd1h21Ir
        8rrmhGQIvMmrt6Dvt7xiLnR4hW6O5KpaeHfkOXmvbFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=SWkoMC
        du1pCujG+lx4L3CAlt29Sk34QxWvtf76t+36U=; b=dS4v0djoqkbFxcXPqm73uj
        rr+7bpxxHeCkK5b0N6MuZDgUlbVW0xTzmTc3Ho1MVGRAdxS1hX9DvuIsSIy/Xt30
        66FG1r6LZqUTaevKQs7ifpxYEJevuaRJNO1IW4S+pRVz6dT+TjZh0Mit7nbaJJX4
        umXz9l01iH5qU1XTPek/EEuVclZmQ8vchoYr0JpMiPd6//Dz5/WU/CDzws0Xtiyf
        Zz7pVrDX4WrttGwTcsH5lMPb0RFrp40piNYCG//9jgcV6P8oXU9NJoBsht8+gw6f
        GsznvW5Ca9BxJ/JUoB1HEvK6++MsSxlNNB+5OGaxGR7jpaZc9liJzi0aGWqMbGRA
        ==
X-ME-Sender: <xms:NbvaYBCssZ77Oam_bzZYE2VdrnuCJFxYZJQ57vIX8iUllYGLLZR60w>
    <xme:NbvaYPi-8vg4cu5YXHgEjIFsWQtl-ZLYdcvFE1IloozwuOrqbBw-MWaWnXZ1xEHzt
    0tmGmTad2rxTGLodQ>
X-ME-Received: <xmr:NbvaYMl37ioEnShbYqSXEjKo-iIoB8farq4WCzMhUAKOewxGTNe9VAePlV7Z7mzibqx7qSMxr2imnpuJEBYdxCTH55WWYurVjOr7PivoRlT3mMpvDpI9Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehhedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtudenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnheptdffjeeiudduleehvdfgteeifeelheejtedvteduiedttedvtdffffefhfdvgffg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NbvaYLwCV4dhBs3S7iXIg1g5DPp3pxPJ0yqypUyflqP_wAce1dveWQ>
    <xmx:NbvaYGTWFJabknZNSvCdHD3E-shHk_9FZWbds02LXL17_gR0zSplMA>
    <xmx:NbvaYOa8k3xna3CGm1xDDis4IdC2t1rC3Ioia7ZBhRM7J_u4BhAZnA>
    <xmx:NrvaYDK3l0zgLPydqOoOwIdxMDYOMB49OYSFPsXhBsoJUyCupsoLUA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Jun 2021 02:18:28 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a4f6031e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 29 Jun 2021 06:18:25 +0000 (UTC)
Date:   Tue, 29 Jun 2021 08:18:24 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/3] p5400: add perf tests for git-receive-pack(1)
Message-ID: <YNq7MD/fMQp05I21@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <2f6c4e3d102e71104d7d00c78631b149b880609a.1624858240.git.ps@pks.im>
 <871r8mxvvx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2KNyko00sAnty2M1"
Content-Disposition: inline
In-Reply-To: <871r8mxvvx.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2KNyko00sAnty2M1
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 28, 2021 at 09:49:54AM +0200, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Mon, Jun 28 2021, Patrick Steinhardt wrote:
>=20
> > [[PGP Signed Part:Undecided]]
> > We'll the connectivity check logic for git-receive-pack(1) in the
> > following commits to make it perform better. As a preparatory step, add
> > some benchmarks such that we can measure these changes.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> >  t/perf/p5400-receive-pack.sh | 97 ++++++++++++++++++++++++++++++++++++
> >  1 file changed, 97 insertions(+)
> >  create mode 100755 t/perf/p5400-receive-pack.sh
> >
> > diff --git a/t/perf/p5400-receive-pack.sh b/t/perf/p5400-receive-pack.sh
> > new file mode 100755
> > index 0000000000..a945e014a3
> > --- /dev/null
> > +++ b/t/perf/p5400-receive-pack.sh
> > @@ -0,0 +1,97 @@
> > +#!/bin/sh
> > +
> > +test_description=3D"Tests performance of receive-pack"
> > +
> > +. ./perf-lib.sh
> > +
> > +test_perf_large_repo
>=20
> From the runtime I think this just needs test_perf_default_repo, no?
> I.e. we should only have *_large_* for cases where git.git is too small
> to produce meaningful results.
>=20
> Part of th problem is that git.git has become larger over time...

I did these tests for 3/3 with git.git first, and results were
significantly different. The performance issues I'm trying to fix with
the connectivity check really only start to show up with largish
repositories.

> > +test_expect_success 'setup' '
> > +	# Create a main branch such that we do not have to rely on any specif=
ic
> > +	# branch to exist in the perf repository.
> > +	git switch --force-create main &&
> > +
> > +	# Set up a pre-receive hook such that no refs will ever be changed.
> > +	# This easily allows multiple perf runs, but still exercises
> > +	# server-side reference negotiation and checking for consistency.
> > +	mkdir hooks &&
> > +	write_script hooks/pre-receive <<-EOF &&
> > +		#!/bin/sh
>=20
> You don't need the #!/bin/sh here, and it won't be used. write_script()
> adds it (or the wanted shell path).

Makes sense.

> > +		echo "failed in pre-receive hook"
> > +		exit 1
> > +	EOF
> > +	cat >config <<-EOF &&
> > +		[core]
> > +			hooksPath=3D$(pwd)/hooks
> > +	EOF
>=20
> Easier understood IMO as:
>=20
>     git config -f config core.hooksPath ...

Yup, will change.

> > +	GIT_CONFIG_GLOBAL=3D"$(pwd)/config" &&
> > +	export GIT_CONFIG_GLOBAL &&
> > +
> > +	git switch --create updated &&
> > +	test_commit --no-tag updated
> > +'
> > +
> > +setup_empty() {
> > +	git init --bare "$2"
> > +}
>=20
> I searched ahead for setup_empty, looked unused, but...
>=20
> > +setup_clone() {
> > +	git clone --bare --no-local --branch main "$1" "$2"
> > +}
> > +
> > +setup_clone_bitmap() {
> > +	git clone --bare --no-local --branch main "$1" "$2" &&
> > +	git -C "$2" repack -Adb
> > +}
> > +
> > +# Create a reference for each commit in the target repository with ext=
ra-refs.
> > +# While this may be an atypical setup, biggish repositories easily end=
 up with
> > +# hundreds of thousands of refs, and this is a good enough approximati=
on.
> > +setup_extrarefs() {
> > +	git clone --bare --no-local --branch main "$1" "$2" &&
> > +	git -C "$2" log --all --format=3D"tformat:create refs/commit/%h %H" |
> > +		git -C "$2" update-ref --stdin
> > +}
> > +
> > +# Create a reference for each commit in the target repository with ext=
ra-refs.
> > +# While this may be an atypical setup, biggish repositories easily end=
 up with
> > +# hundreds of thousands of refs, and this is a good enough approximati=
on.
> > +setup_extrarefs_bitmap() {
> > +	git clone --bare --no-local --branch main "$1" "$2" &&
> > +	git -C "$2" log --all --format=3D"tformat:create refs/commit/%h %H" |
> > +		git -C "$2" update-ref --stdin &&
> > +	git -C "$2" repack -Adb
> > +}
> > +
> > +for repo in empty clone clone_bitmap extrarefs extrarefs_bitmap
> > +do
> > +	test_expect_success "$repo setup" '
>=20
> > +		rm -rf target.git &&
> > +		setup_$repo "$(pwd)" target.git
>=20
> ...here we use it via interpolation.
>=20
> I'd find this whole pattern much easier to understand if the setups were
> just a bunch of test_expect_success that created a repo_empty.git,
> repo_extrarefs.git etc. Then this loop would be:
>=20
>     for repo in repo*.git ...
>=20
> I'd think that would also give you more meaningful perf data, as now the
> OS will churn between the clone & the subsequent push tests, better to
> do all the setup, then all the different perf tests.
>=20
> Perhaps there's also a way to re-use this setup across different runs, I
> don't know/can't remember if t/perf has a less transient thing than the
> normal trash directory to use for that.

I originally had code like this, but the issue with first creating all
the repos is that it requires lots of disk space with large repos given
that we'll clone it once per setup. Combined with the fact that I
often run tests in tmpfs, this led to out-of-memory situations quite
fast given that I had 3x6GB repositories plus the seeded packfiles in
RAM.

This is why I've changed the setup to do the setup as we go, to bring
disk usage down to something sane.

Patrick

--2KNyko00sAnty2M1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDauy8ACgkQVbJhu7ck
PpSr5hAAoWm7TlfeYBg49lXd6GMEQPYU66JaQmGwqhrxZDGFJKhCiCRx1oMG+NT3
GfRBAJY2/XAqn+iAHHxwFp2rkJ+yap5gpyOSna+kzyfGKEC8ickGgstepC4lE0++
eSieTsj1KaTJCPzb+Fjc0eMXE2fMRveI7FlVF93lr9Cmr6VPmI9aQ19gXG5UiIqQ
TpR82dfHNBavZxBDyuZ9I3hS/HgrqOa1bj4Pfwu3p9cK2ibe/XexvA6YP2UQeQyp
D+6C4lB70Q8+1b655pZTAMzCBUth1l+jX0O7D5b+3tbYRZ5PRvnoB9QDENWZL/2p
dK0H71JewugGtori80zE5Ozq1nogI+/IwE5Ah/U2YPX7iMqv4kpkWJEgB9Pbh5VQ
gVYgwiO7pnOrZsdQWYkJqsP2rpB7bPQOGkWOZwD9MR/kTVuaX+pk9KHScxVLflyr
FoULncspC7qjIdj3nvW6BRvqFsooLB6pVL/+Ufy2ESq8habpGqupwt2MJHY5l57U
fIg29AMSlQ/ghAgDymWGyKwaV3A1K3pzwExkYtK7v1NQusfDDr4oWEhgiIrL2VSW
DYg5ag5AD12BbZovq20KqpL+2Tj+bt2zBEURpvU2SNaohHUYj07IKXwJ5Jn9Hf6m
gyFFFlJBnDK+m3yRzk05zRjQLzOGFPlItUD86NrTFuEP15bbK1M=
=l0qB
-----END PGP SIGNATURE-----

--2KNyko00sAnty2M1--
