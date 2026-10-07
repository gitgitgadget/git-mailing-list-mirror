Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D243D353A7E
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407272; cv=none; b=XiJNJONGEVAbgOYuxtTGwfU+XazqSV42VPvwmAIZNfh85vF0gYsBvj0V4tItY/rGV/5SYVuvjYa9pn2u33oO4lnRk19VkABM0e9taP963cuF09Fu1ot1gToIyxG+8IwLcQtOtJngL4v7w2MeurnrYolQG8Fdh0M15Q6EMUCRWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407272; c=relaxed/simple;
	bh=Wm0DrMK9ryvIxm+jfpu4Jt5wGs9naKHdlhF3cMI+q20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJEoNsf0jHJtpMKTU0Sg08UtEmE2Cgng21SKAeUU2p0/QkWwGzqFXfu6nFpuZaDxOKjG/cb3/iAB0bOKLZJk5XQaViJvi8qYtNGIaSWxfpAn7pp5XynjRwB7Gz5Nnf+7tj5qtVtahtQCeHsULnSpVen7sI9hU35XBDDstf+2v5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NHqpNcCI; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NHqpNcCI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1791407268;
	bh=Wm0DrMK9ryvIxm+jfpu4Jt5wGs9naKHdlhF3cMI+q20=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NHqpNcCIb8SwCdDhLxmMb6BxWjBKwP9yN2hG1NH6PCr8pp/R1libkhvLBa6SuBvg6
	 ReIU0bSqnZXUbBvVHDvuow57CNM/2IBpBTSTaiCrWanFLj7rKpAM1Rse9WSwcSKCm/
	 8xFjzhD5QjezFYo0BO299XNR+jblN+a58KUEQM+pEacWerq217igZaZ8oCN+qeVGGf
	 JpO3fECPsSASTNWGwYrfFzGowYySObHqUVwN/b7eM99n3Vpgu/5BYxrtzZMXtQ3E7s
	 PW89bdSZrWZte4uTRRx98Ufbucg7v39Ai/ONMxd1CIzqy0ib4cibZz73fB1b6Ms/xt
	 S3SJjeDP83lOvXwD1DiwCIrfN80hI4zdu2XxlP7XWUu+MopYixX8eK6UPzKfBTdl+Z
	 SrwfSWBiNABezOVKlgkHZgKuwUNqdT7woARVtoS1+tKtgyrDD4mkvgHXC8Unp5J2tv
	 VzyrCBlHTkqfERo+lu/66RdbCg7W/+MemCp6336tkN9f75kd1MP
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:66aa:1c10:d66e:dab7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 92D5D20077;
	Wed,  7 Oct 2026 21:07:48 +0000 (UTC)
Date: Wed, 7 Oct 2026 21:07:47 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [RFC PATCH 0/4] sign a SHA-256 digest of the tree in commits and
 tags
Message-ID: <asa0e64qw7gzhI23@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Christian Couder <christian.couder@gmail.com>,
	Scott Chacon <scott@gitbutler.net>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
References: <20261002081846.25144-1-scott@gitbutler.net>
 <asAAn8NZwB29WhGR@fruit.crustytoothpaste.net>
 <CAP8UFD096CdR9MXd+VHk7Zf9rCJEnGTEiBhCc0mJdMmE3U_gOg@mail.gmail.com>
 <asV1oB_avuEbgRVe@fruit.crustytoothpaste.net>
 <CAP8UFD3dnx3u6LL78pPSzreaTsSmoiJvofoR_R0Pyk7H6-8NXw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FoPJjEml4IqOTTpB"
Content-Disposition: inline
In-Reply-To: <CAP8UFD3dnx3u6LL78pPSzreaTsSmoiJvofoR_R0Pyk7H6-8NXw@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--FoPJjEml4IqOTTpB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-07 at 12:26:39, Christian Couder wrote:
> I am willing to help, but it's not likely I will have a lot of time to
> work on it before the end of next month. Anyway let me see if I can
> upstream some parts of the `sha256-interop-part-2` series this week or
> next week...

I appreciate any assistance possible.  Getting that series upstream
unblocks a lot of stuff because then we'll have pack index v3 and object
map support.  That will allow a lot of work to progress in parallel.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--FoPJjEml4IqOTTpB
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrGtHsJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ270GPy8fzRnOzFXgfE2kmDLROgNj0C1pJFAgpeesdVp
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAHoHAQDGHhUWRd+PEsA/sxhA618g3Av4
1HlJ1WyVGyGonYJ+ngD9HigP+i6cjv9Px2JnflCVHiuHHMbn/3WAGrtnhbAbFgg=
=s58B
-----END PGP SIGNATURE-----

--FoPJjEml4IqOTTpB--
