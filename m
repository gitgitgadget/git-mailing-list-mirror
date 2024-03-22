Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDEB65C
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 01:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070714; cv=none; b=ecGF0XCQIG9Vq7RVkCRUnnbZzh+wRXoraVfbMM+32hzyiOtgP16/vZE9sQLZ++lIpkORr/cv17usFaO6haLT0fkR3TID97hiZFEIAYWdRIsAoivfJn67fSzrZFsbBHbBUwzQDb7p1NM03Nd+z4yPLh1UHMArLJETRn+Lug2gBqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070714; c=relaxed/simple;
	bh=nt+NK0OW0BAofpumz5OrJo+98y6SADLNutt571+k5dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UWksZaaxyQBMgvxpdWyRz6ch0iignAZSQJwZnsgJ8n3JzXQM2L4x9qMTELIT1buzHUMZOldyQHeghPq6eHbsZUPjbuqk5Ecy+tHHofp+mYLFK+j/J6gf/xHTnKWbh+FGaGJ7HFkKRwv4BJzuU0fxsVNPhq6dYRZ47NPM0jLWQI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=S9Uh7ZJP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a7/j+E8w; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="S9Uh7ZJP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a7/j+E8w"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7D69313800C8;
	Thu, 21 Mar 2024 21:25:10 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 21 Mar 2024 21:25:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711070710; x=1711157110; bh=b0o1h4F43V
	7DpibrsmRXNNqApN58ZyT7P4ZkZbJmncA=; b=S9Uh7ZJPU06l0vs6AEw8GrkDz2
	3xZPyz2p+/ZjX4RtAq3uB/h75+dxYTZnvgr88rqza4r0z5YgO8sszGKLnnsSTfHW
	znXwSwqzsSu7tdFr7PgiCYzCQ6phx9MEuYDX4whrpj4ajhf8Q82CEnawQ/nxZo1s
	uGyQVDkuX6pGvEf6OEuO8vrqni8VCxYB1CtdfekALQzv2pyyK9mvpXI8zjdPorj2
	n3uqtAKNMthJmlWCce5w1wdvMR6VSBEYRzeIkeDA9pbffVojdDX6ljaaq+EKJfY4
	KypYdEQHExdHJDm40H/psPydDbszCOSOFs4X5M+IqWr8aoMfnjss1fKw6E1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711070710; x=1711157110; bh=b0o1h4F43V7DpibrsmRXNNqApN58
	ZyT7P4ZkZbJmncA=; b=a7/j+E8w5RdwzB5fWNSKOHXfD6KUi4Za71eLxrn8zMA7
	MS02S20XIAWCqiAVcHqiSt0Ogf9JKEW1+PH5th2U36elVsTsPx/6iMP6I802xlqS
	o+xqCpHlHj8ucNDjAhoxDBnQxl0v8DJOfNnzfyKKIudFluVBsCg6yu4B+UyOjTJd
	dVK9OQm6aHPpLw5lhGdHPlNI5uf+3nVJOcVcbwV+LsDN+bv5i18opxZxZC0bC2Ey
	omsZwA+j7PUvdKcEEWnjxV1Ng55dy8bSJdQmZXVB2qV4gPqCg3we3bHx+g5RuCS1
	pabn1Qp0aXVPGG7M57edJXmv9X2cyL9kBNS50pa6vQ==
X-ME-Sender: <xms:9t38ZRkEjzZd9bYEtNNT4Gb-OEp10x82_nJ_KTikxejCm74gmtE1Zw>
    <xme:9t38Zc1QlXV1yBzdhz0kamqDY_w4Y9kcP18nGNnKmM0-7J9r36etE4TuAdu_WAJ4j
    w6GJsZx3dQbIpNHnw>
X-ME-Received: <xmr:9t38ZXrth3GdxCn257X5CoVzwfDaBrPcDjEjoO5Ynj07WBGE6dDbfIw12dB9cq03iYwJG09crXb5rN3v8VGFkcHA7PfHLBi_xLcvSycBjSalEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:9t38ZRkll3MQyJFrNxgJAf-oDm0VIRq9ehIXOzkOi9aC3m_EVTdrcA>
    <xmx:9t38Zf0F_x8_vA_pv8c2MBh9fxzhgYBp3r9tQqsX1qHR3QetKavNmA>
    <xmx:9t38ZQt3GSueIzo0CtOgUXqLtjp_886gWAsVNPoZu1_a30VggY4wCw>
    <xmx:9t38ZTUjjfUAmc6qIyIHaX162SQ42Z3eez8StBV_E9hgOXZTLqxkOQ>
    <xmx:9t38ZZqhGd_S7o5VMaSsDoQ4qrhuZxPb9Uj7SE18HHXuesQTUcDqXw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 21:25:09 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id cb018936 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 01:25:02 +0000 (UTC)
Date: Fri, 22 Mar 2024 02:25:05 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v2 0/3] reftable/stack: use geometric table compaction
Message-ID: <Zfzd8YdAwzYRYkA3@tanuki>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BnSuAn4pJRmsO9qN"
Content-Disposition: inline
In-Reply-To: <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>


--BnSuAn4pJRmsO9qN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:40:16PM +0000, Justin Tobler via GitGitGadget wr=
ote:
> Hello again,
>=20
> This is the second version my patch series that refactors the reftable
> compaction strategy to instead follow a geometric sequence. Changes compa=
red
> to v1:
>=20
>  * Added GIT_TEST_REFTABLE_NO_AUTOCOMPACTION environment variable to disa=
ble
>    reftable compaction when testing.
>  * Refactored worktree tests in t0610-reftable-basics.sh to properly asse=
rt
>    git-pack-refs(1) works as expected.
>  * Added test to validate that alternating table sizes are compacted.
>  * Added benchmark to compare compaction strategies.
>  * Moved change that made compaction segment end inclusive to its own
>    commit.
>  * Added additional explanation in commits and comments and fixed typos.
>=20
> Thanks for taking a look!

Cc'ing Han-Wen and Josh for additional input. From my point of view the
new algorithm is simpler to understand and less fragile, but I do wonder
whether there is anything that we're missing.

Patrick

--BnSuAn4pJRmsO9qN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX83fAACgkQVbJhu7ck
PpRNMw/7Bs5bl3WIkF7cplFgIcTq129xWpRSqZeJzmfkX7auYVL5aaTfQtwqzrDc
k36mAIFqWQhGP8rhHDTWb0Stqmh5dWyttVaKx/2r2RmDA2YirIbqAGa8581AajsO
30VhxFVWkha+06k0aRRFl1a6PDDLD3LdLXTrGCQa3cSmLZe0hECBVjSTgZBcyaSI
Gry/N/QsJdAIs1MsFjzUzUoi9R+PZtr5W2ySkIzjDw/NszjMd+6w5SwLa2TuOcyq
ioiyJA5TUXROOoO/APOrwe+PbY/Qw2jLMJ7Kv/veDZrBIhWphoPwwxrUhXJEOs08
Wva+sDfyYmVtuMsUQfpnmNuWdphilKKF5CbqtXww/uFG3YvbggGx6pl3Iw9FW0Kg
RzrRmFXH1yvN/xI+q4TZqRg/+Y3iDoUMsMKe+ILOvtSkVZiGJg4JKizQB9CG5doq
ZskZHZ1vHQUDvw8C7ixzlQes1L4fTTz45D+q6xmCYiNUUSbeyoP+sjqslKRb5QE5
mavl0xbO3eTsap/yfCYEE5eyEyJriioDmPGzEIlLJlXW/Qmzq6hwePDcHLPo3+Hm
dOR58kF+igOgwMKRgx8ZaeLf+TQx1dmYiUSfu8Pnc3CJnf63VPsFrJGeUBB0iMWz
D+VzVYpgwQkprZtI4MZuvDSiN5y2LJycK4hrxKKaAJfPFOtJJCg=
=OP99
-----END PGP SIGNATURE-----

--BnSuAn4pJRmsO9qN--
