Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966DB2904
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 00:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751761729; cv=none; b=LFHhQOl4t+uGuEUJO0t73LCg9PsXqc06vDrPMYEuee5JJ2nHeQO0cRuOUz+wUPBcu4j7eu+ZnaMvlRA4L1bM5aKF3yN7rOSicIqglInDurviHn5aJefWaCMjo82dWwiGxLuMdD2yX/S51VEfnC31xmPfbNtcDefz2rQHZd/MK2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751761729; c=relaxed/simple;
	bh=SuEddk2myntfYVq7edruN7r16PUv71L4dFhG92uS2wU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdoVFHy6HTCdRb7/sqi4AifbLLpri2+Fzw9xzDkhQ6aNWYSXGX2yUnp9WM+SIeljJzTeHVsd/mK4XGzmxgxuv/zzPE2Y+RjVd4iKB8ASXp8EtJj4F89bcuvFU+4KSrQGlWwbk+QoelNJMrI3cxWpuzcKG6SpqYKgVOl/CPgM0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=EmhRWHD5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="EmhRWHD5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1751761725;
	bh=SuEddk2myntfYVq7edruN7r16PUv71L4dFhG92uS2wU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=EmhRWHD5tL9t8m3czkN3gUY3shlr/n7rGdmYSLGnnTy4RgivbGHReXqVUgO2EhK2E
	 iaUTakyPuyWNJ5eZZ1mzt3Wj8BCHCKsj5GRwcU92G731lPIPq46wuEpwugSbZGXjs3
	 NdLsXTsl5KJG9uAtmnlA0/KnraH64CPuMai3kRKBdAWRBcAcCexSXB2Ze07cOTi97M
	 aBpPcl24JTk7EPZRlLmtYCOdTqnzIa5RlJrbr4XFNtqzdxXnTZ3gW2xuI7ZlGnXA2A
	 9ar4b0tRZGUyqVa0uj8rm1ET/EjKt6I9apTMOIqXp8oDMlzSaKShKJpLVRqrsR03wV
	 l6Z0U9j+k0hscxPJbyZ/74kUocJ1eqkETRC3/F5ECFkSRYyF5tjoTy3mDePaYSgVSh
	 zMfxsXXBET/yuFImvoztM5Avh/x+i4iDuMTrDCp4eZMaNBJPDM+jUDiqCX6BDGImkS
	 MsBXMa5wFifupiGU97E3twuHvzraBHhRF8b4VzZIk77yuiAYAqY
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f46e:145:3ba4:8bd6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 1BD052003B;
	Sun,  6 Jul 2025 00:28:45 +0000 (UTC)
Date: Sun, 6 Jul 2025 00:28:43 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: redoste <redoste@redoste.xyz>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Fabian Stelzer <fs@gigacodes.de>, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] ssh signing: don't detach the filename strbuf from
 key_file tempfile
Message-ID: <aGnDO3HIAQgsRbnJ@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	redoste <redoste@redoste.xyz>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Fabian Stelzer <fs@gigacodes.de>, Elijah Newren <newren@gmail.com>
References: <20250704230829.29696-1-redoste@redoste.xyz>
 <20250705192113.GB2496172@coredump.intra.peff.net>
 <aGmGCmkwC1HlSyog@fruit.crustytoothpaste.net>
 <DB4HMD2HLG24.1V8Y9JDW6BACQ@redoste.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bKBkKOns2EQs+89q"
Content-Disposition: inline
In-Reply-To: <DB4HMD2HLG24.1V8Y9JDW6BACQ@redoste.xyz>
User-Agent: Mutt/2.2.13 (2024-03-09)


--bKBkKOns2EQs+89q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-07-05 at 22:50:43, redoste wrote:
> On Sat Jul 5, 2025 at 22:07 CEST, brian m. carlson wrote:
> > On 2025-07-05 at 19:21:13, Jeff King wrote:
> > I don't have a strong view either way, but I do wonder if it's a good
> > idea to have the testsuite poking around in `/tmp`, although maybe if we
> > honour `TMPDIR` then it would be possible to do in a tidy way.
> I looked into adding a test, but I didn't find any other tests checking
> for temporary files and I agree that messing in /tmp doesn't feel really
> appropriate for the testsuite.
>=20
> Maybe something like this?
>=20
> diff --git a/t/t7528-signed-commit-ssh.sh b/t/t7528-signed-commit-ssh.sh
> index 065f780636..359dc8eba8 100755
> --- a/t/t7528-signed-commit-ssh.sh
> +++ b/t/t7528-signed-commit-ssh.sh
> @@ -85,6 +85,7 @@ test_expect_success GPGSSH 'sign commits using literal =
public keys with ssh-agen
> 	eval $(ssh-agent) &&
> 	test_when_finished "kill ${SSH_AGENT_PID}" &&
> 	ssh-add "${GPGSSH_KEY_PRIMARY}" &&
> +	export TMPDIR=3D$(pwd) &&
> 	echo 1 >file && git add file &&
> 	git commit -a -m rsa-inline -S"$(cat "${GPGSSH_KEY_PRIMARY}.pub")" &&
> 	echo 2 >file &&
> @@ -95,7 +96,8 @@ test_expect_success GPGSSH 'sign commits using literal =
public keys with ssh-agen
> 	git commit -a -m ecdsa-inline -S"key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" =
&&
> 	echo 4 >file &&
> 	test_config user.signingkey "key::$(cat "${GPGSSH_KEY_ECDSA}.pub")" &&
> -	git commit -a -m ecdsa-config -S
> +	git commit -a -m ecdsa-config -S &&
> +	! ls .git_signing_key_tmp*
>  '

What I would recommend is adding another test (that is, another
`test_expect_success` assertion) that when signing we don't leave any
temporary files behind.  You can then squash that into your patch and
send a v2.

As for `ls`, I wouldn't use that in scripting.  I'd use something like
this:

----
mkdir tmpdir &&
TMPDIR=3D"$(pwd)/tmpdir" &&
export TMPDIR &&
# Other code
find tmpdir -type f >files &&
test_line_count =3D 0 files
----

I think `find` is typically better in scripting and also in this case
with a separate directory as the temporary directory we'll find any left
over temporary files, not just the pattern we've fixed here.

Our coding guidelines point out that some shells don't like `export`
with assignments, so we do those as two lines.  Normally I would write
what you have in my day-to-day life, but we run on a variety of systems
that most people will never use.

>  test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'create signed commits with=
 keys having defined lifetimes' '
>=20
> I can add it in a v2 if you think it's a good way to test it.

I think the basic premise is sound, but a separate assertion would make
it easier to readers why we're setting the temporary directory.

> > I also have some friends who are trans and have transitioned or are in
> > the process of transitioning but have simply not gotten around to
> > getting legal paperwork done[1].
> This is the exact reason why I'm not very comfortable with using my
> legal or real name, (well, it's mostly because I still can't find a name
> I like).
> And since it's a simple patch that's probably not even copyrightable, I
> figured out that using a pseudonym was fine.
>=20
> Since I knew that the Linux kernel changed their documentation to remove
> the use of "real name", I thought it was more common and didn't relly
> think about it a lot.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit=
/?id=3Dd4563201f33a022fc0353033d9dfeb1606a88330
>=20
> I'm sorry, I should have read the git documentation more thoroughly.
>=20
> If it's really an issue I don't mind signing off with a different and
> more distinctive name.

No, I think this is fine.  You weren't obligated to explain that and our
policies should gracefully handle this situation regardless, but given
what I said before and this context, I think the name you have is fine.
Git unfortunately has poor support for replacing names and I would't
want you to have to put your deadname into our history for all of
eternity.

I'll send a patch to fix the policy.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--bKBkKOns2EQs+89q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.7 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaGnDOwAKCRB8DEliiIei
geWqAQC+LGZUPXpCYvVJoU8dgdGwYncdp3D0OOgSOmDJ0mRa5gD/YHTJdTOA2j83
9FzgNA8qLi2VqzH11bkPEyro9o/fXw0=
=rKDx
-----END PGP SIGNATURE-----

--bKBkKOns2EQs+89q--
