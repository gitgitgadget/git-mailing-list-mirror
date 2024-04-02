Received: from wfout6-smtp.messagingengine.com (wfout6-smtp.messagingengine.com [64.147.123.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C516F3B299
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 07:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712042637; cv=none; b=Sqe37iJLh9okrWAZfwNKlrKjhUaO0c5rcGeTHUrj7Tqnb1M1PDauQZEbmcRlRbXV+Tfw48njJE3YXedmJC1k2FeK7vREQ+omoKn/BgcWQzj0y6rSJ5lft7SKnZMVkzaF4e6jxMc9ExXiAfIiG6S6g2SKZ6bloRamINGV3EeTif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712042637; c=relaxed/simple;
	bh=w9CIL94r0dOEQH7VpjdXlL//r2ATG6Xkdl6NG1AKJ6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gdv3JKnlQgtHS0x7QqfI5Ju4uyhex6erK7/F97ysco1EY1Er70gMJdYtf+SmtiXocroYMUTxQ4ACdpDnty3DwFvuS5mp4o7cns/CM69zgOPAhofD9+PzoiYbp5WB8IAI+ncSyk5rgUNFuXCkmGuS52XJsZJrwZY+PFr+zLn+Kms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gT284i+r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GN2RzRPs; arc=none smtp.client-ip=64.147.123.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gT284i+r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GN2RzRPs"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 72EEE1C0007C;
	Tue,  2 Apr 2024 03:23:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 02 Apr 2024 03:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712042633; x=1712129033; bh=T981OUnN7o
	BIGaZOtGwo62T6cVFuU3zJoo51c13nPNY=; b=gT284i+r0y1bkuh445lNL0+7xK
	PS/YQgCQzuYvek5lYv1/3aNVCh/5knbiIfnnAgApJFVL0Xe0iPu+D6Cvu7JtcfC8
	0LNp7i2hKMgKUcAktXSf4uJ4GhFH5OqIYQKk5c+/GKo3fD3WVGu0G0k8OXo2ehuU
	72761StzfJY4u6UHrWGMEmv8I03cl7CsRY75jvHophBElXsgtGQYN8TXspMe4MFK
	3kOEScU76J0c9QnKQfVGfuccFK4minET4TPcTeI3t+c58CJ0Q+b/tpkY/0sYF5md
	vvuAsFWiW3TG1c12lj5ybMn1nUzu2Nw8d+wExw9FcJGLfqGkRBLMsjCqHHjg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712042633; x=1712129033; bh=T981OUnN7oBIGaZOtGwo62T6cVFu
	U3zJoo51c13nPNY=; b=GN2RzRPsmCMR/veLv1cDPyg6wU6r2BNCN2SM/RIp/w8/
	strGxD2poFziv9HompkkLUZrK8vs21OZoYdyV0q2kipCXSTf6Z5j6M0J6ovUisBk
	7j+6ZZUQruTEse/Ce4//WGg8uY+r57FsnD1c5RWqpnujWXJRR+OkjRGuGGKDKpOo
	elJpovsVy2KcRrrK/JKdveRXPGs1xmLKOCQc9D5xyl4CaRXlrz4l8i5M72F+94JH
	tbpxPelOwKi8QfhqvuTqFo1mNVxcriRS963fxmzCJVty5ZoAGlq2viBQzlyqMYKh
	uCC00zZzBHCGdHXcIL40XqN5F2Z0W6g50R0LZvaWfw==
X-ME-Sender: <xms:ibILZju9iQQVhOpixf7jhJhWrE6qPJlER1zn_xx_jPb07TFdTxIFcw>
    <xme:ibILZkewApNVP8cmJ03ywhp9W4pOXWobyhPp8f3Oj2Votm6V8HPhp6gxunt-fsuRR
    L6GaF1SkqsV8pcXmQ>
X-ME-Received: <xmr:ibILZmwwWQ3ejR_aGxHHf9xtTH0r2xFSFeqHVBNDopbvOC2J2IQ0pb9L0SqQtoNjAAIO3Tvp5twW8UKzD-NEo-InqdsX6e_1I-9fHZ4V3TDLen8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedt
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:ibILZiMS7mCjgMfmycNn5XZo8AurG0S5mvqlcsUY_c39I1lf-Tdwgg>
    <xmx:ibILZj_vMHhsbfkQnxIev83GBEHUv1tSTGujUYvIVfA9qyDCW4K2Zw>
    <xmx:ibILZiUUw9Qoj6UI8y1Hu0vLuTHe66TIEJawnq9d3a-Etvi1yOfZGg>
    <xmx:ibILZkdj4vUh4mtlROjIh4DSWzmGZlcing1uZD_HD5fKS2lcXtAcig>
    <xmx:ibILZulZjZXBzQ-fGEiR80txUtzqU1RaUSn_NgBrWf9AZjsfkPjY62Sn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 03:23:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d2d208fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 07:23:44 +0000 (UTC)
Date: Tue, 2 Apr 2024 09:23:50 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 2/3] reftable/stack: use geometric table compaction
Message-ID: <Zguyhhyot0ZphACv@tanuki>
References: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <pull.1683.v3.git.1711685809.gitgitgadget@gmail.com>
 <7e62c2286ae9c63368f1508f065b33422ca24bc8.1711685809.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oeneywtiiNbPiQ9u"
Content-Disposition: inline
In-Reply-To: <7e62c2286ae9c63368f1508f065b33422ca24bc8.1711685809.git.gitgitgadget@gmail.com>


--oeneywtiiNbPiQ9u
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 29, 2024 at 04:16:48AM +0000, Justin Tobler via GitGitGadget wr=
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
> Instead, to avoid unbounded growth of the table list, the compaction
> strategy is updated to ensure tables follow a geometric sequence after
> each operation by individually evaluating each table in reverse index
> order. This strategy results in a much simpler and more robust algorithm
> compared to the previous one while also maintaining a minimal ordered
> set of tables on-disk.
>=20
> When creating 10 thousand references, the new strategy has no
> performance impact:
>=20
> Benchmark 1: update-ref: create refs sequentially (revision =3D HEAD~)
>   Time (mean =C2=B1 =CF=83):     26.516 s =C2=B1  0.047 s    [User: 17.86=
4 s, System: 8.491 s]
>   Range (min =E2=80=A6 max):   26.447 s =E2=80=A6 26.569 s    10 runs
>=20
> Benchmark 2: update-ref: create refs sequentially (revision =3D HEAD)
>   Time (mean =C2=B1 =CF=83):     26.417 s =C2=B1  0.028 s    [User: 17.73=
8 s, System: 8.500 s]
>   Range (min =E2=80=A6 max):   26.366 s =E2=80=A6 26.444 s    10 runs
>=20
> Summary
>   update-ref: create refs sequentially (revision =3D HEAD) ran
>     1.00 =C2=B1 0.00 times faster than update-ref: create refs sequential=
ly (revision =3D HEAD~)
>=20
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
>  reftable/stack.c           | 120 ++++++++++++++++++-------------------
>  reftable/stack.h           |   3 -
>  reftable/stack_test.c      |  67 +++++----------------
>  t/t0610-reftable-basics.sh |  45 +++++++++-----
>  4 files changed, 103 insertions(+), 132 deletions(-)
>=20
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 07262beaaf7..e7b9a1de5a4 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1202,75 +1202,73 @@ static int segment_size(struct segment *s)
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
> +	 *
> +	 * Tables after the ending point are not added to the byte count because
> +	 * they are already valid members of the geometric sequence. Due to the
> +	 * properties of a geometric sequence, it is not possible for the sum of
> +	 * these tables to exceed the value of the ending point table.
> +	 *
> +	 * Example table size sequence requiring no compaction:
> +	 * 	64, 32, 16, 8, 4, 2, 1
> +	 *
> +	 * Example compaction segment end set to table with size 3:
> +	 * 	64, 32, 16, 8, 4, 3, 1
> +	 */
> +	for (i =3D n - 1; i > 0; i--) {
> +		if (sizes[i - 1] < sizes[i] * 2) {
> +			seg.end =3D i + 1;
> +			bytes =3D sizes[i];
>  			break;
> +		}
> +	}
> =20
> -		min_seg.start =3D prev;
> -		min_seg.bytes +=3D sizes[prev];
> +	/*
> +	 * Find the starting table of the compaction segment by iterating
> +	 * through the remaining tables and keeping track of the accumulated
> +	 * size of all tables seen from the segment end table. The previous
> +	 * table is compared to the accumulated size because the tables from the
> +	 * segment end are merged backwards recursively.
> +	 *
> +	 * Note that we keep iterating even after we have found the first
> +	 * starting point. This is because there may be tables in the stack
> +	 * preceding that first starting point which violate the geometric
> +	 * sequence.
> +	 *
> +	 * Example compaction segment start set to table with size 32:
> +	 * 	128, 32, 16, 8, 4, 3, 1
> +	 */
> +	for (; i > 0; i--) {
> +		uint64_t curr =3D bytes;
> +		bytes +=3D sizes[i - 1];
> +
> +		if (sizes[i - 1] < curr * 2) {
> +			seg.start =3D i - 1;
> +			seg.bytes =3D bytes;
> +		}
>  	}
> =20
> -	reftable_free(segs);
> -	return min_seg;
> +	return seg;
>  }
> =20
>  static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack =
*st)
> diff --git a/reftable/stack.h b/reftable/stack.h
> index d919455669e..656f896cc28 100644
> --- a/reftable/stack.h
> +++ b/reftable/stack.h
> @@ -33,12 +33,9 @@ int read_lines(const char *filename, char ***lines);
> =20
>  struct segment {
>  	size_t start, end;
> -	int log;
>  	uint64_t bytes;
>  };
> =20
> -int fastlog2(uint64_t sz);
> -struct segment *sizes_to_segments(size_t *seglen, uint64_t *sizes, size_=
t n);
>  struct segment suggest_compaction_segment(uint64_t *sizes, size_t n);
> =20
>  #endif
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 7336757cf53..21541742fe5 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -717,59 +717,13 @@ static void test_reftable_stack_hash_id(void)
>  	clear_dir(dir);
>  }
> =20
> -static void test_log2(void)
> -{
> -	EXPECT(1 =3D=3D fastlog2(3));
> -	EXPECT(2 =3D=3D fastlog2(4));
> -	EXPECT(2 =3D=3D fastlog2(5));
> -}
> -
> -static void test_sizes_to_segments(void)
> -{
> -	uint64_t sizes[] =3D { 2, 3, 4, 5, 7, 9 };
> -	/* .................0  1  2  3  4  5 */
> -
> -	size_t seglen =3D 0;
> -	struct segment *segs =3D
> -		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
> -	EXPECT(segs[2].log =3D=3D 3);
> -	EXPECT(segs[2].start =3D=3D 5);
> -	EXPECT(segs[2].end =3D=3D 6);
> -
> -	EXPECT(segs[1].log =3D=3D 2);
> -	EXPECT(segs[1].start =3D=3D 2);
> -	EXPECT(segs[1].end =3D=3D 5);
> -	reftable_free(segs);
> -}
> -
> -static void test_sizes_to_segments_empty(void)
> -{
> -	size_t seglen =3D 0;
> -	struct segment *segs =3D sizes_to_segments(&seglen, NULL, 0);
> -	EXPECT(seglen =3D=3D 0);
> -	reftable_free(segs);
> -}
> -
> -static void test_sizes_to_segments_all_equal(void)
> -{
> -	uint64_t sizes[] =3D { 5, 5 };
> -	size_t seglen =3D 0;
> -	struct segment *segs =3D
> -		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
> -	EXPECT(seglen =3D=3D 1);
> -	EXPECT(segs[0].start =3D=3D 0);
> -	EXPECT(segs[0].end =3D=3D 2);
> -	reftable_free(segs);
> -}
> -
>  static void test_suggest_compaction_segment(void)
>  {
> -	uint64_t sizes[] =3D { 128, 64, 17, 16, 9, 9, 9, 16, 16 };
> -	/* .................0    1    2  3   4  5  6 */
> +	uint64_t sizes[] =3D { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
>  	struct segment min =3D
>  		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
> -	EXPECT(min.start =3D=3D 2);
> -	EXPECT(min.end =3D=3D 7);
> +	EXPECT(min.start =3D=3D 1);
> +	EXPECT(min.end =3D=3D 10);
>  }
> =20
>  static void test_suggest_compaction_segment_nothing(void)
> @@ -880,6 +834,17 @@ static void test_empty_add(void)
>  	reftable_stack_destroy(st2);
>  }
> =20
> +static int fastlog2(uint64_t sz)
> +{
> +	int l =3D 0;
> +	if (sz =3D=3D 0)
> +		return 0;
> +	for (; sz; sz /=3D 2) {
> +		l++;
> +	}

Nit: we could drop the curly braces while at it.

> +	return l - 1;
> +}
> +
>  static void test_reftable_stack_auto_compaction(void)
>  {
>  	struct reftable_write_options cfg =3D { 0 };
> @@ -1068,7 +1033,6 @@ static void test_reftable_stack_compaction_concurre=
nt_clean(void)
>  int stack_test_main(int argc, const char *argv[])
>  {
>  	RUN_TEST(test_empty_add);
> -	RUN_TEST(test_log2);
>  	RUN_TEST(test_names_equal);
>  	RUN_TEST(test_parse_names);
>  	RUN_TEST(test_read_file);
> @@ -1088,9 +1052,6 @@ int stack_test_main(int argc, const char *argv[])
>  	RUN_TEST(test_reftable_stack_update_index_check);
>  	RUN_TEST(test_reftable_stack_uptodate);
>  	RUN_TEST(test_reftable_stack_validate_refname);
> -	RUN_TEST(test_sizes_to_segments);
> -	RUN_TEST(test_sizes_to_segments_all_equal);
> -	RUN_TEST(test_sizes_to_segments_empty);
>  	RUN_TEST(test_suggest_compaction_segment);
>  	RUN_TEST(test_suggest_compaction_segment_nothing);
>  	return 0;
> diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> index 434044078ed..b95626549e7 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -293,7 +293,7 @@ test_expect_success 'ref transaction: writes cause au=
to-compaction' '
>  	test_line_count =3D 1 repo/.git/reftable/tables.list &&
> =20
>  	test_commit -C repo --no-tag A &&
> -	test_line_count =3D 2 repo/.git/reftable/tables.list &&
> +	test_line_count =3D 1 repo/.git/reftable/tables.list &&
> =20
>  	test_commit -C repo --no-tag B &&
>  	test_line_count =3D 1 repo/.git/reftable/tables.list
> @@ -308,12 +308,24 @@ test_expect_success 'ref transaction: environment v=
ariable disables auto-compact
>  	do
>  		GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C repo update-ref bran=
ch-$i HEAD || return 1
>  	done &&
> -	test_line_count =3D 23 repo/.git/reftable/tables.list &&
> +	test_line_count =3D 22 repo/.git/reftable/tables.list &&
> =20
>  	git -C repo update-ref foo HEAD &&
>  	test_line_count =3D 1 repo/.git/reftable/tables.list
>  '
> =20
> +test_expect_success 'ref transaction: alternating table sizes are compac=
ted' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	test_commit -C repo A &&
> +	for i in $(test_seq 20)

Nit: we could reduce the number of iterations here so that we don't have
to spawn 40 Git commands. Using something like 10 or even 5 iterations
should be sufficient to demonstrate the problem, no?

Patrick

--oeneywtiiNbPiQ9u
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYLsoUACgkQVbJhu7ck
PpTWUhAAjlMmjBQZuZxdbHZLkS/0hVq9SfmWgRNMLUpeGbEzhFKMCVdf0Cek6q6G
4qNDyTA/gHe5gF9ijB1gOUeINzOD9DreMl4N1VXGT/BSXyOH5IZGL7jbddvOsqtn
hoOXX4FiZ8mzyh6d4fS9SZisgZsAo0nEqi94qke6gWktwgixds46GO94YWLmcu+i
JxTYvrwP12PXi82Xl/kXkI9d1MFnYTg6NglxdBAu7oLXz8dgYoJDsZb9edifN7oX
P+0g0AoRizjL/8wA0RRuG5QY71ZiVBFmwobtksRA81dOJYmT2QulYmZ+1CW2D8Tk
PbTQNGqVegERieBr5uAFYE4Itz2upG9o4cZCI+U1TJwQa8zyYOZhw8kwou/QbvKa
qCATRqpYIezaOpHc2IaSZBx2MCKl6a3AywUSh46azJv/Akl8mhPKkab2osA6qUWY
NuoXBtXuNVA4B2j/eyYfc8JDdirHecnnHkFudNZL/00/LXnVIgAZsWJn8cAEMO40
uxWhErYROsvHJcKkPKSMsArYjIZxYJ+iOcQWaRVDGIWW86SR+QrLUb0AhDwb3J/j
2HOpC5cPoN+YSFaVB7Dr7f120DOK4DVq92O6hfky0s/V6dEq09e86G/JvrSixZ/O
eDvRCCfvVn9S43j7E8Z9byckWpnG6ykP6RCnJ5qODGktxBkWBp8=
=6ETG
-----END PGP SIGNATURE-----

--oeneywtiiNbPiQ9u--
