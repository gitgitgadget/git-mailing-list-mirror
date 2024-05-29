Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453D4C70
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986715; cv=none; b=k2MG7Uz9DcKMDo6jI5RU/zatwbkscox6/ojaW/+jah7NK7I2brm2mkBS1ohyP2EqhKmpABuDXjGDFer3eu/a4ksApOCAq5W/vTqXgBLVbST68HlqqK6ucPXP3WUP0wJz24UtpYs8DVtZSX01GPIDIZ0nD7bu4qs4To6E3eO6XpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986715; c=relaxed/simple;
	bh=mooNOdW8hzdm+jm2Z2ntufcUxqvWvPYR/7mSwjnKfP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yu7Lt5kMLsnj1QRyw+bPgkRRpKcY8EYQ64ZKN84hxzNZm3AtQzNpFNWZHZDlucRlap8nkHK88btYny2hXh4Rhr3OFve84Tc5GmbIJZAslxwRXBjL1Va5Qr+y5/AZWsdApBrK69XdIuA0lm1porGlPfSYkI0A/qzesjtU+PavhsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iss3F0qV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XjkZYcpF; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iss3F0qV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XjkZYcpF"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 55C031C000BF;
	Wed, 29 May 2024 08:45:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 29 May 2024 08:45:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986712; x=1717073112; bh=Ur8bXUargy
	EXX3WA/QlCkr1k6V29ZzNUiRdU2z6ZtRg=; b=iss3F0qVoCmhjO8Ql28tFyb7Mu
	MIdvsDupfLw56JmBvTrIskzCJnU3HDWMdJ3miOjQ4DjSjuYpP4V/hqY/xJ1u48Va
	KKvhgGNotaww7Sa2wkGQHbe9qy93yWxA0LRMDO0xC64BVHoZRdqJhiahBXzQyVld
	x2DAQYrbbjkRrquFRvxYnxFhRznxflQmh49T3mgfc42GExjECJDuvbZ+m519XYOT
	hY5m4K5nT8HQSE2Fq/Ffpy2CvGiduAVZcYKGBPgrFDvLuU7sJpt8YwPvCT7i7UAA
	Mf3MvTNy26pQBfLkpa4EVACGdhWzrCtr2LajyOJkmw49gQPMJYKg448Oih1w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986712; x=1717073112; bh=Ur8bXUargyEXX3WA/QlCkr1k6V29
	ZzNUiRdU2z6ZtRg=; b=XjkZYcpF2XaB8yJtO+e5HvvDYtKehgUK9j+NGVh6QAa/
	8OGpmJgb4cKLwOeum9pFerEPAh1tzBjJWY0nOcEsJyERgBmDyETlN38QxSFhQzHi
	+1F1ZNJeHsE6g8AZyhGOnanD/Ys20N9YRumnYQQqz+RWePjZa9tVsg7CERyZEAwn
	bIaxgkEthMQMPL91kWKEOrOPFLM6YhSO4gk4Pl6dnnrO7BbLiYck95mJCZOmFB5Z
	Wj3d7A90j1W4FhZMqkIDOLZ76ZHJHTDGPwEggxFp++V1T/f2QT/tNkpJZMOsgITn
	WTsJfM2hZ3PJegSIHl/mxnnGN3evgq+J12UnCFsVlQ==
X-ME-Sender: <xms:WCNXZl7OjRFoLgak5okqocqFyviRWgRpgDeS7wjLM_hcrECEwW55VQ>
    <xme:WCNXZi5uZ-tR410z-1uANOqsYaP_uw58O6g-AEv1_UbZ1ieGDW3fEmo9GLLSXK7Vw
    y7hj1SxwCjIaGnhuA>
X-ME-Received: <xmr:WCNXZseVz5X05h7G1jE5D1DPzzl5e32ryz-8pWFJCmgWFG5nQ7NyftycvOr6W1Y858RipNJiMxyl9lFJ0zVa08VWwIPP7umUEzN-mePWyfeigT25>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WCNXZuL7SjRfyixzvu2riUb32Hkz_qqm3XkO8XUpCWMe-W6lweaFkg>
    <xmx:WCNXZpIP1g6fdCQwsyjzhfcHCA9XxJTo1SxgevD9P_L6xQCPXnHnmg>
    <xmx:WCNXZnxpoBoYO9J8lp7Wms-4x24q2wuuuQ1HI8bImSSm-loMOfeMQw>
    <xmx:WCNXZlLj_60Jcsk02y_LcWu_fr89lamedTCNvYDIxZU0-9H_PEvOgA>
    <xmx:WCNXZgW9KIggJI2emDj3nv18h1Y0VyeqFyKB8_r8TY_b77bkLZTZkD3Z>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:45:11 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3b8e7c06 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:57 +0000 (UTC)
Date: Wed, 29 May 2024 14:45:09 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 14/19] mailmap: always store allocated strings in mailmap blob
Message-ID: <0e393fa6a708fc29fe666b75d89ed66cc69ec634.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UHGNiJ5QIhYrOgot"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--UHGNiJ5QIhYrOgot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Same as with the preceding commit, the `git_mailmap_blob` may sometimes
contain an allocated string and sometimes it may contain a string
constant. This is risky and can easily lead to bugs in case the variable
is getting re-assigned, where the code may then try to free the previous
value to avoid memory leaks.

Safeguard the code by always storing allocated strings in the variable.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 mailmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mailmap.c b/mailmap.c
index b2efe29b3d..3d1e092fef 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -216,7 +216,7 @@ int read_mailmap(struct string_list *map)
 	map->cmp =3D namemap_cmp;
=20
 	if (!git_mailmap_blob && is_bare_repository())
-		git_mailmap_blob =3D "HEAD:.mailmap";
+		git_mailmap_blob =3D xstrdup("HEAD:.mailmap");
=20
 	if (!startup_info->have_repository || !is_bare_repository())
 		err |=3D read_mailmap_file(map, ".mailmap",
--=20
2.45.1.313.g3a57aa566a.dirty


--UHGNiJ5QIhYrOgot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXI1QACgkQVbJhu7ck
PpS5JQ//ZVa0d3Lm7MyfKRHsZ6ygRsee9m0IC4ghkAydTLve+d6TaT+s2CtxwnCq
KNJrEWtRYcrGJz8yrLLNgHOKmdAAn5S2VqHIV4GouCL95tmCP3WvnmBCtJ4W5Tih
uZneS/9xfr9LKJ1WGjXVTDwHZGvhkLuSgMetow7MYojhDuL6hkn692jmsZFEydRW
NtWdQIMx9QYjY7Z2YAiuVfGCTteKfMOkReC2MWXHLtnSO0VUGljNfIIdpcVRaqMZ
3LCTxTGapfs0uSgGN90TM5C0xWzEvIi0EWKCVHkHN7AdZPnY2vaHgAvgXbEm89ol
sDPaQbpRmnTJYWAjVax1gHKp1aS6I1wLglSbg91aW43wR85EtVM3CB1DYzkIxmj1
dVbLGKAUpkP7ZYBD5dJA5EmlWGwz22dGtHrVZohQUFDCQRO6xG+zysdvNteeD9RD
RV/2fFLQLlpuCXO8Ia3ZryKzpyimpyNTr//WYgi/36L4Utt3WV2u58QDIQXz0Lpi
zq1QQwGRyz8ojPohBzjRihoNzeF3VVLh5VzXu390eu67rlK9Z3e6nloRqaQ9AbzE
pOsXnC+04dwbUPv6ouTzmDMSE4YusOJ9wlIQP7a62YBffXhq5e76XgMdUu31NxUQ
DPNE6rnQoSMEL01sIpDdWGzTSswpUHRR5+8aHk5hBBrJ6qcODLA=
=HHLE
-----END PGP SIGNATURE-----

--UHGNiJ5QIhYrOgot--
