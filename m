Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A66514AA9
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 04:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714452857; cv=none; b=k/zZF8BNkYAA9mjTgPgy0/HGopwblQXTpCWAhpMHhlgm94DyA1js0tBV/PhqOsNBTruidcgrl1V+CIEEmLxI2/DpGW1dqNh+JoPf7R70IQrSG3et+MFpOl1K08hPoLl7iRf9LF+YhxX2X1bbeIZoWDmFyB/nBu5saCpIpYi+S/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714452857; c=relaxed/simple;
	bh=tq4WJ74/k3Eswow+smo3Ppl/MUz1mO+yxoyDNYBR6sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6Y1s190RYzBW8rLMvHX3Fmy8qt9Vmi7YRc3oeIoiySWvtPytbTficEWRPN5ebZOMQrtkc9AxyJXJ0Db8/yYT8iqxiPVJPyKuV+cHlGZrpt7u9M9HeD9bvO0/97B5hn3X3c9scl4Z1k/VDC6kfM89o6RP7SGXREvxiU/r29nMMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pJaqwMkN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=G90Il4Pk; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pJaqwMkN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="G90Il4Pk"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 4AFE61380F71;
	Tue, 30 Apr 2024 00:54:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 30 Apr 2024 00:54:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714452855; x=1714539255; bh=45BgYETagi
	UiIxOsBC6/J+VRd9AWOb2o+f5jrKb94Kc=; b=pJaqwMkNzHaPQEhQeDjFOe3bsZ
	Ck4MVxctd2eGU7dlP2WwZVBiChbP0Wi4kEyml7uqh5K851yDfXmgF23aOc2EXgec
	wt1ltCHSVBnlh1c79PzOZa+SbJ4XF7C+up7MxO7xagHliricSWpn7mXfj+ABbWxC
	HvJQ92xRT2oiW8f89ni6E4A1JMxAa/hd1W/NYwtNjZieKbKjhd0du8tmCW95Tz2O
	xLisQ9JqfyCR3SdPjtwguxKFCvrh+GTwjnC9HqhCJ+nDX9OgECVS4NAMmYBZ4t8j
	3XJ26BiWPVUcROuqr5sbOdzmRtL/XmdQhvqKkMr6KY2lbiSzaVHrbK/c51dA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714452855; x=1714539255; bh=45BgYETagiUiIxOsBC6/J+VRd9AW
	Ob2o+f5jrKb94Kc=; b=G90Il4PkrBjt0OdHyQCFWwA9AQIwMqy4AqQBaM4T0Fk9
	goNe0YRhwB0TZy9rQAfRJSmKv6OrCTuiWX9JEKYVU/wgYLRVnfatMZ8CpDvfD9tG
	A6NdcSG+KKLnOuvuMDVZvoB2Uw1eC6dBBQK8Z3WZRKKr2su4LGQSMMJyrdAOx+Vx
	KLxtte4+al0drL21Ti6YhGN2YHFAiwo7gx3CgeRt6ILhHEE2cuXp2ad9wSRvnz3C
	9tD9hdS5uXWceojfmOTRpQ2GzJ23K/AH/Wr2a0bbLBvHB7G41AwcVtO6vFcxi0wm
	S8hWedcAV4W0FWxVVT9HXF75Ed25hy7XiSHNQGCjdw==
X-ME-Sender: <xms:d3kwZp88tc6_TcxILPhm9qQ3Zmi5NULRwTPQy6MowXnK0bTadOXyUQ>
    <xme:d3kwZtvFK-RayxDZR2haBV5SjeeIEY4yG_i4cr6OhLpFV0EDEhsKT157bn_a_f0DE
    TUBIerSJaJ4KsLrPg>
X-ME-Received: <xmr:d3kwZnBYqsHzKQ0hqTXwi9paBKczwu4WAYGG_MeLu8XaQYs_y25eilccLgEaVSCdfiXIigPgR1049N6GO6G9ypkByZURddcxfzNRVQjycjZYqN66rgvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduvddgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:d3kwZtezH204E4flI4Pqz1Gqp546scSHhUkzpQ5dstRzSttaq-X8rg>
    <xmx:d3kwZuOAimrlo32QqIJHCkoqrhWlD4XxBRsbatnxWRfNLMouY2er_Q>
    <xmx:d3kwZvlu7_gAJjWG7RlNZx_mktk1i9ShFpvtkayEd1YYkVUsk0AynA>
    <xmx:d3kwZouHz8nqefVNLRURNFIXrTmiRm34Ptar_L0k-vcFnOpJX_oa_Q>
    <xmx:d3kwZnangRw5CqvGsHGRt8lgfajP-DjOQcnVui4azbk9oDonpoyrZcCu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Apr 2024 00:54:14 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 10f99a0d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 30 Apr 2024 04:53:53 +0000 (UTC)
Date: Tue, 30 Apr 2024 06:54:12 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 8/8] refs: check refnames as fully qualified when
 resolving
Message-ID: <ZjB5dPoEoq8D6qzJ@tanuki>
References: <20240429083533.GG233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0pDE3FGjOVHrbWzs"
Content-Disposition: inline
In-Reply-To: <20240429083533.GG233423@coredump.intra.peff.net>


--0pDE3FGjOVHrbWzs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 04:35:33AM -0400, Jeff King wrote:
> Most code paths for resolving refs end up in refs_resolve_ref_unsafe(),
> which checks the names using check_refname_format(). The names we have
> at this stage are always full refnames, but we pass the ALLOW_ONELEVEL
> flag so that the function allows pseudorefs like MERGE_HEAD. We should
> instead pass the FULLY_QUALIFIED flag, which lets check_refname_format()
> do some extra syntactic checks on those pseudorefs.
>=20
> With this patch we'll refuse to read anything outside of refs/ that does
> not match the usual pseudoref syntax (all caps plus dashes). This should

s/dashes/underscores

> not be a loss of functionality (since such refs cannot be written as of
> the previous commit), but may protect us from mischief. For example, you
> can ask for silly things like "info/refs", "rr-cache/<sha1>/postimage",
> or "objects/info/commit-graphs/commit-graph-chain". It's doubtful you
> can really do anything _too_ terrible there, but it seems like peeking
> at random files in .git in response to possibly untrusted input is
> something we should avoid.

Agreed.

[snip]
> diff --git a/t/t1430-bad-ref-name.sh b/t/t1430-bad-ref-name.sh
> index 120e1557d7..5fb780cb08 100755
> --- a/t/t1430-bad-ref-name.sh
> +++ b/t/t1430-bad-ref-name.sh
> @@ -400,4 +400,14 @@ test_expect_success 'update-ref refuses non-undersco=
re outside of refs/' '
>  	test_grep "refusing to update ref with bad name" err
>  '
> =20
> +test_expect_success REFFILES 'rev-parse refuses non-pseudoref outside of=
 refs/' '
> +	git rev-parse HEAD >.git/bad &&
> +	test_must_fail git rev-parse --verify bad
> +'
> +
> +test_expect_success REFFILES 'rev-parse recognizes non-pseudoref via wor=
ktree' '
> +	git rev-parse HEAD >.git/bad &&
> +	test_must_fail git rev-parse --verify main-worktree/bad
> +'

Are these really specific to the REFFILES backend? I would expect that
the reftable backend sohuld fail to parse those, too. The fact that we
write into the repository directly during the test setup doesn't change
this, because all this patch is about is that we don't want to parse
random files in the Git repo. And that is something we should want to
enforce for all backends.

Patrick

--0pDE3FGjOVHrbWzs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYweXMACgkQVbJhu7ck
PpSBEw//UjldFYN/HWN0Cp5xkYRJuiVam20DQr+JlbvGwQrJUH2+4zctTFCcHGgA
Jkc8bvTJ1JjDvwkS8aLalqjxn/N9hFgTmOfoHHuS7a+X6q4HGoYZr+1jfr88/FaK
BAGCfcsmC4hBhNa/Xb/PehAyBjhRdPyvrvCb0c+kevawdPqZzlVQtX5LgSkAu7V8
idSycjGqPayuVqGPHagy6Vo8C99T2XWqvTVfxkhAXwIzK9XTfLC0nwBW/Nr8yZzZ
Y5tSKZgsM8vTAy6F8PtNvDKvYF8IK74H2m/HXd0n4EtFO0k6mkV4WJCl7yreEEn1
cZv+l8viDTu/3dEMcYMCltwzVkiKj36DClvTO1vfjE7478hnyTQMcMIyUdWqzYwR
3lOSGEzU9pHGLZrrx0+euygdvyLHS8K4KSONr+xXJu3QgSncLXWBI1wtuMh8MYB3
BbknnEUbfG/8WIZXnvCsGEyYH2PAXnn9VYmqLVP2iad49QK8Jz/byNA4rXCZMcz/
hF3VpCtwkudMs8vthelP72BiGi/E1khiR/7q5sSx+boCYOfj30e86i8GuBvDXr5x
+fwfuX3954zKAPdMUKODegSxwDdBnLRUuXlazbeM/4TVlGJk6w/IYfXtQZaKFkpz
QK6SjnvIxKXulPzXVf6dndoouxvwIOzsm6rTGd2VytfaFkdhTGE=
=DMMB
-----END PGP SIGNATURE-----

--0pDE3FGjOVHrbWzs--
