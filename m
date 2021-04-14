Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA0F1C433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78CA161132
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 12:00:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242476AbhDNMAT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Apr 2021 08:00:19 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:55805 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233625AbhDNMAS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 14 Apr 2021 08:00:18 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B22545C01C2;
        Wed, 14 Apr 2021 07:59:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 14 Apr 2021 07:59:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=Qn7jJ3c95uar7IXzNhiphq0KvAn
        +woSWrpJhgGIcIDQ=; b=ory43T517VZ0IHyFFonqVLROwUH5/N8wx+Uo2VTXLWg
        PynUQxMFtjThsUZrNJdjkw1xj5afBGfUwUbgbF7RSgkDwhdfl8WKj73RgXlOTLjt
        b0G4+b27wx+gUVKxQm6V6ScAWlL4XFUO72TES5eNSqHPnUGDGhDIh1RrcXHndj6K
        y7JcJpjtsy97cx6gtPnHa9CXujN07JKUgsRP0r5sGyzWeD+H+uGjAyuaklr4gb71
        3WlhceRYyS/nmIKntlZovoCVhk8sKAxHDXGHxX9McPXwyVG3yGtqyGQbTJCGWDAg
        xR8Sa+jABr0cnr1+P0pnydCRawpMdbrrmKH08ik7lYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=Qn7jJ3
        c95uar7IXzNhiphq0KvAn+woSWrpJhgGIcIDQ=; b=eU0PKZaiaopoUMGPpmthEg
        tU1q3himS/ZfULBHxP2yfzFKOY9vNxIIAWgZOxXXe/93qqLAnmOz9DQFgJsBgclu
        j1oxFMWJ/ccDJ12KDLlSC/O3RHJSe+iQa1fOjhFd4/+H2mDQEVomImB9vTGWZ0Bo
        smRE6T1O2SEfXdkMta6JTQBt2AbA0vYQbCmYRdiGQkpiKGsshlG48MJs99Q+2WrC
        d9P/C2/SXWrG6YTewMYburXP5TKhBtyvrPghmo6ybeG6wriv6Fo+UxEpZOvOz5vm
        dDcNaP8JQHj/S7Z9p2AJ3u1xjYb1k8df1qqd60CiPZ7DnS8B0788U0J7SYb1VMDg
        ==
X-ME-Sender: <xms:O9l2YK2JbSa-1VkL7CTCi1jTeF-vm231Pj_rCLqQwtbDWRRuqcWQ4w>
    <xme:O9l2YNEox_9Ra1_V3ye5d_dY03-DXvTnrxnUVYKJIppKuuXfqg5ADQZlYkOM4m34d
    6XNpEkh1mb0LCqOkQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeluddggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeivdejfeehieetkeegjeevfefftdevvddugfdvueehfeefjeefteduuedtfefggeen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejkedrheehrdefgedruddtie
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:O9l2YC5_hKxvzpzitb7V9GDMUdEJalzNal9zPavbxq17ufKrtJbIkQ>
    <xmx:O9l2YL3m-OWSdv9wirEMfiC9AWGAsFw2yLDxEkTrXK4ilnnfxvRijw>
    <xmx:O9l2YNHQx2LQ1wEXmVULGvJsObYCQPCqHANsbj3X5YMgqXXVfFKeqg>
    <xmx:PNl2YNArZWJDsjSukXfNo863cORZcsdNiA8Sequ-LoYIPdHL-rmCog>
Received: from vm-mail.pks.im (dynamic-078-055-034-106.78.55.pool.telefonica.de [78.55.34.106])
        by mail.messagingengine.com (Postfix) with ESMTPA id 14705108005F;
        Wed, 14 Apr 2021 07:59:54 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1218dcfd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 14 Apr 2021 11:59:50 +0000 (UTC)
Date:   Wed, 14 Apr 2021 13:59:48 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v4 0/8] rev-list: implement object type filter
Message-ID: <YHbZNL0gzw0+1k5h@ncase>
References: <cover.1617967252.git.ps@pks.im>
 <cover.1618234575.git.ps@pks.im>
 <YHVMEdeDv9ZeXRAU@coredump.intra.peff.net>
 <xmqqfsztlwxb.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nX3JUSe0V4BeV4jL"
Content-Disposition: inline
In-Reply-To: <xmqqfsztlwxb.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nX3JUSe0V4BeV4jL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 13, 2021 at 02:03:12PM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > Thanks. I have no more nits to pick. The only question left for me is
> > the big one of "do we like this with --filter, or should it be some kind
> > of rev-list option", as discussed in:
> >
> >   https://lore.kernel.org/git/YHB7R8hVRt+V+i2W@coredump.intra.peff.net/
>=20
> I do agree that adding "--blobs", "--trees", and "--tags" options to
> the "--objects" (and implicit --commits) to rev-list parameters is a
> lot more in line with the original design by Linus when we added
> "--objects" (vs not giving it).  We even internally have had the "do
> we show trees?" "do we show blobs?" separate bits from the very
> beginning of the "--objects" feature at 9de48752 (git-rev-list: add
> option to list all objects (not just commits), 2005-06-24), which
> was extended to cover tags at 3c90f03d (Prepare git-rev-list for
> tracking tag objects too, 2005-06-29).  The basic design principle
> hasn't changed when the code was reorganized to be closer to the
> current shape at ae563542 (First cut at libifying revlist
> generation, 2006-02-25).
>=20
> But back then, we didn't have mechanisms to filter rev-list output
> using other criteria, which brought us the umbrella notation to use
> "--filter=3D...", so as a notation, it might be OK, provided if
>=20
> 	git rev-list \
> 	    --filter=3Dobject:type=3Dtag \
> 	    --filter=3Dobject:type=3Dcommit \
> 	    --filter=3Dobject:type=3Dtree \
> 	    --filter=3Dobject:type=3Dblob "$@ther args"
>=20
> is an equivalent to existing
>=20
> 	git rev-list --objects "$@ther args"

Filters are currently AND filters, so specifying them multiple times
would cause us to print nothing. And I don't think we should treat
object:type filters any different compared to the other filters, because
that could limit our ability to iterate in the future where we may want
to add OR filters.

I initially said that I didn't want to add `object:type=3Dtag,commit`
filters as a way to say that all types which are either a tag or commit
should be printed because I thought that having the ability to combine
filters with an OR instead of an AND would be the better design here.
But on the other hand, there is no reason we cannot have both, and it
would implement your above usecase, even though syntax is different.

> I however have to wonder why this need so much code (in other words,
> why do we need more than just adding something similar to this block
> in the revision.c machinery:
>=20
> 	} else if (!strcmp(arg, "--objects")) {
> 		revs->tag_objects =3D 1;
> 		revs->tree_objects =3D 1;
> 		revs->blob_objects =3D 1;
>=20
> that flips <type>_objects member bits?) though.

So if we make this part of the rev machinery, I guess your idea is that
we can just put the logic into `show_object()`? That would indeed be a
lot simpler to implement with a lot less code. But on the other hand,
it's also less efficient: we cannot stop walking down the graph like we
can with the current design when e.g. saying "Only give me
{tags,commits,trees}". And with bitmap indices, we can even skip all
objects of a certain type at once, without having to load the object,
right inside the filtering logic. If this was part of `show_object()`,
we wouldn't be able to do so (easily).

Anyway, this is assuming that I'm not misinterpreting what you mean by
your above comment. So please let me know if I misunderstood.

Patrick

--nX3JUSe0V4BeV4jL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB22TQACgkQVbJhu7ck
PpQWxg/8CSzmfeoffcmHM2LozqKDgf93SqYIGR2LvekSceA+90BmFlje2raFQPuJ
2N4gDJlQlmoxBAU3Zqeg3RpMM540DdEYHjuy5B4yfeOPD+F4kP9dC2HPW96SnRwW
hM2xPHRfYqJPNx3X2M03LBVzNKZgDG9lpQNP46DsZEEFCSQ5KUaLGKxDb9y3IrYo
1zKDlSSjiMIIRInaE3GNpeWZ2YXkGrgBxCSlnYv6ZdXWelksDsc0CdcCf/N3csNQ
+B/CosCQdGFXQxxC0w7OUtGy9RPbzKXsWnjtdk1fFL2KjsBgXlRtOlC5X2QnjXPY
Usiozljjo9JxgAX2prayHeKZtzDHu8zrkvDsbe2DvOk6RyPr/t5oFekn9uO7G+Mx
BPcDHJPvrqqNgfW1iUNqbqtzyTAy4G6fBi3ocVId0o6LqeNSOaivqwr2ZIN6Sci8
Sl57HO4oQWjv6OHsZqxJ/6ArOGzrGlAcda82h0L3CkMsBDXQEVqM5rdO6zVJAfg6
cAksfW7LH6teN83kNs6q7I6NUN5yMJIt8ya8KeVK75kEGCFBWie2A8PoJwZC0pO2
60WBfuR4s1LV8oWQVXaSzoZp+yF6VSw6Jnc0CXXIUGsJySXWrT19MSCmSrUDj7o7
IxM6QsK+zxCDD0f7oImr/FyVstCRuDqbsw0/0o12Pwr8WDzQkmc=
=Qn8e
-----END PGP SIGNATURE-----

--nX3JUSe0V4BeV4jL--
