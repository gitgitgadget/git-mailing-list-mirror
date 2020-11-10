Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA04C56201
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97F582076E
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 12:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UCicLiKz";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P7ILrptO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbgKJMe3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:34:29 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58651 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731275AbgKJMe2 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 10 Nov 2020 07:34:28 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 41FE4880;
        Tue, 10 Nov 2020 07:34:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 10 Nov 2020 07:34:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=dPziJzAlThwGe9CevoksdUo8rlT
        KHOmRBWM5Pi2ywYM=; b=UCicLiKzWWy3B+7GiaHHSsh0tff0Bp2+XAmAmtHYal4
        Zeh2fG810P/kXMU2ZUCZ+3flBNXviUww2mTpkN0v4BD6Z4apLhIYtptJ9GtDr/2J
        ec24upSvdX9B1f7j8V/c044o8EBz04NI56vDpSwZC9hJCBeHQrEJXrZkMXClrUoV
        0t1iP4sU7jpCasuH6aD95DLzEp43L6WumB/RJB7mA++F0BrnamMBRz5jtaRazgVz
        0aoHJwuje0j9rPx5Q9e/RuebZ7wmQkrRwdS0xeIEGnTocPAIdNp32RsvVb4rgZgY
        8ou4pakgIu5ftKeIS51xMYXiI2WCy1rEdXO6OpJt7kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=dPziJz
        AlThwGe9CevoksdUo8rlTKHOmRBWM5Pi2ywYM=; b=P7ILrptOzIDRCoCWhxR4Ra
        gVjT3hqLJldWuQA1p1iEhQFyMbtWACHCd0dZFPn8PpRf2yRZFsA22J4C7rIUFEoE
        lodGMXxN1bf0XxCHszC3+pIiLXUN9UphN4ztbW61a0liPqmT/5Ys9ANdfZUW+EZJ
        6mkMowxLv9/9tttX1tAjnxtz4MrTHHjc+PLywdxuXI8v0NOoLGcw27VcWYlLIr8N
        Oaq3NzFux5ziABDPHryGz6GunJ0qdbC4PDH8TMw/iRA9yEUQHdzFo5EycSs7WL44
        ik44AmgshrqDkO+hwTgOMwlUg6CKWoRJ9UXFk8j50A6w6cF/Si9Nar7NhuOYplZA
        ==
X-ME-Sender: <xms:0oiqX7jrzIXoyIpSLoxXGrMa_mTi8GrIRgCYoZlK5adGbvp_KERZ4w>
    <xme:0oiqX4DJnTndOYLTY5YXj5AOYfhYT7Co5e6vzUQ9vZNB4CUlkxaajDjenT1qnbHhq
    cThvJ7DP7sT0j4v5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddujedggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudeluddrvdehhedrudegkeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:0oiqX7EjmAQtfrus28CfvmSu-Ze6faICMDqVnut_dEKjIM_3toxyrg>
    <xmx:0oiqX4Sk505ACFXzy3MIH6mzl4gPQYGC3SSX5spCnPh0P0P0yqgCxA>
    <xmx:0oiqX4xoYxSjmrFimOwYezBq75asPqxboIHx2JuxNv1DXCz7f_JmmA>
    <xmx:0oiqX-alqVVcjNXP2pP18RK2qd41mSmf6nUd6RCbe-s_M2ydwm5oag>
Received: from vm-mail.pks.im (x4dbfff94.dyn.telefonica.de [77.191.255.148])
        by mail.messagingengine.com (Postfix) with ESMTPA id C92A73063082;
        Tue, 10 Nov 2020 07:34:25 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 815b60b0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 10 Nov 2020 12:34:24 +0000 (UTC)
Date:   Tue, 10 Nov 2020 13:34:22 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 1/4] t1400: Avoid touching refs on filesystem
Message-ID: <X6qIidgbnhYa3S0o@ncase>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1604908834.git.ps@pks.im>
 <9b49e849eaf6786c63016d767d2ad56112d08d51.1604908834.git.ps@pks.im>
 <xmqqpn4mb9bv.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ICly2YHBkf7mGUAp"
Content-Disposition: inline
In-Reply-To: <xmqqpn4mb9bv.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ICly2YHBkf7mGUAp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 09, 2020 at 11:48:20AM -0800, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> > index 4c01e08551..957bef272d 100755
> > --- a/t/t1400-update-ref.sh
> > +++ b/t/t1400-update-ref.sh
> > @@ -14,6 +14,12 @@ n=3D$n_dir/fixes
> >  outside=3Drefs/foo
> >  bare=3Dbare-repo
> > =20
> > +# Some of the tests delete HEAD, which causes us to not treat the curr=
ent
> > +# working directory as a Git repository anymore. To avoid using any po=
tential
> > +# parent repository to be discovered, we need to set up the ceiling di=
rectories.
> > +GIT_CEILING_DIRECTORIES=3D"$PWD/.."
> > +export GIT_CEILING_DIRECTORIES
> > +
>=20
> Interesting.  The current tests do not need to do this because the
> HEAD-less broken state is transitory and is corrected without using
> "git" at all (e.g. echoing a valid value into .git/HEAD), I presume?

Correct.

> > @@ -80,26 +86,26 @@ test_expect_success "fail to delete $m (by HEAD) wi=
th stale ref" '
> >  	test $B =3D $(git show-ref -s --verify $m)
> >  '
> >  test_expect_success "delete $m (by HEAD)" '
> > -	test_when_finished "rm -f .git/$m" &&
> > +	test_when_finished "git update-ref -d $m" &&
> >  	git update-ref -d HEAD $B &&
> > -	test_path_is_missing .git/$m
> > +	test_must_fail git show-ref --verify -q $m
> >  '
>=20
> During the above test, we are on the branch ${m#refs/heads/}, so
> "update-ref -d HEAD" is removing the underlying branch ref, making
> it an unborn branch, without destroying the repository, so this is
> perfectly sensible.
>=20
> This is a tangent, but what makes this test doubly interesting is
> that "git update-ref -d HEAD" would have allowed us to make it a
> non-repository if HEAD were detached, and it seems that we do not
> require "--force" to do so.  We probably should forbid removing HEAD
> that id detached without "--force", which is such a destructive
> operation.

That'd make sense to me, yes. It also took me quite some time to
actually figure out why tests were misbehaving when I converted it.
Until I finally realized: this is not a Git repo anymore, and refs have
now been modified directly in the real git.git repository. Just this
morning I still found some invalid refs created by the test in git.git.

> >  cp -f .git/HEAD .git/HEAD.orig
> >  test_expect_success 'delete symref without dereference' '
> >  	test_when_finished "cp -f .git/HEAD.orig .git/HEAD" &&
> >  	git update-ref --no-deref -d HEAD &&
> > -	test_path_is_missing .git/HEAD
> > +	test_must_fail git show-ref --verify -q HEAD
> >  '
>=20
> This is an example of breaking the repository.  I am not sure if the
> test_must_fail is a good replacement--it would fail even if you say
> "git show-ref --verify -q refs/heads/$branch" where $branch is a
> name of a branch that exists, no?

Right, it's not. We're not detecting HEAD deletion by means of checking
that it doesn't exist anymore, but only detect it because the repo is
not a repo anymore. Which would in fact cause most git commands to fail
now.

> For now, I think this is fine, but we'd probably clean it up so that
> without --force update-ref would not corrupt the repository like
> this.  When used with --force, or before adding such a safety
> measure, how we test if we successfully corrupted the repository is
> an interesting matter.  I'd say
>=20
> 	git update-ref --force --no-deref -d HEAD &&
> 	test_must_fail git show-ref --verify -q HEAD &&
> 	cp -f .git/HEAD.orig .git/HEAD &&
> 	git show-ref --verify -q "$m"
>=20
> to ensure that other than removing HEAD and corrupting the
> repository, it did not cause permanent damage by removing the
> underlying ref, perhaps.
>=20
> We may want to add some NEEDSWORK comment around such tests.

I think the proper way to do the test would be to create a non-mandatory
symref and delete it. That'd also be a nice preparation for the
`--force` parameter already.

> >  test_expect_success 'delete symref without dereference when the referr=
ed ref is packed' '
> > @@ -208,7 +214,7 @@ test_expect_success 'delete symref without derefere=
nce when the referred ref is
> >  	git commit -m foo &&
> >  	git pack-refs --all &&
> >  	git update-ref --no-deref -d HEAD &&
> > -	test_path_is_missing .git/HEAD
> > +	test_must_fail git show-ref --verify -q HEAD
> >  '
>=20
> Does this share the same issue as the above?

Yup, it does.

Patrick

--ICly2YHBkf7mGUAp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+qiM4ACgkQVbJhu7ck
PpRw/w/+Jrp2WPEOdS3gPJsHiiwgCTSU3GqZoT8t1EjvqXwMyrxsqZQYNXzQ4IIP
1DxVonGMMoE0UfnF3hjq2w6wVLrGSNQLEOz+qYypb36Xi922wb9/QawtPNSMrYEN
/oqEAsvo/aXoGn/CgiU2QOG46/1PArtEF7Nm/hJda84M5ZspdNl9LaZRTXRLISJf
IwAdz33Vk/XkIjNGM1u0oyc1uPVjNxnL9MwFHFSWR4xqyK1GcB1m5OkOISyDd6Rr
eoNN4gUA1BImLbcCHqqmxILxeo7WsUhL/Z22tmBRrnT95/YNdZlarxIAqxWKipFf
6G+yWPnpAlopN3+Q1+mlkF2izN2E+EjK6Ve8J6dbcASQHqolU7pnDHsJTgO9wyl8
36cq4g0xhu6mrGEz4OfiIxP4AyprWMtsmZOoEJpF16r3xcMlWBqtXpgJTVlmBTHU
smPOtvn6vMdEcDc2UIOstRev2DSiNhQez/J2xq4BHDzEY309GQbb+OglNNGDDtg7
NRUqq1PgMEYGKSwaCRfYmljMrFif0errrYbic/ZnnD8gAPGOJGQrm4D6M/dnwYXc
ScEcUgBUZI1HqqDOe30ymh4FgUxej0fLQ685BdvwKwh2+qZJHtB5TUmUAv4I9W2D
Ip4Wmpk8nQ2H/+dsjbOiXvMlQdU4xB3r75Zhl2RMAlMPoZijNUo=
=TksO
-----END PGP SIGNATURE-----

--ICly2YHBkf7mGUAp--
