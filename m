Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD7012C550
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711360988; cv=none; b=WoEmXwln2VqZuerEp/g4+ztUtddKUypBF/FPabtNV0D8MlRUwmjxSHoh8VYX8/zyecNIGfRX+K9t50KLwOvDvaXzBEt2VobJfQ6pvpd+q2xVEp3hvbxvevIMMm3mhNliauAkLMU3WejIbgS/fHBWfj+gUaYFpBpTdju78F4/hJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711360988; c=relaxed/simple;
	bh=SvdDExjxp+VEjTH5CIdiVa7INZvzBvPFcRsRpWqKY9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLMRAMjTBQ/2H83wkVP9HjB/Go1FLSLMdRoZH6gYsP+Awa3804F3G4bJxPc+VrWXpZGvWU228F989YoDzgmA33uC1n/ZYuLy28YMu2/7pZ8UtWw/7Jqv2zEfJQAFt2FrNPpEQlPlIdqDhVb1/7PYCzDH5JdxBUfYgbT7CfE1uLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BKmcrYte; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VS46aGRy; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BKmcrYte";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VS46aGRy"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 28A4F1380083;
	Mon, 25 Mar 2024 06:03:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 25 Mar 2024 06:03:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1711360986; x=1711447386; bh=I6toofywJk
	eF7jswopkRGwq5moffPwnyKcvdwRibSN4=; b=BKmcrYte+1sFT5T8WJhKmnxgZo
	kHM9+6YBMeCgIfNH6SfyScp1xvP/zGoWgqR1/JugJ2MmvMR2kOcCIkPaBimG3LwT
	RbT6m+m1UkI9a74UFi4RiibvMIUK4Z2NedAmFIDnpKKv2D/tp1hCmsoOwQNAfo+r
	I78mAV8thdkT+2dBNYOR6ilOw39OJ92HucGqDAuwATkFHyGLH1D+Vdv8dgs7PBV7
	M8N9ZmOIPmxAn2pRNlKYGagUN6Kl1fyXcMkhUXiSqRhRXw8x0ZDcuF5j3rOW2+Ui
	3DPkeHmgpOJFo9kVoReQTnGgg58UgPM9CXgdWTiVy+I1LBtGUZZ8bK+YkBOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711360986; x=1711447386; bh=I6toofywJkeF7jswopkRGwq5moff
	PwnyKcvdwRibSN4=; b=VS46aGRyCuNIos8ikflu0H6VZgl4KupMP/2yO0Aizkv8
	dZydaKaX95ycQrLSMVfGFUWjTvFc0Kgq8RcBeXwl7oMN32pu439+HvvVyKOVt6m2
	luwfdagDktOf9dPi4lVLGiDl5aS3H6SJ6rL3TVXWZqwjYrEsGSKxfbNnPInNgKjt
	HPys18xZcnEN8ld8oMIWBC1ZlidLJA2CjGwszsT7vDQSRlbxBUfA8v3t3o4VO9Hu
	O2XYgrxubRjJUs7cNsZxFBpWxCm0PMstcxQwhODenWWDxAdS+shNHoRAbbTrpJKC
	K3wqceMiDSQZ9oFC37u3bcnHui0BoY65MAOUgyhWbw==
X-ME-Sender: <xms:2UsBZsG5wJRn3fJVuPhkDi5VKGoaXLT01AHSfPLJNeO1457bn_MLDA>
    <xme:2UsBZlWZ1GDMnz5XWNj9fuRkDgcOO3aMQgemVDE2KBU7CgiNoYoJLeLDeyh_PEFxa
    eH6EekaRnyBs6v1kQ>
X-ME-Received: <xmr:2UsBZmL_A0RLo2mcscz5i36wsA-Rd3ffDJkpU7LKulFuVEssa2qiqXKEMmrZ1xFhNpZMs46uRlMN280fHseZBfWQN0XFy7Nlj9EjRWtZMBuv-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtledguddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:2UsBZuE0YTzy5qCwg_KScMympn7isep-_isEmAyYxBv5M5-gCB7oqQ>
    <xmx:2UsBZiVulSSOxHmC_Ses72MQnOaXcmb0S86F62-8EtwQuoanA5kvjQ>
    <xmx:2UsBZhPAl_UsRyGTJFuJpSjVyAT1F1EnG9mja4An97wRSY1KnuVi6g>
    <xmx:2UsBZp1rT-bY4CAoEZn-J_Ez8JngyNZijDwhYAxYhc407QrgpAZXVQ>
    <xmx:2ksBZgzxtWk89N0Gj5JvhKrdEDCco3W6I1ZVHBuJwAFMvJkDh_YFfg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Mar 2024 06:03:05 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 085286da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Mar 2024 10:02:55 +0000 (UTC)
Date: Mon, 25 Mar 2024 11:03:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 07/15] refs: move `struct pack_refs_opts` to where it's
 used
Message-ID: <809094ffec47db9c2f95850106448ad3b2e83430.1711360631.git.ps@pks.im>
References: <cover.1710706118.git.ps@pks.im>
 <cover.1711360631.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BOWB50Cm7PLQAh97"
Content-Disposition: inline
In-Reply-To: <cover.1711360631.git.ps@pks.im>


--BOWB50Cm7PLQAh97
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The declaration of `struct pack_refs_opts` is in a seemingly random
place. Move it so that it's located right next to its flags and
functions that use it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.h b/refs.h
index 298caf6c61..139ce7113b 100644
--- a/refs.h
+++ b/refs.h
@@ -66,12 +66,6 @@ const char *ref_storage_format_to_name(unsigned int ref_=
storage_format);
 #define RESOLVE_REF_NO_RECURSE 0x02
 #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
=20
-struct pack_refs_opts {
-	unsigned int flags;
-	struct ref_exclusions *exclusions;
-	struct string_list *includes;
-};
-
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 				    const char *refname,
 				    int resolve_flags,
@@ -433,6 +427,12 @@ void warn_dangling_symrefs(FILE *fp, const char *msg_f=
mt,
 #define PACK_REFS_PRUNE 0x0001
 #define PACK_REFS_ALL   0x0002
=20
+struct pack_refs_opts {
+	unsigned int flags;
+	struct ref_exclusions *exclusions;
+	struct string_list *includes;
+};
+
 /*
  * Write a packed-refs file for the current repository.
  * flags: Combination of the above PACK_REFS_* flags.
--=20
2.44.GIT


--BOWB50Cm7PLQAh97
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYBS9YACgkQVbJhu7ck
PpQXNxAAgZPxLRBFvb0KuR6LLfkc8CISiK7699/yEVFn6Z0kngZwJ1vqrVo9dE2r
dpQMkj/Hy6rj6lqX0EX3VoBGVOA33kDDoWDDWZjwSIwJvLZG+a3BC0YRN0/UopOu
Z/F/3WgB4LUOZFlZDJ5AbtPUu+2NwvyFKhj0bwAJK9WcYeuHIl+jh+MCNMKHjrfE
QzTZcxE63Kcn2t+qMBEUqvIdeo2L84NseFX+uAKgAfECvM0MTsUZIznArESqKIva
tuFdcJtkyaVSv9BEkkq7zNbM3mWms7R9bLP+XTVjM2UKHDXtZyp7Pcestqm3VIhz
t96oGTXr5+cxDSoarBgdNjbddUDGKxRnUza2Ri+qoC1NNNNdsMQHMhrq4SFXkke7
SXcc45+11DkdoWD7Nc+iXlCKCh6jJmCpXSQ0dTH07ZPU59ny+kp+R+vb/uHr4xbW
l63j2A060HnsPtDGV3WZKdcL72GDJTdzPayeqSgE/jWpeYv/zMBRUZN98tpvLfXc
19oiOnlx7hXrN5eHqNmuriropiIsIswJzWv6bPzdfNl0ng84+m0JGnHaCbSwoHUn
e5hPiRG4sHLgUzPvSLttJKeOeiy4+2bwVSPcHpelfDSI/VyEn9jVFcllv5pfaTMo
NA6v1An0isTEbWAmvREMIjL/ZOTRIXEQ5HHCpFUYM6LwpSkTG/4=
=paSQ
-----END PGP SIGNATURE-----

--BOWB50Cm7PLQAh97--
