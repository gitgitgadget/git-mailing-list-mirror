Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1165DEE57FA
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 11:21:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236695AbjIHLV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 07:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjIHLV6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 07:21:58 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B643611B
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 04:21:53 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 83F4D5C013A;
        Fri,  8 Sep 2023 07:21:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 08 Sep 2023 07:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1694172110; x=1694258510; bh=GQ
        F0WBXFkSpkAvgyWxu0ALbC/oUUu8MGZ7uHDgF8J+Y=; b=TCw0hCd4WaVv7xoO1s
        r3EJSCdl+y0NLLCuiFHYG4nua3l+AKwNopgG7Mt/i+PjVrtLzKmwD9gJnT+bU7vX
        Jxa51O7dF9oByuUAf/a1R/vSVr6hjgAkJZRiZJoLlVuVhxppDLvoeVoJJtqNRSnE
        8vse/a5uDGTDs4RLekOPTSTwVFQBl0sw0vuUjkll6ZVncOM61SlR5nB1b0b837Ul
        sIW/l/1qkeyIkLwEyQ7QsAUUX4n5Jdi4pSN7ZoEU7gRU9MRUw0PKACs/ktKzo0qj
        xpofDvEPldbmjEYywTZGn9dBl/FodGGQ52YsufpzcyTwTu9qyslLYXkEN7dnZX7H
        aSLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694172110; x=1694258510; bh=GQF0WBXFkSpkA
        vgyWxu0ALbC/oUUu8MGZ7uHDgF8J+Y=; b=ewwRgoVJ/FdH/JrUmZNWAKaeozOLm
        X+WFxU0D4gartP9IxT5suo/1bbHmDbD0wKZ8ulWkD0Ps0LIUN2h7mrFL+IauIeHp
        VIGLXNzmfN9sTM39SM8ySX35AeXaqn5tl9b32wBRqFUfcb7ePnx/pPoUAX10yOcR
        Czut86eOzWv1vxkjLkvBI+sQItiTKOR6DwMxfX8nd5ent15uvbO0nVjOtckS3AME
        jexMRzdKy08k1jhYYCABJcvdyixl0cTLyr+PSKZOmwg/NHQ8Lqt76t17WmjIpr+K
        obDO5hT+5yTwph0p//uD0EjUJOiDDOGeKyQRp0prde2yjilppHqgVUbUA==
X-ME-Sender: <xms:zgP7ZOcm4SJsdtJFlQ0m74V0WfDkO21-C9ekOZi44IPIi-n6VqJYCQ>
    <xme:zgP7ZIM2u5n7Nz9MhvwZwole7WKSpCzqKYPHVKnNAfsoFs2l_H9TQpDiCs6k8UVop
    vLGKzMvxD2YD7jJtA>
X-ME-Received: <xmr:zgP7ZPg_1Hk2n-ra3F6-UfRTsCqqq9tA-HCS3Ggur1IO-F4I4PpQe_uVKAK58meEoHgezCj7XQzg7zib5945HextYUDrDP9CH81rNCxCagbW3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehjedgfeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:zgP7ZL94W94hZBrT4lGFdyw4d57GzywCaI1j23h1R4tIf13GqAKAAA>
    <xmx:zgP7ZKvHxQnZqNw8fukPSVd1Jy5QYu9pgr5JwxWkjZzpB1bc_YMzuw>
    <xmx:zgP7ZCFCJLefkRRYxGt4XG_rtkltxPHA23dThAYVVdIkubA43OlQRQ>
    <xmx:zgP7ZOJqLBR1A2c058ZsxTRXIxFtjYFhSBoddHucM1vvb57L7Sk1Cg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 Sep 2023 07:21:48 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id ef3af088 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 8 Sep 2023 11:21:45 +0000 (UTC)
Date:   Fri, 8 Sep 2023 13:21:44 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] builtin/repack.c: implement support for
 `--cruft-max-size`
Message-ID: <ZPsDyKOa76Mxb9u-@tanuki>
References: <cover.1694123506.git.me@ttaylorr.com>
 <7e4e42e1aacf2111f04a933c0725a8c81769f8d6.1694123506.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uuEBqkH9oJRAWPT3"
Content-Disposition: inline
In-Reply-To: <7e4e42e1aacf2111f04a933c0725a8c81769f8d6.1694123506.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--uuEBqkH9oJRAWPT3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 07, 2023 at 05:52:04PM -0400, Taylor Blau wrote:
[snip]
> @@ -125,17 +133,39 @@ static void mark_packs_for_deletion_1(struct string=
_list *names,
>  		if (len < hexsz)
>  			continue;
>  		sha1 =3D item->string + len - hexsz;
> -		/*
> -		 * Mark this pack for deletion, which ensures that this
> -		 * pack won't be included in a MIDX (if `--write-midx`
> -		 * was given) and that we will actually delete this pack
> -		 * (if `-d` was given).
> -		 */
> -		if (!string_list_has_string(names, sha1))
> -			item->util =3D (void*)1;
> +
> +		if (pack_is_retained(item)) {
> +			item->util =3D NULL;
> +		} else if (!string_list_has_string(names, sha1)) {
> +			/*
> +			 * Mark this pack for deletion, which ensures
> +			 * that this pack won't be included in a MIDX
> +			 * (if `--write-midx` was given) and that we
> +			 * will actually delete this pack (if `-d` was
> +			 * given).
> +			 */
> +			item->util =3D DELETE_PACK;
> +		}

I find the behaviour of this function a tad surprising as it doesn't
only mark a pack for deletion, but it also marks a pack as not being
retained anymore. Shouldn't we rather:

    if (pack_is_retained(item)) {
        // Theoretically speaking we shouldn't even do this bit here as
        // we _un_mark the pack for deletion. But at least we shouldn't
        // be removing the `RETAIN_PACK` bit, I'd think.
        item->util &=3D ~DELETE_PACK;=20
    } else if (!string_list_has_string(names, sha1)) {
        // And here we shouldn't discard the `RETAIN_PACK` bit either.
        item->util |=3D DELETE_PACK;
    }

>  	}
>  }
> =20
> +static void retain_cruft_pack(struct existing_packs *existing,
> +			      struct packed_git *cruft)
> +{
> +	struct strbuf buf =3D STRBUF_INIT;
> +	struct string_list_item *item;
> +
> +	strbuf_addstr(&buf, pack_basename(cruft));
> +	strbuf_strip_suffix(&buf, ".pack");
> +
> +	item =3D string_list_lookup(&existing->cruft_packs, buf.buf);
> +	if (!item)
> +		BUG("could not find cruft pack '%s'", pack_basename(cruft));
> +
> +	item->util =3D (void*)RETAIN_PACK;
> +	strbuf_release(&buf);
> +}
> +

Similarly, should we handle potentially pre-existing bits gracefully and
`item->util |=3D RETAIN_PACK`?

>  static void mark_packs_for_deletion(struct existing_packs *existing,
>  				    struct string_list *names)
> =20
> @@ -217,6 +247,8 @@ static void collect_pack_filenames(struct existing_pa=
cks *existing,
>  	}
> =20
>  	string_list_sort(&existing->kept_packs);
> +	string_list_sort(&existing->non_kept_packs);
> +	string_list_sort(&existing->cruft_packs);
>  	strbuf_release(&buf);
>  }
> =20
> @@ -799,6 +831,72 @@ static void remove_redundant_bitmaps(struct string_l=
ist *include,
>  	strbuf_release(&path);
>  }
> =20
> +static int existing_cruft_pack_cmp(const void *va, const void *vb)
> +{
> +	struct packed_git *a =3D *(struct packed_git **)va;
> +	struct packed_git *b =3D *(struct packed_git **)vb;
> +
> +	if (a->pack_size < b->pack_size)
> +		return -1;
> +	if (a->pack_size > b->pack_size)
> +		return 1;
> +	return 0;
> +}
> +
> +static void collapse_small_cruft_packs(FILE *in, unsigned long max_size,

We might want to use `size_t` to denote file sizes instead of `unsigned
long`.

> +				       struct existing_packs *existing)
> +{
> +	struct packed_git **existing_cruft, *p;
> +	struct strbuf buf =3D STRBUF_INIT;
> +	unsigned long total_size =3D 0;

Here, as well.

> +	size_t existing_cruft_nr =3D 0;
> +	size_t i;
> +
> +	ALLOC_ARRAY(existing_cruft, existing->cruft_packs.nr);
> +
> +	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
> +		if (!(p->is_cruft && p->pack_local))
> +			continue;
> +
> +		strbuf_reset(&buf);
> +		strbuf_addstr(&buf, pack_basename(p));
> +		strbuf_strip_suffix(&buf, ".pack");
> +
> +		if (!string_list_has_string(&existing->cruft_packs, buf.buf))
> +			continue;
> +
> +		if (existing_cruft_nr >=3D existing->cruft_packs.nr)
> +			BUG("too many cruft packs (found %"PRIuMAX", but knew "
> +			    "of %"PRIuMAX")",
> +			    (uintmax_t)existing_cruft_nr + 1,
> +			    (uintmax_t)existing->cruft_packs.nr);
> +		existing_cruft[existing_cruft_nr++] =3D p;
> +	}
> +
> +	QSORT(existing_cruft, existing_cruft_nr, existing_cruft_pack_cmp);
> +
> +	for (i =3D 0; i < existing_cruft_nr; i++) {
> +		off_t proposed;

This should also be `size_t` given that `st_add` returns `size_t` and
not `off_t`.

> +		p =3D existing_cruft[i];
> +		proposed =3D st_add(total_size, p->pack_size);
> +
> +		if (proposed <=3D max_size) {
> +			total_size =3D proposed;
> +			fprintf(in, "-%s\n", pack_basename(p));
> +		} else {
> +			retain_cruft_pack(existing, p);
> +			fprintf(in, "%s\n", pack_basename(p));
> +		}

It's a bit funny that we re-check whether we have exceeded the maximum
size in subsequente iterations once we hit the limit, but it arguably
makes the logic a bit simpler.

> +	}
> +
> +	for (i =3D 0; i < existing->non_kept_packs.nr; i++)
> +		fprintf(in, "-%s.pack\n",
> +			existing->non_kept_packs.items[i].string);
> +
> +	strbuf_release(&buf);
> +}
> +
>  static int write_cruft_pack(const struct pack_objects_args *args,
>  			    const char *destination,
>  			    const char *pack_prefix,
> @@ -846,10 +944,18 @@ static int write_cruft_pack(const struct pack_objec=
ts_args *args,
>  	in =3D xfdopen(cmd.in, "w");
>  	for_each_string_list_item(item, names)
>  		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
> -	for_each_string_list_item(item, &existing->non_kept_packs)
> -		fprintf(in, "-%s.pack\n", item->string);
> -	for_each_string_list_item(item, &existing->cruft_packs)
> -		fprintf(in, "-%s.pack\n", item->string);
> +	if (args->max_pack_size && !cruft_expiration) {
> +		unsigned long max_pack_size;
> +		if (!git_parse_ulong(args->max_pack_size, &max_pack_size))
> +			return error(_("could not parse --cruft-max-size: '%s'"),
> +				     args->max_pack_size);
> +		collapse_small_cruft_packs(in, max_pack_size, existing);
> +	} else {
> +		for_each_string_list_item(item, &existing->non_kept_packs)
> +			fprintf(in, "-%s.pack\n", item->string);
> +		for_each_string_list_item(item, &existing->cruft_packs)
> +			fprintf(in, "-%s.pack\n", item->string);
> +	}

If I understand correctly, we only collapse small cruft packs in case
we're not expiring any objects at the same time. Is there an inherent
reason why? I would imagine that it can indeed be useful to expire
objects contained in cruft packs and then have git-repack(1) recombine
whatever is left into larger packs.

If the reason is basically "it's complicated" then that is fine with me,
we can still implement the functionality at a later point in time. But
until then I think that we should let callers know that the two options
are incompatible with each other by producing an error when both are
passed.

Patrick

--uuEBqkH9oJRAWPT3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmT7A8cACgkQVbJhu7ck
PpSVdA//Xp563AfABGSUtndb/ToH8L4aOfIA+9e0VpIQCddtJ6xse+9Xvjl+o07S
WSn/Nt6jIPQFqOh7oZkXT10iwHzLaT9rAvC8coJ9e80yGkyEHQ925KShz/4NDuoX
Qb4ED+/0oObzY0I5N7QOd+C32sftckANNRwjRsQBOKR1kbLdDeNYAkiYr71JT6qA
rqio9WPvXtzwlyVl+KrFcP39o9eDBFUhL8vr3YceGKdGwSaatd3hOA+j67VcQTfU
0e9Xa3LNIDdu4Mt6D5pgJmSmFOxx3yecsfzdrIWEE5WBoWwJNvVgK8rmh8ZckkEp
TOMUs38oZaqX5YT3Q0zHRNd7KtT/sjFIOdHRwI36lAwte3Z2wlzkXz68AvbFBDuL
kt/FhUc2ts73XCfFDrYufyEBEi0E5P68pOoMHf5zrUsrYAjUf950nQiIDTJPlrs9
rvPjIAEhsocFxEMYy+xawXCfELt591rQ2pbTm3C70yQ5Agps30QParCyXg/Xtj02
IZe4eq4CYdTza4/+i3YNZWEBsDtB+K7W7FiG4U8I8yhpvMFmRgl5EVKJpp3G+VC4
KWVf7Abf8xBJE35uEG0lDvLpYvArwJ0ZZuzN4DJFaosDds6+jK8breReMyJuuOaJ
AS/CUeKrQGpjLnzXPqE/lSs4qEES2c/Q/pQQ+sMCcBmhXHA+0hg=
=bUY9
-----END PGP SIGNATURE-----

--uuEBqkH9oJRAWPT3--
