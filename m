Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86036E92703
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 14:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjJEOXG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 10:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234240AbjJEOVT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 10:21:19 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266AE6EB6
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 06:55:51 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id DA9823200C00;
        Thu,  5 Oct 2023 08:08:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 05 Oct 2023 08:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1696507697; x=1696594097; bh=ZX
        gdutLQkNeOhLhFayqouySg57lt/5ainKy8JoGgAqI=; b=sqmzKdvBQmu6W7tHgs
        Pj34DRRoDRkWTmegoeBvqmwPzNUjnqxFQX7aqiYp6SqgNySKJzn2+DkXH3sS9+Es
        70aWeRJNpr04yhrv2b0nF4MbtvtScuxPCJvB+YtIM46CT3A2JitptQ+OnYGDwOJq
        S/qXWuQttA8teXyey5LEWypPCCUhm64vWr40uldjDoPzzEG72Vf2BoavRNRJ+7dh
        IKrmuqbUnmCCPQP1Eqwa0ynr6VAHnB+dd4OVAnQtvjC1c+b1OrDJawx3GkDsW3YB
        mGlIlI4+j33c5wou/ltidDJdncFqRe7fqQFXz2uH1dor+j1d0Yk4jfiTtZwWUOg2
        aAUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1696507697; x=1696594097; bh=ZXgdutLQkNeOh
        LhFayqouySg57lt/5ainKy8JoGgAqI=; b=fVC1MHKtxsEa6JMxUm5joS8xgl/lw
        6Vgv1rNrg5O2OMwYhIloMMksEh+KsAgDd+oRzHfBMnmPxLNoQKTroIUNjHK6VkTL
        Pex9CvsrrpCChMToIREhoSfnCaTHLO/NHbYgIdaEO95DyqTQmA2pubhK0Zedxgvu
        3raa2cvIA4C7B0R6mIkpdCJAyXn7+zqEbLoAq9Ul9pOv9iiUTr3ygUBYaCvRN8gE
        KjghjBnH0Qd1Mv8UUG0HAzY2KjCtN8Olx5WDy7+wj1Nadbm/Zfxk1fd9g/F27Oqt
        wPqFUbwUu9uPGharz55UDNjNeX2kkwKI52C4cDWfWb9RaI3zb1EG3NnJA==
X-ME-Sender: <xms:MaceZZdaXJ6tMtBG4-dUK_AfqVZYKo4P65EBbkMkbMLlT2_oJOWXeA>
    <xme:MaceZXNY4CN6NGXCGbfX8ex0_CJaeZ4m4lOrt7WxcpDqcFUvsEAtOor4Blxy5yaCd
    mzaC66rtgkQceX10A>
X-ME-Received: <xmr:MaceZShTYRFX0lHiSYFsWGN8cZQt7pw1cLkJ5-gqBVBRDYk9QbtUTK-pIEB1D1iNYyvhgyg5V5VHoyuSPhS818VH48rsB47JIE30xtphT65PmA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrgeeggdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:MaceZS_E6XQUTg3w6Yi4OZtZTOy65VS4zgjbcKmqLKbNvGfjAZVrXQ>
    <xmx:MaceZVuGYqdZTFx0OIDouGFR_p6Plgy7i6TCdMVkpMr_zNvAT6kewQ>
    <xmx:MaceZRGTcxCzI9OGeMD9mwabEu2a1eOn4rM6z6YPKf_8GzdFP3TmlQ>
    <xmx:MaceZdLpWp2X_6_FXST6QG9zjHpDu-f_bKvx8D-VYSfBjE3VqpISiw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 5 Oct 2023 08:08:15 -0400 (EDT)
Received: by vm-mail (OpenSMTPD) with ESMTPSA id 99867548 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 5 Oct 2023 12:08:12 +0000 (UTC)
Date:   Thu, 5 Oct 2023 14:08:11 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] builtin/repack.c: implement support for
 `--max-cruft-size`
Message-ID: <ZR6nKzflu_18JnoG@tanuki>
References: <cover.1694123506.git.me@ttaylorr.com>
 <cover.1696293862.git.me@ttaylorr.com>
 <e7beb2060dad648ec5c3fa8984e432ee243ae012.1696293862.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vRS6MLkWI7gfwfqT"
Content-Disposition: inline
In-Reply-To: <e7beb2060dad648ec5c3fa8984e432ee243ae012.1696293862.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vRS6MLkWI7gfwfqT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 08:44:32PM -0400, Taylor Blau wrote:
[snip]
> diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
> index 90806fd26a..fa0541b416 100644
> --- a/Documentation/git-gc.txt
> +++ b/Documentation/git-gc.txt
> @@ -59,6 +59,13 @@ be performed as well.
>  	cruft pack instead of storing them as loose objects. `--cruft`
>  	is on by default.
> =20
> +--max-cruft-size=3D<n>::
> +	When packing unreachable objects into a cruft pack, limit the
> +	size of new cruft packs to be at most `<n>`. Overrides any

We should probably mention the unit here, which is bytes.

[snip]
> @@ -806,6 +846,72 @@ static void remove_redundant_bitmaps(struct string_l=
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
> +static void collapse_small_cruft_packs(FILE *in, size_t max_size,
> +				       struct existing_packs *existing)
> +{
> +	struct packed_git **existing_cruft, *p;
> +	struct strbuf buf =3D STRBUF_INIT;
> +	size_t total_size =3D 0;
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
> +		size_t proposed;
> +
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
> +	}
> +
> +	for (i =3D 0; i < existing->non_kept_packs.nr; i++)
> +		fprintf(in, "-%s.pack\n",
> +			existing->non_kept_packs.items[i].string);

As far as I can see, the non-kept packs are passed to
git-pack-objects(1) both in the cases where we do collapse small cruft
packs and where we don't. Is there any particular reason why we handle
those in both code paths separately instead of merging that logic? Is
the ordering of packfiles important here?

> +	strbuf_release(&buf);
> +}
> +
>  static int write_cruft_pack(const struct pack_objects_args *args,
>  			    const char *destination,
>  			    const char *pack_prefix,
> @@ -853,10 +959,14 @@ static int write_cruft_pack(const struct pack_objec=
ts_args *args,
>  	in =3D xfdopen(cmd.in, "w");
>  	for_each_string_list_item(item, names)
>  		fprintf(in, "%s-%s.pack\n", pack_prefix, item->string);
> -	for_each_string_list_item(item, &existing->non_kept_packs)
> -		fprintf(in, "-%s.pack\n", item->string);
> -	for_each_string_list_item(item, &existing->cruft_packs)
> -		fprintf(in, "-%s.pack\n", item->string);
> +	if (args->max_pack_size && !cruft_expiration) {
> +		collapse_small_cruft_packs(in, args->max_pack_size, existing);
> +	} else {
> +		for_each_string_list_item(item, &existing->non_kept_packs)
> +			fprintf(in, "-%s.pack\n", item->string);
> +		for_each_string_list_item(item, &existing->cruft_packs)
> +			fprintf(in, "-%s.pack\n", item->string);
> +	}
>  	for_each_string_list_item(item, &existing->kept_packs)
>  		fprintf(in, "%s.pack\n", item->string);
>  	fclose(in);

Patrick

--vRS6MLkWI7gfwfqT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmUepyoACgkQVbJhu7ck
PpRGEQ//cYxxRrXMBZhyptxzzyQljskJ9eDfsSHXy+lpQlj0w/0sjgyjKZMbojTv
EgecHFheUkwMvpHYSpOVVzk/yLcUt6BfZpEBApneXvnPakHkVh9ktyoN+vMB3GSl
FKJL5wG4jPAnMY26ONG1hKSEs7UCHcs9b4ua31bSP2TpKB3iyIhd3P7QsLx3rp0j
R3QoLv4I4+M8WRr265NCLVHa07ZVfZWhL8hcVRYrRZ+ygyVgRx3OPezWcd4oGwh1
+9jwTBSqQbjXxv32JbDSFELPsLzZ++rByK6e+uVYoc3EMygBt0mB2VdXR8afvAiX
CrIlyQB6qoBiXTXrs08FTvtX6XfTOzyr82gZw0RgmVRGLU4ssHkahu1MHmvR+TCz
MGEeDPbGd5FcERLotOQp1q7kFlaLb+sfsQ4gYdQIKbfizcBDPCWA96eZ27TPhUe3
dsbRH31zuNgL94xQfHzqgZRdlczKZjkwA3RKZNI6+n5gzb7DaE/xVy9B5sgVBLU9
/+DAHypgWoGuZvvRTFyhgPA5tqKTvAtf8Fi/9YrGuf/sK22Wxxq1JBdxpo25Adex
k0NuMXf3Cu7Q7tEvCLOFi6QjhfcvOuuKkcJHv3YZv1iTam7BlvqEHo5X4CqyVyGA
IrDsrj/fOUbZoE9UcX67gEU/G/04ptSnZzCRpAxNFDRGHgmDbTg=
=WCEw
-----END PGP SIGNATURE-----

--vRS6MLkWI7gfwfqT--
