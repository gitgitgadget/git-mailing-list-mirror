Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EED238F649
	for <git@vger.kernel.org>; Tue,  6 Oct 2026 22:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791325606; cv=none; b=sH9nP+vEPcbREbzymmMbfCcF5YBEI3TyAnr6bXKQhPjz+tviow0WMMb9ECHvW8vMcICAkNaemernVZBfyfIY3rCP9mXqdC2Q78VVZ/ZWWGZzM7t7ybXq4awjHKxbfe9Ag3DBKrrE3nd3jhpnILpJeOteM/Ciane+nnnOIocEsp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791325606; c=relaxed/simple;
	bh=kt2oq0nCLOpT87e4L/6at81fcRTTg29ZZ1W4ONYIVk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Am4QHW8sqUm1UsikXDX3C15FBubsVzLa8HiTuLhy0QfutQ6AiTZIRMrm8LKFyEd7W86d9PEHukDuBzuouG92PgSYCi+l6SUYJzPdSiwBcBysPrs/+NsYrzPou5dqD6+kNGNNcaSSMsF0LSDZl+SbmviG7DlMLJ7kWQAEWJWiY4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=VAuRFVeK; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="VAuRFVeK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791325601;
	bh=kt2oq0nCLOpT87e4L/6at81fcRTTg29ZZ1W4ONYIVk0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=VAuRFVeK8qyZvVBJ9LL3jzlvwSjn8uyRE68WSnuNEbfMEJnSX1Eo9v665LR1Il94D
	 JerFuD0s/9RUPG/yrl6JeO9SnyKLNkZBLc4SXVzriYhCXbeGNYfVUyn+wK/g5RP/wc
	 HMjmEWm3H4ZS11luFhAFuplZzIgW4rQltxDoF4BuYEMI9TwMGpfuxfe4+kFZ7e5bo1
	 6AvO5BZ45S88O02HKnGeo5WrVM61mBo9wTubTFJRmrwwgWYBebN7BLoFxufLSx63EQ
	 eklQhSNH4XpVT+pCJKeIIDve3cKeh088Jp814wbHhjhG/O/9PzHKB0OU20o3b2bNF6
	 tBpZFwdP/0MN/YNi39Lc8tJT80Pi72lvpZkjFsuCKWSEfVhbVohmqfRlsQAMRdHtHN
	 JjqQ+hLnPisPWqxAJmlTfx6kMfCmP0p7FzAdRhFoLsP2BVnpi85S0uXdkZbVNCXEZQ
	 5xOwxJAOfQ+zbqrQ/6C1p7ZZ6h9Zxl9MvW+Bc5XNe9ip/DorzDK
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:1808:f548:d307:7e36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E0ECE20077;
	Tue,  6 Oct 2026 22:26:41 +0000 (UTC)
Date: Tue, 6 Oct 2026 22:26:40 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and
 tags
Message-ID: <asV1oB_avuEbgRVe@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Couder <christian.couder@gmail.com>,
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20261002081846.25144-1-scott@gitbutler.net>
 <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
 <CAP8UFD096CdR9MXd+VHk7Zf9rCJEnGTEiBhCc0mJdMmE3U_gOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UObIqWE///zYb7j5"
Content-Disposition: inline
In-Reply-To: <CAP8UFD096CdR9MXd+VHk7Zf9rCJEnGTEiBhCc0mJdMmE3U_gOg@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--UObIqWE///zYb7j5
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-06 at 09:00:45, Christian Couder wrote:
> On Fri, Oct 2, 2026 at 9:15=E2=80=AFPM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>=20
> > The thing you really want is the interoperability work, which can
> > automatically rewrite repositories from one hash algorithm to another
> > during a clone or fetch operation.  Yes, it isn't quite that simple for
> > submodules, but if you recursively clone the repository and all its
> > submodules, it should be possible to rewrite it in place, although that
> > hasn't been written yet.  That work has not yet been sent upstream
> > because some of it was written at $DAYJOB, which requires that we use
> > Outlook and we all know that Outlook corrupts patches.  However, there
> > is some intention for another company to handle the polishing and
> > sending, so it should be available sooner or later.
>=20
> Sorry for the possibly stupid following questions, but I think the
> answers might help us get a better idea of what might be needed to get
> a smoother transition.
>=20
> And yeah, I know that many people have said that merging all your
> interoperability work should not block Git 3.0. But if it can ensure a
> smoother transition, we might want to get at least part of it merged
> soon, and the rest in a good shape, anyway.
>=20
> Is the current state of the work publicly available somewhere? Or
> could you make it publicly available somewhere? (Fine if it's only as
> patches in a tarball.)

Yeah, it's at https://github.com/bk2204/git.git as `sha256-interop`.

> Is the submodule work the only missing part of the interoperability work?

Not quite.  The limitations are outlined in
https://lore.kernel.org/git/ajCWBG9RHBrm8jMZ@fruit.crustytoothpaste.net/
and in `Documentation/gitformat-hash.adoc` in the branch.

There's no in-place migration tooling, which would be required for
dealing with submodules, since those would need to be migrated before
the main repository.  There are essentially two cases for in-place
migration: adding the other hash as an extra mapping and rewriting all
the objects to the other hash with our hash as a mapping, much like `git
refs migrate` does.

I've started on some of the Rust pieces that I was planning to use for
in-place migration, but someone who wanted to work on a C-based
implementation could also do that.

There's some missing features that I've outlined, like a lack of support
for multi-pack index.  Those can be added, but they're not immediately
essential.  And there are other things which need to be actually
polished and fixed, like the fact that delta resolution is recursive
rather than iterative (which would allow a malicious server to cause
stack exhaustion).  The good news is that most of those things are
labelled with `WIP` and a short description of what needs to be fixed in
the commit message.

One other thing that needs fixing is that we have many pieces of code
that write large numbers of loose objects into the ODB and may randomly
die in places; `git add` is a great example of this.  The object maps
which are used for storing loose objects should ideally be written with
all of those objects at once in a batch and then committed.  However, if
we die at any point, we've written the loose objects, but not the
batched object map, so the repository is then corrupt since it can't
perform mappings.  If we write the objects into the object map one at a
time, then we end up with N object maps and `git gc` runs all the time
to repack those into a smaller set of data.  We therefore need to either
fix the die-die-die behaviour or use ODB transactions to write both
loose objects and the object maps into a temporary directory.  This is a
case where it technically works but it performs awfully, so we do need
to fix it before non-experimental use.

There is a partial rebase of the early entries in the series converted
to use the pluggable ODB work in the `sha256-interop-part-2` branch. The
pluggable ODB work has caused a lot of conflicts in the interop because,
unsurprisingly, both series are intimately involved in the object
database.

> How much work is this? (At one point it seemed to me that it was
> around 200 patches.)

It's presently about 212 patches.

> If you were to work full time on upstreaming it, how long would you
> expect it would take you?

Probably four release cycles, assuming release cycles are 6 weeks.  The
reason is that reviews will be needed and those will take time.

If we wanted to write an in-place migration helper, I'd expect another
two cycles.  Writing one that preserved the existing algorithm and just
added the mapping for the other algorithm would be easier because it
wouldn't require rewriting the `objects` directory.

> If some of us could help you, how could we best help?

I would love someone to start picking up patches from the early part of
the series, rebasing them onto `master`, fixing up any conflicts, and
polishing them, and then sending them in.  The `sha256-interop-part-2`
series would be great for that.

Just let me know if you want to do this and then we won't conflict.

> Could you say which company is interested in helping with this? Would
> that company be willing to work openly with others on this?

I'd rather not disclose that without the permission of the person making
the offer.  I'll just say that a respected contributor and member of the
community offered to have some of the work done on their company's dime
by a person who is also known to the list. They did note that there
would be a delay before starting, so it wouldn't happen right away.

I feel confident that the contributor in question would be willing to
collaborate with others in getting this work done because that's the
kind of person they are and obviously it would be in everyone's interest
to do that.

> Are there some tests or kinds of automated ways to check that things
> work as expected under realistic conditions like:
>=20
> - using real world repos (large ones, old ones, with submodules, etc),
> - mixing a number of new and old clients and servers,
> - interacting with other implementations (JGit, libgit2, gitoxide,
> forges, CI, etc)?

What I have done to test this is `git clone --object-format=3Dsha256:sha1
https://github.com/bk2204/lawn.git` and then pushed to a SHA-256
repository.  That's just a personal project of mine that doesn't contain
submodules, but it's what we've used for testing at work and we have
several internal copies of the SHA-256 version of that repo.  It clearly
interoperates with GitHub on a SHA-1-only and SHA-256-only basis, but
there's no support for the interoperability on the server-side yet.
There are also tests for the interoperability code in t1017 which are
reasonably comprehensive.

Once we have in-place migration, I would like to test it with git.git,
since I think that would be a great real-world testcase.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--UObIqWE///zYb7j5
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrFdaAJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ0WME9nnEi1fer4HD1kJxnRj4KUQu3mqHNM03tA1VjTM
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAFoAQDHZtNizMCY5eN/u02QLwqO1L3d
ovqF/PWtLOYCwqWi8QD/YkcUo2ykIgOKog7lT8oqc5/gsFSESo5Rm+PK9T2FNwk=
=f6To
-----END PGP SIGNATURE-----

--UObIqWE///zYb7j5--
