Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F120FBFC
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716987142; cv=none; b=gsQx0LcjycsPcUKSFKO85X2f2j08hhpQeiDgtcTHeem+rlF9v0wxy3p+UgCxVshG9z2bBgUvNH68tjQ9JVPTVQqREsekcRG0S2mLB2b+q4/WZp8HBmq8eFaixSOAG6OPqEY91el5RHAZCURWXIEsG0SqEq2308IdQQgNHl8G0Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716987142; c=relaxed/simple;
	bh=avEAkYGFPYsj1F7zHiA50LPIUrovToUHCTCvGQII7bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AlZUXg6ZNMQzH05mYDtR5g1McSdlzwpuGZmzIo2G67mjbe2BVKvXqBJC5KvjWJmWR6QFy7HrjysKRE2/PnD4/Qq4b7Zu3JFNj8CIijzpY8xln4mXBzCGEeVwk7d4M8Fdz9QdcGi8YolA7p32nkJRBraFuGNwsAvc+9X/UYJ72co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ipP98THI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X87HKhSH; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ipP98THI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X87HKhSH"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5B36E18000A7;
	Wed, 29 May 2024 08:52:20 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Wed, 29 May 2024 08:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716987140; x=1717073540; bh=9wSidALfOz
	5ZTIQkdwwQKvhjweO4UwNG85YiUF4WvhY=; b=ipP98THIu6SPdwi5LZvPxXLrJa
	lqoDCaITSLlYdn3Kmw3z7g7DbJxXYaJafIXptJ+0dhTqKGRHUZt5JuvHO44QAAwJ
	xQ0Y2Xxz41Emp1ao3If40dCosqqup/+qSMCAXOToyIONgxIsQhel4Yr+EQLLxm3+
	6XXS7T/ZpwPRInhYsf5CNEu6A3PIRLEYh6VmaaAqByMbWwagv7wVBPl0umEiPXsh
	9m57fwCFaHyUH+HlL++Unmvex4mt/aWBQZ7qLR/BjdgNyeH9fYaj2GFjrbQqdkmE
	w9y+Rq9dEck3Hl40zVNqtpOEg/qD00d35dek3NSKysNHkmhQFOO/Xo6bkzrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716987140; x=1717073540; bh=9wSidALfOz5ZTIQkdwwQKvhjweO4
	UwNG85YiUF4WvhY=; b=X87HKhSHCRVZc9VektaFVnRGxbTdS3ahFGNOzYtdKsK1
	dr1Y3ipYMlzedFtKcElgMKiTyxtiwCVsTtXwqj+vs3BchPo6yFa5xNHx5jTY0Coe
	quZndCrwIKn4zlxzHrcvkhxC5Qwor4sRqX4cioPEvbS9Bm3krE4j4NGFudh1zAmf
	IUzWmNb9vP216XH+xhuwuDo8/RIPcrEtAy5zyKtpNzwmG4EACi79VI1SEm7LuMID
	KSyWnNqaesEXTdhY5+TtRqIDyhw/IWGnpm3YKAQDa5i2DoIe7zbhrhOnw43fLG0O
	YuSr/T/YeLq2M7NtucjNMFYiLblkRCTISDl54KzWBw==
X-ME-Sender: <xms:AyVXZu-oJYKhR-Zvre_FaocgvUD5Oasvgis4A2OK4_4FOUFhG7dqXw>
    <xme:AyVXZuvDGYYI_Falr0aOnu_g9w94l1x1XvraRMBW4X6uM2XWfUo7Onsj-ku_n2QsI
    aXCKsOom3GufKkFcg>
X-ME-Received: <xmr:AyVXZkDlAZ2eV_5GGJjf_UHSsKqO4fZO6tXzfYmvNYDQCE6Io4qzf12wajQAK2NiivI2IbeqEBiSbpY_gZR1TBfb7HAvLSGixrh9Z9v8z5OdASkc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:AyVXZmeIqamQi_yFoeWn5LvY1XQZ7RZ9N-5XJsnudW8--5OGRhZWHg>
    <xmx:AyVXZjNi89rgAwtN8LQU79Oxgoz5ksTqWbKbuGSJGG1Tj9u5GtPqnw>
    <xmx:AyVXZgk-xSUEJ2AoQuAMSOTfEhetH-9SfXw_1VXuAcpoQDjtHBsv7Q>
    <xmx:AyVXZlsRobvxjZMgb9EgnGqgJC8majahx28RPOfUQSkTUgFQcaHkyg>
    <xmx:AyVXZsZih_6jHWSwBECqIItrlKFDJWA4qh6u_kU_PeOIf6EDSSWfhUFG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:52:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id bb896f67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:52:03 +0000 (UTC)
Date: Wed, 29 May 2024 14:52:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/19] Compile with `-Wwrite-strings`
Message-ID: <Zlck_1vQo8FokpZI@tanuki>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Gkod4JfBaL07EEpS"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--Gkod4JfBaL07EEpS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 02:44:01PM +0200, Patrick Steinhardt wrote:
> Hi,
>=20
> there were some recent discussions about compiler warnings and how to
> stay on top of breaking changes in compilers in general [1] and about
> string constants in particular [2]. This made me look into what kind of
> warnings we should reasonably enable, which led me to the following
> list of warnings that may be sensible:
>=20
>   - `-Wformat-nonliteral` to warn about non-constant strings being
>     passed as format string.
>=20
>   - `-Wwrite-strings` to warn about string constants being assigned to a
>     non-constant variable.
>=20
>   - `-Wredundant-decls` to warn about redundant declarations.
>=20
>   - `-Wconversion` to warn about implicit integer casts when they may
>     alter the value.
>=20
> This patch series adapts our code to compile with `-Wwrite-strings`.
> This option will change the type of string constants from `char []` to
> `const char []` such that it is now invalid to assign it to non-const
> variables without a cast. The intent is to avoid undefined behaviour
> when accedintally writing to such strings and to avoid free'ing such a
> variable.
>=20
> There are quite some cases where we mishandle this. Oftentimes we just
> didn't bother to free any memory at all, which made it a non-issue in
> the first place. Other times we had some special logic that prevents
> writing or freeing such strings. But in most cases it was an accident
> waiting to happen.
>=20
> Even though the changes are quite invasive, I think that this is a step
> into the right direction. Many of the constructs feel quite fragile, and
> most of those get fixed in this series. Some others I just paper over,
> for example when assigning to structures with global lifetime where we
> know that they are never released at all.
>=20
> I also have a patch series cooking for `-Wredundant-decls`. But while
> that warning detects some redundant declarations indeed, it creates a
> problem with `extern char **environ`. There is no header for it and
> programs are asked to declare it by themselves. But of course, some libc
> implementations disagree and declare it. I haven't found a nice way to
> work around this issue, but may send the patches that drop the redundant
> declarations nonetheless.
>=20
> The other two warnings I haven't yet looked into.
>=20
> I ran some test jobs on both GitHub [3] and GitLab [4] to verify that
> the result is sane.
>=20
> Thanks!

I forgot to say that this is based on top of 3a57aa566a (The eighth
batch, 2024-05-28) with ps/leakfixes merged into it at ebdbefa4fe
(builtin/mv: fix leaks for submodule gitfile paths, 2024-05-27).

Patrick

--Gkod4JfBaL07EEpS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXJP8ACgkQVbJhu7ck
PpRLfg/+OMZJIhNtWuyzYMYMCLxDSKfEoVzP+c60GnrSB0H12R/HisiFVdZoPkLb
x6/qQdP8kSl3EZFeOFkFAA3ixIgAW8cX6bygeNW7sbaeJ44xOj5cJnsD6I1MTrnO
O5WHQU7klbO0Ty/004xi34aDmSF5N+bEsV0I3yQCj/XVrtvo1gyF8hmTRndQv85y
rLhtumrjLHizbryzH07uhXV40/yhnzTYvcwCdTYCm9bmLF9bCctcZCi9XdXd2cm5
cY6G53a6hVvXojMSx0td3oDqWwEgju1BZaWyG8ELz7cdfEdeWCmt6tUtSsNM8YCg
iXL/avNhATB8Crp3Wk+bANxn6wLxbBah9GBwzLFTv7yV+dQ2V9SrkFXvibbwfc/x
7GPwM4TlB8tpTQCQEh2SBd6WCaVGn4gBh1BQj/SeN26kLQQmCwiL61j114Bzw168
MtLhoIusxlAywlAnZKnrDYIQFxUSh1yZFuao1dhb5JGPB1Ct01YRsahS+AZXEoSZ
APKamCGJrtxQb5XeaOhPfqdUdVGfqCLD62EhRma/D2+WTLGP8v04RCU8jMwWf/8w
8cm19wPEMbQWXKk8EZgHr8o+pnY19bD+Mm5sFp0hxy89fiOfijvGbVnFI7vAwi2s
3z9srtgDJlsxpgL/L9jBBbwFL2fd59AQExx125WFq2vo7DARLbM=
=8iII
-----END PGP SIGNATURE-----

--Gkod4JfBaL07EEpS--
