Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F436A340
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579047; cv=none; b=eP39zZSt9oZX/e6vQNjkcm+c1aHTs/c5Q9M8FNwqld3BqnSyQGYtr+eMVNWT3WT2nacJOLeabvfNvpgGJX/gLs9exbr9sYS9lkq8Avp6rCwDXnZL8ojRlR7tPbJ6xmSuYvwIwc/f1sJhKRMLt6orEYWCUcfhmITyL+EVci0tJjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579047; c=relaxed/simple;
	bh=PzM9mGZBtv/60xeuQhgpBNrEVg+fyyEsHxSvMmJALSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oz4l3p4q2gfh0dm8HfMuxEY88Ieo0OO2b1KZN+g8oWEr2q0TzCYZx0yTAHa/ZhK48KKYdhJRx7wYwHRzt2IfBD81sR15fyQ1/ia9gYuSS59cIrPSLx1+D5K+B8FpH88vxllsusU0em7FmVRMLyOcAFr3yuWGf+4uknVCSa36Rzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Sz3Uuzxg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GqiD2aP+; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Sz3Uuzxg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GqiD2aP+"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 369EE138010B;
	Mon,  8 Apr 2024 08:24:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 08 Apr 2024 08:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579045; x=1712665445; bh=6VkoQ0LeaP
	fr1rq2ORipEk5JxrHckoUW4dtch2bJmtw=; b=Sz3UuzxgsyenmdfN8I1Fr9Cw80
	R719tLVfwvfpSGqHlcAbJE7diprSpLFJST1RVsjs/CarUjgqWaJws6YPHzv/kQKn
	XXxir0918BimHXrZrW4DZXMhqTc8XXLs0+BUXFEoceuGOU2FYlULM5f6NthGDjnD
	LJeE7FXE+FrduKWwVrRqkvtnbRZnpXUn99EYXMmkhzV9Wafsuy5B+pY4JqSSsZzb
	wNr629f9IqVdXfG+oEAPhgk4/H5pDomnIU9PQt1Z+2taAKAjSGAdONKP20Q7dkNa
	sCHD8gOc5hw1va6nYy7L1mZu3gL1tiGcQWPm+k5kBtate1BP6pEjlgT/HudA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579045; x=1712665445; bh=6VkoQ0LeaPfr1rq2ORipEk5JxrHc
	koUW4dtch2bJmtw=; b=GqiD2aP++n1/7qGtWPkHCL3r/npVILiJc2MCV9DwDWQt
	Rg7iXKU40zhW4nvO4vTIVwkgBvIZLTFjR1/RKcdU8KnjTIQ/XyPVZ6AENx2yOJeO
	pZknOKESVTwgDShVq5dykNgNadVjQ/b56iZmz0LSQwZPDC2cAmc/ICEZ1kYiIS+a
	SpKNKR1Q6Yr2mkBJi53dwgsquu+a7WG7bghNyPaQT90tYUI0PAQfSahqvLNCUVSF
	jhaNIXABtZKCZK4NV2EJnqHOdjnhVsCbTPTWyaKOWBeMc3wwsycJ6NfvhbxRYI9X
	E7+acpADiiaVCfCkd8j8DCQvVOub49ERxQ7TQpHuBw==
X-ME-Sender: <xms:5OETZg4fsamzJQGE2oyk1GDlCz8cvphvp41m8mcEmpXUyfFhpdN6MA>
    <xme:5OETZh7pLm_jmnFwrqTXVhWd2kOJymVvB-trztSbCz_h9Qww7gzV57xPOnrea-YfH
    iHRvu-ikzPngpb4dQ>
X-ME-Received: <xmr:5OETZveNcl_SI8KmZu4CH9Ncy0ku-vzxGmwOtlUCPawrprNA17gtJU9aiCbnv9hvgQANEpK89XStUaZWFcghHJbjidRMNGIO5AvThpGvjSpNPHO2sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeetueevhffhudefvdegieeuieelgedthf
    egfedtueevjeejtdfgjeehudejuedtudenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:5eETZlLI6eWQAnT71jozHeJKoi0wflrVEQdTmpNl_r1dunMuS0x2FA>
    <xmx:5eETZkK7X_Jp1XFUDxihDlTURcB9zx3qapcGR_0dt98nlTsf4gAwAQ>
    <xmx:5eETZmyjvpIBezQW7FMiiXg2_hkuT8UiyPXqZrc7OtqzMqrrx0goEg>
    <xmx:5eETZoIuLIQXaewGdp1ZT3NA9ZTGd0G7dQRKlj2LulTXxBqCzGpjNA>
    <xmx:5eETZo2KV-pmKCIFj9OvaSc2sVfuLOGyMjJ9J1RRZ3fmt4L5wYOrT5rB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:24:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 2fb0d75b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:23:57 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:24:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 03/11] refs/reftable: skip duplicate name checks
Message-ID: <763c6fdfcd93651dac46de9c308c66f10d73d3d2.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MDTlKFdoCed72LD1"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--MDTlKFdoCed72LD1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

All the callback functions which write refs in the reftable backend
perform D/F conflict checks via `refs_verify_refname_available()`. But
in reality we perform these D/F conflict checks a second time in the
reftable library via `stack_check_addition()`.

Interestingly, the code in the reftable library is inferior compared to
the generic function:

  - It is slower than `refs_verify_refname_available()`, even though
    this can probably be optimized.

  - It does not provide a proper error message to the caller, and thus
    all the user would see is a generic "file/directory conflict"
    message.

Disable the D/F conflict checks in the reftable library by setting the
`skip_name_check` write option. This results in a non-negligible speedup
when writing many refs. The following benchmark writes 100k refs in a
single transaction:

  Benchmark 1: update-ref: create many refs (HEAD~)
    Time (mean =C2=B1 =CF=83):      3.241 s =C2=B1  0.040 s    [User: 1.854=
 s, System: 1.381 s]
    Range (min =E2=80=A6 max):    3.185 s =E2=80=A6  3.454 s    100 runs

  Benchmark 2: update-ref: create many refs (HEAD)
    Time (mean =C2=B1 =CF=83):      2.878 s =C2=B1  0.024 s    [User: 1.506=
 s, System: 1.367 s]
    Range (min =E2=80=A6 max):    2.838 s =E2=80=A6  2.960 s    100 runs

  Summary
    update-ref: create many refs (HEAD~) ran
      1.13 =C2=B1 0.02 times faster than update-ref: create many refs (HEAD)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8a54b0d8b2..7515dd3019 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -247,6 +247,11 @@ static struct ref_store *reftable_be_init(struct repos=
itory *repo,
 	refs->write_options.block_size =3D 4096;
 	refs->write_options.hash_id =3D repo->hash_algo->format_id;
 	refs->write_options.default_permissions =3D calc_shared_perm(0666 & ~mask=
);
+	/*
+	 * We verify names via `refs_verify_refname_available()`, so there is
+	 * no need to do the same checks in the reftable library again.
+	 */
+	refs->write_options.skip_name_check =3D 1;
=20
 	/*
 	 * Set up the main reftable stack that is hosted in GIT_COMMON_DIR.
--=20
2.44.GIT


--MDTlKFdoCed72LD1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4eAACgkQVbJhu7ck
PpSfLA//cuVk1ub3TbF33157GRXdqVw361I1qKCts/tAHp8Z9RpGyPvq3oYiTEsR
aESZ3EiUtB380cRXVsOdjYmACqjHDQLX3n8ZI+ZD12MRubgbBnxiQ3kBQs28K8rv
lY3jEYJ/4V3mbzMBIcrFJTAqUhomRhUOjAEz0rqGU3NIxqy31btkQuf2u56awYK+
gJ9xvzhZ3j8WYxBNbcSeBYL42qsOnSGyo+oJJBUhNQGHP6EU/kQgkYeNMRe6UPTn
/CS01qgIW6ko2zwuzZPL27hvIusqcHh0QLy8oq2RyVLBQ526IJHfFnYDeZ7SxTFQ
2hD6MGehmY9Ws/FKJ80zx0o3g8ybDKMS5OaXyw2yU1hBLVWbloZk8RBH1CHdfSdD
fr2XkMGvuN7niI8IDtvP1pBZRTql7/pidn5TXakE0JpQHYTt4HsKp1jFBTsjooJb
c0u13Jq50RXGv3pNWNGzFg9iUvm+kRywyjT4PX7ss7eez8Ew1MC+b6a6LRvmHc6F
kpK0DZfZMGHzq8kOl30s45xKoBOXGfiV26XNWe4oCMnBq1MYXqVlAQumg4UtLBF7
65teOaC4Onhje3O4muh2cduRM7cyKy4phrrYuA77iUUZEW5Xw/9YCUkRd3ieLViv
cLeA5l0pxjqt4P+IUu5JhcgMtSzMjeShuom/7P4EU9hWI3d598g=
=Rpou
-----END PGP SIGNATURE-----

--MDTlKFdoCed72LD1--
