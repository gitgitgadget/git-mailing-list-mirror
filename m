Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75FF79FD
	for <git@vger.kernel.org>; Thu,  2 May 2024 06:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632420; cv=none; b=lzSkENSbYd0zN12eF4zfhi5CInnPLJPR24oM0HkNRI0ywL+Fqsnzh1+l8mSFV7im094AyRSiFqI8pF6J/Afo7VYhnJY1UO6DnwAl56OGweqngVEtNDwWdygA8Vkz6xDdu5KZTw+V5fxt36RVVsfiN5GIwme6BxYjqZL45ia63pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632420; c=relaxed/simple;
	bh=4PvTFmrMG7eSQXefdpT5qKtoQ5KdtklCiNY60uBm1Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mfj6qE5b/VlbZGIng4Xr7YmmSzJuZisdNvhmHr/1OpEp6r07he8SIaoV79bhRXMfg+mvRQUBDWfis/mX0VlhiHnwEFxuO4b2FvEIlXq/qPAMiQT8DHIs5mJ8F+htbyazgOr7QuiMbHSmJ1lZLVAaWrpG+OJbhmjKYGvgu4tUgFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hu5nydnf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IrvXWMan; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hu5nydnf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IrvXWMan"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EE6C21140078;
	Thu,  2 May 2024 02:46:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 May 2024 02:46:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714632417; x=1714718817; bh=bAXIsfmJHe
	AiijSNCGauvDasUbDyvUxEwGfbogsWi2A=; b=hu5nydnfDtUmSz2ZzTTNMnwbnv
	akPXUF2Tu8gT+PgyfxMLE8mIb2f8z1xr1AcYJRfy+255CH1V874cSVpHv6RJshCk
	BPTEBOveEmVdHWvhDSb3C5G0kwOhHHzxpuFr2c6Vh6+wASsgPxauCiRnYtUHgQ8O
	3aWfa0wABwNE3FIbNVlW76xVvR+iZVPyC0MftdyCpaBvVO9IjtLqnZwTen390ac/
	yU3zoEM/53JGDjkni9p+aF59woLSS2yna/hJGgd2W22LpV734yooKVZyR7rec/bp
	IEvJFErHwH3K7C9f1cZdzLjfOh4I0mO0mMH3latUiOhCh6xk8V7BR3faG6Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714632417; x=1714718817; bh=bAXIsfmJHeAiijSNCGauvDasUbDy
	vUxEwGfbogsWi2A=; b=IrvXWMan3G2IqOz/D2LfrSjsBfjIl1TPqGS/3e13iqn2
	otHnlu+xjfVYdgKUCs65adO4z+MFThAtgXfCIw8EmwJ1Y681HmXxWyaJ2a79AtYL
	r/dJe9cX17EQNX2G1RCps0nU+4wXyWp9JvPru3xH2tzdo6PRKcU9O+d0dVOxwc1x
	ZlCQc1LoNSAmLLLZOug5BQW/NJa2cSAZl9kbyZt22ZekKXAa0CSUqp8DyydVsRcS
	DJQve1mwykzD35Y0Ska/gNANxRKLS2cdjmqAw0xEjLVg95sMb52xC9hQYMppOqMp
	lifEiy5ayf8dIf06t175z8UosrLXamWArW+ty0KssA==
X-ME-Sender: <xms:4TYzZqA82P0QmVdB8KkssXG6gJWkIY_ppqhGQX2oGkdUBM4Kw9RdIA>
    <xme:4TYzZkis_0brqR3avQRzkPvW_0uwsh5T2k6bZvsr0LODYc0zj_G5icvPXJLnE9ObJ
    _j3_LzAee4CVtt4IQ>
X-ME-Received: <xmr:4TYzZtliZSkRx8x5Uz_8Oa25TKivrh8q0KSoXEBXcakpsEUPgyHShVf3Zq4Gwiv9lrDGGW3LYHngJ-BeNbmwRj7eoxw_ORbnGMniHK4jm49xUrU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeiveektdfggfeluefgvdelvdeftdfhgeeugeefveejleeufeekgeefffehgfel
    gfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4TYzZox46Uk1mzv8wXXA8prJgcJaPc6fME8zZRItGiqdUeGgVK96OA>
    <xmx:4TYzZvTfCQBXA0FuPgkMPQeVA7k3A1L1mBwumdx4WfpfKdAw_ZSQvQ>
    <xmx:4TYzZjYvQHHxCY1DqWDUS_ejiZDB9HGJ_CPaoitr_ulM8AkdVeF30w>
    <xmx:4TYzZoQvJK_7pDs78BEzYs7kDKZUtt7YXZMX0UCkMYAw9w7pKyXN5g>
    <xmx:4TYzZpcFD7mSpe9X_KogLqmewicVuTxWVICPxG8UHzJXaQlx7QqyV6P6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 02:46:56 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 8e0a9146 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 2 May 2024 06:46:30 +0000 (UTC)
Date: Thu, 2 May 2024 08:46:53 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] scalar: avoid segfault in reconfigure --all
Message-ID: <ZjM23X_Tf3pcWsIq@tanuki>
References: <pull.1724.git.1714496333004.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hfo3mnXaaFSupETY"
Content-Disposition: inline
In-Reply-To: <pull.1724.git.1714496333004.gitgitgadget@gmail.com>


--Hfo3mnXaaFSupETY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 04:58:52PM +0000, Derrick Stolee via GitGitGadget w=
rote:
> From: Derrick Stolee <stolee@gmail.com>
>=20
> During the latest v2.45.0 update, 'scalar reconfigure --all' started to
> segfault on my machine. Breaking it down via the debugger, it was
> faulting on a NULL reference to the_hash_algo, which is a macro pointing
> to the_repository->hash_algo.
>=20
> This NULL reference appears to be due to the way the loop is abusing the
> the_repository pointer, pointing it to a local repository struct after
> discovering that the current directory is a valid Git repository. This
> repo-swapping bit was in the original implementation from 4582676075
> (scalar: teach 'reconfigure' to optionally handle all registered
> enlistments, 2021-12-03), but only recently started segfaulting while
> trying to parse the HEAD reference. This also only happens on the
> _second_ repository in the list, so does not reproduce if there is only
> one registered repo.

Interesting. This also has some overlap with my patch series that aims
to drop the default-SHA1 fallback that we have in place for
`the_repository` [1].

> Add a test to t9210-scalar.sh to test 'scalar reconfigure --all' with
> multiple registered repos, as a precaution. Unfortunately, I was unable
> to reproduce the segfault using this test, so there is some coverage
> left to be desired. What exactly causes my setup to hit this bug but not
> this test structure? Unclear.

One way to trigger _a_ BUG is to use an "includeIf.onbranch:foobar.path"
config. This will cause Git to try and look up the "HEAD" reference, but
because we have a partially-configured repository, only, that will crash
with:

    BUG: refs.c:2123: reference backend is unknown

Whether that bug is the one that you have seen I cannot tell. It at
least does not sound like it.

    test_expect_success 'scalar reconfigure --all with includeIf.onbranch' '
        repos=3D"two three four" &&
        for num in $repos
        do
            git init $num/src &&
            scalar register $num/src &&
            git -C $num/src config includeif."onbranch:foo".path something =
&&
            git -C $num/src config core.preloadIndex false || return 1
        done &&

        scalar reconfigure --all &&

        for num in $repos
        do
            test true =3D "$(git -C $num/src config core.preloadIndex)" || =
return 1
        done
    '

Another issue, which is likely the one you report here, is if you have a
repository with detached "HEAD". In that case we use `get_oid_hex()` to
parse "HEAD", which will implicitly use `the_hash_algo`. But because you
unset it in the second round this will fail with a segfault when you try
to access it:

    ./test-lib.sh: line 1069: 583995 Segmentation fault      (core dumped) =
scalar reconfigure --all

This is the following testcase:

    test_expect_success 'scalar reconfigure --all with detached HEADs' '
        repos=3D"two three four" &&
        for num in $repos
        do
            rm -rf $num/src &&
            git init $num/src &&
            scalar register $num/src &&
            git -C $num/src config core.preloadIndex false &&
            test_commit -C $num/src initial &&
            git -C $num/src switch --detach HEAD || return 1
        done &&

        scalar reconfigure --all &&

        for num in $repos
        do
            test true =3D "$(git -C $num/src config core.preloadIndex)" || =
return 1
        done
    '

This issue should be fixed by my patch series in [1] because we start to
use `get_oid_hex_any()` to parse detached HEADs.

Anyway, your fix is indeed effective because with `repo_init()` we now
properly configure the repository.

[1]: https://lore.kernel.org/git/cover.1714371422.git.ps@pks.im/

Patrick

--Hfo3mnXaaFSupETY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYzNtwACgkQVbJhu7ck
PpS5bA/+IcQtFSxDt1JePdYBjVdjtoiUMWAVznuvyjfqd28QZiE1qs23F5nOaS+6
4hUNhWoZWEXawhK8JsgYek+9O3Ml1aUb5+jm5kEE9dsbNSjWv3YcpEEiWkFV7q9o
8LaZgDWaHVaTTbZf9abJzRDljBceTvCmpgnMWvYxHlFTrB8WLrwA9DrU861cbQnr
FMk818xla8HwTw0J4VkTl/8buMsCNTBLZ4ThSQ65N1c7hKPUDX7rC5eUMoQ18EiN
g23QpgOAdXsU0TXgJIu548sXKeTSpovlB46IIeoMG2K6m0yKg+/g0wzLjgqS3OqA
fhSFWnYj9LsDvr5Cj/SAJLu5kRmSB4LeIAzoEH6Y6uSzGA3guiH4YdOOqH9x3dtz
2467jIQEb0s0YaWhtsECtR5m5i/UHU5EJitwxe5q+fxIAKRu0vA3R8KhYet9Wwu5
Yx0GwGduvuhB4l2E2Yqfc7oFkWep/uTZOIoB3O4QGXKyfOFKRx/o1DYbcSJvVryv
vcZTlK/CA7i1nhFK3BlD5QmMc1Oo7MTxED5s1YSoFzm0cJi+5wLU5g0iMxhX0bjT
4sN67mY4LJouuF9THz0PyyS24uXkNdKZ9Klb3+c7Wuu042fe8ji5B26TvrUgkR5I
5tw+GqrJ0EOxuZwI6qdPaxpbTXwoEN+h+BQm+qE500RQpJma7Dg=
=b0ns
-----END PGP SIGNATURE-----

--Hfo3mnXaaFSupETY--
