Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47977C433EF
	for <git@archiver.kernel.org>; Wed,  2 Feb 2022 12:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237227AbiBBMvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Feb 2022 07:51:48 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:55693 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230258AbiBBMvq (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 2 Feb 2022 07:51:46 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 77D475C00F9;
        Wed,  2 Feb 2022 07:51:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 02 Feb 2022 07:51:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=YBB7TUFIM7QwQPFkv3eWmYzV5RX/Uck9bQSzb/
        HIed0=; b=Np9CrVkCyzJBfJGwgsRnW7X3eCJrmwopGCcqmc+IMX7ClGKdY/oq4Z
        ElCSG6HOPN5SFX5eytFQwWA4LO3d34tFK+H2TBpvYPNSLYR1VNVX0kdq/1On4Fm3
        gOueKYGg4s9jh3eUgy2lqS3+thmvJ/Vc5H9mCOs8hSkl50ae0BmvS5oI+vImp3JL
        NchAhL1U0l/hMBzH4cAuLVqj2t4ALofVLhcg2xpycQIOtXggCtWHrfzDNwyiN1Bk
        fMxP/GmE4flsayHfVDRF6UEVVAIJLMcCKw1VzWXLC/VPOHGPLsEWtEXviCXNlgnK
        VWeOazIgv76wEL/Hs5+LcX0tn98fBxZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=YBB7TUFIM7QwQPFkv
        3eWmYzV5RX/Uck9bQSzb/HIed0=; b=KLy+cGAW0F0Lz9EwxBue+It5BWaOEkKrM
        As+0/X0ym7djbbx8hFNEqafZBa/OIVANJldNWm8S28yYNGU8E3rPefhIRWdi3Qds
        unFS+0baczoUEENh0eytZZ+Q3yST+2IHdJJwysUt/g3h4/jmLexKjiyQPS/8oZ3A
        csSBQmrdDUXcM4juevLAiCBPiQ8/hRIMGxfPhKPquhxYNreF8hEljSPeRplbHy6+
        7CZNxR5oDmlPUiM/Q5USVcVx++mnuKNtOOhO8y3MQMFKeU45qCfYorlz1dr0keFy
        fhQ469CG1HM3p2B5DfBaW7R92lcogsOSSugle/1pibVV+asJPlACw==
X-ME-Sender: <xms:Yn76YRNmNGaumBi1nDiTtpK2SxCJab-g-mmKxxVxpgIxQXSFYpsyjg>
    <xme:Yn76YT-kfnPXVlwccUJ9Jf4hYH4xRn7KdI3KeBETMXH1oCeqUBj1NMg_BCOcNRFBC
    AcNqA-XN-HKRPzYdQ>
X-ME-Received: <xmr:Yn76YQTh8Pf3h4bePZ2aEEThk02bK_n6wXC1x4kz_BYVJxk5EME4fP8GIpOxdgvcweQ0y7kwxPsPeL1dEkzc_ajYVFbxc14obyo7dkXEjEeaGcmukuH5rzQY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeehgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:Yn76YdvSTCibe8VXuRwETotgGTiAPgXpCV9wGJ9QMu4QN2FnkJ3Vhw>
    <xmx:Yn76YZdNTraXUCoyHiOcNMfc6sfO-lbP8GdMZs8ifUiTbjLfipEtFg>
    <xmx:Yn76YZ1PJ_NgZ45hPIzMufXjQ1MNUL1vGMq9u5Fx8ej3RXU1zx3Ybw>
    <xmx:Yn76YZE-24JnQq12-vEWNkuJoB6ugsotFDs18RFSAiGnpchDJKmv8A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Feb 2022 07:51:45 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ce383cc3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 2 Feb 2022 12:51:44 +0000 (UTC)
Date:   Wed, 2 Feb 2022 13:51:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>
Subject: [PATCH v2 0/2] fetch: speed up mirror-fetches with many refs
Message-ID: <cover.1643806143.git.ps@pks.im>
References: <cover.1643364888.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6NJh4F1gwoH23qA7"
Content-Disposition: inline
In-Reply-To: <cover.1643364888.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6NJh4F1gwoH23qA7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series which aims to speed up
mirror-fetches in repos with huge amounts of refs. The only change
compared to v1 is a fixed up commit message: Taylor has pointed out to
me that commit dates retrieved from the commit-graph are not in fact the
corrected commit dates, which are stored separately.

Patrick

Patrick Steinhardt (2):
  fetch-pack: use commit-graph when computing cutoff
  fetch: skip computing output width when not printing anything

 builtin/fetch.c |  8 ++++++--
 fetch-pack.c    | 28 ++++++++++++++++------------
 2 files changed, 22 insertions(+), 14 deletions(-)

Range-diff against v1:
1:  31cf8f87a1 ! 1:  6fac914f0f fetch-pack: use commit-graph when computing=
 cutoff
    @@ Commit message
         the cutoff date. This can be sped up by trying to look up commits =
via
         the commit-graph first, which is a lot more efficient.
    =20
    -    One thing to keep in mind though is that the commit-graph corrects
    -    committer dates:
    -
    -        * A commit with at least one parent has corrected committer da=
te
    -          equal to the maximum of its commiter date and one more than =
the
    -          largest corrected committer date among its parents.
    -
    -    As a result, it may be that the commit date we load via the commit=
 graph
    -    is more recent than it would have been when loaded via the ODB, an=
d as a
    -    result we may also choose a more recent cutoff point. But as the c=
ode
    -    documents, this is only a heuristic and it is okay if we determine=
 a
    -    wrong cutoff date. The worst that can happen is that we report more
    -    commits as HAVEs to the server when using corrected dates.
    -
    -    Loading commits via the commit-graph is typically much faster than
    -    loading commits via the object database. Benchmarks in a repositor=
y with
    -    about 2,1 million refs and an up-to-date commit-graph show a 20% s=
peedup
    -    when mirror-fetching:
    +    Benchmarks in a repository with about 2,1 million refs and an up-t=
o-date
    +    commit-graph show a 20% speedup when mirror-fetching:
    =20
             Benchmark 1: git fetch --atomic +refs/*:refs/* (v2.35.0)
               Time (mean =C2=B1 =CF=83):     75.264 s =C2=B1  1.115 s    [=
User: 68.199 s, System: 10.094 s]
2:  5a3fd3232f =3D 2:  4b9bbcf795 fetch: skip computing output width when n=
ot printing anything
--=20
2.35.1


--6NJh4F1gwoH23qA7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmH6fl4ACgkQVbJhu7ck
PpQv7Q//S9mS3RFJE7lE6xm2rbtPbFtloETRWHMxlAW96JqO+61YpY009KaDohLB
J57/gkYKCnaAnwR9PkGmmEWFRdZNIOEU7/9EJnwg8Gw7d7JtJQ/2UuoW9WCsUbOg
dfdjG/DYGn2d3XkalOsVk359GIBf3BIvwgh1bMLvzkqayoj2h9rQ4YR6JwhbV9vo
ecXjL4eOgAs/dXh+XKUbuL2P11E4TyeLAZqazTkUgOVozecnq5vv2u0AKjk8mmiB
Yu3UMMVbT5bwAepx1XZAoUn4xoiH87Ptpb716wB3bPy3bS6vuWjDS1IpJG/K1jJS
YD49DkrVjcwRCZ8EGNHYDiEuTNAg2L45RWvt8naZrvt8N32m6ZfD3YlTduNuIHyP
BicgvAONFi+I+3bT3x35BzoaNUbifaoTb1rKhFKYPVmfEf/al6Pzn5YEwxcVn88b
3VPIXYNNnSlMLbQJ2q0uBS5Ere+cXG05PP27UhXQ2/v/cCpQo5XYN60Ck2nDJ4hg
PDxf+J2RFbRhq9EUHNpDFnnLFbb5tDD6zdhmZtLrYq0tzjXHXAaamd3kOUWzyKa0
s48ZVzxCXsQGeZfLF12fL+eWdCxp57fBl16NlaVqXizDIXYF4AJEpC4m/CKvfgAh
Po2YVABRHHrDP1pU6/xcHIQHwfdvyw+VGJeJvLX5XgqDmixNa5w=
=BwjV
-----END PGP SIGNATURE-----

--6NJh4F1gwoH23qA7--
