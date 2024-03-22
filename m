Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568E28F3
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 01:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070726; cv=none; b=d7X71vGjgtrcam4jXeyy+JD0hAoa5mL1n2IizqstcLqQ9Q+AMqnTcoTLKe3HNrl7KHq5vwGZMUyHDZaf5rYyt9DmAClYm4N8RijDA2EsiRRVNgaOHGMfbAWLd0J1nyVYMTcgv3BLL71XJBkny7UXhNCm2suyZTMXN+eGfRsOJhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070726; c=relaxed/simple;
	bh=gfl6Yji2FN4KIq1yMTdZNXpkD+tLngHkimw4Y3/c23g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hi3bsh2GK34z1aqPFpsy+VWgxxNaN2YinC212/agvljSHQLr4Q2ncGDjR57vLT1gA0C9ssp+BKput7JIaC3VQUuDDWLW8LBcb5i7F6im02/jOQrU+qQoFwy1a1OhM/oheZXh5qAhr0+0rQiBgkeHCje2ybocgWdJVwyxely/ipI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lTdzirYk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aDPeqbLR; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lTdzirYk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aDPeqbLR"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id AD0021380100;
	Thu, 21 Mar 2024 21:25:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Mar 2024 21:25:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711070722; x=1711157122; bh=8iaM8S9ET6
	/oCqq7dKzotxkzT8AHdAkKgXqQN5ckn7Q=; b=lTdzirYkXKxBsDF2mVg/WhAHAY
	54l2ST8BZeZ4zO4g4q8wzFnkYW6vAmBvkhZbsr723SDkLZoOpHg7Cu4yq5asjCE1
	5D6aIiW1NVV9rtpctX/MyIF6GV2Z+7b8/UgN8C8Q1BH/3ucGXgzCEyOGZCBlFevp
	tlkUbphnXkTQk1HYlM8KUBj8PEiskZZe4fF1E1XmY3YkqJc82Au/CPV4qkLGPcC3
	7xewDZFvd/eVlWDnsWniORZ92PD2f7L0wEqFm0TzCskzxH7iXHi4prJa7i4s2ejG
	KpVRhPoEJab0Nihh7mbEeFRGf2ud9K3IoOHhOMXVDFftF+A6nGH8oPejzXFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711070722; x=1711157122; bh=8iaM8S9ET6/oCqq7dKzotxkzT8AH
	dAkKgXqQN5ckn7Q=; b=aDPeqbLR7IRIMx65Zqr4CYcp5dJS2VAmOSKlMc5G7uLE
	a22c/lIbkPEYng7P/IFghAEoyQMvYtWdgk7yItX9KttpDlDSysgo+puYdvY9DGWW
	Vf4QYF4vIH374arMhqHcOt8X3ehcPbtMIM89zdUGSdAl7vQqAgppkkY/LGxMKJO3
	c158Hdwrb0m76OEEJH43rhqtz7BmwxYxajKaYXC8p/9OAiX9ww8lsacmwcmU/JIF
	ZOT4SHEPPQHtZs23PmMIgr143cgh0KRPMrv/1hXQ+aW174gw3v9Q0pYqapXXFzoh
	qFltjbDqqAPmZ1/M9Tn1/T7vojKWmg+HqtR8EgJJ5Q==
X-ME-Sender: <xms:At78ZUws2_mV_2uIz_qNUDyn6DBwy7Z30DWUYmyxTsT5HkePB-3SwA>
    <xme:At78ZYRAJFK4C6nASqWNirpT_rOCivClLl45LBIA0aFjPgiUWclot8xWgaiibPZiT
    9ZKW2yJI2iu3TkjzQ>
X-ME-Received: <xmr:At78ZWVodnSrNpJUEXa63UhUNsNAagEbofCCswcB99iscuu-52tg_dpVE-tEPvn6e2xZjfW-NdBQ1-BTyU_QZ7Jz3GizxDDqG8LcoqwmM-IRVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeetueevhffhudefvdegieeuieelgedthfegfedtueevjeejtdfgjeehudejuedtuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:At78ZSidNBDsy-KbTlYX73oh4fr2bHBIDG4DetPeD0rVshvQEAiTog>
    <xmx:At78ZWCevPiEUbWnnQSUrFRmVD6nFlAwkSMIv-CkRfbRYj61p0LLYA>
    <xmx:At78ZTJLACCGisWhNMDaYxm9TetFMFQ9-TW1aGsrCn4S03ODSMEe7Q>
    <xmx:At78ZdCBZAQTZ8ITrZcnFnRuQ72RTJbByk23xnEU5BGypzVuayQkyQ>
    <xmx:At78ZZ96lkXtyFEMmQBMScJucmQgHO_nMBPV8D5203TFpBgcCKSJXA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 21:25:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id edd02ef3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 01:25:17 +0000 (UTC)
Date: Fri, 22 Mar 2024 02:25:19 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 2/3] reftable/stack: use geometric table compaction
Message-ID: <Zfzd_yxeXWWTJdyP@tanuki>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <def7008452303f71c1fa469609bc199c629a19ec.1711060820.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EEBvjK/IkZciiCam"
Content-Disposition: inline
In-Reply-To: <def7008452303f71c1fa469609bc199c629a19ec.1711060820.git.gitgitgadget@gmail.com>


--EEBvjK/IkZciiCam
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:40:18PM +0000, Justin Tobler via GitGitGadget wr=
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
> each operation. This is done by walking the table list in reverse index
> order to identify the compaction segment start and end. The compaction
> segment end is found by identifying the first table which has a
> preceding table size less than twice the current table. Next, the
> compaction segment start is found iterating through the remaining tables
> in the list checking if the previous table size is less than twice the
> cumulative of tables from the segment end. This ensures the correct
> segment start is found and that the newly compacted table does not
> violate the geometric sequence.

I don't think we need to go into so much detail how exactly the
algorithm is working -- these kind of comments should ideally exist in
the code. What would be more interesting to explain here is _why_ we
chose the new algorithm over the old one instead of just trying to fix
the issue.

Other than that this patch LGTM.

Patrick

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
>  reftable/stack.c           | 109 ++++++++++++++++---------------------
>  reftable/stack.h           |   3 -
>  reftable/stack_test.c      |  66 +++++-----------------
>  t/t0610-reftable-basics.sh |  43 ++++++++++-----
>  4 files changed, 91 insertions(+), 130 deletions(-)
>=20
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 2370d93d13b..ef55dc75cde 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -1214,75 +1214,62 @@ static int segment_size(struct segment *s)
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
> +	 */
> +	for (i =3D n - 1; i > 0; i--) {
> +		if (sizes[i - 1] < sizes[i] * 2) {
> +			seg.end =3D i + 1;
> +			bytes =3D sizes[i];
>  			break;
> +		}
> +	}
> +
> +	/*
> +	 * Find the starting table of the compaction segment by iterating
> +	 * through the remaining tables and keeping track of the accumulated
> +	 * size of all tables seen from the segment end table.
> +	 *
> +	 * Note that we keep iterating even after we have found the first
> +	 * starting point. This is because there may be tables in the stack
> +	 * preceding that first starting point which violate the geometric
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
> index 509f4866236..e5f6ff5c9e4 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -720,59 +720,14 @@ static void test_reftable_stack_hash_id(void)
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
> +	uint64_t sizes[] =3D { 512, 64, 17, 16, 9, 9, 9, 16, 2, 16 };
>  	/* .................0    1    2  3   4  5  6 */
>  	struct segment min =3D
>  		suggest_compaction_segment(sizes, ARRAY_SIZE(sizes));
> -	EXPECT(min.start =3D=3D 2);
> -	EXPECT(min.end =3D=3D 7);
> +	EXPECT(min.start =3D=3D 1);
> +	EXPECT(min.end =3D=3D 10);
>  }
> =20
>  static void test_suggest_compaction_segment_nothing(void)
> @@ -884,6 +839,17 @@ static void test_empty_add(void)
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
> +	return l - 1;
> +}
> +
>  static void test_reftable_stack_auto_compaction(void)
>  {
>  	struct reftable_write_options cfg =3D { 0 };
> @@ -1072,7 +1038,6 @@ static void test_reftable_stack_compaction_concurre=
nt_clean(void)
>  int stack_test_main(int argc, const char *argv[])
>  {
>  	RUN_TEST(test_empty_add);
> -	RUN_TEST(test_log2);
>  	RUN_TEST(test_names_equal);
>  	RUN_TEST(test_parse_names);
>  	RUN_TEST(test_read_file);
> @@ -1092,9 +1057,6 @@ int stack_test_main(int argc, const char *argv[])
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
> index 686781192eb..e6c3f94d874 100755
> --- a/t/t0610-reftable-basics.sh
> +++ b/t/t0610-reftable-basics.sh
> @@ -293,12 +293,24 @@ test_expect_success 'ref transaction: writes cause =
auto-compaction' '
>  	test_line_count =3D 1 repo/.git/reftable/tables.list &&
> =20
>  	test_commit -C repo --no-tag A &&
> -	test_line_count =3D 2 repo/.git/reftable/tables.list &&
> +	test_line_count =3D 1 repo/.git/reftable/tables.list &&
> =20
>  	test_commit -C repo --no-tag B &&
>  	test_line_count =3D 1 repo/.git/reftable/tables.list
>  '
> =20
> +test_expect_success 'ref transaction: alternating table sizes are compac=
ted' '
> +	test_when_finished "rm -rf repo" &&
> +	git init repo &&
> +	test_commit -C repo A &&
> +	for i in $(test_seq 20)
> +	do
> +		git -C repo branch -f foo &&
> +		git -C repo branch -d foo || return 1
> +	done &&
> +	test_line_count =3D 2 repo/.git/reftable/tables.list
> +'
> +
>  check_fsync_events () {
>  	local trace=3D"$1" &&
>  	shift &&
> @@ -324,7 +336,7 @@ test_expect_success 'ref transaction: writes are sync=
ed' '
>  		git -C repo -c core.fsync=3Dreference \
>  		-c core.fsyncMethod=3Dfsync update-ref refs/heads/branch HEAD &&
>  	check_fsync_events trace2.txt <<-EOF
> -	"name":"hardware-flush","count":2
> +	"name":"hardware-flush","count":4
>  	EOF
>  '
> =20
> @@ -346,8 +358,8 @@ test_expect_success 'pack-refs: compacts tables' '
> =20
>  	test_commit -C repo A &&
>  	ls -1 repo/.git/reftable >table-files &&
> -	test_line_count =3D 4 table-files &&
> -	test_line_count =3D 3 repo/.git/reftable/tables.list &&
> +	test_line_count =3D 3 table-files &&
> +	test_line_count =3D 2 repo/.git/reftable/tables.list &&
> =20
>  	git -C repo pack-refs &&
>  	ls -1 repo/.git/reftable >table-files &&
> @@ -379,7 +391,7 @@ do
>  			umask $umask &&
>  			git init --shared=3Dtrue repo &&
>  			test_commit -C repo A &&
> -			test_line_count =3D 3 repo/.git/reftable/tables.list
> +			test_line_count =3D 2 repo/.git/reftable/tables.list
>  		) &&
>  		git -C repo pack-refs &&
>  		test_expect_perms "-rw-rw-r--" repo/.git/reftable/tables.list &&
> @@ -747,12 +759,13 @@ test_expect_success 'worktree: pack-refs in main re=
po packs main refs' '
>  	test_when_finished "rm -rf repo worktree" &&
>  	git init repo &&
>  	test_commit -C repo A &&
> -	git -C repo worktree add ../worktree &&
> +	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C repo worktree add ../=
worktree &&
> +	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C worktree update-ref r=
efs/worktree/per-worktree HEAD &&
> =20
> -	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> -	test_line_count =3D 4 repo/.git/reftable/tables.list &&
> +	test_line_count =3D 4 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> +	test_line_count =3D 3 repo/.git/reftable/tables.list &&
>  	git -C repo pack-refs &&
> -	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> +	test_line_count =3D 4 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
>  	test_line_count =3D 1 repo/.git/reftable/tables.list
>  '
> =20
> @@ -760,19 +773,21 @@ test_expect_success 'worktree: pack-refs in worktre=
e packs worktree refs' '
>  	test_when_finished "rm -rf repo worktree" &&
>  	git init repo &&
>  	test_commit -C repo A &&
> -	git -C repo worktree add ../worktree &&
> +	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C repo worktree add ../=
worktree &&
> +	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C worktree update-ref r=
efs/worktree/per-worktree HEAD &&
> =20
> -	test_line_count =3D 3 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> -	test_line_count =3D 4 repo/.git/reftable/tables.list &&
> +	test_line_count =3D 4 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> +	test_line_count =3D 3 repo/.git/reftable/tables.list &&
>  	git -C worktree pack-refs &&
>  	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
> -	test_line_count =3D 4 repo/.git/reftable/tables.list
> +	test_line_count =3D 3 repo/.git/reftable/tables.list
>  '
> =20
>  test_expect_success 'worktree: creating shared ref updates main stack' '
>  	test_when_finished "rm -rf repo worktree" &&
>  	git init repo &&
>  	test_commit -C repo A &&
> +	test_commit -C repo B &&
> =20
>  	git -C repo worktree add ../worktree &&
>  	git -C repo pack-refs &&
> @@ -780,7 +795,7 @@ test_expect_success 'worktree: creating shared ref up=
dates main stack' '
>  	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
>  	test_line_count =3D 1 repo/.git/reftable/tables.list &&
> =20
> -	git -C worktree update-ref refs/heads/shared HEAD &&
> +	GIT_TEST_REFTABLE_NO_AUTOCOMPACTION=3Dtrue git -C worktree update-ref r=
efs/heads/shared HEAD &&
>  	test_line_count =3D 1 repo/.git/worktrees/worktree/reftable/tables.list=
 &&
>  	test_line_count =3D 2 repo/.git/reftable/tables.list
>  '
> --=20
> gitgitgadget
>=20

--EEBvjK/IkZciiCam
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX83f8ACgkQVbJhu7ck
PpS+GQ/+JZO4cJKdDTC+/UMsiey61nwoB4zV2BZYQZGP2ka9YamR0eL46RyliQcy
Q5Z8UfGX3s9r3BKO2+h6NesezG27X3jcn/Jetj3/NGcmwyooeTbNhWL6o6UO874L
wYZiKI7pRo0pKXrXontAindAzM2wTfWrNfo4rlrK0KnrlMAaYi08BP1yr6iKgpL9
ai2EysuwbHAjUNmNbzy1BQs4KRNBiXZ2zjWS01VpKBfcL1NX8YblJyIT8Zjr0Ovh
KayUENw+S128/hjrBVzP47sqrOPTGpTpToofFJTgWJC/CUMb/q2oLKiS8DtZhBU0
6plyD1llBh2sUDEqo7EcDGY/hpcjq05zAeh9PbLhPBOo9+rSA3Cvxe0tSXQUKUav
EcVPyt2crvWS9lx/buY0nTTtQHvCg2RFO5G7VFZB7txvhnh/3opyLhS09hp73sXO
eJTXhSUT/T0JeTgP/mb49EaGB/ZDl5tqCzPnIa6aNqxtfGa68AXjcfjGMINaMmBh
rfH6e16nFJyjtL1ykbSU899HaPFedWLRQBkn50XsSJoIHMD7P+nqTbQgzd7tsChL
4aWprYnVbYuZ/lqwq5XY2P/XE+Iht3vYD+u04feOPFf6FfDXtOs1kOP65F/OpYJ+
NZItN/zeON1+oLVNvJKyS95MlPMEZf5nJMnlLudLjHsB9NMGFhQ=
=utYP
-----END PGP SIGNATURE-----

--EEBvjK/IkZciiCam--
