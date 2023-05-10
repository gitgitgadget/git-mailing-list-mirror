Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BECFC77B7C
	for <git@archiver.kernel.org>; Wed, 10 May 2023 12:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbjEJMgJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 May 2023 08:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjEJMfl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2023 08:35:41 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5E7AD3D
        for <git@vger.kernel.org>; Wed, 10 May 2023 05:35:19 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3317F3200918;
        Wed, 10 May 2023 08:35:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 10 May 2023 08:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683722117; x=1683808517; bh=s+
        UQ38aJu9qbvAlDuRytMS41f5sJnX0ykBxmK7ijp/c=; b=luZHbTxnRTI+6XsnT3
        nnn6XBP5kTbwYsr9LC2dOmzbGUSMzINDuH+LvbpGKWvdSY1AmKiFLX3m1i0BSzZP
        +mYEHuvXasdA/GmNH5aBjD4rHWlIb5DIaaaYibUDQ8ZHzEqI/ksvtE39ff1B2tmf
        lPUo78Sx/yj/w+mqa1DV9cBiVuUjAK0zDxudNBYqCrOl1W3VoxWv6MlqJKZwx0sw
        nGuQcfIvcYlu7i7M1O8e3g0USk3b/3vLZApTJ6rfSHN+yxSCbE1bfntqNjpwxt0T
        dCSqYK22noo7Lz/5cjR/19fu2tNypULY+CH7WRvJNX2HUk6vsRyQstoCSyWBHvhM
        0VeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683722117; x=1683808517; bh=s+UQ38aJu9qbv
        AlDuRytMS41f5sJnX0ykBxmK7ijp/c=; b=LHd4DzJkj5OBncPz1UYTBC6xmULNo
        Q3ZxcsJTBZiy5b7w9nueNxHl5WgWxq1aUnunLCMqsmwjll8GcHNrL6GX9LkRxeYO
        WM80Yo7RItCV0lLPC3krS2kRzbTgrpeoe9yaBS2BwZquB+HHJkdx3yq9LUeNP2eS
        IyYY1C7CukzpAAhDek2+Sv8x3GumBbN5XCAYIWbQpSCG5DePWzAX8I51ozcoKBO0
        aG+aCBJAwtM3NoRHBEGmZ8PM2sx9o9pc5NVwyyjPrgf026FpTw2++PRPWHVBa1O1
        EgPAKJiVjs0fjALiuCHnFUxJXdXtGzCtni6auAOrospPVHmNmn+YPJOzw==
X-ME-Sender: <xms:hY9bZF6QznPhecaP_TgjU-IYkf5g3Nuk2l5m7F4hcZCQa3NVF_EDxg>
    <xme:hY9bZC4IRscsD1Tk_ik5X_V16-5634yzm5jq2mX5Vcn5unWjY4FZjzC7GQJC9h1ht
    oM6-uHNlD-xXlUMmg>
X-ME-Received: <xmr:hY9bZMcn8ynlKqBDUos6chUDXr6FGShtUSO5MPJXIYNJTe5RptO8GfG27OyFzuA18abCe9coikQP2G7vqdqZcb2INTJDiud9Ga-7PRjPUL6a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeegiedgfeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:hY9bZOIlnNSxEScwwcXV2xBREDblxjaMd-tYZ5vCFZDC9oCXCSWxUg>
    <xmx:hY9bZJLxIPV5KuTQjvnOUdE-Mc3Mbivz4wm7H6OOx82aN-SKEXKX9Q>
    <xmx:hY9bZHyjjsevcm2CgVtEOgNAaVJoJHu8BIofVhkxLURxpTImyQhCOw>
    <xmx:hY9bZGG8ZqtD-la3gNGyUnALXbVBIIBAhb0dsX_e6mrpUxfEznMFlQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 May 2023 08:35:16 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id af0350d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 10 May 2023 12:35:07 +0000 (UTC)
Date:   Wed, 10 May 2023 14:35:14 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 8/8] fetch: introduce machine-parseable "porcelain"
 output format
Message-ID: <ZFuPgh2ad-Cw1r3P@ncase>
References: <cover.1681906948.git.ps@pks.im>
 <cover.1683636885.git.ps@pks.im>
 <24ae381950249fd5c1cd799b75dda1407495d9d4.1683636885.git.ps@pks.im>
 <xmqqjzxhw802.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ltqklZ8s8llXjnYK"
Content-Disposition: inline
In-Reply-To: <xmqqjzxhw802.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ltqklZ8s8llXjnYK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 09, 2023 at 01:43:41PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > Considering that both multi-remote and submodule fetches are user-facing
> > features, using them in conjunction with `--porcelain` that is intended
> > for scripting purposes is likely not going to be useful in the majority
> > of cases. With that in mind these restrictions feel acceptable. If
> > usecases for either of these come up in the future though it is easy
> > enough to add a new "porcelain-v2" format that adds this information.
>=20
> Two steps ago, the proposed log message still mentioned "--output-format",
> which may want to be proofread again and revised.

It's a relict from previous iterations. I've fixed the preceding patch
to talk about `--porcelain` instead.

> > @@ -1786,7 +1810,8 @@ static int add_remote_or_group(const char *name, =
struct string_list *list)
> >  	return 1;
> >  }
> > =20
> > -static void add_options_to_argv(struct strvec *argv)
> > +static void add_options_to_argv(struct strvec *argv,
> > +				enum display_format format)
> >  {
> >  	if (dry_run)
> >  		strvec_push(argv, "--dry-run");
> > @@ -1822,6 +1847,8 @@ static void add_options_to_argv(struct strvec *ar=
gv)
> >  		strvec_push(argv, "--ipv6");
> >  	if (!write_fetch_head)
> >  		strvec_push(argv, "--no-write-fetch-head");
> > +	if (format =3D=3D DISPLAY_FORMAT_PORCELAIN)
> > +		strvec_pushf(argv, "--porcelain");
> >  }
>=20
> Hmph. =20
>=20
> [PATCH 9/8] may want to also introduce and pass down the
> "--output-format=3Dfull/compact" option, but that is clearly outside
> of the scope of this step.

We don't have `--output-format` now though, but only the `--porcelain`
switch. The only way to configure "full"/"compact" output formats is via
the "fetch.output" config variable right now.

> > +static int opt_parse_porcelain(const struct option *opt, const char *a=
rg, int unset)
> > +{
> > +	enum display_format *format =3D opt->value;
> > +	*format =3D DISPLAY_FORMAT_PORCELAIN;
> > +	return 0;
> > +}
>=20
> Lack of "if (unset) ..." worries me.  Shouldn't the code allow
>=20
> 	git fetch --porcelain --no-porcelain
>=20
> to defeat an earlier one and revert back to the default?

We pass `PARSE_OPT_NOARG|PARSE_OPT_NONEG`, so this isn't really much of
a concern. But yeah, it wouldn't allow `--no-porcelain`, and supporting
it is trivial enough to do. I'll change this to a `OPT_BOOL()`.

Patrick

--ltqklZ8s8llXjnYK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRbj4EACgkQVbJhu7ck
PpSVOxAAhCendGtJ1CyZW363+xBvVczp7kAhutCE27rZiVLb09l4P0vRZI4zrips
VuIBNBV2GDdX87Z2yWOcoL95FeUwZCJ/4OhiYZL0FW5ffHX9k5HcEPi4BHCO+LsA
lEFmN7c1kCS1HAPzr7L2SyqlClip5IeOL3MH2SIEc2SekInY05BpcKLFGKSjvHDl
ZkcK2IMPz7XjQ8tKW5RdJrTJvdzQKKeI2+Pd8HXFw0ZCWCWXY89FlhDXIdhb4yjF
/R7naIM4HXIlRN+ivK38Iv+en1D4HPijw8QTaywbH1K6tsOhsL3VubQecNITKkV7
PYwmySOq7jrSlPRV/IBMwGmUBF9pl7VWBv/YtdmdpZCPqFJxv2A/d7TW/ontuhn7
x+p+sHflEnboqD8LYbV2FzF+d+TkqAmhsoEFGkvEuzJhhS1/TEbiTwpU2ggi+y1l
SJV7eOuaqfSq+7EUXKqbcaaV49W2EmtKfXiEGeCdjUJOtuJuNpIh5u/eHmFYP3ff
Cqu6xxv5SndncRTbsFZGqo8Ly81AsVV32Iu9fxzD/oAlOcFq+dm6EVUpAItwlIb5
yeT2D/CDXBGWpfaG66QizKlbMSCmfi8ITRrS4WNyFMkfRrucdhy87BVsPj7CkR1r
attgkTb14mdx1nFkv34pAdpW/jWPpdJO1G9nZL29WDUogPZ3D6w=
=oelp
-----END PGP SIGNATURE-----

--ltqklZ8s8llXjnYK--
