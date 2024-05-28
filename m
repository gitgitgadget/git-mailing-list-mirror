Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9F16C841
	for <git@vger.kernel.org>; Tue, 28 May 2024 11:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897325; cv=none; b=RLZoS5md/R0vX5wMbEsL1XPqNT694m6W53124ibV1ygcK8zJy+az9yuBUfG53DJOC+1CTKlWI1/8a41glsSI6AEYjUuUGyQ7ZKQCm17eNx7enV9PHHgsisk5sPnnh47JhdEGsT1cBQ43aCcPQYFkWRz+FAyvwgqlZoaqjA9YsVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897325; c=relaxed/simple;
	bh=aU4jXHl3neDc5HyRxjBjqtv/p2xs1W4iowrvOtgmaV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qfz5SUWD16SZacyhK/GRq6T+5CO+gZ+JAUjAl3BGXaGv67xmS1/LezL7309BxAoKFElScWL1EH+FdLuDYN91ehe3aP9/silwTAZsWv/y5mEVwufoQiL8h/ERFSOeYKPYNwA/yB4cruZrEQf85scwjC6OfzBxwJuFHGWm1xfjN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ansAfYGt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LUB0Ozn4; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ansAfYGt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LUB0Ozn4"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id 382031380106;
	Tue, 28 May 2024 07:55:22 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 28 May 2024 07:55:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716897322; x=1716983722; bh=vwEfN4qPT/
	IX1zflqYE5wanczpHW6uDf/wjkfLKl9y0=; b=ansAfYGt4XlO9wI4j/20vmxP4B
	tzLW75P2zO3/ARsRxoyHa+q+1H1Rykwx2fnnMy1dM3kXO4HLa8ukMDDFK9GWT0ta
	jYO+zp3lssPw7EdJwa3GnyGSHhm77mWE+u0OAahVh5p8yRpJGPjrOvzYMWr9Le7v
	4h22psPa/el7fNuQeD8OeP1c6NNVFc2B7KtxsdLoJb++dlRH7nmz1THHzIocR5Sj
	CCspme1+tz0vbHXtC/Vka2RnXjFsydxP8PFMmFO6ErdT8FRX4IOJABAfaYRd7FHi
	B/ZspqF5FSUBCiihQ82klW+UBSJ7ydw8g0xvPguPzfoI2EyD79U0V25ZWjCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716897322; x=1716983722; bh=vwEfN4qPT/IX1zflqYE5wanczpHW
	6uDf/wjkfLKl9y0=; b=LUB0Ozn41m2X9QWEJvAGy9lsN+m+TmcEwnXC1qgZDIT2
	DQSVtOXDdB7Ar3ymy6L8g8lJ5Zhm+eugd4CkeiAVoZeRPGA4aO96UQVxdgpcAnX1
	N1/1h/M1+4PkP+CXeTbKhTPp+S1vKKFJQINeoc6+P5HxI88bTbhthJUXiT+1zw2H
	iSEf2AbD5c85S42g70tEuI01KVDAuBtxhxJCkrGhwXrM0uSHJIE2C0ODWRUUjdNW
	7nAWDN0OEUHTFO2snWLPvzo0WXW2SxdTtGaShaWUPS2rIHMo7WszeLr2e1+UpCWX
	dfS3uGq/ZIelJiGnZKwfp/fuCkhdLt9V7LHS/MZEEA==
X-ME-Sender: <xms:KcZVZgvV26ncqRje5g2bKgvgEU9Kzd8gWGqoqnzGuDNReDAXNE1qvA>
    <xme:KcZVZtezGwx4HJqqFpj5g2vmc4PY5AII_WN7Rug6GeM5bG1_TH0jFFykoIkF0tP0v
    Ca-w6cKfcz-qfyLUg>
X-ME-Received: <xmr:KcZVZrwU8z5x6_ye5YVwijznSf8TUf2s7FMpHP2OM0HaCHNln-WpZytRCOB_Cx83w_mF8hRJnbw0D_qCyxaYKBxGBB-P50gkC7_F0ANuHXMPnkeP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:KcZVZjMoVJwlZgDc7Rl1s9qFjeugG63MwEyOCdEfb0MuqdJZoLRQMw>
    <xmx:KcZVZg-0OrHZOcTrtjjmZt8O39MVWpWfI9SeclmKCSKWXaXqu0-UOw>
    <xmx:KcZVZrXAfrRbDlmrnj8XjihSsuSM02Plx10hAV88bOFtx99A0srkWg>
    <xmx:KcZVZpc8lMp2VcDzYxDpx5AAyPk2m3coiL2XqAWXQ56kPORSQqjCCw>
    <xmx:KsZVZvmShDkq4cT-qeNwUxkIlmwvNR0vzl92ZZzo6n_OHC8FeDZYuMix>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 07:55:20 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 91874855 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 11:55:05 +0000 (UTC)
Date: Tue, 28 May 2024 13:55:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v3 1/4] bundle-uri: verify oid before writing refs
Message-ID: <ZlXGI4lkaXcD7_8C@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <8f488a5eeaaa0cdb525c34c2c165e6ee74ee7691.1716824518.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r4z5W1YqIR4f+VCb"
Content-Disposition: inline
In-Reply-To: <8f488a5eeaaa0cdb525c34c2c165e6ee74ee7691.1716824518.git.gitgitgadget@gmail.com>


--r4z5W1YqIR4f+VCb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 03:41:54PM +0000, Xing Xin via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>
[snip]
> 5. The `verify_bundle` will call `parse_object`, within which the
>    `prepare_packed_git` or `reprepare_packed_git` is eventually called,
>    which means that the `raw_object_store->packed_git` data gets filled
>    in and ``packed_git_initialized` is set. This also means consecutive

s/``/`/

[snip]
> This commit fixes this bug by dropping the `REF_SKIP_OID_VERIFICATION`
> flag when writing bundle refs, so we can:
>=20
> 1. Ensure that the bundle refs we are writing are pointing to valid
>    objects.
> 2. Ensure all the tips from bundle refs can be correctly parsed.

I think one angle that your explanation doesn't cover is why exactly
dropping the flag fixes the observed issue.

> And a set of negotiation related tests for bundle-uri are added.

s/And/Add/

[snip]
> +#########################################################################
> +# Clone negotiation related tests begin here
> +
> +test_expect_success 'negotiation: bundle with part of wanted commits' '
> +	test_when_finished rm -rf trace*.txt &&
> +	GIT_TRACE_PACKET=3D"$(pwd)/trace-packet.txt" \
> +	git clone --no-local --bundle-uri=3D"clone-from/A.bundle" \
> +		clone-from nego-bundle-part &&
> +	git -C nego-bundle-part for-each-ref --format=3D"%(refname)" >refs &&
> +	grep "refs/bundles/" refs >actual &&
> +	cat >expect <<-\EOF &&
> +	refs/bundles/topic
> +	EOF
> +	test_cmp expect actual &&
> +	# Ensure that refs/bundles/topic are sent as "have".
> +	grep "clone> have $(git -C clone-from rev-parse A)" trace-packet.txt
> +'

As far as I can see there is no test that verifies the case where the
bundle contains refs, but misses the objects to satisfy the refs. Can we
craft such a bundle and exercise this new failure mode?

Patrick

--r4z5W1YqIR4f+VCb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVxiIACgkQVbJhu7ck
PpRGJw/+KfDf/Fkcks9wr1VWgNyACEEEXi3iTfUv/u9vw+zfn0yuLilooF6xwl76
223rqv0lcYJ83tgm9XSce2PdHSHfSLymR1bHDKqjVhE6cuPHt9+o5OjQP0OyR18Y
PvwNZSPmT2Vp6GJ/GfIN1UFi2w1zlDcloagFS0BjCcDOpknTLwAXuSgINFGsddsc
i1HHj+jXxBImYBuL/riKVwLZPzU+cSG9LfCUHhFUfjn7GuWr9O2NcFPX0fdbQKTd
3JbAm3A3yxJh5a98rmaJQwIY23H6LaPoStiDrJtEDICihQ0PUXRgtb7JX4XFymTH
LAn32Z1VIq460PwZbeJBH+007TT/7LN7fxFp/SQQgzv4qjfxk2sOEpFmA6PSer+b
s+9ftZgT7ewp1y7MbPV99nI6KtJWjwH8N1DlWYlANscpXeQYiydYl60enLx1HOyf
QKWADpMotnx08kO1mxH1ozFImn1gRvE+HbHDGHLye3542A9xrrAX71kH/2Lqt+AJ
LdM9l5UGDk/G2peq4vJXcZKwHiWaVWDA2NCGg02xoz6khmI/qVyS/iBuOedTLMHm
CVSk3vpLTgD82Hux5j9ckcV07dnaD4hj7jTW5NOcj3v9wJxRGWoqdfUSWcCSplHA
4IfpWcxBsMTyZsNN2Neow0XdXCVjzp7/rSI8V9TqWlXeeqni4B0=
=pBld
-----END PGP SIGNATURE-----

--r4z5W1YqIR4f+VCb--
