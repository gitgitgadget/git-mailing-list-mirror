Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E38C823A9
	for <git@vger.kernel.org>; Mon, 29 Jul 2024 15:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267715; cv=none; b=gGF++bqS+jtvmUSNXO2JiZx/uKJ+Y3vOVpLsXOkxV5k5n190JwzhDJ+zvr6f+srA5w+YVcPh9UpT+s7qn1PZZ/lyv/bPk6vyjf5lHUYiAcvdfyKO6dz4w88n/PlgWb8zSJiEaXTN/NdZUSF4ZvVTq61Zly6044ClkP4K+IuGnic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267715; c=relaxed/simple;
	bh=C0mH8pdUfkRcc4XhFXnBsz5lACXLzJd/EQh7YlV5a4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRU1YZ56LZ538lUFO12FemK9ta18hlONsvX9uy7RxsxTXOwn+JwW9k+BnDINklW7i4Ap2TyyTeTtCq+dpwTxbFsb8e8mCpLycRSfqYAHuQ1X5854d2oCUs9fqPLPF0/AnVJoGcPwWxBS/+nvhN5aTEIG7V6JJYyO0kZzucitZfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MndPN7U0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4VuIBDL; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MndPN7U0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4VuIBDL"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 075C21140196;
	Mon, 29 Jul 2024 11:41:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 29 Jul 2024 11:41:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722267710; x=1722354110; bh=uc9fHwtL33
	t0Ho6qmIf/Iw4Qv/3eqSHnq0/i0ZAYzCI=; b=MndPN7U0x4gKFKRUSqNEDkPgwN
	IyHSm3iInCvMJEQf1+Vfb4wrGRBFGRnQE710o6D9ZbujWqIa2OZ6UePZVKmBvPJ0
	LeC1b2FDcuX2iu0jTvXpHdLurAEfYOb0MlNOVTqVUPCDaj61skuQfTg6oDoItcPA
	BVkIa/vOIfLkgHJ8AAC9VNh3n345F+S8ZePgI3e6oyIcUm8Piz0HaA/rZp60SMus
	Af5+R92VAuvJptAfYMLkLwQ0ys1HOFqkXPHhrxdE9ldKde4DRvNs+LfO6Os9XMgu
	2spWn7b+gse7lvcseIDPgu4zwBYl1w4oJQDVv7L53ksGwrxohk2J1DQsGi/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722267710; x=1722354110; bh=uc9fHwtL33t0Ho6qmIf/Iw4Qv/3e
	qSHnq0/i0ZAYzCI=; b=F4VuIBDLLxXh2urKLyqliIl8d5TVfKM0stXHVGQmGxue
	ArZZNjP4dtJsKBKf9tjntJnNPTCTWroCmrxhJvF9dAo3t9NrzjAh4UXfuYT/MjIS
	7lltzxD2SdjRBPuQHSQtFWVFTOFYCBak7Qglv6gdwULaB8c5zJW1u0F0s1icwRHE
	Axs7aE+gOHVk6VZyRIOCzqV92nK6zYbnDnM1t/Ck2VT8P7X1bthyeZXQyVPU98Ut
	FaZ30JOnT2uzV9hCgYfSDhPD8PsDg+tQKIhDscwaGun0KI44U8vP0MaUa/nIgphW
	E0W2sAdLZMkhQ6nzyabc/MvJRf6MpH0ov1y0Pnfwsg==
X-ME-Sender: <xms:PbinZirIUzfPMdMZ1Cu1EaXLFQWXTykng89hL7V-bnUKwGNMA7BmXA>
    <xme:PbinZgoSMA-I3XVrNPLiGNWBykT_gOAV-MVHJiXW9ZO5NFdPPzJpgWBsfgK4i9GLt
    PvU791VxmeWa6XKmg>
X-ME-Received: <xmr:PbinZnMCRewIyEsXaYcaFpMClDxav_4ynT8KN52uPEkNhRg2BqDq549TTX15J3TTPDzsjpu2hSz8O8497IeHk-X43w60maT6p_aUvpGIXAi9LP4t4A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjedvgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:PbinZh7JfNpq-VyhYgpCFallXkoOJasJ0H8S6mxdpqN9U2cuEkxF5g>
    <xmx:PbinZh5avsvhMJqLUAEfLj9AcHYqIer7_-9FU-THpHgpyrUQP_siFw>
    <xmx:PbinZhjvkV19VUoqe-nJvoVk8x6_G3_2A41GI3YfC90nsFSiMxbKBw>
    <xmx:PbinZr7ur6Duut3vA0qQLB_OntqJw7VDEIIcLpaXKAr2Z7RnQUjrSw>
    <xmx:PbinZrkfcA_xVRmkNYTk_nuIAg-tqNvTVm5mD5caxpnlv5l3A3CfSXwo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jul 2024 11:41:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id b6b9cd3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jul 2024 15:40:20 +0000 (UTC)
Date: Mon, 29 Jul 2024 17:41:37 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Mike Hommey <mh@glandium.org>
Subject: Re: [2.46 regression] git ls-remote crash with import remote-helper
Message-ID: <Zqe4Mec80hKaPWfH@tanuki>
References: <20240727191917.p64ul4jybpm2a7hm@glandium.org>
 <xmqqle1mrx22.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="53sDQxoje9RRNZMi"
Content-Disposition: inline
In-Reply-To: <xmqqle1mrx22.fsf@gitster.g>


--53sDQxoje9RRNZMi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 27, 2024 at 08:54:13PM -0700, Junio C Hamano wrote:
> Mike Hommey <mh@glandium.org> writes:
>=20
> > Running `git ls-remote $helper::$url` crashes when run outside a git
> > repo and the helper uses the import feature.
> >
> > Here is a minimal reproducer:
> > ```
> > $ cat > git-remote-foo <<EOF
> > #!/bin/sh
> > echo import
> > echo refspec '*:*'
> > EOF
> > $ chmod +x git-remote-foo
> > $ PATH=3D$PWD:$PATH git ls-remote foo::bar
> > ```
> >
> > The crash happens in parse_refspec in refspec.c, on a deref of the_hash=
_algo,
> > because the_hash_also is not set anymore at that point since c8aed5e8da.
>=20
> Thanks for a report, Mike.

Indeed, thanks for the report, I was able to reproduce the segfault
easily with that reproducer.

> Patrick, we have expected reports like this when we did c8aed5e8
> (repository: stop setting SHA1 as the default object hash,
> 2024-05-07), so it is not very surprising.  In general, I think any
> command that is designed to be usable outside a repository should
> continue to fall back and use SHA-1, at least for now.  A command
> like ls-remote _might_ want to do even better by waiting until it
> has a chance to inspect what the other side said before setting the
> hash-algo, or even better is to make it work without having any
> concrete value in the hash-algo.  After all, when SHA-256
> repositories become common out in the world, you should be able to
> say ls-remote against them from your SHA-1 repository and the fact
> that the hash-algo is read from local repository and set to SHA-1
> should *not* negatively affect our ability to receive the ls-remote
> response from SHA-256 repositories.  But that are all for longer
> term future.  At least assuming SHA-1 like we have always done
> should be better than the current situation.

I definitely agree that as a short-term solution it's probably the best
way to handle this.

The below patch is what I came up with to paper over the issue. This
restores the old behaviour, which is somewhat broken because we end up
mis-parsing refspecs. But I guess "somewhat broken" is arguably better
than "completely broken".

Let me know whether you want me to send this as a proper standalone
patch.

Patrick

--- >8 ---

commit c52112d3946b2fd8d030580cd7acb809fa54012a
Author: Patrick Steinhardt <ps@pks.im>
Date:   Mon Jul 29 17:21:00 2024 +0200

    builtin/ls-remote: fall back to SHA1 outside of a repo
   =20
    In c8aed5e8da (repository: stop setting SHA1 as the default object hash,
    2024-05-07), we have stopped setting the default hash algorithm for
    `the_repository`. Consequently, code that relies on `the_hash_algo` will
    now crash when it hasn't explicitly been initialized, which may be the
    case when running outside of a Git repository.
   =20
    It was reported that git-ls-remote(1) may crash in such a way when using
    a remote helper that advertises refspecs. This is because the refspec
    announced by the helper will get parsed during capability negotiation.
    At that point we haven't yet figured out what object format the remote
    uses though, so when run outside of a repository then we will fail.
   =20
    The course of action is somewhat dubious in the first place. Ideally, we
    should only parse object IDs once we have asked the remote helper for
    the object format. And if the helper didn't announce the "object-format"
    capability, then we should always assume SHA256. But instead, we used to
    take either SHA1 if there was no repository, or we used the hash of the
    local repository, which is wrong.
   =20
    Arguably though, crashing hard may not be in the best interest of our
    users, either. So while the old behaviour was buggy, let's restore it
    for now as a short-term fix. We should eventually revisit, potentially
    by deferring the point in time when we parse the refspec until after we
    have figured out the remote's object hash.
   =20
    Reported-by: Mike Hommey <mh@glandium.org>
    Signed-off-by: Patrick Steinhardt <ps@pks.im>

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index debf2d4f88..6da63a67f5 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -91,6 +91,21 @@ int cmd_ls_remote(int argc, const char **argv, const cha=
r *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 	dest =3D argv[0];
=20
+	/*
+	 * TODO: This is buggy, but required for transport helpers. When a
+	 * transport helper advertises a "refspec", then we'd add that to a
+	 * list of refspecs via `refspec_append()`, which transitively depends
+	 * on `the_hash_algo`. Thus, when the hash algorithm isn't properly set
+	 * up, this would lead to a segfault.
+	 *
+	 * We really should fix this in the transport helper logic such that we
+	 * lazily parse refspec capabilities _after_ we have learned about the
+	 * remote's object format. Otherwise, we may end up misparsing refspecs
+	 * depending on what object hash the remote uses.
+	 */
+	if (!the_repository->hash_algo)
+		repo_set_hash_algo(the_repository, GIT_HASH_SHA1);
+
 	packet_trace_identity("ls-remote");
=20
 	if (argc > 1) {
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 42e77eb5a9..bc442ec221 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -402,4 +402,17 @@ test_expect_success 'v0 clients can handle multiple sy=
mrefs' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'helper with refspec capability fails gracefully' '
+	mkdir test-bin &&
+	write_script test-bin/git-remote-foo <<-EOF &&
+	echo import
+	echo refspec ${SQ}*:*${SQ}
+	EOF
+	(
+		PATH=3D"$PWD/test-bin:$PATH" &&
+		export PATH &&
+		test_must_fail nongit git ls-remote foo::bar
+	)
+'
+
 test_done


--53sDQxoje9RRNZMi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmanuCsACgkQVbJhu7ck
PpT/+RAAgNstQ464vKHEpNNMmqdRFKpg4z4YqlprKukrjGNDp+tzCfOwdeqPCb3k
D+lvlCNVKhcVGJ8cCvrIyXekCFnJVy6Qx3DfuA2m1RVUEIHrSv5cXXfrKizlB6i6
PGNsBud59L5c1Tbz+Df8qiGE+CnO7Aa77th1l4yAcNBZk3iX4PavTNIxSDTaSGAu
yE4aTuxy34v3Cw5obfdPATsxCW9TqEa43IwX/F5qRZzopGO3GE7tdewc/yLttoe6
PyL4wJYbaMbtZ4ifhyvkaB/6tSI5yzv/l1wrAC0qVRo8FFqA+moLtYNsf1fw5uVG
YmcHYu+oLa6ihRxoqNMEIuPST7Y1UKshyfFMDYaFDSE+bDetxq8Yv8x3tPPOoYJe
nVsebzM7bCWLf8o5J/R257a3qdmEgZrdR5bc0pNtUi99bMNG7d+Xmal51aArCIHC
6+QOPOIUEZnaJeQ6Vr4EcF0zDngLt2BuSZ/Gzlb760dQ++6PBcLHI1+4CxBwcM5p
oNvh0EqGCNkhZyj/AnPH2xp2SnTnBzuLjzZzyz8mS0z75j1Af/dStqKweHqs/eTD
aZ3mD2IFzX48AozizDrmdnFSEs9g03NC8J6V6Itjemu/YAwfcAL/r8KxYC24Rl5p
KbS5jSLRv15xIwB2aE0Rdn7XYX5eSW99fmnXzv61L/+OPfDyLNc=
=+szc
-----END PGP SIGNATURE-----

--53sDQxoje9RRNZMi--
