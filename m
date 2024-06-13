Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC53137901
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718259256; cv=none; b=Y8APdE8QSYfHWYa6t9G2cefET6mruYAJqKOaZfBSxdryw4j0FC09zgGRvxe9RN0FdWPU+jt2W718bVAdfqbzlo1jgtWqYG4fNKZoSA0/KMs6RmrFruy68jaZtEysbQRLW9jeRtODF6+da+pj6p3/wWDF7YcB/a9jk1YfSTIyyMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718259256; c=relaxed/simple;
	bh=BGY2EiQlwh0uMFxs4RDOg3G08jVoSqHmncDK2xP9a48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fvl23qLgc1U228/Lc+HNTQzSIJeZP/tjCTacRXCHA1IzURZsUv627qOa/N5WvadEYXQTtnCf50/1xYrt5pZFgK1CFmuK3XjX6b7oyQkgKVuxRRbflz6FJWEh8YKT7tV2nmAwHRTpiLA657YDVsI7xSaOSmFjSBuJW7DvOae2AEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bBPrCS7k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aHME4iKu; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bBPrCS7k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aHME4iKu"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfout.west.internal (Postfix) with ESMTP id 64EA51C000E6;
	Thu, 13 Jun 2024 02:14:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 13 Jun 2024 02:14:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718259254; x=1718345654; bh=Lv0c4nCDcz
	Xh1PgYtSPwVFSBzycj7q15Qx0hYMJTQ2E=; b=bBPrCS7kCY/S6rMniyqEJ7ZHaJ
	PZKlqajUvB4RcmjHHi2I5c28aEbmEStgwh3Hq7W7wC7Ub5pGY6jYwsZBrwYOxKTO
	+VIxliHYHkP9yFBJappEzVhKHigVJBmb79nQNXqvJWAH9aUgcEg7AGMzIne4vSPd
	NZ2X8lte56KA1b6VCtQqNPELu+xbKzoc0JmCeosrew0Zh4z2tbXJ+ep5sC4vX0kk
	T94hmG40Ku02vuoioof+uQk6fzuVl3qLy4wWD3IUTs9lOXYyevuoSYBbH4s4ESbb
	PBgkS/RZI1iXMJqB28frmY9CWJqbzmOJ/zD1HYT3x88+1x5yffUwCe6uvHNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718259254; x=1718345654; bh=Lv0c4nCDczXh1PgYtSPwVFSBzycj
	7q15Qx0hYMJTQ2E=; b=aHME4iKuKq9avAD4kW5FFTJCFRfzcSgMH8emU4AsIHGR
	vPLOAFVfs8DyTumICoaPzPHoBN+m5s7QLMZxdyQv0FEKV+tBYjgXy6UDHdDObK9C
	I6OF0WvFWcmL5meVQEWQLH8uWRcvASdBVZuOXR7o0diAeaF2gHujU50KLqrBjTm1
	aI2VN0NfpWRGXqjVX757Z6nn+0HZNGwrg9U4ELWeMphFEZayzVcvf4UM5qWrneKJ
	2WQLwV7/nS799pL+54PXZbiAv5/ays4AhLITV8OyZtuZgV4n8g16owYj/EzoOhU1
	YgFP5eQZEQd6Lz2tLm3qp9GKq+ik7sVAA+7s+YxI+w==
X-ME-Sender: <xms:NY5qZjKowLnxlxrjZCxQ_paFRXpx8h7z5memZQhYEDI54X3NvsDaDw>
    <xme:NY5qZnKlMuDAEiHWSsZhFtsVSC0XMKgbzJpGA06KCIWCaHrwPDxfBAbMhj1wvZ-oD
    Tl6IWi0QVBt43BXdQ>
X-ME-Received: <xmr:NY5qZrs1rU6EISW4OAuMJrX7NsPGviikVXFt_KGbQMJ7-PIrLcY6HZnG8KF1K5f0IFCJYSCUlbc_-DpDx6NfZJs9JD-g6QFHJlVfPz14duf8xu22dAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduiedgjeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:NY5qZsZOTRUToSPUIzuPxMta1SWHoFQySFNx0R3chLXYGURugmRRKg>
    <xmx:NY5qZqYyfBXBrPK9IfX80jBa4zfcuE7dPgtv65CGYSqIccJE8IKXCQ>
    <xmx:NY5qZgBRUeHKhjcxe_SLgAv4rSvvU6M_6lbfyDyFcsmvaX1CHAkuPQ>
    <xmx:NY5qZoYOAx3TgDfSxv6wlUUKySkZl-0yamuV1IMd87n2UwMVWLTG-g>
    <xmx:No5qZqHWcidzqhwHrnNsVHaLmwZvQqJsooQROxQIsZhYruhUyCckh1uG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Jun 2024 02:14:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id fed97593 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Jun 2024 06:14:00 +0000 (UTC)
Date: Thu, 13 Jun 2024 08:14:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 10/20] refs: avoid include cycle with "repository.h"
Message-ID: <4492548209bde9e43ed01d012a3bfaadf9e2ab04.1718259125.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
 <cover.1718259125.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JGQcBtawgy6sG5Fz"
Content-Disposition: inline
In-Reply-To: <cover.1718259125.git.ps@pks.im>


--JGQcBtawgy6sG5Fz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There is an include cycle between "refs.h" and "repository.h" via
"commit.h", "object.h" and "hash.h". This has the effect that several
definitions of structs and enums will not be visible once we merge
"hash-ll.h" back into "hash.h" in the next commit.

The only reason that "repository.h" includes "refs.h" is the definition
of `enum ref_storage_format`. Move it into "repository.h" and have
"refs.h" include "repository.h" instead to fix the cycle.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs.h       | 8 +-------
 repository.h | 7 ++++++-
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/refs.h b/refs.h
index 76d25df4de..a9716e5d25 100644
--- a/refs.h
+++ b/refs.h
@@ -2,21 +2,15 @@
 #define REFS_H
=20
 #include "commit.h"
+#include "repository.h"
=20
 struct object_id;
 struct ref_store;
-struct repository;
 struct strbuf;
 struct string_list;
 struct string_list_item;
 struct worktree;
=20
-enum ref_storage_format {
-	REF_STORAGE_FORMAT_UNKNOWN,
-	REF_STORAGE_FORMAT_FILES,
-	REF_STORAGE_FORMAT_REFTABLE,
-};
-
 enum ref_storage_format ref_storage_format_by_name(const char *name);
 const char *ref_storage_format_to_name(enum ref_storage_format ref_storage=
_format);
=20
diff --git a/repository.h b/repository.h
index 29727edec6..6ce6826c26 100644
--- a/repository.h
+++ b/repository.h
@@ -1,7 +1,6 @@
 #ifndef REPOSITORY_H
 #define REPOSITORY_H
=20
-#include "refs.h"
 #include "strmap.h"
=20
 struct config_set;
@@ -27,6 +26,12 @@ enum fetch_negotiation_setting {
 	FETCH_NEGOTIATION_NOOP,
 };
=20
+enum ref_storage_format {
+	REF_STORAGE_FORMAT_UNKNOWN,
+	REF_STORAGE_FORMAT_FILES,
+	REF_STORAGE_FORMAT_REFTABLE,
+};
+
 struct repo_settings {
 	int initialized;
=20
--=20
2.45.2.457.g8d94cfb545.dirty


--JGQcBtawgy6sG5Fz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZqjjEACgkQVbJhu7ck
PpSJChAAn0kshhCAk8yzO76jlmGKtXFB0r4g23SFcFXtYLXBf7hrR93GyXEE8S9z
sDVg3k9bC9FHFSzt+Wmwv80SWIdN538dqmeOZ/7RDuDW87DLMB4gme4/jussa/6w
MTMVCC0ffcSt53G4q4but9snrtWOH0m5RzxHSKsgivfxPk0cCNoirzzk5o7HXfK+
hhbI85Pjlnv49sQl1aAWsGHuL1hr5L8pIWxupRs12SYieIEdknvsFaynANtRe95+
FlyJR2IMsj/ymRPhrFxcxZTSbl6IL5LtGdKc0ASRyBakEmr+d+Lw+CbAJ9/lOiDa
UVfLJbSC20ojSRHTUpOt9duJIfCEwv+8qJKZ2Cl4vWXrIkV9wB/TYwlbNeH0rWml
d8Ie/dChjLBeZvLly5VCdLuX4HQBNZJ9OR0Oen4Pxgog58LZvxO3QYwuOa+0j8w9
Agoymm7zleQQIzT3Gd601GKjQGQprStu2LUiePzaW++XmP0a8EbzC5O3zZx6kVBW
PVkP7pZLcM122FvsCb3uz3p29keflk1ggFMk7E8h+McCzFhTUjI6e1H2/LrNLgBg
yRvjABHfRvAemhOPAtCAcYK8T2Jv8kwV8UNmpOFKim3UdSXQCLEKE3mxbgq6o68g
/a7pN7WoWhJj6H79ju5XjHfDbJh0yBVkzHm21YNoY1OWrxU0g20=
=eRhl
-----END PGP SIGNATURE-----

--JGQcBtawgy6sG5Fz--
