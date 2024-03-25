Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C22149006
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365753; cv=none; b=P7gucqC/uAqRGiudR6jAkG9/gzarLCfr1Y2UP6V0oQKz/sMFDaQqBoX32Xy8u00fsd70Zt7tJ7lSRcdQOkoy5cV/SwkTeGDQCQKGqcU9RncC7sKvj5DKBLNBv76GLL1SVCNa1CLSZp00Leg2rTofcfZJWVBCnL2cCBcJ20RSL14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365753; c=relaxed/simple;
	bh=ob0Gd7PByI/VUcToV1/YRjYnE1PuPmAiTpkIkbwHWPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OUPMszxu59irmYsQcAhWs5HXHBhZan+Yf0DPmiW7GX5TIZ4Njsv1qlthtAeXNvK/r6H9KwTBYu/hEnlZ7ksdtsX7gHLQz4WOkQXVHNjqBn+PcBJEcvG4h4RcD/N2AR3bj7mqTgJIK/fPCZhHU1vfGq4GNJg/iY0dV1GdXzax42w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=mp9fIT5m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gaseLXL6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="mp9fIT5m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gaseLXL6"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 571C011400D8;
	Mon, 25 Mar 2024 07:22:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Mon, 25 Mar 2024 07:22:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711365749; x=1711452149; bh=8Oiz0z0Ofn
	3WWAkQYlWFiDz9ZdgKO4b3CoDN8oZnxxk=; b=mp9fIT5m7as1Huh2d+qzsM01Pc
	MXku/QSjzeVyTd6F/9vSxcaLVnzdW9nQwJ5JN1shgCLvclEEx7GSqgSE+71H3aXH
	giWquk+Z2yPba5ZGioLdD16JV3Z5pJNyMfCfrvwfbzrL81qZcHYPU1G2YobHmUAz
	NYMHA1uaCybdJcfWE7kOGgTg/Ja8we2R6Vo7hUsgvTdFZxuIWiDTGE5i/BaU4aGo
	eRcOd9ylzzj/+jim70N6b7EfuNNcDmKlu2KI0I2IciXVZdhKOmHlfk4RfBqcJ/tE
	Zfd/H7ggcZRog5+H2vSCToaHdBOwe3Mxq9KJoPy2Pae8u3Vkespg4mPXihWg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711365749; x=1711452149; bh=8Oiz0z0Ofn3WWAkQYlWFiDz9ZdgK
	O4b3CoDN8oZnxxk=; b=gaseLXL6QixQo4hN3wQYTnXvbvU+UZHJQTtRLvUEiMdt
	utEInLM+a0tR9UWUpW+YEDd9YQSrChYFwjyuZpUsgnkIShX0Ktg7xcZIZgVQSYLt
	K7q9PtE8KVfKCNifIaDU68jOAJUI6RwSOMJCfIq0kgHZUnOmxntdGoIThhZPaX8n
	u3CyTTXIKP5yu1NJp+8m/4tCSXVO4iEZs86UBJc2jHkd0kfjeZb/c0Z1No+NAQ7j
	9/EcLU+cO3sJmLyYcKKIskiC36MqisZhggdVszLDxodrJSUx41sFld2LZseyk9te
	Y7AFwqgof5xRnoDlZNbnl1/WZcr2Z5mBr2LfBgGfrw==
X-ME-Sender: <xms:dV4BZhn-PktpOiLm29iTy55HEI5OystPC0HlwBVI8xoMh8b3YnQBAA>
    <xme:dV4BZs3CHteQZtVDlL_vXsFsPvGRZ_pNEDuQhhYZtwDJLsocv_9PaPkExAhlN92Vp
    0SjzGwyWFvs-S-CPw>
X-ME-Received: <xmr:dV4BZnp3eY0Cu4zerGtZZn2kdfG2NqPnDMT4APS-1CMcw4b8lm9beSrqFGD2HTyIFqChXsDg4cVFqECYpXnFt5csgUr3KUmEtUBPwdjR3TLVtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddutddgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheefhfeutdevtdefieetueeggfefleegleevheffueekleefhfeikeetveduhfff
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:dV4BZhnnapO_q176y39JfQTXtx0IX99b6v6vFsaHtokzffmehd2SMw>
    <xmx:dV4BZv2fdMUwcCkG-LFa-kRsD30OeXX8xlkN6T8WhGquV78s_7YduA>
    <xmx:dV4BZgsJiD4xRHEGf_ZU5ZgyF4Kh3fH5pvy6EbO7IcedAlIwQG1I0g>
    <xmx:dV4BZjVNzSqUlT9U65eoAjz5szqVsE1wANTltumiue431HpVuHfWKA>
    <xmx:dV4BZqRtBXCnhSDSF4MQmFmiiapPpcdb2uR6Tw2EEWmHmhFeLVkNMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 07:22:28 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9f8de695 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 11:22:16 +0000 (UTC)
Date: Mon, 25 Mar 2024 12:22:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 04/15] reftable/stack: gracefully handle failed
 auto-compaction due to locks
Message-ID: <ZgFecAnKzLgCbRcj@tanuki>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
 <50a3c37f92a28876c0db24e515826485c863ecc3.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fC0/zy/FaQwHdCms"
Content-Disposition: inline
In-Reply-To: <50a3c37f92a28876c0db24e515826485c863ecc3.1711360631.git.ps@pks.im>


--fC0/zy/FaQwHdCms
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 11:02:51AM +0100, Patrick Steinhardt wrote:
[snip]
> diff --git a/reftable/stack_test.c b/reftable/stack_test.c
> index 2c3540d9e6..822e681028 100644
> --- a/reftable/stack_test.c
> +++ b/reftable/stack_test.c
> @@ -343,6 +343,48 @@ static void test_reftable_stack_transaction_api_perf=
orms_auto_compaction(void)
>  	clear_dir(dir);
>  }
> =20
> +static void test_reftable_stack_auto_compaction_fails_gracefully(void)
> +{
> +	struct reftable_ref_record ref =3D {
> +		.refname =3D "refs/heads/master",
> +		.update_index =3D 1,
> +		.value_type =3D REFTABLE_REF_VAL1,
> +		.value.val1 =3D {0x01},
> +	};
> +	struct reftable_write_options cfg =3D {0};
> +	struct reftable_stack *st;
> +	struct strbuf table_path =3D STRBUF_INIT;
> +	char *dir =3D get_tmp_dir(__LINE__);
> +	int err;
> +
> +	err =3D reftable_new_stack(&st, dir, cfg);
> +	EXPECT_ERR(err);
> +
> +	err =3D reftable_stack_add(st, write_test_ref, &ref);
> +	EXPECT_ERR(err);
> +	EXPECT(st->merged->stack_len =3D=3D 1);
> +	EXPECT(st->stats.attempts =3D=3D 0);
> +	EXPECT(st->stats.failures =3D=3D 0);
> +
> +	/*
> +	 * Lock the newly written table such that it cannot be compacted.
> +	 * Adding a new table to the stack should not be impacted by this, even
> +	 * though auto-compaction will now fail.
> +	 */
> +	strbuf_addf(&table_path, "%s/%s.lock", dir, st->readers[0]->name);
> +	write_file_buf(table_path.buf, "", 0);
> +
> +	ref.update_index =3D 2;
> +	err =3D reftable_stack_add(st, write_test_ref, &ref);
> +	EXPECT_ERR(err);
> +	EXPECT(st->merged->stack_len =3D=3D 2);
> +	EXPECT(st->stats.attempts =3D=3D 1);
> +	EXPECT(st->stats.failures =3D=3D 1);
> +
> +	reftable_stack_destroy(st);
> +	clear_dir(dir);
> +}
> +

I forgot to free the `table_path` buffer here. So this needs the
following patch on top:

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 822e681028..7b2a8b1afd 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -382,6 +382,7 @@ static void test_reftable_stack_auto_compaction_fails_g=
racefully(void)
        EXPECT(st->stats.failures =3D=3D 1);

        reftable_stack_destroy(st);
+       strbuf_release(&table_path);
        clear_dir(dir);
 }

Patrick

--fC0/zy/FaQwHdCms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBXm8ACgkQVbJhu7ck
PpThgg//ZcBdyKrjOqPJn5qyDpNTbRbbh+FJaiFZuTgzOxAYZ12lDmkrSmP2Es/5
gL0rJ0VTb+f9lU+dDPhdkhz3F+voVFumXTjrKYGca4j/riQe+2PTtckPMag174fQ
QZoCC3o/mEGyNgsL48ct00c8JFhQYOe+ZOsXHLnFlLJyz2gDexj1cfNhRIYwcRV3
2fqsLLv6mWrIb3xaKRqLYPr5kytc8uf/QrsQAGy0CE4u9cTH1tp/TBymeXiJHIBo
fC3X4RHSySOtHJNcwQhQ88OfdBQB94mIKhO179fkqZyYqststoFdbZVO2kZSrBdn
fJOMFjD5i9WshxV1CrMNmHAe5oZG5Ok8b0b2IooQQaUCdlwoD1P5gp8OUZivK5KZ
9S6c91I1STO2n/P76tyaPHejQ9bhYDPW7iZytWJSMia2563RoQ9r7Dz9EqVcomhx
PLhoftDOe44qMdWF9Ish9i0XZp3G8nI4pKH4i/Do447WnPji3Xdxh2eImL7zsNzY
dBjf+ZabFYKklAYR2Y5NIWL51nkStodylr0KAzvS0AHYj3jk5a44KM1yVjRrtD8T
uxh0qGgQ7Z3PVVQmsvV1B2iPyZHHs3GO0tdOzA+fNTHjQMu0l8VhdS9Bak7xThtJ
BYIqscaxUtg0jHWOCHSzDDt+JAa33oV1KUdNCt92cBFR0GLJNBc=
=+zPD
-----END PGP SIGNATURE-----

--fC0/zy/FaQwHdCms--
