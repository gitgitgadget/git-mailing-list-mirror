Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF5824A4
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407580; cv=none; b=GsREw0KVGnIF/SNBIXvWBhH9mwSN9LIWV6LzHX4qgWu2Um0HX6gsCTy68zesMcixu7hY4nMMxiQJ1yM6aYeQfcS9WbiK2TlbuqqO2uIEek9YUfdSwHVYFPV6l+Liqp4mxoXAOGAaLgkgSNaPTyXUeyKDrY27llXMzQ5A95U2nHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407580; c=relaxed/simple;
	bh=3k/7iMPF1f9+k4pDvNwcbz2m5T0uh0PLyG4A29r5IF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsnlnGsvtHF8nv9gDeNjbX9igh17g61CCOIIVoP2yieIGfWCBUZZYTJjOXQNRSrm5Brap6U8pSlTsm6C8di3Nt1T0as4081wxyoFStWL8zl7JMT9YSyUDE6wbhC//Thjz+XLn+U4GW1qF2im/5Hijh6YBRk3C+zQhMY96SvctQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dMGBG/qT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RDBwtrom; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dMGBG/qT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RDBwtrom"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 1156018000C2;
	Mon,  3 Jun 2024 05:39:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 05:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717407577; x=1717493977; bh=LSrOZfgj6z
	9FDaJib72kYTa3RB30tyQH6pziu1ZXObg=; b=dMGBG/qTUYoOIM3pev+WpUchzI
	5suhgBrnktI963/NfbRMG9/MvitODIw32csMUFx4JIJfP1GMFEsvjnslDgeL1+qw
	Xg1h8iYz8JRYdOJUrHr6TAguNvpRtyyKw3CcvhzZdbXIUXvZ0N/xAxkvoNX0XETS
	i49GMSnpOHwTBG1ipT6jmjN31ErsIN4lgzIN7q9Zc3GyrI9INhdAEqsvAF++uBeP
	894K5GvJww+DZPThxtNW2NsVq66UFZ7CMuVZGmMynevI2DO3rDDHQcF9kZb0LD3o
	deefWtsy2GxEm3rNLgLdhOZnmt+B5pCrb4GeKlHBqdjGpjrvBgJXB9xRV7Ew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717407577; x=1717493977; bh=LSrOZfgj6z9FDaJib72kYTa3RB30
	tyQH6pziu1ZXObg=; b=RDBwtromx9fojDWn/cTKrpSd2y2jsVzUw3cask8XxRBm
	gSYyVMouaf5WMXqn0SmrNNNbmnexYHI28El4f+HkVF4tX95MoPjqFSxxJezzZPR3
	aSr9KjZsSIq+o7Iy2oibWggdHku9EZkRCgNu63Rr7nMjNzEja43xfWdXTRX7aDgE
	tfK/sCMgWs5ejvF+PF0QEiq9SywHCsJZBplpgolGCFHfmkvqY48rSYLkEDEwLMOK
	5VFev9GhAtAdKyV6uQgzzyc4E68shKdpsGdq5pEpyTD+C6cDIQQBwJK+3HMxOyPZ
	wcKhl1K1wwpenpcYbvQ9KTiBLsmjh+VVfLm+jO+p+g==
X-ME-Sender: <xms:WY9dZtgVfvUNNQp4y4e5IKdmc74p6ABnNkusbPSxPToM8siwgwjkbw>
    <xme:WY9dZiB5ZYnpSC-HJnz4AMG2KwceYbsTjSv17FXy18kB6ZaTXEOz56eZXv6RpXrF6
    rMltHlmcGl-PKkW8g>
X-ME-Received: <xmr:WY9dZtGq5wskuGM2NgTo-QYSwGOROxmWPAukQFCH4FZmqMv4UlgrLENDNmQ17LQffJzBPWDgT8ypniaKE9swX0oyYa9hwstQb5Hk5nwIYWJBQqfE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:WY9dZiTtqjButWj0OPcNz2ml6P5TswL2d9n-zHYxnw09ueT4TQ_51w>
    <xmx:WY9dZqwUSVtZLQG2bWMur7FzZFKb4cbcihoKNb_KJIXXTtRAiA3KdQ>
    <xmx:WY9dZo7xJj7srxi-RDY8SaHGyOMZ7-79zA12Jyw0U5r0xn92Y3-vGw>
    <xmx:WY9dZvz-H7ncWmy-qVPPmB8J-aoa3n1-_zhkGEeWUCSB-1y-a1ufIA>
    <xmx:WY9dZu-6OjR3JJ5jRGqD2JNovxLXEe-sGpCchOXmdTl4rM6_PxrQgVnS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 05:39:36 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id cd3f42a8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 09:39:11 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:39:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 08/27] line-log: stop assigning string constant to file
 parent buffer
Message-ID: <cc8fa1896d4b49be36495456dd4ebd4544c6b0dd.1717402403.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717402403.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oV/hPAdJ4fS9HyJX"
Content-Disposition: inline
In-Reply-To: <cover.1717402403.git.ps@pks.im>


--oV/hPAdJ4fS9HyJX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Stop assigning a string constant to the file parent buffer and instead
assign an allocated string. While the code is fine in practice, it will
break once we compile with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/line-log.c b/line-log.c
index 8ff6ccb772..bd3e663c24 100644
--- a/line-log.c
+++ b/line-log.c
@@ -1032,6 +1032,7 @@ static int process_diff_filepair(struct rev_info *rev,
 	struct range_set tmp;
 	struct diff_ranges diff;
 	mmfile_t file_parent, file_target;
+	char *parent_data_to_free =3D NULL;
=20
 	assert(pair->two->path);
 	while (rg) {
@@ -1056,7 +1057,7 @@ static int process_diff_filepair(struct rev_info *rev,
 		file_parent.ptr =3D pair->one->data;
 		file_parent.size =3D pair->one->size;
 	} else {
-		file_parent.ptr =3D "";
+		file_parent.ptr =3D parent_data_to_free =3D xstrdup("");
 		file_parent.size =3D 0;
 	}
=20
@@ -1075,6 +1076,7 @@ static int process_diff_filepair(struct rev_info *rev,
=20
 	diff_ranges_release(&diff);
=20
+	free(parent_data_to_free);
 	return ((*diff_out)->parent.nr > 0);
 }
=20
--=20
2.45.1.410.g58bac47f8e.dirty


--oV/hPAdJ4fS9HyJX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdj1UACgkQVbJhu7ck
PpSJ0w//TMkLI7H0TrVczq2CobmppYOn1VqVRgUdDkE9RZTHhrV5cY6z4zwcAeOW
iApV58dYR0HJwg8Uy6/h24wjnQmWtzZq2SbNaqsUrq5MV27TYorStUQrVgQqrX3n
IxOoDHosMFrIRRmnohshaRAc8wsqdukbLAjyMwEdOVe4/wpds9Mm5jVQzw/RYwJa
7EB5ygd1BYgEKld0gURz6sGm9bsbyL642kFIPQVedmWtyJokLOEYAYBBLlS5wtE+
KsCFnuzgVmV95/uOoGW6/FKovPm+zDpk4IJKhhZHmZSa53fxPoFKwij/kDFxNMe3
HdOfpQlp9vciItAlOt53FEAGvuegLnNK+OcEmuWH+ftnWUzmV9dx1yzNuJKrwIdB
IszRPG7j6qiN5R0/G5OGZf+LfZYNwx2wqPKG7+bfFMIbgpSvhnShwmHJzuATzuF7
zCQqTHonv90TCYW1PeFVsro08YgDPdatqxVlghDnzFBLZwieQRsmclRy8YsMchLu
dIYFh1A4Lr0TXQd1VVhHLZj1OJgk++cKUAFHmBCakpFHfnq0SZyN/GL8GVTb5FFo
wL1XoAYFeG2/TeDh6q2oZCz5+Sdpnyupk6/onMUvCzN49pwqx68bkkXT0A4PpwRa
PsbX763WZ5y1OzRp2dhWx2bNgokJwLpNce1BZUus2eA7EX3pCiw=
=UrOL
-----END PGP SIGNATURE-----

--oV/hPAdJ4fS9HyJX--
