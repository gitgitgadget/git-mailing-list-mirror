Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52D42DE717
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 17:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772298949; cv=none; b=OyVzUc1AFCBiCYqq+Jhs9tDmLhqL2OziFrvKq8vnjeUtiN6bneatBotii/yYtrKMO2KLTKZhRoNTAZ2tnWLRcB/Yf1GnjSu5OPw/anOC9hVd6CWhpTXxluC/ZzoBsO3LaPLlLu9XRarTh7FNRrq8xXobWB3/TzMm8VUN+wAiVqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772298949; c=relaxed/simple;
	bh=NKTZrjzqBSuNpKt43lqs1kfIIJqCSb5M1HQxTgMTX1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sncUK3bQjWcEGtLmf/mRm+2bzplxu9+Jl1ua5KFgbBkWmc6Mhls7/ZThiFgvHWP3Q+p0PRbFuWKjxF2alRVCIewzSLkrec9svljizV9xUdzaED71wZA8YjEAILcJl8ivWaPn801wlJWZMXtUwjgNu4ZizsqpduiTJdptuXP92yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=PzsPcS7N; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="PzsPcS7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1772298940;
	bh=NKTZrjzqBSuNpKt43lqs1kfIIJqCSb5M1HQxTgMTX1s=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=PzsPcS7NGft8khliE2BpMx9QvQWd0Kxzy9V9DwbuAUq0xwKCfDFbscKxr/hdx1PGi
	 aD9gAIzGW+Hfh+LWkZgU30dJrTrh8pXzjjFGTveFBmfQulwBPQca0wWJ6t8QOeFNu1
	 s9AL5bKABFYABs4EUbZ2SkIldhDsBTd+HkfIiibL2WecmSZ3BLgglm7VXRbWT2ySz4
	 nW1jGapulEODpCfBwjL0/+SDevMvGesc1VTxmJpO99A5xir3YvrCN2w02VtbWeCvCV
	 37BWWRwS/49HFJQxGU1OpKVhJoF4Rvmt/sIaLWepRNu0nI7Au5w+MwgyudefFC5EvG
	 3aywJXN6qNd1N/TUTBi24w2eIRPSBu1hvFanc9p3CCTaVPheV7WCegcc90eGY/C0Ci
	 Jqh40XNXo8H7RylTYSdPHlWc13X3+LVG/0zDELTizXyGvTP+T5OAPJR62XCv6b8ULv
	 Vge1qzQtGSa2RsB3Z3appTY+nx0rE7kKBj97HztusNTd2DqoBBC
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:6292:ce7f:47e:478e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D70AD20106;
	Sat, 28 Feb 2026 17:15:40 +0000 (UTC)
Date: Sat, 28 Feb 2026 17:15:39 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] fsmonitor: fix two bugs in watchman hook retry path
Message-ID: <aaMiu9mDVAb6Qvyr@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Paul Tarjan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
References: <pull.2180.git.git.1769391202338.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KaEVe4gVdJ51zlkq"
Content-Disposition: inline
In-Reply-To: <pull.2180.git.git.1769391202338.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--KaEVe4gVdJ51zlkq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-26 at 01:33:22, Paul Tarjan via GitGitGadget wrote:
> From: Claude <noreply@anthropic.com>

This looks like it was written by an LLM.  Is that the case, and if so,
how does it line up with https://git-scm.com/docs/SubmittingPatches#ai?
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--KaEVe4gVdJ51zlkq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaaMiugAKCRB8DEliiIei
gXKLAP9lEUtKXJW4p/wxyHdZppSBgavl6lX9rgbsnxXaLZTi9AD/ad6MHp3FFmO8
d3YopRYJWNjT7p8jJekcaruRGu3+JgA=
=1dHE
-----END PGP SIGNATURE-----

--KaEVe4gVdJ51zlkq--
