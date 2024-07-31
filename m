Received: from fout8-smtp.messagingengine.com (fout8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A521B29AF
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 14:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435307; cv=none; b=kFHoqPsXxFCirxlY83i9S6ovT0K/k4QBwKN+eIW6GUqkp9UPBZvrHsLiMZJ3qOgM2tbIndGlEGfIKOinhVOCcaYProBRevNUqqhQDm0DJsuKTZiXF4Xu9cUZIcSXHbIm7+1244G0+Mo6WA8eX9mA3DKky4Wa+6XqzKxuh8voATA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435307; c=relaxed/simple;
	bh=fBRaXFS8MPvnHhcR/egteD/EyGRCgv/KauuAx2Sm8Vo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZCpk8WUGqeQfPJc7RGX9oIKLxwrIm3WZ97GsAVUzShaNqlrCAkQK54DHReuWlVTFCfzk+Fkgz3bP9TLbvoOl55/5G2jhhN2ms9oPngJ+++gpbxQCFg3b0CzQwTqYtwm+frDqwVj6j4xYoqdhoc/PgXYjg+jRw55BY4O6OB+gdeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ri9Zb1ej; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nXx3C+Fu; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ri9Zb1ej";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nXx3C+Fu"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfout.nyi.internal (Postfix) with ESMTP id D30551381E13
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 31 Jul 2024 10:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722435304; x=1722521704; bh=5XM5RP7Snv
	lBYI0Jc1VH7d2jaLrnMpEW7ihYBko+nts=; b=Ri9Zb1ejLyb3kfOFM+KUh2R8j9
	7bPawhjTdIh8VmJwtXk8Mr68yh5UHioad4kbqAQfKcbRi/xCUHQzESy8d9DpBAN3
	9aWDQO9kQFmUxP2emJntU7LBZoevsZAVeVYEsiuc3MWWK0XPio1C+YHzTHFzZop6
	Ikt9L5ze1PjMyhSiYS6yJrhmX1stEmQLxjRUokqoybClat8nemZup4yRed6gPQy5
	bqHnq5Y6npknEXUFizqHvtOKFwCxOT8gRKV5BsxVWu4o5Q1AYY3C/UZiCVq/Z9Lw
	GR7mSvFtTvfsJInBqP5mVSZ06Xi3Iiw9zX/4V3QLdoaILfuJvep2HUBMVfIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722435304; x=1722521704; bh=5XM5RP7SnvlBYI0Jc1VH7d2jaLrn
	MpEW7ihYBko+nts=; b=nXx3C+FuaN7gAdD/ElLsJoV+433aBFrNzwojub8P7I2K
	J2JbC3oRZl2f73a10kYCh6LolvQJy+DVeSPqbaEcZ4NTQPHSJmMQaVwrvmysOHod
	mzGtFIn1a42q4Gajr9n5SNW6oe9KA/uwRX2sLuegHINyP6mczRF8GrJLo15GYaJf
	TowdN5kMgVGuT+OOvh86wNfL8nzI9oMa/5S4Vm5/zNLxfP0N3r3t2MKJJPTGJK0k
	0wSDwlwP7vqJqXf3Ybj9SClIdf1rcx+253J1KmgYpf6XlYFJTSPbUPOoT7YBsew5
	Sk+RCspKGR4GcVrI77YCL/k61mgXT91OM4+gzrOfyg==
X-ME-Sender: <xms:6EaqZtb9d0gFxjDoflX9xYJQU6f762RkPKHVOv_Fg2JLo3UCXwBIQw>
    <xme:6EaqZkZ0Y4b20iCL1zgYjBrQFspxegOv77hp14giiQ1A7bAEOsk4FopG7LNeB3mKG
    HV4t4lEALJ76Q8zBg>
X-ME-Received: <xmr:6EaqZv-9t25m4J0olzvEecTXYfDi8cpEDZ3EpVzjrk34yEwCaYnGUESypXqTdjhhQBPZxXbWN3LeW5cOdOO97uYTdJXonL4S8YcqeqcNivo2JwoO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeeigdejhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:6EaqZrpr5sbxiHB7sW6PTh3XSIGrbIHCwW9E5t_nKMFQOLBlHsT0GQ>
    <xmx:6EaqZoq-oIyh87W7JfTtB6dr4EsebpASrIy1wyBuwURg_mZgaDoQlQ>
    <xmx:6EaqZhS5vx9SKbh2X01Ctj0Kv8_VJv5hUZixPeMORKGkOYl51ayOvw>
    <xmx:6EaqZgpX9y3991edtJvQVKmN0G4uTiveHED1uaJA7FW9tE9lOaRfeQ>
    <xmx:6EaqZlB01fNQkBObhZwQZyOqf9Kw8gUvfu7wdIxgdYpkCbjAL4RwQuvn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 31 Jul 2024 10:15:04 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 495e22cf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 31 Jul 2024 14:13:34 +0000 (UTC)
Date: Wed, 31 Jul 2024 16:15:02 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 3/8] reftable/stack: update stats on failed full compaction
Message-ID: <1fa7acbddfbf5f195047bb99ca7312f74a897223.1722435214.git.ps@pks.im>
References: <cover.1722435214.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1SG9+AfAXUxuGqXq"
Content-Disposition: inline
In-Reply-To: <cover.1722435214.git.ps@pks.im>


--1SG9+AfAXUxuGqXq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When auto-compaction fails due to a locking error, we update the
statistics to indicate this failure. We're not doing the same when
performing a full compaction.

Fix this inconsistency by using `stack_compact_range_stats()`, which
handles the stat update for us.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c      | 14 +++++++-------
 reftable/stack_test.c |  3 +--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index ba8234b486..e5959d2c76 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1205,13 +1205,6 @@ static int stack_compact_range(struct reftable_stack=
 *st,
 	return err;
 }
=20
-int reftable_stack_compact_all(struct reftable_stack *st,
-			       struct reftable_log_expiry_config *config)
-{
-	return stack_compact_range(st, 0, st->merged->stack_len ?
-			st->merged->stack_len - 1 : 0, config);
-}
-
 static int stack_compact_range_stats(struct reftable_stack *st,
 				     size_t first, size_t last,
 				     struct reftable_log_expiry_config *config)
@@ -1222,6 +1215,13 @@ static int stack_compact_range_stats(struct reftable=
_stack *st,
 	return err;
 }
=20
+int reftable_stack_compact_all(struct reftable_stack *st,
+			       struct reftable_log_expiry_config *config)
+{
+	size_t last =3D st->merged->stack_len ? st->merged->stack_len - 1 : 0;
+	return stack_compact_range_stats(st, 0, last, config);
+}
+
 static int segment_size(struct segment *s)
 {
 	return s->end - s->start;
diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index 04526c6604..8739ff3d63 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -1003,8 +1003,7 @@ static void test_reftable_stack_compaction_with_locke=
d_tables(void)
 	 */
 	err =3D reftable_stack_compact_all(st, NULL);
 	EXPECT(err =3D=3D REFTABLE_LOCK_ERROR);
-	/* TODO: this is wrong, we should get notified about the failure. */
-	EXPECT(st->stats.failures =3D=3D 0);
+	EXPECT(st->stats.failures =3D=3D 1);
 	EXPECT(st->merged->stack_len =3D=3D 3);
=20
 	reftable_stack_destroy(st);
--=20
2.46.0.dirty


--1SG9+AfAXUxuGqXq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaqRuUACgkQVbJhu7ck
PpSskg/+LoVJUVXDfMA53qJ1Ss4ydSPI0i26DkemFpXxzs2NcJH1lYi7M32BaGaN
05JNurWMM0JTQJ4rI8XMScFatFPgzBhhKVKI3GOdb6nt/12XqznVgiVxC0bOTDtw
e3hUZf9jcHPwFsdixPYB+jHSh5nQ+zHGLIH+88jNzeACNLDBKpy93ISM64NaaIQp
O1nMDT1uTPWlx8ovMukbaHpRIsTVRXaLckHcQBfbA9JYaeaVCKy5ZOMIP/CzARjS
orROvJOXY2vOWfRztANhWA1HTHOTiGPP0q+kCpjB7t4LWqfJ/0ECUvBiu63hTRQ5
beQGPU+mZnKUXAo4Ix3xJejouPBfh0yCF5UuhMEBP+y+kMzU3it06ayh+cJbEIV2
cLMA3hJDvQc+fxT9l/75gR/4PuUcUgDhU0OVIZaq77/z0/ZkCT1a1T4KRac1PIoz
J3oxKILVqwtGbQ7OBz272dMCCElVw6RiuO209HZoJMq9LHCy5cXT09EYz78R32/c
kaQzuQm3GH8pDUS/GWk5iICWsGNTqwIXTNlU5XvGp+RRd3of7bGR2CrbIZwRgCqQ
jamTk5YMl9B7eOcdnBgwRXHITSua1nEujHTPHZhDHrT4VYX8QxewGCoV2SKSNrYI
XT79z/8pcpx5T6lMHjkQvJLT/A8+N3JuTJgKtkXoYbu1DJAyDKM=
=nOjA
-----END PGP SIGNATURE-----

--1SG9+AfAXUxuGqXq--
