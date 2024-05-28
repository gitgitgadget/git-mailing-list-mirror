Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6E8F48
	for <git@vger.kernel.org>; Tue, 28 May 2024 06:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716877880; cv=none; b=VOvUTPFmb++tI+o6yb+fCKA/zJTDYf/jNgNRRFxdQ9OPfQhufiRQ/38pSFNFBNUyrI4RlmyzGBVrcXSRHfmQy7rCc4mCJL2j1HXeukmqPz+YDDO4lPqF3WGHbhupI5maScFE8SZoSNK+InjbHWZj2GmavZ9OKpiKtL8W9eRFgjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716877880; c=relaxed/simple;
	bh=2stneM+1FbI5Dcv9aozRKngsDk9dZupO8nJlWDE+PWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pF3v3vXA6LX+VQLRs+fEyrPfcBrXUq+XqxvhrgGq23QzjdUscwQjjLmqnpu7ILYQLdmkETdcmYjwQvfqzSW47WCSe3sEtyNsY9oaRGHcE4I8HltXGGjVDOxAbebtOUbnHAGgc3RQzYBOzbaw+CSM8xHsOmBdiBpplKljzVXJhoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D6FTCDO3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gXtf+Guh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D6FTCDO3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gXtf+Guh"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5B6121140101;
	Tue, 28 May 2024 02:31:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 28 May 2024 02:31:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716877878; x=1716964278; bh=ouv2cJr261
	+nZpT1zWanSfoBjX8kP/6uFyEfCI8OzcE=; b=D6FTCDO3xfdRNXfb1A3S+yoEah
	Rdtk97gXP4sq1bVnhqABp/FXPTvk5ZRADs29ScR9+thNg0f62UejJyDpn1xDWJGQ
	sH/Ac69pHjplXZYxxiwJCZTdygBTY3yPt9LhCxYCBcp6x+QJZ0LbQG8KV69/tE+A
	ZLfjtkTZA2S2mZVvFoWpHSehTx90rBwBL+RKcyjPL4oemt3+nalkk6S68uEuGqfu
	Bert8PxAvTLQ7YuI0K9+U56/P/CFmA/L63mbASDAJBzqqcrNxmUedC4AXA2+NVBu
	Z3LoJz49J21Y5CZEtyx3E0IFEjUHqE4J3C7T+rGWZEypUTkYH30SuLdHdiLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716877878; x=1716964278; bh=ouv2cJr261+nZpT1zWanSfoBjX8k
	P/6uFyEfCI8OzcE=; b=gXtf+GuhbWLL9DnRjK/ZrS/HIGwlJR+WU1/5Q+9eay0g
	lDjh5ScbI+a2XEIgU3Mxd4KR4GB6pqSrJn90I927euM+6irDgAzPp3nWq6bWzVnb
	kPYeUfOfJv1/B/ePlRZp18q6MNPAjbp5HEv9ufEidMBfb5RXPo+BJaa4F0zT3zE3
	9EBzuPm3Wv4wS1vN2SlyRjgQHGEUpsE0h0G+FaYZm/zPHsOGF92FlLMZZcjPuSK4
	p1oiL/mKl5E71gyxigc2+alESmpfMNsDoEfnXjUsH9l5zfhGUUwIG/r5KRgP/co3
	/50Re48BObJ1/AxASiF8jQxlbihW1avBesLRUzGV8g==
X-ME-Sender: <xms:NnpVZjvrEZ6yyY5jdPdkomBoUYK7UOikYLTUHke9XZbA4M7v-Nbuyw>
    <xme:NnpVZkdGUrNPiiyNg7og2IHJtzHJvlFLzz9RgBFKuXkYFPfin6TguThPk3FKiqiMM
    7COpgMDCS9F1k8bLw>
X-ME-Received: <xmr:NnpVZmwOAJjsWwbLxKuWx5JI8hmyEqy1262eLGyELxFtVrcmfalpqz513ys6g24tuMCH4Mg-tYcpasg2YlZwB4dqSpgbQk0r2ZPc3RLgpCVGowik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejhedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:NnpVZiOYbv1cq818K6zMqh37TetsauOrftJMCdHYAm3HSEH-ub7K3w>
    <xmx:NnpVZj_9TRsFF2xcuRUCDGGAiDvCFcBO89bXm1DVqAGe5_xceeqgEA>
    <xmx:NnpVZiUKtkryE8YDZ1L8GOIGC8g87CE8csdSZn00Eu4h9GqKihKYoQ>
    <xmx:NnpVZkchWT9npxFlhtPQbv0lLHmius-WvwXOm4kXd5XhhZcfO9EKCw>
    <xmx:NnpVZun_BkeW8DR9f4t5sDHEwpRC3kJpNuEZGC1DBbTqpTToJEOeBRKS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 02:31:16 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id e54423b6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 06:31:05 +0000 (UTC)
Date: Tue, 28 May 2024 08:31:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 01/12] setup: unset ref storage when reinitializing
 repository version
Message-ID: <afb705f6a080d93284919ae951d7b24d0a43cc08.1716877224.git.ps@pks.im>
References: <cover.1716451672.git.ps@pks.im>
 <cover.1716877224.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JNLCIzl+3BAaen78"
Content-Disposition: inline
In-Reply-To: <cover.1716877224.git.ps@pks.im>


--JNLCIzl+3BAaen78
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When reinitializing a repository's version we may end up unsetting the
hash algorithm when it matches the default hash algorithm. If we didn't
do that then the previously configured value might remain intact.

While the same issue exists for the ref storage extension, we don't do
this here. This has been fine for most of the part because it is not
supported to re-initialize a repository with a different ref storage
format anyway. We're about to introduce a new command to migrate ref
storages though, so this is about to become an issue there.

Prepare for this and unset the ref storage format when reinitializing a
repository with the "files" format.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/setup.c b/setup.c
index 7975230ffb..8c84ec9d4b 100644
--- a/setup.c
+++ b/setup.c
@@ -2028,6 +2028,8 @@ void initialize_repository_version(int hash_algo,
 	if (ref_storage_format !=3D REF_STORAGE_FORMAT_FILES)
 		git_config_set("extensions.refstorage",
 			       ref_storage_format_to_name(ref_storage_format));
+	else if (reinit)
+		git_config_set_gently("extensions.refstorage", NULL);
 }
=20
 static int is_reinit(void)
--=20
2.45.1.246.gb9cfe4845c.dirty


--JNLCIzl+3BAaen78
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVejEACgkQVbJhu7ck
PpTo4A/7BgGV8G/4k2/5Km27MnU04IClgOfLqykZbqg3k4oNx9HHQwDGLDzeTL2B
JNYfO8/sdxnoqVbigeRW/klOdUvOb1mZirJnlLKXK0Dx/nq+MGbYuE7euVf16/+P
QCEsoW2WNdnoMv4rXKmHxcXfx87ElwKwK0iR6SNcvfLVNQvFWpu5Vk0FkJm6hLIw
txPeSHDWahJjakDCY/urPVERUEVxNu+E1jfreI73ozNzdhwQpbZ7SsNc2T/lPkAQ
5w0xImxXsPAyK2qCC0cKRNLaomkOAmXZTnSUxj/iEw7p3Scm4pHgHkN9xxr4cJSO
U2gnb6O4mbh65K6ifvzlARhyo5ExJYzN7nohsxfyvmuUqqBFnp7wNgj3BNdLSLyv
Gg9Kj8b4tzAIY5HRdoDv6r58Bb9qlsQpikYtHN1H6CEMA3lCEqUZjEWjGWq0dbIq
blnrpAb2m5hI2qO2XWd+sPBe5BxoMpdBDtMAdFyHEWJjHkDnmlyqrY7XEyhajRx1
k3GKzpDVyDJjKewP4fNqfpk1BU+CFErV38ZydmSmwsGOm/xHhWfUKqkvJWeaNEVF
wsYfVy7suAHR84Tmb4quERh00nhYkteVoS0U9FMwOuIolKJy6WrVMA6UbVDGeygE
yuQtL3tJmxGE4+Y2SLGH4tnzYUVnUz+YWLwkAWDdx/2jdMqV1/0=
=PRjU
-----END PGP SIGNATURE-----

--JNLCIzl+3BAaen78--
