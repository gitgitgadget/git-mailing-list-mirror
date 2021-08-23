Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978F2C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75FCD611C8
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhHWGxm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 02:53:42 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:51025 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231779AbhHWGxl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Aug 2021 02:53:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 89D825C00CD;
        Mon, 23 Aug 2021 02:52:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 23 Aug 2021 02:52:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=lK1n/69cwVyJwCY7qruFYOiVYn0
        1ivTDl6UdGX9x/U4=; b=JJAgrvviv+xlrKGnd960kymgadkYvSuMTSpjUOT9WK2
        hIoWbesc4HSADvzTrLWVMzOg48gzngns03bpKcqB+cOcsBzM1zHsM6s/EFjmweeU
        ERBGjvQhKcHr53rzWihtohjpfxlsmYy4+JnGfKNXYGXTYzKBCZIW8Ryu1SoWXiGG
        QzhYPBYNvxik1cY2mLnBQJNatoHcqenkD88zhvJHgfkxF2eYz5F8RZV5c42iTqn3
        CyOWBz88umXAEenwmOh/aC4KuB1v7AvzW05xpFshPurb09c8FSC3oSeVKpsHHCQM
        8WFoe4q+9CkZMARt5DRg5sd62uA5bW1nINgyiojV3+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=lK1n/6
        9cwVyJwCY7qruFYOiVYn01ivTDl6UdGX9x/U4=; b=XFMV3IVdYdULLFAShQLeO7
        tE9dMQRwRk7W6uMzZM109bk0rWYhYaZjb8FFCl3zy1O7JCHBl6aQQ+rPc6iV+S35
        77RK58Sh+PoNqpkjvzY17AcmMpSs3j1Bm9Esj1jIT31HtEb7rW8JSnBZqeWCT4qP
        qRPbO9KWasqwxvXK/4doHuPIMvn6XjiXK1fQnw3aDey2DEOUh+DiXQLX1Z6b/0gJ
        ORTiPmxK8b0ho4ndYNp696lMqYKUijdJEsOMLZRO+KBCX+WRG0t+iZfmpR5PcO0v
        aI0upS9jR5ddzUBMJhm8BB24ZmPtvAFdLvf4CyRIa1YHd9v31aq1jGGi3COQ1Xfg
        ==
X-ME-Sender: <xms:ykUjYQTdwkte3Ppy0sBOJB9LRBmBOFQf3BGd0qf2iD-Sn8laxrV5xQ>
    <xme:ykUjYdzOL9TnBJS4pDuEalqEsXluTvtZH8TEmaocWj5fqBvhhBYczal7F1iw4PJRN
    9OegPDUtOumtW35mw>
X-ME-Received: <xmr:ykUjYd0TZb6JpbbOkdpSvXYprGM-QsctyOl4F2OKCaKxWsWC0gvIAzh9G5xvptDvsiOOs4-nuG1x0Imb37GEyK21szEU8-kQzmcJXPwnvptyPzH4xxP-iI4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtgedgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ykUjYUBvgRuPrMHcj-tK0SHpOf9aZn9uB941f8etc_lJuYO-RUM-8Q>
    <xmx:ykUjYZiiU0uUY1e7ELqvEKC-7cxO7p6nAd2XXIJLcS5uSRx0HhO_DA>
    <xmx:ykUjYQpnt2vUQB1oK_XbkwjjxtqZ5LKTpHTacTQdZK2K2HWePl1bSg>
    <xmx:y0UjYevjvcskw_LaN8YNARM2yVM5blL2s_bP9htRymeOV-ZfWIQM3A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 02:52:57 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id db1ff874 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 23 Aug 2021 06:52:56 +0000 (UTC)
Date:   Mon, 23 Aug 2021 08:52:55 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/6] fetch: avoid second connectivity check if we already
 have all objects
Message-ID: <YSNFx9FdSWOy6b45@ncase>
References: <cover.1629452412.git.ps@pks.im>
 <646ac90e62aab4e4aec595d6848b60233bbe8c77.1629452412.git.ps@pks.im>
 <1d5ae688-fa08-6c8c-345f-9b0389e21dd7@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ravmerzpDfwPWUQj"
Content-Disposition: inline
In-Reply-To: <1d5ae688-fa08-6c8c-345f-9b0389e21dd7@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ravmerzpDfwPWUQj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2021 at 10:47:11AM -0400, Derrick Stolee wrote:
> On 8/20/2021 6:08 AM, Patrick Steinhardt wrote:
> > When fetching refs, we are doing two connectivity checks:
> >=20
> >     - The first one in `fetch_refs()` is done such that we can
> >       short-circuit the case where we already have all objects
> >       referenced by the updated set of refs.
> >=20
> >     - The second one in `store_updated_refs()` does a sanity check that
> >       we have all objects after we have fetched the packfile.
> >=20
> > We always execute both connectivity checks, but this is wasteful in case
> > the first connectivity check already notices that we have all objects
> > locally available.
> >=20
> > Refactor the code to do both connectivity checks in `fetch_refs()`,
> > which allows us to easily skip the second connectivity check if we
> > already have all objects available. This refactoring is safe to do given
> > that we always call `fetch_refs()` followed by `consume_refs()`, which
> > is the only caller of `store_updated_refs()`.
>=20
> Should we try to make it more clear that fetch_refs() must be followed
> by consume_refs() via a comment above the fetch_refs(), or possibly even
> its call sites?

I wasn't quite happy with this outcome, either. How about we instead
merge both functions into `fetch_and_consume_refs()`? Both are quite
short, and that makes sure we always call them together to make the
requirement explicit.

I'll add another patch to do this refactoring.

Patrick

--ravmerzpDfwPWUQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEjRcYACgkQVbJhu7ck
PpQ8IA/+IkFw46FbeiV0jC6N0sdF1mgO7R2R/Jci1zY9Qlk7cb34KckhokFDcEo4
tPZGD9OUadmXyk5UeG36kcfLAzf5AYWzve13pViANtRQlB+gAkrldePDhbbt89JH
0hQOyRKbQu/Tt/9udvOYCSya6Pi3Mg9VrRM7A2bcM8sqcrq1IQpIoHZs1N9aFgCS
+CNDq3/G5c25/RWMQojtjiJ3r27YyIWlncy9QYfReoFpOzsHAU9FSuufnaDbBJ9V
bwGVPbuZB3wph7xR48Ycyv6h10/vDWPKGPB/ngBmTU3mALCjM0tzR6ErLrqVs1xy
o6ChjOECxsTgrs1YpGj2mOcFsTF2oha7Wi4esBI+X9qQZm9o5uqbsfg5M444aVAr
74fbj0aVp1SFFHxhKHaVsxs4Lkr7NNaZWmmZSvK7VOR12u0LhX/Z4I9xstcNCMQD
93oRJzR54wNX/LYaNuAe+uE3irdwRt7PyaVUx/vBZPc3QpE52rtXeVeBXIY9AN7S
Of9YOVlDSfIwo154lm5u7Y0s5dlco3jGe3p6t5G1pkMM6eppiQhMpAq9YGq//1B3
rznQZV8Zjz6fwc+nepBEwsqN/+TEFjkrJqu9mXTiZRLUD8lXj2kPl7WfZ/mZWKc1
lX73KJ/WiaSJsWCYn7LdswzN80/fzkLMZQx+Nr2hSBeVODvftt4=
=YPZI
-----END PGP SIGNATURE-----

--ravmerzpDfwPWUQj--
