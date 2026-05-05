Received: from smtp-good-out-3.t-2.net (smtp-good-out-3.t-2.net [93.103.246.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F080237B014
	for <git@vger.kernel.org>; Tue,  5 May 2026 21:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.103.246.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778016420; cv=none; b=MHxU4BKlzXeyToX4UXP8yh9G//3Vp0Cy21WCh0WeGukEzpo3gMtO7fgvBP56VGyC1kGCI8lzLY4XDQDmXtlS+WMzAB1it3IGEmMgWqq+tOvCWnpvEotrdP5Yp2DFLT66jjzGF2Xv7VXPwatQGfdjauFzzF8GvVNM29tXrdyZINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778016420; c=relaxed/simple;
	bh=Ornm42SZlucXWwtuKXzB5FQ6k6VwfxEY0RZV69DKpDs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LDCloCdGqIYadoUbQSJi2H9ETsd7PImrcd4s8DEa2lsMBn4Jfkvj/qQN8wg+/N5dtwwakglMXnHeR/FOMy+boX2ldMWmOthWz3mhgZq0beej4Is4A6nNzeAZG83uuqumt96sk9IcghUCNsu57I2fDl1YfGk5aiqyulbj9qX0gxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net; spf=pass smtp.mailfrom=t-2.net; dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b=KbIwc5uv; arc=none smtp.client-ip=93.103.246.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-2.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-2.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-2.net header.i=@t-2.net header.b="KbIwc5uv"
Received: from smtp-2.t-2.si (smtp-2.t-2.si [IPv6:2a01:260:1:4::1f])
	by smtp-good-out-3.t-2.net (Postfix) with ESMTP id 4g9BRK4dt2z9vDRq;
	Tue,  5 May 2026 23:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-2.net;
	s=smtp-out-2; t=1778016413;
	bh=Ornm42SZlucXWwtuKXzB5FQ6k6VwfxEY0RZV69DKpDs=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=KbIwc5uvFynLL7ER9CzwA9P9ir0AG0d6/WeN0HDEnF6+3wiWGY3IbzudbQydQYjDd
	 qrJYAAwnhdnucIxjmp/hugYRVCQnRijdPCNYR4x8pM6t1xm42Fs/ZQjqhqQ4+6GkOh
	 kFgLBb+I1Ew6253psGLoNMThDjDDWnfs02IoOjwA=
X-Virus-Scanned: amavis at mail.t-2.net
Received: from hpfur15.u2up.net (89-212-91-172.static.t-2.net [89.212.91.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: samo_pogacnik@t-2.net)
	by smtp-2.t-2.si (Postfix) with ESMTPSA id 4g9BR90psyzMrVw4;
	Tue,  5 May 2026 23:26:44 +0200 (CEST)
Message-ID: <b8cbdc24c871d96c85da590853a036263b90f92f.camel@t-2.net>
Subject: Re: [Bug] fetch --deepen truncates history in v2.54.0
From: Samo =?UTF-8?Q?Poga=C4=8Dnik?= <samo_pogacnik@t-2.net>
To: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>, Owen Stephens
	 <owen@owenstephens.co.uk>, git@vger.kernel.org
Date: Tue, 05 May 2026 23:26:39 +0200
In-Reply-To: <e8257951-4ea7-40ba-8043-f4f2a080b70b@web.de>
References: 
	<CANOh7gEEw+6146NN3JV8EYxQarj0KkyA7r3RZ6v-DxeqQZLrCA@mail.gmail.com>
	 <a5fd970d-fd78-41bc-98f8-a6a87a7f39cc@web.de>
	 <e39f6770-fcc4-49a2-b3ba-5ac2ec9e047b@web.de>
	 <2afd4a28a9a542f8baeab488cb0801d6b98adb0a.camel@t-2.net>
	 <e8257951-4ea7-40ba-8043-f4f2a080b70b@web.de>
Autocrypt: addr=samo_pogacnik@t-2.net; prefer-encrypt=mutual;
 keydata=mQINBFwCXogBEAC4B5dfY/m82d0d5VBtFeVAjtUrOOdrLgbYJZFUXsX9pya5x0QdYeTP4
 afUZ73e7zMe0ozH8UMz6iv1niPfPkMorUzNcALDcotZ8Vvf3bMdndV7lHk8jScAMoW2L7VHGn1N+H
 8yJ5WufqF/yNBLqmVqaLqNjHejZN+Ld+/4AaJ/gQzWVqYH6EaJZd/LSqppJWGOHGGURFakFSDp3Bi
 6n8SOQmarOt6mGX5wsiHNwa8NtNX1cEJPT8YCQUR7o5fTHb3AEemLRFJoGjeH2RjzPloyTlwSjLXd
 Egph2uUGqiBKD1dREfIuIWtFAJF+iMRHhIEJSF4hvUYrYAV+7ZTlIo3NnDLIeNn40Qmn++9Uh8FbL
 YdFb14dyBkw8MBBQPQNCCpBflK7aaSFWpHv6nk/Z7fGrkwrD51CHsDut8PGQMtmSYMoSCWRI1wChn
 peoZn4Cq3yG1rj90IVv/rxmvL3oMQfE2oSMAhpyRPi0vK68cG4ILpO65Aulr0wr4JFdZBNmpf8BCF
 4jqpN1HsQJCYUYBMeMeOMkH9Gz3DBWuszvjjs7wmesMkEz5C92UlK6FWGUz6Ioi2bfRGOzx0+AjpZ
 rUaSIQ+5MCPxjWkxl3EQQFL2U3ItxxpaDO46AoRFj4oKKeHoteiwpziY8whIFmDXWfy7nDfp76RiS
 riLtyZiFEuzLwARAQABtCZTYW1vIFBvZ2HEjW5payA8c2Ftb19wb2dhY25pa0B0LTIubmV0PokCTg
 QTAQoAOBYhBNCCwgeDpWpcp2HPBvAkWUZaOuMIBQJcAl6IAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4
 BAheAAAoJEPAkWUZaOuMIKE8QAJ04bxv8nXpY3Tp5nWOIOsBmEHWvVEIdD2kxjC9YCQeKx4gJLADa
 RcuXhFbwi0NQtuSRf1G11ZGqxBM/YHvSd4Rtqbag4P9UY/ZdvMAe1zW4HTO9c2mtoWN3WYxS/gkX+
 wBLVIy+eqrsG5peJmRlq3fTbCxLprgqp6B2IUcTEBa8Iynv7B/1qsG2rd0y8pY+ZHIUtz2ZJHoYz2
 Lx091uYwy9aozibWRot+vZNx4QipOmsoZOm+e5FvTf4yvmFYJ3iR8fUfq9gpCokRNtPG5NvqNLApk
 EwEAlaXH7flAUwF/uRBUASZeyEeKGRtXOUYeGXFyOgykbmIs9IXDms8OLj/TZlSzECeoSX25I0P8M
 QrMb7GChMME4W9i9+ZZc8VWPyYW8W6dyNfBb05lu0XMB62oiYim7cOXiDV49EBYtiXIwUnbfQYVSA
 U8MTvZKS4ek2KGc9OJNLnm8dP2u31jvMUts7AEoU3vxwv8tUBEm4Zpzv8+HvzpAGAnbGc/kiLClaH
 j8E5d/3XIyq0TXlZf7B5Fq+lwa3gXMiLWko7m3PfOFtvbsSWPxplka6r2T2GMt9e51sctckfd7V/F
 unQvSwML0gpE6YicA/OcoFFOwoipilJ4D0YcqLgO8FNQdXukJciq0xeeBWY4t8Oo5M88J4YzAKMr9
 PU/BhjCBDTyCb2b1
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-XQXIlIjpqA1g7EhmtkPV"
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-XQXIlIjpqA1g7EhmtkPV
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2026-05-05 at 22:34 +0200, Ren=C3=A9 Scharfe wrote:
> On 5/5/26 9:27 PM, Samo Poga=C4=8Dnik wrote:
> >=20
> > Hi, thanks for pointing out this edge case. Would you care to check the
> > following change (the provided test is also a bit modified):
>=20
> There's spurious wrapping in the patch, but the changes look good to me.
>=20
> Care to send them with a commit message and sign-off?
>=20
I will, but it may take a while.

thanks, Samo

--=-XQXIlIjpqA1g7EhmtkPV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE0ILCB4OlalynYc8G8CRZRlo64wgFAmn6YI8ACgkQ8CRZRlo6
4wgjTRAAifwXo2Y+/07wj/yQq5VIw1jQHMNRdeFN0Uxi698clr5HnzKGblb8CF3r
YpktXVbAdx0vSbJV4KVNn1Rk4gfA2/fd35ZY1oGe8sqC5ciaoYe09RzKYMYURnGJ
mlPVycyxD1qyvDMDBpWsLb7GPfZDUTZT4OVEsAu74zxxd7yt2yBOQ4px+IaUaBIV
22Gp/7JRF1rNGRwoi/ZGq4OE8rji+JmOmjW1LFAJqZfUs+h4/h8INf0o3Clw/9CX
S4aUGKQCge9F1H27vLOKrKZ/1ckhSR8cZTTmp0CizJLUsKew+kJl6lQTHrDQyZoA
pfFi83YKowiO/dmjzGIwtZmzy7C4fzXrf64Zkbn16E2x9Qf2U13N1C4/M+rzX3+5
RymcpT04Xaurm39NWllfwOR6KFOogfuNH8eYAyUWZkThyFe/+pKwf5UlLrvuhBPq
bPNIAzpe4N1gchwk23OfVpOCaAMr3jIPHYB7c0WQy3M7K83yQJ0HJ/1QAQfdBKaz
WaqFkJGpRYyiPrJsXea5WflFUKqE4v/fpC1H+2qgOBcF3PaXVbh8hyG+Gp7YVMNO
6B0QRHnrYArfZGiJbueFtWCB1dykV3irbZ20YmAX4qaNDeK6olorV7izaizAff4L
CpUCflsusgTz4rUR+2ezikCD+KT5gZ+XwAWU6jEdHG7AQ1Kvj/I=
=QQAZ
-----END PGP SIGNATURE-----

--=-XQXIlIjpqA1g7EhmtkPV--
