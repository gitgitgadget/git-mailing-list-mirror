Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B229413
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718177889; cv=none; b=NWFHaxsuJe9V9ks26Ouh3tBWicWJpEgjrwlBpmGi57d/eUxsc0z6eFOHLK3aeVH5AOu8JulrUWRuEccUSvSl5jIjp12fFof2thiAbiks6KtWMBLA7MvgLyddzvvcD4KOMhwds0jByfhbqWr2+be7qWqQ5ZCJiKYVOuG0y/R47Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718177889; c=relaxed/simple;
	bh=gp8K9J2quAnEpT7NXknKjistUDaHVtZVPpDusRA8Tcs=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YghwI9WTtjWtXLSbhdJxWYZLxuGWNCgo9ZKlWyUi7KQEgpcjeXLMg7HqU3+eOTSZuK10AK80BRd1Z+mt34rGHSwUR+jqKmVn3LiEv8xEtZpPvdKdf/h8E9eY/MhGnJVrluqxRRw1gpTOg+ydaSdh1BqX3OxVHIv4Jweg0U/IDuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CocS9m7I; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gDfbU0/n; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CocS9m7I";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gDfbU0/n"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 82CF91380149;
	Wed, 12 Jun 2024 03:38:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 12 Jun 2024 03:38:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718177886; x=1718264286; bh=L/4Cs+NVlb
	N0hm3mkqVTn1fSvFLhhNhQ1i+GhH0Fp2A=; b=CocS9m7Ivg9oZFv4o69YzOcx5m
	TnrYnESIYfBPb0VB9VC4BOLqknRW9k1Bsyp/a8xmJezr+DahASqYzzw3Db0xRA+d
	Pjy/fDqnMSEUxzE+irhmmf3XtwvWfGvj5PibYedKqVM0/ZJdziFZ6KN2JJvjTq0Z
	y+N7sPgyyzPanHefFsraVGUDLhjNHyS5JzuBnOIChKKq/mMmmkO80SrbNsWlFRzZ
	hMcy4M54mmWpqDPZh7ttyqgXzy1CZ/fDazh/nqabgV0tZQTDFp+KnRxv2syhZEo0
	FVgVM0HQXSUWUYGugLKVPjgflDw5bsf1zeOyNenruLAPIzsqQL23hH+NBcVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718177886; x=1718264286; bh=L/4Cs+NVlbN0hm3mkqVTn1fSvFLh
	hNhQ1i+GhH0Fp2A=; b=gDfbU0/noawfXkpV49QwuGA4+FA1PPWNQTP8BF4AcFd0
	jCXZsDTGuR4oESYftzYimo5zGmaRUqj9Y/Lpwzsf5s7uEeDjSk/YNHkKLdaJNK3j
	231ynfzbqYxw/e4SNkjR2L3peGhie6uuzZOxiTIsDwpX5GOMut5umXvZOlDbp1U/
	Sngp4uNl4sq9OKwPa3rIvn8zTwFkDlau2JIyuUYufQv9vqn9ihrA2qeUYYO7QiYz
	AZE/bX+K1GZPIOkRT551haL215PFys9WC2zrZXOpjo8d11pB52XML0p15seQW3Om
	uvTWUoRjicunQ/p6CRXnadiBL63Pp+aBGoy1xdgrmg==
X-ME-Sender: <xms:XlBpZmM0rvC1B3MYk3Jevw1HwyhAdvygwUdVWFFBjQ6SC2FOF7Sy8w>
    <xme:XlBpZk9cd2pTdKXFMB4h_7fbNXkcLGtLmZYc_ZlTa99AGlcMXcaIobt2znVO7d41i
    OhHZEKfflSQO4-GeA>
X-ME-Received: <xmr:XlBpZtSf9SMOHwNEStpcj4T8Rth3wO3P68tBsc3szd_KAXsUVMsTO7QHAm-juWNuceNFtDV2-SJ_TvdEDqaexwJR0Caj8soKPiNMFheAKq9whMkkq-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:XlBpZmvxgHHBeqlKPijfGa_PhnUc19x25wZ2PmqzN2lH4sEJEroWCQ>
    <xmx:XlBpZuewtMEP-ny9XLY1A_Ur-IIS6WLGCMI7LOxJ88G7AhIrLOHlEQ>
    <xmx:XlBpZq14ubjiVerf8f4TsOiT04kvdtWpkXKxpMUhTplYyWs_tuQKwg>
    <xmx:XlBpZi9hfQHQPc0wrUXmE7b-uIuXd8S3kgTBMhIl4Rgk0zwR6z86fw>
    <xmx:XlBpZvpTWPliOKJKxFOa8WQMKMsiovhn9BqMacMe2kq_ZdzfURRjtFi0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 03:38:05 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 34309f1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 07:37:54 +0000 (UTC)
Date: Wed, 12 Jun 2024 09:38:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org
Subject: Re: [PATCH 16/21] compat/fsmonitor: remove dependency on
 `the_repository` in Darwin IPC
Message-ID: <ZmlQWh9LBzZb_zU-@tanuki>
References: <cover.1718106284.git.ps@pks.im>
 <d4e87f9d6b4813fe359e22f4b5d5ebda28e09a08.1718106285.git.ps@pks.im>
 <Zmjas3s9OPJ9Ff5E@tapette.crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V9mKY5QNmvdQZRK5"
Content-Disposition: inline
In-Reply-To: <Zmjas3s9OPJ9Ff5E@tapette.crustytoothpaste.net>


--V9mKY5QNmvdQZRK5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 11:16:03PM +0000, brian m. carlson wrote:
> On 2024-06-11 at 11:58:47, Patrick Steinhardt wrote:
> > The IPC socket used by the fsmonitor on Darwin is usually contained in
> > the Git repository itself. When the repository is hosted on a networked
> > filesystem though, we instead create the socket path in the user's home
> > directory or the socket directory. In that case, we derive the path by
> > hashing the repository path.
> >=20
> > The hashing implicitly depends on `the_repository` though via
> > `hash_to_hex()`. For one, this is wrong because we really should be
> > using the passed-in repository. But arguably, it is not sensible to
> > derive the path hash from the repository's object hash in the first
> > place -- they don't have anything to do with each other, and a
> > repository that is hosted in the same path should always derive the same
> > IPC socket path.
> >=20
> > Fix this by unconditionally using SHA1 to derive the path.
>=20
> Let's instead use SHA-256 to derive the path.  I can imagine that there
> might be a time when some users would like to drop support for SHA-1
> altogether (for FIPS compliance reasons, say) and we'll make our lives a
> lot easier if we avoid more uses of SHA-1.
>=20
> It is also typically faster when compiled appropriately, although the
> amount of data we're processing is very small.

I only now realize that this actually a bug. The hash is already getting
computed as SHA1 unconditionally like this:

	git_SHA1_Init(&sha1ctx);
	git_SHA1_Update(&sha1ctx, r->worktree, strlen(r->worktree));
	git_SHA1_Final(hash, &sha1ctx);

And then we used to pass the computed hash to `hash_to_hex()`, which is
of course the wrong thing to do in a SHA256 repository because we would
end up printing `GIT_MAX_RAWSZ - GIT_SHA1_RAWSZ` uninitialized bytes.

I agree that we want to convert this to SHA256 eventually. But I'd say
we should keep such a backwards-incompatible change out of this patch
series and handle it as a follow-up.

I'll rephrase the commit message though.

Patrick

--V9mKY5QNmvdQZRK5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpUFkACgkQVbJhu7ck
PpT65A//XB5VnQeIqo1MZz0uJAXFeVE2ahtVcetuDkw9pk1+Xu26MqHJiP+SBhye
JTYpzQn8EUdS5abe52J0KI9EllR9VHebJi3kZ2nGyBsyrSshJfz/2hQrRy7JdDEQ
ED7TKrSeA+zc3Tm/xpML4Ex+86n0XTHr5phGdZfpOKXS6Y3CtRLZYVhmiyCcIKG4
CUFr3I7z0e7y/R9HNCozZEYGZ87CCooU/YEOCfuwRIaTr7vQJOqtPRXTQ7OW68Wz
2VIg3fDtn47dVfy16vdgvBxioneENBQAwVsO5JL1twSJQJZ0S6LMlOOUd7zQrke2
fPvrtLxvitUzL+X53ZY50w5KPeiJuaq0FLfRTcGk1M+0wHSIhgMoCeGSYWqW7yaq
vzRtkBjT0e8bXhKoheewBJLVGolmyNuDGcTFI1U2sVLT6+ZoujWC6VFuGShzuJ7t
QKvyt9mTJNLVgyaE5UIbq+iiJqX0dOWn5FTwbxpWGVEWjQjLya2nRMH1Tyquhbvm
tiyGI7aMjeKG99JfCH+XWlLf4aEekI/nBg0li3CxjforVlxFRFG5P+Bw5Ocmeu/b
MfkfaEom/nwwSAM6Npi1Rsob+3xL7rp+6q+g4phnDUIsq5DP089xSXbpWphgg6xV
9M5Zov4oJE92LsOGM+l/AyGdKBNqX5tA/aWMQFioFd8Mf5Kn424=
=Uj/+
-----END PGP SIGNATURE-----

--V9mKY5QNmvdQZRK5--
