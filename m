Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F2A85622
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 09:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717408031; cv=none; b=iMXSXPSB/9xhRUCJamq1xmTAYlLkLlCRZDgyWXemMsxQah1eGgEubW4LlrpkG0YF7tTjDXNKUkRj9P4ib2WTXhsOhafotxuLgI2++K7tciF6uFi0y0JBBJSoMIlev42Xj0uyKBazH5ovB23CVol2oziFYb6yj6UBeoJGZXO9fIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717408031; c=relaxed/simple;
	bh=kr45Qc6Y33+XzSlFkcuTedQv37BKI+nv1aIQzc9RN+A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AG8htbdX+9Rwkl8H0CGzHfzx6eubpE1cDy+bacMHgWMfHvoADtqaS0RyjGpDJRkmrs0l7CwlLCOvhX0Bl6IZ73mwsEsfLue25r6VKNDN1wNAdlirufAiTqWdvkRI94HIl69ksw0I7Ms58d22mOHJ5sCovOcqzgBl8rfYeWGiv5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UkuXl1Cw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OFJSGDXk; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UkuXl1Cw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OFJSGDXk"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfout.west.internal (Postfix) with ESMTP id C077B1C0008C
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 05:47:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 03 Jun 2024 05:47:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717408029; x=1717494429; bh=hevo73as9h
	WobDaO/WBICETqEM+zg7WEnjuRLdMv9IY=; b=UkuXl1CwuerktT8xAkGf3Uh6F/
	ARgtknBAptei0YzdYVboUn8fZQg/YM4ZHNYPukuqjRYEtGvQJh60GdJZuXV+HhlL
	bzhlajr9IqqqWXFtGzO3Jkw1KfDQc1nmc1rbAu+pBu7KFUuEjMY++yK1PH/5WBWv
	SCAgk8foIp2FdsMcIRt2Ce1rpoa8MQsD8JTYLEb/aaREVqyEbxl963vgoM+L4lwl
	smh9IHYCEGvkuZgIARlY/aN+KG1ZUHtk9LBdZpcx+o7zHwzKIGHzjY3Du0tikBfI
	HHn8tVVFDgLqWf7R8vIptWeSWcFQtQe4urXDt7ygh2zY1MKODTanLJ3Ynf+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717408029; x=1717494429; bh=hevo73as9hWobDaO/WBICETqEM+z
	g7WEnjuRLdMv9IY=; b=OFJSGDXkNir/0IB2siknh+pvOygmXkWGV3kdMO/EnJ0S
	1JMGZZmQej8PbHjt2L5+ZMN/FoJlAWuShlbqWGNTrpvKbIYBiBfpis9+auavCSVV
	pzyJ7mxOg4RzQC8jDEfi5mfgVIRiziydyaYhBCG2MWmCsM6XnGSLCP9yKm6Zqqsk
	e6zKwFHxrDD3HGhzQufoNwXY36Y1Tb6nmlgbyZwGBhYZxV1adfebITqNqnuqlmEW
	oeKKkdx0wQLiJKnlFVXOHk/sm3GhyLUnoeaRfuHeA16RBntldsT1vxclCDwU1jgq
	Gc3HkWFsHVlGY1ixpIDIR31bZDaDMQfgvcpAfe2OVg==
X-ME-Sender: <xms:HZFdZlZ6YnXnkBYkbBRCNB3KtulfP0njbWimv1KBBopT5MNDSDhHMw>
    <xme:HZFdZsZ2FRgtE-M33Fey8Si9DZXsOQ4xuhFTCDK9kbsrGBvNtYbx0bc6-6ffc9-ay
    BOTQOy9yQYyC3pVMA>
X-ME-Received: <xmr:HZFdZn_OwbPL2Z3DgJu8izvJYAqzHphpX1NqP9K4iCsc9CpnDB-ljlKNtBm5qMRkvsz7x-_59sjaIIrtDtVrDmHGf_Zk_uNrgz70bHQo91DG2xmK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelvddgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:HZFdZjpyAm0gd6y1nYs30BT-YsQcDUrfCXq7qg2YlNwFDcs-tuTGnA>
    <xmx:HZFdZgqDZnKj4ZKu1GbcohTTYMpgRDQZbNmlsbAch63Hovbzo0C8Dw>
    <xmx:HZFdZpRjf8mZ-_vBT33fBhufj-1p8m6BUvmeeDCk2bXHqzcTdJ0xdg>
    <xmx:HZFdZorvwdUriKXBHpLi2IIXi0_gDMTPVnMZP7vvRgRM_Q-EexXQYQ>
    <xmx:HZFdZtDK-zW0VOYPzJyRNaltdiMoUZentT3JzFeodQ6o5eMS69oNnaZz>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 3 Jun 2024 05:47:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 324b092e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 3 Jun 2024 09:46:44 +0000 (UTC)
Date: Mon, 3 Jun 2024 11:47:06 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 09/29] builtin/rev-list: fix leaking bitmap index when
 calculating disk usage
Message-ID: <5e01c39e357bd3f06c1312c27b1a59cd9f741fda.1717402439.git.ps@pks.im>
References: <cover.1717402439.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SokaezriR3e61kmF"
Content-Disposition: inline
In-Reply-To: <cover.1717402439.git.ps@pks.im>


--SokaezriR3e61kmF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

git-rev-list(1) can speed up its object size calculations for reachable
objects via a bitmap walk, if there is any bitmap. This is done in
`try_bitmap_disk_usage()`, which tries to optimistically load the bitmap
and then use it, if available. It never frees it though, leading to a
memory leak. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/rev-list.c     | 2 ++
 t/t6115-rev-list-du.sh | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 77803727e0..97d077a994 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -508,6 +508,8 @@ static int try_bitmap_disk_usage(struct rev_info *revs,
=20
 	size_from_bitmap =3D get_disk_usage_from_bitmap(bitmap_git, revs);
 	print_disk_usage(size_from_bitmap);
+
+	free_bitmap_index(bitmap_git);
 	return 0;
 }
=20
diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index c0cfda62fa..21c4a211b1 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
=20
 test_description=3D'basic tests of rev-list --disk-usage'
+
+TEST_PASSES_SANITIZE_LEAK=3Dtrue
 . ./test-lib.sh
=20
 # we want a mix of reachable and unreachable, as well as
--=20
2.45.1.410.g58bac47f8e.dirty


--SokaezriR3e61kmF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdkRkACgkQVbJhu7ck
PpT5sRAAn3GMd9F6jNIfu89jWN6IVuiusGuc35qsArIPOPl25EMe2a6WAVAQzS3B
xchNPLfHvyEBdPEj3PMPACxtihV/fFRI6V6wshv1okAKLySlRSe6135tKCntB3uG
PcoVZyu0DxNWg4HAcYMuN5kRrnaO5ljmRuSMM/DRF7JStIDzagtymdCdhbrumA1O
LzfvOg8fDD12+ZFezMbemscXRyQXxmH6hy/gcbHKNSAZLlh8Lhf3ZvgA7EYqz2yg
Fviu8a/HnvQKiXzjd2nCj4b1GJ/0I+qNFLi8gIW5RAk4vrakLK9n0/E6MrYuqn4L
WiyvBu409G7+DdNj5meRdNxeY1kt1pdX5lg0qm2Ah51uBcKsqcD1W+y2dGzSI3dX
48WHW34dUii2e14lRR1qVeyhA1rjsrTWSqRlWt1ClOK9idIZnSv7YJ4BkjQGwxje
O+Cd74C+tLI7xr6Gd9GnPq5q6gI4zwHYLeIpnFZsNrAo1ZrKmJflZOwXsb9lfnkm
wVAWg+TVIF+RXb6l72wOTXWTAHRB01lmoyBZB71TZnDH7HkdqXhVlosdDfToEzwR
ibHCZ0grfTYc3nkJtFDo1W6Usi3KK+gXJautxh35xQaKA4uNT5j5RmvRz3gkiHvJ
EA1GGGghbogG0x0o3/XOkCpqoCeHqvc9gXivAB2Ca3nvhtAMUPU=
=uI25
-----END PGP SIGNATURE-----

--SokaezriR3e61kmF--
