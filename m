Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C93BBE5
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 10:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722508813; cv=none; b=BLc6TAJEwyucpbqJ02+rXMc7Agmcy0FCPJ+8M/wD/s1P8TXIHf4877y5ymWEDfMAafUDaW66CqugqsmFcAulga7bMDvW/meHEMALpLktDKLQpbUfD4BeiJJrBRxDbZKbPooEWl2go8Z8NW9ODfhyBtgxO31UpecRQn9MsxaE9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722508813; c=relaxed/simple;
	bh=IKITCKsjskzBqFnZjBot6MSjQLu7F8ZLxJByBnNybf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUXnZfS+pnwdaunxyQRWT99gFJl6U6eUibISPbnvaQwZK+03bPkLu7l+x+1K4odixvs3HKhAMA4Li9xgQt3ZXhtxHPkBvoGqdWWAzFKx4i0pk+XrQlQ91r8/S01iFlAnsotpJYeLywoZa96jXPWN57d/5QJr8VF2hdgSUGjwyfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RWkYJF/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FvXzidqb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RWkYJF/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FvXzidqb"
Received: from compute8.internal (compute8.nyi.internal [10.202.2.227])
	by mailfout.nyi.internal (Postfix) with ESMTP id C2D9C1388049;
	Thu,  1 Aug 2024 06:40:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute8.internal (MEProxy); Thu, 01 Aug 2024 06:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722508810; x=1722595210; bh=JU25/SsTIp
	SAslIaW7lgh6M5OOzhHTwL1rRX/ojlVmQ=; b=RWkYJF/AsciZE+k52mwVVsPPZD
	pZqjuO2DRzO38ZuLfUdK5+aKZTLi2+RZPYmPku3waShEvsQKL33BefxwBbVineNc
	0iFuTjAUFjT0Fsu0279e720v8FsbXwqeilb6zDX3feRlM8txMERLSvt2goZ30AL5
	r0hrmoLXwiVHTRbDvlmQ3ULfRWy7wTvBkOYChrnt6UauMBeKsmDXfNDD3o+t5Wvm
	7ycHJoHScs5ilH8xPRITf9t19XQwxIQ3w9fXX61N7nZ2OrZ4GWMDAhCtKPkj/Atl
	kn3GA+GG1tPct3vO2OlT/vdqcSo1IxQn8j7BMeEGuP6u4XOKVU4cj2bnvewA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722508810; x=1722595210; bh=JU25/SsTIpSAslIaW7lgh6M5OOzh
	HTwL1rRX/ojlVmQ=; b=FvXzidqbBUED0zXFZpxnp8AXq5wU3RN74hRmXZfYtc7x
	P/VvrGA0h/KpuPsx/CaWxrcxWpPQJm1S4ExvSxuBLqpIVcCekqGLTt3nFzhOQyoz
	CKY5Xvu4cCjY+QRjbF6bqeBKCbBB4K1LZJ18fCE64dIljvSKkr/RwwQezF6ZD+RJ
	69GstoD9IwqbbFRgD7kJ5z8BhJsDJ4a5jcqA4/VZrFzD0xAPqGBnd8Z/YYnFD7jS
	Xccr2asufeODULaSjea6iUlTGVU3WMq2ZPAs+uIDY/niwsuxr4VmyOflEcvWvKc9
	tVgm9s8Tt2edmhfMjJRqMEWPMsYBwRAzHY05tJiWiw==
X-ME-Sender: <xms:CmarZnhGn5nD16Zo8ju_hLsj5m5ndSC8G5nwCoeJP34fnGFY_x_PoQ>
    <xme:CmarZkDtttCpD5FUA2BZm8nNihXdTNjfwKqhKd4v_nNLPaxbN72Z-sGlb1vFzn6ZP
    KSRcW9NZNPzkbw58g>
X-ME-Received: <xmr:CmarZnHcamXfJA0peZYVmWHuvrNj9E8GvUVgf9__lOJvorW6VYe_JOjwuUhd4vYQFW1HNREg8_4AimRlzp7JxQWXsHUdSmmZZnFjaad1dQ6y5RA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeekgdeftdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:CmarZkTOnKuO1LvtI4bTedlxttryXPwKdRoZXAMUkyXGtIG64ZJcZA>
    <xmx:CmarZkyvCE6660XD8ijhU--Ck-nCsM55xyzW4ADsTAlzGdwV-sildQ>
    <xmx:CmarZq6HJwoLQJul4wDG40Gdg9eB1Vn33-B3xnX7s4eB21AHsDYvgg>
    <xmx:CmarZpyqwEFW1ypXF3TxW1rvdUplYs_A01MrAx7_F5hrMb0E1tnSDw>
    <xmx:CmarZjosEjkm7CSXnDhkQmp90_r9LQcuPjGr_tmyED7vnr030j2cLJOZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Aug 2024 06:40:09 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 874eed28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Aug 2024 10:38:38 +0000 (UTC)
Date: Thu, 1 Aug 2024 12:40:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UnViw6lu?= Justo <rjusto@gmail.com>
Subject: [PATCH v2 10/24] builtin/remote: fix leaking strings in `branch_list`
Message-ID: <2e3f76b428a0304d6e638dc4b8ff575dbd365691.1722499961.git.ps@pks.im>
References: <cover.1721995576.git.ps@pks.im>
 <cover.1722499961.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8l7Sk6K90lSMGj1E"
Content-Disposition: inline
In-Reply-To: <cover.1722499961.git.ps@pks.im>


--8l7Sk6K90lSMGj1E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct string_list branch_list` is declared as `NODUP`, which makes
it not copy strings inserted into it. This causes memory leaks though,
as this means it also won't be responsible for _freeing_ inserted
strings. Thus, every branch we add to this will leak.

Fix this by marking the list as `DUP` instead and free the local copy we
have of the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 08292498bd..303da7f73f 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -258,7 +258,7 @@ struct branch_info {
 	char *push_remote_name;
 };
=20
-static struct string_list branch_list =3D STRING_LIST_INIT_NODUP;
+static struct string_list branch_list =3D STRING_LIST_INIT_DUP;
=20
 static const char *abbrev_ref(const char *name, const char *prefix)
 {
@@ -292,8 +292,8 @@ static int config_read_branches(const char *key, const =
char *value,
 		type =3D PUSH_REMOTE;
 	else
 		return 0;
-	name =3D xmemdupz(key, key_len);
=20
+	name =3D xmemdupz(key, key_len);
 	item =3D string_list_insert(&branch_list, name);
=20
 	if (!item->util)
@@ -337,6 +337,7 @@ static int config_read_branches(const char *key, const =
char *value,
 		BUG("unexpected type=3D%d", type);
 	}
=20
+	free(name);
 	return 0;
 }
=20
--=20
2.46.0.dirty


--8l7Sk6K90lSMGj1E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmarZgYACgkQVbJhu7ck
PpR9gQ//QFv2WiQUWE14u5LW9Vf1TibJWKtKaSGZ7FNBAtxCO5qSwC4NHUx1jKH2
N+fgqkVADJ99AdMRwdw67VbZRW3pNnaf8FBpx0fgxkDisb5EeTef1cnhAmTCG+zb
OZYiGXHVioWmYUM7+TApXK5SLwnuArP1VJjR5Pfq7ZvqO5ZAdWs1Ah9mV86D+NCR
7VWd0UompNLYJUV73krF0fyBvqy35rWVi/hXW8rE2LVrP8S88oV71piew7jVuu3t
mBz+WZ8pa7UmruXjOnJpVwN9eaGRmHaW9yu6ptT42VuTK1bPbctNVLWJXLaPxun5
Yq1keNAtOEOv4DiF11er4Ee5DYQJ80EYf0gFTw/iROpuNlO/xizJ3ewMK+E0GSoM
iOhL0V3Vj3rJOQi6G1YcgisE2TGSFhkaOWFUXpHU+F8+IqrK/wxKezq82w7oyoqa
bTLJbrL8Sp3O/uV6a8vgjQla4ZyvI/wpXI88DAsV2ydDdG127qsXMNfTw0IYKA7Y
4uVdN8DF3xrhFOqXH8Aynkv85smwccK/lwvBmIp20+jGMZV/yx0drLmk4lGMe+cy
V7HzxDGanE4ECz9AM7whWqEM3TG0P3kL0kEw+WpQ5eO0V/UdeyIyIHJBXuS3IuI5
yJJiXjO07ZXElmFIjxpILuR+MBJp8+2uoZiny5FlhEfgfUJBxcU=
=Zp/H
-----END PGP SIGNATURE-----

--8l7Sk6K90lSMGj1E--
