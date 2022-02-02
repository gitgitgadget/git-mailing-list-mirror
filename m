Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 480E8C433F5
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 12:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbiBBMqm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 07:46:42 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52989 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237243AbiBBMql (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Feb 2022 07:46:41 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A24E5C01CE;
        Wed,  2 Feb 2022 07:46:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 02 Feb 2022 07:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=BCCN6qkY8fQZBWb8xdhVdn5iTx65TRN+Irs8JV
        gnh8M=; b=DLLZ+Dwf8DlWpigcqj/+/dWmfp0J+XlyQpLf/VYZstCbKn72VZ+fff
        OlLQ6GEh+PFhaSPZjERKdPMrRKvBU/Z3JhFxT/+s3aPNZX6A8vtsIrHgX/+yRKKy
        oUWO5SYLN89WQ/zr9YyM4tMW2ej9xM6c4UXUN0ibsYt5cwnjzFvdzNqhLWYgYyPK
        ESUB6/gTSaI9b0MT91Z8OwO102y4r50ke44MCUx3NNUxDmp4SkjANE5YGU0VyRgk
        SM+acpL9HVSwOXF7ZdjrOiD3M7G/6rz0pRnmSdMpbi9zFVFVjK2YMoujn81lnPh+
        GuTaBi9L6x+6MuJu73wvfxFwp9j5gjkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=BCCN6qkY8fQZBWb8x
        dhVdn5iTx65TRN+Irs8JVgnh8M=; b=cGPzEbNRhmnPl7qWW6H4iyVlIvHn5kL92
        IEcStQNYY9I4ulGyiNKLHRJcTX/FjoI+lShiTi+WG8f/JgB9iipoZ0k5k2ooeXM+
        HvniiodwEOHIaItYw/FtOisMDsniB1ZJ6D41mbPPJ3SksMZMgzwof3tV8QYB1xPa
        wFH/3nC8CkVzAZxOPh5cVVVLUuoS8LMorfH+B75k58fWdi4Yci0nb76NdbJIKrnk
        rd2IzXVy5Awgl4r0e1C8txvrFhaWfawN9n4tXpaVtfBswEMiaAiXtQlt5RNKpkOJ
        qnpysJaQQbNnxYsSB33ZjkBX8Hi4/WiLBUEPKGPWcOlN4GKLITrEw==
X-ME-Sender: <xms:MX36YYkRNfi1eBsOj5yUgn8_RiKj1uSBOuCRw8G60iPcgO7sCgehOg>
    <xme:MX36YX2pm5x9CC2aJ7Y9bLE7gFHvhQ32lqGrUUosa4zPgMZX5SGzUWC6o8hssNJbn
    HF_q24OZIRbExCQmQ>
X-ME-Received: <xmr:MX36YWrQKSWIiHC2_coB08FASPEdX47JGcRlnV2gO29IgQ-PHWbPm1Ffl53mLXxuye8e3WPFyDRgfOjWHwtOib1mpdsIifr3p2YE5HTI6GzZ7mPEeyqd63Dv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:MX36YUllqLbYkbsJC-hwefvf5y_OSK4HKSNxj_P319IzHLtoms5vTA>
    <xmx:MX36YW16QvooHkjFtuV5hq3bmDY5iOAgJ3eUL2eroK54ybteJMtdTw>
    <xmx:MX36YbuqrisTpFTbcRZB4pol8rh7BmekdKEns8WC5dTvy1RQ2kyDSw>
    <xmx:MX36Yb9wgThInXoYYxFBMQVBnULcDbKURVQW0indD65XSTDl_9nI0A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 07:46:40 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 293ada68 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 2 Feb 2022 12:46:35 +0000 (UTC)
Date:   Wed, 2 Feb 2022 13:46:34 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] fetch-pack: use commit-graph when computing cutoff
Message-ID: <Yfp9KsvvQa5yWuLE@ncase>
References: <cover.1643364888.git.ps@pks.im>
 <31cf8f87a149c0fc8013b869e0e30364f3c60e01.1643364888.git.ps@pks.im>
 <YfhoWk1LFnzbFaQf@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mF0jwow/aGuhhS4u"
Content-Disposition: inline
In-Reply-To: <YfhoWk1LFnzbFaQf@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mF0jwow/aGuhhS4u
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 31, 2022 at 05:53:14PM -0500, Taylor Blau wrote:
> (+cc Stolee, in case anything I'm saying here is wrong)
>=20
> On Fri, Jan 28, 2022 at 11:17:03AM +0100, Patrick Steinhardt wrote:
> > One thing to keep in mind though is that the commit-graph corrects
> > committer dates:
> >
> >     * A commit with at least one parent has corrected committer date
> >       equal to the maximum of its commiter date and one more than the
> >       largest corrected committer date among its parents.
>=20
> This snippet refers to how correct committer dates are computed, not how
> the commit dates themselves are stored.
>=20
> Indeed, the corrected committer date is used to compute the corrected
> commit date offset, which is the "v2" generation number scheme (as
> opposed to topological levels, which make up "v1").
>=20
> But that is entirely separate from the committer dates stored by the
> commit-graph file, which are faithful representations of the exact
> committer date attached to each commit.
>=20
> Looking at the very last few lines of the main loop in
> write_graph_chunk_data() (where the committer dates are stored):
>=20
>     if (sizeof((*list)->date) > 4)
>       packedDate[0] =3D htonl(((*list)->date >> 32) & 0x3);
>     else
>       packedDate[0] =3D 0;
>=20
>     packedDate[0] |=3D htonl(*topo_level_slab_at(ctx->topo_levels, *list)=
 << 2);
>     packedDate[1] =3D htonl((*list)->date);
>     hashwrite(f, packedDate, 8);
>=20
> the low-order 34 bits are used to store the commit's `->date` field, and
> the remaining high-order 30 bits are used to store the generation
> number. (You can look in `fill_commit_graph_info()` to see that we only
> use those 34 bits to write back the date field).
>=20
> So I think this paragraph (and the ones related to it) about this being
> an approximation and that being OK since this is a heuristic can all go
> away.
>=20
> Thanks,
> Taylor

Aha, that makes a lot of sense. Thanks a lot for correcting my
misconception! I'll send a v2 of this patch series with the corrected
commit message.

Patrick

--mF0jwow/aGuhhS4u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmH6fSkACgkQVbJhu7ck
PpRzKBAAi+WDEL8HbnqobuMJFRei6sjW7Vp/0pExtybB7csGaGs3y7G17e/HePK4
mV/1ZEbXzlwrmjdCcn9O8ct++O1DnblCgKdMe0PPLLcqPGSNCX4GLwOR60fmzdtR
K1aMkiJn+mJB3UewsisXhLc4aW0yELm5BNXDrp1V69Uz1msPC3eWMBR2NK/MFTkU
YzsLX0g4CCRwdvN+p2mywR3bF1JpMR+Zt0r255WKPVnVECsyzV3r9aa0Xgupb6kS
9mqUagZIC4pOYc1NRVezONoau+EEy1dTfYdwhCW8wRFTyZrymGjjWuE1ACMPtwG8
HrVhIozNhQw9bVtpkeD8YGFCvuxF0PTYaTP6gBHXk64AyV6+h5FvQw5KZfmiYP9R
v0oOkBbX5LY9J3eFnrpTy7i5N+JUDOrU2qmskyfWM5zrrjJ+TW8FcyVZ+y5fhr2U
0PwWVmNMGS0kZyFF0S9Wp0SmkrIAf3jQZJN+PCXwlIrCKLmJlqMUhXb1AUOPjmMl
Vy9NL4scLFJZ5NpIT6l2IRquHUFw6APifgtZg9o+MwmvHCpJ13ZVb0LwoXXUdybk
dge1tKiMnAvQUPBJ6nbJ//hLXPGOFwuOBfUJViOmsP/kHFRwks4FHVOBRNejAV+z
Puj6gLoouEXcgSpwpuRHUrNH3ncdgvIcdcU/DfTrFD+TyDb0nlM=
=Mpka
-----END PGP SIGNATURE-----

--mF0jwow/aGuhhS4u--
