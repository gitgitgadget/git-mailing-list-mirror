Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="fsAlUZkP";
	dkim=permerror (0-bit key) header.d=archlinux.org header.i=@archlinux.org header.b="EbLsdxek"
Received: from mail.archlinux.org (mail.archlinux.org [95.216.189.61])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79607270F
	for <git@vger.kernel.org>; Wed, 22 Nov 2023 01:50:51 -0800 (PST)
Message-ID: <ccbab7a73f734b09fb6915ab30506eb2c0db2321.camel@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-rsa; t=1700646645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fuyaBIJLocwLZadHHidqqKDw9mqltQyzVl80ZyK8TH0=;
	b=fsAlUZkPhJgyWhVSt8BMo8uuVITATLBK2kDzA3C8BmIM16CC4eJBvuOoq39V5e1cjSJCxe
	qWv06fOfF9osz1c6EzCspTHQ7j5mf19BdEwT4xFYsZEJKv4bEjlL9J5JjDf5ZfNFoA7g/Z
	84Yf1wSpvIPQfjAyh0H2AmIPLXbAE72EgC8Nvj+/eX6uUnM5Ok67sKxCXQX0lnh/PeVJGL
	7Jgkhd0R9j7GAdXoR5UANAEs6TFR+83HwUqzD/3ZW5YvSsUDdoRQIBqCXpes5ftcVzIlNX
	/2QXc8pkWE/mJ2Y6oisRz058JoHHzdWxzd5f8MdSDjuW8v0a2z1DSVG1xLOlSpxi6bd9bR
	D5LENg22pJnXEGPp7AIygaMC+/ta/AXpsvcsOubeKOsRmv9LvMWBUNuGCm858GhpJYoffa
	sFv6XdAPOeG5MxUtciNEeNBZ7l2/JCvZODRA7JcSeTgp/+egdy0WzwNIVJ5525Hhalu4Q0
	LMa0AsJGmC213Z4OtR9r7MnQ6ucxczmPwiYe9eeeNjj/oxkSPlxwoiiKZisgdVqbCguxIP
	U02ejYcgDT8TfRpDRtgqSbTjBJVe6BHllc2VDsulNBLiLA58VuirEjgB6e2s2kdAhgziiv
	zdR0W8hHooKM67CLjzUPwHNhVVHq2/9GwCrLikVlKnSxh5Rf45jdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
	s=dkim-ed25519; t=1700646645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fuyaBIJLocwLZadHHidqqKDw9mqltQyzVl80ZyK8TH0=;
	b=EbLsdxek/5xJonIKMse9nQHiLV2u5Is5sC8XdGVMJWHT/ykHySOGjRyUY+8F98Lah/zlg+
	gJS9caA4RfqBzfDQ==
Authentication-Results: mail.archlinux.org;
	auth=pass smtp.auth=heftig smtp.mailfrom=heftig@archlinux.org
Subject: Re: [PATCH v2 1/6] submodule--helper: use submodule_from_path in
 set-{url,branch}
From: "Jan Alexander Steffens (heftig)" <heftig@archlinux.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Shourya Shukla <shouryashukla.oo@gmail.com>, 
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason
	 <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>
Date: Wed, 22 Nov 2023 10:50:44 +0100
In-Reply-To: <xmqq4jhedxza.fsf@gitster.g>
References: <20231003185047.2697995-1-heftig@archlinux.org>
	 <20231121203413.176414-1-heftig@archlinux.org> <xmqq4jhedxza.fsf@gitster.g>
Autocrypt: addr=heftig@archlinux.org; prefer-encrypt=mutual;
 keydata=mDMEXrlG5RYJKwYBBAHaRw8BAQdAUHS8Z8nv7Qpds2idiabXgBePjduNTS6FDPew5ioWVzu0OEphbiBBbGV4YW5kZXIgU3RlZmZlbnMgKGhlZnRpZykgPGphbi5zdGVmZmVuc0BnbWFpbC5jb20+iJMEExYIADsFCwkIBwIGFQoJCAsCBBYCAwECHgECF4ACGQEWIQSi/zo2qqVmVBCQZKsZgC+LDXD8MAUCXsft+AIbAwAKCRAZgC+LDXD8MGBcAQDNyC78jjQIB06d3XoRLeZtNzCauYl5H7eb/7NwV0G1qwD/fu6vWzI8o08S4XenjFhLUFsiwQ4nSk00JdFrySXRHgq0PEphbiBBbGV4YW5kZXIgU3RlZmZlbnMgKGhlZnRpZykgPGphbi5zdGVmZmVuc0BsdG5nbG9iYWwuY29tPoiQBBMWCAA4FiEEov86NqqlZlQQkGSrGYAviw1w/DAFAl65R0ACGwMFCwkIBwIGFQoJCAsCBBYCAwECHgECF4AACgkQGYAviw1w/DBHTAD+PNwiUfbLSXEAJJpHArw5CT2sP7k1Yy6X2yK+R4dJkHUBALF5qQlbVfiPskk09bmNrN6VRpxFkXF/NOF5mElKMd4AtDZKYW4gQWxleGFuZGVyIFN0ZWZmZW5zIChoZWZ0aWcpIDxoZWZ0aWdAYXJjaGxpbnV4Lm9yZz6IkAQTFggAOBYhBKL/OjaqpWZUEJBkqxmAL4sNcPwwBQJeuU1kAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEBmAL4sNcPwwSmYBAIV4TJmJUd2H8CB1/v6hBqfzcvdoACsJfCYFEa0SMSbrAP9bGMNzxlCazbIcQPRf9z++Lwum5oyXqM39bqaHnCQNCbg4BF65RuUSCisGAQQBl1UBBQEBB0AFn0QAtcl65oxMplZAtuBin8mNWVkNhDbkb6Gz7boNWgMBCAeIeAQYFggAIBYhBKL/O
	jaqpWZUEJBkqxmAL4sNcPwwBQJeuUblAhsMAAoJEBmAL4sNcPwwTmMA/0NYZUauON3mKQjuu1utN5kIUBYEbxoZpKoYQBIjoV+YAP9QcYa9ZqKZqJeIkJWu+DgKUPQj95p44B1nEVE2nAAfC7gzBF65R2QWCSsGAQQB2kcPAQEHQOo6khBqHiXAVPR5NBrKeCtHnb7zYYJmHxkCFhwbtcWviO8EGBYIACAWIQSi/zo2qqVmVBCQZKsZgC+LDXD8MAUCXrlHZAIbAgCBCRAZgC+LDXD8MHYgBBkWCAAdFiEEBmh6HZ1Pqwi1D9krO5SoDlCkd8cFAl65R2QACgkQO5SoDlCkd8cRdgEAk8M0dFfq8/YcSw4/nFHV/r9du86prBK3gkvcLduib3IA/jm1ENsH8ev0HB/p2PLwgq4kE8c8q8m7tagFesm2zpIHCIABAACxhRpz6oWlGFjhbOQ2+oNvn2z0l6RLCC6sobTR8LArAP9tuByp1H6Ta1fUhD8WZFYap3nu8GIQZW3iWVrVO8WhB7gzBF65TnYWCSsGAQQB2kcPAQEHQGNbRKSVPySqXMjiyxYXhhusHw7a1pokxZ2paLiEQ7ExiHgEGBYIACAWIQSi/zo2qqVmVBCQZKsZgC+LDXD8MAUCXrlOdgIbIAAKCRAZgC+LDXD8MAG7AP9AHkNtsZ50M2v9AtcWXPPo1xV7DHZhJqyaeXpV5BwmPAD/Qibc9XxPawrOYbSVLG0qZ/Yvw8Kpv1PAbduah+k3ywI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2023-11-22 at 16:54 +0900, Junio C Hamano wrote:
> "Jan Alexander Steffens (heftig)" <heftig@archlinux.org> writes:
>=20
> > Notes:
> > =C2=A0=C2=A0=C2=A0 v2 changes:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - fixed code style
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - replaced potentially unsaf=
e use of `sub->path` with
> > `path`
>=20
> Hasn't the previous iteration of this topic long been merged to not
> just 'next' but to 'master' and appears in a released version of Git?
>=20
> We are all human, so mistakes are inevitable, but if we discover a
> mistake that needs fixing after a topic hits 'next', we take it as a
> sign that the particular mistake was easy to make and hard to spot,
> and the fix for it deserves its own explanation.=C2=A0 Please make an
> incremental update on top of what has already been merged with a
> good explanation (explain why sub->path is "potentially unsafe" and
> why using path is better, for example).
>=20
> Thanks.

So it has. I'm sorry. I was only keeping track of the 'maint' branch.
