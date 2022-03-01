Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52105C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 08:44:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbiCAIoq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 03:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiCAIop (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 03:44:45 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D807C789
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 00:44:04 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id CE0C45C026A;
        Tue,  1 Mar 2022 03:44:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 01 Mar 2022 03:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=NeoJtc4WpiPQyPH6G8niadlDN01kSR4l8JYO3c
        LLX4M=; b=lk2gDQfWEnBTzEkoYFyTacBSwK0PbVGRyStyP6UPxJx4UywqlWSofV
        bt1y+POM5vsi6DUYmQgSVEp81VfBpiHgHQ4lTVTi37Nf0AV4ftC5Z5mhieEvLTla
        Tq+RLnhxRShpRC/iKL+U6vzMaone1xVc7Qx2/qqkQZnld0/snZ7WTf9o2dncpdwo
        llFj5UT/DqHgpFxswa+b7lmYGumIFWK57sVErgfoD7y0oNw34ZAwz5bv1r3n85h5
        Td9PuumaRVfY5icudnCmJgqYdmA/IiU5mJpXdBlaxZDHP5w0/QWauST+KNUZ4LQD
        YHEM7WBGyGKRB4OurHQ9mFdVm9YpTvGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=NeoJtc4WpiPQyPH6G
        8niadlDN01kSR4l8JYO3cLLX4M=; b=Pv3XdkVmDT8Vqp/7JFUFBcz5i6qMzXEYp
        WmgTMzqHA8Cot4CYlKqm0uRb17y9k35/eQfeFiPkULgbyrBPw02y6JmYD5CnugqQ
        is3pdqmcQpozEhpvGEIQbPs1K+Px/4fJ+iUfbWGvR9W1toZFL0+22v0x/UHprFks
        /1ZfQblE5B1mtQ6F8i6OgN85FwOghOGAx4/nvzhS06xaM+vnT+inW/VawafBplgr
        UTsVkaJLnNV4NRSRvGL8jtPaJx5FpSMTqkoKc8fvccCrrJloA8eIL/vm8kgvH0xj
        M0pY34G+28ySaDWZlMoWo8W3M/k/0Dd9ol87pLCV1Xu7iCioeAGeg==
X-ME-Sender: <xms:09wdYiukVL4jdBenp77hcfFIgLtnpk8p4JtlbifUMSxRUvfxfxEsjQ>
    <xme:09wdYnekIv-kw6D70txmGfbT4EqaDXbyezRHnWWmHzQ4U9j-Heh-fq8qUNyW_2yey
    mneQeDCKq-TDB_NvA>
X-ME-Received: <xmr:09wdYtxIl4jhptrq74bWUfa7fAyXpm0qP4PxpS2byPrf1OWULhcuYrimIsh3_P4Z6glqn7Hr_NMDm3bN4iTjbtqiwMCxyhQSHPx7V31ixzL1jbVlVRd0mMK2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:09wdYtMZk0tpb4ly_KD_-_uGIM3qJ0y-RormkaO68SEvEHY6BFVXwQ>
    <xmx:09wdYi9VnVv47W0d4bQB_4o7-MB2knJqWHm3204XiqVHjo5Kv1i96Q>
    <xmx:09wdYlUbwCYQOWWiGtr8NTAJEN5o_5ptE5lg7XZzEdZRxQlyhJHC1g>
    <xmx:09wdYnEl2uVOxVIFjg0kz3pfyrW1qj4NVOLUVvvR4oeTOY6WXqr9qQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Mar 2022 03:44:03 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 76e728e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 1 Mar 2022 08:44:01 +0000 (UTC)
Date:   Tue, 1 Mar 2022 09:44:00 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] fetch: avoid lookup of commits when not appending to
 FETCH_HEAD
Message-ID: <Yh3c0PvV1f3HEsOI@ncase>
References: <cover.1645619224.git.ps@pks.im>
 <80f993dddd521133154a751aeaab86adee409eea.1645619224.git.ps@pks.im>
 <33154b3c-1316-aab3-46a1-a0fbd87293de@github.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bcgLmcbULamMRoKM"
Content-Disposition: inline
In-Reply-To: <33154b3c-1316-aab3-46a1-a0fbd87293de@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bcgLmcbULamMRoKM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 23, 2022 at 09:18:05AM -0500, Derrick Stolee wrote:
> On 2/23/2022 7:35 AM, Patrick Steinhardt wrote:
> > When fetching from a remote repository we will by default write what has
> > been fetched into the special FETCH_HEAD reference. The order in which
> > references are written depends on whether the reference is for merge or
> > not, which, despite some other conditions, is also determined based on
> > whether the old object ID the reference is being updated from actually
> > exists in the repository.
> >=20
> > To write FETCH_HEAD we thus loop through all references thrice: once for
> > the references that are about to be merged, once for the references that
> > are not for merge, and finally for all references that are ignored. For
> > every iteration, we then look up the old object ID to determine whether
> > the referenced object exists so that we can label it as "not-for-merge"
> > if it doesn't exist. It goes without saying that this can be expensive
> > in case where we are fetching a lot of references.
> >=20
> > While this is hard to avoid in the case where we're writing FETCH_HEAD,
> > users can in fact ask us to skip this work via `--no-write-fetch-head`.
> > In that case, we do not care for the result of those lookups at all
> > because we don't have to order writes to FETCH_HEAD in the first place.
> >=20
> > Skip this busywork in case we're not writing to FETCH_HEAD. The
> > following benchmark performs a mirror-fetch in a repository with about
> > two million references:
> >=20
> >     Benchmark 1: git fetch --prune --no-write-fetch-head +refs/*:refs/*=
 (HEAD~)
> >       Time (mean =C2=B1 =CF=83):     75.388 s =C2=B1  1.942 s    [User:=
 71.103 s, System: 8.953 s]
> >       Range (min =E2=80=A6 max):   73.184 s =E2=80=A6 76.845 s    3 runs
> >=20
> >     Benchmark 2: git fetch --prune --no-write-fetch-head +refs/*:refs/*=
 (HEAD)
> >       Time (mean =C2=B1 =CF=83):     69.486 s =C2=B1  1.016 s    [User:=
 65.941 s, System: 8.806 s]
> >       Range (min =E2=80=A6 max):   68.864 s =E2=80=A6 70.659 s    3 runs
> >=20
> >     Summary
> >       'git fetch --prune --no-write-fetch-head +refs/*:refs/* (HEAD)' r=
an
> >         1.08 =C2=B1 0.03 times faster than 'git fetch --prune --no-writ=
e-fetch-head +refs/*:refs/* (HEAD~)'
>=20
> I have a super-small nitpick here.
>=20
> I see that you are using '-n' to name your experiments. These names
> are a bit long, especially since they are the same Git command but
> built at different commits. It would be enough to say the command
> you are testing before the stats and leave the names as "HEAD" and
> "HEAD~" (or, I typically use "new" and "old", respectively).

Fair enough, will change.

Patrick

> >  			/*
> > -			 * References in "refs/tags/" are often going to point
> > -			 * to annotated tags, which are not part of the
> > -			 * commit-graph. We thus only try to look up refs in
> > -			 * the graph which are not in that namespace to not
> > -			 * regress performance in repositories with many
> > -			 * annotated tags.
> > +			 * When writing FETCH_HEAD we need to determine whether
> > +			 * we already have the commit or not. If not, then the
> > +			 * reference is not for merge and needs to be written
> > +			 * to the reflog after other commits which we already
> > +			 * have. We're not interested in this property though
> > +			 * in case FETCH_HEAD is not to be updated, so we can
> > +			 * skip the classification in that case.
> >  			 */
> > -			if (!starts_with(rm->name, "refs/tags/"))
> > -				commit =3D lookup_commit_in_graph(the_repository, &rm->old_oid);
> > -			if (!commit) {
> > -				commit =3D lookup_commit_reference_gently(the_repository,
> > -									&rm->old_oid,
> > -									1);
> > -				if (!commit)
> > -					rm->fetch_head_status =3D FETCH_HEAD_NOT_FOR_MERGE;
> > +			if (fetch_head->fp) {
> > +				struct commit *commit =3D NULL;
> > +
> > +				/*
> > +				 * References in "refs/tags/" are often going to point
> > +				 * to annotated tags, which are not part of the
> > +				 * commit-graph. We thus only try to look up refs in
> > +				 * the graph which are not in that namespace to not
> > +				 * regress performance in repositories with many
> > +				 * annotated tags.
> > +				 */
> > +				if (!starts_with(rm->name, "refs/tags/"))
> > +					commit =3D lookup_commit_in_graph(the_repository, &rm->old_oid);
> > +				if (!commit) {
> > +					commit =3D lookup_commit_reference_gently(the_repository,
> > +										&rm->old_oid,
> > +										1);
> > +					if (!commit)
> > +						rm->fetch_head_status =3D FETCH_HEAD_NOT_FOR_MERGE;
> > +				}
> >  			}
> Looks good. Most of the diff is whitespace.
>=20
> Thanks,
> -Stolee

--bcgLmcbULamMRoKM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmId3M8ACgkQVbJhu7ck
PpTQVw//QkUOM248lPyujZ1dHzz3fYgv0Phy/C1f1STjvVu17DuueGK+JqgaswMT
VrxyFEObwj7X3QjyMfbtUnfQsekN1CAOO6c1dailHRCLyJIAr9iytU+If+Uhg0Yu
R+7BDxLzldhcitN75IYpyCh1KCjxNokH0PYiifeYZMlyFqnUTKjXktXarOz53HPf
rnK9OwNvk7+aa8RL3ODpw2XjZDZYttfoAiNcY+3QVbYfaRajNoIIL5Eki15zSGA1
zwsRwVwmIaejZy8wyXFF1PBeZr4feGRBUMbkh4RAw+PVl4HYywJumzX5ACYIlMl+
jZYG0z5kbnqLlHe85s2eBNegU7suHcW1atESrQ8vNFLjE+3MQHY1V5iwmjDmBjF5
cA+iY2IjGyDMAR19ghXYVBni0kHgpfIY4FFazokIaSqsi6nBzljdAOSXzxPEQqS6
hiImvSJK0en/qLoy4KGvfbJqwXi1DQo2kyYbN3poQvgCjvMSmOTOtQ/YnvtUx72/
Q5wXSl9kmfJtheMCyuubIPAJAq28N0md0VeTA9nyatXybaZF2b4BH6qeKqF2Guu7
LZ6ErM4WEfb421e/yYYPiwv+/GM864zPp8g5b6jGhtiRYybV7AJ+yChULQHbZnur
GmQC6Ncs+TMEHhvkAF5k3cKsasyr5J5BiNE5l/W+VjxooopXcM0=
=5J0B
-----END PGP SIGNATURE-----

--bcgLmcbULamMRoKM--
