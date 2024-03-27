Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5A28DBC
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528964; cv=none; b=K23evZfiUCJOnaNOAUYFZKv4tyfLYWVSkhQQuUQ8A6GE+OgYiEGUKyDoD1BHiUC3spRzgpkQlTSyZu2ZVwS0fEXYvmLL4gCxskZmIfpgR5ad2FkJdT2s2M//OgcdWwi+qvRUeQgbWLRzBcOPZsBUlrdWJ/gN3l7izQc1aLJpUZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528964; c=relaxed/simple;
	bh=JG+vNZ7fCb5JJUQILjp8eX02QzXYW7SjrTH4oTzLnj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt7ukjx+7VnrPnXoXakmgNzL6KmParbFzoZr6Bg0d8bS+NT2pTFcg9Z+WCymQCry6h9ImBdUW37FJKWR9w88dsuEB5ZAOCW4xQLttYl/6lyasXbQ+RuYlMzBD/YDmFDKGfW65I672WpAxjTGrWeWqe2FK/7URrcdM+qdxQgvP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YpD4fiWV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NgP+ydXM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YpD4fiWV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NgP+ydXM"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id B4E621140175;
	Wed, 27 Mar 2024 04:42:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 27 Mar 2024 04:42:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711528960; x=1711615360; bh=xY66DxBM4L
	jJSkKKaBkifnXfki8fm5r3UsnpWZTsNp4=; b=YpD4fiWVNbMpGcPy4pRd2prEln
	j4A9v3Nw8NCXCgtnRVi3ykCIa63RoXSh59MNx4cEENKUVT2XGAU6XtiSBXgB8Ncb
	SmfTX2YnuBYjZy82MEXrG7ytow4Y30fpgVGuMbDwXPxdxMh5b8jdqCrQFRJ4YXgH
	3+COUB/6sx1wmiU5LiFQlF2ZN3sdSDhpTNZXIX0cPTaoxmKj5br7bwa1rp+Z4VH/
	bRqgFmPJd2d5ZRHbmOdRG23zVOKQ1CAiBrgXmsm5bCUvOHpEF+BrGuxmSYA/95jf
	GRVV8s4ZyPAMWDwHIVk25BTK2zk1uhKKg+3NOALyt9TiC9CJ7sMSNbfrnNWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711528960; x=1711615360; bh=xY66DxBM4LjJSkKKaBkifnXfki8f
	m5r3UsnpWZTsNp4=; b=NgP+ydXMhTt1UhGc/FrMl5vinDbIvyvCU9WDPv5793bq
	tzI7Tlk6Lkzmb4yQvUksWBXfrY+jDdFD8BC2DQT91PTj5WEdw2pmTIyOitLr7/FH
	T0UCK1VI0H7bAAPBk7wqT7W7w+7Wf/Ji1Mpb5nzbhlYL/N8WazupxzJSiGxzmTAc
	iPDEYtjK4WAP+8VJp2KoBV9oQtixIl5fYmxhngqaQM3rRh4GnO8PXmA/HBEiE9fT
	jDA6bKxS5qS/qPSXeYRUU8tJrficBScjyTgFIX25yoyoCaRrnz195uWG5cRVKXRM
	11cJ4EwAxUqFBS1+pfTEs72NPuCFLf9kXtf18QhHhQ==
X-ME-Sender: <xms:ANwDZj53vAn0j1FBHQ53vwS7ILJGP6Uf0B1C7nEFy6zJ3ph-0wLp1Q>
    <xme:ANwDZo6VfnEFVeZOs8HhhzgvOH_yOknmMdyHH6cjzCnsEc9h8OEyIKhDygcVIbz1r
    9tO6Z1ZEk22bykKsA>
X-ME-Received: <xmr:ANwDZqeZiwf3syreYWqUFTrbWqj4hmy57Mf6zvZiHitTH23KXTS9KW3XKnKAUuB6zPH58RFkerQ0viW8Yu0yIYow6fOjR_6hyZQ2jD-9ilfM9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddugedguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ANwDZkLiU18hc_A4i7IGI92QHiufcAtzM0f2jX9ZhWbYQhZCwWa8OA>
    <xmx:ANwDZnJmGgHCtLSoWbR5utniw8FLm0lTWJQHY0Owpg73DKALwircuw>
    <xmx:ANwDZtymRv5ltLM8AirgiWftI6TCxTE4LhEdpmrosk8iivoUr1LNnA>
    <xmx:ANwDZjJFbMuj109qFkNH0gHy4ER1Ot3Ogp9atgPXdXqpGBkiYB-PrQ>
    <xmx:ANwDZkqfEMUz6eF2q1IBkCzLBi9Eiq97WkoUjmtat0PGK49fsppjyQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Mar 2024 04:42:39 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id de0df66e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 27 Mar 2024 08:42:24 +0000 (UTC)
Date: Wed, 27 Mar 2024 09:42:36 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Taylor Blau <me@ttaylorr.com>,
	=?iso-8859-1?Q?Jean-No=EBl?= AVILA <jn.avila@free.fr>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 06/13] builtin/config: introduce "list" subcommand
Message-ID: <ZgPb_HB3792jHLto@tanuki>
References: <cover.1709724089.git.ps@pks.im>
 <cover.1710198711.git.ps@pks.im>
 <53401299fa1f51954834e2507a2282cf60b02f20.1710198711.git.ps@pks.im>
 <CAPig+cTybDAqZeGXPi+hi5zpPD=7nGpknzM6MForaaff4H4htA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="qFiLMpQ7h7mfHxdT"
Content-Disposition: inline
In-Reply-To: <CAPig+cTybDAqZeGXPi+hi5zpPD=7nGpknzM6MForaaff4H4htA@mail.gmail.com>


--qFiLMpQ7h7mfHxdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 12, 2024 at 10:45:56PM -0400, Eric Sunshine wrote:
> On Mon, Mar 11, 2024 at 7:20=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wr=
ote:
> > [...]
> > Introduce the first such new subcommand, which is "git config list". To
> > retain backwards compatibility we only conditionally use subcommands and
> > will fall back to the old syntax in case no subcommand was detected.
> > This should help to transition to the new-style syntax until we
> > eventually deprecate and remove the old-style syntax.
> > [...]
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > ---
> > diff --git a/builtin/config.c b/builtin/config.c
> > @@ -761,6 +811,22 @@ int cmd_config(int argc, const char **argv, const =
char *prefix)
> > +       /*
> > +        * This is somewhat hacky: we first parse the command line while
> > +        * keeping all args intact in order to determine whether a subc=
ommand
> > +        * has been specified. If so, we re-parse it a second time, but=
 this
> > +        * time we drop KEEP_ARGV0. This is so that we don't munge the =
command
> > +        * line in case no subcommand was given, which would otherwise =
confuse
> > +        * us when parsing the implicit modes.
> > +        */
> > +       argc =3D parse_options(argc, argv, prefix, builtin_subcommand_o=
ptions, builtin_config_usage,
>=20
> Upon reading this, I wasn't quite sure what "when parsing the implicit
> modes" meant. I suppose it is referring to the legacy style command
> invocation?

Yeah, indeed. Let me rephrase it as "when parsing the legacy-style
command modes", which is hopefully a bit clearer.

> > diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> > @@ -11,6 +11,21 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> > +for mode in legacy subcommands
> > +do
> > +
> > +case "$mode" in
> > +legacy)
> > +       mode_prefix=3D"--"
> > +       ;;
> > +subcommands)
> > +       mode_prefix=3D""
> > +       ;;
> > +*)
> > +       echo "unknown mode $mode" >&2
> > +       exit 1;;
> > +esac
>=20
> t/test-lib.sh defines a BUG() function for signaling the sort of
> programmer error handled by the "*" arm of this `case`.

Ah, right, I'll use that.

> An alternative simpler implementation, which wouldn't require any sort
> of programmer-error fallback, would be:
>=20
>     for mode_prefix in -- "" # legacy & subcommand modes
>     do
>         test_expect_success '...' '
>             ...
>         '
>         ...
>     done

It works now, but will stop working in subsequent patches. Not all modes
can be translated this easily. E.g. "git config config.key value" needs
to be translated to "git config set config.key value".

> > @@ -527,6 +542,7 @@ test_expect_success 'editing stdin is an error' '
> >  test_expect_success 'refer config from subdirectory' '
> > +       test_when_finished "rm -r x" &&
> >         mkdir x &&
> >         test_cmp_config -C x strasse --file=3D../other-config --get ein=
=2Ebahn
> >  '
>=20
> Is this an unrelated cleanup?
>=20
> > @@ -1072,6 +1088,7 @@ test_expect_success 'inner whitespace kept verbat=
im' '
> >  test_expect_success SYMLINKS 'symlinked configuration' '
> > +       test_when_finished "rm myconfig" &&
> >         ln -s notyet myconfig &&
> >         git config --file=3Dmyconfig test.frotz nitfol &&
> >         test -h myconfig &&
>=20
> Ditto.
>=20
> Same question regarding similar changes to several later tests.

These are required because we now re-run tests twice. Consequently,
state from the first run may still be around in the second run. The
tests here broke because of that, which I've fixed by cleaning up the
state. I'll clarify this in the commit messages.

Patrick

--qFiLMpQ7h7mfHxdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYD2/sACgkQVbJhu7ck
PpQXtRAAkakPLIA48d6pngS0fjZwKQuD6XEVEMBjy0QAdpilloJMLMoW514IrNGC
MBVpTJKgJRmD4+gwXOCoyj96bLmHlTKh/tDWbDqUeYFk08sQCOwUL3r1Rqj2cxZt
FosX4V29h5lOe/SoI1yfx4Atq58Pt4kd0R8TgUcK4uP4oUGO6lJpn3dNOeu2G/ts
sGBfHUmG9XMwOg+cr57Mx3nRrM1g0KXrU0dshBsAOxCJc/iWe5ClUa5FCT5osmVd
nU36dXbC4Vmq4U43CzJGllM7Wp9HBPgbqKeNy4DXldF5xyQwOiwDf0qn3yuPUf07
kScFcvPom5vT3+6u0ZD5rehxWAlSwkyXw1Dil0dJdOrp1zx6BfRaawrdjUQoIKa9
m1J1/4YIQMXer7Xpmw6RM36fKpBo7PfUncXYzjOTjS0bU3h+YGhG5F0IIt89eTz2
FBpl2BdBIphet71tCAL5zYYfqD6D+BpHntc7ZzuWeYOFLFefgZI46p+ORP7U6zeE
1FdkVRBqygsQbqLp2HTAJq3C/lwkPc16bR6zGLvlE8mfBVge/nNEvUu78NBULdO5
JwujNx6EKrudJY2Y6zFJP1V34549QBPF05bHcJ1aZ0s0YnHrF+qTqs1X77V7/1LT
R1lNHUx1P/NN08LC4awI6pnDzM5HJ6NTqkiEMsD0e3i2vQLbx+w=
=wOSv
-----END PGP SIGNATURE-----

--qFiLMpQ7h7mfHxdT--
