Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F771753
	for <git@vger.kernel.org>; Tue, 28 May 2024 12:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897956; cv=none; b=NsobKSF8CmvTu5ZFg2b84jw6HwQRKvc4jxYgPZgTKCOvEaCmXwzPlZdR4lSXDus8eA458V744sbun++FjAAdgEJuXmvLC/sPZ5egObdMmDCOI1mBLhGahDfhLBHzMdvakQx4qQ2ZHhCNibpi7dGCRbznDVkahIIWaS2Yq7HHSRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897956; c=relaxed/simple;
	bh=uvHNemIGBqPNl+KfSrWhJ+29xd632zI0nbDk24vQE8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTsjCcZkTECR+tYg1ya0JT/KkCDe9Qw2A4CTCHXecXLck3DW1xoeLL2c7sV82Hfj7lilLxoghpkw1czpgGjpKHk3lJL2S9GHQZ3MjJ4xE7ZmVWqxvNi9t6W0BsdpCnGtXDXQax88xM4+jnPFtEwMqD4pYoAQqVcnSOBm0rkrYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZNwXoCwm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gfNptL5p; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZNwXoCwm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gfNptL5p"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id C040518000C7;
	Tue, 28 May 2024 08:05:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 28 May 2024 08:05:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716897953; x=1716984353; bh=xo5dyHw+9O
	4YsKpHGlBps8OfJQ0G7Zxz1PY9tR0I44A=; b=ZNwXoCwmJK4REEtwrysAgw4ozB
	mik76TLJyYxt5Pff98huCqZzIbeGiflo2b4XM0S/kRZhim7MD+8QjS/ziN2S9Y2i
	pvhbTDSHwU9L9fm3M6sCbfxh0h9swlzPbVQQE0Vj5ag0PBqnnbMtTeE7EeGUdiDy
	HD/uPld8Hybv9N07IHFGPaDekOSAndLHsXXcEKVfhm4jdbrMODckm+VVqrOYMx1P
	hw2h04Mos50cGvsYRduc9M/3CiN/zAY9LZRbzEtrCIQifGEXfF6E8Bqo8xv8Zg8q
	JkkrCc7ijXUH740gJNRIsuR64NV3ten89ZWXRVAiavwi8SNRgsbpMaReSycw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716897953; x=1716984353; bh=xo5dyHw+9O4YsKpHGlBps8OfJQ0G
	7Zxz1PY9tR0I44A=; b=gfNptL5p95vENfErerLclJTk1lnsBQFBaX4S8aQOCVeF
	3lRQYiI1s1ag7w97r3OdEkMMzEuZEVQyrmHiGvq72isp+bQlfmjNYgXhSZR4oNJl
	BZbDbtHGZIR+1USDtEtOsfxV9zutWFmRtYC6LRY9CvcsRwa1EBwUkUhK+qNDvkdu
	ZVWkd+FrpvEnGlb0Oe5DSKPlU/0qDaRdMXttviUMmSyKnci2MQfq9qltPkc9CRMk
	EYEZC61mIkrsfIYztBwxLvsFl6bXHoMHcV7yQ7rdxuBtTW8HwiL+hJXx0kX3Ytu/
	ZdtwM8/wae7RkMl+Q7Y0VzAsp0u7xCJGfRiGJeB8QQ==
X-ME-Sender: <xms:ochVZrNTfXpDYm4_7lC8zVG0Omj5CXvfKHna-y8aChfor7hBPYbv0A>
    <xme:ochVZl-RiWvJKURRXwcQtm9KTeAqK-c87umyXrhI7uOls7WjRMnOd9QuC-aigWZfp
    sTvZPzbItYW361RNw>
X-ME-Received: <xmr:ochVZqSXIr_C1NiSOtgkyZ1_M3MQjh8646whuqX5h4WOdFdXXKQxoACCRBAHdZ4AW34pcslMBzl2vw_prOGxOhMiltXOfiuqAGMkwnMabdRNLfis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ochVZvtUC74_4UlIe9xkZqzVc3kQ2TmWFbr9HBvE2kC6rS-DLc_xOw>
    <xmx:ochVZjd11FZRmQUKSS-HfvVOJsbvxcCHbK8NBvR7ieoi8lSc-m_Cdw>
    <xmx:ochVZr3uXxszhAFWTcJ_Jc55aHRlkNnVvw38hfj9sEBTrkHVFBw_0g>
    <xmx:ochVZv8FMEeOTi0nLQKEBd5Nub-NIYYD2-Ao7wm36AncWGvbltRz8g>
    <xmx:ochVZkGltg0YzCu12JfyvKDUUzeVDHJfa627OxJwYXXx7T0q8vZnElng>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 08:05:52 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5529f2b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 12:05:38 +0000 (UTC)
Date: Tue, 28 May 2024 14:05:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v3 4/4] unbundle: introduce new option
 UNBUNDLE_FSCK_FOLLOW_FETCH
Message-ID: <ZlXInJZn7oDfyvWv@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <c19b8f633cb9f851948b3a17b5425f3310d900d5.1716824518.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="H1uM/nxjIA9qAgEt"
Content-Disposition: inline
In-Reply-To: <c19b8f633cb9f851948b3a17b5425f3310d900d5.1716824518.git.gitgitgadget@gmail.com>


--H1uM/nxjIA9qAgEt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 03:41:57PM +0000, Xing Xin via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>
> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> index 0d1e92d9963..423b35ac237 100755
> --- a/t/t5607-clone-bundle.sh
> +++ b/t/t5607-clone-bundle.sh
> @@ -138,6 +138,29 @@ test_expect_success 'fetch SHA-1 from bundle' '
>  	git fetch --no-tags foo/tip.bundle "$(cat hash)"
>  '
> =20
> +test_expect_success 'clone bundle with fetch.fsckObjects' '
> +	test_create_repo bundle-fsck &&
> +	(
> +		cd bundle-fsck &&
> +		test_commit first &&
> +		cat >data <<-EOF &&
> +		tree $(git rev-parse HEAD^{tree})
> +		parent $(git rev-parse HEAD)
> +		author A U Thor
> +		committer A U Thor
> +
> +		commit: this is a commit with bad emails
> +
> +		EOF
> +		git hash-object --literally -t commit -w --stdin <data >commit &&
> +		git branch bad $(cat commit) &&
> +		git bundle create bad.bundle bad
> +	) &&
> +	test_must_fail git -c fetch.fsckObjects=3Dtrue \
> +		clone bundle-fsck/bad.bundle bundle-fsck-clone 2>err &&
> +	test_grep "missingEmail" err
> +'

Do we also want to have a test for `transfer.fsckObjects`?

Patrick

--H1uM/nxjIA9qAgEt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVyJsACgkQVbJhu7ck
PpRQSQ/+P6w/YhxjyJmoWwwOCp+4VcOo3J4HFrqNpeRTPdSbUME2Nzl98hacYeuC
06m3LGq8VE5RIRaKXcl0jabTROVwJ6DWi/tTcDF5jya8JiCFwD6LY9t2IPDMgGl+
WJAELQdDhpB2Kk/d3Es+wR4JxmCMT9Ks51277+vgp31Vq458ONcHOHIfYxBIhNU+
FWxjmf1w52ZKmUH0yo13MBIC9jSSJwQSSIUk4jYq4cBCZbNNIelaNmTWLlzMKjCY
toLWfM8k5f/QBh/NSEk4ccwCOPmllIyPRPqxPXlxoJwAabDMcQfrGFENGgCtF5h1
4etwgsc12wT/6zQeRqxOoQhSAVppzV4fVx43BZ3ZDMihmCd1asYQdHnYU3AOX9xC
BhQ/KfseqskjguqoYu6q3POOWmNiJPNccrCe9XlYvbuFqDMsk1nVWLsSK5lfbAdI
GrSU7CljAa1LLe+vjNdJ0QLvZyrSGhqCkV4hILCEDZhqg1EQlEnQsK1ulELO2ROk
AnqZyypiUXuDtYx2v6rLZGG0MqtUv0F3qwyE37DbR8QFuPwhk//CClin9fLwLtY3
E92pMn35WUR6s3zyCVmWNL+X7ZQNOOTeFhXXumJyQg8ySERDwdvWy3XMqXAj/dcJ
Mu7XR7Qf/94NnIPIByrzNq9Qy4R554SvhRitI4EbpgnYG4fc0ok=
=K3j/
-----END PGP SIGNATURE-----

--H1uM/nxjIA9qAgEt--
