Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C8538C
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708756591; cv=none; b=m63cfLQCChdVW2YyJdccfY61LbfHtQsYqwB2lEc+ecwEiDqP7y1UbPr7+xoXXaAendL2SNykaOzUvZu3MnsfzjJRSsNVtVY3bciuqgEEOTx9k7jmGA0HtBcTO77tpLsWjYukE+rnerad+7lQpTRPpshczdMQPT7TZLnlX41vGo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708756591; c=relaxed/simple;
	bh=hPY79wZDVPWr8b5OmqYMKVq5xn3Z1FO9KfUE6/TRFsI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IeH1dKEAGeFQLt16xOYg9binrjIQioqCffv3Z0MPkcC+LZrUZNlW0cC4MDGCru0LTettwrplwJtiMN10fCrsKWoCE/yuaxG/8PMptA6mos7kQNoEF+R7BG90b/CcICa6lwIRd7RtksFbrYeYqCCdb6qBKwkR3sM7V87ONeOHqeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BnQ6vtqR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=efDa2cTF; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BnQ6vtqR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="efDa2cTF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 38D7011400D5;
	Sat, 24 Feb 2024 01:36:27 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 24 Feb 2024 01:36:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708756587; x=1708842987; bh=W0+smJsRtZ
	FacO10MdjGipaBthjwKTvq//7WJHveJRo=; b=BnQ6vtqRByODgThp8y+MDJV5my
	H4x92NrrViCdY1Vr2sXLSoh9psPauhRcs7YY7BwHdydFdFj2KjxyjKJ1UAkgQeDb
	kmNjT5cq3LAKxkG5pdn8CPJenv2XhUCCRLAIJri7MjwQ8bNHcjtz9udn3D5CxB3f
	54xOu9QuPOWXQ+PIv4R0npGTUfPG5xzwSMYgzyayY5+k+4BE+C7UjlY5k8z/hH0O
	aIRr+7mjqx7crV7L89nI2wcSITdcq/b3mBfhg60jLSHHY2/7pAQt96ZXi6MizeMF
	VGCsLyXXzIUa8qUZadkmP7sEaZg3heFYvNb+sd9wlaQZpiotZyWo3b+x7amg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708756587; x=1708842987; bh=W0+smJsRtZFacO10MdjGipaBthjw
	KTvq//7WJHveJRo=; b=efDa2cTFdvVCIK4CF8tmRZ+Tkj+hu1T1sCe4BE33WzXu
	uZkez0GTbX+bHy2JzgOEus0BdNnt96PNZFyQ49iCx6SB1COt9nCYvcR8NzyvFgmF
	E11Em7ihSm4isSjJAGVOKh2mmh4bbNrkqGfWz1mzhiGqzvKsESz4PHkVaz4vRqpn
	fgZte5X6c5jbMSoOBHmP8MtEGd7lSKn6mxRQnCf5EkeRD9ZVDlVUWZU4TKpzt664
	vG1cp4/JwwZv1hRePsmQlcNzQi+UjHOIZWv5IKqv2JIvkkE7uNklI54L7Yiqhqml
	zNyTIoQYmfwB8BwvsfO0JRg/5RhlzN2LQ+uFZHg2Mg==
X-ME-Sender: <xms:a47ZZdz7Az5X8PyAy-NaD1dS5zL6_2h0sBgqFgW0VNrFFW4YRA5C4A>
    <xme:a47ZZdQAwDrx9ANe2XveX_e4or0qu0gePHExZ43Sv5nGaQfFIbTtEGlYvdHK0Pp6o
    bfAPL_raZ7fWXc87A>
X-ME-Received: <xmr:a47ZZXUqTxevURMzinn_ITOd7A5ZT9llnG3WEiurRXqqjS3-oRbn7Q-B5CG6UMWoCCoA9Feq2HM_2FDTrmOUUp6UbDqtHFxd-nnzASpHilPzLqBl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeejgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:a47ZZfidmes_W9_Si3p4fjC8wOpSKnyV09-vsAMheRVR0dM_NE5fFg>
    <xmx:a47ZZfDWOEEHPuaamS1UEZGH0wiH-8wZioALMWj-7YonWDQMpWUUsQ>
    <xmx:a47ZZYLAdZyv3Xl6Jxpx9XbURd7X1iY9qpInwT94hMKgKeRPSssjBg>
    <xmx:a47ZZa-fQIJdynaOKrots-a6dzjWYfLI1KA3uBqvycaS7MR1P3ymcg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 24 Feb 2024 01:36:26 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e59091ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 24 Feb 2024 06:32:13 +0000 (UTC)
Date: Sat, 24 Feb 2024 07:36:21 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Mike Hommey <mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	git-packagers@googlegroups.com
Subject: Re: [ANNOUNCE] Git v2.44.0
Message-ID: <ZdmOZRjJ-mClBR02@framework>
References: <xmqqbk87w164.fsf@gitster.g>
 <20240224051040.ftuo24smozqugbde@glandium.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="InqMLgLNVfxIuQNA"
Content-Disposition: inline
In-Reply-To: <20240224051040.ftuo24smozqugbde@glandium.org>


--InqMLgLNVfxIuQNA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 24, 2024 at 02:10:40PM +0900, Mike Hommey wrote:
> Hi,
>=20
> On Fri, Feb 23, 2024 at 09:17:07AM -0800, Junio C Hamano wrote:
> > Patrick Steinhardt (139):
> >       builtin/clone: create the refdb with the correct object format
>=20
> I haven't analyzed how/why exactly yet, but I've bisected a regression
> in the behavior of is_git_directory() during a clone to originate from
> this change.
>=20
> Here's a way to reproduce the problem:
>=20
> ```
> $ cat > git-remote-foo <<EOF
> #!/bin/sh
> git config --local -l >&2
> exit 1
> EOF
> $ chmod +x git-remote-foo
> $ PATH=3D$PWD:$PATH git clone foo::bar
> ```
>=20
> With versions < 2.44.0, it displays the local configuration, e.g.:
> ```
> core.repositoryformatversion=3D0
> core.filemode=3Dtrue
> core.bare=3Dfalse
> core.logallrefupdates=3Dtrue
> remote.origin.url=3Dfoo::bar
> ```
>=20
> but with 2.44.0, it fails with:
> ```
> fatal: --local can only be used inside a git repository
> ```

Thanks for your report!

This has to be because we now initialize the refdb at a later point. The
problem here was that before my change, we initialized the refdb at a
point when it wasn't clear what the remote actually used as the object
format. The consequence was twofold:

  - Cloning a repository with bundles was broken in case the remote uses
    the SHA256 object format.

  - Cloning into a repository that uses reftables when the remote uses
    the SHA256 object format was broken, too.

Both of these have the same root cause: because we didn't connect to the
remote yet we had no idea what object format the remote uses. And as we
initialized the refdb early, it was then initialized with the default
object format, which is SHA1.

The change was to move initialization of the refdb to a later point in
time where we know what object format the remote uses. By necessity,
this has to be _after_ we have connected to the remote, because there is
no way to learn about it without connecting to it.

One consequence of initializing the refdb at a later point in time is
that we have no "HEAD" yet, and a repo without the "HEAD" file is not
considered to be a repo. Thus, git-config(1) would now rightfully fail.

I assume that you discovered it via a remote helper that does something
more interesting than git-config(1). I have to wonder whether we ever
really specified what the environment of a remote helper should look
like when used during cloning. Conceptually it doesn't feel _wrong_ to
have a not-yet-initialized repo during clone.

But on the other hand, regressing functionality like this is of course
bad. I was wondering whether we can get around this issue by setting
e.g. GIT_DIR explicitly when spawning the remote helper, but I don't
think it's as easy as that.

Another idea would be to simply pre-create HEAD regardless of the ref
format, pointing to an invalid ref "refs/heads/.invalid". This is the
same trick we use for the reftable backend, and should likely address
your issue.

I will have a deeper look on Tuesday and send a patch.

Patrick

--InqMLgLNVfxIuQNA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXZjmAACgkQVbJhu7ck
PpTY7w//eUbqRXOuVqracVkaDQ9Bg3wqC8vxBhxoUpRWUtkVIzLUh9R4hnW4+DV+
Si6zKozUIHDhVyepR8lzreIVnmIz1XZUkATkpy4LDqP/EG6Viqt4ECFQACyPnWE5
EXf2weTr8UneIDxZVaz5CLQ5hJ7dX9U5M8xagxtI3iZnL5dVIyuBbwHK4BvDK3bl
v+2EkyQtrzbx00zjpHXTUvVyXQivpg4gPp9dfldOWknfrknrNUK+3yI8+UxjBYyV
TFuw/n3ImVjHz63WGgq46kqVR4L1GHoHlaYdvRXWqrtzXxhYZlZqC9aFdDQJAbo9
aKzIkNH85EJzCi/gAOUwGjv0oqrG2IMldUn2pFE+7p1xypspwNcNeTPwuTKvAbBH
cBC483L4d4P4865qNDBfmer4qK2mAjvBg8wsPXq1/ev5AWqZ+YpQk3AHIR3Su3iP
9pokZyI/wLkMRZSG1Aka1VRTAeUebponUqq7fF34wbIIagt36CoYYBJTWaKOFv6y
SuDAuno4WZPMHnTXiLd/csMIzev4b9htRlcVXtrGy/3Znw96/BUZtfl6jCxzavth
ILppQIiNhNO2EbADQM9t9jemQN4ZIJmd++jZXzAqVXlHsmnbd/JCzPPQrXpcJUyQ
ZC4X0MMGD5FOzLD9EWJZtZFeJjh+cZAPArpozeDX/aBg45NaWPE=
=tURc
-----END PGP SIGNATURE-----

--InqMLgLNVfxIuQNA--
