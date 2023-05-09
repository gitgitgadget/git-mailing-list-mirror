Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212B4C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 12:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjEIMls (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 08:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbjEIMlq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 08:41:46 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA949C8
        for <git@vger.kernel.org>; Tue,  9 May 2023 05:41:44 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9B5DA5C0103;
        Tue,  9 May 2023 08:41:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 08:41:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683636103; x=1683722503; bh=sj
        FaqMU9iqYFyN8zkYk502BkV2v+Mk1x4Tzv7Rki+bU=; b=JZh8Z9l4XGBIRaAYqf
        IZdlPqdOIjIMbsvPtyHykPE5W9DTaesMGJLyFfEa5dn2hvwV1m0WJaretpBxuOgn
        7T9J1KWJGYJ+wQC/e6aWXimgtc1UAhrzGhHNubnoschjDMLwCmkzlugBGnbN+z8I
        TBsMiRGRevKq5UEnhQCCp7EzFm9ruXSqHO1XxhzIbqtbcWz80j9XGt08sLHW7xAM
        6YE0yXdv+XkpU6ymrJJiVvv+ulNexFVrOMpcH+c6YD3Lo4Cq/9zrsmmlsNpG2ess
        YCrAcCsSVL5Mxe8d9+QK+lpaYV59Hw5vQgQaoXMR0Yslubh2Gwv762eMQXxVe1up
        Miqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683636103; x=1683722503; bh=sjFaqMU9iqYFy
        N8zkYk502BkV2v+Mk1x4Tzv7Rki+bU=; b=MUH/YX3DvBkwEjjkFcYmd8tMXmb3v
        hc6XR8klQwmIyzjx5JyaamRDtCKKFuseAtVJ68CyVpOyy/by6Svff6YtL+yemC9r
        01pKYNp3Zlls1EUAfTYflPbQoR/4hhINaDMSrTI/EpSZee3MOpO62M0kWe9DQ4Ak
        QcPPM09zGtZmexxOBuG2BrlLQTHQ1dlccXlNCqChqL/hSz4FoqG6lveMArW/I7ST
        +o5tKnuO6gLp5ohmQyjagYR0hACxpRmgqXL4q2nYgBnCROmWpYuyELllx85k6Itl
        5dz/mSIaeNhnwLPr92OKg3YY4afjNqQQgqMaZHQmLJdr5sVuBV2U9tRVQ==
X-ME-Sender: <xms:hz9aZMS6Ti9ybNxelj6n-9f1c9aGG2S4YPNjTVG27NRhDAWwkCmB7Q>
    <xme:hz9aZJy590zes6e6oP1ZrI4RH7j0ie4CfkOQxqEWxA1S7dUfs-3vi6ORBV3m8I6xo
    mP6fgoeJ0rU0O0uUQ>
X-ME-Received: <xmr:hz9aZJ2HbLG5__GAyxyFfsdEO_FIE4G8Rc2-hiB58X4I0YvgasCqQc6Rv-4OVr2X02dT2vzNZjrRaZMFa73on2jrlAcqKb4ARF2DojbeUCM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegtddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:hz9aZAA4rHzg50a-a6xK6nVWEuHU7ukQbwaz03BCt2CcAd0-IYohbw>
    <xmx:hz9aZFic56u8nQxn3y93zcGepK367BzHilTBf7NDVLhrEI9Vr25Kkw>
    <xmx:hz9aZMo9Gzp2scn1S08LuSQib5OJYY8CO0EV5JltWNP-5EetLwGlCQ>
    <xmx:hz9aZFf0T_5p4kA6Hwjie_nvOfC2uV22ukK428wj2hpuOCyldEI9xw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 08:41:41 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 4f7448f2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 12:41:34 +0000 (UTC)
Date:   Tue, 9 May 2023 14:41:40 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v3 8/8] fetch: introduce machine-parseable "porcelain"
 output format
Message-ID: <ZFo_hHiwRU_7yDsg@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683113177.git.ps@pks.im>
 <e132d9494ee7d8c4eb3a7a82b6420743c8c7a9b0.1683113177.git.ps@pks.im>
 <kl6lild21jbd.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Ue0aYJPUuJm8T+xq"
Content-Disposition: inline
In-Reply-To: <kl6lild21jbd.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Ue0aYJPUuJm8T+xq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 04:42:46PM -0700, Glen Choo wrote:
> This version looks great! I only have minor comments.
>=20
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > A notable ommission here is that the output format does not include the
> > remote from which a reference was fetched, which might be important
> > information especially in the context of multi-remote fetches. But as
> > such a format would require us to print the remote for every single
> > reference update due to parallelizable fetches it feels wasteful for the
> > most likely usecase, which is when fetching from a single remote.
> >
> > In a similar spirit, a second restriction is that this cannot be used
> > with `--recurse-submodules`. This is because any reference updates would
> > be ambiguous without also printing the repository in which the update
> > happens.
> >
> > Considering that both multi-remote and submodule fetches are rather
> > niche and likely not going to be useful for the majority of usecases
> > these omissions feel acceptable. If usecases for either of these come up
> > in the future though it is easy enough to add a new "porcelain-v2"
> > format that adds this information.
>=20
> As a point of clarification, I think these options aren't niche in
> themselves, but they are more user-facing, so using them _in conjunction
> with_ --porcelain is probably pretty niche, so I think this is okay for
> now.

Yeah, that's what I indeed intended to say. Will clarify.

[snip]
> > @@ -1830,6 +1857,7 @@ struct parallel_fetch_state {
> >  	const char **argv;
> >  	struct string_list *remotes;
> >  	int next, result;
> > +	enum display_format format;
> >  };
> > =20
> >  static int fetch_next_remote(struct child_process *cp,
> > @@ -1849,7 +1877,7 @@ static int fetch_next_remote(struct child_process=
 *cp,
> >  	strvec_push(&cp->args, remote);
> >  	cp->git_cmd =3D 1;
> > =20
> > -	if (verbosity >=3D 0)
> > +	if (verbosity >=3D 0 && state->format !=3D DISPLAY_FORMAT_PORCELAIN)
> >  		printf(_("Fetching %s\n"), remote);
> > =20
> >  	return 1;
>=20
> Here and elsewhere, I wonder if it's clearer to name the variable
> "porcelain" and separate it from "enum display_format". Then we can
> check "porcelain" directly instead of using "format =3D=3D
> DISPLAY_FORMAT_PORCELAIN" as a proxy...

For now I'd like to keep this as-is: it's easier to keep track of this
when there is only a single variable that keeps track of the output
format. But if we were to add additional porcelain formats in the future
I agree that it would be nice to refactor the code as you propose.

I'd rather keep the simpler version for now though where we only have a
single state to worry about.

> > +static int opt_parse_porcelain(const struct option *opt, const char *a=
rg, int unset)
> > +{
> > +	enum display_format *format =3D opt->value;
> > +	*format =3D DISPLAY_FORMAT_PORCELAIN;
> > +	return 0;
> > +}
> > +
> >  int cmd_fetch(int argc, const char **argv, const char *prefix)
> >  {
> >  	const char *bundle_uri;
> > @@ -2104,6 +2140,8 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
> >  			    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
> >  		OPT_BOOL(0, "dry-run", &dry_run,
> >  			 N_("dry run")),
> > +		OPT_CALLBACK_F(0, "porcelain", &display_format, NULL, N_("machine-re=
adable output"),
> > +			       PARSE_OPT_NOARG|PARSE_OPT_NONEG, opt_parse_porcelain),
> >  		OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
> >  			 N_("write fetched references to the FETCH_HEAD file")),
> >  		OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
>=20
> e.g. since we are reusing the "display_format" variable, we need to make
> sure we parse "--porcelain" after we read "fetch.output". I
> double-checked to make sure we were doing the right thing, though it
> would be nice to not have to worry about those sorts of things. This
> shouldn't hold up the series though.

In fact it is the other way round: we parse `--porcelain` first and then
only read "fetch.output" in the case where the `display_format` variable
is still set to `DISPLAY_FORMAT_UNKNOWN`.

So in the end there is no fragile order dependence here -- it would work
just the same regardless of whether we first parse command line options
or the configuration.

> > +test_expect_success 'fetch porcelain with multiple remotes' '
> > +	test_when_finished "rm -rf porcelain" &&
> > +
> > +	git clone . porcelain &&
> > +	git -C porcelain remote add second-remote "$PWD" &&
> > +	git -C porcelain fetch second-remote &&
> > +
> > +	test_commit --no-tag multi-commit &&
> > +	old_commit=3D$(git rev-parse HEAD~) &&
> > +	new_commit=3D$(git rev-parse HEAD) &&
> > +
> > +	cat >expect <<-EOF &&
> > +	  $old_commit $new_commit refs/remotes/origin/force-updated
> > +	  $old_commit $new_commit refs/remotes/second-remote/force-updated
> > +	EOF
>=20
> The only thing in this test that relies on the previous test is that
> HEAD is pointing to "force-updated", and it's hard to tell where HEAD is
> since the previous test is so long. Could we create a new branch
> instead?

Makes sense, done.

Patrick

--Ue0aYJPUuJm8T+xq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaP4MACgkQVbJhu7ck
PpS9Dw//fbHOO8WQ1MuJLZsyMymXQruj/w/Mr91y6zlQ+UTeRBCwwAyxvSjaP6yk
96haiB7GA52APLxZxYhE8cnswfJEmrxBPahaJ22BWmiAIS/lrzOJy3XSubLE5o9R
Wbqr+vHhA+D+XsAymBkLIuaoYK+qx+WYOeSe4mwqv2qOyElbCpd3Vhz7/LPedH8W
f7dW4cYC/cb4IPK42Vpr7uR8WVxVlLxoMkcC3uJD6iNnlQhYVBpPm+XxlDsgxr72
pD7ajXVW1j5SvMVKhGTHfoRJq4hZWjemQQEObrfV3b8MKBgHvNQtgj/+nHkyhByM
eF2h6saITBAboQHB186VwFCqoq2QxsWFak0HbVn4+8yVYwfkOWU+2viKQnZpcsTw
zoNGSWWp/1KTJL8mP7Tb4da8jaXa5lBWVw/eq9Ba/h3UglxmdfOSztnSTluRxM91
g2l62EWwuh7YwPA5WmSDWnPE2PQLTCrrVbxiLJX6VH0INQU/gIoByRoxRpG0eXhZ
PoMvkRPb19BLSPz4egOat7HKqIu5pBVV3+fwiGSB46Vm8GYckEJb0ymjw8e/fGWA
5RF1fkUYOEr7AQx92W4O9ugUK1lS1AgFprOEZRpf6tR7+CkI9Vmud+Uf2SzzgNZt
3bQRv60wg5oms+Yefeif+/WBhqWU6r+WvBfW3dvLvcjGJdwpQh0=
=0mSm
-----END PGP SIGNATURE-----

--Ue0aYJPUuJm8T+xq--
