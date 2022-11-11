Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41EDEC4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 05:49:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiKKFs1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 00:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232117AbiKKFs0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 00:48:26 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B1DE6A
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 21:48:24 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E4B085C012E;
        Fri, 11 Nov 2022 00:48:21 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 11 Nov 2022 00:48:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668145701; x=1668232101; bh=/NgluLIwzu
        0/QPTBYfDZrL0NlnD8fd78fu3qwj/9d1Q=; b=h4tmamvryqCcbM4oFbkelwQ0vk
        AK8RmwetWT807ls4WcQV2Gikb0nJsQrRYD8SaypRKFzVG2KLq4v1vsFn7BMB4zqe
        bUvhuerHl3pHPu0TT0K7q2JWyj/Pre3S/g2Tyw1JZlM2tPmCf+SviVntWagUtr5d
        l+4CvTZGbvJpcIZeZ/aB8gpUeH/f/MVooewKG5fW0DJJ+SNA0YCLfIWjSOmWoJNw
        Q4RtajUZbWHMPnJ3D93fTGJ7nZcWETdxdffFqhv6lBHoXVEB4llgIq+lKcB21yuU
        nElhz+Sdd3qzhUpMgaml+orFSKt68KBTYGc8ue3pOZUfjOtpo5JBjTfAaTEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668145701; x=1668232101; bh=/NgluLIwzu0/QPTBYfDZrL0NlnD8
        fd78fu3qwj/9d1Q=; b=icTMuZN4wUeNPqlOE24mWPs6oUCp4DoCyo0P3kXr0IdH
        erHIaOErIG9cvKmz+fUnk6GjixD9aAKb8Z/dHW/NTpL/dtaVE9ioajSc346c4g0F
        Po1NV9ld0ylYArXLpqX51jb8Kwfita3Smr39tThN7mho+69KkDTF2rbjv8Z2nA41
        fyyPHFODV7jnyAHonX3YNVnU1vvo9nF0o1St0Qwa9rsoAH3dqlz4T3oPSVR/gK3s
        SZunO9pbRoaGUmjrnbRG3Q3Tn3Ke8JqxxtKJCP8JHuPBe1uKD4b1L8enYt780QbK
        1zlJupxmsT8DDmLnaYRg5qFe1Dm4AMWw0vfxQ4MrAg==
X-ME-Sender: <xms:JeJtY-RxXyEjc66gbkF3L0-74QkldMQFgB4dlgwRQMnm3mISbqnvXw>
    <xme:JeJtYzxyHPSrnO82OsJNaHawXeB5wmrHrDDAsuMKMdiTHIOp4VaYxO2RuAoCf08NE
    Ui_-wB9V_cTCvSA4w>
X-ME-Received: <xmr:JeJtY73jbs0cjJmOH96tXG7h7ACv9fRr_LSHlFBk-O6zoJU4cA6a0nW5zr8dz6CvcZe642cbHnSBbBUsz9KyCfWlZLKzJ-ivIriNYMrXeHtStQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeehgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepveevveeuvdegudefjeetvdelvefhleeuje
    evkedtlefhteeuudeiveettdevgffgnecuffhomhgrihhnpehhihguvghrvghfshdrlhhi
    khgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepph
    hssehpkhhsrdhimh
X-ME-Proxy: <xmx:JeJtY6Ax8jVI6basPEuZdLuvdNXJTNoqqym8K8cUGqUhsFxf8yohdw>
    <xmx:JeJtY3ileEwZFW_0elsS4MCxov7TL3VrrNAgbU9B0REXYBZ2ds92aQ>
    <xmx:JeJtY2rgjg8WajOYnnhziXBgPOEfU00eZ07jgrFvrztAbypu_KBiGQ>
    <xmx:JeJtY0spx-lFbDgTqjsJN_cD9NOGcimQj_cI3Ac3Qa31D94trXlBhA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Nov 2022 00:48:20 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 56cbb656 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 11 Nov 2022 05:48:13 +0000 (UTC)
Date:   Fri, 11 Nov 2022 06:48:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4 4/6] revision: add new parameter to exclude hidden refs
Message-ID: <Y23iHhBYJclNzXn6@ncase>
References: <cover.1666967670.git.ps@pks.im>
 <cover.1667901510.git.ps@pks.im>
 <c7fa6698dbe7b0eb5e2b9c4725e9bdc6cdb22983.1667901510.git.ps@pks.im>
 <Y2pwt77e9KP5J3XD@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pAEH1j7vd7lR5AmM"
Content-Disposition: inline
In-Reply-To: <Y2pwt77e9KP5J3XD@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pAEH1j7vd7lR5AmM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 08, 2022 at 10:07:35AM -0500, Jeff King wrote:
> On Tue, Nov 08, 2022 at 11:03:51AM +0100, Patrick Steinhardt wrote:
>=20
> > --- a/Documentation/rev-list-options.txt
> > +++ b/Documentation/rev-list-options.txt
> > @@ -195,6 +195,13 @@ respectively, and they must begin with `refs/` whe=
n applied to `--glob`
> >  or `--all`. If a trailing '/{asterisk}' is intended, it must be given
> >  explicitly.
> > =20
> > +--exclude-hidden=3D[receive|uploadpack]::
> > +	Do not include refs that have been hidden via either one of
> > +	`receive.hideRefs` or `uploadpack.hideRefs` (see linkgit:git-config[1=
])
> > +	that the next `--all`, `--branches`, `--tags`, `--remotes` or `--glob`
> > +	would otherwise consider. This option is cleared when seeing one of
> > +	these pseudo-refs.
>=20
> OK, so this one drops "transfer", which I think is good. But again, I
> think the explanation here is subtly misleading, because it's not just
> "hidden via those sections", but "hidden as receive-pack or upload-pack
> would, respecting both those sections _and_ transfer".
>=20
> I also wondered if we could simplify the explanation a bit by tying it
> into the existing --exclude, and then we don't need that mouthful of
> pseudo-ref options. So together something like:
>=20
>   Do not include refs that would be hidden by `receive-pack` or
>   `upload-pack`, by consulting the appropriate `receive.hideRefs` or
>   `uploadpack.hideRefs`, along with `transfer.hideRefs`. Like
>   `--exclude`, this option affects the next pseudo-ref option (`--all`,
>   `--glob`, etc), and is cleared after processing them.

I'll try to come up with something, thanks.

> But then I read the next section in the --exclude docs, which says:
>=20
>   The patterns given should not begin with refs/heads, refs/tags, or
>   refs/remotes when applied to --branches, --tags, or --remotes,
>   respectively, and they must begin with refs/ when applied to --glob or
>   --all. If a trailing /* is intended, it must be given explicitly.
>=20
> Yikes. So --all is going to process "refs/heads/foo", but --branches
> will see just "foo". And that means that:
>=20
>   git rev-list --exclude-hidden=3Dreceive --branches
>=20
> will not work! Because receive.hideRefs is naming fully qualified refs,
> but we'll pass unqualified ones to ref_is_hidden(). Even though that
> function takes a "full" refname argument, I think that has to do with
> namespaces.

Oh, good catch. I noticed that paragraph before, but somehow it didn't
click.

> I'm sure this _could_ be made to work, but I wonder if it is worth the
> trouble. If it's not going to work, though, I think we'd want to detect
> the situation and complain, at least for now. And likewise the
> documentation needs to make clear it only works with --all and --glob.
>=20
> Sorry to have misled in my initial suggestion to turn --visible-refs
> into --exclude-hidden. However, I do still stand by that suggestion.
> Even if we don't make it work with "--branches" now, the user-visible
> framework is still there, so it becomes a matter of extending the
> implementation later, rather than re-designing the options.

No worries, and I agree that it's ultimately still the better route to
use `--exclude-hidden=3D`. The things that don't work right now just go to
show that there is still some potential here and that it's overall the
more flexible design. And as you say, this is something we can build on
at a later point if any such usecases come up.

Patrick

--pAEH1j7vd7lR5AmM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNt4h0ACgkQVbJhu7ck
PpT5bg//eTWzahrBTaz0zzH2UaIPIBtCelgk16IDC4KZRxnoVLbl64pRh+H0TWef
MtsrGguIDEhzgmq2s2jgFNAO5tY7X6O/UZOHYWJkBaOuLC0sPyikl/W8cTcP/bDx
s/PNgmd493Mlo9SAtLlGfAhOdREGAuMrSGzAw+VgpYkdX9d4Pgmf0fpm/YCfwV7e
sLsqagwhTtlmXKAiscccU8MKh5VzLBiwQzDDkqFikQzLaT8RPqGreWvC3qimLC1G
orOZf+JCkAaZldknVm0Dnvw8jp4/X5KaGUNDU1vjQ34qQ6Ov5QVpb/j/9EsHIQOs
S2K9kOngozSyW9aZoMve5asjTIhZDEzqirujsflXx45UM+UrtGYge5V0CkqGjz95
CJPjK8UyFALMBvkbzVSVNF0ORyYKn94Zr9XqdyLgaGj3zuJdPGfFFLTB05g/OYwx
KO46GwHl0OeIs8gmXOqamlxbysklizXz5Shq9fVaJD7aF3bAGpvcs3WKHmS33vtt
eB3EWEqESR4lb2oo/DdfINZ1UwKvQdW7twutGW8SG3X1Rl0ecA5psKHIIOu+NfGy
r7FVK2SaUz8BXMl6RiEZCc9tkNJXpaOR8/h+mOw3jK6EpGP9llJ54sUncnQSWcAS
rP4rqj905F16NGJtT5BV79AtUesdY5Gh9wxaxKyGxFbPzVQLpTA=
=WV/H
-----END PGP SIGNATURE-----

--pAEH1j7vd7lR5AmM--
