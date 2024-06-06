Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74482C153
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 12:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675609; cv=none; b=rn9zYY1fAaaDv5nVOc1dWOonu0YCegIV/7lj4vDebOSW/MNfrPgHX1w7RfN5mxdcmlCcc/cnMMEAJlniwbd1E4lZG18Qg66Kqh+sYw1M04ZIUCga9mx3UOkNBKRu1VVfkddOlBd8g0XLS7aiqX35VSiRcatAV8bb6lTy/eEdEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675609; c=relaxed/simple;
	bh=lt5qKt4AnHwzJytjKwyXnYKZR0fcUYt39tUTOUjgyM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIoQ1kLKY7/OvBsyrCpgvE0SAYY/fDhrIZKcxVC8XjZ4bOLoLcqp+qSKpojItyBRIYy9zDJRVNrzQnyvb2q0cvyopzeX3fB5LBjnSOEmmbC0fUu1L9FPYEf7h9Hlik5kiMCuENrzW4nA6f8HDxiAl7TmUq/qi1nvysCxu4zl+74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=O4LLcg3g; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lF+YK3hs; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="O4LLcg3g";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lF+YK3hs"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 5B9E41800149;
	Thu,  6 Jun 2024 08:06:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 06 Jun 2024 08:06:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717675607; x=1717762007; bh=lt5qKt4AnH
	wzJytjKwyXnYKZR0fcUYt39tUTOUjgyM8=; b=O4LLcg3gMb+aie1N5eiCvp2Uuo
	MthwnyfzeyUP5LQaSV/AtsMRKgLhCQKTxPVUFaEKV6ZvtmkPDzhf6NJ5V/dUsLmf
	gvLcCW+mFDN1SiQSo/rxaqe0UfmG4oFc6obbvCYAK7AaQHkpQ1Tcig2mD9QDfaPg
	L0uoqTlUFJYHnBF7rZQbGlP1RtBMOWLPD9gmcL50ZgBFP7jgH46D9N423E5pW7I0
	O+kSgGFDbXSJr8gRB9pe2tFBNIa+mEpQ+YaDCSMvSJ6z5m9mTb9EmogSRvCcDUyp
	l0yH+r+qgAiaa/L3SKZCzF4awmsIBvpt9nQnTuHf/9qnkmkGOKlHGhtrdNdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717675607; x=1717762007; bh=lt5qKt4AnHwzJytjKwyXnYKZR0fc
	UYt39tUTOUjgyM8=; b=lF+YK3hsDtrpikK5He5JvOnk1Vu6HoOOqMVh8u5eqtEy
	vT9ATnhn6FShx/VFnvuEOUJFXb1fUw9OwtJfg+M3NHXqAnS3oiYl5iLwBgs6Fxum
	fzevhxh8BkCRXWi8Lk9FzCBE/shJRsiYooHxuIU9nrElmuYF9qylk4CPovjDHE7k
	i03uceZhpacQe/AVWXuJUT7BWi0Hpl/8NcmWyIN0Z9TgFiYnVpcIsGVMN2lM2Ftm
	fgOakuCapC/v/OPLvXvgTqeWcwZlhl5Q4A3mMwE/M8GmrqgBLVvwp69UFz7lfX62
	V93iuMIgulahW6Bbqpw1ScM5l9y/1ItAwFiAgcO2Dw==
X-ME-Sender: <xms:VqZhZgXIBMK-ajRa1xeixt6nKLOz1J8J3YlAiRz9LbOFoEHPHn4PhA>
    <xme:VqZhZknET-rHOsA83bzDRfkgMbIptZ-2GbxFwcGTHbCYsY8s0T8DNQLTWBjhx55zu
    wo5JYhXv3UR0hi_LQ>
X-ME-Received: <xmr:VqZhZkaB_KYC7ZG2okFUGPoy8BLYPPgGRbKcrpQt2BlzpEXj4CSeK5CcGDIwLYCLae3XTD_40miezSIeVh1dtn7J3M7ebn3rcENCYlniVh2s9Lv1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedggeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:VqZhZvVaExvpOROklxz_bJUkorJY9WNjTCNZkrhQKjFbKBxnSaZCkg>
    <xmx:VqZhZqmcFXchnt728nxSvDL1ddEN1HomSgPmTk1YrSBRuHe2wPivQA>
    <xmx:VqZhZkcmppn6dd7Wjx54Ja9g-OdhWGb0FSkGdHtKgptSeuOjTu9zMw>
    <xmx:VqZhZsGnMwDuJhQJBEBLb-6Hhsk0rhNF9y_95h6hQgS9WL9NUbNW8g>
    <xmx:VqZhZhvqyl8yYsz_JbsShfUjhEjjlhv_rUpn1_4o1QbxZyHRXOzjjPZH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 08:06:45 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4d15b747 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 12:06:12 +0000 (UTC)
Date: Thu, 6 Jun 2024 14:06:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v4 2/4] unbundle: extend verify_bundle_flags to support
 fsck-objects
Message-ID: <ZmGmUcO8OYuPnH9H@tanuki>
References: <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <pull.1730.v4.git.1717057290.gitgitgadget@gmail.com>
 <beb7073581123c1a9096d466f1ccff7fa68f3a19.1717057290.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IIp52NtmKYjFgEYn"
Content-Disposition: inline
In-Reply-To: <beb7073581123c1a9096d466f1ccff7fa68f3a19.1717057290.git.gitgitgadget@gmail.com>


--IIp52NtmKYjFgEYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 30, 2024 at 08:21:28AM +0000, Xing Xin via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>

Tiny nit: the important change in this commit is not that you wire up
the flag, but rather that we start to execute git-fsck(1) now. I'd thus
propose to adapt the commit title accordingly.

Patrick

--IIp52NtmKYjFgEYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhplAACgkQVbJhu7ck
PpTKPQ//VmW3gd19wKmOuhGeE7dwwMBTJm3P/OQyF8VZHvnYnCHn6/Su36gQLNUj
7FEervFJhQD/uADcNKqPmimO3bkYmmkpBsZCjEQkNBDp03kyCSKOVfw27PolXVjv
vtHbKtoW0eu836hA6RhHzCqCedUyL9A//qN0xAYiAUaAESRnaBxF4T9Afuy2erGE
pcOnhe3/NWBpt0XYouT4H0mQnBiQ6nhgr5izZNhZOuZTvfT3GFisJgUpTBvdkD2q
fzwAK/X12BfDP2p7q6mYrodazfCauNE7HA21s8kZqOOYX2wHcWI0YBbbE1vkm8l4
Af3MWz0TWsp9pJQPLp66rLecIlkeUJbg17vCrBqH3NspjbIMOniAddeF3xbbqUwa
5Yy1F1ekdJGLa0dKCdPM4JdYKNc4tjXZMcPcAK3EgZzFfBlKLZXk0Is/3Fo5Kx7k
uAWUyBWH7cIQPnu701a8rOPUIW82+ps8xCvUtBeZzEN5hT8qaJ8hX5hjZHTFuKHw
LyyAbNvU51EnUKapzwf7MH/XUhv2G2kFWCX/dAFSG9GZdlXV36YqSih5CDLsd2r2
MtZuTC14s+Wy3gnlYBu3jmAt7+WTQ89rUUlCwUwF9v9SGyON2sl890k5Y6WlBoNS
fXS3n79SToEtk8MQaSttMwOSUdh9eBVpat4y9tDOlD13beQcGSQ=
=ywqG
-----END PGP SIGNATURE-----

--IIp52NtmKYjFgEYn--
