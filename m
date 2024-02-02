Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D90F9C2
	for <git@vger.kernel.org>; Fri,  2 Feb 2024 05:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706850670; cv=none; b=lvixtNyTsVqPNx+CEiL23t6cXVbPtE1+K2Nrc4VBx7HqGcGHwFnWznjtzmn28f3EEo9N5gS3/WecWglOUDLhjwU8uIyIfYzx1+R74UhD6ITJJGtF7hp5ZvNEVqmQ5cnWnRd53HBHDl7nHkR8QULEdzLo5UbxgwJ8xiVxHQikph4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706850670; c=relaxed/simple;
	bh=Qx+AdwnnBewaApPy67uhq+jmA/xh8f3FPUG++zlRK4g=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wg4B6NYWFfzw1vraNtTeF7KnNs5vX0q78Y/iQgebqG8z2QE7wUYTPZf+Jxcr7BjSKPPGplrmfEEeezLO2oPyIJWYLS0d38CUQwmV5xmkCQSxqY+63mNkYUAH3fbSQcm/Sn4/cu+bxqIP7pttM8L+TgXTvcAuWXqe8heRR3/MWOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=A1MnTn0L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tdYruaU/; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="A1MnTn0L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tdYruaU/"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 26AD61800081;
	Fri,  2 Feb 2024 00:11:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 02 Feb 2024 00:11:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706850661; x=1706937061; bh=/qJ9R7MZFM
	znKMvFg+3a0DizySa+0ck47GENVKZhlG4=; b=A1MnTn0LrO/q3ogV7lgZASbwOT
	P84XdHVuvNO3YUPPKS/A6qZdVSDc/DX4WnKfAJqxzr8F/rUg6vGDWgLjHtWvnSFu
	8zZ9UzikL/70S/PUeSIk0argCpepo2kzzfP1sn5dCDfSU0dBnJn0hSy2Ym+buYRz
	JPAPkwQGPR9SApBmKDL1vN0wlyZLLl4oqATp+oU3aQmvI8l/3hIMevCK8pOFAwzk
	ElRGIKRRLbObItXMKFRIw0DQdOSPXdQUeyn/vOZTVe5BusVwjijh9KWXVgNo40Gl
	8YA+10kfiRQci1BSSK8oudPZp9YtRO7Gp+x0utMFLxUEYuRCO7GejgtMR5bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706850661; x=1706937061; bh=/qJ9R7MZFMznKMvFg+3a0DizySa+
	0ck47GENVKZhlG4=; b=tdYruaU/5sjPQEa/nM85ga4sGuHk8Qjr3DJALeK8hRb3
	btb8E5hnJko7oOuDhv3ND1ERugF3jL31dHspT8Y/Asjc5kHGGhtxiD4ZXH5Irz91
	bIOLVG4jopiQNqbacmPCHl9XKNATIX/US+dXIV0MhKFPJAR1LWMVJGFRdc6XcDep
	xsTvERqxUxu4g9fdyTvwEdzjZnGe8L3w1o758bZ9QFuwXSAs5gbrtw7DjXSYIUpz
	I4QTTOVELBOltcfKs1AZCl2OE1WybsAKlIIRO7mR6uKN/71j0ptfdDlCWZzWVAhp
	k5lBzQT996PZDrsL8nyx3LRy4+vuWGuXlCkRHt/o4g==
X-ME-Sender: <xms:ZXm8ZRIkOIJjtWH5NxScZuRjwBhN8TopJLc2500J_i82nDShkZ7cjA>
    <xme:ZXm8ZdKj3QY7HZ-kL9UEaZiWkatiNHh2ME3-BrPdSa2vtiscL48trKS9hplbDIJvZ
    V_Tuvz784g_m7IP2Q>
X-ME-Received: <xmr:ZXm8ZZvEhSazp73l-_TKkNreN0SDDS3RQZQyTnfmJimJScFtioFrML0jV1xaHZC6yxIwVV9llwUJQb0DJSimjbTzs5S0X-OL8sKaL62d9pGLIg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedufecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepgf
    evteekveetieffvdevgeefteffheehudfffeefvdejgfduieffheeuueetgfejnecuffho
    mhgrihhnpehgihhtqdhstghmrdgtohhmpdhgihhtlhgrsgdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:ZXm8ZSZkX4PwQvnJiUx8jWRjLRinIfGIbr388aS-fteydkJQRGdUWg>
    <xmx:ZXm8ZYaM4yZz8k_gQwgldyE0avDLaap2kLFoh-tWK3RmmUFYxm_XDQ>
    <xmx:ZXm8ZWDVkT-RWFPNcaLrGdHq-PkfSSj8xSjl19Z123f7y0wx2-QXmQ>
    <xmx:ZXm8ZXx8iNh9_P-M64a_ORA3h7vvHAG2MDXHjal4hESXm0BQzp82DN8GREw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Feb 2024 00:11:00 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ce84e5bb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 2 Feb 2024 05:07:34 +0000 (UTC)
Date: Fri, 2 Feb 2024 06:10:55 +0100
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Hans Meiser <brille1@hotmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Migrate away from vger to GitHub or (on-premise) GitLab?
Message-ID: <Zbx5Xzb3kyHvkp7C@tanuki>
References: <AS2P195MB21350F44B079009C05A1EAF1E2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <AS2P195MB2135D91EE464FF30EE84E77EE2432@AS2P195MB2135.EURP195.PROD.OUTLOOK.COM>
 <20240201-primitive-aardwark-of-contentment-aaabb9@lemur>
 <DB9P195MB21301E5E271567256303443CE2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <c3b6de0c2ccf71f0dfa5aff06fa63d8f@manjaro.org>
 <DB9P195MB21303B5546A764A18FE78C97E2432@DB9P195MB2130.EURP195.PROD.OUTLOOK.COM>
 <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OxdmwzN03inJQdmc"
Content-Disposition: inline
In-Reply-To: <ZbxI4wNTBZ48YcTi@tapette.crustytoothpaste.net>


--OxdmwzN03inJQdmc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 02, 2024 at 01:44:03AM +0000, brian m. carlson wrote:
> On 2024-02-01 at 18:36:48, Hans Meiser wrote:
[snip]
> > In the end, it's all just about git. You may create your own git
> > webserver (https://git-scm.com/book/en/v2/Git-on-the-Server-GitWeb),
> > or just use an existing one, like the GitLab server:
> > https://about.gitlab.com/install/
>=20
> The Git project has tried for a long time to be neutral on any
> particular external piece of software.  Installing a GitLab server as
> our preferred development platform would promote GitLab as the preferred
> forge to other users.  Similarly, moving to GitHub would prefer GitHub
> over other forges.  That's not a thing we want to do.
>=20
> We also don't accept patches or features for the benefit of one
> particular forge or external project.  Patches and features must be
> of general benefit to the project at large.

I think this point is indeed really important in the context of the Git
project. It's a rather unique limitation that no other project out there
will really have. I don't think this has to completely rule out the use
of a forge. But in my opinion it completely rules out any forge that is
run by a for-profit company and that isn't completely open source. So
GitLab, GitHub and Bitbucket are not really an option in my opinion.

That still leaves other forges like SourceHut, Gogs or Forgejo. But the
benefit becomes at least a bit more questionable as the barrier for
entry is again higher in that context -- after all most people only know
about the large forges out there, and creating a new account raises the
bar.

Patrick

--OxdmwzN03inJQdmc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmW8eVoACgkQVbJhu7ck
PpSpoQ//YKCmm4NjJDu/zpCEnkz3MNukG7YZFtd8Ty/zuXeKpqeq4EzFxuu4ZaVk
WWM+PaMVbvbSksubVVfC+8UpyzmOpqBQTYqO0AhVO9cqhQTpgfSqy1WoHckVxtZ/
UsPlY0mPLBGtr6NT0Te5P11snbKhbdw0EJZ4Yh07mwvOgm/ruHPFKkOqslEWVMGZ
z0eggR3xylU85nG3kokLoiYb49BtJNrmil9AVrmAmMbvXcrlduRJhZ/stkrKohR8
xt0uxEPgZjVQ7S+oHuUIDC9FS6BBQVyePJeeOHHVTf5Yg5Xp17DWabBfkSzk4eyi
Qk3JXd5DJ0cYOsymlIILWnx3YXPucyRj8Xd/BMX9mBprWzGfMx/KJ2xaaNeNXHwj
SMfU17CdRUGMzhL9G92Cdrk3P2IOx4Cuzkstlt41KkAm7wwnNNWiwOcSNIoXGN5c
r1zxu+kBvnNbOMIRD2T1rcBR7lCPYxquFmuX/oizwMomXmU4LP3Co5CsoVfc8vpm
aAkRJC7ClrcJfoBgvZbP3On2+KXSmjscU74ovQok5dz8LEqPo4jgZr6cu81ccU8k
Ne9PR2rgtZTI3dna369wQNJFyqB3pVb4pC+mz1BHFbvzsYJK7rGhNcP6X6zHsuK2
aKDWLB+xVXhi9GHnyOl8ljeyJ+YCwVeVp3+dZoCt+fZCDI4w+0Q=
=pXCw
-----END PGP SIGNATURE-----

--OxdmwzN03inJQdmc--
