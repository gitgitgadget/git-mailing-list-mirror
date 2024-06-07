Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABFC1CABF
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742306; cv=none; b=VleUtgezkmtTYQm5vP5sXq6apqu03NMOOMom868D2l2EQRDcHIqvnlEWdi1udt3WPouAhcBUcjvnif26GIZ4PlGHp0RvQJOq1peI+qr4gEM05UQWdGrPevkt0CwBCB0y4WFIb4D4gRTuJvOEFpyHrbnO7LNU4uECxEZ9OBzy11s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742306; c=relaxed/simple;
	bh=EQ9tBHGPa4dUpfS4ANshpnQDwZa2dqiYyYPEWPj0DJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rK0sRbjnzLQlWn8PDx8WL4GvhXaAFJElNX8kxiKdwsZshZeIIpjPBUSvMzzjNF2ie285O9jM86DuJ6t1B92xMuvScYy2Qxi6saO7QpO0F2fvYRwieOM6OSZtP1OWOHcPu5/rHbAr+CItO9k3uVI8C4wlrgnG3I1CoD/N585kFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QkJZ3gE9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xe5q4Df3; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QkJZ3gE9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xe5q4Df3"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 8E88613801EF;
	Fri,  7 Jun 2024 02:38:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:38:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742304; x=1717828704; bh=xI2mHvxT3G
	WwsBbdc5ijKx3ef4cLWnvY1zE7IEphVV4=; b=QkJZ3gE9pv0eX4V6NOD1M0h4Ys
	iSNZdMPeYx0sbNAWN9X0pdsQ3cGjiC6/2L/T0SvavFSehSzxNzQ0hY5S9qGIphM7
	pEYvih3JXTlo0LNR6GLRQntdhmlIICb8xmKRvJxAeyAg+fkvGPQ4EVvEKMxuQ736
	KRP61AuWqa5ETZ+GnGTqWCK0p4nzU/nRFj4DweuDtcxJBO07zQFqEsfyUeJUZ0mB
	wMbSBCTvdWP7Sp9CWFhhXu200a6Nd5q9ilZ8fE0fcv0JL9bHEdPUQ8Su6Wkcgklq
	aHiun96OWehix8mXqKAhxaXoSX3IB15NxwvhKUBEdnlD8G11TiCDiH0O3jCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742304; x=1717828704; bh=xI2mHvxT3GWwsBbdc5ijKx3ef4cL
	WnvY1zE7IEphVV4=; b=Xe5q4Df3qSnckLy1zfrFZt5VcIOE+xKPIV7LzQO6el/j
	mrl6uYdKnhskpD16xOXkDSw6zcNO8v0GBf9aKL5NeiWWwPKEsgmE98COJcP5gbxk
	avzgfA2P2T+K/tHRF4Dsf1QFYK1q4GEY/V4oC89ITII39Y7PKfDAKNpOU1gzS5F9
	ennqHerdlaGX0crldJVRDj201N/GjDTIM4DtTHtouFA9LBDwo1BiuPI18VFD9LzG
	xkMRPUxWp9nHvGiv6YziQgy6ZgEVT1VoaVmgYPAo2qiuz45gr6IhMXrZ8fN3toDv
	ADxBKxoUSc07cV1kTsjoM6j3rd5TNyHN3JaJ9t0tFg==
X-ME-Sender: <xms:4KpiZhf4ZWFmUEw9WDKvH3gL5jhUHyWyBNrGZjD3M9rgOmg57qeFYg>
    <xme:4KpiZvNneQTTp_s4MGhBptqIk9XpRwRZ_Gw_Y0xRA5JLEa8eevN16Adm1SCnWQkto
    oauwy1IaG-z0A2iqg>
X-ME-Received: <xmr:4KpiZqjseYAFeZJUXyC8uIZZ-Y0qAmFriF4Gr6WkiW_32Gfe2TLASModGEQ1jGoS1rs4OR0cZ4h9J_GVSasDTztVdPRnqZGwHTtC58p7NSDrVgn_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:4KpiZq8fTF6XwzjRk4p3zbqfpPf5jt2obifYDz__tBreCW4W2FVfcg>
    <xmx:4KpiZtt7eL4O1K_4eUYp4r-LFhULOQyQSWx9yyEHm63Tg1RDeQo2Yg>
    <xmx:4KpiZpEaXvGDPW1miNXxpt73ycvvqubuP8p_9yHTF_womgzkHajawA>
    <xmx:4KpiZkMnOf_vaajQ0BkWjb5A-6wYmYCmwr28P60VC8KXUy2HfeVy6Q>
    <xmx:4KpiZnI7YQQd9AStiwHP4jZwcoaUFGMbLl91ZlAZWd1cKxEXh6TG6XWs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 4bc5b767 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:22 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 10/27] entry: refactor how we remove items for delayed
 checkouts
Message-ID: <4d0b8dcbaff0335a3020d2ee742b91393fc99e75.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FB5CaFQwV0En5wsa"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--FB5CaFQwV0En5wsa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When finalizing a delayed checkout, we sort out several strings from the
passed-in string list by first assigning the empty string to those
filters and then calling `string_list_remove_empty_items()`. Assigning
the empty string will cause compiler warnings though as the string is
a `char *` once we enable `-Wwrite-strings`.

Refactor the code to use a `NULL` pointer with `filter_string_list()`
instead to avoid this warning.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 entry.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/entry.c b/entry.c
index b8c257f6f9..f291d8eee6 100644
--- a/entry.c
+++ b/entry.c
@@ -167,6 +167,11 @@ static int remove_available_paths(struct string_list_i=
tem *item, void *cb_data)
 	return !available;
 }
=20
+static int string_is_not_null(struct string_list_item *item, void *data UN=
USED)
+{
+	return !!item->string;
+}
+
 int finish_delayed_checkout(struct checkout *state, int show_progress)
 {
 	int errs =3D 0;
@@ -189,7 +194,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 			if (!async_query_available_blobs(filter->string, &available_paths)) {
 				/* Filter reported an error */
 				errs =3D 1;
-				filter->string =3D "";
+				filter->string =3D NULL;
 				continue;
 			}
 			if (available_paths.nr <=3D 0) {
@@ -199,7 +204,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 				 * filter from the list (see
 				 * "string_list_remove_empty_items" call below).
 				 */
-				filter->string =3D "";
+				filter->string =3D NULL;
 				continue;
 			}
=20
@@ -225,7 +230,7 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					 * Do not ask the filter for available blobs,
 					 * again, as the filter is likely buggy.
 					 */
-					filter->string =3D "";
+					filter->string =3D NULL;
 					continue;
 				}
 				ce =3D index_file_exists(state->istate, path->string,
@@ -239,7 +244,8 @@ int finish_delayed_checkout(struct checkout *state, int=
 show_progress)
 					errs =3D 1;
 			}
 		}
-		string_list_remove_empty_items(&dco->filters, 0);
+
+		filter_string_list(&dco->filters, 0, string_is_not_null, NULL);
 	}
 	stop_progress(&progress);
 	string_list_clear(&dco->filters, 0);
--=20
2.45.2.436.gcd77e87115.dirty


--FB5CaFQwV0En5wsa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqtsACgkQVbJhu7ck
PpTS0xAAgKLMaMp9y05y8zOMNXY5mitw0pRYLjWlfK/05OnD0KWITfmG/maQm71T
eFAfuVWQTIizOwhNU0RqE6X5dyPqh403jIEKO+rAEBCVkbydWAa/hfC39rM9gd1D
4IBLEVeHUh+6P9BDNJmVas3OjREClR+ywdWAZ9O4DTAybBksV2EOsZ8Fz0G0ZyXY
3MiJyH4Hcp1tY21+loO3bIcxdAMLrXRx1iE9rktZaeZB9GAdRqDykEWzdLdGYS7N
yaqK6wU99k52gGyBYdDZB4vvr7XiUbMsRNtUkXLcQwNm8TWEkqRmCs7+V+RCjyH/
LIQfwYQvmiklg3FGrsiA6XSJP6sanWhN37LLpVBC2wL400fyqDve73bB2mdltH7D
FzZZtlFrFtOVKmfjzfXjQ/EwIZhEV84LPr1FrmmLB2PLlLh8IRi7T8S8PDuX6Oz1
yLmeq/eZh76SnVsAa0T4VWUaKer6jDz1kCvaMzyAQNQXmuc36c5ODjzGjRsUhHRE
4ZMtlmjVTV1VlfvDAs6uyn98Fzv119tJUyGa+u+rkt7kWGD5TE7kZ/cwnhcw+h8u
e1jMfFxQylw6IPk0oPDe4tlO6nba82ZxQURBpjwhyYcknTLSbKcKUFctanA2658T
T8+6Ts75Kw8YblfOC3CN1S69vsFEDlDhZOIKpJ68TXhBFT4AbXk=
=h7AO
-----END PGP SIGNATURE-----

--FB5CaFQwV0En5wsa--
