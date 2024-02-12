Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7D46FBF
	for <git@vger.kernel.org>; Mon, 12 Feb 2024 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707722145; cv=none; b=unylOAIPF5RdtItAZmylgwGsPXJ6jfaXLqYxK0BhsBu33YdvEqcNP8tNowwgIN47CZkZ7X01PlCR/ttTwHlZnfiOLk8JW4FSwT/YdW+DMd/6f5FlmMPb6Q/aHZ62WZSDVlwlD9VlMBzIBH7iPphVPNIcsI/y9gnmakZ1Sw7Br84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707722145; c=relaxed/simple;
	bh=NfK5TkfuVi2v9d9xwsfacvyZDd2vGrNkCQywEiHR3/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKCA5n+NhQ77KQ/uNNnihJwIwd+sk5OFNgz9Dii8646cvsl2KjhhkcZCF7NWarPTQOYlAjgGeMbNBRF+AnI35G9jl/JOR4/Aww/lFvofXsgC5UvwfouRKYb7i8vonFH8jTAdRQCSR787LmU5wqHAKmG/ggbNwxblcb9QYWdYzRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gU/jc2FV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hxNsxllS; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gU/jc2FV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hxNsxllS"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1508511400A5;
	Mon, 12 Feb 2024 02:15:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 12 Feb 2024 02:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707722141; x=1707808541; bh=NfK5TkfuVi
	2v9d9xwsfacvyZDd2vGrNkCQywEiHR3/M=; b=gU/jc2FVGeDZJPuJtbYGPPOoXC
	GoOPMPbQygbLOdbhX5XNBJy62/ipXwhGo2fDF5zB9gxLg5CR5nKT+PuETLaEEUAU
	63Ol2GXNzpYkBsMMR9rP6xfvf+jvFpkay8mB0DRF5vSqjs94sgmotatEI4gF53F0
	g3VSMhT8yZPfoQhAs0sdcPVwQ0JI7XlzDV/KPaVnCbnXHzk/qS7tIzlaPbJpLiSV
	T0eH8z8BJk/99nBxBWhr8Kv6a9Gsq9a1zjgaG8kjunhUCV50PRbSeevdvUFdyGWx
	meZn2On0SsaiW1UzjOrN2G9jvD5SxY+zDRvpBpd4VzPpql63hPzzwAJF61Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707722141; x=1707808541; bh=NfK5TkfuVi2v9d9xwsfacvyZDd2v
	GrNkCQywEiHR3/M=; b=hxNsxllSK10iUNX7WDpANcumqS3b7ySmH74xrwpY2t9j
	2eZVKoVGPT37CNwLwy+cRrnWsakZweZ05lRnvXUCCiLdpRefjnS5MWm8Pxpd7yts
	R+dY3c2QUcYwrj5+jyB7QwiFmmT8Ikh/bOk3HhmjF+9QxViE93lOOUgD2C3zpQbb
	qzdAZiwbWEufhazSkgK4pAj0F9TLS+jIjwwAtXGE+uKFxKmdeDBC83XlV2SLSCBV
	4M2FAIB0+ubL9F9MN6sK/qH4ev+3tPExiiCVJta4UfV4lRlFDJI2sFNuFiDcaBKa
	+ZHSFJTaKgkc99U0DAaC8DifDpQJW/Ge2YynCeSRPA==
X-ME-Sender: <xms:nMXJZVXwEmIpDfP6mi_xvlwUNnaP-UXHQ6nRqEGhVjphHCvgYcdqlA>
    <xme:nMXJZVnOTlK43Q8eHHHmv_igpe0TkOWvWKUOTTX87aqhoa1llvWheYKOJWh7DcYXy
    oz0H8m0qFTq6V2bhw>
X-ME-Received: <xmr:nMXJZRYqXjjLrKeqmL76B8F7wWb4jUj-kZ4TUQ077IzM1PpP0OMEMju0zFbZL1EiCalZBEnrIZzpN1TqEinGTkQS6YDzgV3gGgbs_tLrAXb71AI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddvgddutdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:nMXJZYUbE7-w2bmc-7evrJqvY1fWZTO-fxnfprROYm8UnYp736qt9w>
    <xmx:nMXJZfn5u3Z2V1CzHoEj6NghoNi84sAPpbt0jor1qSKKS0pSz_hjwQ>
    <xmx:nMXJZVfBEVGmpO7zdAN2PKCO0k1gx-3CwYNcvMsCcz-0JvqWfouNQw>
    <xmx:ncXJZdhamlrDsAmTD8f9FNKEqP6TU6qDDeN_exK_Ryi3d0g4MwMALA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Feb 2024 02:15:39 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5aab29de (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Feb 2024 07:11:51 +0000 (UTC)
Date: Mon, 12 Feb 2024 08:15:35 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Stefan Haller <lists@haller-berlin.de>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org
Subject: Re: Interactive rebase: using "pick" for merge commits
Message-ID: <ZcnFl8kypKRYeLo3@tanuki>
References: <424f2e08-a2ad-4bb2-8a6b-136c426dc127@haller-berlin.de>
 <ad561600-faf6-4d3c-80b2-34b3d1a1b99e@gmail.com>
 <65c65f6b-5ec8-4fa0-a17c-0f2c0d32b390@haller-berlin.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Fv+jdl/u5tFNjkOz"
Content-Disposition: inline
In-Reply-To: <65c65f6b-5ec8-4fa0-a17c-0f2c0d32b390@haller-berlin.de>


--Fv+jdl/u5tFNjkOz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2024 at 10:23:16AM +0100, Stefan Haller wrote:
> On 09.02.24 17:24, Phillip Wood wrote:
> > On 09/02/2024 15:52, Stefan Haller wrote:
> >> When I do an interactive rebase, and manually enter a "pick" with the
> >> commit hash of a merge commit, I get the following confusing error
> >> message:
> >>
> >> error: commit fa1afe1 is a merge but no -m option was given.
> >>=20
> >> Is it crazy to want pick to work like this? Should it be supported?
> >=20
> > It causes problems trying to maintain the topology. In the past there
> > was a "--preserve-merges" option that allowed one to "pick" merges but
> > it broke if the user edited the todo list. The "--rebase-merges" option
> > was introduced with the "label", "reset" and "merge" todo list
> > instructions to allow the user to control the topology.
>=20
> Yes, I'm familiar with all this, but that's not what I mean. I don't
> want to maintain the topology here, and I'm also not suggesting that git
> itself generates such "pick" entries with -mX arguments (maybe I wasn't
> clear on that). What I want to do is to add such entries myself, as a
> user, resulting in the equivalent of doing a "break" at that point in
> the rebase and doing a "git cherry-pick -mX <hash-of-merge-commit>"
> manually.

It would be neat indeed if this could be specified in the instruction
sheet. We already support options for the "merge" instruction, so
extending "pick" to support options isn't that far-fetched. Then it
would become possible to say "pick -m1 fa1afe1".

Patrick

--Fv+jdl/u5tFNjkOz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXJxZYACgkQVbJhu7ck
PpT6vQ/+N18meJQhxEPz2QIun3B/T68rNC8rPjd2oTtEgdmHBC1SPMaPWsQXQOku
eNDuUZK+tytPZ+egSiYynqJFeerLvHrGOWgzBVSXkHXsPXqy77hR7ydlGb346EYS
zGpbBCdkfPfn1jBQZ/1UV34jK29rD11pBDgrLLENk+dh+S2zcJcOKcwItzgg7fHI
Hq77xngaYsCZ3VqIdNkCt/Q2oaPAn6Yr1GxEjxpT52kYauXiZRhTsX4/UBHB5EuR
uXPoXXwdmpmdHFLUX3x+BKmydAnhQd01jWlgyUh4zA8uMv2eBmgQfTS7avQCHRsK
m3bRi4ox0xYIgshElHiopL8UDShOARob93Q4/mDKH3botvU4lSrj5vU616Aib+yY
tSNSxuscYnL7jJiWb/9lXlDUWXoxIp08BBRNBE/Yh+Xw/ZRns8lYt+YzvSxA21PR
KGF2aHQWbf6I9dhYoPhIHgOAx7q/Np2hs5xWAA4NACxSn7RBk722V8yEvvDE20cZ
WZTCOGb1a76cHqITaHKKzyU2OU2zbnr0JtXcnNwN5TPgsIO1hjHJxHtqWKnPcBPi
EhdSeO+Jc3BeaAMFh1ntb/XvpvcOJKRXwpMe7+x5+a9albpdalQthMY3nhkT9sf3
1jMWxBHoywbsyelXiqKDbXluYPOMjXjtk/no1sBX6eHGv7xvraM=
=Ansb
-----END PGP SIGNATURE-----

--Fv+jdl/u5tFNjkOz--
