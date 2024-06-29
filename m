Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261EA36D
	for <git@vger.kernel.org>; Sat, 29 Jun 2024 00:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719620641; cv=none; b=ag9PUM09cGgNSLnDhVPtE9/nQzNfmoRByOq+T4Qd6pCecik1O5bHyLEe7InIaeMvwUKQRpDPf9zPtZavVxo0dZERK6RunpTCPXdP4OPcpeFLQtHYjSIFH53GiRUcg1NpdmO7v0jNkmlxcE3ke/I9JKdO+Y7FqZsUNpNhclp2zQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719620641; c=relaxed/simple;
	bh=jq9nXzxeCkvxB8Ob+Dmha3eM5c3jNxV91Wr2jry8zcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmmexU4s1I9KVWnOmHCKtTAP0eY8AjxRyfmDN2CzqtHtJA3frNdzg+Cz7bkWfr1PbGnBioEU4qMdwDpQC/H0f51sSMMfMFIHwVtxp8HJFLyy7LUIrZXLNf+fxIufrUecpkzaqEwmrk/ZJFupa8g1GVWkQdDS37suZdN9p7g9Ktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yiFvzTGp; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yiFvzTGp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1719620637;
	bh=jq9nXzxeCkvxB8Ob+Dmha3eM5c3jNxV91Wr2jry8zcU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yiFvzTGpJ5Q9GAh0HfzgzyJ8cD/1hcpcZu7ElhkN8OW/P4QtBgD8nj2HuDAmesZZR
	 rsfsROtjSs0CMB1vhMykMi03Mrm/LC85ZOdu+PFagCPZtTCJHIFsQrzuRS6FJOlIVE
	 qFMipNwWWcFQTkn3XQbkS74pY+JB8jZ3fZTP7krEZey2KCzCq548w4See7aYjrLawB
	 t+xWhxzh6yGVITH+6SOQdpYTtbygPZqsg2N5TA+FuUin9wjg1tanjBmKF8RD0hrqhE
	 qP05ff5RR70ucNadxEXGi4NHhJh7m8bjx7hQ3m/UzcKK9P1seMyl/kqdVjxX5JUthn
	 CpyuTgwuVeNaGG5hY+BfUc33/1iU1AJmO0jnLe2Rmbj1ocT9KDvWWRxRucEsy/8Teu
	 wUs0vP/SPVdjXau5SYHeNG0+3BtT1koyEMSlD6Yjfir7pf+2kzBmsC/sxEM+OtDtm3
	 iOVmxgSgj3SfNw0bqLAxpmsixuT5+qIDGWMWBKLu1r950foIGTC
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D35542638C;
	Sat, 29 Jun 2024 00:23:57 +0000 (UTC)
Date: Sat, 29 Jun 2024 00:23:55 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/1] http: allow authenticating proactively
Message-ID: <Zn9UGwMQ4Ur-peI6@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20240628002742.3421311-1-sandals@crustytoothpaste.net>
 <20240628002742.3421311-2-sandals@crustytoothpaste.net>
 <xmqqa5j53pbo.fsf@gitster.g>
 <Zn8yhdN6henrIqgD@tapette.crustytoothpaste.net>
 <xmqqh6dc1zk2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tqo0BSpQcHNn7cos"
Content-Disposition: inline
In-Reply-To: <xmqqh6dc1zk2.fsf@gitster.g>
User-Agent: Mutt/2.2.12 (2023-09-09)


--tqo0BSpQcHNn7cos
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-06-28 at 22:18:37, Junio C Hamano wrote:
> Well, at least I couldn't read the proposed document update and read
> that much out of it, and I suspect there may be other readers who
> will share my confusion.  I think the source of the confusion is
> that "don't request" does not automatically imply "allow the helper
> to pick any scheme as it sees fit" if you do not know how helper is
> designed to behave when it is not requested "any scheme".
>=20
>     `basic` - Request Basic authentication from the helper.
>     `auto`  - Ask the helper to pick an appropriate scheme.
>     `none`  - Disable proactive authentication.
>=20
> or something, perhaps?

That sounds good.  I appreciate you providing some language that would
be less confusing to you, because it will probably be less confusing to
others as well.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--tqo0BSpQcHNn7cos
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZn9UGwAKCRB8DEliiIei
gTc5AP4mXl/zvNeFiJzJDcHwjLRz5gaM4xnB3aa/YQbsh26feAEAyEMryzkRkH12
L4obIln6T+g9cmvIqOLhVwUMUy1RDQI=
=CxSc
-----END PGP SIGNATURE-----

--tqo0BSpQcHNn7cos--
