Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5106210A1D
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 04:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452853; cv=none; b=nhpiXEa+orhbvn5XT5yl+mHyy9nI82NP4NDb3yZHLmVwBIGxo4VDZTUz1ssEdFNL5DS+dEj+SvKBtjC1HeQAxjyOqrhVICJVxT9hC9xpnWfQze4eEOzcO0Eef9chTMrdQ62Gcj10TNb7woexlvNO8hql4XEQ7UcSQ5rUsC6GBnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452853; c=relaxed/simple;
	bh=qdq2VDa0j0glAAxQ5hQW2AhO9xdbC9r66Tap26VJQ4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jPNPI6WAqNbSzoJptg8EmnpkLypaA1sa1jmuh6OMGXcXxGdip6rrMiKHUcYtikSvGX2JVoJxtjB0C2sCOw9aJE+YiK82xMLIrdzCdIt1R6Cws+D6TQ1KbOenIbG9mQoT6McxPZ38W+dvVXn1JgXeZRWymrruRhrS61yXs7vagH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GCJzVjM2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ME7Y+ReK; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GCJzVjM2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ME7Y+ReK"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 2C7821380F71;
	Tue, 30 Apr 2024 00:54:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 30 Apr 2024 00:54:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714452850; x=1714539250; bh=RGzPGjkYfk
	STJAZ0v7m9tsTRZhF1M528zgGjvN6qW28=; b=GCJzVjM2FZKZoDKRsFK+pbjrlK
	tAX7psdp6m8a7ynpISQnQ3EQNliC0t+GpiINw5YJkTvOF4Qh3dBI9z8fT3PBH5hg
	mwM/o0yLgFBzFPVv0Xc+XDTNJv/OBRK8LV+ApT1eIueQ9cP++qUibsLrvVnrHTnn
	zttIbUyegYH8RbRCFOIF86f7yROmK6OaTR0+H47JXoBIQLFtBl2r7dmQ9shDecM4
	J9tfElARhF/vhlHVMfFL1cCRmbWYiw32o/VMs7Ouwd0Df5qoi+l6AkPjq1bnNYJf
	e6s0PosgKi64CBbtjrU9e0fLQHzgvtcN0lb4ZQFUCt5fUOje9PZhC7Z/g/Ww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714452850; x=1714539250; bh=RGzPGjkYfkSTJAZ0v7m9tsTRZhF1
	M528zgGjvN6qW28=; b=ME7Y+ReKvPLaqr/c8U+PlVGOwhj7k7Rt6q3f31/boJI1
	b8hnJYciPd515GVNJVjh16RgMAU386rzBr6/DRGjOdvyBiDQ3cWnZu8T5WNl6ogc
	o1qfnTkZhQhpTmdlGm6XspVy43nP0xMpciHdXhP7m55ZlXLktuNtYu6j/3f9FTyd
	2cVsbtc16qzxepICLZmnKcJzCdd3zBahNNiQnUaroBbE0FfxG+YEuwKzJzn1A5KQ
	5MAWBGfHNpNq44LCtkVEaebALEYUN3HJDXOiEUl7/m8QjPoYqRex31vTS++TAYdP
	IKDzhdhJIeDmZqAjKdKw+ygQCgKVuQts/OMmqwxsyg==
X-ME-Sender: <xms:cXkwZh_PNm1RqDaoG3BJ0cVruJ_RFFCNwkziVbVBMZLft-84X1ZXJw>
    <xme:cXkwZlsm9thu2OJsf6w26BqLUu1R2Dvf32Qaj_eAMY10OUs4seIhDhfJ4F50AEyTn
    Jdfp58-ls_F7axsBA>
X-ME-Received: <xmr:cXkwZvBuiMQcf0G1VDxfUCtbd6Sv_V20Ra5fWwB0RaWV8p8Jbc1RKi78RWbZv4ljnYKA2B-UtKbfK-wc4KuSUAzJvUsm2g03-WF7l7FAimu6Ub1x-LvZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:cnkwZldI5uvZdGrrwmLGA1nhtToGaoRutQ3ndfuXiu41zyQQi5zd9w>
    <xmx:cnkwZmO7grSBGDgY8CXTuv6E_EwKjHFykEwccK5t47t5JRrt5k8igw>
    <xmx:cnkwZnlXL2p7UiRvZXhCuMY4vmwlvoOSUkLggr3z_1Bwdio27Vqptg>
    <xmx:cnkwZguG6MKrir6zlcyFKqEcbocA3gporbfHFkqrAAS4jL1LSQCchA>
    <xmx:cnkwZvaxVsYEkK2krUNbo69SzWrdcYubl7FAVUUCP-qI87dsNGctzA3e>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 00:54:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c60815e2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 04:53:46 +0000 (UTC)
Date: Tue, 30 Apr 2024 06:54:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] check_refname_format(): add FULLY_QUALIFIED flag
Message-ID: <ZjB5bHiF5kAcRMpP@tanuki>
References: <20240429083325.GE233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mA/nyX48fo6s3vJs"
Content-Disposition: inline
In-Reply-To: <20240429083325.GE233423@coredump.intra.peff.net>


--mA/nyX48fo6s3vJs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:33:25AM -0400, Jeff King wrote:
> Before operating on a refname we get from a user, we usually check that
> it's syntactically valid. As a general rule, refs should be in the
> "refs/" namespace, the exception being HEAD and pseudorefs like
> FETCH_HEAD, etc. Those pseudorefs should consist only of all-caps and
> dash. But the syntactic rules are not enforced by check_refname_format().

s/dash/underscore, right?

> So for example we will happily operate on a ref "foo/bar" that will use
> the file ".git/foo/bar" under the hood (when using the files backend, of
> course).
>=20
> Making things even more complicated, refname_is_safe() does enforce
> these syntax restrictions! When that function was added in 2014, we
> would have refused to work with such refs entirely. But we stopped being
> so picky in 03afcbee9b (read_packed_refs: avoid double-checking sane
> refs, 2015-04-16). That rationale there is that check_refname_format()
> is supposed to contain a superset of the checks of refname_is_safe().
> The idea being that we usually would rely on the more-strict
> check_refname_format(), but for certain operations (e.g., deleting a
> ref) we want to allow invalid names as long as they are not unsafe
> (e.g., not escaping the on-disk "refs/" hierarchy).

I still think we should eventually merge these functions. It's not
exactly obvious why one would use one or the other. So if we had a
function with strict default behaviour, where the caller can ask for
some loosening of the behaviour via flags, then I think it would become
a ton easier to do the right thing.

In any case, that doesn't need to be part of this patch series.

> But the pseudoref handling flips this logic; check_refname_format() is
> more lenient than refname_is_safe(). So you can create "foo/bar" and
> read it, but you cannot delete it:
>=20
>   $ git update-ref foo/bar HEAD
>   $ git rev-parse foo/bar
>   747a29934757b7e695781e13e2511c43b951da2
>   $ git update-ref -d foo/bar
>   error: refusing to update ref with bad name 'foo/bar'
>=20
> So we probably want check_ref_format() to learn the same syntactic
> restrictions that refname_is_safe() uses (namely insisting that anything
> outside of "refs/" matches the pseudoref syntax). The most obvious way
> to do that is simply to call refname_is_safe(). But the point of
> 03afcbee9b is that doing so is expensive. Without the syntactic
> restrictions of check_refname_format(), refname_is_safe() has to
> actually normalize the pathname to make sure it does not escape "refs/".
> That's redundant for us in check_refname_format(); we just need to make
> sure it either starts with "refs/" or is a pseudoref.
>=20
> But wait, it gets more complicated! We also allow "worktrees/foo/$X"
> and "main-worktree/$X". In that case we should only be checking "$X"
> (which should be either a pseudoref or start with "refs/"). We can
> use parse_worktree_ref(), which fairly efficiently gives us the "bare"
> refname (even for a non-worktree ref, where it returns the original
> name).
>=20
> And now when should this new logic kick in? Unfortunately we can't just
> do it all the time, because many callers pass in partial ref components.
> E.g., if they are thinking about making "refs/heads/foo", they'll pass
> us "foo". This is usually accompanied by the ALLOW_ONELEVEL flag. But we
> likewise can't take the absence of ALLOW_ONELEVEL as a hint that the
> name is fully qualified, because that flag is also used to indicate that
> pseudorefs should be allowed!

Indeed, it's a proper mess :)

> We need a new flag to tell these two situations apart. So let's add a
> FULLY_QUALIFIED flag that callers can use to ask us to enforce these
> syntactic rules. There are no callers yet, but we should be able to
> examine users of ALLOW_ONELEVEL, figure out which semantics they
> wanted, and convert as needed.

Makes sense.

> Signed-off-by: Jeff King <peff@peff.net>
> ---
> The whole ALLOW_ONELEVEL thing is a long-standing confusion, and
> unfortunately has made it into the hands of users via "git
> check-ref-format --allow-onelevel". So I think it is there to stay.
> Possibly we should expose this new feature as --fully-qualified or
> similar.

Hm, that's really too bad. I wonder whether we should eventually start
to deprecate `--allow-onelevel` in favor of `--fully-qualified`. We
would continue to accept the flag, but remove it from our documentation
such that scripts start to move over. Then some day, we may replace
`ALLOW_ONELEVEL` with something like `ALLOW_ROOT_REF` that allows refs
in the root directory while honoring `is_pseudoref_syntax()`.

>  refs.c | 14 +++++++++++++-
>  refs.h |  1 +
>  2 files changed, 14 insertions(+), 1 deletion(-)
>=20
> diff --git a/refs.c b/refs.c
> index 8cac7e7e59..44b4419050 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -288,6 +288,15 @@ static int check_or_sanitize_refname(const char *ref=
name, int flags,
>  {
>  	int component_len, component_count =3D 0;
> =20
> +	if ((flags & REFNAME_FULLY_QUALIFIED)) {
> +		const char *bare_ref;
> +
> +		parse_worktree_ref(refname, NULL, NULL, &bare_ref);
> +		if (!starts_with(bare_ref, "refs/") &&
> +		    !is_pseudoref_syntax(bare_ref))
> +			return -1;
> +	}
> +
>  	if (!strcmp(refname, "@")) {
>  		/* Refname is a single character '@'. */
>  		if (sanitized)
> @@ -322,8 +331,11 @@ static int check_or_sanitize_refname(const char *ref=
name, int flags,
>  		else
>  			return -1;
>  	}
> -	if (!(flags & REFNAME_ALLOW_ONELEVEL) && component_count < 2)
> +
> +	if (!(flags & (REFNAME_ALLOW_ONELEVEL | REFNAME_FULLY_QUALIFIED)) &&
> +	    component_count < 2)
>  		return -1; /* Refname has only one component. */
> +

I first thought that we don't have to handle REFNAME_FULLY_QUALIFIED
here because the above should already handle it. But we can of course
have a single component, only, when the ref is "refs/".

Patrick

>  	return 0;
>  }
> =20
> diff --git a/refs.h b/refs.h
> index d278775e08..cdd859c8b7 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -571,6 +571,7 @@ int for_each_reflog(each_reflog_fn fn, void *cb_data);
> =20
>  #define REFNAME_ALLOW_ONELEVEL 1
>  #define REFNAME_REFSPEC_PATTERN 2
> +#define REFNAME_FULLY_QUALIFIED 4
> =20
>  /*
>   * Return 0 iff refname has the correct format for a refname according
> --=20
> 2.45.0.rc1.416.gbe2a76c799
>=20

--mA/nyX48fo6s3vJs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYweWwACgkQVbJhu7ck
PpSUfRAApobbxI7xDjTjAJxn7Z4oPRTA1ZCr0uB/k23GcYxn2qw1AwEdrbvdXA2s
JjocAbcmo7XNpjIuTaMnI5nJ9qzkb4LzP0ijHztEend331zdS/WfHyCqYyJiKu/n
1p4+jMD3rP8YjXTCeBrJtwI5VXoxdeFlsZsw05B6j8/DCjoOBLKi2bLLT67r2xxs
JJNpAnh7tH0jr6QUWuU9v3q4y+o+kHJqg9lYD8EfBO//1mofFN0Os3e8uchtioKp
U38kft9vtmsc9XhiJGMYmpkBAkl6I5JzQ4JtO/vPqRj5EgaF9XlK3hPEKbDwlxmJ
CiTEgAoFEb1o5/tJhoynCAjFf/J15vxEVRYe7cEUAcNVUfmicH/9hL6v8orJzv5q
t1CB9PFXzLK7tqjXitKQGIyRJEdAXIQkM41Bq5tpKj7bh82gWjSTprZ7QUr3G8TP
qF2MFd2WQSrSVI62pom4QURLPOCBy8IEz0cvsi9dMuDvZUAwWyFZnq6GAtVrneLx
u+x1KUS1y9BvFJSHA/Y1VF92XzlN5tm/r5WakkzMUURZ1n5nIJC7uitRiVsexYm2
ibEiwMbjZcwxn8BzGsSAIzK8LgL2YzYVkhx6ftuQh02Gko12fmjMlXVKRhqRFusn
PdUsJKAwYZixrIlSpg3ABKTDOZnnyjcza0IQM6EPw5lOuUHm37I=
=d+uE
-----END PGP SIGNATURE-----

--mA/nyX48fo6s3vJs--
