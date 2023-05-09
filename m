Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81AA6C7EE23
	for <git@archiver.kernel.org>; Tue,  9 May 2023 15:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjEIPPv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 11:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235631AbjEIPPt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 11:15:49 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D8A44AF
        for <git@vger.kernel.org>; Tue,  9 May 2023 08:15:47 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 3C8E35C0246;
        Tue,  9 May 2023 11:15:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 09 May 2023 11:15:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1683645347; x=1683731747; bh=4I
        I3D0BpriB74xCF8ebVaSzKEGaIcUECImTdkKr5xuQ=; b=HTEg26iwnRZoQ77Sab
        ERdYQabgzRqDCHIgGWMfP5nH3T4EwCv1wvjRVFp+Z9bEcF3mD+oVf1Gtaxjg9Ss+
        SWGkeaoHkHfl4wMu5OzYIvhoq/zYRbPpGMhmIhn/yAy/mz23JOnBj24HXekVF484
        X3u5HySkziNnVUEf78BdrUSfKtNThTS6+ONW5z0y8xMBkLWKtoDx9WtZ4i9oLSEy
        OFtCWona5qqGAyFLQnEmbMJyHX90CZOBf2kb5JjJykosNkTfW3VgIl67gUYmYjML
        QfuEXD3gLJtazm++C6qQCKBHBBndbAHNkBYqraOWLdriuzfiazJlux1uW2Pg/KCG
        doIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1683645347; x=1683731747; bh=4II3D0BpriB74
        xCF8ebVaSzKEGaIcUECImTdkKr5xuQ=; b=LTm01jAD95ob6Rp1dbzE8CndobR/N
        bKEzKlaNypwtipBY0O5SnqqGu64IMowhc0e6b/WJK3Wt712NQH1YyzQwBVuwcgG5
        iJNZ/ZUvHBb/Qv0JsQDVui5Y6eklr5KqGd/ojfIVQCNs8bZqAEI8qDq5NXr6zVtc
        EdGJhiojYi3nhF1Qzemm9Gc/QTSUZKlUYH0M4xwXpTjLsSjAHkiFL7ryTvGX3IaZ
        6NuduHhO8cl0gUJwYdR+xott3ypsuJ1pICYQrH8opYFSQMbFm2XvJjaa3Y2lUfu1
        8q0Ok3STi9gFeVs89laB1ufRZep2+Jn9LsKYB6oz5cjkU5oCi1gmCGNqw==
X-ME-Sender: <xms:omNaZORm9F0JRuyQqQ5grUtYVnH7-h136G-DpZXXrKtyfrveUeKrwA>
    <xme:omNaZDzDpm_-OCiM2YkaU0Tu8hClFm5griSEWK3zUiQFdufvSYTphX5q13CA5xbmo
    FclKqlomT81qn54jg>
X-ME-Received: <xmr:omNaZL1gGViWnT4XzHSWqpPah30XxCLhZIiiEceMxtK5VHLV_BXQbWRVh0Dvx0BGAlhy0LaYTKv0lomLV5G_5DoJMGbIMmK0mml880W33Lk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeguddguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:omNaZKBq16iHZCqDA61KgSbeVYRlClsLcFZbVDm7bRL9MYDnQXTUfw>
    <xmx:omNaZHjqR7UZ7hIjW7YO17QkDFv2jMWVZULGNl7y7sAeMyf66yiEPw>
    <xmx:omNaZGpBzYPqgLfgLhsD01mqWwG8i2rSeXWxGwNBG8PNktY-O9xxlA>
    <xmx:o2NaZEuqEKmvKwJV-EA56xY-TU5mFuPTo-5kvyBHjraJqVgT4rh5aQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 May 2023 11:15:45 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f0eb5d2c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 9 May 2023 15:15:37 +0000 (UTC)
Date:   Tue, 9 May 2023 17:15:43 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 09/15] refs/packed-backend.c: implement skip lists to
 avoid excluded pattern(s)
Message-ID: <ZFpjn-vjP6H_v_KD@ncase>
References: <cover.1683581621.git.me@ttaylorr.com>
 <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2qeH+lY6yiwLatI8"
Content-Disposition: inline
In-Reply-To: <a39d1107c1f3e9fbd859a23aed72e63bbd394fa2.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2qeH+lY6yiwLatI8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 06:00:08PM -0400, Taylor Blau wrote:
> When iterating through the `packed-refs` file in order to answer a query
> like:
>=20
>     $ git for-each-ref --exclude=3Drefs/__hidden__
>=20
> it would be useful to avoid walking over all of the entries in
> `refs/__hidden__/*` when possible, since we know that the ref-filter
> code is going to throw them away anyways.
>=20
> In certain circumstances, doing so is possible. The algorithm for doing
> so is as follows:
>=20
>   - For each excluded pattern, find the first record that matches it,
>     and the first pattern that *doesn't* match it (i.e. the location
>     you'd next want to consider when excluding that pattern).
>=20
>   - Sort the patterns by their starting location within the
>     `packed-refs` file.
>=20
>   - Construct a skip list of regions by combining adjacent and
>     overlapping regions from the previous step.
>=20
>   - When iterating through the `packed-refs` file, if `iter->pos` is
>     ever contained in one of the regions from the previous steps,
>     advance `iter->pos` past the end of that region, and continue
>     enumeration.
>=20
> Note that this optimization is only possible when none of the excluded
> pattern(s) have special meta-characters in them. To see why this is the
> case, consider the exclusion pattern "refs/foo[a]". In general, in order
> to find the location of the first record that matches this pattern, we
> could only consider up to the first meta-character, "refs/foo". But this
> doesn't work, since the excluded region we'd come up with would include
> "refs/foobar", even though it is not excluded.

Is this generally true though? A naive implementation would iterate
through all references and find the first reference that matches the
exclusion regular exepression. From thereon we continue to iterate until
we find the first entry that doesn't match. This may cause us to end up
with a suboptimal skip list, but the skip list would still be valid.

As I said, this implementation would be naive as we're now forced to
iterate through all references starting at the beginning. I assume that
your implementation will instead use a binary search to locate the first
entry that matches the exclusion pattern and the last pattern. But the
way this paragraph is formulated makes it sound like this is a general
fact, even though it is a fact that derives from the implementation.

I of course don't propose to change the algorithm here, but instead to
clarify where this restriction actually comes from and why the tradeoff
makes sense.

[snip]
> @@ -929,6 +972,108 @@ static struct ref_iterator_vtable packed_ref_iterat=
or_vtable =3D {
>  	.abort =3D packed_ref_iterator_abort
>  };
> =20
> +static int skip_list_entry_cmp(const void *va, const void *vb)
> +{
> +	const struct skip_list_entry *a =3D va;
> +	const struct skip_list_entry *b =3D vb;
> +
> +	if (a->start < b->start)
> +		return -1;
> +	if (a->start > b->start)
> +		return 1;
> +	return 0;
> +}
> +
> +static int has_glob_special(const char *str)
> +{
> +	const char *p;
> +	for (p =3D str; *p; p++) {
> +		if (is_glob_special(*p))
> +			return 1;
> +	}
> +	return 0;
> +}
> +
> +static const char *ptr_max(const char *x, const char *y)
> +{
> +	if (x > y)
> +		return x;
> +	return y;
> +}
> +
> +static void populate_excluded_skip_list(struct packed_ref_iterator *iter,
> +					struct snapshot *snapshot,
> +					const char **excluded_patterns)
> +{
> +	size_t i, j;
> +	const char **pattern;
> +
> +	if (!excluded_patterns)
> +		return;
> +
> +	for (pattern =3D excluded_patterns; *pattern; pattern++) {
> +		struct skip_list_entry *e;
> +
> +		/*
> +		 * We can't feed any excludes with globs in them to the
> +		 * refs machinery.  It only understands prefix matching.
> +		 * We likewise can't even feed the string leading up to
> +		 * the first meta-character, as something like "foo[a]"
> +		 * should not exclude "foobar" (but the prefix "foo"
> +		 * would match that and mark it for exclusion).
> +		 */
> +		if (has_glob_special(*pattern))
> +			continue;
> +
> +		ALLOC_GROW(iter->skip, iter->skip_nr + 1, iter->skip_alloc);
> +
> +		e =3D &iter->skip[iter->skip_nr++];
> +		e->start =3D find_reference_location(snapshot, *pattern, 0);
> +		e->end =3D find_reference_location_end(snapshot, *pattern, 0);

One thing that makes this hard to reason about is that we don't
explicitly handle the case where the pattern doesn't match at all. So
you require a bunch of knowledge about what exactly the functions
`find_reference_location()` and `find_reference_location_end()` do in
that case in order to determine whether we will end up doing the right
thing.

Explicitly handling this would give us some benefits:

- It makes the code more obvious.

- We can avoid an extra skip list entry for every non-matching
  pattern.

- We wouldn't have to perform binary search over the snapshot twice.

Might be I'm missing something though.

> +	}
> +
> +	if (!iter->skip_nr) {
> +		/*
> +		 * Every entry in exclude_patterns has a meta-character,
> +		 * nothing to do here.
> +		 */
> +		return;
> +	}
> +
> +	QSORT(iter->skip, iter->skip_nr, skip_list_entry_cmp);
> +
> +	/*
> +	 * As an optimization, merge adjacent entries in the skip list
> +	 * to jump forwards as far as possible when entering a skipped
> +	 * region.
> +	 *
> +	 * For example, if we have two skipped regions:
> +	 *
> +	 *	[[A, B], [B, C]]
> +	 *
> +	 * we want to combine that into a single entry jumping from A to
> +	 * C.
> +	 */
> +	for (i =3D 1, j =3D 1; i < iter->skip_nr; i++) {
> +		struct skip_list_entry *ours =3D &iter->skip[i];
> +		struct skip_list_entry *prev =3D &iter->skip[i - 1];
> +
> +		if (ours->start =3D=3D ours->end) {
> +			/* ignore empty regions (no matching entries) */
> +			continue;
> +		} else if (prev->end >=3D ours->start) {
> +			/* overlapping regions extend the previous one */
> +			prev->end =3D ptr_max(prev->end, ours->end);
> +		} else {
> +			/* otherwise, insert a new region */
> +			iter->skip[j++] =3D *ours;
> +		}
> +	}

Mh. Does this do the right thing in case we have multiple consecutive
overlapping skip list entries? We always end up adjusting the immediate
predecessor as we use `i - 1` to find `prev`. Shouldn't we instead start
with `j =3D 0` and assign `prev =3D &iter->skip[j]`?

[snip]
> diff --git a/t/t1419-exclude-refs.sh b/t/t1419-exclude-refs.sh
> new file mode 100755
> index 0000000000..da5265a5a8
> --- /dev/null
> +++ b/t/t1419-exclude-refs.sh
> @@ -0,0 +1,101 @@
> +#!/bin/sh
> +
> +test_description=3D'test exclude_patterns functionality in main ref stor=
e'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +for_each_ref__exclude () {
> +	test-tool ref-store main for-each-ref--exclude "$@" >actual.raw
> +	cut -d ' ' -f 2 actual.raw
> +}
> +
> +for_each_ref () {
> +	git for-each-ref --format=3D'%(refname)' "$@"
> +}
> +
> +test_expect_success 'setup' '
> +	test_commit --no-tag base &&
> +	base=3D"$(git rev-parse HEAD)" &&
> +
> +	for name in foo bar baz quux
> +	do
> +		for i in 1 2 3
> +		do
> +			echo "create refs/heads/$name/$i $base" || return 1
> +		done || return 1
> +	done >in &&
> +	echo "delete refs/heads/main" >>in &&
> +
> +	git update-ref --stdin <in &&
> +	git pack-refs --all
> +'
> +
> +test_expect_success 'for_each_ref__exclude(refs/heads/foo/)' '
> +	# region in middle
> +	for_each_ref__exclude refs/heads refs/heads/foo >actual &&
> +	for_each_ref refs/heads/bar refs/heads/baz refs/heads/quux >expect &&
> +
> +	test_cmp expect actual
> +'

Nit: it might be a bit more readable if we put the comment into the test
description instead of having an opaque description that mentions ref
names that don't have much of a meaning without reading the test itself.

Patrick

--2qeH+lY6yiwLatI8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmRaY54ACgkQVbJhu7ck
PpT2pQ//TQZjyGp7VF1/jkZ9Ymgqp59mmF76Nk/gKh78kdPaXJvtRGZlKY/EfgFR
EnlzJemBA/wdmI4fxqPF7uYLFV0PMbSNxrh/V9dgKzQntzNr1HJQ1yoexnVPGkoZ
NCIxTgtsy5s3U+2ExJlc0c6M6r1rAc8WzrxbnrAFwgYVOTeT77cK442hKS+KIGCZ
qBoikFyJaRe46WhrvYM/9ILhbcLcssh0W3fV84lds1hx2gHrBHlr2KfkE3vterML
i0pW9m5WuXVI0XIb+0Q6zevy8YMXrBPWyI7pP3TK6aIx55AWIC68HWHtONaqf48g
d8ZL/ku4iBJ3LA1En6LnePVsX5hhz6s2XSsIWXEM8IMM22ZBC4W0xpHK+W5ZU7n0
x5tZpMHj4fqTjNuCh1DP3W475Mn1RzcqEoBFVsRlXxG3IB/DozU3v9LOVaM0KUv5
WkeSQFyjVHxQZhv+HfxSg0+WN0hJNtiyVmwUAMLUFJGGcdor0zPj4bPYC6I+JjOW
lMEybiF8szr/vi0ZFlc6Zv/e0QMXsq/aMIHx7D1d26vF1Ivk2SPrSNprlJtRV2Z4
pwC37h9uvlsI+7V/0k++nFWbdQhHRf3/XUswyBCQ3qA/E2KgYz48cU8jBzuad6oe
Z/tDSN1tCi3uxn8HTvvRbgqLGRn7+zlGNE48UyPatRQ0E74rSjU=
=4k1V
-----END PGP SIGNATURE-----

--2qeH+lY6yiwLatI8--
