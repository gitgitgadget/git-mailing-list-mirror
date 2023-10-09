Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9413FE95A91
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 10:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346010AbjJIKEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346026AbjJIKEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 06:04:35 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38EEC97
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 03:04:34 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 6A96E3200A2C;
        Mon,  9 Oct 2023 06:04:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 09 Oct 2023 06:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696845872; x=1696932272; bh=8v
        /debs2SevFeDGUY6p+Bg+4dzkWJWx7SGxlBTSO27g=; b=mMOvCVH0qB3bOFKXvG
        +Yj2oh9Sn4jxmpNLqe5vZDAb2TroLk2+Z39uV3pp+WlJXxfpV0r7ok0sfWal7M5/
        IUEw8TlrPEqGdITuuPrgJKcla37mB4+BJ5zIMJTpz/MmOKj871PZb1R2WAf/anSQ
        B2jafmsiDAIZC5L6UbJ3XgYgIlJhOfh33e0Q53+BYP1QWWJAL7fo2xjixaWdWRNr
        bqMUDWs9I9JGjkndqp5zF8DQwt3DQ7G3WsHLsKyyXzIpR5jHZ+ifjup4JkGir0HD
        rZPf1E5/2gwg1ohjOVMG7tE48+whGt+BRfdhAih+MtmtPVMsSivjgQIcdFFEpETl
        Vhsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696845872; x=1696932272; bh=8v/debs2SevFe
        DGUY6p+Bg+4dzkWJWx7SGxlBTSO27g=; b=gTHPmpZFW2AFNi0Mnz0gQ2YhDPoUD
        5d3jxqNtUJ7UUUELeNr7OC2u6wUtvwIfF6Bm12LXay8sjkfi+mfSn7jdq1iYo+NB
        V2mn36ES7jQBvLVvG8zlJ8i8KR/ev+5cVVzot77CFSlH2vp/c8E9+TY29ZL29Bdu
        CWNFOIY6sEx0r5+FyCvuPOQV0vLFkEFrkxLXHh1KpZTVAxCjvSGETVA4XS71xhCm
        uLQgAi+LSIkIg3hxdMDF8Jdqr8VqOvVwIFh6vLMc7WrO1Ae1x/W/mpOD3z6HNRA8
        g7gX6304lWmDjTElWP96g1toJjMeKyxUynuaBlk2N+3FfCPUw2HJ4/k2Q==
X-ME-Sender: <xms:MNAjZYEYJBcPJ9a_nqy76KtVYVjQV2HUbtkYusv0ISA_GHBz-4FnXA>
    <xme:MNAjZRVxRAXHrasgKsJUmuZU2Uuxjq9WKiD4CkhuS81pPtlJfyHpwMT47adGrQeQY
    fbi1fktwRygIqLHXg>
X-ME-Received: <xmr:MNAjZSJceSjjt3QnF4MIa6enEtQI14tZgobivugsHiJUI4SNBI_AZhvUwpubsd2JavvPIvr-mWq8005a0f5J_xFkc68NzHnANDc4oxmwx6cxGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheefgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:MNAjZaEyrvQ6WLNqmyHXU6bAxTiNfra0dJAM5y-mHfoJ9yIrVJ75vw>
    <xmx:MNAjZeX4VzYiqH6D2NEUFLHJDXXQAUWnsXGjR6WjwlL6y-BY7Sh52g>
    <xmx:MNAjZdNTFbfLiE-W8JPQrwzcIS0DdkwMekWyozoYPbRu0o4g_plkEQ>
    <xmx:MNAjZbhd0ZUa5wt_DHsVji9xb2bGL5_AlMp6LYmC7w0258DvvVMNMg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Oct 2023 06:04:31 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id dffb80cd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Oct 2023 10:04:31 +0000 (UTC)
Date:   Mon, 9 Oct 2023 12:04:30 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 1/4] ref-cache.c: fix prefix matching in ref iteration
Message-ID: <ZSPQLjJwq-7SjsDT@tanuki>
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
 <59276a5b3fd1fd3b25db73e096cf0e834af2d4f9.1696615769.git.gitgitgadget@gmail.com>
 <xmqqfs2n8lnn.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rJLoLs7z6vnIhoZn"
Content-Disposition: inline
In-Reply-To: <xmqqfs2n8lnn.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rJLoLs7z6vnIhoZn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 06, 2023 at 02:51:24PM -0700, Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > From: Victoria Dye <vdye@github.com>
> >
> > Update 'cache_ref_iterator_advance' to skip over refs that are not matc=
hed
> > by the given prefix.
> >
> > Currently, a ref entry is considered "matched" if the entry name is ful=
ly
> > contained within the prefix:
> >
> > * prefix: "refs/heads/v1"
> > * entry: "refs/heads/v1.0"
> >
> > OR if the prefix is fully contained in the entry name:
> >
> > * prefix: "refs/heads/v1.0"
> > * entry: "refs/heads/v1"
> >
> > The first case is always correct, but the second is only correct if the=
 ref
> > cache entry is a directory, for example:
> >
> > * prefix: "refs/heads/example"
> > * entry: "refs/heads/"
> >
> > Modify the logic in 'cache_ref_iterator_advance' to reflect these
> > expectations:
> >
> > 1. If 'overlaps_prefix' returns 'PREFIX_EXCLUDES_DIR', then the prefix =
and
> >    ref cache entry do not overlap at all. Skip this entry.
> > 2. If 'overlaps_prefix' returns 'PREFIX_WITHIN_DIR', then the prefix ma=
tches
> >    inside this entry if it is a directory. Skip if the entry is not a
> >    directory, otherwise iterate over it.
> > 3. Otherwise, 'overlaps_prefix' returned 'PREFIX_CONTAINS_DIR', indicat=
ing
> >    that the cache entry (directory or not) is fully contained by or equ=
al to
> >    the prefix. Iterate over this entry.
> >
> > Note that condition 2 relies on the names of directory entries having t=
he
> > appropriate trailing slash. The existing function documentation of
> > 'create_dir_entry' explicitly calls out the trailing slash requirement,=
 so
> > this is a safe assumption to make.
>=20
> Thanks for explaining it very well and clearly. =20
>=20
> Allowing prefix=3D"refs/heads/v1.0" to yield entry=3D"refs/heads/v1"
> (case #2 above that this patch fixes the behaviour for) would cause
> ref_iterator_advance() to return a ref outside the hierarhcy,
> wouldn't it?  So it appears to me that either one of the two would
> be true:
>=20
>  * the code is structured in such a way that such a condition does
>    not actually happen (in which case this patch would be a no-op),
>    or
>=20
>  * there is a bug in the current code that is fixed by this patch,
>    whose externally observable behaviour can be verified with a
>    test.
>=20
> It is not quite clear to me which is the case here.  The code with
> the patch looks more logical than the original, but I am not sure
> how to demonstrate the existing breakage (if any).

Agreed, I also had a bit of a hard time to figure out whether this is an
actual bug fix, a performance improvement or merely a refactoring.

Patrick

> > Signed-off-by: Victoria Dye <vdye@github.com>
> > ---
> >  refs/ref-cache.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> > index 2294c4564fb..6e3b725245c 100644
> > --- a/refs/ref-cache.c
> > +++ b/refs/ref-cache.c
> > @@ -412,7 +412,8 @@ static int cache_ref_iterator_advance(struct ref_it=
erator *ref_iterator)
> > =20
> >  		if (level->prefix_state =3D=3D PREFIX_WITHIN_DIR) {
> >  			entry_prefix_state =3D overlaps_prefix(entry->name, iter->prefix);
> > -			if (entry_prefix_state =3D=3D PREFIX_EXCLUDES_DIR)
> > +			if (entry_prefix_state =3D=3D PREFIX_EXCLUDES_DIR ||
> > +			    (entry_prefix_state =3D=3D PREFIX_WITHIN_DIR && !(entry->flag &=
 REF_DIR)))
> >  				continue;
> >  		} else {
> >  			entry_prefix_state =3D level->prefix_state;

--rJLoLs7z6vnIhoZn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUj0C0ACgkQVbJhu7ck
PpRvxA//b4yupygGCmS++GCnN5BJsQ0OsX98fLukTgvDF3hMMIOoxy8OAHpk2III
U3Qxjq9k7UdDR5vSatGWo26Bk7n3PeZTNzgEtMCecTm70PKlvRxj9xrSMorGg4ii
393/x8rI4/wFTv5mvPWiTgp/+QzsvlVmmzH/6Rf6jGHSqBxag0CMF4PDgHyqUQMi
jmEbmtDvCutUzdJdK50UAz7A2fl2yOffRtYiDE4pb7eZAZkKdosLsmADudg0LV+l
61FJL80Dhxan+c4L8WZthfYRWoKL8ivXk7CiOSL9eGVnbf+rOZLLvQ6R4kMgfQr4
CaMekVnGgQNXcYm9SONslfhCZXKJ/6ZbnWua1yKLObxNdgnxpQ+tMMqzx04bJASK
4QNkqnWUjTOufUVGMYJ8CFwx6C1FZFlL0u/5WbvjNctiOXL71+y0JE/wed5ckguz
sJzABYZUWXNNazffMEgk1L0Fo/AM9cqgtS1zS+tsKNo0SxaWd+N6qNrxXcT0lLMx
bvmannO5b4Wlu1PSZckz4vIYvQbZ+4BqcWQdTa2lXgBv83vzMILwDbR+7PvoH5hY
XS46AAWi1wKjJWgkImZpky84dBb4CjGieZ51ZAG+RJk9Uz6GgVpTxOtSqveDgRZT
2JT1YJduytpS3gBDnKbjAhkijI1xzzd2FFH80w7GozIjTNXgFIs=
=styO
-----END PGP SIGNATURE-----

--rJLoLs7z6vnIhoZn--
