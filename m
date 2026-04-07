Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C159C37F002
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 23:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775604526; cv=none; b=FbQjlsez6dp4/nOGmA7OcrvSRM7Ve4DAQUbPbMD+EVKuMsfIbccHKIR48PBRVH3NuT+NkkaDQdwqT0OrtD1gI9U0VnLY+j0axuDvT7+LGrU4l6emUE8exsRMY4jKsI4DcIZv7L6La2vJQ6bKFF9mbGpsztynEhsmaDapD0aEjas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775604526; c=relaxed/simple;
	bh=CoYhXAr4oXpJffYkYLyWprpBRHTNIQx/NjmVb9d/e5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5RPe09UifjNCSj/C7y5hwwpqjKY2oX2Tl5n4wZF9Pzn55+rIUhKVA0Tp5wgP65+2S4LzTWwe1I1IuRtvaIpgVBUphqfmskGgNByif1/pCbB/5RNzF0bGe9ULg68QPcDzpmgIok7Q8/jMkEhm5RV1Tzu3nIw/bPO/4h8HgrUITE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=g8zri001; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="g8zri001"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1775604523;
	bh=CoYhXAr4oXpJffYkYLyWprpBRHTNIQx/NjmVb9d/e5s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=g8zri0015IivGPm39iMgnF8VtjEcV0wNk43MJxIZkMvPpLnr1vXQylqIY2gtD8d2h
	 dRecyniKh7XW6hu4W/v2idcSpTh31hsTQidYqUf2eEBdPtY2Wi2OPw5ILA58GlKsRs
	 F9fiBcgwcw0GKZLnvchG48Pd6356b1LIN3L7DrEqICxREWY+dmgZlO+acHcKqicgUu
	 l3RhsletL5UIJIgLaD8wPjxQr991CX4fnxvNYuUUcQ4wpnhV52rVDVWoWA1t64C9QX
	 aAR/xXUOw68aQFr+Mw50rY3N63axdOJqFK4KFHdbgWo+JGAt4/3IgkAGwx9zaESHhy
	 +0b0ySSYWPwF1hxueYZD6su6CEAwMS5CjDP+qfMPMhWv7HiJBYq7TITQccJvpB16ww
	 AwjKrlZURCvQm0JoYXYJUfb/t+q7c5xGfAXJDohMQNChGZn+JJpunUev0bDouQaf9L
	 4pWfCU7aAa1htPVPYv+JmU801d/qjA+CM/2dipnOjvpBOj7n1ZO
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9492:b8ae:a7e1:509f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id A652B20144;
	Tue,  7 Apr 2026 23:28:43 +0000 (UTC)
Date: Tue, 7 Apr 2026 23:28:42 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Matt Stark <msta@google.com>
Cc: git@vger.kernel.org, ps@pks.im, gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
	Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
	philipmetzger@bluewin.ch, konstantin@linuxfoundation.org,
	newren@gmail.com, tytso@mit.edu, nico@cryptonector.com,
	rikingcoding@gmail.com
Subject: Re: [PATCH] headers: Preserve 'change-id' header in rebase /
 cherry-pick.
Message-ID: <adWTKt20ISC3qz2g@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Matt Stark <msta@google.com>, git@vger.kernel.org, ps@pks.im,
	gitster@pobox.com, phillip.wood@dunelm.org.uk,
	Martin von Zweigbergk <martinvonz@google.com>, remo@buenzli.dev,
	Edwin Kempin <ekempin@google.com>, schacon@gmail.com,
	philipmetzger@bluewin.ch, konstantin@linuxfoundation.org,
	newren@gmail.com, tytso@mit.edu, nico@cryptonector.com,
	rikingcoding@gmail.com
References: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0M4Jca071uXnXa+Q"
Content-Disposition: inline
In-Reply-To: <CAH7WC73-4p0RrqKNSh2G-xfpfO7QHZiXHbU_UFRkM3Q=bMWTDw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--0M4Jca071uXnXa+Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-04-07 at 03:13:18, Matt Stark wrote:
> In the discussions on
> https://lore.kernel.org/git/Z_OGMb-1oV0Ex05e@pks.im/T/#m038be849b9b4020c1=
6c562d810cf77bad91a2c87,
> it seems to be that:
> * There is consensus that a `change-id` header provides good value

I'm not sure I agree.

Absent some well-defined documentation describing what it means, I don't
see how it could provide good value.  It sounds like you're saying a
persistent commit ID is generally useful, but I don't see the value and
I associate persistent IDs with online tracking and advertisements,
which are neither useful to me nor particularly ethical.  Since nobody
has explained the compelling reasons in documentation, I am left to
speculate on them myself and have come up empty.

> * There is not consenus on what precise format that should take

I think stabilizing this before a format is defined is a mistake.

Even if, for the sake of argument, we agree that this is a generally
useful thing to have, we'd want to have a standard format (ideally
produced in a deterministic way for the reproducibility of the testsuite
and downstream projects), which we don't have, before we persist this.
We would probably want to have `git fsck` verify that the format is
correct and this is not being used as a way to store random information
as part of the initial change.  I assure you that users will very much
try to shovel random, arbitrary, malformed information in there
otherwise, since I've seen this in the author and committer headers[0].

> This commit, rather than attempting to standardize the format, simply
> preserves the change-id header in whatever format it used previously.
>=20
> If we so choose, we can later decide on a standardized format, but since
> git only preserves existing headers, this should not create backwards
> incompatibility.

As I mentioned before in other threads, this needs to be off by default
or configurable.  This kind of ID provides tracking of commits, which is
useful in some situations but may also be undesirable for privacy or
other reasons.  Unlike other headers in commits, it is not easily
visible (one can easily tell if a commit is signed, for instance, or
what its tree is) and so therefore has potential privacy implications.

This is especially true since historically a great deal of information
has been automatically rewritten when rebasing or cherry-picking
(leaving only author and message alone), so users will have come to
expect this.

This is also a great way to leak information, such as secret keys.  I
can shovel sensitive keys or IDs into a commit (in a possibly encrypted
form), push them somewhere I have access to, and then exploit them.
Nobody will ever notice since corporate firewalls don't actually see the
raw object information, only the compressed and deltified packfile.  I
can even have my colleague rebase my commit with --reset-author and push
it so I have plausible deniability.

As an example of a problematic situation, say user A creates a commit
and publishes it somewhere on a remote.  It doesn't get picked up into
the main branch.  A year later, user A changes their name (because they
transition, marry, acquire a new citizenship[1], or for any other good
and valuable reason) and suddenly go by the name B.  Six months later,
they rebase the patch on the current main branch and, because the
project has advanced quite a bit, it looks completely different (so `git
cherry` will no longer identify it in any meaningful way).  They adjust
the message substantially due to the change and sign it off as user B
and submit it.

The user in this case may not have wanted the two commits to be
associated (very especially so if they transitioned), so this poses a
substantial risk of unintended disclosure.  The fact that Git makes this
a problem already is not a good excuse for making it worse here; to the
contrary, we should be making the situation better, not piling on.

[0] For instance, some people want to provide timestamps that are larger
than 2^64, despite the fact that it is remarkably unlikely that humans
will still exist 5=C3=9710^11 years in the future, let alone that Git will
still be in use.  Unsurprisingly, most programming languages don't
appreciate these timestamps, so problems ensue.
[1] Some countries require that citizens have a name which can decline
grammatically in the native language or otherwise meets linguistic or
cultural norms in that country.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--0M4Jca071uXnXa+Q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmnVkykJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZyjkB5+JUJvQxvaPsBjmsHSwXebLWhLdxjE7LmEOAR3F
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOMKAQCdzUoXbncTkLwjUVE31elqkxSx
vecVSzIfrxasRtqZhgD/c/RWH6/LRmPv/Nijhsm+ouKBUAYv0+5DuaKucwo69ww=
=qWp3
-----END PGP SIGNATURE-----

--0M4Jca071uXnXa+Q--
