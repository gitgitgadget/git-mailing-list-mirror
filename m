Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0789016D9B0
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 08:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179422; cv=none; b=qt635rxFAHTh+cv4UdRwrFMTlCNjSHDc1hKftFUz3XfHNU1CvdiuOPNHEywXfzChM/PZfet4U3B9yZpAGDi1DK/wvMY4XL7tIM/avxyTwhwPhtvWaIIlycA3BenRJzwkWJcEWqMm1/TnHM5A6t3srj2q/JXhcvcOIOsqDFodN0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179422; c=relaxed/simple;
	bh=Ys644v6hgwqRUjsDfxjHDW3z0uuwXuTjGRNrXI2uTIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DX3FpjGnVBnmCBX3qbYXy1yvuhwqD3dFuc+/gikxr4DJkPuNsBiPGrD8/e+FPXAF5tG5/C05QFLzVX2i5FcMVj8JsbgPTVR4+RGSYzh9u/0eyuIYHIDtKrUMzcX/zi9KJ2l8yoXXtBSYsEunAMbqVDZWPH2prs47ScZYh06ocaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LdLCUOoM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MpNxkekO; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LdLCUOoM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MpNxkekO"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5BCE413800FC;
	Wed, 12 Jun 2024 04:03:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 12 Jun 2024 04:03:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718179420; x=1718265820; bh=KNWaneA2gC
	NzKmNZFUlaFCk2pozweAFT2BdSugPa01o=; b=LdLCUOoMAZVyGioiD7bl7WRUbA
	Dn+twiWbH+HtHK8sREWLUy2FFl255KMOjoRs2pcXUtOEVTAl0ZTbUkUOFOUmyRju
	Tj+CMaZv7BG+BI+iha8yF+1vfb89Tz0xUn8A+w1JoAr/LZ7ueX3EqL9naGW2kK7u
	yCsx/ElLiwP7b+WnodoQYqNkQL83sHgOrI7HqIyq0gxxNYL2sS4O/5IlIMUY1rBy
	tuAbSeoJrimEOZe2zvLFA4OyNTdtHGqddI/L8yuL8kl8F5BKEwcADs22upNGNK6s
	ccviD/2163f+lM124TLFY57v+dLqdmefEBp2qLAoIF1n1VgwOt0XUq/C8jLA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718179420; x=1718265820; bh=KNWaneA2gCNzKmNZFUlaFCk2pozw
	eAFT2BdSugPa01o=; b=MpNxkekOrkwOIiJzhNXBSqonwOfn4+6pjkjO/HDHafy8
	+alwkqq1W+jIRI37S8jq1kS2DbR35m18KiRmz80tT0nfgp7ABGgulgOhR7V7FZRV
	hZY3VOb8KwKJn099mLR1EACUjllJgRsBsexgYvzLhVLfW/fUKWyl//NYeWVmyxit
	G4LlQasKVk2v+XYURN3JIDndBJR9IVU72OaY5LcYgLB/Ee96mDfJhWfE7F7PPfys
	lGpLT1RgKk2J44uTTQ5dNxCOFWtje90YIL2eyosXeZCDzmKuLG528ZUUEQO5fDF4
	2mOrcj1FmFiFGvoaESLPyJHyc04GbgKAStZNrDhv5Q==
X-ME-Sender: <xms:XFZpZpJSg_F_KtWtFaz7SGI1-KNYSx3Cu_gNs1dXY5hbkqjYQfde8w>
    <xme:XFZpZlJwp9Opv6liR-JQNIyQNVo-cCiygRYe2O_oEf3U9WDUfE9e1j7Qf5FWJmGCj
    F-QZsDnxBF2zBY8Mg>
X-ME-Received: <xmr:XFZpZhvXLCyZ6mJnHH8BoqKv25b3CRzTcpPv4jk97rzctXsuquYS-bVduQGEsA8uOjTuNIgNiCr_v_Jmfmc-uzEzzaT_UuyCrhEc-ChzkWqn-UfqAfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedufedguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepteeuvefhhfdufedvgeeiueeileegtd
    fhgeeftdeuveejjedtgfejhedujeeutddunecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:XFZpZqZEIRRFPzwyYz_uDxmFcBcOyU39jLwjfaqvTJ7pm8p1sJS1kw>
    <xmx:XFZpZgYjI-9nf2dP80bxLdQXrVU9uk3Z_vuytRajYR7WBOrV4y69uQ>
    <xmx:XFZpZuDp22Gm92wGBK7fYB-TImdebeN8Ot7SVAXkprcOGhN_sfbDlw>
    <xmx:XFZpZuZl34tfl95yADtPXKbquxlP42j-FUHpKBOrzMrIHE-CJc9mOg>
    <xmx:XFZpZoGrowbug3BTxK9ykWDP-puL6hLE_wRlhBdy2fgwPCB-rC33Fzi5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jun 2024 04:03:39 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 7993d7e3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 12 Jun 2024 08:03:27 +0000 (UTC)
Date: Wed, 12 Jun 2024 10:03:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Kyle Lippincott <spectral@google.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/3] object-name: don't try to abbreviate to lengths
 greater than hexsz
Message-ID: <0ccb8d8efa4010c4a7ba00ca1abe7f3e923843ed.1718178996.git.ps@pks.im>
References: <CAO_smVimsHAPbMxy09mcYZY8apFgCbpnS9eSF7UOL6_BLqntNw@mail.gmail.com>
 <cover.1718178996.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jiY2XQcYUHwWnLyC"
Content-Disposition: inline
In-Reply-To: <cover.1718178996.git.ps@pks.im>


--jiY2XQcYUHwWnLyC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When given a length that equals the current hash algorithm's hex size,
then `repo_find_unique_abbrev_r()` exits early without trying to find an
abbreviation. This is only sensible because there is nothing to
abbreviate in the first place, so searching through objects to find a
unique prefix would be a waste of compute.

What we don't handle though is the case where the user passes a length
greater than the hash length. This is fine in practice as we still
compute the correct result. But at the very least, this is a waste of
resources as we try to abbreviate a value that cannot be abbreviated,
which causes us to hit the object database.

Start to explicitly handle values larger than hexsz to avoid this
performance penalty, which leads to a measureable speedup. The following
benchmark has been executed in linux.git:

  Benchmark 1: git -c core.abbrev=3D9000 log --abbrev-commit (revision =3D =
HEAD~)
    Time (mean =C2=B1 =CF=83):     12.812 s =C2=B1  0.040 s    [User: 12.22=
5 s, System: 0.554 s]
    Range (min =E2=80=A6 max):   12.723 s =E2=80=A6 12.857 s    10 runs

  Benchmark 2: git -c core.abbrev=3D9000 log --abbrev-commit (revision =3D =
HEAD)
    Time (mean =C2=B1 =CF=83):     11.095 s =C2=B1  0.029 s    [User: 10.54=
6 s, System: 0.521 s]
    Range (min =E2=80=A6 max):   11.037 s =E2=80=A6 11.122 s    10 runs

  Summary
    git -c core.abbrev=3D9000 log --abbrev-commit HEAD (revision =3D HEAD) =
ran
      1.15 =C2=B1 0.00 times faster than git -c core.abbrev=3D9000 log --ab=
brev-commit HEAD (revision =3D HEAD~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-name.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-name.c b/object-name.c
index 523af6f64f..1be2ad1a16 100644
--- a/object-name.c
+++ b/object-name.c
@@ -837,7 +837,7 @@ int repo_find_unique_abbrev_r(struct repository *r, cha=
r *hex,
 	}
=20
 	oid_to_hex_r(hex, oid);
-	if (len =3D=3D hexsz || !len)
+	if (len >=3D hexsz || !len)
 		return hexsz;
=20
 	mad.repo =3D r;
--=20
2.45.2.457.g8d94cfb545.dirty


--jiY2XQcYUHwWnLyC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZpVlcACgkQVbJhu7ck
PpRumQ//fnNVlbaNqwAv2/SHfD/lW2iV5y5d6poc/FwTb4/t2/FMsqXXZ2PhVOdV
cyfFI5JHxuxakgaxDK7qUB8RdeMNbpFdVmoTAGftPL/IrG+Qa9Ow0L4e2iQs+LkJ
Vr9W7hMGyu63nAynca+iJw1zD8i252aFhuom4/NOemH+wOCpO09jMaKLhoo8YRcG
4v0Z5pFLF15GETBAx8l6LSQ4tiym7wYR8Kr1mYaE1vC/UJ82kI1hEPu+R1LdpX5b
a/jsNaaWjZvEZOikBS88yjGRiSV1wA9Otx3nKW+iH/MNmSGZ1+48ivlbBBza2kdl
ddYp4Ylcp0ToCpJ/xfYGjnHR9eDB7Hrca4Gen1+coHJP3f2UPwIAqVkHA0nRYeUo
/vvZfJH5Qm49sak296vGA8LYhyelZWNCdd2+qU3aUdquiFD2igtd2lrkPq/1Ta0N
d0OpPmgY84qrMI6U9KbGbkV6AE17mdLRpGz4v3Wq04QqgRgzGD4I6l0zx5wB8PWm
Fw1JGHKQ6hfdP1H7Mpt8D1hiECgAQo3/WOYTrsy8wHNV9iAjHYiCfm2Ie5n4zhSo
kYUZ67fVroRiBmyvdoM6y7Ep28TJ/h4Zu7Ok0PdgjzJj6XBWC70Eom4anGguO1lV
mI8v9aUQGjkvFNKQQWPCghRUVJl64UtLZ7rATy9BY3j2/WY7R9k=
=bvps
-----END PGP SIGNATURE-----

--jiY2XQcYUHwWnLyC--
