Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919F212CD90
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 12:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714479386; cv=none; b=o7PHQGG0MMPfrjx+1P92NnxTv+HLZwxHRDN0al49MQ/pU7vsqpekyeBE7WHa4UOq+8Qw+eYCcP1BSPClv8IGIw2en0HaU6s2hciVaIxBqbbpBYG6Wc1iHtdr/xiT8jzqsw/JOdXgDHTxS/f8w8iND5hXjVrXjGMw7FlMP9HBaNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714479386; c=relaxed/simple;
	bh=rpO73FL+BAFH4rnpvvVMbXKAXoU2ZcF8B7p7B0gs5gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qr3gUk4G1QXVtZmR+FIxCiF2QxQxxWBrr6gxvzvpvt0HKlRxIerKCz/2MNVRkzRERf5kPKJyMEckuLod3aL+RauYGAiEnbKAuL07T1to+zafW7q4vsXZ0poyVU/eryzndZNy+mJ72/95yslier2l7Xs7TRqDasHGs+k8Z8BoMYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=scdRQ2Z3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vtw6PhXL; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="scdRQ2Z3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vtw6PhXL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 84E421800155;
	Tue, 30 Apr 2024 08:16:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 30 Apr 2024 08:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714479382; x=1714565782; bh=rpO73FL+BA
	FH4rnpvvVMbXKAXoU2ZcF8B7p7B0gs5gg=; b=scdRQ2Z3TFjTz8hK4e12j+goj2
	/NY8xPY1uhd1EocMzsAL6n4oSQvOnxnnC9vdF9YqHaKCUxL5M2eVHwvtJvSqsbNi
	omF1VaP+nPJMWe/t1oRkOYOuhK9KL1hMWennczzVMUV8BAr+DQFFIw3pcQAPlaAI
	R9Lu2ReF2FCntBxUUus38m1zhfY6QobOTlz/vIk7FgvHdNxdGM0gzCiajg32jhQy
	Vl4Yf2nox2FBvSS09lB+6Co6KQrglXhaLCO3qP82Bh0HLSSNBxuPBv1fqF+xGtf+
	AjjsLTGoen0tNmgOhiCquccMdCLRKtnyVtk6+z9kz5wnQb1arYd8W3m1cXgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714479382; x=1714565782; bh=rpO73FL+BAFH4rnpvvVMbXKAXoU2
	ZcF8B7p7B0gs5gg=; b=Vtw6PhXLxWQZlmP6tlX9gFxRicIAkxg671MOAI5TRdr1
	IPRm0+1xSu5ggh4fqD/TgrqMylroVyu3LAQH9lUtFjmhHz28LB6juhg3YGfIYDZo
	ji0kgz7fmuY8P2nSfBeBLzNWwOeUb1BihU3+I531deemBfs8Ito2K+yE5DHcSxzu
	ONu3Yc6QuY0U12S2BVNNo4RzkdZhDUMbW4qdPZrSXnzmnlclWViFn3EHvVpToiVL
	4CO6QaTX6ksDCF0QjII07im8QwM6FiTaKRYkgKME62ecw5mKySBVg8oJM+VDJ3cP
	QHDUnnZdYUJcgQSuJUKreygRVtjAcG0DrGfaK9ttZg==
X-ME-Sender: <xms:FeEwZhru0WcH6B_qfHr0O3g3Nx0L6jJkeRRHhEbXpUqKwR73e4Mw-w>
    <xme:FeEwZjrZOyQX5o5rQujHq0LvTLerxVn6JO05rz1--2k0pNa51olRcbFqs-Uy-Opub
    ypCEJDEf3u6rLR6dA>
X-ME-Received: <xmr:FeEwZuPxfbeuNfN679N32-Wxtep359b4JfwmtwmeSh38zDZjoLiE3jbspKEGXiNVJH2Fv-ArLafgbywps380LyTKx0wdjlWF_Xb1TwSSfKnvsfu4NZj2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddufedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:FeEwZs5bGWR3X-7uQplv4jWH0foeoRkpZK6D7_sAhu7jnOmvFlEvjg>
    <xmx:FeEwZg7vcunU_BOo4ghLOeeqxo9dG2GNzWj4ifkQ9_7U6JCRLYFfoQ>
    <xmx:FeEwZkj5hK4GYtnz3oL4DZ9upTVRTi-8DB5JAZD2ZDJjTHmvvkmkFA>
    <xmx:FeEwZi5lkneVQ4QKH3DqghmxsyQiwjdhoQAWGmwMRMjRk4-ASLsrUA>
    <xmx:FuEwZr0rTt3l68fPMsypsjraskhTZdz8RmLiF7WIUcnwJz1NU8tJ7A80>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 08:16:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c438b154 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 12:15:56 +0000 (UTC)
Date: Tue, 30 Apr 2024 14:16:16 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
Message-ID: <ZjDhEKbTFx2O-gcD@tanuki>
References: <cover.1714398019.git.ps@pks.im>
 <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
 <e57ed591-5006-453e-bc93-6c53fcab2aec@gmail.com>
 <ZjCd_drNT6kyjNa6@tanuki>
 <20240430102310.GC1279403@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IzXaN6vbT3mBMJdN"
Content-Disposition: inline
In-Reply-To: <20240430102310.GC1279403@coredump.intra.peff.net>


--IzXaN6vbT3mBMJdN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 06:23:10AM -0400, Jeff King wrote:
> On Tue, Apr 30, 2024 at 09:30:05AM +0200, Patrick Steinhardt wrote:
[snip]
> > > Are there any practical implications of the changes in this patch for=
 users
> > > running commands like "git log FETCH_HEAD" (I can't think of any off =
the top
> > > of my head but it would be good to have some reassurance on that poin=
t in
> > > the commit message)
> >=20
> > Not really, no. We have never been doing a good job at enforcing the
> > difference between pseudo refs or normal refs anyway. Pseudo refs can be
> > symrefs just fine, and our tooling won't complain. The only exception
> > where I want us to become stricter is in how we enforce the syntax rules
> > for root refs (which is handled by Peff in a separate patch series), and
> > that we start to not treat FETCH_HEAD and MERGE_HEAD as proper refs.
> > They should still resolve when you ask git-rev-parse(1), but when you
> > iterate through refs they should not be surfaced as they _aren't_ refs.
>=20
> I actually would not even mind if they are surfaced when iterating with
> --include-root-refs. But then I am a little skeptical of the purpose of
> that feature in the first place. After all, the reason code shoves stuff
> into .git/FOO_HEAD is precisely because we don't want other stuff
> iterating over them, using them for reachability, and so on. That is why
> "--all" does not include them, for example.
>=20
> But I did not follow the development of the feature, so maybe I am
> missing some cool use case.

The thing is that once we start to surface pseudorefs (in the sense of
these _really_ aren't refs) in ref-related tooling, users will want to
treat them as a ref, as well. And that's just bound to happen with
plumbing like `git for-each-ref`, where a user may rightfully expect
that all output here can be treated like a normal ref.

In fact though, I want to double down on restrictions regarding the
pseudorefs FETCH_HEAD and MERGE_HEAD. While it's fair enough that those
can be read like a ref, writing to them is a totally different thing. It
does not make any sense to try and write such refs, and our abstractions
aren't even prepared to write them correctly. They go through the ref
backend, and thus the "reftable" backend would write them into the
reftable stack instead of into the filesystem. Now you could argue that
this should be fixed, but I don't think it is reasonable to expect the
reftable backend to start writing loose refs for those pseudorefs.

So I'd really like to stick with the current explanation that we have in
the "special ref" glossary: pseudorefs must be written via the
filesystem and can't ever go through the ref backends.

Patrick

--IzXaN6vbT3mBMJdN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYw4Q8ACgkQVbJhu7ck
PpR6bQ//XPzi5L0aD6VHt+o1qhp670XvfVur6pO0FUudolgnvgFwQcJO+4zcRA3j
J8H/owSEcRKoUszvz1Si3sEvEly5+wm9l4MhflLPyYofSZlFxfhadJoB+x9JPqYt
XqTR0pwYckAUbfd21IviDJ0ghqFhTOldQ3XjbBhPAEfPE4rUnda4DmfUYwGwK8R3
AVRyem8TO7lxRBa5Y4swfDkAsN3rFwsPfMIa1iaP+2zS+6lcbSykI0KB7EwQvYcf
4FDg6iS8S9pjZv+KetQSz3qLmPz4hyUZhEthWfP3EX4163e5MtLiA+9wtMsqYQiY
SDKl18+ikEZhhEbwBN8QL2JsVnFlXXOuQe0XtoSXPaRztr41CY4qYYxMekrdOZ5n
UNwczKIkWPn8EnIevx+EeID/JsXs5jHYpY+j3xHBcPevQBxFDPAOnIN/o3MWMQqY
GhXDRbIWX65DqL0xU2rkdlQpjsipGtK3MgpexfhOZMecA6+ZZcYRJknShpFHQV7C
quUfvhTJlPkbCAcuimFOXwu2nddKRHLI+NDN/I5MhTO15MV8+sTu9L2N2ujlrJTU
+Z8a3HZKIJcSQRkLAuVG/kue0sbSBQnJ6LH11UBxdycM4cqK9b8sIYTHP9nZO8UJ
/O6UkmYSf6aTx94oa1DvYIVJQmP9I659B1yZwJihHY52jRZBTkc=
=GaI9
-----END PGP SIGNATURE-----

--IzXaN6vbT3mBMJdN--
