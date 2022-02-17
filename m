Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE2ABC433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 12:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240295AbiBQMDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 07:03:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240259AbiBQMD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 07:03:26 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4872A97D2
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 04:03:08 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id AE9883201F4E;
        Thu, 17 Feb 2022 07:03:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 17 Feb 2022 07:03:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=FlZXciH/4TAj10UgmDe7IeW++1DM7AqVZMR8ZC
        iw10w=; b=wmeCdpzDUy2STsLDKcNQjBgXlMgAE0c6TuY5HDK0bIn/WHDRqH44ex
        PCLrX90v+4Wdkoz5o9NkwJOsbLk0GbIGVZpXNqLxqBIYuA9r4YYc09TBFOHyVZrA
        DIOgopQj3ndBHU3zAzib3IOQcTIbVhitQQ/Xnjh4ufhRoRBo79iFf6BJLt30u8Lx
        Bu0MsM+N418zpUzMbSkuMEjvcgKTEnYTpNuptB4MOzieuQTC2ZLDwITUzAChM0Iq
        yoF2yc5i0D/b6Yfli34LK7o6S68v4tid7BXjiBhzZQq7VkW3b5BLfpcitF/rhWCK
        gXPe4/lyii9iM8/hLKAmgwLpc8CcLuWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=FlZXciH/4TAj10Ugm
        De7IeW++1DM7AqVZMR8ZCiw10w=; b=LWl04pZJSRuOLG5UBHh3s6NzrieWC3uoG
        8+06uwAb7bvpzpkhGV7Bxt0pTcK5HZV7uumsqXAqWTmBDs8jUz8n4VuoF6ZPFIYE
        JyFm0O7QLG99jDktCWuw0fvodhjSyfQfHZaSL4zhShi+vsOTITuddVV1iNAdr1Yk
        SNG7gV3v5CSArxj5TFBhuLV5uTeiBQX5AEp1FSy/M3dSJln1R++cGP2emIZ4seVC
        i9K2IFBNAWh0RiwaIcOh9X3zfTR1DCR/yt3wa3E4a39Y6AZslR2ldPllwktigVNv
        TlUtzxbVQG5SiBT9wqvfK0S5EbmJgsx15Ib9fqD7a3UgvQs5Rx+Ag==
X-ME-Sender: <xms:ezkOYj0REmx-TTo8W-AyH9_UQqribnIQm4isLL_8t-pwPaBvpum8WA>
    <xme:ezkOYiFBYFFLdviMPuq4fGUc1re4UTLqZfgFP7ybN3GWRvRU6Fc9ZgwLJ1gPS0i8y
    x7YcKJXSQ1Q2SEQjA>
X-ME-Received: <xmr:ezkOYj65S8DPPufm5UTaebttCi3ht_Ec0WRQ3cFBKxbpup1_P-dIwaiCminuLiemZf8Tyi3itLDOjpCuJVUWXohgu26EwRP0CpSWKVjdkYEoXaQPwU9rgXY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:ezkOYo3_traPVhKs6HT8zEEbWWxspRkZF91gM_-XbxM_yOg0dDjodQ>
    <xmx:ezkOYmFBw02n0S_IlYep2e6zP72EpyuDXxdOAeg8HtpZAXTw5_8AXA>
    <xmx:ezkOYp-YMm2K5dhvhrAjg1fAs7eTtACwnYhN5dXDBXS656dK7guJrg>
    <xmx:ezkOYhOAE0KkoLI7Lii2mv2wGNwB5wY_8vge-qptlFwLpesOQTvZwg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 07:03:06 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 027355f5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 12:03:04 +0000 (UTC)
Date:   Thu, 17 Feb 2022 13:03:03 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] fetch: make `--atomic` flag cover pruning of refs
Message-ID: <Yg45d4boNwsRhhPr@ncase>
References: <cover.1644565025.git.ps@pks.im>
 <682f16117b743bec59c533e15ae5a88d39250222.1644565025.git.ps@pks.im>
 <CAP8UFD3Fc9315jsbTFNzGunLyrm0P=zDLda2F=7O_5+B-ZtBOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/1ACfYu2cqNuBP1g"
Content-Disposition: inline
In-Reply-To: <CAP8UFD3Fc9315jsbTFNzGunLyrm0P=zDLda2F=7O_5+B-ZtBOA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/1ACfYu2cqNuBP1g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 10:12:23AM +0100, Christian Couder wrote:
> On Fri, Feb 11, 2022 at 9:25 AM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > When fetching with the `--prune` flag we will delete any local
> > references matching the fetch refspec which have disappeared on the
> > remote. This step is not currently covered by the `--atomic` flag: we
> > delete branches even though updating of local references has failed,
> > which means that the fetch is not an all-or-nothing operation.
>=20
> It could perhaps be seen as a regression by some users though, if
> updating of local references doesn't work anymore when deleting a
> local reference matching the fetch refspec fails.

I guess the same comment applies here as for the other patch: the
documentation says that we either update all or no refs, and that's not
what was happening previous to this patch.

> > Fix this bug by passing in the global transaction into `prune_refs()`:
> > if one is given, then we'll only queue up deletions and not commit them
> > right away.
> >
> > This change also improves performance when pruning many branches in a
> > repository with a big packed-refs file: every references is pruned in
> > its own transaction, which means that we potentially have to rewrite
> > the packed-refs files for every single reference we're about to prune.
>=20
> Yeah, I wonder if there could be a performance improvement in the
> previous patch too as it looks like tag backfilling wasn't atomic too.

I doubt it would be as measurable as it is here. The reason why we have
this speedup is that for every deleted ref, we need to rewrite the
complete contents of the packed-refs file only with that single ref
removed from it. So for 10k refs, we essentially write the file 10k
times.

For the backfilling case that doesn't happen though: we only write the
new loose refs, and that's not any faster in case we use a single
transaction. Sure, we'll likely be able to shed some of the overhead by
using a single transaction only, but it will not be as pronounced as it
is here.

This will be different though as soon as the reftable backend lands:
there we'd write all new refs in a single slice, and that's definitely
more efficient than writing one slice per backfilled ref.

Patrick

> > The following benchmark demonstrates this: it performs a pruning fetch
> > from a repository with a single reference into a repository with 100k
> > references, which causes us to prune all but one reference. This is of
> > course a very artificial setup, but serves to demonstrate the impact of
> > only having to write the packed-refs file once:
> >
> >     Benchmark 1: git fetch --prune --atomic +refs/*:refs/* (HEAD~)
> >       Time (mean =C2=B1 =CF=83):      2.366 s =C2=B1  0.021 s    [User:=
 0.858 s, System: 1.508 s]
> >       Range (min =E2=80=A6 max):    2.328 s =E2=80=A6  2.407 s    10 ru=
ns
> >
> >     Benchmark 2: git fetch --prune --atomic +refs/*:refs/* (HEAD)
> >       Time (mean =C2=B1 =CF=83):      1.369 s =C2=B1  0.017 s    [User:=
 0.715 s, System: 0.641 s]
> >       Range (min =E2=80=A6 max):    1.346 s =E2=80=A6  1.400 s    10 ru=
ns
> >
> >     Summary
> >       'git fetch --prune --atomic +refs/*:refs/* (HEAD)' ran
> >         1.73 =C2=B1 0.03 times faster than 'git fetch --prune --atomic =
+refs/*:refs/* (HEAD~)'
>=20
> Nice!

--/1ACfYu2cqNuBP1g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOOXYACgkQVbJhu7ck
PpRyag//WcooMPAxtReciAGgzufBWje4+LMFudkkpNTjCDA+2WIHtq2tWqpFKsAg
jneaHiHObDmzPRsYRiGZMZzdJbOvlLaJxCqAWVSQtebfokmxibnsbMdAtaOVzu1B
Mot6AImFnzPLtEIstyH/FoJp6MTa16Vp4eKJUrrksZK/7BJftNKKU+D7esZRvf+F
rDI13VhqaSlyNsSiBFNW3ST+0R9Wio9oFSpirzNEi75lOPVHHjJdVXBwU2T7d31a
9SYU/f0E+gwSdJrBassDYZLbGQOLD8kucK6fLl56gNERCGe+UHZjZghiZ0XkmZb4
LAE0+EShUSKgCg9U7zp77ILW0Q5JahtPDPf4y1K+2M6I84Kzme+Ml4WL+CSKAJyx
kAELU2wZ3Io5QzWKxS4l15srvqwSXBlWuJbyCKU7eQ9DptklDakezikdJiBxQkZf
8gt/1pSy3/OZM7JxU+xEuZw99eDHIu2M8LgIkilLDUTAScs/4BUJo4GhxJy8Vlqj
IA6jVfgbiNtIvrLgggCSINTpR5l2QHNxCondCjaPbS7H+rFViUfhI5Xc/PV/96sc
kQNEjcsOG1h8b7TOWgLDF+c1d6c6TvMH97Y21L9qenwzWzwVCqFq1fukNjHJsSdz
mKo4NZayT/GEpMa8BOyctJoGeizE7tDf8APPC1hQCD0G9SoiYg4=
=mpY9
-----END PGP SIGNATURE-----

--/1ACfYu2cqNuBP1g--
