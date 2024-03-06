Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4337FBDB
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709728215; cv=none; b=pIgVYdgUsI+PwRHsC4MLUOZFOHXpuBb0ogx109f9kuHNV9zvNCqvVSuMALx0aaZvThT5ROLY2tCz6eHLY+tOrFb84UQKAhvR+Ru8SFUVo63QoYx0Bd+59e6Yh8c7Lzcf9CGp2Op4gGZK0TUfqTg2FMYCekvs//1QZCLRxkch8JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709728215; c=relaxed/simple;
	bh=dKTfdGgCmsiNDHal4Eh5yumLFIgE93TVs5wEirSql04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFr0ho03nsmAQ7BI1Znls7Fmx2AkGUDTnJuEjm/iaDMPQcIefUEmmFcOa4CQob6S4IYIaqWn/Bgfy3cxGYV4ClU6NKf1Awayw1YsZxo8Ufnr9dNtww/Ov9sQVvr8W5i3eRmtt2ry1otoAxuCillCYJID7Y3O8JXj+eiXARuZVx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OKo0OxWy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WrHP+O0I; arc=none smtp.client-ip=64.147.123.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OKo0OxWy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WrHP+O0I"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 287B2320094F;
	Wed,  6 Mar 2024 07:30:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 06 Mar 2024 07:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709728211; x=1709814611; bh=i4MRkXPRcX
	2zZojaOdB3f8iLnvNEsGS5fqJ7+21wKRo=; b=OKo0OxWyAcwrnlwnpFmJpE1TX2
	5SMTwZOawJxYD5B65svtuIub30ZgCUSDveMrYzEF5Pz9NvfOzyOwx1Gs+bRMnLQu
	Z8KDVs78j7BAYtn9oPYRQguf9Oh+kD5/SUuMGn1yImLYwvHdGknPCuIoqmcFWjNW
	r3sHzw7LSEDTdIc0dl+ZYjh4LIn2YDY7iuVZ6bJ+Ta6YjfmkGxoVNWWqRR4ae+TW
	48hz8BH4z4TvmDfsdzrOhNOF7GjsC14SSwjXtNMA7qd719iDKrJDlGTiXguu0c2Z
	51/gm/fzWihH+zIEJPHsTUKIDXZJUvU+fxYWkFdyKmOFEmMybxfRBrWEYBDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709728211; x=1709814611; bh=i4MRkXPRcX2zZojaOdB3f8iLnvNE
	sGS5fqJ7+21wKRo=; b=WrHP+O0I85wsmhRfhICfVKs05JTn1NOjw/UcbKcQO390
	fdrcTSMWmW/0Bf+JEZanwv5++H/WOnPVhMZeIj+JpBzMV2+QNHYYRwNPQJVqxEBC
	THrBxfY/r8oVT2ZlM3QXV/FJIURX3VwgqUKgoUPWZIk5hxGyaMxNUR4478A9uoVf
	RKoUYhUfBjeGkRrtpoiVVwwxKjcZUhTq3o6NUyupPK39dL16dtUbmEAjmLUrvVNf
	+mMsl0beOPYsufzxzy/7/wyhpkMXODjX0u3eO3n2OoI7gxiyoF8f09MToez9JI1L
	/OeZGTC8Rxt3hpJqYdcEF4ovbIz38UevvXfPjL17Vw==
X-ME-Sender: <xms:02HoZTFs4hUCPhaImSLTckjCVYgW_aYvvp9qeSmk29S98DClcENcfg>
    <xme:02HoZQUzvkEdZnvsfu78UBGLfFzqaEeLcWv3CWAZarf5RjBnXIXAN-JvwmNxuih7q
    I0ac-0aO6IymlS2qQ>
X-ME-Received: <xmr:02HoZVKPzjXj0JA0LxS-SPa242lWSisTd8w_VLUXg7l5Ji6ktLqQQ6rWwgqMDgQZGv7s9IFjLj0rdZtLgXijIYf_nL5L_s9Wz24gRp0j5_aF6rkL0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledriedugdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtdorredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeejfeeuueetiefhffeigeeiuefhtefguefgjeelffelhedvfeejjeehueefffeiteen
    ucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:02HoZREeMv6jbnumEZtyyCMG9fR07u0lUwzeY4ZXNOV7TlVMNHCiNQ>
    <xmx:02HoZZXXSfSbP4CjMBYCUlO7b6Wa8yV_BNM6yqVChxVg_xSIvSew-g>
    <xmx:02HoZcNEY8-mX556mjxrgFZB3eT95_6QwmfL7tj2HbnErWDTTXv2Nw>
    <xmx:02HoZWhivsp4TiQoflHIUMeVCw838b1vBzO6uBeVW7Cmwt4RUSXveg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Mar 2024 07:30:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 783e1266 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 6 Mar 2024 12:25:37 +0000 (UTC)
Date: Wed, 6 Mar 2024 13:30:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] reftable/stack: use geometric table compaction
Message-ID: <ZehhzdOYYvreRIfq@tanuki>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N+Ku8Sk2RulYRMUl"
Content-Disposition: inline
In-Reply-To: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>


--N+Ku8Sk2RulYRMUl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 05, 2024 at 08:03:45PM +0000, Justin Tobler via GitGitGadget wr=
ote:
> From: Justin Tobler <jltobler@gmail.com>
>=20
> To reduce the number of on-disk reftables, compaction is performed.
> Contiguous tables with the same binary log value of size are grouped
> into segments. The segment that has both the lowest binary log value and
> contains more than one table is set as the starting point when
> identifying the compaction segment.
>=20
> Since segments containing a single table are not initially considered
> for compaction, if the table appended to the list does not match the
> previous table log value, no compaction occurs for the new table. It is
> therefore possible for unbounded growth of the table list. This can be
> demonstrated by repeating the following sequence:
>=20
> git branch -f foo
> git branch -d foo
>=20
> Each operation results in a new table being written with no compaction
> occurring until a separate operation produces a table matching the
> previous table log value.
>=20
> To avoid unbounded growth of the table list, walk through each table and
> evaluate if it needs to be included in the compaction segment to restore
> a geometric sequence.

I think the description of what exactly changes could use some more
explanation and some arguments why the new behaviour is okay, too. It's
quite a large rewrite of the compaction logic, so pinpointing exactly
how these are different would go a long way.

> Some tests in `t0610-reftable-basics.sh` assert the on-disk state of
> tables and are therefore updated to specify the correct new table count.
> Since compaction is more aggressive in ensuring tables maintain a
> geometric sequence, the expected table count is reduced in these tests.
> In `reftable/stack_test.c` tests related to `sizes_to_segments()` are
> removed because the function is no longer needed. Also, the
> `test_suggest_compaction_segment()` test is updated to better showcase
> and reflect the new geometric compaction behavior.
>=20
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>     reftable/stack: use geometric table compaction
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1683%2F=
jltobler%2Fjt%2Freftable-geometric-compaction-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1683/jltob=
ler/jt/reftable-geometric-compaction-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1683
>=20
>  reftable/stack.c           | 106 +++++++++++++++----------------------
>  reftable/stack.h           |   3 --
>  reftable/stack_test.c      |  66 +++++------------------
>  t/t0610-reftable-basics.sh |  24 ++++-----
>  4 files changed, 70 insertions(+), 129 deletions(-)
>=20
> diff --git a/reftable/stack.c b/reftable/stack.c
> index b64e55648aa..e4ea8753977 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1214,75 +1214,57 @@ static int segment_size(struct segment *s)
>  	return s->end - s->start;
>  }
> =20
> -int fastlog2(uint64_t sz)
> -{
> -	int l =3D 0;
> -	if (sz =3D=3D 0)
> -		return 0;
> -	for (; sz; sz /=3D 2) {
> -		l++;
> -	}
> -	return l - 1;
> -}
> -
> -struct segment *sizes_to_segments(size_t *seglen, uint64_t *sizes, size_=
t n)
> -{
> -	struct segment *segs =3D reftable_calloc(n, sizeof(*segs));
> -	struct segment cur =3D { 0 };
> -	size_t next =3D 0, i;
> -
> -	if (n =3D=3D 0) {
> -		*seglen =3D 0;
> -		return segs;
> -	}
> -	for (i =3D 0; i < n; i++) {
> -		int log =3D fastlog2(sizes[i]);
> -		if (cur.log !=3D log && cur.bytes > 0) {
> -			struct segment fresh =3D {
> -				.start =3D i,
> -			};
> -
> -			segs[next++] =3D cur;
> -			cur =3D fresh;
> -		}
> -
> -		cur.log =3D log;
> -		cur.end =3D i + 1;
> -		cur.bytes +=3D sizes[i];
> -	}
> -	segs[next++] =3D cur;
> -	*seglen =3D next;
> -	return segs;
> -}
> -
>  struct segment suggest_compaction_segment(uint64_t *sizes, size_t n)
>  {
> -	struct segment min_seg =3D {
> -		.log =3D 64,
> -	};
> -	struct segment *segs;
> -	size_t seglen =3D 0, i;
> -
> -	segs =3D sizes_to_segments(&seglen, sizes, n);
> -	for (i =3D 0; i < seglen; i++) {
> -		if (segment_size(&segs[i]) =3D=3D 1)
> -			continue;
> +	struct segment seg =3D { 0 };
> +	uint64_t bytes;
> +	size_t i;
> =20
> -		if (segs[i].log < min_seg.log)
> -			min_seg =3D segs[i];
> -	}
> +	/*
> +	 * If there are no tables or only a single one then we don't have to
> +	 * compact anything. The sequence is geometric by definition already.
> +	 */
> +	if (n <=3D 1)
> +		return seg;
> =20
> -	while (min_seg.start > 0) {
> -		size_t prev =3D min_seg.start - 1;
> -		if (fastlog2(min_seg.bytes) < fastlog2(sizes[prev]))
> +	/*
> +	 * Find the ending table of the compaction segment needed to restore the
> +	 * geometric sequence.
> +	 *
> +	 * To do so, we iterate backwards starting from the most recent table
> +	 * until a valid segment end is found. If the preceding table is smaller
> +	 * than the current table multiplied by the geometric factor (2), the
> +	 * current table is set as the compaction segment end.
> +	 */
> +	for (i =3D n - 1; i > 0; i--) {
> +		if (sizes[i - 1] < sizes[i] * 2) {
> +			seg.end =3D i;
> +			bytes =3D sizes[i];
>  			break;
> +		}
> +	}

I was briefly wondering whether we have to compare the _sum_ of all
preceding table sizes to the next size here. Otherwise it may happen
that compaction will lead to a new table that is immediately violating
the geometric sequence again.

But I think due to properties of the geometric sequence, the sum of all
entries preceding the current value cannot be greater than the value
itself. So this should be fine.

This might be worth a comment.

> +
> +	/*
> +	 * Find the starting table of the compaction segment by iterating
> +	 * through the remaing tables and keeping track of the accumulated size

s/remaing/remaining/

> +	 * of all tables seen from the segment end table.
> +	 *
> +	 * Note that we keep iterating even after we have found the first
> +	 * first starting point. This is because there may be tables in the

Nit: s/first//, duplicate word.

> +	 * stack preceding that first starting point which violate the geometric
> +	 * sequence.
> +	 */
> +	for (; i > 0; i--) {
> +		uint64_t curr =3D bytes;
> +		bytes +=3D sizes[i - 1];
> =20
> -		min_seg.start =3D prev;
> -		min_seg.bytes +=3D sizes[prev];
> +		if (sizes[i - 1] < curr * 2) {
> +			seg.start =3D i - 1;
> +			seg.bytes =3D bytes;
> +		}
>  	}

Overall I really like the rewritten algorithm, it's a ton easier to
understand compared to the preceding code.

One thing I'd suggest doing though is to provide a benchmark of how the
new compaction strategy compares to the old one. A comparatively easy
way to do this is to write N refs sequentially -- with a big enough N
(e.g. 1 million), compaction time will eventually become an important
factor. So something like the following (untested):

hyperfine \
  --prepare "rm -rf repo && git init --ref-format=3Dreftable repo && git -C=
 repo commit --allow-empty --message msg" \
  'for ((i =3D 0 ; i < 1000000; i++ )); do git -C repo update-ref refs/head=
s/branch-$i HEAD'

> =20
> -	reftable_free(segs);
> -	return min_seg;
> +	return seg;
>  }
> =20
>  static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack =
*st)
[snip]
> @@ -737,10 +737,10 @@ test_expect_success 'worktree: pack-refs in main re=
po packs main refs' '
>  	test_commit -C repo A &&
>  	git -C repo worktree add ../worktree &&
> =20
> -	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> -	test_line_count =3D 4 repo/.git/reftable/tables.list &&
> +	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> +	test_line_count =3D 1 repo/.git/reftable/tables.list &&
>  	git -C repo pack-refs &&
> -	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> +	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
>  	test_line_count =3D 1 repo/.git/reftable/tables.list
>  '

This test needs updating as git-pack-refs(1) has become a no-op here.

> @@ -750,11 +750,11 @@ test_expect_success 'worktree: pack-refs in worktre=
e packs worktree refs' '
>  	test_commit -C repo A &&
>  	git -C repo worktree add ../worktree &&
> =20
> -	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> -	test_line_count =3D 4 repo/.git/reftable/tables.list &&
> +	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> +	test_line_count =3D 1 repo/.git/reftable/tables.list &&
>  	git -C worktree pack-refs &&
>  	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> -	test_line_count =3D 4 repo/.git/reftable/tables.list
> +	test_line_count =3D 1 repo/.git/reftable/tables.list
>  '

Same.

>  test_expect_success 'worktree: creating shared ref updates main stack' '
> @@ -770,7 +770,7 @@ test_expect_success 'worktree: creating shared ref up=
dates main stack' '
> =20
>  	git -C worktree update-ref refs/heads/shared HEAD &&
>  	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> -	test_line_count =3D 2 repo/.git/reftable/tables.list
> +	test_line_count =3D 1 repo/.git/reftable/tables.list
>  '

Same.

One thing missing is a test that demonstrates the previously-broken
behaviour.

Patrick

>  test_expect_success 'worktree: creating per-worktree ref updates worktre=
e stack' '
>=20
> base-commit: b387623c12f3f4a376e4d35a610fd3e55d7ea907
> --=20
> gitgitgadget
>=20

--N+Ku8Sk2RulYRMUl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXoYcwACgkQVbJhu7ck
PpRaCg//eVm/4PI2MXcDfdi3BYu6G1AN5jFrB1Rp/ZrCyTp60ng30d4Pe5GCbaEm
KqCMAoZVs/kKZvGQ5vZdoGCugDQe7Xn0Ow8nM62NBUkcFbU5QJM4MbQ6CBJdbl2f
DJOAd4xjZ2hsBiihIYMSy09qY8+IGeG4McYkwyGqH8yKThIxd3uAbYZckn4Vigwr
1Y1o0r51eSjGnIQjuaL3+mkN34KJ96/x3zEPW/dGdqK28NJn4zjazviAAho/MSDA
lqWTFqtdaJLGBX4XFoa7csVJMwvzC0HcYlRyfLLsZ+VIBFUXa44nHAFEZKQA5UpW
kK0mMKps6PZNF7vHI1qjbi0OZWG2mrdLRVQSwwvmarI2jcP4mXoHXCBhbv5cX+vk
ck7ZEEmIhi0du3L9cHz1vtgkAS1qin08c+gXAMlXQ8+dFnBHiKcxuEOSw0ATHBJn
MTcAXjzJLShyraqjXsAFJ4HmJWLZijSQs8nGJ3co61b7dPMEP70OZeOQSJ0w7781
NunHDWxO0FwAbKavn4I+eb5ui3KrPJptqa/m7MMRz07WCbpy26xunFprnbUJ8wjb
/MfnTvB5yqG9HLYWVwjXJ0C0ueLgXrXTVofGXysD8zd+49x69RrLMy6hhAOSaFNN
QWZET3LNmTd3LcXmkaaIuN7s83w77KErfy8IgWsvMsXRSYBch4o=
=h5P+
-----END PGP SIGNATURE-----

--N+Ku8Sk2RulYRMUl--
