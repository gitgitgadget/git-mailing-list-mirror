Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8017B212D7C
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 03:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750909512; cv=none; b=AkSR8Ge0P1s0b9Q+fgQsQDYhNmNKcO7e0Tx99w0pJQU9QwtILMMzC2bxxEwDIfnJDhIsXhNIvokoBmuNDVCMWvEZAGU/41cFwE8oFpY4x3CFu+jaP8Kt5k+yyaA3ey38OiUyStP83SwV14h6g/iEVI0rHi3dGgLWEh2h8JkzW0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750909512; c=relaxed/simple;
	bh=12ry0UOKciGq4/Sn0fc76u/3mrCfcDzuPkTOLL4UutM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=MHH4X5dLtJ5agybVElLOSWoCypECorYcczGCkUSamPLEhlTaORCEz34YnKg+s/4gs9zmNzyR1zFpwyLdiQEAs8mXIL5zDQFsztVybrsmXFqCd5VEEKkYb0aabZ/305Z6hU1T9wAq74jnfezN6Knw1+3qen9zxHre+NLbReeboC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
X-QQ-mid: zesmtpgz6t1750909492t50ea632c
X-QQ-Originating-IP: RY4nRq648ZhVIjDQnpf+E9ZzQWkg849lyLA23ab1NOA=
Received: from smtpclient.apple ( [36.152.24.138])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Jun 2025 11:44:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11652212966516777754
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 1/2] bloom: replace struct bloom_key * with struct
 bloom_keyvec
From: Lidong Yan <502024330056@smail.nju.edu.cn>
In-Reply-To: <xmqqtt43u36t.fsf@gitster.g>
Date: Thu, 26 Jun 2025 11:44:40 +0800
Cc: git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4E0C5F0C-16BA-4B7B-BC5B-632CFEA871E3@smail.nju.edu.cn>
References: <20250625125541.3048632-1-502024330056@smail.nju.edu.cn>
 <20250625125541.3048632-2-502024330056@smail.nju.edu.cn>
 <xmqqtt43u36t.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NXTls5eEgiGl9nTIEwwcfEwSxixbL523QBA5S/XOGwYxa/iyqGLjNdVA
	ZQpbLmS4Y2+XGgfgjj+TrZaTrBG7mGseD5/ZwFdZcvgWMX7ELYth4nCKsgNtTvpMvTmrpJu
	HkqqFSEqTMdMVirvgqKgXfRV9lkBgUUMkRi92brTu2W3b9lMfUhqwD0DKUOqp8PGJQRa/gZ
	tLOHiO9vB1JNP8hr5gGpw+aGnZsW4C9vYCyr7CsHkzzdNd2p9BeO9fTaWVtlJY8N+MMtwKQ
	/kDMG+V73oAVwGchhsgSH/URbahIzIKwI/gRGQ3UOk+OV5JZabJoSSaqqPe3Iowp5j2mguS
	M0xo2ypnXQ8m2vVicJYW7pEwhvj6QaI85XvidrhauWEB7uLEKLqtN1HfXXa2PSximnFDddL
	AYxUpwZP87SYcUwjmsoR2CbO5tNbqundKzurc4oiWdSOMpnflpOlIakpLYN8yXdo2psVIpt
	MNA8myPbzJ+XDnoOCVPZGYkHbDg2M/GU2b+jYACuAB8NBxcHtFLlkB0O0sGmitqtM5zDUUA
	D1icz0F2Vue608BP2QVAE5rEc0qMMyHuCoWX27mXZ6O6QNSCPf8w3BRBRuuI5fp6F4qCqqW
	qtO2U1TDGtYXoc5rciauZf1+IMG8AnNzntUHAQTW/D0ZJ086XB9YwPPe/UpdIjgqiH37pwR
	hPw08EXmt0KhAL5pHWxpXvy2XAeKyTn4JOG3MdOP03egHpKvh7wIHwhZ+my0YoDmIm5DaSp
	0sEtw/s+6SelNjiS1mfaNQM0iWH/WrJYfiR18wXeMX6OFsfgkqq/C+gC/uhkjR3ktP4/ADh
	cbDqB3jsgx9uBskQQhCPtG+ojgJQkzinTDE13I7i+NSYMdMRsRJLmnw0Fh4QGaIip23sX3g
	EDCaHO39o98YbspUkoV//7QX8Ed9lDCusCkkv3ndnwUXST1YWqZbo3FA3Y/kFJOMYtDn/Hx
	W2TEEF3QN5J1us3m+peHigw93XPJzrpyjL3rKh1/mhtiZpuIwfnr9nCdXQVZsEE+jWmg=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Junio C Hamano <gitster@pobox.com> writes
>=20
> Lidong Yan <yldhome2d2@gmail.com> writes:
>=20
>> +void bloom_keyvec_init(struct bloom_keyvec *v, size_t initial_size)
>> +{
>> + ALLOC_ARRAY(v->keys, initial_size);
>> + v->nr =3D initial_size;
>> +}
>=20
> Hmph, does this ever grow once initialized?  When I outlined the
> solution in the earlier discussion, I was wondering a structure that
> looks more like
>=20
> struct bloom_keyvec {
> size_t count;
> struct bloom_key key[FLEX_ARRAY];
> };

I understand. If we don't need to resize the array dynamically, we =
should
allocate the array elements and the array length together to gain =
benefits
such as spatial locality.

> Also when your primary use of an array is to use one element at a
> time (as opposed to the entire array as a single "collection"), name
> it singular, so that key[4] is more naturally understood as "4-th
> key", not keys[4].

Got it.

>=20
>> +void bloom_keyvec_clear(struct bloom_keyvec *v)
>> +{
>> + size_t i;
>> + if (!v->keys)
>> + return;
>> +
>> + for (i =3D 0; i < v->nr; i++)
>> + clear_bloom_key(&v->keys[i]);
>=20
> By doing
>=20
> for (size_t nr; nr < v->nr; nr++)
>=20
> you can
>=20
> - lose the separate local variable definition at the beginning;
> - avoid confusing "i", which hints to be an "int", to be of type =
"size_t"
> - limit the scope of "nr" a bit tigher.

Got it.

>=20
> If you make keyvec an fixed flex-array, the below would become
> unnecessary (and the check for NULL-ness of .keys[] array).
>=20
>> +
>> + FREE_AND_NULL(v->keys);
>> + v->nr =3D 0;
>> +}

Another benefit to use flex-array.

>=20
>> +struct bloom_key *bloom_keyvec_at(const struct bloom_keyvec *v, =
size_t i)
>> +{
>=20
> Ditto about abusing the name 'i'.
>=20
>> + return ret;
>> + }
>> +
>> + return 1;
>> +}
>> \ No newline at end of file
>=20
> Tell your editor to be more careful, perhaps?

Seems git clang-format doesn=E2=80=99t add newline for me, I will try
.editconfig next time.

Thanks,
Lidong

