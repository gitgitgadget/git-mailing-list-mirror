Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B90C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B2C3610CC
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 11:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240678AbhHELCH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 07:02:07 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:35307 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240698AbhHELCH (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 07:02:07 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 7AD055C00ED;
        Thu,  5 Aug 2021 07:01:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 05 Aug 2021 07:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=V9sMJOJMlqd/4nOm2alOMtWVOeK
        7Ar5Iw14v+jkp1rw=; b=aXm967QHOPp1/Boz24/iBaTD2K4ZI5MU+10VRJZFth1
        wlP2iTbv7EODcpSH8TrhMNaABjG3vpxWOltrbXuII02Sgba+0YjkEX45GSSZ5kVt
        aCa8ZN2hupI487vU5OESQmRAVkVTsQZawNFajGbxQm/1Af5MVZo4tx5NExC1vFim
        gCoxPuXNuuzSit7LQeHdZCSiwbhPFqlfTyoLHOQnrxia3nG5E+cvrh1g7ZHFrOC5
        QJ3hmnO72XNqK/Bj9oMtzkQKUGkcRT81bNxpsTEt7BQP02dz3D/U94xjxj7SSgmn
        7fwT5iG1mcKxwX+J8VSzw5Q+HvE8NN5NNScgWxVmPjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=V9sMJO
        JMlqd/4nOm2alOMtWVOeK7Ar5Iw14v+jkp1rw=; b=D9OZweObL3tFK+Gh3Tc4p0
        +tro+cqTwh+kAANUCQ/Ta7I+dT4BBGuvE7p6xQIwNhIvCjAn5+XYk7d4/dzoFfR9
        xlBfgVKNY43PHzRL8JIrCSgPSk4JQH+sBDLTUwfCalS53X80E+Pd+SWN1m2Td5bA
        iglXkQ+31I38CO2vumXnLXDo7svsdSakOSP05qcs1k+BVANrHLBwCPJFuObPuX+R
        CBg+f0D9sjVIPUnTRxG5nQnlKN0GE9i89ztawhBcpHDeapfnCtuUQ+KJoduIZ0fw
        ovQSQ6N2QlIjqzHyPVSM+NR5VaLoNkCxqQWxSCrKqrjwGTdDqi3uRmI53WmBlEfA
        ==
X-ME-Sender: <xms:H8ULYeg545fTcaf_OSEWXZW0HaaDHzjKLWMMR079HsdhIXVkI_CN2g>
    <xme:H8ULYfAznKvIJg3tq4JNCMBoKrafNq6qhEKqqRmPT9IvZyAh56hn8aJhi7BLi08_3
    cP3amO2vEU0CdhzGg>
X-ME-Received: <xmr:H8ULYWEVzGA_SOXa3CDACsQma1CpUWOpDAJBUF7K7ygdmUtAMyTI5ijSxFlOnG9NYVdpPBVK5FeyHWXHoFx6skhuyP-B8G0yopFPrIbYoBRGviug3gKIg6s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieelgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:H8ULYXSsaaopD1GhlMUkoKusqM0n5hxcnHZnnkq-5JN0kcUhlnfxMw>
    <xmx:H8ULYbxpIk9KBP-kD9oDfKUiRjdnvFlWN30E0J3PtiiVMyzaI50V6A>
    <xmx:H8ULYV6J3J5R704eG4BCe6FoOi4zhNYouhFre-1TR8I1UvDQfBgRcg>
    <xmx:IMULYSnpsj9oRke5BDcC0z5E2BuABDowjw65RtpxDzL_oR2tEH3LlQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 07:01:50 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id a7dfc8bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 11:01:47 +0000 (UTC)
Date:   Thu, 5 Aug 2021 13:01:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 4/4] revision: avoid hitting packfiles when commits
 are in commit-graph
Message-ID: <YQvFGuf3Ba/5UNXk@ncase>
References: <cover.1624858240.git.ps@pks.im>
 <cover.1627896460.git.ps@pks.im>
 <f6fc2a5e6d94befa915fb59b6296ce3153820c13.1627896460.git.ps@pks.im>
 <xmqqwnp3vcow.fsf@gitster.g>
 <YQkJdDvRtyOPzszU@ncase>
 <xmqqmtpytcny.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Dr0EpGMHWkEfSJB+"
Content-Disposition: inline
In-Reply-To: <xmqqmtpytcny.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Dr0EpGMHWkEfSJB+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 03, 2021 at 02:56:49PM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> > I wonder what our stance on this is. I can definitely understand the
> > angle that this would be a deal breaker given that we now claim commits
> > exist which don't anymore.
>=20
> An optimization that produces a wrong result very fast is a useless
> optimization that has no place in our codebase.  But don't we have
> some clue recorded in the commit graph file that tells us with what
> packfile the graph is to be used (iow, if the named packfile still
> exists there, the objects recorded in the graph file are to be found
> there) or something?

Unfortunately, no. For bitmaps we have this information given that a
bitmap is tied to a specific pack anyway. But for commit-graphs, the
story is different given that they don't really care about the packs per
se, but only about the commits.

I was briefly wondering whether we can somehow use generation numbers to
cut off parsing some commits: given we have already observed a commit
with generation number N and we have determined that this commit's
object exists, and we now see a commit with generation number M with
M<N, then we can skip the object lookup because M is reachable by N and
thus its object must exist. But generation numbers cannot determine
reachability, but only unreachability, so I fear this is not possible.

We can do the following on top though:

diff --git a/revision.c b/revision.c
index 3527ef3f65..9e62de20ab 100644
--- a/revision.c
+++ b/revision.c
@@ -368,6 +368,8 @@ static struct object *get_reference(struct rev_info *re=
vs, const char *name,
 				object =3D NULL;
 				goto out;
 			}
+		} else if (!repo_has_object_file(revs->repo, oid)) {
+			die("bad object %s", name);
 		}
 	}

We assert that the object exists, but `repo_has_object_file()` won't try
to unpack the object header given that we request no info about the
object. And because the object ID has been part of the commit-graph, we
know that it's a commit. It's a bit slower compared to the version where
we don't assert object existence, but still a lot faster compared to
looking up the object type via the ODB:

    Benchmark #1: HEAD~: rev-list --unsorted-input --objects --quiet --not =
--all --not $(cat newrev)
      Time (mean =C2=B1 =CF=83):      4.512 s =C2=B1  0.057 s    [User: 4.1=
31 s, System: 0.381 s]
      Range (min =E2=80=A6 max):    4.435 s =E2=80=A6  4.632 s    10 runs

    Benchmark #2: without-existence rev-list --unsorted-input --objects --q=
uiet --not --all --not $(cat newrev)
      Time (mean =C2=B1 =CF=83):      2.903 s =C2=B1  0.022 s    [User: 2.5=
33 s, System: 0.369 s]
      Range (min =E2=80=A6 max):    2.878 s =E2=80=A6  2.954 s    10 runs

    Benchmark #3: with-existence: rev-list --unsorted-input --objects --qui=
et --not --all --not $(cat newrev)
      Time (mean =C2=B1 =CF=83):      3.071 s =C2=B1  0.014 s    [User: 2.7=
12 s, System: 0.358 s]
      Range (min =E2=80=A6 max):    3.050 s =E2=80=A6  3.088 s    10 runs

    Summary
      'without-existence: rev-list --unsorted-input --objects --quiet --not=
 --all --not $(cat newrev)' ran
        1.06 =C2=B1 0.01 times faster than 'with-existance: rev-list --unso=
rted-input --objects --quiet --not --all --not $(cat newrev)'
        1.55 =C2=B1 0.02 times faster than 'HEAD~: rev-list --unsorted-inpu=
t --objects --quiet --not --all --not $(cat newrev)'

Patrick

--Dr0EpGMHWkEfSJB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELxRkACgkQVbJhu7ck
PpQMkA/9EzwIaminY2/7O73VKL+1jglfirdQYnbl1WtS2TWChAus1utqblxSvy8q
Pd0tQOiW3gl/3O+5B0OLyaPnxda5iGFTOqFoRNcnxOyUfklcUPKv8r+8UmuC1M93
ASrgQgAMzvHGHpK9iWcDslXhP7q8WFnLWtSIzXlk1uRP7YOa+5XHhEl1g2lpiDnW
bYwiaUGqvPD6kooJq076ifHETXR9cZQGaKxQJaSF5poeWD8+QIL4W3k7ToOugdXV
qI73CFAYS1aCHX6ywdypXFr06Nt3gI4FsuwdFixmKldyEpeH2tIMth7NBkGXVxU/
/rg3P0Qjl4nKy5jLFlHyhJRaqV897P3Ilvjpc3rFUx1JUx5Rw6cM8f694kAJFEge
WHpAeoRWJXv1f/2iNClbtxhoNj+80WVMPikLuNnp2zSUrJFDion+PzkyJRQw42sN
Np9D/G6dnGJ9pClBmZQJI6nM09TZV/dTrAr27dLlxdVokDdwtmqPH4hXvq9CdCSl
v+uXpe4SUZGSJsIxWFwLFViPTAdasWGhpp54fmFifKOqb1i+Yt60Ir9GPNGGu9mb
TDv7otPy05MXYPpbp9v4kTu40bbzKg5lo2F0YjgeuLHuncm8fU/FNLy9k5Sf8Mme
TptZhkGJUPSn/uSkQSrVDjTtiMxJwqmXDvzIpofYtcfVQC8yblU=
=WfV1
-----END PGP SIGNATURE-----

--Dr0EpGMHWkEfSJB+--
