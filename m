Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD123D2
	for <git@vger.kernel.org>; Mon,  6 May 2024 11:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714996374; cv=none; b=pHxSeowbeUYRE6XH0IIs6O99jD8UJ+wjpWYfMBkMUM+5YOWznNdltrj3zcFQbwyOjf/xAtHu8V04zPLTRYlRdL9N9+AHNC20i2O0EstUgxlK8CCynHMj4OlFLhlelfYljlq3bLAFAZF80ltB/ffn96oTNFeO6zXmGJHnAgGYHbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714996374; c=relaxed/simple;
	bh=+9XwKEbKZGJbPT7iY7di1+qCxCGct9UAiK1eEZ/zfXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HqfXZWMQpZEGzl5P7APN1ilw8sOfoNeLEvCaQQ7qQkbtHMo71GcfpAMZ19OlraGDEZFvv6rvnnf6ACVJpX7CKkHEjzQ2It26qg+9Az7xLXfswXdMuZSN3TBhKOZVVfT0qBMh7u0vqaz5ui0NCqAMy8QDe/U62xouXL/DHvSWpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lrl+1GGK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i8B8DJ7r; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lrl+1GGK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i8B8DJ7r"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id 290FB1800129;
	Mon,  6 May 2024 07:52:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 06 May 2024 07:52:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714996369; x=1715082769; bh=ksgAti2ZNI
	+9odMSESH0Z51hL/znqSeD3Utd5lRyE1o=; b=lrl+1GGK6tYtU0aG7ydemnLO10
	hdPKeDjEUdF7HMIISLYPg3t5CdgrH4K3UkQ1OwlF2h2aPrtIzv0+Hupwo8tDaegp
	f/nVfiaxOZfkjdkv2yrF6lmHohS/xRbtEWsDUfKvAoeTnMjZhyY6oJJiuUwkqCWQ
	AzyxpySqmoDDgwYsXCo0avPZFMOx3Qk0lsJUSm8NKKWLkmreHzdVucR/fjvoBuSV
	5a6jXYV4GyQbPeq0iPtIjI/uKBhcrMo+5QbXHLGaMnxSacXxM5r0wXMAgIpvhzwy
	GpLcmWVkhxDc0PBrMeNfVrnWeGd4u1xGi67juUeSvFNeQNWXciG0z5hlOxLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714996369; x=1715082769; bh=ksgAti2ZNI+9odMSESH0Z51hL/zn
	qSeD3Utd5lRyE1o=; b=i8B8DJ7raWxe/J0/oqjW0sYkKVS01ywN+4flxofrRBTF
	AugK+EJg7ladgNKrwhARts8kPbVgDO7zrElO/z8ZYOUlnIV+bA/qIxghxhGVPsan
	T1nPDhnJLcyX3Az1bCaeRTEC67pgf0snXUohYx3+9O38QjnpoDfh+33oBLw1kwgQ
	hpdUhA2QdRIiTKVLV4roAVYhNdxqDUmDOIQTdpkYr+fCIC3/gRThtVv4NTkgLNJY
	6sQ8h9Jvrx5SW+KTAIaqQVYd0h4rBMoeI5rp3Fp8G02bmFZSaoPWMrVyV0Zx+2TR
	Iv21a4tC2Z0/t062kujaut+Zj9YGb0pUBuPkxyxCgA==
X-ME-Sender: <xms:kcQ4ZhojP69ZTFtbav-e4f8YSvnqaIUH35VNYgOQNhSnwWI0sqFUrw>
    <xme:kcQ4ZjpqWYcCyty-aXm3BSrvKmuxcCejmQw_4O6EgQUtmfPeAEdPKnYeD00_ccBgI
    ou2G-AguQjtK33s9A>
X-ME-Received: <xmr:kcQ4ZuOuWicaZ-VzwdOM6IHvCwNklzpkqaOaWjGiXnY9uojtXP6qyglPxUIQ1m4PgbSQfqopimWcpdvaCTpi9YodpWaLqntcB5SeAc7SHzZlnw1F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddviedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:kcQ4Zs7U45IybrTxbIhwEMpI7GfERDAE0iUHNe94kvPaVZSI5-cYOw>
    <xmx:kcQ4Zg50Xkr9sg50UscnPWonvOfZUGDAzFK3DvY8if9D3qu6UEFCUw>
    <xmx:kcQ4ZkiaSigxd9AsmNUttmyxrYKc4tJg5AXybO0CLf9ZY1Fw1ad43g>
    <xmx:kcQ4Zi7yXUsG38f3N6kVuxeZj3TGUE6btIEQhGI8dzn7Sdb1s2sQyQ>
    <xmx:kcQ4ZqSMKtF1fBHHkruUjH59MbaGJT1YQtjhguCzY6cs1q9Gm-nYhfrg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 07:52:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ebf55c5c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 11:52:41 +0000 (UTC)
Date: Mon, 6 May 2024 13:52:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 01/23] Documentation/technical: describe pseudo-merge
 bitmaps format
Message-ID: <ZjjEjNRp2BAMWJ47@tanuki>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1714422410.git.me@ttaylorr.com>
 <43fd5e3597151a86254e18e08ffd8cadbcb6e4f0.1714422410.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zL3wtdpj5DhIAaoh"
Content-Disposition: inline
In-Reply-To: <43fd5e3597151a86254e18e08ffd8cadbcb6e4f0.1714422410.git.me@ttaylorr.com>


--zL3wtdpj5DhIAaoh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:42:54PM -0400, Taylor Blau wrote:
> Prepare to implement pseudo-merge bitmaps over the next several commits
> by first describing the serialization format which will store the new
> pseudo-merge bitmaps themselves.
>=20
> This format is implemented as an optional extension within the bitmap v1
> format, making it compatible with previous versions of Git, as well as
> the original .bitmap implementation within JGit.
>=20
> The format (as well as a general description of pseudo-merge bitmaps,
> and motivating use-case(s)) is described in detail in the patch contents
> below, but the high-level description is as follows:
>=20
>   - An array of pseudo-merge bitmaps, each containing a pair of EWAH
>     bitmaps: one describing the set of pseudo-merge "parents", and
>     another describing the set of object(s) reachable from those
>     parents.
>=20
>   - A lookup table to determine which pseudo-merge(s) a given commit
>     appears in. An optional extended lookup table follows when there is
>     at least one commit which appears in multiple pseudo-merge groups.
>=20
>   - Trailing metadata, including the number of pseudo-merge(s), number
>     of unique parents, the offset within the .bitmap file for the
>     pseudo-merge commit lookup table, and the size of the optional
>     extension itself.
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Documentation/technical/bitmap-format.txt | 179 ++++++++++++++++++++++
>  1 file changed, 179 insertions(+)
>=20
> diff --git a/Documentation/technical/bitmap-format.txt b/Documentation/te=
chnical/bitmap-format.txt
> index f5d200939b0..63a7177ac08 100644
> --- a/Documentation/technical/bitmap-format.txt
> +++ b/Documentation/technical/bitmap-format.txt
> @@ -255,3 +255,182 @@ triplet is -
>  	xor_row (4 byte integer, network byte order): ::
>  	The position of the triplet whose bitmap is used to compress
>  	this one, or `0xffffffff` if no such bitmap exists.
> +
> +Pseudo-merge bitmaps
> +--------------------
> +
> +If the `BITMAP_OPT_PSEUDO_MERGES` flag is set, a variable number of
> +bytes (preceding the name-hash cache, commit lookup table, and trailing
> +checksum) of the `.bitmap` file is used to store pseudo-merge bitmaps.

Here you say that the section is supposed to come before some other
sections, whereas the first sentence in the "File format" section says
that it is the last section in a bitmap file.

> +A "pseudo-merge bitmap" is used to refer to a pair of bitmaps, as
> +follows:
> +
> +Commit bitmap::
> +
> +  A bitmap whose set bits describe the set of commits included in the
> +  pseudo-merge's "merge" bitmap (as below).
> +
> +Merge bitmap::
> +
> +  A bitmap whose set bits describe the reachability closure over the set
> +  of commits in the pseudo-merge's "commits" bitmap (as above). An
> +  identical bitmap would be generated for an octopus merge with the same
> +  set of parents as described in the commits bitmap.
> +
> +Pseudo-merge bitmaps can accelerate bitmap traversals when all commits
> +for a given pseudo-merge are listed on either side of the traversal,
> +either directly (by explicitly asking for them as part of the `HAVES`
> +or `WANTS`) or indirectly (by encountering them during a fill-in
> +traversal).
> +
> +=3D=3D=3D Use-cases

I feel like starting with the problems that the whole feature is
intended to solve would help the reading flow quite a bit. So I'd move
this whole section up.

> +For example, suppose there exists a pseudo-merge bitmap with a large
> +number of commits, all of which are listed in the `WANTS` section of
> +some bitmap traversal query. When pseudo-merge bitmaps are enabled, the
> +bitmap machinery can quickly determine there is a pseudo-merge which
> +satisfies some subset of the wanted objects on either side of the query.
> +Then, we can inflate the EWAH-compressed bitmap, and `OR` it in to the
> +resulting bitmap. By contrast, without pseudo-merge bitmaps, we would
> +have to repeat the decompression and `OR`-ing step over a potentially
> +large number of individual bitmaps, which can take proportionally more
> +time.
> +
> +Another benefit of pseudo-merges arises when there is some combination
> +of (a) a large number of references, with (b) poor bitmap coverage, and
> +(c) deep, nested trees, making fill-in traversal relatively expensive.
> +For example, suppose that there are a large enough number of tags where
> +bitmapping each of the tags individually is infeasible. Without
> +pseudo-merge bitmaps, computing the result of, say, `git rev-list
> +--use-bitmap-index --count --objects --tags` would likely require a
> +large amount of fill-in traversal. But when a large quantity of those
> +tags are stored together in a pseudo-merge bitmap, the bitmap machinery
> +can take advantage of the fact that we only care about the union of
> +objects reachable from all of those tags, and answer the query much
> +faster.

I would start the explanation with a discussion of the problem before
presenting the solution to those problems. In the current version it's
the other way round, you present a solution to a problem that isn't yet
explained

It might also be helpful to discuss a bit who is supposed to create
those pseudo-merge bitmaps. Does Git do so automatically for all tags?
Does the admin have to configure this? If the latter, when do you want
to create those and what strategies are there to create them?

> +=3D=3D=3D File format
> +
> +If enabled, pseudo-merge bitmaps are stored in an optional section at
> +the end of a `.bitmap` file. The format is as follows:
> +
> +....
> ++-------------------------------------------+
> +|               .bitmap File                |
> ++-------------------------------------------+
> +|                                           |
> +|  Pseudo-merge bitmaps (Variable Length)   |
> +|  +---------------------------+            |
> +|  | commits_bitmap (EWAH)     |            |
> +|  +---------------------------+            |
> +|  | merge_bitmap (EWAH)       |            |
> +|  +---------------------------+            |
> +|                                           |
> ++-------------------------------------------+
> +|                                           |
> +|  Lookup Table                             |
> +|  +------------+--------------+            |
> +|  | commit_pos |    offset    |            |
> +|  +------------+--------------+            |
> +|  |  4 bytes   |   8 bytes    |            |
> +|  +------------+--------------+            |

It's a bit confusing that in the EWAH section above you have the type of
the fields in the same line as the field itself, whereas here you have
them formatted in a separate box. This makes the reader wonder at first
whether this is two or four fields. How about the following instead:

    |  Lookup Table                             |
    |  +---------------------------+            |
    |  | commit_pos (4 bytes)      |            |
    |  +---------------------------+            |
    |  | offset (8 bytes)          |            |
    |  +---------------------------+            |

The same comment applies to the other sections further down.

> +|                                           |
> +|  Offset Cases:                            |
> +|  -------------                            |
> +|                                           |
> +|  1. MSB Unset: single pseudo-merge bitmap |
> +|     + offset to pseudo-merge bitmap       |
> +|                                           |
> +|  2. MSB Set: multiple pseudo-merges       |
> +|     + offset to extended lookup table     |
> +|                                           |
> ++-------------------------------------------+
> +|                                           |
> +|  Extended Lookup Table (Optional)         |
> +|                                           |
> +|  +----+----------+----------+----------+  |
> +|  | N  | Offset 1 |   ....   | Offset N |  |
> +|  +----+----------+----------+----------+  |
> +|  |    |  8 bytes |   ....   |  8 bytes |  |
> +|  +----+----------+----------+----------+  |
> +|                                           |
> ++-------------------------------------------+
> +|                                           |
> +|  Pseudo-merge Metadata                    |
> +|  +------------------+----------------+    |
> +|  | # pseudo-merges  | # Commits      |    |
> +|  +------------------+----------------+    |
> +|  | 4 bytes          | 4 bytes        |    |
> +|  +------------------+----------------+    |
> +|                                           |
> +|  +------------------+----------------+    |
> +|  | Lookup offset    | Extension size |    |
> +|  +------------------+----------------+    |
> +|  | 8 bytes          | 8 bytes        |    |
> +|  +------------------+----------------+    |
> +|                                           |
> ++-------------------------------------------+
> +....
> +
> +* One or more pseudo-merge bitmaps, each containing:

In case you have multiple pseudo-merge bitmaps, is the whole of the
above repeated for each bitmap or is it just parts of it?

> +  ** `commits_bitmap`, an EWAH-compressed bitmap describing the set of
> +     commits included in the this psuedo-merge.
> +
> +  ** `merge_bitmap`, an EWAH-compressed bitmap describing the union of
> +     the set of objects reachable from all commits listed in the
> +     `commits_bitmap`.
> +
> +* A lookup table, mapping pseudo-merged commits to the pseudo-merges
> +  they belong to. Entries appear in increasing order of each commit's
> +  bit position. Each entry is 12 bytes wide, and is comprised of the
> +  following:
> +
> +  ** `commit_pos`, a 4-byte unsigned value (in network byte-order)
> +     containing the bit position for this commit.
> +
> +  ** `offset`, an 8-byte unsigned value (also in network byte-order)
> +  containing either one of two possible offsets, depending on whether or
> +  not the most-significant bit is set.
> +
> +    *** If unset (i.e. `offset & ((uint64_t)1<<63) =3D=3D 0`), the offset
> +	(relative to the beginning of the `.bitmap` file) at which the
> +	pseudo-merge bitmap for this commit can be read. This indicates
> +	only a single pseudo-merge bitmap contains this commit.
> +
> +    *** If set (i.e. `offset & ((uint64_t)1<<63) !=3D 0`), the offset
> +	(again relative to the beginning of the `.bitmap` file) at which
> +	the extended offset table can be located describing the set of
> +	pseudo-merge bitmaps which contain this commit. This indicates
> +	that multiple pseudo-merge bitmaps contain this commit.
> +
> +* An (optional) extended lookup table (written if and only if there is
> +  at least one commit which appears in more than one pseudo-merge).
> +  There are as many entries as commits which appear in multiple
> +  pseudo-merges. Each entry contains the following:
> +
> +  ** `N`, a 4-byte unsigned value equal to the number of pseudo-merges
> +     which contain a given commit.

How exactly is the given commit identified? Or in other words, given an
entry in the lookup table here, how do I figure out what commit it
belongs to?

> +  ** An array of `N` 8-byte unsigned values, each of which is
> +     interpreted as an offset (relative to the beginning of the
> +     `.bitmap` file) at which a pseudo-merge bitmap for this commit can
> +     be read. These values occur in no particular order.
> +
> +* Positions for all pseudo-merges, each stored as an 8-byte unsigned
> +  value (in network byte-order) containing the offset (relative to the
> +  beginnign of the `.bitmap` file) of each consecutive pseudo-merge.

s/beginnign/beginning

Patrick

--zL3wtdpj5DhIAaoh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4xIsACgkQVbJhu7ck
PpTimg/+Jhdcsg5DWomkQWfZFHxxQJUcCvBYjnva39XNx0bbuLApUMuIU+mF9WH+
LKjZpqC0FX+6sC2QcUUxlPL5Yhj4iZbfGwBl1gZMpjfQevvDlHw9UicpoWq6gXTv
xjdVo+s9wFwgkjjBO3m4yElR230uP/AgPe3oJ26dOnjDOQzFqDAacXleRrvQlltC
Tp4/eoiD5s7gDwjVZWKuMBqc4e7UFbxHOcYY46Fzcr0ccJP6zpnY0ETUGPcjOBTM
l2HbkSxTLJfgEi+wQDzegUETmbjHzjtmqqdSS1aXY8QMDGiyuEN3MgMRREB6ddhs
NqpIVfilCQFI2I2l9N4JbSA2qjv8x7E/eWD9XKwHLQeSMtjCE/HSZ1o0puEFVDXy
wOL4YPlMkYfESpKKGcfQ808wQBgvWmbBcS3arV3ffWnp4owIjtWjffijPtmVqple
uH/m2owwUV4DOtsnJyXhGFJHQhC2eBcfh7RoJrShm4ZjfJRoo4TxqAIAspi7e3Un
2BT3VLwOByREhZTyi8ETWWvWKOD+vpqhGJ2n0NFZM2tRpiPNkvu6BJU/mxZXxSCc
zzYRxunPpl4sqOTK9sn2JfB6SR7EyJ3dpx9Zr/mTWXH2NoeMM4d9+grwMt+5GS6w
U5ViuVEGmNfPm0CUmzpedV1H72anOYJg7YrwSExTZFigu20sSnU=
=3zi/
-----END PGP SIGNATURE-----

--zL3wtdpj5DhIAaoh--
