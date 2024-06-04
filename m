Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C79145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504646; cv=none; b=TgVEAT/DVDxt31f82/VeDWELx6TNLhdoLuGuKA6KMn9hfivic1BrDMOh5naJzZRGAs39EU/sDuyBKC5+wZv69DZxTojG/bygXRF7l0NZkl4KXDmGSE067QBr6HdFtDxlfVLQUMqyWgEZmKJX11gtRk3API2LrLouej/KdGn7pWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504646; c=relaxed/simple;
	bh=MCcRvBdaHon2V2C4arDdRnB3wJbxnfTS6a6vm5W86fk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m0fXwz2dwBZjKWn2C6r2fcLwhDM8fTUM6GeP7gYdXi26MyisXfHGR4M7zYiw0tSN1YdeoNPh00FxFYiCY1qwTPl3Q5PMfd7XwcoNsSlc42uPiUZqenlk+WWNZCC5LtdQTjKUiGmQHXV+UM+L3Q6bx4ejqvbuoW0auH+TSufY6vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JJvR+KJH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=g7ia0YsT; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JJvR+KJH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="g7ia0YsT"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 2196C1140092;
	Tue,  4 Jun 2024 08:37:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 08:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504643; x=1717591043; bh=jLsnnHIUI0
	GryprG0JeLjSZL8jIjPYzspaMGlKbfiTk=; b=JJvR+KJHPkS2Ua7x3lS8oUgsaG
	ZSuOsr4lKJ7VVqG1jnt4RG5yPfGjwk4Tzs92O78R7L92d346A5YpYWSlDK6cO9qn
	pvx1wy9duu0vQ1+gi83wnkId8xsmMONX+bzn8tMQSmcGDMqQIo5Ne8pdYR0Vpsb9
	ltJ0Hi+lXp4lzxvNcZn1S5kSaz6SYTIRHGlKclpw++cP13ZPqGbkjopm2M2hDAaL
	F+IYA7OVxRKhV+VN8HNMRQcP8W5XdGKKTg1axrKhizVgR9wltsJm4NmPbiCD+edv
	EbyfhcBxjgEZyq7lCrLfeYEUC2uKS+Nu/mGrHO/HwPna4jUOYMW0uK6yYCbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504643; x=1717591043; bh=jLsnnHIUI0GryprG0JeLjSZL8jIj
	PYzspaMGlKbfiTk=; b=g7ia0YsTZZcdnCGAXYUMc5CyNzFtxhuZnHJZjrDVrY8G
	r9cIH8KLfFOBwovkkYLTrhzKR0RoOASsxkbAVkZmE7cbPR+tqqmf/6ysCPcE+44+
	k5SxaihzoOaudIm8+FXNop5dq8RCu1IG1JghM1gVO45hO5HX9SuYvAt7NG3vX0L6
	iDXhbZIvqPq3W5AY4bT2V2pvbaF8/ZBkwNB6Eyx7VyMPD63iElY+uzXMpbejxBB4
	12n+aF7IiBOTKA7enJGBuftPXlvC17Rz/74q3Arn96+1h2xHCBjojl+JSgXMyNt0
	UFWlY0gmPwh/3phx1iHesCTZhbcB6EuSQASpbQzXrQ==
X-ME-Sender: <xms:ggpfZtPkSFQlSm4PHGsIT0jZrMlXNIU7XCM837iS1IWNGs4f6JwQOw>
    <xme:ggpfZv8bGZVPu8SaB01zRcnyUTvWXyqZQh7C4LeCHzK79RHLqRpaXFqNXyiDPvrhr
    9vSDB0mjHRxDBg1jQ>
X-ME-Received: <xmr:ggpfZsRdTPMMOxSHaDLc34DPeypJgDKXAkxZ8igBc5sw98ZCys2veVdWWLWeITjRJepQy7opR7zhVEi_dTOFrnyvr32Z4ZoYY68_g1CWgCu9zbJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ggpfZptwVeFCPrbqP5aJxRwfD49YVQeO2cdzrc2ErQGSfMhPR9n0qA>
    <xmx:ggpfZlf4syns00CzpBkl57EzJw-OAPK28KOefYgH1cxn1lUVaR9MQw>
    <xmx:ggpfZl2D2VXAgihNnifq_mS2ZUhMUohTmgNEaO2Euqh7jzuAlamkxA>
    <xmx:ggpfZh8O_Cunu799ylEGd98-yn26HDjZ-wF2N6csvyV0W1SB_yBYBA>
    <xmx:gwpfZs6hr9jJ-TFdeuoKskHynPEqe_9Z0rws4dS3QOAbMDO95gSK8xhQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:21 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 893057b4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:36:55 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:19 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 06/27] builtin/remote: cast away constness in
 `get_head_names()`
Message-ID: <7cb5df9182e5739f54be089832d85e0447efe46d.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LvL28+1vB5sb9fJw"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--LvL28+1vB5sb9fJw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In `get_head_names()`, we assign the "refs/heads/*" string constant to
`struct refspec_item::{src,dst}`, which are both non-constant pointers.
Ideally, we'd refactor the code such that both of these fields were
constant. But `struct refspec_item` is used for two different usecases
with conflicting requirements:

  - To query for a source or destination based on the given refspec. The
    caller either sets `src` or `dst` as the branch that we want to
    search for, and the respective other field gets populated. The
    fields should be constant when being used as a query parameter,
    which is owned by the caller, and non-constant when being used as an
    out parameter, which is owned by the refspec item. This is is
    contradictory in itself already.

  - To store refspec items with their respective source and destination
    branches, in which case both fields should be owned by the struct.

Ideally, we'd split up this interface to clearly separate between
querying and storing, which would enable us to clarify lifetimes of the
strings. This would be a much bigger undertaking though.

Instead, accept the status quo for now and cast away the constness of
the source and destination patterns. We know that those are not being
written to or freed, so while this is ugly it certainly is fine for now.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/remote.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index d52b1c0e10..b44f580b8c 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -493,12 +493,13 @@ static int get_head_names(const struct ref *remote_re=
fs, struct ref_states *stat
 {
 	struct ref *ref, *matches;
 	struct ref *fetch_map =3D NULL, **fetch_map_tail =3D &fetch_map;
-	struct refspec_item refspec;
+	struct refspec_item refspec =3D {
+		.force =3D 0,
+		.pattern =3D 1,
+		.src =3D (char *) "refs/heads/*",
+		.dst =3D (char *) "refs/heads/*",
+	};
=20
-	memset(&refspec, 0, sizeof(refspec));
-	refspec.force =3D 0;
-	refspec.pattern =3D 1;
-	refspec.src =3D refspec.dst =3D "refs/heads/*";
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches =3D guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
@@ -507,7 +508,6 @@ static int get_head_names(const struct ref *remote_refs=
, struct ref_states *stat
=20
 	free_refs(fetch_map);
 	free_refs(matches);
-
 	return 0;
 }
=20
--=20
2.45.1.410.g58bac47f8e.dirty


--LvL28+1vB5sb9fJw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCn4ACgkQVbJhu7ck
PpTpNA//ZTlu8a2jSg5kByJPK2A09OwAbdgwHb2xi+YLaR0fyvld4uY1j07L8B2N
sYmk8otvrUuUiwb6nD31cbq+Wh5YRVQC4/9NRT9tJFp2PO2oJbFYL7SgGl7MT1rG
NJsO9Hih2VRUoSkw3pu123dwAceuxoBfTiENHYYhpkaFsWSnmSpoZ7YITfXyf+27
5UYztDlurRciO1WSGTBBs0Dc9lYZv2b7M6b+UaknkdkfUYBugfuvZrMIoVktpfOQ
TGbedkwWC7MgLYlH3f5qWnF1jrPjsD30bWgZ5kLVywOQPs3GDTc44dd3JVKngNFt
I40w0huFF+LRAYytcgJeI3wNo8sOyXhu3UWJf5j+u1Q24dydEMORge567+mrVbpB
m5TOnHe2GAq0EyOt8WXdGTgnasacaL7YI64sc2zAbJ0ozPuhl3EqYsJKJTU+e1/7
xSvHEUHRwwfuD3SSLmvd8qXHuhwu3qugZvHXs3z0Ec58ESh7tIYx6R5kET9NlgX9
giHZVGuPcr6ZUc5UqPdAiu0ElzcuLChPdZ/U99yzM+qjbmjXosrBAEbve1zstbch
Uq8ZzCbaO+K8AQwCYTRMvoGBV1E4+/4NTjcDpjuQBzf+8HzFnAQKrdutHQim84Qe
TUs4urDu0CiG3kvBiB5rz5jdDrMB98AWSpo/xO9IxV8KiYDTDhI=
=D9yF
-----END PGP SIGNATURE-----

--LvL28+1vB5sb9fJw--
