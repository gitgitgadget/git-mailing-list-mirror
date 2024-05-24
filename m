Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D365F1EEE9
	for <git@vger.kernel.org>; Fri, 24 May 2024 13:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716557437; cv=none; b=XiD4UKcLCHdFaxYGd3zhJWHByhbGstLhucfliIB+AJHtQeg/Zb5zej2PXz6jtdPjkEjWDAloibmcozX1F9lB75p5CJB2L+OVhm3V1vKYr5z4Olj23aC2ktDFItztxG96lpld9Z0fwPunDUFfBNu9D4p1h3rKQlZL3fTGbqe4sfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716557437; c=relaxed/simple;
	bh=dmhaq6YItF5afzSkrql140P4RFyrvL+NK/MlOdVdtBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PT0KFv0vaNk097jpUwqDSCk0m2bKnVHPCrgHbrVxrMu1yVFwttIG8aFnuj8omG3mFoTgT/QUWMU/uATzdnCMsOQAlU7PsVuAGx+vxkSKib1aGpILb6oH/i2eMSjGhgdpcsKBL/vq2BQAvijSlC0eUjc0UIijDVFMeh34UrnDfZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mlKHcumu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SqVRx1Mv; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mlKHcumu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SqVRx1Mv"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id C367C13800F5;
	Fri, 24 May 2024 09:30:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 24 May 2024 09:30:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716557433; x=1716643833; bh=AibssA3a6/
	QiLJGVO05BEsymy8y7VNSMCj+Flqg/g9I=; b=mlKHcumuQHOpxwndk0ygeUdVr/
	k5CTTVtXUXg7QrxoVz0iTxmY8StHtOrfDrcsg4xZEbfNUfLPumOwzG3ZLLzC1wOK
	bzmuVKt+X9x3ouaVfP/V5qhVemtcRDHHla9tYbm/uZOaTX8PmuIHe9fc+Jots7br
	lxRy2/oT0zeZeusgdD78Vxz+4brtvJV7jv7VWdZRsaKpYWBzjFvH7u/9V7gadn5Q
	r81EtDJUXae165it77gH+FwxfEKAZ+lGCFmiIPPArsY6shgLqLhMoiw++RzhCvwe
	rF5/bpJYxQvXSlyLuqFMtWb2CteftlZcJOP+S9dmx9J+qgnCcuUNEB6kqdiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716557433; x=1716643833; bh=AibssA3a6/QiLJGVO05BEsymy8y7
	VNSMCj+Flqg/g9I=; b=SqVRx1MvoNu6xJVBDiBatWbxdP4RM68/WWfYsTlzGNa+
	CR0dZNxrx2BrI+RFWGM86NDtkmyUepchKAvmBtGS2imcJ9dyAmFYF0lhhAt9VDti
	pU9GdsmhmUW4tK4bURzxZOOf/XlY7BXw1MNrAHz/lKogwhgh/LjM+qZGJnf1k69e
	pc+6G+IZkrtBdUA5FgxncpT8M2GMDb2h0n73LCwhbgjeS366KAxdyZM//PVy2zWH
	ZG/kIzNQOR7IupmA4DThIjFcnel/nnZaOnGRntEm/qgmd75IGAkBX/eHtyY4N4Io
	8hKssPcOZNAQQPjp2+7ELzIUY4iFUJRxRJJebecZ7Q==
X-ME-Sender: <xms:eZZQZocptKghgW_3fNTZ1u22bRkqeZptnWr2uKDP2TYzGpQGW9HHUw>
    <xme:eZZQZqMUb1TPoVJ1IsztTsxjnZ1dP2_v_Jdb6M3xk2L068W3V_SleGb-m5nLs8Yci
    Ycb9HzgvnWro1AdiA>
X-ME-Received: <xmr:eZZQZpiTehcvF-EKBQkMruUudVa8492RIrXOI7505jk0gJuRVdcDNu81XnXXCC0KgqtdHRBXUjhy0QkHskRlsYl45sIwdYXsmPKL-ycdHoy7tgE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeikedgiedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:eZZQZt_TzkTP66cDX6y_7pACNKPjr-X26bw0wK2Ikix5M_V-DuPebA>
    <xmx:eZZQZktUQg7oZ_jgbTRbZHtA3_QRX8FWdCTetdk0igQYhASUSHs0Xw>
    <xmx:eZZQZkHiA-qZlWDq_yiI-Z9SihT8k-0fIUdU7lH1YNiQ2VkdWHyz0g>
    <xmx:eZZQZjNNd4VIGs6oJxpCpOlh-8VyhGqogsFfKhky0cFO1Z1DyRHaCA>
    <xmx:eZZQZp8No7q6M6McYiQM0vD_jaWldTfS4y5A9Y1x0xpN_IelYfQEGtcx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 May 2024 09:30:31 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 19f79efe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 24 May 2024 13:30:26 +0000 (UTC)
Date: Fri, 24 May 2024 15:30:26 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: ach.lumap@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 2/3] t/: port helper/test-sha1.c to unit-tests/t-hash.c
Message-ID: <ZlCWcpcUkgUMWJYz@tanuki>
References: <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240523235945.26833-1-shyamthakkar001@gmail.com>
 <20240523235945.26833-3-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eTB+TFQO/csSAVXw"
Content-Disposition: inline
In-Reply-To: <20240523235945.26833-3-shyamthakkar001@gmail.com>


--eTB+TFQO/csSAVXw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 24, 2024 at 05:29:44AM +0530, Ghanshyam Thakkar wrote:
> t/helper/test-sha1 and t/t0015-hash.sh test the hash implementation of
> SHA-1 in Git with basic SHA-1 hash values. Migrate them to the new unit
> testing framework for better debugging and runtime performance.
>=20
> The sha1 subcommand from test-tool is still not removed because it is
> relied upon by t0013-sha1dc (which requires 'test-tool sha1' dying
> when it is used on a file created to contain the known sha1 attack)
> and pack_trailer():lib-pack.sh.

Can we refactor this test to stop doing that? E.g., would it work if we
used git-hash-object(1) to check that SHA1DC does its thing? Then we
could get rid of the helper altogether, as far as I understand.

> diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
> new file mode 100644
> index 0000000000..89dfea9cc1
> --- /dev/null
> +++ b/t/unit-tests/t-hash.c
> @@ -0,0 +1,54 @@
> +#include "test-lib.h"
> +#include "hash-ll.h"
> +#include "hex.h"
> +#include "strbuf.h"
> +
> +static void check_hash_data(const void *data, size_t data_length,
> +			    const char *expected, int algo)
> +{
> +	git_hash_ctx ctx;
> +	unsigned char hash[GIT_MAX_HEXSZ];
> +	const struct git_hash_algo *algop =3D &hash_algos[algo];
> +
> +	if (!check(!!data)) {

Is this double negation needed? Can't we just `if (!check(data))`?

> +		test_msg("Error: No data provided when expecting: %s", expected);

This error message is a bit atypical compared to the other callers of
this function. We could say something like "BUG: test has no data",
which would match something we have in "t/unit-tests/test-lib.c".

> +		return;
> +	}
> +
> +	algop->init_fn(&ctx);
> +	algop->update_fn(&ctx, data, data_length);
> +	algop->final_fn(hash, &ctx);
> +
> +	check_str(hash_to_hex_algop(hash, algop), expected);
> +}
> +
> +/* Works with a NUL terminated string. Doesn't work if it should contain=
 a NUL character. */
> +#define TEST_SHA1_STR(data, expected) \
> +	TEST(check_hash_data(data, strlen(data), expected, GIT_HASH_SHA1), \
> +	     "SHA1 (%s) works", #data)
> +
> +/* Only works with a literal string, useful when it contains a NUL chara=
cter. */
> +#define TEST_SHA1_LITERAL(literal, expected) \
> +	TEST(check_hash_data(literal, (sizeof(literal) - 1), expected, GIT_HASH=
_SHA1), \
> +	     "SHA1 (%s) works", #literal)
>=20

This macro also works for `TEST_SHA1_STR()`, right? Is there a
partiuclar reason why we don't unify them?

Patrick

--eTB+TFQO/csSAVXw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZQlnEACgkQVbJhu7ck
PpRQSxAAiGpP/8bHFiJoXpAS9P9fDoE48PNGhBuIV3TUQOrLUb1ABj6CT3bzwlsT
5Wb962WDzgFRUsyXzuefsijrE12F/R7tg4V8FrE5evDDpcOXmNLyHcAzTIdvYn5R
hnb+4ZFquoQNgLNFE6LO33mY79jli5NMR3pRoaBvfwj67OkarXoORkCcW7oZyHQo
s/2ksPluFkiAtRcIEsnS0wJb+fMOha/6xDLmfJ8a8tdFSDLHsHeFQ2xjM9KLCez7
ZrJfz+GtP9uNsKeMDYDzJFMtPLRXwsEF92dcoEBEEJHd6mf6vhD4216C/11EzDoK
Vmuvdd6kj3i9j0VXvop7DZ9m7AXY3ZEx725E7I/w6QZlsCCSvctuXSyGrX7vxOfN
Np8pCXsUvt7ghU6JZzgn9FSM9KQMLvDX6UatknRdpaPWY82Cg8ffSlhzsXn+i+W/
bBk2a6ZBV1MM8uIyvDyWT68yhw29G4InQCTOuASBq7KYjCoBSZxQEBCdC0994NAr
cwJpQQgOpZ9yjFE0XsiZgPEsRb3K+hPIViRHKM9I1vQyxvBclnJA4F4hPN5Oyid0
pmwqw2EAidAOXMS/TdkSrHd5YpQOzSrMZpKBAkgwd3yTzR8pqYYqcJjUY0hj4kRA
4rkw72yzptShGYRImC53nUlQgrshjfBbrxxkBcD/elyV/Fv0DTU=
=xWVu
-----END PGP SIGNATURE-----

--eTB+TFQO/csSAVXw--
