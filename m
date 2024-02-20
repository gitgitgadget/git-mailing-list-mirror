Received: from wfhigh6-smtp.messagingengine.com (wfhigh6-smtp.messagingengine.com [64.147.123.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5771660DDE
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 09:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708419987; cv=none; b=GVsQzwWj+ODXgztYitkdGWBU1oQ1IKwj3iIpuxagPhg88vxT1qsaLJq5FLmSCBDVor5KqtiUwR4Y8Pm3MU9awcKWerVp/a/QNRdA+9qJU4Ebt0ugKz4yb8wrXWEnlIgSBfdqhN8cvsYn4xYz7ubjBLpeHazBkMswxRDdV8uBHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708419987; c=relaxed/simple;
	bh=n8mvr86/X/TM8SXaacNf9sp06VOrX9f2zcyKwrYbFCU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GRTYt0D9hTB0ahyg8HLDw1bw4MbTHVyfA/ipTBoF6k59dNINCRSQp8+EczqQwnN22Nn+2XstJEJhQoczI3wJwd//WFdZQmgDpQp2+PF5Nqh1ruZNI38noMJWwb44VI3rAQ5SlJCmTDwqghnuMXQrrRY29yN1pvupyAa9CL9JAp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I5RVAfbP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Y9RkeEZp; arc=none smtp.client-ip=64.147.123.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I5RVAfbP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Y9RkeEZp"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 777951800081;
	Tue, 20 Feb 2024 04:06:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 20 Feb 2024 04:06:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708419984; x=1708506384; bh=eQ2wBbEoqS
	dnK5w3KA0gu9hDkEB80ZxuU+7XcyxTeHs=; b=I5RVAfbPtOBoUzSxmLlpkV4qwu
	tSr3LVaGAY2s3Si2TAoUGtk93eP2ghtDTE7jP5D2+FmB9koVfN8Y/p4nwmdoM7Gg
	cjEevpyz3vhdpALHRD0UMVrfltR6sAXfQdezfS1OajBdtCyvZBg+kvWUL1txsmik
	fEexs1H+aj4qSV5wfRSfn3OybFNai2Nk3aCv1I7CLjJZKnBYd1JktX7++8Za9/hz
	3mzrYVNAmOc05KiiKB32J4DkjPu7s8cL61m0pJ6N1N80nclADJjXpVmZHFw0M/Z5
	HLHUz8hUint36jsUHi137QWbJN1vUNBLXaDnk9+rDsQtpJBv5Y93f1tXG4Ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708419984; x=1708506384; bh=eQ2wBbEoqSdnK5w3KA0gu9hDkEB8
	0ZxuU+7XcyxTeHs=; b=Y9RkeEZpro2LzW7HL79SIWenF2G1WdZ7+iqHgMPz8elh
	2Kd1TLDImPFbwxsgT7UKzmpLiCrBMpezt5S64pgE0J5vHqEEIfHKDQd+fTKKkIdt
	kFJ37uh9pLJ/r8ypK46q2Nv+8m0aoyxxNzKaRDJk+2ZpH+JCfoJa9NnwpFdPXo6Q
	g3AsxL2r8ypCbdwCeurDkvpoPHgQT12nLjMBNV9yKXPHKVYub0BSLKH6y0yGELTl
	8QnvZmMVZssKiyGh0kietWTNo73dtVXXa8m+6FHEOlZ5V5HSkUCkPOwaBJYGSkNa
	ZpVdm5y6sTJtx74lRZaWlgx18awqOj7KvZ/9OVol5g==
X-ME-Sender: <xms:kGvUZdpcEDmsz8qBjOnOgL8AaUzVJBZuEi5uAVckxx2aMjTPnE47Eg>
    <xme:kGvUZfqAUewidk0HsH2CGsHNyIbo3BDoVkuaLOun8m4UqE9Ui8Wcn2Gkg29m333cX
    S01qumv6xCOxCXwfA>
X-ME-Received: <xmr:kGvUZaPebIKCtnWuP3Tq2G_joDlt0GF7N9NOtTzXtgDGvfGf9Ouq2nqyKGm6j151hbMNv4QAHSk9PJWCOW8YMVYWen0uPoGBKJNtjlDAVI09Gg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedtucetufdoteggodetrfdotffvucfrrh
    hofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttd
    dvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdr
    ihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfe
    efgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhep
    mhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:kGvUZY6piDVqPnXCfBTIPbSaKXYrmA5bsC0lb5WBplyaHnQiHEpwLA>
    <xmx:kGvUZc6JsUKWkV7res-1IVEcTuNb5kkzRWe1PP26Of0ogpPmaPqUIQ>
    <xmx:kGvUZQhdNRb7DggMy2WJ47YgOOxCPt6qJ2kcc2b1pDbNouQm7v2mhQ>
    <xmx:kGvUZcHCCncKVChsl5ilDjoz-CP40MnlGeKGec4aU_jDnlpCe6hv3Xlc2lc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Feb 2024 04:06:24 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ec88437e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Feb 2024 09:02:21 +0000 (UTC)
Date: Tue, 20 Feb 2024 10:06:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 1/7] dir-iterator: pass name to
 `prepare_next_entry_data()` directly
Message-ID: <12de25dfe24d61ef54e0ccc0ebd4cc69d73da50c.1708418805.git.ps@pks.im>
References: <cover.1708353264.git.ps@pks.im>
 <cover.1708418805.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Tb5exPaatLJ59qHv"
Content-Disposition: inline
In-Reply-To: <cover.1708418805.git.ps@pks.im>


--Tb5exPaatLJ59qHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When adding the next directory entry for `struct dir_iterator` we pass
the complete `struct dirent *` to `prepare_next_entry_data()` even
though we only need the entry's name.

Refactor the code to pass in the name, only. This prepares for a
subsequent commit where we introduce the ability to iterate through
dir entries in an ordered manner.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir-iterator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dir-iterator.c b/dir-iterator.c
index 278b04243a..f58a97e089 100644
--- a/dir-iterator.c
+++ b/dir-iterator.c
@@ -94,15 +94,15 @@ static int pop_level(struct dir_iterator_int *iter)
=20
 /*
  * Populate iter->base with the necessary information on the next iteration
- * entry, represented by the given dirent de. Return 0 on success and -1
+ * entry, represented by the given name. Return 0 on success and -1
  * otherwise, setting errno accordingly.
  */
 static int prepare_next_entry_data(struct dir_iterator_int *iter,
-				   struct dirent *de)
+				   const char *name)
 {
 	int err, saved_errno;
=20
-	strbuf_addstr(&iter->base.path, de->d_name);
+	strbuf_addstr(&iter->base.path, name);
 	/*
 	 * We have to reset these because the path strbuf might have
 	 * been realloc()ed at the previous strbuf_addstr().
@@ -159,7 +159,7 @@ int dir_iterator_advance(struct dir_iterator *dir_itera=
tor)
 		if (is_dot_or_dotdot(de->d_name))
 			continue;
=20
-		if (prepare_next_entry_data(iter, de)) {
+		if (prepare_next_entry_data(iter, de->d_name)) {
 			if (errno !=3D ENOENT && iter->flags & DIR_ITERATOR_PEDANTIC)
 				goto error_out;
 			continue;
--=20
2.44.0-rc1


--Tb5exPaatLJ59qHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXUa40ACgkQVbJhu7ck
PpTVTg/9GEEDnbKZMpkhZEa9hdJn55cN60Jf90JL0ukQbmkGRGp/tFjIdieDyDHj
wFJq4XgPrgR8LdAbE/ydqIF75qCLExyNUQPeDzLliNMjOOmL1Dg7TVCALRTM/4eD
vfg+qy41R/z2kQeRwSiL9/PJVxY9HSk9DAcOXv2LESWqn4J5HTLQnZy4eoPz834Z
w8/f4N01zMlHEjRKXQNL3W4BO4D7bsSQpXdQY64LWG2+td+q0Xzq0DXQw4a+lIxx
WTNdbJr028i5EYk2ggP+5TYSCSxQB8ymPo7XQmuLvcZ+n1WAdjdYpQTnNZdILgMw
lFD7fsZnlzM1BqGmt0MGLtcs/w2ZenWcvvIM7NcaIlWwWVX6U2HuXeS4HjTnpmZI
Jipp93dCtnkwwCBhivz7PrwpXDLQ3LDK2GYzBMVbIUEWM6aoj9cb9Lfy8RL96vlv
eUrNAUIPq6NRIsB3WV6/3JM9zCJc8E1OVK6SML5DlSeLqA5/DH7YOZBv+4+qbrZ7
Fp0sxZSJuMnWTo2RuYU0VSCVhN9HZuKP5+iYzzNsYJNFx6ZCaE3KPThY5CoiuBEt
GytddOm6HvdqGgWudY8paGrt2vwmLsDNo2Q2STD1VqZ/ELIRcdFE+Ya0KjyfebUT
IUa7t7h22+ZEWhSYLwEOpjBwFlqinjMTEfaHu1GhVpzxRg7TgGA=
=MDx2
-----END PGP SIGNATURE-----

--Tb5exPaatLJ59qHv--
