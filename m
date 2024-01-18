Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B08622F09
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 11:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705576516; cv=none; b=r62R+qyBRqrALPBOh4aJ2JCnRPHRDWV1PwnnOiPfKtcEe6LlA1QwcZBRZprdGIrg64M5BHHMAndHLKj6sGlCLgs3f6g96mIGhYB4/Sa4wiUWJmFg/SdofJ/xQLdpmFeEjNCB49zpmhSGN1KuaLU0J+CgRCmKFQwBBqtpWabWUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705576516; c=relaxed/simple;
	bh=B9EWPnI/ddWSAlwe99NHQO+Bmbhb8Op+woSKK5IlHig=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To; b=WHakawXtmMJhOhk4OnWZ5Gm69LZblye/T6gGXz//Qn7Z05lejIHaqA9na3ug9vIatOMAAw6pjbYPkeTzh9evIPdHl1RSSB0pX0usN+OsqAJFw5d5NESoIOSOZ8Km44OLkfnsXLsBNqrKLzoEHQA7epmEapDHMGW+VcXcXMMkbu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d3zInwni; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kwskh2Ud; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d3zInwni";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kwskh2Ud"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id 1321C3200ACD;
	Thu, 18 Jan 2024 06:15:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 18 Jan 2024 06:15:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705576512; x=1705662912; bh=faomcJXx0U
	HwkvrA4jRNY6AryoiZcI9ebqWzi1WZuuM=; b=d3zInwni9FelHNuqc2p9JjyTNm
	LZyKrqEAcJvC+3hTHnTsYaSwY4sTd0rzKcGslCKKZQYNWlTAseKp66XvHGuAmc6W
	ehiGENyhhM2kB+zhAFsi2frKl9uteIUMTKrHbjfdcrb5Abd3gM0gPn1vjb5OCJu2
	5GAHIgxJf+5t4Vn8q71ujUyyseTFOx8DdySmQpddlLCTh7/iN+8NxFe7oV9pZ+0r
	DggYVRs186uM55Mlr59oAgWlwL5gN5tfklRIkyJpZyXdzkBCpkTyzss4ModE/rdp
	8CqZcdh4DT8rHi2peJZsgq0d2eeBkKR7WHXFi2540VFn1xtpNgg9LyI/IhuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705576512; x=1705662912; bh=faomcJXx0UHwkvrA4jRNY6AryoiZ
	cI9ebqWzi1WZuuM=; b=Kwskh2UdmSZC6cD/niHeJ4RdEEfnAUZmDIYDCVEoZTOo
	fkt1rmRwobgGxlM/A6g6Igpo8DMNN/ylPXcST90+lUtNzCjUNS5qhsm5a/XbSAxi
	j9B5EDzML5eU8ul6p8CY20qbZLBJHZdxO0L7YFRbGis7dYX7BwjugKoriTadCqcc
	huWRt0gOexqaQR2TC7zm0f134lICdl5GMfquh5nXQQ7S3n1W3b8/VkHhjqMQvYjK
	l+fKFYabmCYBhMM/Ma8px5Ty76x8kKJDKlpOPaKQztm2nqSIDNgUA1vCkxvgUKyL
	RzwTShVcSQoKxaTYHtwoOHczuDK4eKY9OJSdbUgLNg==
X-ME-Sender: <xms:QAipZWrOZanwslLXHdR0egNA_J6G_nCczqt2gycr1i2F-kk2SrMdGg>
    <xme:QAipZUo7ehW33RuYnIYeLkhe3bhB9GttHokScUFTgYqk6fS0j490FoghA1z7MSySh
    MuHD4obfMgoCbKTLw>
X-ME-Received: <xmr:QAipZbMS6ME3OGnNzNUS1EXjW0otgGAizJ0tZNSEPEdH7exlNt2Fbz9U8FRMnHmguSwSU0uM1rGhyeOavDYs3jSQktl4DCH3nXug-j1QZdw3K_Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejkedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:QAipZV40hMyBFH1xmjZjNwIEPwg0IBVJxiVHGgN113gYw50N0P9jKg>
    <xmx:QAipZV6EQuJG8nIUwlzeOHpEjmLF_iSHuwmsbr3-bnARg5KMYPnJww>
    <xmx:QAipZVhszSR6QZ7KUgM-aIAYN_i0PsWGnHOSSqMIV6sIgRdoUxEujQ>
    <xmx:QAipZSizsyvwC7_g5dIVRKDOKvbMBj8yVBsJpGiUW5la8zs0gznehA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jan 2024 06:15:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c231b857 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 18 Jan 2024 11:12:14 +0000 (UTC)
Date: Thu, 18 Jan 2024 12:15:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "R. Diez" <rdiez-temp3@rd10.de>
Cc: git@vger.kernel.org
Subject: Re: git fsck does not check the packed-refs file
Message-ID: <ZakIPEytlxHGCB9Y@tanuki>
References: <6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="scF6bJM00/L+fOlH"
Content-Disposition: inline
In-Reply-To: <6cfee0e4-3285-4f18-91ff-d097da9de737@rd10.de>


--scF6bJM00/L+fOlH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2024 at 09:02:30AM +0100, R. Diez wrote:
> Hi all:
>=20
> I have been hit by an unfortunate system problem, and as a result, a
> few files in my Git repository got corrupted on my last git push. Some
> random blocks of bytes were overwritten with binary zeros, so I
> started getting weird unpacking errors etc.
>=20
> It took a while to realise what the problem was. During my
> investigation, I ran "git fsck", which reported no problems, and then
> "git push" failed.
>=20
> One of the very few corrupted files was packed-refs. This is a text
> file, so it was easy to compare it and see the corrupting binary
> zeros. But that made me wonder what "git fsck" checks.

Can you maybe expand a bit on how you arrived at this bug? Was this a
hard crash of the system that corrupted the repository or rather
something like actual disk corruption?

I'm mostly asking because I have been fixing some sources of refdb
corruption:

  - bc22d845c4 (core.fsync: new option to harden references, 2022-03-11)
    started to fsync loose refs to disk before renaming them into place,
    released with Git v2.36.

  - ce54672f9b (refs: fix corruption by not correctly syncing
    packed-refs to disk, 2022-12-20) started to sync packed-refs to disk
    before renaming them into place, released with Git v2.40 and
    backported to Git v2.39.3.

So if:

  - you use a journaling filesystem,

  - you didn't disable `core.fsync`,

  - you use Git v2.40 or newer,

then you should in theory not run into any refdb corruption anymore. At
least we didn't experience corruption anymore at GitLab.com, whereas
before we encountered corruption every so often.

> I am guessing that "git fsck" does not check file packed-refs at all.
> I mean, it does not even attempt to parse it, in order to check
> whether at least the format makes any sense. Only "git push" does it.

Indeed it doesn't. While the issue is comparatively easy to spot by
manually inspecting the `packed-refs` file, I agree that it would be
great if git-fsck(1) knew how to check the refdb for consistency. This
problem is only going to get worse once the upcoming reftable backend
lands -- it is a binary format, and just opening it with a text editor
to check whether it looks sane-ish stops being a viable option here.

In fact, I already planned to introduce such consistency checks for the
refdb soonish. Once the reftable backend is upstream I will focus more
on additional tooling to support it, and extending our consistency
checks is one of the first items on my todo list here.

> What other parts of the repository does "git fsck" not check then?

There may be some metadata and cache-like data structures that we don't
check, but the object database is checked by default.

> The repository check is suspiciously fast. Is there a slow way to
> check that a repository is fine? I mean, something along the lines of
> checking whether every commit can be checked out without problems.

Other than running `git fsck --full --strict`: not that I'm aware of.
And `--full` isn't even needed because it's the default.

Patrick

--scF6bJM00/L+fOlH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWpCDsACgkQVbJhu7ck
PpRfww/9FwnbCdOT9rKVHh2Qj7u1mh6wX9wT175mBkOKaYRYFfzWXoNL1iAnj7zj
2StlRT0+50HY7Kb9UbNIbc8VVtw+mFSFDzzjHZfWgodUZfX6fCUYVLYFDnx8XT2t
7HUR8elb4N0mAEetqCMtS0hslMtfyTJ2U+UG9DOtucYn1swd5KNpOBBUD5qQ3c/B
ENjXLU0tuH4hFkkBdu6Pvd4mt82WjJdMo1Bq+lP4ImQ5sU6+bRRJX10MtASIN/33
ZFQpJdezZoPtc1H/uhG+K6Cm/QzU2pV+nLkPWwxpgNS2z1xi+uLUN+i84bOdGow2
AbCL9hKR9XdkwP7qsGbak25k/fjkeBX91ZFZFuO2CYHEvXbHtuiUqINVOKMvbIHQ
HT643PYbkocpc3r+bvSh+VSNeySDyLePT33iPU8oCYecnxHQl3K6u4WWjFlDIG/a
JBA4o1XftWnF8mekKqgoiK1JBNzL21urC48I+MYrlF1z4M+w/EhlCTzjx/NW7E+e
8d223OJpwZNEJjHNtSUjoAfgNOXGAalBGSVaCTbWIpAAIxfG3/LfQvXEJ3u39uPT
uthplY1STSlLBt5MM4Edjr5mh9NfLsfWc274l48/aRqkANcI1RoKX7smqx/MW2sd
aQiPshjetgumf9v1Gs158I9+qf7bI/9YHjPrjdGOF1CeSP3/n1g=
=y3Lm
-----END PGP SIGNATURE-----

--scF6bJM00/L+fOlH--
