Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE882F56
	for <git@vger.kernel.org>; Wed, 29 May 2024 06:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716963994; cv=none; b=V9MuVVy3M/+O9Q+W1QBjWVQQ0r04+1hUdThUdXGGIEzcbvP10PP6Cm0iX3S/eGtAyafEtdASo91XP6L2s6ebrChtq/DAEgG15bCX7Rbd+biLCyZdT1Pyf7HPEA/lk39qvdyatUmJTdqm3dfUoCH8EGSNFJa/D9Wtb0hPQlyK0nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716963994; c=relaxed/simple;
	bh=1qqA6O4ZNPFx0nHaptyve1dnAced30JBTIdc9J39ZfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSVu6I/u+qLWV3NzpyUPmddZx/gDe2M0dlmqa6x0kpf0QksZkrlxxsgi5v2uA0kMUmSEFFZqAY515PovxKw3XGhcwZbsJmfxZ/uzq997f7jAj2DstjMfrKOm/jk6xfUS170Al9dd9Y7UqkMfgoVqDIIuZjxNNR7yp9TNU2UBwq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=kY9pK/nk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lBnmjtRr; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="kY9pK/nk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lBnmjtRr"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id A36A218000C3;
	Wed, 29 May 2024 02:26:31 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 29 May 2024 02:26:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716963991; x=1717050391; bh=WqiJPhtRu3
	j53VwiMyvJUhQ0XmOWoCvf6A+rb83SkYI=; b=kY9pK/nkOCWkmoWO95wT65wPGl
	uOJQw17/G2uRKviDVGUayJyLbgDFj54dBv8z2ELDvWJk4QmJYfZ3DpkyiwIH1n0D
	4ODWLrGXm099qbMuNs8lj4nOdMmr6y+UgyIVbDAmk40u183NDqrSJsm6at+4rl5g
	QvKGmis1UxZSRxb3q4gYuNPNhnbiGlg4YhZYdFeEl09WvoKweAXzNL0pTyYcodc+
	bHQLoEk5myNGlWEyiOsHITY1aq9Dv/iVB/68u2CGdEkjSmCbNpzNteqL1K/Vh2rJ
	8cyoJ4WCWJnBcVrcaQcFAi2vtHBUNG3uKPx603Mvrapgq29RLv4OcyFUX7HA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716963991; x=1717050391; bh=WqiJPhtRu3j53VwiMyvJUhQ0XmOW
	oCvf6A+rb83SkYI=; b=lBnmjtRrVX2ttJ6RxnwyLCeHk6eeRe9GB+YnBZY1MXqc
	op0U7Do2PgAatCPgbfLyGONPmGrzVLb8c9F7qNpRa1dS3lZKTtoV0XBJsZDouZuf
	9EC4wWMiXFyb/D0Q3Bb7I6AEe2A/fnwgnmPO1Exj4tRVi/J08Krsix8GkP4PQj4x
	B9imSfIQ5ukjGybIKMPWWqV+/LO1duNC+CBMk/k2rAGtJpIi7+x//jjZ1zdiK4yO
	JTJuYYBykxHJAjyioQ9qNHxqRfu484RiEl+MxdN/V0jVcybCtmlcvy3oQYIaeaWp
	Arw5sgn0ROuu8VkTXB3EIrwUe7+dl+az4dEswPeH7A==
X-ME-Sender: <xms:l8pWZoKiFUiJ_WYbw6WAdttLBlBy2fU2DLwMBPf5J65NFSLgbcIqXQ>
    <xme:l8pWZoIZBfUiC2fSm4syXR6B11O9nO-2fOJggRf-CIOlaNOVYDL4qJHfjnFhGoXhJ
    fPdaUMPE_CNe3aKuw>
X-ME-Received: <xmr:l8pWZosATx9kLTLjDQQGMxC1Ft3PzwltyuhCU2V616r1mHAqfBe8PLR7A1GHdB5dgV1d_-PD7ejcEIxp7RAZMVktcnoJNEQ7QlLRes8uO0TXO2G7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdektddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:l8pWZlaJJ54XD_UDzEk8L7dHYqSTe5XGO_lhucNjg0X0fhQnq_TRhw>
    <xmx:l8pWZvaBxEcX_Y1bbOabvDWUQ2RLkuJ32QHJ_o-bMftohrKPU2HEeQ>
    <xmx:l8pWZhD2HL-yGz1xJpfX8uh4W_wkwIjr_TGmJEa_Up6miBd50zBqGQ>
    <xmx:l8pWZla2xI3F68ri3MrcJpCnTadP7SqPVw2pRViHCZAqYxYtiCEtyQ>
    <xmx:l8pWZj4I0IGTiZzliMEG9zcPh7qYfqOmEmTcqckancjp6MNkG5OkEcqK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 02:26:29 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5a9613b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 06:26:13 +0000 (UTC)
Date: Wed, 29 May 2024 08:26:24 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: ach.lumap@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
	kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v4 2/2] t/: migrate helper/test-{sha1, sha256} to
 unit-tests/t-hash
Message-ID: <ZlbKkMfmWFw59aO8@tanuki>
References: <20240523235945.26833-1-shyamthakkar001@gmail.com>
 <20240526084345.24138-1-shyamthakkar001@gmail.com>
 <20240526084345.24138-3-shyamthakkar001@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aJSyCxIMMeNY4VJY"
Content-Disposition: inline
In-Reply-To: <20240526084345.24138-3-shyamthakkar001@gmail.com>


--aJSyCxIMMeNY4VJY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 26, 2024 at 02:13:45PM +0530, Ghanshyam Thakkar wrote:
> -test_done
> diff --git a/t/unit-tests/t-hash.c b/t/unit-tests/t-hash.c
> new file mode 100644
> index 0000000000..bf3e0e9e94
> --- /dev/null
> +++ b/t/unit-tests/t-hash.c
> @@ -0,0 +1,86 @@
> +#include "test-lib.h"
> +#include "hex.h"
> +#include "strbuf.h"
> +
> +static void check_hash_data(const void *data, size_t data_length,
> +			    const char *expected_hashes[])
> +{
> +	if (!check(data != NULL)) {
> +		test_msg("BUG: NULL data pointer provided");
> +		return;
> +	}
> +
> +	for (int i = 1; i < ARRAY_SIZE(hash_algos); i++) {

s/int/size_t/

> +		git_hash_ctx ctx;
> +		unsigned char hash[GIT_MAX_HEXSZ];
> +		const struct git_hash_algo *algop = &hash_algos[i];
> +
> +		algop->init_fn(&ctx);
> +		algop->update_fn(&ctx, data, data_length);
> +		algop->final_fn(hash, &ctx);
> +
> +		if (!check_str(hash_to_hex_algop(hash, algop), expected_hashes[i - 1]))
> +			test_msg("result does not match with the expected for %s\n", hash_algos[i].name);
> +	}
> +}
> +
> +/* Works with a NUL terminated string. Doesn't work if it should contain a NUL character. */
> +#define TEST_HASH_STR(data, expected_sha1, expected_sha256) \
> +	{ \

These macros should like start with `do {`. The reason why we do this is
that the compiler will complain if there is no semicolon after the macro.

> +		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
> +		TEST(check_hash_data(data, strlen(data), expected_hashes), \
> +		     "SHA1 and SHA256 (%s) works", #data); \
> +	}
> +
> +/* Only works with a literal string, useful when it contains a NUL character. */
> +#define TEST_HASH_LITERAL(literal, expected_sha1, expected_sha256) \
> +	{ \
> +		const char *expected_hashes[] = { expected_sha1, expected_sha256 }; \
> +		TEST(check_hash_data(literal, (sizeof(literal) - 1), expected_hashes), \
> +		     "SHA1 and SHA256 (%s) works", #literal); \
> +	}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +	struct strbuf aaaaaaaaaa_100000 = STRBUF_INIT;
> +	struct strbuf alphabet_100000 = STRBUF_INIT;
> +
> +	strbuf_addstrings(&aaaaaaaaaa_100000, "aaaaaaaaaa", 100000);
> +	strbuf_addstrings(&alphabet_100000, "abcdefghijklmnopqrstuvwxyz", 100000);
> +
> +	TEST_HASH_STR(
> +		"", "da39a3ee5e6b4b0d3255bfef95601890afd80709",
> +		"e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");

I think these might've been a bit easier to read if they formatted like
this:

	TEST_HASH_STR("",
	    "da39a3ee5e6b4b0d3255bfef95601890afd80709",
	    "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855");

	TEST_HASH_STR("a",
	    "86f7e437faa5a7fce15d1ddcb9eaeaea377667b8",
	    "ca978112ca1bbdcafac231b39a23dc4da786eff8147c4e72b9807785afee48bb");

It makes it a bit easier to separate the test data from the gibberish
that those hashes are.

Other than that these patches look good to me.

Patrick

--aJSyCxIMMeNY4VJY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZWyo8ACgkQVbJhu7ck
PpTbiBAAgXlugz3VNd71FNTPU3XXl03pjSFUWrgJyWUBd+XKlDZCz2CH/G6MSRNl
Y33NEqnIFn6Ami1q5m+8xNfVibn4U3dew8kDP/HChLZ2y99e+QYb39EJqUuQ06eI
vEMWCl0zlFR+nPtpIoDxQ5CvIcEtyHvEGa/KkoAuRXM9i7685RNfRqaVeBAIbnfk
RUVyqn+gra9xYPRooCgOaetv6f+EiCfdtAtwZ5QJFr1GqCepf6QgM4ut8j18HPdN
2TcbHp4PQlWkpMMWM6WOIrnRTkQfVaELJ19GcVZJymFdJbwjP2uDJu2oSzyMyzyX
eeWfCd1KQoewjQxZSSx9gTCTPBuWfLUB8I1qRBuraknFVcJRs5vWEgB6c4+RCV80
uWDWMTyyWm5A04rSXSNtYN63GQK/Z/OEqeiT4UT6d65abynV1BOoc8k6QdgBDrkm
8ETL4w9lzDCNWErfqOyIAY+1XVIgtuofQgn6CgsN99eCo3KFaNm+C53e1C2NvjnF
7fwaadKPDMuUIjPIb+Jf98svQ4j507+yaVdQfY/LtXrGKEnrR0Jf5RlaTJhkcQCH
F7VTg5uooT0vR0AyzIsZQqv+zIdeGaZREvA+9IkZX78t1lHshZEO+4p3zMzj1oZv
N6JV64rL3x0eQnI+eQveTxDZr0//UyrO3BazMcwbahSNnZs3BV0=
=bIbe
-----END PGP SIGNATURE-----

--aJSyCxIMMeNY4VJY--
