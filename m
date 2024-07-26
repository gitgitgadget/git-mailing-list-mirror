Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323942B9DB
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 12:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721998266; cv=none; b=Zc6g5i6AK/lWsxRKXofTxo+G9bR2cNV1m92uj8kix0jg1iTh7maKL0HX3wgOaAuAIekQLAjcUq4lvCe7kAQa9qHeJiaMCnjLACfFEyod6D8QXI9JmK5cCz2hM7O30nemnz1s2Z3mZ+HK6Xysol9/6zpkT3qKs4VFWVaH071x+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721998266; c=relaxed/simple;
	bh=nN9096ScGzxgejcx3EHn7v1WWsLcYS82dWyOWclY57E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOg0NCGnuUlITS9HV9wxYP/Gt72KuSOOcEcGi57EsKzT9IqJ8VzepCs0m71kattqOFp/ZBB0iF1mqcdWEfbzJJ3jtGf2f38mYnJzynUajfuUoOcZh8XPW/ISeGwSTtmcBEncw7UsO7msMB4aJN2ovFUAlklKvwpxOfOkYocD5GY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cvxJ7C2l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hHWWQy1e; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cvxJ7C2l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hHWWQy1e"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id F26CE13805E4;
	Fri, 26 Jul 2024 08:51:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 26 Jul 2024 08:51:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1721998261; x=1722084661; bh=nN9096ScGz
	xgejcx3EHn7v1WWsLcYS82dWyOWclY57E=; b=cvxJ7C2ljz2B0Eg5oNBOZHOz52
	Dz+p7KTknIZ6efKezvVWl3nynYqdLjH/0wEiJFl4cJiWenagDWEBd6i3dlYxQnPn
	mVNb9fZ9PrwW9Aspvqfy/anFm4wddxPx6tmMKf2yCAkU66fjzFWD6yIXH2qPmMeU
	2EROtsA1aPbMLbN8EzxAyNk+R2QuCW7hijS1qz0Zhd4pkZUAY89d3xlSvms0Wtai
	GfWJeJDlg6tCC93kBsYWvjUQT58WyBS5PJLhSoohrr9V4MyOCl+NXdkenv2CLGMv
	uTYUZCZjhSi3FQl+RWVheIy+8J0+PhMogFwQgzOqiBObPKy2tmzodDii0jGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1721998261; x=1722084661; bh=nN9096ScGzxgejcx3EHn7v1WWsLc
	YS82dWyOWclY57E=; b=hHWWQy1eYOAKrQfPa8CBBPgkxWulrKYqJFfuV2p6IJRP
	cfsAIvU947mCdsA+PVolGZedVcUmIFhgkH0u/K7NJjlz+8xp7cKQbImUuNzxIns4
	utv43pGOMvClHaBFwCRlxlHJw24mjsRMc7GTyjR3W6en6JHgQGwKbELz3ke7adMT
	YpnXqjbJiv9NIcYrpWPLPParygToa8bfwjcMCxJiFGfG7Dwp0Z04l/PaF8t5qJ0s
	R1UPb7xdrIKDqRvhvAa3onSeBSG2mDvqlrrh+7Lru0YbTyx0zR6C/p49QWryVT1J
	jxInsSHJdpO/TMBbim+svz//rLUv9ZmBrv/jyNxFDQ==
X-ME-Sender: <xms:tZujZqJdNbC2a9jp7eXwae5yHSAL2_hQQ0ScR-AwVXt-R7525rzwrQ>
    <xme:tZujZiKGJg53wmZPj1Sm75GggnK6LUqQrm79upvSWuOSwbfC5iPsNL1Wqwkvf1lPS
    ztu5M4WheKS_-yW7Q>
X-ME-Received: <xmr:tZujZqsAor0jr5LOWi_rioTm1YH3T9UzkVfXMg_u5XzcQq9Gy_iy1F--K-ZIMxereh3j4WhFfaUYnTZ93opCOxedt86Y7EGu6EzSNhvHyD8Dbk5q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrieehgdehkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:tZujZvZWG3dLRJalgUnaKtXvqQBBhT2uTjhCcRPFDHK2ztf3BG7seQ>
    <xmx:tZujZhbP0AHKxPd6S4duBcVhtuftjwBQbpk25MI4_aktMcm1Y6Ug5Q>
    <xmx:tZujZrCMJN2yl800Ud30dm9DTNSFTP0G3gQuIGFkEsnEqPmp4I5svw>
    <xmx:tZujZnaY08MCsvbwHSvvwFH6VDM4OrqZZhagWeaoFqdkWWqlwvZVfA>
    <xmx:tZujZlHYL8BArUtnqnrpFvh5jpFDx0xe0oOquMbZgyxFAj31_v9v8UsE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Jul 2024 08:51:00 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id ce4cced7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 26 Jul 2024 12:49:37 +0000 (UTC)
Date: Fri, 26 Jul 2024 14:50:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 3/3] fetch: use bundle URIs when having creationToken
 heuristic
Message-ID: <ZqObobw8FsDMkllm@tanuki>
References: <20240722080705.2614195-1-toon@iotcl.com>
 <20240724144957.3033840-1-toon@iotcl.com>
 <20240724144957.3033840-4-toon@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZzEgT8aDDda3s6gc"
Content-Disposition: inline
In-Reply-To: <20240724144957.3033840-4-toon@iotcl.com>


--ZzEgT8aDDda3s6gc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 24, 2024 at 04:49:57PM +0200, Toon Claes wrote:
> One way to achieve this is possible when the "creationToken" heuristic
> is used for bundle URIs. We attempt to download and unbundle the minimum
> number of bundles by creationToken in decreasing order. If we fail to
> unbundle (after a successful download) then move to the next
> non-downloaded bundle and attempt downloading. Once we succeed in
> applying a bundle, move to the previous unapplied bundle and attempt to
> unbundle it again. At the end the highest applied creationToken is
> written to `fetch.bundleCreationToken` in the git-config. The next time
> bundles are advertised by the server, bundles with a lower creationToken
> value are ignored. This was already implemented by
> 7903efb717 (bundle-uri: download in creationToken order, 2023-01-31) in
> fetch_bundles_by_token().

I think Junio essentially asked this already, but I'm still missing the
bigger picture here. When the "creationToken" heuristic is applied, the
effect of your change is that we'll always favor bundle URIs now over
performing proper fetches, right?

Now suppose that the server creates new bundled whenever somebody pushes
a new change to the default branch. We do not really have information
how this bundle is structured. It _could_ be an incremental bundle, and
in that case it might be sensible to fetch that bundle. But it could
also be that the server generates a full bundle including all objects
transitively reachable from that default branch. Now if we started to
rely on the "creationToken" heuristic, we would basically end up
re-downloading the complete repository, which is a strict regression.

Now that scenario is of course hypothetical. But the problem is that the
strategy for how bundle URIs are generated are determined by the hosting
provider. So ultimately, I expect that the reality will lie somewhere in
between and be different depending on which hosting solution you use.

All of this to me means that the "creationToken" heuristic is not really
a good signal, unless I'm missing something about the way it works. Is
there any additional signal provided by the server except for the time
when the bundle was created? If so, is that information sufficient to
determine whether it makes sense for a client to fetch a bundle instead
of performing a "proper" fetch? If not, what is the additional info that
we would need to make this schema work properly?

So unless I'm missing something, I feel like we need to think bigger and
design a heuristic that gives us the information needed. Without such a
heuristic, default-enabling may or may not do the right thing, and we
have no way to really argue whether it will do as we now depend on
server operators to do the right thing.

Patrick

--ZzEgT8aDDda3s6gc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmajm6AACgkQVbJhu7ck
PpRV0hAAhbw4CUWS4G1VL2W0Ns2PbjFvIlDapCQlDwxHr5U7kzvvrAZXeWlW10jf
KTM0H/T0D8mtMO1oL8Np8PQv5rzy+bkShvGEwxmhsOjpmduEGgUCUVuzCnZeRc7U
eksClMVwfhKikiXkPHFpwAui8TBQwttKxbOWfVw70FxI2S/wkFfx6m2jelw0F6ap
MVmoRlfWst+QgFb3sBPbyQ3hLskNLHDU0M4Rc4bED7lVhLpLZydlCN5RngmiDp7+
3RP3lZfpmdGQSy7FWt5FHIL51nPJWi97P4DcHbLZKYHwAcDc1KB3h7SjWkDUNtQN
b17OVZOzYXSsb5vsCY4oLnwx98RBJGBis37AxmUOBs/iPbNAWjroWfJg/ZMwtqDu
g4WvYatbbWNZPfjD3GHqCBSvIzaPQcPo+tDlHmBwZyDPhHd8XwwB75Lkho09UYu5
ZNBbvojkA7w9kLTunhZA7QJfogQdn2KPfspE9CFafYO7HGKcXPH6kTBGzs3yUHZ5
p67zQlrS5gYuMtsb3z03yy4aSAe/4X+wu4JSRnx1YhFLG1ujHLz3cP/JbYvH9nwK
90cwQt3lCaFu3Dy020fVmgAz4i9u0T29oyNYN+nKWosz3XhhnVeNvg/PjjFOuU0B
eVhany03DyXkkumi7z7f05h2XI9xYeH8HZzoXr7jFLjVMPmD4TQ=
=1hZf
-----END PGP SIGNATURE-----

--ZzEgT8aDDda3s6gc--
