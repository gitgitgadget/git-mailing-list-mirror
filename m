Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CF5C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 17:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjDKR0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbjDKR00 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 13:26:26 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2585761A8
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:26:12 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 536CC320090C;
        Tue, 11 Apr 2023 13:26:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 11 Apr 2023 13:26:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681233970; x=1681320370; bh=8D
        Hhe0UkHYhRZVoSCjvSBg2LT3mwWOlv/NNyZe+E2WE=; b=NE1pOOcUdcoxfZYl1Q
        8h0eWW2tYpnbuKRqva/tWzzqL4LeYNmilAmnzK3h9wdjuD6465dK3EQrQSQcO8R6
        BfqhgR2T5MfV07A/u442oqDGWFaZlOM4ydMtNydh0W5yI8vLI72GLXNKCCg/g7fR
        YarGYYpqSlXeEgv/GKflInNGEen9Va+juP59AgGJJjYTfpjLY8wkAN852y0y2ATl
        oYFFD6zo/pMtK8EQNzpRRPp6k9y9gjzdW7oy9X19ojHe5knWjYJ80vw97UWShVPE
        BqJHGiGegVVHYamJxBG4sNHXU18J1JwpKT/K0oh2eFipLUVaEbUHrXG1NgWTRj8l
        /M0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681233970; x=1681320370; bh=8DHhe0UkHYhRZ
        VoSCjvSBg2LT3mwWOlv/NNyZe+E2WE=; b=ejR09rY2m3TIacXE6Gb8f0GV+2HR0
        QnHrbxBaraSspKVWx+cd49NjAWj5BqTU7sx3UFhJSSazFO+mkC+CmU0zmOxvvxKK
        Zpbs3xaox2oDi66s3ahqsO6+Eay+J+CDK3Ol1dNdo1QNdQ61a4q1Ogk5zJLthL3K
        exxZ1eMNwrrSza5G7tJKrRyzuCCzxWbLN3/sa8Vjl8+aEy95p17fJATvRDZURNJG
        lV+SQsyV3y/DI9aBBERByT2Fgy0WGzyju0ovxzLhFtGbL6zNmQFExIoT8aDOw5n9
        oWNWKFpncZTb+gLR/paLHMhJzTSy1AThbYqIUvLyCUHV+7+FMPe6yViBQ==
X-ME-Sender: <xms:Mpg1ZGcyLygs1KHJOc0scA2C7VYujvyZEp9V-YAl5LmAkng_MxcXLw>
    <xme:Mpg1ZAMcS5Qx-U8kbG9tc3OCwSMXx1bcCH6ZXAFzyoB2hjZE51EcbPXDdeE_8CXKC
    JYibrLGf9V4P7MpVg>
X-ME-Received: <xmr:Mpg1ZHj3SQMffBHj8o8hcQuioSzWctHIVajf9eXghS4C8w9t66uToY-HdqwtiBr8w1YnPFmSP6jvRSbSXCa42yB9qVTNTIgQ9c1xFjgb3ySxZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Mpg1ZD-aV1LMwI2Zu3A_oThcuLCXY1sIAv7En2UoLNyLzbJDpGaG0A>
    <xmx:Mpg1ZCsLOdTptvGYO7CGl9wymBs2hC9NLH09FGN7Y8GHizXtI7GjoA>
    <xmx:Mpg1ZKH_3LLhRuFe3sHR0jHH-KRRth3o8FNZL3AqPkMw_SjEvJAq6A>
    <xmx:Mpg1ZGJYLyh35yB7hFdIEXkuVcahCEud9VjYssIZuYK2NOvdKInGMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 13:26:08 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id c00099fb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Apr 2023 17:25:49 +0000 (UTC)
Date:   Tue, 11 Apr 2023 19:26:04 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZDWYLPw4Hk0-12Fe@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
 <ZC0eY8q6ushpfkrQ@ncase>
 <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
 <ZDWTp2RfFTbiE9I9@ncase>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="e9q1mEG3Qz2U3cb8"
Content-Disposition: inline
In-Reply-To: <ZDWTp2RfFTbiE9I9@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--e9q1mEG3Qz2U3cb8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 11, 2023 at 07:06:48PM +0200, Patrick Steinhardt wrote:
> On Mon, Apr 10, 2023 at 11:06:49AM -0400, Derrick Stolee wrote:
> > On 4/5/2023 3:08 AM, Patrick Steinhardt wrote:
> > > On Tue, Apr 04, 2023 at 02:55:50PM -0400, Taylor Blau wrote:
> > >> On Tue, Apr 04, 2023 at 01:08:33PM +0200, Patrick Steinhardt wrote:
> [snip]
> > > I'd personally be fine to start honoring the `po_args.local` flag so
> > > that we skip over any non-local packfiles there while ignoring the
> > > larger problem of non-local geometric repacks breaking in certain
> > > scenarios. It would at least improve the status quo as users now have=
 a
> > > way out in case they ever happen to hit that error. And it allows us =
to
> > > use geometric repacks in alternated repositories. But are we okay with
> > > punting on the larger issue for the time being?
> >=20
> > I think the real bug is isolated in write_midx_included_packs() in how
> > it may specify packs that the multi-pack-index cannot track. It should
> > be worth the time exploring if there is an easy fix there, and then the
> > po_args.local version can be used as a backup/performance tweak on top
> > of that.
>=20
> The problems are quite multi-faceted, but taken on their own most of the
> problems actually seem quite easy to fix. I've got a local patch series
> that addresses almost all of the pain points I have found until now:
>=20
> - A segfault in git-multi-pack-index(1) when passed no packfiles and a
>   preferred packfile that it cannot find.
>=20
> - The issue that git-repack(1) asks git-multi-pack-index(1) to write an
>   MIDX with packs that it cannot actually track because they are not
>   local.
>=20
> - An issue with git-pack-objects(1) that keeps it from packing objects
>   that are non-local due to the way `--stdin-packs` is only referring to
>   the packfile basenames.
>=20
> - The fact that we don't honor `-l` when doing geometric repacking.

Ah, one more thing I forgot: add a safety mechanism that disables
writing bitmaps when we see non-local packs.

Patrick

--e9q1mEG3Qz2U3cb8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ1mCsACgkQVbJhu7ck
PpQvRQ/8CgzYk5gDyuptYfqsmhwKDFvlghgyoodyM2UJH5ogHnfVmNgNjvfu32M2
j4XHzD4B6YChBJrcegIWtlvrmsIR+ZY/7AaqeTUKKvPDyVUl0bTfkvPBsbxL411w
JYFMQzykoL6fUIkYiyHz8n744fjgU1Il0CiWC1sa/We/up6J/pLwwNhZ5VnO18kr
HeJCabpsAyoXxPHxbUBew4p2CMq4utXvca/zxXVs/uIdH9AB06/3CdaSHsHlDeuJ
OjpaWiXZrywxurEkVXqL+YUk3IELdJc+kWuVLYBqJ8PHqrCez/PhOW/dHfmIGNqr
4wkzWh1lIOY2X1kVwy4MuU7EA1xh0DTCa9Nddj4IFYJ4O4BrjlYhdsldMI6+6g4x
BN8KHq6C16PxIOhNUZpFR6bsSuonsjdAFVxWLxkllO0gH0W1nOrUYDmcrzngCegF
BQcqfzJmElT42UzliJ9iLjz1evF/i4BRdd6DyfUTPsJcoOTsO8Kwm35BgqmYCobS
fsUfqon/9AXfJC0S/uiTB7TBVcY7+z8e/iJj+CpMj31URueD3ZDGCBfUKqGvta9O
0YW8+zxF3eJ+K+NGpHIm5fShBVre2zbXYMSMswezsGtxXVluryZVgOKTPaq8WqOn
fNZJYpZV88ZxgaRCR9cY0WiIoWJfT5nWkXIBd3itgE8dV4gC4Jc=
=xvbO
-----END PGP SIGNATURE-----

--e9q1mEG3Qz2U3cb8--
