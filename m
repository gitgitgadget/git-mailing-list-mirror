Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1582CCA0
	for <git@vger.kernel.org>; Thu, 28 Mar 2024 08:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711614078; cv=none; b=IYX6QdliQOkKWcmfxCdRHXniQlbwehEUiAedMvR4gR274ElgyPeeI9szn8l6x8GzbcVGPXjGNbDCUVgecI18aLVOOzvEByO5zqNRKDN5/xfkoiWX+1hIX4PMLjSrWMKtoNvRJwNwpJ5pBKdveCcbMbyiz/dyXNcwfTWR5Kv7ur8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711614078; c=relaxed/simple;
	bh=1KwU+byyiu4BL7g8D5wdiRx9AennMGpNDDD6unP9HRM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5B4mvHuPSKjOWeiBsxrRL7cA9Yh9wreuIjOlRL+nkamsEzZoxQbkf6qPG59rgcmmuEqG5MDzksOkF3IW1q2nYBfjnXVxGQaj8POh93fUU5XpP+IkTKbKf2Fi2+Z0JdoyNPt5KE3pTZJzdNiRIi5zysJgVM0p/w0Yy+63Nso+Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XuRSPli1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kssjPqpx; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XuRSPli1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kssjPqpx"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 5BF8C1C000DE;
	Thu, 28 Mar 2024 04:21:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 28 Mar 2024 04:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711614074; x=1711700474; bh=9IOoeh9x8q
	JFiWlDGllS9o0D1QA6+iQAo4orcyWg97g=; b=XuRSPli1u3CZrK7rKN6M2irTXK
	y74cKA2+d9ImTnK4q5OuovnEgSLLSjchCwp+Rmv011RQGMGEujXko+TTxEL7SpOj
	+hbNwB84kyoG9/mGsbkKTr14la3RZvbeDnt8YO2V3P5P6TEuc4CVBecHpfWNkVYb
	DcNc+orBDrRcgHyN/vj1gVDMy8BrKpj+/rSG8cgrcFmEgEVFQv9bAlfWjX11seLh
	BWUcPw/gBdphsEGzc399oHwzUBBuhi3hH8nCbun0jkMTtet3S8xoucoKZthTVuqQ
	RcDUwNlEN5rZdvJN7MBSOs9sz56smc0SkWeItaH8MQO/Cqhz2j0jIZolJSTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711614074; x=1711700474; bh=9IOoeh9x8qJFiWlDGllS9o0D1QA6
	+iQAo4orcyWg97g=; b=kssjPqpxH2bNHa76NutXMTWwBKriwQ85hYVQe+sEvm5O
	J4zYLGuSnqfJ7V6nhtGk/zm43eCO5LxZYC9BkHblxZA9rysMMOGZ6nA2TPIAitId
	u6U3m0o5+2dSnaB69hkRRy2S9hy8nD50R0UPTSFzyEzbPvZoveRnasKsZ+yQ8AYL
	/G5voEHvR6qntJVfs8BGxiWp0EDxzaTtnjGL1o9jMkDb3chxj8JionCzpM/iqVr+
	6Rx5KDy9auvjccrbOMZl+YPj3deWm7fG5n39uczCnehgL39toEUTQm3dOKOnCmLf
	JglPCywyujH2PtfBYxu8VxXl6WkpDCHVNRBdoXIkRA==
X-ME-Sender: <xms:eigFZgrjxSrSGyOgvst2nSlM1nSusnq14J1vjXeczChpJd2lcsLHSQ>
    <xme:eigFZmrDakEG9FVJsv8UWBTn7XYcnL7VtdwKMXUvEixbVKl0TkpTwTGvQo5gfvR17
    U3zH8DFjBuPuTwAFA>
X-ME-Received: <xmr:eigFZlPIHs83SHgUdWKO8Z9S4AFwi4v07NqJkeOZjbU-6bkHEbavr7PM7LinhS2JHSZS3SUeeDrHqaVoBZIZZOAIK2k86up4Xc5bRw6_t7SyL6o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddukedguddukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:eigFZn5JfcOhyfLW78-nKLFkiYBH_07tFgQwD-z2N0UaWMe7_B8iig>
    <xmx:eigFZv5Cyww6YjL4xzJhcOnK_9-V7jAgZSzVI1MsU5aXDkHDCeW1fQ>
    <xmx:eigFZnhWypcQMKXTjA3lUCnTMiokyuNjGhMzheGJxXW34atrvf4zZA>
    <xmx:eigFZp4yFKSUvLaAERRpA0jK6s-LRO3i6YRbC8lQZL8HQZCnQViDGA>
    <xmx:eigFZi030nl2WBIdcFr5WyOGfJu_2BH9eO2QHe7PN3D-YMp8KPXLIzAdL7s>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Mar 2024 04:21:13 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b642482a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 28 Mar 2024 08:21:11 +0000 (UTC)
Date: Thu, 28 Mar 2024 09:21:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/6] fast-import: release unfreed strbufs
Message-ID: <ZgUod3QKptINaPBF@tanuki>
References: <20240322000304.76810-1-thalia@archibald.dev>
 <20240322000304.76810-4-thalia@archibald.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kh9/MWw+s3h0Gv1L"
Content-Disposition: inline
In-Reply-To: <20240322000304.76810-4-thalia@archibald.dev>


--kh9/MWw+s3h0Gv1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 12:03:33AM +0000, Thalia Archibald wrote:
> These strbufs are owned. Release them at the end of their scopes.
>=20
> Signed-off-by: Thalia Archibald <thalia@archibald.dev>
> ---
>  builtin/fast-import.c | 29 ++++++++++++++++++-----------
>  1 file changed, 18 insertions(+), 11 deletions(-)
>=20
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 1b3d6784c1..d6f998f363 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2364,6 +2364,7 @@ static void file_change_m(const char *p, struct bra=
nch *b)
>  	/* Git does not track empty, non-toplevel directories. */
>  	if (S_ISDIR(mode) && is_empty_tree_oid(&oid) && *path.buf) {
>  		tree_content_remove(&b->branch_tree, path.buf, NULL, 0);
> +		strbuf_release(&path);
>  		return;
>  	}

Oh, now you get to my comment in the preceding patch. With this patch
we're now in a somewhat weird in-between state where the buffers are
still static, but we release their memory after each call. So we kind of
get the worst of both worlds: static variables without being able to
reuse the buffer's memory.

If we were to change this then we should definitely mark the buffers as
non-static. If so, it would be great to demonstrate that this does not
significantly impact performance.

The same is true for all the other instances.

Patrick

> @@ -2409,11 +2410,11 @@ static void file_change_m(const char *p, struct b=
ranch *b)
>  				command_buf.buf);
>  	}
> =20
> -	if (!*path.buf) {
> +	if (*path.buf)
> +		tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
> +	else
>  		tree_content_replace(&b->branch_tree, &oid, mode, NULL);
> -		return;
> -	}
> -	tree_content_set(&b->branch_tree, path.buf, &oid, mode, NULL);
> +	strbuf_release(&path);
>  }
> =20
>  static void file_change_d(const char *p, struct branch *b)
> @@ -2422,6 +2423,7 @@ static void file_change_d(const char *p, struct bra=
nch *b)
> =20
>  	parse_path_eol(&path, p, "path");
>  	tree_content_remove(&b->branch_tree, path.buf, NULL, 1);
> +	strbuf_release(&path);
>  }
> =20
>  static void file_change_cr(const char *p, struct branch *b, int rename)
> @@ -2440,17 +2442,18 @@ static void file_change_cr(const char *p, struct =
branch *b, int rename)
>  		tree_content_get(&b->branch_tree, source.buf, &leaf, 1);
>  	if (!leaf.versions[1].mode)
>  		die("Path %s not in branch", source.buf);
> -	if (!*dest.buf) {	/* C "path/to/subdir" "" */
> +	if (*dest.buf)
> +		tree_content_set(&b->branch_tree, dest.buf,
> +			&leaf.versions[1].oid,
> +			leaf.versions[1].mode,
> +			leaf.tree);
> +	else	/* C "path/to/subdir" "" */
>  		tree_content_replace(&b->branch_tree,
>  			&leaf.versions[1].oid,
>  			leaf.versions[1].mode,
>  			leaf.tree);
> -		return;
> -	}
> -	tree_content_set(&b->branch_tree, dest.buf,
> -		&leaf.versions[1].oid,
> -		leaf.versions[1].mode,
> -		leaf.tree);
> +	strbuf_release(&source);
> +	strbuf_release(&dest);
>  }
> =20
>  static void note_change_n(const char *p, struct branch *b, unsigned char=
 *old_fanout)
> @@ -2804,6 +2807,7 @@ static void parse_new_commit(const char *arg)
>  	free(author);
>  	free(committer);
>  	free(encoding);
> +	strbuf_release(&msg);
> =20
>  	if (!store_object(OBJ_COMMIT, &new_data, NULL, &b->oid, next_mark))
>  		b->pack_id =3D pack_id;
> @@ -2886,6 +2890,7 @@ static void parse_new_tag(const char *arg)
>  	strbuf_addch(&new_data, '\n');
>  	strbuf_addbuf(&new_data, &msg);
>  	free(tagger);
> +	strbuf_release(&msg);
> =20
>  	if (store_object(OBJ_TAG, &new_data, NULL, &t->oid, next_mark))
>  		t->pack_id =3D MAX_PACK_ID;
> @@ -3171,6 +3176,7 @@ static void print_ls(int mode, const unsigned char =
*hash, const char *path)
>  		strbuf_addch(&line, '\n');
>  	}
>  	cat_blob_write(line.buf, line.len);
> +	strbuf_release(&line);
>  }
> =20
>  static void parse_ls(const char *p, struct branch *b)
> @@ -3206,6 +3212,7 @@ static void parse_ls(const char *p, struct branch *=
b)
>  		release_tree_content_recursive(leaf.tree);
>  	if (!b || root !=3D &b->branch_tree)
>  		release_tree_entry(root);
> +	strbuf_release(&path);
>  }
> =20
>  static void checkpoint(void)
> --=20
> 2.44.0
>=20
>=20
>=20

--kh9/MWw+s3h0Gv1L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYFKHYACgkQVbJhu7ck
PpQBTQ/8DXii2ml8IY0kpDN4hInue82/xzZlYNHtyl5hk0nLuNBppsH+SZKYhO76
PrsFNT2O3iofI6dj/9iilX1TRYdgyyqJTcaejowbMIK4HCnbU2nELi4VyGLJtDkr
eGQr8Bx9FJRR0Rg2cLOxNaF/zuPeY29kysSGeR8/lEcGHZPWDfwKNyQATEZKNWhI
3aHtAuH9+Kr2DS3cKmb2lF8dDQUZiNIlG0Z0ZaDlqyhxqXhI9Fx4ju7sbvCwKNWX
Io3IU9OrXGmQW8MV1YqemajzlQF5O9LNm0wGRB1McYq2sMebguTjBt6T8SjOYEwD
h5P2pxObVw0FmKZoS6Jf7q0lt/mPlokOra8TNMVt/LnTP9jdlAbQXvXPW1gzcsKk
tIYfLLNAjxgaJwuLCX+Qs0om1ms6OAqzNT+l40+IUJpBsUFnWeS7Oc1vegaqFv6X
HuNp51c62SYI0ikTK5TOnof7lJWQw+0qJz9yGiwlXe1TLhwLBD9rAOPRSeKH7l7p
duxckmZJYHEYmPKV5Spsl0a1rMHi1w1Gqf2Bkui2DMgO0g9pv42GPyy9xdAjJQ4X
V97mThO8Gu3DF2AuAbZ9Yg98DMRXf2Xp84ggvimjRP0lcyVtHfnpu+uj48Q7s+lr
v5nehUz6hd7RWO8Oq35Dp1lOTIWbhJynsWIai2zOOJv+QFdbx9M=
=Ua0A
-----END PGP SIGNATURE-----

--kh9/MWw+s3h0Gv1L--
