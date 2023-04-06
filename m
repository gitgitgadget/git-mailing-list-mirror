Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80853C76196
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 08:19:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233588AbjDFITb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 04:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbjDFITL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 04:19:11 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D205FF
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 01:19:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id D16073200AA6;
        Thu,  6 Apr 2023 04:19:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 06 Apr 2023 04:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1680769148; x=1680855548; bh=js
        e+PVNPobg3pj2Kc9erRI6uNfb8gTR6Ls0WwQUVtqA=; b=ey2qjsIaoUsUmVCWnA
        cKUrafOr5ptu6So2c8v3JrXKGHSZaYO7W7wMX73a4wAfkJVyxVLeml+GI+GJooIa
        TeAgJJfsG6JsYJOyvj4OXPom/lsB5R/xTNVF+9g+u6VtGFHNJX+ppURCegIaEA4M
        56sugtmx5nT/sr9p5BvQAUuSddPFll4OIo1gft9ab3hOvkLq0YHe5gFIEdV32YLD
        b8U/tNBywU2XhNTU3ojffI0vFa4T2Qcl6Q8wHK7ukUjAfaqcFdtW06PJVweMFb8v
        ObAWLakRaOBfiKD+ibEIHAyjbQacsUDxi2NQp67giooFy89jdLZLVM6hT5oqipGu
        NXwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1680769148; x=1680855548; bh=jse+PVNPobg3p
        j2Kc9erRI6uNfb8gTR6Ls0WwQUVtqA=; b=CV+fUnyOk8pX3W412dJrLpro8jY1y
        5/AlykxPqmIN/ju2Q1cjkiYc6amN0HB+BiCkZx7tC2JmKFUOqSm2OUtWAOyJza2o
        Tw0nRGnGGTqhnGcwW5niEeY5FlBm9APzjtE5PIwjF93qRfa3zE+DmHv7pDjMHNlk
        Jvk0M5DWHaO8nnwS310CyUSKCSVxxzdmIeDpUf0zjvv3+vlY1bXSG6EwhNlAyWiQ
        EosMluAto653RTQMSf2Z/Ott3vV8kYqWZgK8Q1ojJvzbKE6fMx6JHi9YxR9gDoEa
        DOvwaCVRrn213zCts6BVayTiBDdof3JXXMPLgkrsZid8Mvc5rzsxtgohQ==
X-ME-Sender: <xms:fIAuZNdrYSoxuZ-Y6cwJwG_xMtxXwin3xfY72SggqcgrnvmzyNx78Q>
    <xme:fIAuZLMwiLaKyqv3Q4IP83RJhy-k-rpJMEoawSEHrLCEePDdNqC_5YJg6riXBfR4K
    4jJwBxqo42Z4odZJg>
X-ME-Received: <xmr:fIAuZGjmISqKJ7wMf7hSVUuEqb-a7_srdNBHQEudY3tSQXGCeeTqEddRG-6FwpwEF3o7q68HUAYTjadllrul_vUCSz7lWMS5bbZjaXeBv9KW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdejvddgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhephfehkeeiffffveetuedvvddvteeuje
    elgfdvgfduuedujeejueelieffgfehteehnecuffhomhgrihhnpehhthhtphgvgihpohhr
    thgrlhhlughifhhfqddqghhithgrthhlihgsqdhhthhtphgurghpphhlhidqohhnvgdqth
    himhgvqdhpvghrlhdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:fIAuZG_2M0LEqaTa-y2z1HSp1KI0f1HPYeXLNiDRu4hT_MS9NLsNrQ>
    <xmx:fIAuZJtrH4x4iW4VcLB7ervsPMgCNyKMQJLOl8OIKqOQKNEyeM1L9w>
    <xmx:fIAuZFGv2AHkoGmvC8q9Til1J84SNEUEUC_K625TVK6DnomMcHLNuw>
    <xmx:fIAuZH1ozomflQEil9W2aNq-fmPP53bVz5DiDhulrNourF8u9OcFBg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Apr 2023 04:19:07 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 3170bb81 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 6 Apr 2023 08:18:57 +0000 (UTC)
Date:   Thu, 6 Apr 2023 10:19:03 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] global: resolve Perl executable via PATH
Message-ID: <ZC6AdylF4TI41vnX@ncase>
References: <d9cfad7caf9ff5bf88eb06cf7bb3be5e70e6d96f.1680689378.git.ps@pks.im>
 <20230406032647.GA2092142@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mqdPp/wNE2d/SoBF"
Content-Disposition: inline
In-Reply-To: <20230406032647.GA2092142@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mqdPp/wNE2d/SoBF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 05, 2023 at 11:26:47PM -0400, Jeff King wrote:
> On Wed, Apr 05, 2023 at 12:10:10PM +0200, Patrick Steinhardt wrote:
>=20
> > The majority of Perl scripts we carry in Git have a `#!/usr/bin/perl`
> > shebang. This is not a portable location for the Perl interpreter and
> > may thus break on some systems that have the interpreter installed in a
> > different location. One such example is NixOS, where the only executable
> > installed in `/usr/bin` is env(1).
> >=20
> > Convert the shebangs to resolve the location of the Perl interpreter via
> > env(1) to make these scripts more portable. While the location of env(1)
> > is not guaranteed by any standard either, in practice all distributions
> > including NixOS have it available at `/usr/bin/env`. We're also already
> > using this idiom in a small set of other scripts, and until now nobody
> > complained about them.
> >=20
> > This makes the test suite pass on NixOS.
>=20
> Can you tell us more about which tests failed?
>=20
> Skimming over the list of files here, the first few examples:
>=20
> >  Documentation/build-docdep.perl                    | 2 +-
> >  Documentation/cat-texi.perl                        | 2 +-
> >  Documentation/cmd-list.perl                        | 3 ++-
> >  Documentation/fix-texi.perl                        | 4 +++-
> >  Documentation/lint-fsck-msgids.perl                | 2 +-
>=20
> will not be affected by your patch, because we never use their shebang
> lines at all (we say "$PERL_PATH cmd-list.perl" in the Makefile).
>=20
> I did try removing /usr/bin/perl completely (and thus likewise had no
> perl in my path), setting PERL_PATH, and got a few broken tests, which
> could be fixed as below.
>=20
> Does this fix the cases you saw, or are there others?

You know, let's just go with your patch. With PERL_PATH set it fixes all
the issues I have observed. At some point in time I saw more issues than
the one you fix here, but that's because my `config.mak` got lost
without me noticing. Oops, embarassing.

Thanks!

Patrick

> -- >8 --
> Subject: [PATCH] t/lib-httpd: pass PERL_PATH to CGI scripts
>=20
> As discussed in t/README, tests should aim to use PERL_PATH rather than
> straight "perl". We usually do this automatically with a "perl" function
> in test-lib.sh, but a few cases need to be handled specially.
>=20
> One such case is the apply-one-time-perl.sh CGI, which invokes plain
> "perl". It should be using $PERL_PATH, but to make that work, we must
> also instruct Apache to pass through the variable.
>=20
> Prior to this patch, doing:
>=20
>   mv /usr/bin/perl /usr/bin/my-perl
>   make PERL_PATH=3D/usr/bin/my-perl test
>=20
> would fail t5702, t5703, and t5616. After this it passes. This is a
> pretty extreme case, as even if you install perl elsewhere, you'd likely
> still have it in your $PATH. A more realistic case is that you don't
> want to use the perl in your $PATH (because it's older, broken, etc) and
> expect PERL_PATH to consistently override that (since that's what it's
> documented to do). Removing it completely is just a convenient way of
> completely breaking it for testing purposes.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/lib-httpd/apache.conf            | 2 ++
>  t/lib-httpd/apply-one-time-perl.sh | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index f43a25c1f10..9e6892970de 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -101,6 +101,8 @@ PassEnv LC_ALL
>  Alias /dumb/ www/
>  Alias /auth/dumb/ www/auth/dumb/
> =20
> +SetEnv PERL_PATH ${PERL_PATH}
> +
>  <LocationMatch /smart/>
>  	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
>  	SetEnv GIT_HTTP_EXPORT_ALL
> diff --git a/t/lib-httpd/apply-one-time-perl.sh b/t/lib-httpd/apply-one-t=
ime-perl.sh
> index 09a0abdff7c..d7f9fed6aee 100644
> --- a/t/lib-httpd/apply-one-time-perl.sh
> +++ b/t/lib-httpd/apply-one-time-perl.sh
> @@ -13,7 +13,7 @@ then
>  	export LC_ALL
> =20
>  	"$GIT_EXEC_PATH/git-http-backend" >out
> -	perl -pe "$(cat one-time-perl)" out >out_modified
> +	"$PERL_PATH" -pe "$(cat one-time-perl)" out >out_modified
> =20
>  	if cmp -s out out_modified
>  	then
> --=20
> 2.40.0.824.g7b678b1f643
>=20

--mqdPp/wNE2d/SoBF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQugHcACgkQVbJhu7ck
PpRUGg/8DEju3TaJceucWyzLunJoz5EHy4sSYreGM5ZvfieNpKevJ1GX3HtLyg7Y
H2hA6VeJlHj8bmMCpTbadVxE6UyR33C5jZjnqpOcgLaF5+ELF8aMMviJNnMd/2mu
95JD/SdLnIQphVdq9Bbla1bXmxjn5p2hBi8MQoyuAGMytbvisNwkfS2AmpoQDMd/
mj3bejn/+tUz/izh+ItAhzXdaURTJZJ99th43YTu1CehZ9uLuSmAkldykVJ5lGBQ
hAvFKSUcIABZOK2B7CXKm1tfcAn7pvcrfVS/bAASRull1pTy6+pY3uVi3GPLje+e
+GIulwNmX1Yei1C+T8ucXh+uIriLBm5JcyN69mE/etSJPPE9pxsLAKTOwg1cq37i
kgeBsQyrayNBt3E/6kkF9/nGZ0tBLRZRnVQyx8tnXhx43HycqkOWJdtr52iccmkO
rmO7Nn2o9Nr1g4QaAG+ctHWXP/VmBmPVV9MFUx5OkJUr/awkVYnbwHqdTb9S+KLM
0BbFvEtLEA9PdAmHnPQpndpSY7M1/TK04kwWo++7fV1hpOQRWnSxFiKCBcvlQg7y
611Q/8Ue6nQTJ1uWyszA4uMEJ6vabokImkvfDQKgI58rAExMbCQbas5Ctc3vT3pF
yqlpvbbY29kF1sZ36yRl6UgWIzOtu/bCnNf4Mbj68p8Ops9S364=
=9Vgg
-----END PGP SIGNATURE-----

--mqdPp/wNE2d/SoBF--
