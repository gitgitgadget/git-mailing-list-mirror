Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5F217679
	for <git@vger.kernel.org>; Thu, 22 May 2025 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940447; cv=none; b=UVfQCkGWjaduH47m0UiFVAIf+g+KCvDE6bXfVE54j3PncK/wc1E2yoZQRUTBZg73Uvuo8Li8mffLD0pbUMny+0TpIUXY1kIMpMXxWX652YWsVFK7MZwXdyxhJB3ejU4EVpxCZXnpzOUDfhVZW/m7y9GuPVsYil+tYYA6Pf/MLag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940447; c=relaxed/simple;
	bh=zaE/+RzKzb3Vr9j7m9R8qjvuKRQ1ITZedT98xHytcHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WamiCfXqgdnc5hUqgd4Q0bdpCQek6md5L0b/jXW9Y3XFZFmCDJL9O/053f20Z4XEc8GBaUNBnctf+M+zUT6VPi/pbRgBwgFO8JH/oK7hADraPbl86faU57MmJUzwXeMVdbJmK9x4+5BV1rAbd9+P3Fbr6zb9Dc9bpJRQmdXoFZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=uorEYR7J; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="uorEYR7J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747940442;
	bh=zaE/+RzKzb3Vr9j7m9R8qjvuKRQ1ITZedT98xHytcHQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=uorEYR7JhyJkaupWKo3pCGSdTxRX2SWFsl/cMj5OSyuIQ2N7A5xI6NmcigTXbksYS
	 zCfykP3DWmcGBKyU8rl0C4MNz4DNC6rVZKemCKspDcfn/56/H602ulkeelR2cEyZFS
	 qg5xBd/IOPH/JbE0JF7q9jUVlhq6nTebBTPNI4PsEOcrc85XAr96H5eJ2lOcrgiyyV
	 Re7lExvMBHBBiAXgXURybB0lACIAVEto+yZfOxhkmaonNMh9Lu3qeOnEpPTkUo5mrR
	 nwrzk46Ry0axYjWtAo6mHAbYY474ggfg7Lu2UT6ytvUoYY8kFZ1KMB4Mbnc/VLkjBs
	 H+OI5kdhcmc3YrtfbDMdZ7lCySgaWvje5jo2EkMytoWhTy7OVuLuAFD/sQ4r/HT1Ed
	 1deLOnEDf5cdqyFn+Ezg4zYguizZFN6z//TVihcGp5KCLkHtQoNDhIX8F4joYkXXXo
	 FRoRVgQNoYgHKJLqZsqgy0XDx1HDBCosFqIs5jDIc9ASsw5BNuL
Received: from tapette.crustytoothpaste.net (unknown [104.129.158.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 889C52010F;
	Thu, 22 May 2025 19:00:42 +0000 (UTC)
Date: Thu, 22 May 2025 19:00:27 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, pwodd@web.codeaurora.org,
	"D. Ben Knoble" <ben.knoble@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Makefile: avoid constant rebuilds with compilation
 database
Message-ID: <aC90SzSUkhVvahvU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	pwodd@web.codeaurora.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Philippe Blain <levraiphilippeblain@gmail.com>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BwaWb+y5KOgk/rQh"
Content-Disposition: inline
In-Reply-To: <20250522185524.18398-1-sandals@crustytoothpaste.net>
User-Agent: Mutt/2.2.13 (2024-03-09)


--BwaWb+y5KOgk/rQh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-22 at 18:55:18, brian m. carlson wrote:
> Many contributors to software use a Language Server Protocol
> implementation to allow their editor to learn structural information
> about the code they write and provide additional features, such as
> jumping to the declaration or definition of a function or type.  In C,
> the usual implementation is clangd, which requires compiling with clang.

Oops, my apologies.  My patch directory was unclean.  Junio already
picked this up, I believe.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--BwaWb+y5KOgk/rQh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgvdEsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZyDjDtUyaaLKxhWK8Gx/7oIEhlD12kllsEJkatFdhKTS
FiEECCzmip28ZfuD0cORfAxJYoiHooEAALYQAQDC8+QWvULF5Hydmf4tdXseAbSv
GDgzhb4E1dV14ebmfwD+Idmyn+1cDQRjDb/F2QXdUDKRJgx5OFh83lNZI7s3Tw0=
=pZbX
-----END PGP SIGNATURE-----

--BwaWb+y5KOgk/rQh--
