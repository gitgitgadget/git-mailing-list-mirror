Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1A017C9FA
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718107104; cv=none; b=XLFh7b6R7M6mkbfzzFKzAl5VX5oEcHnTdCLynf5lqOvseoapgkmdo6a67dSVdsyMfg6BqRlzNdXoxsE1DjXfaub7gJ5WG53G5R4axxi6b3oygopJUAaOuwVwbhY8wqmgfC8adYdFmJi1v1QC/+TcRxYd2Mkife7cpoS3Atvz7Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718107104; c=relaxed/simple;
	bh=/YQ/5aQzZBl3wAtbGFX6weWXaQhflwWbxiD8Cneo1p8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgNUiBhYjTXCciqZhnqRUX6orqb7uvAXFJVvTd1bfpGE/EB4459vd4aezazkvv9LFERyvWmoeA9I0HmNUv2vH4owPI0yEkU3/I8RXK9AF6hMxkVwXTcGPACrlA+oiijRng6btsYyL5caaljpGUuJCMXPRK0RNLvkxG2p8cOcTlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GFJDfkuX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oCA3aQuB; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GFJDfkuX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oCA3aQuB"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.west.internal (Postfix) with ESMTP id 7AD851C000AF
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Tue, 11 Jun 2024 07:58:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1718107102; x=1718193502; bh=rMb/a//R08
	zonFAQDUteG96w9pv+wgcK2FbdPJRdhLk=; b=GFJDfkuXmufm3vonUMiztum2AW
	ea/6wgnv4/kpVCZyn1iInIbnAmscStAsAqurFuSYPqi8rnWAGsYLFn0o61lZ0Q1F
	KL1fmIYYth8RL5Tk4XQzZ4slYz5wcw9mgiUGjhBeVJu0pLH5V5swVlEJqwYZZXii
	xe8xPbBIssPqFff2Ce6sFvIzw6euTJBOmF0SupHrLXg+o2QhajYfnaJ870CVau4+
	hVoAY+YSr2M2MyP7VdDUp6MEyZYFzfkjWOtpaybj/wllBY8XKEwb+GVontZ8cMK4
	6SUtj23XjR0x7n6lIXk9MkUc2zTfYHo+Ek3hGt6+6+FY/HteRrqbRXqlyuwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1718107102; x=1718193502; bh=rMb/a//R08zonFAQDUteG96w9pv+
	wgcK2FbdPJRdhLk=; b=oCA3aQuBXHhtMfEbRLSca0VN+PaApfKXiEponKTXci4T
	lshz0RYSkWSO/UYLdFCDjj/CvbRge1ubCtYJg98y7SF1Hsl4OKdRGTy0inOxi0tP
	8rJOsyIP3S/10xTBYXtWAwOZhg+xu9OGW7FrH6M/Fk7a8IZmjbIo34b34YvmvPRY
	gi/ZnvMziwVGMiHPILKNB/1idYmeakytZmweQgO298voOEFUDVa+LWJLB8xxA5dK
	rsUoTO6VTEjcEAp1i2I7bpkr507fEETbM5gS7wq5Q62WxZKdnKU7hLz6U83bLxai
	6ny4PJMVHXJxJGdWhUKdRv/bvq+5UAuv9LnxKv14RQ==
X-ME-Sender: <xms:3TtoZmbgoOXhKqpkYE_HDQHDpWJMOPU69L9PXQ11Q9MrC-v5PZLz7g>
    <xme:3TtoZpZLGenHqa3mWos0aJdrHsMBLy7LtKmXRjlaHkHG4Y6AKXEIGyxJrPbyvZCNh
    q04AKRfd-g8fbGudw>
X-ME-Received: <xmr:3TtoZg9LVrPcyXYGU98Hkhc8CJZVNn62PD4wkXvJ9TGjUn20XefX--etq-vrwXAUuEWNR2MZHCopGSHlhKx11XpDDX5igFbH9SPK5tPDndSX-hs86krH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeduvddggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgepvdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:3TtoZorb5Ft1aOWNA0hLNnVFu2YpBKzVFrtbeocOIabTPkTmlXrRcg>
    <xmx:3TtoZho6KwkoQTMRFUG2IwjGg_D-d5dZkUQEKDqJW9cpe3N7cIohvQ>
    <xmx:3TtoZmS1eVpSzKXosHvTP3yqywY_CnsFk36O-p632WEk_f13vqrU3Q>
    <xmx:3TtoZhqll0GV8kKHSgcSNZlTa5hWfX4hL4ovduMNfdEUtlXPKMy68w>
    <xmx:3jtoZiAOJIkIRL45eUc80HZMzU1lvd3aKjWh6Dm3ikFpP8hcFywwXoMY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 11 Jun 2024 07:58:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 53da6f1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 11 Jun 2024 11:58:12 +0000 (UTC)
Date: Tue, 11 Jun 2024 13:58:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 10/21] refs: avoid include cycle with "repository.h"
Message-ID: <7e718c967a6c419cf1328d385b039654a58cea16.1718106285.git.ps@pks.im>
References: <cover.1718106284.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jfz2Vypj7J4n4LTF"
Content-Disposition: inline
In-Reply-To: <cover.1718106284.git.ps@pks.im>


--jfz2Vypj7J4n4LTF
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
2.45.2.436.gcd77e87115.dirty


--jfz2Vypj7J4n4LTF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZoO9oACgkQVbJhu7ck
PpQZuQ/+LpkJXJDOXbx4oxeQFpo5XKYOgvxAamYxXHuk3DUaWOPdVEtuPodcnizO
vJIs4LULF/lnJpaTdFNxvdrqQKPiNcu+8SM4PLUIaEFROQUwPyjhIcmGgn00NTBa
aU2x1aMHtueMkpLp2KwISrBkJPxH1dXnbiK6raZ1/hKAsEKDeDo44/0OI+5or8Xy
cPN0+AGA+Zva0dq7E7iZpzRcP3BH0s8t5Fyw1/QtDlzuX5LLP7BJco4fwP0FTMjo
DREztZk6WlAK+f30cWR4+PN8qYkX8aoJitCr6MKnWWSkJBbn2UTqDsGa9LpH8shA
j4Sdif2qytPXY4sqQl03peXHIvZEC74GRbGeLmB5HlORw8wIBO+7YIeMRC+UErES
/KdtUd+nhztMK1uAMAMMdURyhlCNu80rIXKqZy1NXtlnZpaVq9hKdfLd1QU6JGF+
nss32bXAme6Lnn7fTxwvu9dj8JDZtJfO3Kjkd6+Q0LCnIlb2MsSTLhaV30vGE4oO
cFkso6yxG4eedBcohf/OR/yAx8VP1kJZf75wfJk15MERY03YZXgpeTAOfYs7O41x
3XMHhzXQnO4dPSrkBos1fCzQe7SfluGCeKABJNp8GMRcLFHMN2bl+z0bBSNv+/pM
SacssfB/+Uaoku8tbvKIXTxcu7JczWXPKrry4aWDN1WNVzCoJ7o=
=KUG3
-----END PGP SIGNATURE-----

--jfz2Vypj7J4n4LTF--
