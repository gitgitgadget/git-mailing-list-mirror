Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3A17FD
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 01:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711070719; cv=none; b=Hh8DaoEk/w43ebjff9K9+/mGzvMOUh5f5xAczTDzxVcG4WaghWdg6JZIIOxjAehKgko9N6ZU8pyuorTrUFZpOA6nggUK0UkeDligeu0OszeRAok5k/kNg0wJhdjsm+7XZsPlICj9VDROXbltJl8bPbN0SThk+OU5FVGkeOpLAoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711070719; c=relaxed/simple;
	bh=mKQ6jj54uxlLBn3w3lKpmluR2xBOxTGMKstOxXwtnFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zbev6wJB81FGGp5sWHRJz9BZ44IXZWeXbdVV9WdQORS+kg9NQodeBNtrX0SCbYKyQKf8yX3F2NX+SQgxXZuInL+yb4ObR2ozUDLCsuiXKkecPfM+IrwGdMFSoDM4PXsArqfrDmDnUmiC6Ho6Y9KhXW2796yP2oowAXRgfdM1nEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DxHzOxQR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BhO1jPtF; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DxHzOxQR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BhO1jPtF"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 93E2C11400CB;
	Thu, 21 Mar 2024 21:25:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 21 Mar 2024 21:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711070715; x=1711157115; bh=OtBEnis4b7
	qZExvNIvLT6LTlsgiNmaaV6i8uBwVO2AE=; b=DxHzOxQRqhiO0wRVT2wYMddr1t
	Qy9Q3O8HzwCMpjrRwkDhba3DATirYf5vyOG3y+KpR33UxfK/VOBmiXqMqhzzWpVn
	g5syeWFFNkR//Lez/illpFLUPFsmFp46Tx8r9yuhiU1iSV7TmcV8YNNLIah8UwNl
	knJZGkJ2yTyTmWt40WSVBQWp/EjCejQ4rxYQKdq/aVIFlrgUtLTrTF/vJxRro2md
	Xg6xZOxnRRQ7riLezewqLibLHy5/zVqGHGTjcA1qVGZHCT6/2Lvt9aHYigfG+Vn/
	emRoAG0ECDA/W/YflKLRf9r8tcwCnGcTGW4b4WDYO5oCjebRVN8doNDs96Uw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711070715; x=1711157115; bh=OtBEnis4b7qZExvNIvLT6LTlsgiN
	maaV6i8uBwVO2AE=; b=BhO1jPtFNsFUueFXRLazg73cQEvaXfkWzetRBgbGMQcJ
	79pLOcLGXr9kGn5KCsSJOTpR6wcyX2kCxklSojRBGj4/5EuWl3f8BxAlCM7rmK6S
	8P+5+wKYp+eMg8Yb6pXzEFdK1DHJuuIY+so9aJIt1bV1r1zp8MlT4XiLefAL9ZHE
	idYRRDjlgoNPDWPG8CHn9owC0JrX8hKfrc76aSK63JkpzWHzFbQ4hkmj1tQUUMEC
	C14XTMPzqlpmnlrg/6RbjCbLgA2pXdFKLSl1knilsj3j/iLGV4Sx6cmu2cjeEQg5
	vjmY8Dgxuzx4gc6GwwCuOO9H4B/AcNIYpT01Ks/Hhg==
X-ME-Sender: <xms:-938ZUo0tYA19jj-iTrNoLIofU1Tb7724L8NP_pQB1Bo3BuhpThuAg>
    <xme:-938ZarbT0LG3kCqUxxKpquESlpJaOFYFAEFUbzTs9xKavLfPHvZRthp9Z6WDW15i
    ZlShBm50e6w2U008A>
X-ME-Received: <xmr:-938ZZObc9_-k_3YOv73fnfikGS_vInIvGkGr0ZscI5btn6chdCm2xBZfEASwZU2IKPHvlXb-N0iSsWNOGDzXKvoE8rskvs6-oG53LH0Y_YdQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleelgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:-938Zb67ZizmALJ0y65PeeTKJuWUOcq-hqLBEuDX3KGJHW-G1NdvFw>
    <xmx:-938ZT5o1kfLGF6FfqN8ds4wVfmAth6x1K4aRx8y4NFVAvMO_gutMw>
    <xmx:-938ZbiyAJYnJgFTd35cvKyiuntCNoCfi7tge-gdUnHREiB8Lzqm_g>
    <xmx:-938Zd75GkP0VXb7VISHwMqvJoU7nBZyZRpzAv4rYMWH3L4Spzeu9g>
    <xmx:-938ZW2msruXnRvsBnu7M4kV-uBXFZEjoblKWUvFnXeVifS9RC-MiA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 21:25:14 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b0306f7a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 22 Mar 2024 01:25:09 +0000 (UTC)
Date: Fri, 22 Mar 2024 02:25:12 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v2 1/3] reftable/stack: add env to disable autocompaction
Message-ID: <Zfzd-FcBNW2eHjEe@tanuki>
References: <pull.1683.git.1709669025722.gitgitgadget@gmail.com>
 <pull.1683.v2.git.1711060819.gitgitgadget@gmail.com>
 <cb6b152e5c86ab14165e072ac20dfa865b5f3aaa.1711060820.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MUdusLqsK26cuJwr"
Content-Disposition: inline
In-Reply-To: <cb6b152e5c86ab14165e072ac20dfa865b5f3aaa.1711060820.git.gitgitgadget@gmail.com>


--MUdusLqsK26cuJwr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 10:40:17PM +0000, Justin Tobler via GitGitGadget wr=
ote:
> From: Justin Tobler <jltobler@gmail.com>
>=20
> In future tests it will be neccesary to create repositories with a set
> number of tables. To make this easier, introduce the
> `GIT_TEST_REFTABLE_NO_AUTOCOMPACTION` environment variable that, when
> set, disables autocompaction of reftables.
>=20
> Signed-off-by: Justin Tobler <jltobler@gmail.com>

Might be worth it to demonstrate in a test what this does, also to make
sure that it actually works as expected and doesn't regress. Even though
it may be a bit overboarding to add tests for test-only functionality.
Dunno... ultimately it wouldn't hurt though, I guess?

Patrick

> ---
>  reftable/stack.c  | 2 +-
>  reftable/system.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/reftable/stack.c b/reftable/stack.c
> index b64e55648aa..2370d93d13b 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -681,7 +681,7 @@ int reftable_addition_commit(struct reftable_addition=
 *add)
>  	if (err)
>  		goto done;
> =20
> -	if (!add->stack->disable_auto_compact)
> +	if (!add->stack->disable_auto_compact && !git_env_bool("GIT_TEST_REFTAB=
LE_NO_AUTOCOMPACTION", 0))
>  		err =3D reftable_stack_auto_compact(add->stack);
> =20
>  done:
> diff --git a/reftable/system.h b/reftable/system.h
> index 6b74a815143..ec08b728177 100644
> --- a/reftable/system.h
> +++ b/reftable/system.h
> @@ -15,6 +15,7 @@ license that can be found in the LICENSE file or at
>  #include "strbuf.h"
>  #include "hash-ll.h" /* hash ID, sizes.*/
>  #include "dir.h" /* remove_dir_recursively, for tests.*/
> +#include "parse.h"
> =20
>  int hash_size(uint32_t id);
> =20
> --=20
> gitgitgadget
>=20

--MUdusLqsK26cuJwr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmX83fcACgkQVbJhu7ck
PpSAbRAAi6gl/Xs3eTDJkKqpd81PTSVpL3MfiolyJHwQ0F/5SQPVsOwRNSPWN1n4
4q6dF6APXVUW8BJFfejaURie/9tsiEF8Y7SeZFTg18mInc77y80JITfEhj3E/dUR
rcSzlugXPmdJvdRxa/cCMc5keAAv6NLCH/ZxwpNEo3Qz04/Z+Ngl5k7Kme1hmfWf
4bn2fJZHusTp6KCFL10h4ynHqbkoew8gHoJJU52/SVtBhlfquPxGGUBHrzHhxLLO
ccuOyne9WigLOs1IIy3qCNe19a/BaCfwySoBUvEaVeth7zJZaibEy3x6jwmqx2bM
IcftVJjQ5SPAIVLYG9N6Y8HgiCtv3ptMdKIn7JBpMMFhV2zWsgWu1HyqvV1myL53
guQHkUtgqzOFxz/mD9m0t9FWXZL7BmjhQxnXiUV0CaZs/4RfV2zhs8DKHU0Y1FFC
xjB9eTdq0O1jyYuCVPX67YrK+tI7ssD7lklAb5fiYFGQZINgYmxoSnHR3LPxq1aH
RHoQE3+PjmkByiPy856GssuVG/bnFfpQm2A2AInHHlmSloyhA2AoIfzAapXWZi3m
Zlsvsb+pOsREsI00gnOtkRMSRyz3yBqE9h2qoa61zxcFRiEoWWstNfy7RjGyJwRg
YxbAsMyFwF4pFxxC7y7hv0dqQHAVSKdXzeY2XiwnsgO1n5hF4e4=
=leRe
-----END PGP SIGNATURE-----

--MUdusLqsK26cuJwr--
