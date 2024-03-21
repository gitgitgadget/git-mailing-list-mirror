Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6691CA83
	for <git@vger.kernel.org>; Thu, 21 Mar 2024 12:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711025316; cv=none; b=G2jw1cSFCuzXFoihmE+1rdeTUIr/mAdnP6qbAvo/NesqYGGny/bOVpdqRVQQi8MWE0Y0D0T9nR9UXjWuRm/CGU77yVNqnzHCKSzXHpUWfDta9yge5DerA+tjHFsLOOliPXxZp+XZ9dFyWRvDKuPExVBgRNXG3VGb/ZlFsPAPI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711025316; c=relaxed/simple;
	bh=1wJE0CRjiZWu2F2OnuppV5NjVznWcTs4y9zUdKgzVYw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EP6rN2Ino0thtKVMA7hhnMmOjQK7OKb1ACtkS99Z3JCl0jWZdeTBn4AzJkHa7VCL95/m805VhXuJ1p+RjnKz42p6ybg6WioErQ/bc0+17zUCxVrxv4TTMePfbbtwdxB5Bleu2Tpttglox2zORx9FlGLaitRblKXmjBEt7hRCVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oEg08a/H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B0n63kPC; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oEg08a/H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B0n63kPC"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8B81918000BC;
	Thu, 21 Mar 2024 08:48:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 21 Mar 2024 08:48:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711025313; x=1711111713; bh=1wJE0CRjiZ
	Wu2F2OnuppV5NjVznWcTs4y9zUdKgzVYw=; b=oEg08a/H3rlLC5TifkA1BvnDx/
	RTc0jgPfNvRBmF0kl7iEsUIsVwt4eeZVNInBPfBySslPcmVPsxFz+7f0JXYxjsRv
	5YIkMcVsC1dvoPgeq+3dxwrWRaO/wEBGz849c7qY5miS0mHNDJZ+YqcPl4O/eDeX
	X6eGMyKvtF1dyTyaVQ/EmbCk0eEVnK/knSWAUAuPp/wTFeGIxj9uGMxUTz2wg/4y
	o5Y0H2I2WfJN/qoraVoDoWhcqYB5VRqi2C+HFXqJNj4L9yv8sHfP/HyUTQtDO+Hy
	qf4NsPove8H/O5nDhleGlzshC3yBBYMai+FIjyseKXXY+EcBRfYJyy8OrBGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711025313; x=1711111713; bh=1wJE0CRjiZWu2F2OnuppV5NjVznW
	cTs4y9zUdKgzVYw=; b=B0n63kPCW1Baa0MuIMcc5Y1JovSRm6sbaZgpMNDD85n+
	t8Wvjjv3061mp0xyztU3SvlBXNK5JRweSTBSXyHWZtSgrAXgBM4MSlFZFBof+UFD
	nML+UWL9XeropnhlhE9ujjuLp3U1YyJXUgftlJWD70lqUjuGojBEBwdwKgTX4Gx3
	OkcaCL3IJ7jqd/q985AmJre2XO+33O1J+TOByXN2ZmLdMcwY/aJe0+7zjmLJY1EU
	BVnqnCa7yR33+r4WHWmHKHm5y7dGE/sq7CsX4aLRJ9fZgNngbL0VuhHUwuAog47K
	xH7hx8it7hGEdlNvmS43QRANQZH+/GZnvDXS0IsD6A==
X-ME-Sender: <xms:oCz8ZYfi0-xjPN0VKnAbRYowpTu7mm4U71a-MeLKkaRcfQKiWNapKw>
    <xme:oCz8ZaPZJmLjqcNZmSN5TzJ-PGhjXud1ry1k2KwZ-A1YdB1bfHdEk1GOuu65gaVOM
    KYJgnJmSxCr8rnfkw>
X-ME-Received: <xmr:oCz8ZZh0t6UQpHqJVr-wIbQIaARhWx0E8SrHivG23R64rcJFwCUzbKG7uGEY5iFd9U9mM0ZTOVo2ptXhDBiD1sdWKwQGQLSNNY-lvzspVbDSrQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:oCz8Zd-g4PLg5uHbQSzuduqxwCdG14dJK9pwPAVxzQpuw6qT-1u20w>
    <xmx:oCz8ZUudBCbSbqnjzaVcr_hTXNaOUQhLWwqPUy-nndCRH47JxPEilg>
    <xmx:oCz8ZUH3UuEStgogsHJbrcdhea6NwKsT-MFXsAV0p1g4WlsH8pDsnA>
    <xmx:oCz8ZTM-ATstv9WGBE8Q9A6AsDiwRr7sUnb9Bol9GEiNny_0Wv2FrQ>
    <xmx:oSz8ZYj3KrqRSLDNfUK5SuA1svVozxA62CDJIpKujBPSRtwKbTMr0MCjJ2w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 08:48:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 71558ebe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 Mar 2024 12:48:26 +0000 (UTC)
Date: Thu, 21 Mar 2024 13:48:28 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Aryan Gupta <garyan447@gmail.com>
Cc: git@vger.kernel.org, karthik nayak <karthik.188@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [GSoC][PROPOSAL v1] Refactor git-bisect(1) to make its state
 self-contained
Message-ID: <ZfwsnMWg12S2gV3C@tanuki>
References: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZkuhQetXH0MEkQbR"
Content-Disposition: inline
In-Reply-To: <CAMbn=B4HDXOAThvAmmyA5GEzG1nnvbGvc4yjpg7FHSHQQ-WQfw@mail.gmail.com>


--ZkuhQetXH0MEkQbR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 07:57:49PM +0100, Aryan Gupta wrote:
[snip]
> -- Plan --
> ----------------
>=20
> What is Git Bisect?
>=20
> Git Bisect is a git command which helps to find which commit
> introduced the bug into the codebase at a faster rate by leveraging
> the power of binary search.
>=20
>=20
> The project idea is relatively easy to understand by the description
> itself. Git bisect stores some state files such as BISECT_START,
> BISECT_FIRST_PARENT etc which looks very similar to the naming
> convention used for creating the refs file. Due to this similar naming
> convention it sometimes causes unexpected results when these state
> files are confused as the ref files.
>=20
> In order to fix this problem we can create a new ".git/bisect-state"
> directory and store all the state files which belong to the
> git-bisect(1) command in that directory as proposed by Patrick and
> store all the files as follows.
>=20
>=20
> - BISECT_TERMS -> bisect-state/terms
> - BISECT_LOG -> bisect-state/log
> - BISECT_START -> bisect-state/start
> - BISECT_RUN -> bisect-state/run
> - BISECT_FIRST_PARENT -> bisect-state/first-parent
> - BISECT_ANCESTORS_OK -> bisect-state/ancestors-ok
>=20
> While the change looks very simple, it actually is. We will just
> update all the paths from where these files are being accessed. When I
> went through the code of bisect.c file I found that the path is pretty
> easy to configure we just need to modify it at a few places. The main
> problem is to efficiently handle the backward compatibility and
> implement proper test cases to not let the existing things break. I
> have already gone through the bisect.c file a couple of times just
> reading and trying to understand all the functions and was able to
> understand a lot of things about how it works.

As you also mention further down in the section about backwards
compatibility, the challenge of this project is not about doing those
changes. That indeed is the trivial part of this whole project.

The real challenge is figuring out with the community how to ensure that
the change is indeed backwards compatible, and that does not only
involve backwards compatibility with Git itself, but also with other,
third party tools. The biggest question will be whether the refactoring
is ultimately going to be worth it in the bigger picture, or whether we
should really just leave it be.

So personally, I rather see the biggest part of this project to find
good middle ground with the community. It's thus of a more "political"
nature overall.

I don't mean to discourage you with this. I just want to state up front
where you should expect difficulties so that you don't underestimate the
difficulty of this project overall. It could very well happen that the
whole idea gets shot down by the community in case we figure out that it
is simply too risky and/or not worth it in the long run.

If you want to stick with this idea then I would strongly recommend that
you mention this in your proposal.

Patrick

--ZkuhQetXH0MEkQbR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX8LJsACgkQVbJhu7ck
PpQbUw//QWlvMq7BpU3SXMarUboldMaFKVPrQOvBWwPkatefFQnhcaROtOFxv9xJ
v8bRHjtZMSGsErMwTbpjjPQWJSfoz2uZg+wqQJgkRduf3eZPVxWqJkSsIdHbiWVs
Famc3Lj1sSCbW7xXT2QZT/XrEJtz+zcNsWPGt/9g/WU97axfMcU7Ug3+I7SFphii
5RYArjZl750I8xTsgRFNf3D8ZiKgdrj6Eqhjp+ZQwh7koMmxSk6dziAs04Raky43
itbNaDSQpdwKIeV0/h4IIEaYAn/oxPdVSjr/SSdBJL0zoFPSU9MFaCcLiWXn+HC6
uni+puaYAY0tjKt2MKp+UwHwMFxi06eivudhski5EU8I2WvqcxiXXRQgE9la3aZ5
TSwv+YxLrtntryWlg4gELHbibYzjainunB0W9rPci9ZRLctpIE3ha5X1HNZg28Sm
EDYyHF83tfy6OkAXwBK1cHo3aAmnPYLoaiKjxPxOyrpLZgcNkzyzebI+EBkmYwLU
j6wQ0R0I+0QxVRnhQrRq76VNpqYa0dO09/La22l30zpwWNn473hfT4xcuQgMpzgX
5G29f0V+vvo+UIZbgiXDjGKAIFLcAuLouoep8mK0GUbgL01I6sH1oQSlxjlXDxO/
x2ZFl1UOp1kmCiIZM/wWu6EkCENAPDQXHsWEG5fl4h9Wkna2LhA=
=qq1O
-----END PGP SIGNATURE-----

--ZkuhQetXH0MEkQbR--
