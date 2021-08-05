Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE30C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 06:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE62360C41
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 06:06:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbhHEGFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 02:05:13 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:36395 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229892AbhHEGFL (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2021 02:05:11 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4B5085C00BA;
        Thu,  5 Aug 2021 02:04:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 05 Aug 2021 02:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=JQljBXJYfOyOjQHtjfRwDZrytJV
        0+Q1KhTHryqE4nLk=; b=U3Q63lJHwztXyc/S3PUfUWooddKMuxEXmbQ5+ubYYUb
        W+HRzcDnhQnBTYgpD9g983YiSTxEEs+2dfK/lKhe+GN7+UJ7ueGBQi+C9Dt2zEFI
        PjJupNprtkFyNmGUzrxJTMcfKcW9ccUyiFyeUTU1mPB698O4hKUAT7blf6Mn2IZE
        NymvDuT+Wb0P6ddNrVnURq9MDC7RiV7NgDUTGq/cBn7NwOO7Utad/ifCso+tvmCP
        fKUXhn5XQlK1PI1kcHG/gtNbFJ+TIvzf0VEj1FFYTUPw0asON8bfCqmN1o3wK6j6
        HOcwecPLqLMXLHtnUdVsmg7DhX6OpAlDJsvRPXq+00A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=JQljBX
        JYfOyOjQHtjfRwDZrytJV0+Q1KhTHryqE4nLk=; b=Cou9qHk4LCosRpJ4zaqQK0
        FB3ZA2Ge/WOojN951Rz7Y1jgkftZI1OmVcEtD64taeE3iTmb/J25a2054Iu1NWqo
        YCPH+UFA4DaxPi4ZDNVUsVg5X+/rEN+6EQx5DYaGN5tkFlUXikxFTmfYGNfjLwTi
        4bQ1iliSGVJqcpeFSOXlJOdbb8SnZWHKUJ4GXFQt0Vmuyme2ch/5gzlZCFFu1L+L
        kPR6gVBfIMz2zc995ll3wlwn9THMvTYs5bJhgv8u7KPRGLHknILghPtATj7LBk18
        VlyInq7A+zQR9sjRNtl47L3Mg1thOKlWGvZEmqad0t/SKCFC5HqtTl7zHNmaE5yw
        ==
X-ME-Sender: <xms:iH8LYcEUyrUQ_975urQz1-LA07F0IX7FxD2LDRA-m9Qig_2MK174Qw>
    <xme:iH8LYVVYkr0ok1v-kTpK16DbFgKKNJ_L64f3rg5tDHhoCpPyAy29Ymnf8efYuBukj
    9ckSApC9uv201Ha7g>
X-ME-Received: <xmr:iH8LYWJSaE6CQgCk50dueTkz2-_-WsjxCDnx1myLk5hbKb6nXJlUYAIp9CoReHZU-NRLvctpL6ZF5UcqilUIlZmzkjM9qonG-jd-R_ebUOjlZtlPuGTa5qM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrieekgdellecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeetkeekgffghfeiveeffedtffdtkeejieeige
    evveejffdufeffvdehgeekveefvdenucffohhmrghinhepphhusghlihgtqdhinhgsohig
    rdhorhhgpdhgihhtlhgrsgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:iH8LYeGLqk_oZIPyo1b4PgIUk7Ski07F2dkKnJKcTYArGSEaPEEgzg>
    <xmx:iH8LYSV5-XLgAXprhz-_kUm9-fzeR_AZ8OpipcFQkmCmSMGdNOeHeQ>
    <xmx:iH8LYRNvElwWx4PUPxCj9EvKsUaWml-Qj1wm35gjgjm9qFYOzXkJ1Q>
    <xmx:iX8LYbeZFNXjAxv2C1jQzo2k-Gn3v29Zp27YlDpsxq6OWHmByVhgzA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Aug 2021 02:04:56 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9ecea282 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Aug 2021 06:04:53 +0000 (UTC)
Date:   Thu, 5 Aug 2021 08:04:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: speed up loading of refs via commit graph
Message-ID: <YQt/g0iZxAVgw66o@ncase>
References: <08519b8ab6f395cffbcd5e530bfba6aaf64241a2.1628085347.git.ps@pks.im>
 <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qV+UAlUtJuynWxf"
Content-Disposition: inline
In-Reply-To: <YQr/vLNjZomIe1ME@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2qV+UAlUtJuynWxf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 04, 2021 at 04:59:40PM -0400, Jeff King wrote:
> On Wed, Aug 04, 2021 at 03:56:11PM +0200, Patrick Steinhardt wrote:
>=20
> > When doing reference negotiation, git-fetch-pack(1) is loading all refs
> > from disk in order to determine which commits it has in common with the
> > remote repository. This can be quite expensive in repositories with many
> > references though: in a real-world repository with around 2.2 million
> > refs, fetching a single commit by its ID takes around 44 seconds.
> >=20
> > Dominating the loading time is decompression and parsing of the objects
> > which are referenced by commits. Given the fact that we only care about
> > commits (or tags which can be peeled to one) in this context, there is
> > thus an easy performance win by switching the parsing logic to make use
> > of the commit graph in case we have one available. Like this, we avoid
> > hitting the object database to parse these commits but instead only load
> > them from the commit-graph. This results in a significant performance
> > boost when executing git-fetch in said repository with 2.2 million refs:
> >=20
> >     Benchmark #1: HEAD~: git fetch $remote $commit
> >       Time (mean =C2=B1 =CF=83):     44.168 s =C2=B1  0.341 s    [User:=
 42.985 s, System: 1.106 s]
> >       Range (min =E2=80=A6 max):   43.565 s =E2=80=A6 44.577 s    10 ru=
ns
> >=20
> >     Benchmark #2: HEAD: git fetch $remote $commit
> >       Time (mean =C2=B1 =CF=83):     19.498 s =C2=B1  0.724 s    [User:=
 18.751 s, System: 0.690 s]
> >       Range (min =E2=80=A6 max):   18.629 s =E2=80=A6 20.454 s    10 ru=
ns
> >=20
> >     Summary
> >       'HEAD: git fetch $remote $commit' ran
> >         2.27 =C2=B1 0.09 times faster than 'HEAD~: git fetch $remote $c=
ommit'
>=20
> Nice. I've sometimes wondered if parse_object() should be doing this
> optimization itself. Though we'd possibly still want callers (like this
> one) to give us more hints, since we already know the type is
> OBJ_COMMIT. Whereas parse_object() would have to discover that itself
> (though we already incur the extra type lookup there to handle blobs).

Would certainly make it much harder to hit this pitfall. The only thing
one needs to be cautious about is that we need to somehow assert the
object still exists in our ODB. Otherwise you may look up a commit via
the commit-graph even though the commit doesn't exist anymore.

> Do you have a lot of tags in your repository?

No, it's only about 2000 tags.

> I wonder where the remaining 20s is going.=20

Rebasing this commit on top of my git-rev-list(1) series [1] for the
connectivity check gives another 25% speedup, going down from 20s to 14s
(numbers are a bit different given that I'm on a different machine right
now). From here on, it's multiple things which take time:

    - 20% of the time is spent sorting the refs in
      `mark_complete_and_common_ref()`. This time around I feel less
      comfortable to just disable sorting given that it may impact
      correctness.

    - 30% of the time is spent looking up object types via
      `oid_object_info_extended()`, where 75% of these lookups come from
      `deref_without_lazy_fetch()`. This can be improved a bit by doing
      the `lookup_unknown_object()` dance, buying a modest speedup of
      ~8%. But this again has memory tradeoffs given that we must
      allocate the object such that all types would fit.

Other than that I don't see any obvious things in the flame graphs. In
case anybody is interested, I've posted flame graphs in our GitLab issue
at [2], with the state before this patch, with this patch and in
combination with [1].

[1]: http://public-inbox.org/git/cover.1627896460.git.ps@pks.im/
[2]: https://gitlab.com/gitlab-org/gitlab/-/issues/336657#note_642957933

>   - you'd want to double check that we always call this during ref
>     iteration (it looks like we do, and I think peel_iterated_ref()
>     falls back to a normal peel otherwise)
>=20
>   - for a tag-of-tag-of-X, that will give us the complete peel to X. But
>     it looks like deref_without_lazy_fetch() marks intermediate tags
>     with the COMPLETE flag, too. I'm not sure how important that is
>     (i.e., is it necessary for correctness, or just an optimization, in
>     which case we might be better off guessing that tags are
>     single-layer, as it's by far the common case).
>=20
> If we don't go that route, there's another possible speedup: after
> parsing a tag, the type of tag->tagged (if it is not NULL) will be known
> from the tag's contents, and we can avoid the oid_object_info_extended()
> type lookup. It might need some extra surgery to convince the tag-parse
> not to fetch promisor objects, though.
>=20
> I'm not sure it would make that big a difference, though. If we save one
> type-lookup per parsed tag, then the tag parsing is likely to dwarf it.

Yeah, I'd assume the same. And in any case, our repo doesn't really have
any problems with tags given that there's so few of them. So I wouldn't
really have the data to back up any performance improvements here.

Patrick

--2qV+UAlUtJuynWxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmELf4IACgkQVbJhu7ck
PpQ1aA/4hugsEI23ErVKM98oQyAuELWJ+NSyiQD5dYU3UgRCjopgmEj/3OqxW4Bd
ZA/diwSYr9idTwq3GRMK4NWRAQ3GRA6Q3rGf9Xtcq38f3bSAuy4thnBltMmAky+z
Xm5jCf462oZ7AEmDP3DZDUuh+DSHni8Je3A+WVBg9blZyHR3WYhzPW25n1yziSLt
wMUeLD21R4PqLiTeqNPYNRjUxgEYPV8MutZ0Q+a9ckSBuHYGFoqhgSwl16X44HwE
+WdZvp5eOSIXIZHXwtyIBTiZdWRNd8WIRhAFbjbvcnKH675wsUWGVVEvDQT6FyBE
OesOCfJbu3B8+n47kYbRlGfE6VjHtFCKjPAvAudR05S6v+S7amUX9HQn5EdP1YmR
dl/1emLxHOqTvgbjRatF95GNtH8/6NRtL1o+iHc5UTQLRjDevQ9WgUd1C3T1R3rR
eQK5InrGStgGEr/ccWSC9GKnrxDCv0HUi/LRA0O9qYjNkJvV5oN2pJSkegR3Ku4X
Ewzm5zF3YwrcWyqy3OBLTbKOiYkdl9NeFNAaxgSxeOdo+AVh4cZxryPYKzolPYrV
RFFDsIAYZP95bL5OMPbGyCObIocogMWB9P/CjQZgiQbvZZoWoY5xHTCseKnCskLw
EHMPPLZV27U8hVXN74+ZEh2kEF1/24CV7somVSMta8mIlsCxWw==
=BosG
-----END PGP SIGNATURE-----

--2qV+UAlUtJuynWxf--
