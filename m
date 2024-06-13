Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B787633
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 05:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257943; cv=none; b=RVd6mh014E2/FwjwzUliUBfm/4OJrnr5Fkv/TByqZ2jkt87PJuxFSiT+owWzJcDDcKyBkjsHw2rWjfiNuhjx2yh1QAbqHG/4w5fBemJ7DrDZkuKeHW0EuMB5EuiZH9shfYDlIZkOhFELbLCePc0o1QNFW33UGe7y1mVKu8NstyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257943; c=relaxed/simple;
	bh=Jj2VuL7tWjIw6WBD+5vTvHxXF92XukJzDrw8uz8xMw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=So5+zye1gb1St8Zv2s/wWF1qqMtCWYnjR38Cb+UW12xnvnwco/C6PCMhl6dLh8nHKdNTxCP3wV9j6oYH3oL375I1ZWSZKs+r3zHTpV2yLhM/zHcM+gCRkOODBRyEp/NFnP27EyT0PIFCZpyU11UgN4wwMFZ/lMO1xbsD2g44+1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Emg0GKl4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LDVzlpr0; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Emg0GKl4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LDVzlpr0"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 37768114017B;
	Thu, 13 Jun 2024 01:52:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 13 Jun 2024 01:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718257940; x=1718344340; bh=s6eauxATG8
	Zm2V78X1qFPfyC52Lr+NLM78m/eu2QOSI=; b=Emg0GKl4gif5pKSaI/q7UqyO95
	5krQpxNFYKEMixx5qdcY2HE0FWhbozNbapeZunTUL9QEHYPXe3wsVe8/EnSclWqb
	CwUi8a2QN+F7hVLcDM43qryLJtil+8bDcGHKTyw3NG3HjUzISvsoadP6XlyGlTc1
	8eaSNQLEMXK1GqqVoAMF1apfnvA+0B1f3HFTXI2xXDIoO+EuUIG8poX1mykJbZ6r
	X2wfhrjJZGpJidh2gF4y98iTyWDKf3VcHLKLXxZQhuhcpqI+9gi5wXG3qGY/XEEn
	qlWVkz4a33IOjNN1qzlllosPfBSE4PBLrco8BM7+yJ0ZeRQZUxz0OyiJmtpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718257940; x=1718344340; bh=s6eauxATG8Zm2V78X1qFPfyC52Lr
	+NLM78m/eu2QOSI=; b=LDVzlpr0vtTTbg35wonbiDOwGuQC2YbBVXMpI+Mx6A+C
	NXyPI4pYpa3Ux3/pmcCUiQkLy+TNI8QgAvF+hSbH0N7UP4VT9x7TiBqu3xLQHgyx
	1hmw7iiFVO75qV8b6ml5rJyBu7jmnAxPzzqt1iKclTxcBAHIzCEfiUoj/4wJAtS2
	udlYHRotV48b8/JN4RsIk6RpTR+gCE5uFkwxh/plPonWXy16AEgp0l+bu+7gVxwm
	lLUsQdNMK8bbeVI99IO7V5rx+OdJQolaDurGE5ALrC0JBlx2nhbAV6PCUkR7xpKb
	2TvNAGZJ4qXy5m7KQ2r/WRO1igZvMIF8CzTXq7bawA==
X-ME-Sender: <xms:FIlqZn36cWf61-GiKO-YKydSqWunS3-G6jZjyqk17qzivUxiTqh5AQ>
    <xme:FIlqZmERxgv9Y4khhM_METzbW3H9zR2J18f2dEdqvow_l7SzUEULK3QHdguTFj7m7
    qjqT3pjp5fP66WjQA>
X-ME-Received: <xmr:FIlqZn7kvhFCiyqfGqKslH7tw-vfbEFKc9T6p2cUusZi-TORYhO8wvvvvwCTE4o_UIN6dDe8iR7lygTjeqq0vu0SP_-Y-RH2qwEmCuAhCRtSXpubUh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    orredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpefgleetgeeluefhjefgfedtveetveeuve
    efffeiudegkeduhedvteffkeeggfekteenucffohhmrghinhepphhkshdrihhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:FIlqZs3pmzxHAnrVmcD-0DcQ6NTl9m_JvsIazBemoCyu7oQR71cfHA>
    <xmx:FIlqZqF-sG0R7Yg_BDXLrRqIy2l7h9S6F6qNkVLiJq4OS65r0nlDeQ>
    <xmx:FIlqZt8sPSHmr1zieTNb7VM1wRLOenEkW4xejsqEdiFv0HtcJjGoQQ>
    <xmx:FIlqZnkGjk_99_ky50kQBqs8vnPjjlqVvYt0yy4hw3NrzajNkntP1Q>
    <xmx:FIlqZvRedsuJ76BYm62j5Wfun_V2i-H6h3few96YzJjD3hV6jfvW7h3Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 01:52:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 860e4906 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 05:52:03 +0000 (UTC)
Date: Thu, 13 Jun 2024 07:52:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2024, #04; Wed, 12)
Message-ID: <ZmqJDVTAiBrYJGRW@tanuki>
References: <xmqqcyolofar.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="E2f5T9JFQ37uwpeU"
Content-Disposition: inline
In-Reply-To: <xmqqcyolofar.fsf@gitster.g>


--E2f5T9JFQ37uwpeU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 12, 2024 at 05:30:04PM -0700, Junio C Hamano wrote:
> * ps/document-breaking-changes (2024-06-04) 4 commits
>  - BreakingChanges: document that we do not plan to deprecate git-checkout
>  - BreakingChanges: document removal of grafting
>  - BreakingChanges: document upcoming change from "sha1" to "sha256"
>  - docs: introduce document to announce breaking changes
>=20
>  The structure of the document that records longer-term project
>  decisions to deprecate/remove/update various behaviour has been
>  outlined.
>=20
>  Getting there.
>  source: <cover.1717504292.git.ps@pks.im>

Just to make sure I understand the status: do you expect me to do
anything in this context? The latest version did have some final
discussion, but from my point of view there wasn't anything actionable.

Patrick

--E2f5T9JFQ37uwpeU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqiQgACgkQVbJhu7ck
PpRFXg/+L3ZiHjW2MHx9NGF3c6MiY0wnzcj692D9L4fhSfapOJH85M8/W0sOIghS
qjnUn0XE3tyDeZ3gsYbMzuO4F/rTqIdlVSf/K8HvrU3O7ZQ1TIQY3FDO+FGWFN4K
PoCXyhW4Mg3XNB9WBzgjIvYqiiUZnIaQA1M0h5ZpmBIcKFGaYTAQ89ev9CK92rae
gaijm7prILpj5EfH8xVuPTe0nFE4URq6hZWWQ0s2QzhvJSbDOtdnPoeA4KMHqWAk
XS0wq/qF25aJ8dMOGMHiVo1LbVtxtqTkVzK9Y/Cpu5i84Ns9UD6Xub0SeS22oklI
WPTxjCIU3dl3QyLwJGGAy7J8dE38NwT1s5licGlb3Hu4NOcHeqiptyLVBywe3T6/
nTYa6LFKhH/4uFoizNzoIFX4VAi05Hv4pYxnesoM8KXSVm8fShSnMnEJd7Uzq/Pc
BaOzAF/glM/axs9LQlQMLGa3fyiMgoQ0N7sHCAsml4oIyKzlpJw+X/rxwuLsxIf+
Eb46Q8L1zHbLdxNlcpBlWjk5qYTqRJiLTZtY+oi7mImnrK7TJlros06QrwPia7na
iC7q3++6nTTYx8HNKkzBIsbHsJM9MSH7B+6+mQ4Cw9f5osclLpWt1aQUcqrY4KaO
NIwClNbhUEfLr4GOemhpnnPX///5Ai/JbZyz9fyQ2b4YXmSjXys=
=kzGf
-----END PGP SIGNATURE-----

--E2f5T9JFQ37uwpeU--
