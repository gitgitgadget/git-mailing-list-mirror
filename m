Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D41C433F5
	for <git@archiver.kernel.org>; Mon, 17 Jan 2022 07:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237486AbiAQHSf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jan 2022 02:18:35 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59127 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237344AbiAQHSe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 17 Jan 2022 02:18:34 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 182105C010E;
        Mon, 17 Jan 2022 02:18:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 17 Jan 2022 02:18:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=4asofVG+A6Gi8TIGv3eQOWHAmnO
        kYJIM8iEZ5XhdXOY=; b=e39hLHy0HD+P1OOfQPuBawco5cYrVqCT3NTd80SF96V
        5V5fyfLh1aXxKhIsr938qoWhm895MYp95wU67hO7zVSeArWHfeT8uHjTjVaV1nrd
        pi0hrxzcAg0BmQVOVUJRD/B93v2t7gUhcC5p3R29XT/RVPAwZg9Z6nA6DPMgJ6cO
        rlevV3UiNH6tum9Lr5V3lrSYwPPZ8BhAxOO0lTA72kdUmTbMMltyLs1xRKHqALae
        /OMMh5FksfZSbuPO3JDw60sOgfznWOrfUQa/gw4FDxLpM6+o81RiyUMXmF7LodmY
        iwnGEs0PGk5ggav0+bEFmdrn5aZJXvJsme1odrfcq/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=4asofV
        G+A6Gi8TIGv3eQOWHAmnOkYJIM8iEZ5XhdXOY=; b=h7xJZlmi66RbNbp9+r99CO
        8SLevTP1zakrq1EZwZb/uNKoWoZ0SaZ5CcrcEiJ7buxV+TPzyrPvXOBZ+FEmBaEH
        FSZf3YxX/ujm2JKYsIyQjIuK0ozJvNt4aW9leU2JA9eqPh5OR/w4HUIEVP6f/7y3
        vYV7wdpIoPv+WSizbTE6qWqia4PrxmKQmknqtVoOUAnx5egYjkKrorRMM6WAs0cy
        J4xPU0TCBUhoNZTqq628dtTS6blnOKzcopMVoMoQ2NLh+lPlCyrR0JC68q2Lc+iL
        8vtZLYhwyvgLpeGD8EK5esiQmexF/0rr7ikGns0UnZXUoHJtwLbrv3rYRAKXJa7Q
        ==
X-ME-Sender: <xms:SRjlYRyvLrHErbt5cVtzsK1uI8nb5ofHOj7K5jMTjxCvIN_p8nzk_g>
    <xme:SRjlYRTT-V97fcSuiGoeqLLgIyTatxA7MpxmPu7p7nWVaYW_z3JIC-JXfUrLywmVO
    EBgYgh-BYtuPm9pSA>
X-ME-Received: <xmr:SRjlYbUv0zatrVpx-XaGdQoILwgsBjLa445D-1G95d-WInAIvvGa3jQ0zhW1If75P_RU4k-trYH6t7KLEnJrpl6MutXC8LbclDHtuuf-26iSFSTQ70OY0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtudenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepudeutddufeeggfejlefgheejhffgudetke
    ekteeitdelheeitdejueegtdejiedvnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:SRjlYThah0qCONVWlNqq30ZKiuHisclruzO9kG3Io9jv_nEaBJtAMQ>
    <xmx:SRjlYTB-k05Uw_UTFbQlF89fzIYoBeNhY1cZRNUxlXXsBkwAOAaguw>
    <xmx:SRjlYcJ2Um3aFPjXP_6qXuwI_2g0DMLQxviwJuaf6XA_RRg5bq62Aw>
    <xmx:ShjlYY506plUMn9Xjh6JsH2iTFC2-RjHOCN3k7TuXI18mx5CO6NBTw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jan 2022 02:18:33 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6f019897 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 17 Jan 2022 07:18:32 +0000 (UTC)
Date:   Mon, 17 Jan 2022 08:18:31 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2022, #03; Thu, 13)
Message-ID: <YeUYR8TwJf+31wcl@ncase>
References: <xmqq35lrf8g4.fsf@gitster.g>
 <xmqqk0f3dk5o.fsf@gitster.g>
 <220114.86fspqrxbw.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qM8k+wnVS2RhJg9E"
Content-Disposition: inline
In-Reply-To: <220114.86fspqrxbw.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qM8k+wnVS2RhJg9E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 14, 2022 at 07:12:15PM +0100, =C6var Arnfj=F6r=F0 Bjarmason wro=
te:
>=20
> On Thu, Jan 13 2022, Junio C Hamano wrote:
>=20
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> There are a few "oops, what we merged recently is broken" topics
> >> that still are not in 'master', but otherwise what we have should
> >> be pretty much what we'll have in the final one.
> >>
> >>  - I am reasonably happy with ab/refs-errno-cleanup (just one patch)
> >>    that fixes the incorrect state of the code left by the earlier
> >>    parts of the topic that have already been merged during this
> >>    cycle.
> >>
> >>  - I am also OK with ab/reftable-build-fixes (two patches), one for
> >>    general type correctness fix, the other for helping older sub-C99
> >>    compilers.
> >>
> >> If there are fixes for regressions that we introduced during this
> >> cycle other than these two topics, I certainly am missing them, so
> >> please holler loudly and quickly, hopefully in time for me to tag
> >> the -rc1 tomorrow.
> >
> > Oh, by the way, the tip of 'seen' has consistently failing the
> > leak-check test.  I didn't have chance, time or energy to see if
> > they are failing merely because an existing test script that used to
> > be leak-clean gained a use of command that has been known to be
> > leak-unclean without introducing any new leaks, or our recent change
> > did introduce new leaks to commands that have been leak-clean.
> > Somebody with too much time on their hand should go in and check to
> > help, before CI testing on 'seen' becomes useful again.
>=20
> It's a regression in
> ps/avoid-unnecessary-hook-invocation-with-packed-refs, Patrick could you
> look into it? On your current "seen" doing a:
>=20
>     git revert -m 1 48b388cbf31
>=20
> Will make those 3x failing tests pass:
> https://github.com/git/git/runs/4811683950?check_suite_focus=3Dtrue
>=20
> (That commit being: 48b388cbf31 (Merge branch
> 'ps/avoid-unnecessary-hook-invocation-with-packed-refs' into seen,
> 2022-01-13))
>=20
> I didn't have much time to look now, but this mostly untested fix-up
> fixes up the topic under SANITIZE=3Dleak (but may break something else). I
> ran the broken tests with SANITIZE=3Dleak, and the normal tests without
> SANITIZE=3Dleak, but didn't have time for further testing:
>=20
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> index ff96ee482a0..b8012f97009 100644
> --- a/refs/packed-backend.c
> +++ b/refs/packed-backend.c
> @@ -1577,6 +1577,7 @@ int packed_refs_delete_refs(struct ref_store *ref_s=
tore,
>                         error(_("could not delete references: %s"), err.b=
uf);
>         }
> =20
> +       ref_transaction_free(transaction);
>         strbuf_release(&err);
>         return ret;
>  }
>=20
> I.e. the moving around of the ref_transaction_free() is at fault
> somehow, probably...

Thanks for digging! The bug is actually in the files backend, where
`files_delete_refs()` has two different exit paths, but I added the free
of the packed-refs backend only to one of both. So the following patch
fixes it:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 9a20cb8fa8..844918cbd8 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1280,6 +1280,7 @@ static int files_delete_refs(struct ref_store *ref_st=
ore, const char *msg,
 			result |=3D error(_("could not remove reference %s"), refname);
 	}
=20
+	ref_transaction_free(transaction);
 	strbuf_release(&err);
 	return result;
=20

I'll send a reroll of my series.

Patrick

--qM8k+wnVS2RhJg9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmHlGEYACgkQVbJhu7ck
PpTg9w/9FMQfRwAOW7f0y1WQA8uK5Z4MLAaGPWec5xUaVHqGmj+d0PwTV4e5nZU2
UrATiKB4WP5zci7ZR2N/9hsAFBtes2clIg083JZdAsQaiOvwco+IPRLtmyIdbIyI
GvRZJiHGVZyRWUSGL1/TWBqOM+NqIJNn1Wj3NF+Bxe1PX+Tq63x52cOFwZyEU+vk
ZGKv0TTa0G3HqH/+pXPDkASR9F0OX2nvhy9pP5xZOeyeKC141/+iuUvqULromV93
wGy0QY61uXDWVYOlfMQKtQciAXfiTRsVfI4ZntDkFZhITHtOtmb4eXTp7Bffo/Nj
om33bqY5fXDdQm0bWps7NmpXyZtNATxNa726hjGA2jY0SEXtS53ungU2Pgg4S8Vp
6LfQv8FPeROeIiiCFWd1pQp64gzKGrKV+zZIisKwreQZGZgVUZw1bjSi9sEc61Yh
Rgk1/ZRvFzo2mwlWC+uAnor9NdStstJg3Esr5RoWCNQQnBvm4ZaKGI2H5zr5Y6FD
RWt/oe+aZf85YT6iqNQlyVjaH1/G26zRq+EXn+ie/A7UseQcr+/gYxgCFk8P1N10
i1hLcqoZLsg/5Cx4FxEQyAxTkF4s2hlAMGV5j9/LQm6vXyZSy9apQwWO67QW9Fxs
KPxuM8S7/4RySKKyUzka7bhWDTZcs++rTY0U7DcgsR4co3/U+kY=
=KUQU
-----END PGP SIGNATURE-----

--qM8k+wnVS2RhJg9E--
