Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC551852
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 01:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.110.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538596; cv=none; b=KsBhz7wA4CXuaEysKF6uJB8COgvem009TKfAtaoAzbS/vMKQ64Vgq3bD3YALi14C9ps2TBi9TKAUjF1hKcXJCVDCuU154ZAInPcYeuPghpZZ8yT2kt9wfy05D8OrG6SdGCBHjNvweTUfLDuhmrNmjsUvyq9LeK9lw6gXc0SwKmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538596; c=relaxed/simple;
	bh=CF5w6R8siAgdlJa++FgAiQ3UJGQEKlcTQe2gsCgCK/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3lWGNT2fNfeKl9X2mbMJgYxth85OEszWQFwdLwyJ6jShJ+LKiv6fOUXr5iYjxP+48KvvnSUo2O6GxjhVnO703U6fqea6E309hMoZhAcU39bxTGnWM76/SJQJDPHkhvPmQ8bmzitIThGXZt+kGb2F2VKkpYqpKI6z4AeQMoNMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=eabV+4G2; arc=none smtp.client-ip=172.105.110.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eabV+4G2"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 8E3775D4CC;
	Mon,  8 Apr 2024 01:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1712538592;
	bh=CF5w6R8siAgdlJa++FgAiQ3UJGQEKlcTQe2gsCgCK/4=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=eabV+4G2fz+MpGpBwZxrkh3++WHsGFk7SnuYmP18MuiRH5NdDoFmKz1klfiNZvZOA
	 ahZgFClZaFuC4OjY9ap3TLZhLHvpSXiLY1Fm8VgAPEr1+BFI6Z0xtCfeVuRFpOaWSK
	 0Z7RvjEeIXNCv9BfWwPCehXCJi2SX0JP0ekDyGhH5SWVoJBHrPP58jUBXaBuqZs3G3
	 GyGqWc1o1HHSXtm9zAtpoeZ1QHQcCRPfrRDt35QxWs6wFAQ5P40eNHYHmYN23wmFWX
	 NDjxhmYVW4NZhZIEciFCRM2krWxPFmHZaCcoqDvbLEBLZP5Rcz4K0GQufdnGKf4gWf
	 OqbxmplwCDnXnr0NmPTmH5hJZ+PtWKmnCLUEAzZz1+4+TyxNPzZ8KxrZQsLDCiiCjv
	 5vFGVbnPY3DQvR4Gf+qKNyjF9xQt68CNuWQFBIah6YdPRK8sGtXGPBuGpnnvm0oL9B
	 ODUmT/k9mRxCe1STWxWNpQUZeS3VF42iumWDBunedJehWx6a/lb
Date: Mon, 8 Apr 2024 01:09:50 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: rsbecker@nexbridge.com
Cc: 'Calvin Wan' <calvinwan@google.com>,
	'Git Mailing List' <git@vger.kernel.org>
Subject: Re: [RFD] Libification proposal: separate internal and external
 interfaces
Message-ID: <ZhND3hZXlzDxff5e@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	rsbecker@nexbridge.com, 'Calvin Wan' <calvinwan@google.com>,
	'Git Mailing List' <git@vger.kernel.org>
References: <CAFySSZAB09QB7U6UxntK2jRJF0df5R7YGnnLSsYc9MYhHsBhWA@mail.gmail.com>
 <ZhMRNxgwRJ25P4Ud@tapette.crustytoothpaste.net>
 <037001da8935$4a6e3720$df4aa560$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6Ow1Cjs3IPvqisUf"
Content-Disposition: inline
In-Reply-To: <037001da8935$4a6e3720$df4aa560$@nexbridge.com>
User-Agent: Mutt/2.2.12 (2023-09-09)


--6Ow1Cjs3IPvqisUf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-04-07 at 21:48:07, rsbecker@nexbridge.com wrote:
> On Sunday, April 7, 2024 5:34 PM, brian m. carlson wrote:
> >We'll also need to consider that libgit2 is currently using `git_` and t=
hus we'll either
> >need to use something different or avoid conflicts.
> >Perhaps `gitlib_` might be useful.
>=20
> Or `GITL_`

It's more common to use lowercase, so I think we should do that.

> >I should point out that _FILE_OFFSET_BITS=3D64 is effectively standard t=
hese days.
> >Nobody wants their files limited to 2 GiB.
>=20
> This is not the default on some platforms. It is still required but can b=
e put into a knob.

True, but everyone compiles with it.  If you're a software vendor and
your build only supports 2 GiB files, everyone's going to be mad.  We
should be able to assume that vendors are prudent and reasonable people
who will compile their binaries accordingly and not have to return an
error if a requested file size is larger than 32 bits.

> >Sure.  If we need a file size type, it should be something like `int64_t=
` or `uint64_t`
> >and not `off_t`. Not all platforms have explicit 64-bit APIs compiles. N=
onStop and S/390 do require explicit controls to make this work.
>=20
> This will result in compile warnings with some platforms with APIs
> that do use off_t for arguments and results.

There will need to be a cast.  Our APIs should use a standard 64-bit
type and not expose the platform `off_t`.

> >
> >> - Limited Platform Compatibility. The external interfaces are able to
> >>   assume that <stdint.h> and other C99 (or maybe even C11+)
> >>   functionality exists and use it immediately, without weather balloons
> >>   or #ifdefs. If some platform requires special handling, that platform
> >>   isn't supported, at least initially.
> >
> >I think this is fine.  It's 2024.  We should assume that C11 (a 13-year-=
old spec) is
> >available and so is POSIX 1003.1-2008 (except for Windows).  We may want=
 to
> >have a nice `#ifdef __STDC__ < 200112L` (and a similar check for POSIX) =
to just
> >produce an `#error` if the system is too old.
>=20
> I wish this were the case. I have 2 years before C11 is guaranteed to
> be available on platforms that I maintain. Can we wait until mid-late
> 2025 before doing this? I do not want to lose access to git.

As mentioned in the original proposal, we don't have to support all
platforms in the libified code.  The main Git binaries will continue to
function and be supported, but the new libified code will rely on newer
features.  You will still be able to have all the Git binaries and
functionality, but if you want the new shared library to compile
against, you'll have to furnish a newer compiler.

As a side note, I don't think requiring porters to support a 13-year-old
spec is unreasonable for new, independent parts of the codebase.  As a
side note, if your platform supported GCC or LLVM, then this would be an
easy goal to achieve.  I know it doesn't right now, but it might be an
incentive to get it there.

> This is not a particularly good assumption. Some architectures do not
> support kernel-level threading. PUT threading is possible on some
> platforms but attempts to port git to PUT require that all
> dependencies also support PUT, which is not a good assumption. Most of
> the dependencies that I have to work with actually do not support PUT
> or any other form of threading.

I don't believe this is true.  Every architecture which supports Linux
or any other modern Unix has threading support.  You're compiling on
ia64 and x86, which definitely do support threading and have had it on
Linux and NetBSD for years (before they removed ia64 support).

Threading is a reasonable thing to have on a modern operating system,
and if we're adding new, independent functionality, that should be able
to safely work with threading.  You can continue to use the binaries
without threading, just not the new shared libraries.

I'll add on that I'm not opposed to continuing to support NonStop in
principle, but I _am_ opposed to having to continue to support really
ancient versions of common standards[0].  POSIX 1003.1-2008 is about 16
years old; it could drive a car in much of North America.  I think it's
the responsibility of porters to provide this functionality, and in
general most open source OSes do this with little or no paid staff, so
it should be reasonable to expect corporate-backed operating systems to
do so.

I would strongly recommend that NonStop start supporting modern compiler
and POSIX standards, as well at least one of GCC or LLVM, and that you
push very hard to make that happen.  It's not just Git that's pushing
forward here; there's a lot of open source software that simply will not
compile with the functionality you support, including the increasing
amount of software written in Go or Rust, and it's unreasonable to
expect people not to want to use standard functionality that's over a
decade old.  If NonStop doesn't move in that direction, I anticipate we
will eventually drop support for it sooner or later.

[0] This is not just NonStop; Microsoft's long-time refusal to implement
C99 or a newer version of C really ground my gears and I basically gave
up on supporting it for all personal projects as a result.  Fortunately,
they've now come up to a modern standard.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--6Ow1Cjs3IPvqisUf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZhND3gAKCRB8DEliiIei
gdv7AP9t41JooFAcBdTbOtATl1PyEp9RsRZauQSxiAceKZ59QwEA4NN17d1XtQQD
q6P/9skt2WerQG0svkFIAsTNBRioYAU=
=bQ8a
-----END PGP SIGNATURE-----

--6Ow1Cjs3IPvqisUf--
