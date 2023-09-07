Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9131EC873F
	for <git@archiver.kernel.org>; Thu,  7 Sep 2023 15:51:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235576AbjIGPrb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Sep 2023 11:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344073AbjIGPcW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Sep 2023 11:32:22 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD4A1BF6
        for <git@vger.kernel.org>; Thu,  7 Sep 2023 08:31:55 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 939AE5C0106;
        Thu,  7 Sep 2023 04:20:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 07 Sep 2023 04:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694074812; x=1694161212; bh=Ay
        Lq3e+hB5QFDlAIgb3069HDitumggwZJtNb/qGHLYY=; b=p4SO6+V8z5nYeYOsXz
        O3CdxFYAJx0Ewu7qxuwy5gWUqP3T4tjYIUMRCAbawOeUKTOQHVtL+HQgrDDOapmD
        2M8M/c8xP4dOEe5Ltew8SgPy5HmPh9aG+9hGUcUfP1GmqH/o9hk61538EsDOjwDs
        Li/0ytwOBCxDbqx8aL3JfJx9LLIJdC+luxHxpc4hwFaU1bu6M0rH8fu1vY/dC5xG
        UHOkZMiapkcu2Tx2XJqOEbnxHPjJHVKPqB+3sgQ/vg7i1CrOrff5UOPzAdYaJ3J4
        iWSLU2AhmWykNLXaSnGhJGOsokENs8o/TcFOrUYUGQyV8dcaZ915To/etsvuNyAX
        oHQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694074812; x=1694161212; bh=AyLq3e+hB5QFD
        lAIgb3069HDitumggwZJtNb/qGHLYY=; b=iKBYo3ZDox/SF2RePox8FSl1n7+Yn
        ZzI/qvehnhAoBtK4Gws3BwcgktCINAnyuGlOc9VcUjGluwheKn8KuM+Zvx7xZTuG
        gQXXu+UaYyF8lQJo97cas0rhvUC55wAcqj1M4NsL818OSHVcg8JVLUWC0xcOJcJc
        jtdp3UwEAu+GCt6p5Dk3NpSWUIjnarJRjDYkgrXUGouc0oQMVCM+WYKkMgxX7XrX
        4llFmcxJAsQxs4F5bO0t/iH5nStRXI0ek4VdNPT2Rsjy5s6CfTFBKMX+hNjHqjAw
        ioq0SpyzRlss236fEuTNNtL/Gv+n0YdOD0H3JIo8hB4ZM/cQ5lA2sL1RQ==
X-ME-Sender: <xms:vIf5ZFEvJXaBvm25nVf3ZorCmNxtBNldlz6eicdyoF6I9kzTyT4tOg>
    <xme:vIf5ZKUH-toq9dNBp3cjnZdeZh7vPX6SducPfWcPdVdg76RPk699jmTDa-j8vHivx
    AtU87D4L74F-zClqQ>
X-ME-Received: <xmr:vIf5ZHLXz_hD3pKdtETrj-NRmDkyfnbE_aH0alf9vun8TgIbfnqlj_x_fB5YLUCYRci9dbhitLGKx6pbN3RIrcDPX_2X-cWzwU_y8jUsm3_cE0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehhedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:vIf5ZLGTCmrp4JDkcwNOUIDeRWFwQgPmX3GXnWCIQUmKOdovmx10Xg>
    <xmx:vIf5ZLWsoYjz9mksWdiG-K6E7ac1sBgYwDmQT2ODeiy4el6GjVI_qQ>
    <xmx:vIf5ZGPDwxv42u754pF_hHzGrE1fwD58TdUDTs0h1Y_ez6H7Wm9YuQ>
    <xmx:vIf5ZIi7DyUJakZ4YW10u4rZbQSgtZkuvo_7FCKfLK4oOgAW8X568Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Sep 2023 04:20:11 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 15da464f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 Sep 2023 08:19:51 +0000 (UTC)
Date:   Thu, 7 Sep 2023 10:19:50 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 7/8] builtin/repack.c: drop `DELETE_PACK` macro
Message-ID: <ZPmHpqHNzXF0Jbu6@tanuki>
References: <cover.1693946195.git.me@ttaylorr.com>
 <559b487e2ab056c79367a673188764e4cdce3c96.1693946195.git.me@ttaylorr.com>
 <xmqqh6o7nsf2.fsf@gitster.g>
 <ZPi1c98o2fKB/U+e@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wWXH6Qb8/MV2rubV"
Content-Disposition: inline
In-Reply-To: <ZPi1c98o2fKB/U+e@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--wWXH6Qb8/MV2rubV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 06, 2023 at 01:22:59PM -0400, Taylor Blau wrote:
> On Wed, Sep 06, 2023 at 10:05:37AM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > > ---
> > >  builtin/repack.c | 18 ++++++++++--------
> > >  1 file changed, 10 insertions(+), 8 deletions(-)
> >
> > The reason being...?
>=20
> Wow, I have no idea how this got sent out without a commit message! At
> least it was signed off ;-).
>=20
> Here's a replacement that I cooked up, with your Helped-by. Let me know
> if you want to replace this patch manually, or if you'd prefer a reroll
> of the series. Either is fine with me! :-)

Personally I think that the original version is still more readable. If
you simply see `if (item->util)` you don't really have any indicator
what this actually means, whereas previously the more verbose check for
`if ((uintptr)item->util & DELETE_PACK)` gives the reader a nice hint
what this may be about.

If the intent is to make this check a bit prettier, how about we instead
introduce a helper function like the following:

```
static inline int pack_marked_for_deletion(const struct string_list_item *i=
tem)
{
        return (uintptr) item->util & DELETE_PACK;
}
```

Other than that the rest of this series looks good to me, thanks.

Patrick

> --- 8< ---
> Subject: [PATCH] builtin/repack.c: treat string_list_item util as booleans
>=20
> The `->util` field corresponding to each string_list_item used to track
> the existence of some pack at the beginning of a repack operation was
> originally intended to be used as a bitfield.
>=20
> This bitfield tracked:
>=20
>   - (1 << 0): whether or not the pack should be deleted
>   - (1 << 1): whether or not the pack is cruft
>=20
> The previous commit removed the use of the second bit, meaning that we
> can treat this field as a boolean instead of a bitset.
>=20
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  builtin/repack.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
>=20
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 478fab96c9..575e69b020 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -26,7 +26,7 @@
>  #define LOOSEN_UNREACHABLE 2
>  #define PACK_CRUFT 4
>=20
> -#define DELETE_PACK 1
> +#define DELETE_PACK ((void*)(uintptr_t)1)
>=20
>  static int pack_everything;
>  static int delta_base_offset =3D 1;
> @@ -96,6 +96,10 @@ static int repack_config(const char *var, const char *=
value,
>=20
>  struct existing_packs {
>  	struct string_list kept_packs;
> +	/*
> +	 * for both non_kept_packs, and cruft_packs, a non-NULL
> +	 * 'util' field indicates the pack should be deleted.
> +	 */
>  	struct string_list non_kept_packs;
>  	struct string_list cruft_packs;
>  };
> @@ -130,7 +134,7 @@ static void mark_packs_for_deletion_1(struct string_l=
ist *names,
>  		 * (if `-d` was given).
>  		 */
>  		if (!string_list_has_string(names, sha1))
> -			item->util =3D (void*)(uintptr_t)((size_t)item->util | DELETE_PACK);
> +			item->util =3D DELETE_PACK;
>  	}
>  }
>=20
> @@ -158,7 +162,7 @@ static void remove_redundant_packs_1(struct string_li=
st *packs)
>  {
>  	struct string_list_item *item;
>  	for_each_string_list_item(item, packs) {
> -		if (!((uintptr_t)item->util & DELETE_PACK))
> +		if (!item->util)
>  			continue;
>  		remove_redundant_pack(packdir, item->string);
>  	}
> @@ -695,20 +699,20 @@ static void midx_included_packs(struct string_list =
*include,
>=20
>  		for_each_string_list_item(item, &existing->cruft_packs) {
>  			/*
> -			 * no need to check DELETE_PACK, since we're not
> -			 * doing an ALL_INTO_ONE repack
> +			 * no need to check for deleted packs, since we're
> +			 * not doing an ALL_INTO_ONE repack
>  			 */
>  			string_list_insert(include, xstrfmt("%s.idx", item->string));
>  		}
>  	} else {
>  		for_each_string_list_item(item, &existing->non_kept_packs) {
> -			if ((uintptr_t)item->util & DELETE_PACK)
> +			if (item->util)
>  				continue;
>  			string_list_insert(include, xstrfmt("%s.idx", item->string));
>  		}
>=20
>  		for_each_string_list_item(item, &existing->cruft_packs) {
> -			if ((uintptr_t)item->util & DELETE_PACK)
> +			if (item->util)
>  				continue;
>  			string_list_insert(include, xstrfmt("%s.idx", item->string));
>  		}
> --
> 2.38.0.16.g393fd4c6db
>=20
> --- >8 ---
>=20
> Thanks,
> Taylor

--wWXH6Qb8/MV2rubV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmT5h6EACgkQVbJhu7ck
PpREkg/9Gf7Z3YF8ldQB5PpOkgtB+TY2KS+NWO/l57esfSXYmtu97ET//f4ULiTz
hVxC41U6mWUyxU+bcvW/gKheRDxfic4zo6zDk3DYuj0oCQvD/jpSBr825tSLhLxE
fSs/J1Z9xIauqYkCRShGREt7EnO6JiLg91+2oF4M3/qeOSsBNmekRvyroWC4kFhI
WbmcTZejWRCqUCT5FyMy7ZRpNP0L+IJAzQGkWlSix5XNW7gr6IOF1oR81rpMHTPk
2o/lG0Ss6G50ojrX13PX40kXSD/uUG7hAI3MafGmkSfN4TBBQfZD1t0L1fQoI2F9
iS8PArYrWLQ2VmGqStqITaVYDi6TXNTgZHLSqxuC8uTx5BCmnMIwFinCyx2OdrAa
ESsf2ACSF+3A91WUeLHotNaf5vRURwFd+5Tj1jD75WO1Y9cvxWWSAo/aoILhH+Sk
immj1p121LYbP4q5LG2UTE0pzZwSxCo0X14pKi6T8RtayIZC+uFqU1UZJXiaW1Wo
pYTOby72uZZgLVahPCycslRqPP8ypY6p55QCJ4O4qtaV4Feju2cbocS1+htBsFP1
2bbOtujWi8doBQJ6v4DXZd32Hq6NEh8OIBzSNeV+QeWSIm4uCDUu9pxfYT6hKW6f
Bc53cYapJa87NJLaJnms28Cd+2DpbL9WOXbI60XuRxfbJ5BUqws=
=+GGo
-----END PGP SIGNATURE-----

--wWXH6Qb8/MV2rubV--
