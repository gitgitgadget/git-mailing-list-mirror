Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5920429CE1
	for <git@vger.kernel.org>; Fri,  7 Jun 2024 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717742325; cv=none; b=bn5Fh71tn8DLQVlrtWz0ApqO0GG9Kfdo0xYH2EHUd1VmgtR/uFYnET0w+3YiHhmei5+O7rudi9sMPt+tL8c5LgYIEhB2dpwSQ8JqL4z/kwRO0e6UsavZd/sRcaBe71CCKbnuCqFSPosuJnKRSg51/ssFC0yqkQp6EglPZBhY0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717742325; c=relaxed/simple;
	bh=kLbukn1TrUKa7eSA6G4NrVZMObJefgE5edKm54VDFaw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBZW//q/TRlk5A6A9BQ5QO394VxJ6rKu5RTe6otHQn8igyNa5O7N7JR006yt/6IGa3bdrv/OtMpGKeQ7u/zSiPoBWdysmzilhO1a/SDzXDgMZrrWhEjulvKD47XPUQz7+l1jL5MQxhcprf76Au3gxpW5v2uka/CJTzVuGD0n2Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SY+96dqV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FLAQ0Gx/; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SY+96dqV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FLAQ0Gx/"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 89B1411401F5;
	Fri,  7 Jun 2024 02:38:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Jun 2024 02:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717742323; x=1717828723; bh=7syAb9rPIk
	AAkZ+G2s8YXWdbqpEf1kl19o2DBRyJpAs=; b=SY+96dqVgNwBQ7If4NhCX3qEj2
	qWOYWETfqthcEmYxMWW80+Lot3XihjxPblNFoa2usPc42qLczx0ev9PJ9gDJKr9K
	6RAwFzvjFtvL5c8ukTi+w7mbvQvBwaX5iUkRZ06cNiffH6j4jEoGfWtqq3dGHJZO
	CmW7xm+9XcW6h4iQTDx0mkwAOiIveCMMOoi2OVrgtaoT0Dowbj86JTWKQLC2mFKs
	UNB4ePMMsg8krm+3NwjD1Uu4PoekSfXVgezzX5zT80Oh7QUnAYJF3tV0nk0lW9Y7
	m0FgbjP4el6k68aYSeBXTptFocynMXOPgACy0QcJ3H0YXbSv7gw04zv7vvtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717742323; x=1717828723; bh=7syAb9rPIkAAkZ+G2s8YXWdbqpEf
	1kl19o2DBRyJpAs=; b=FLAQ0Gx/8GxeVaMktv1Xb9zmDyQL6hmh7szGoWUnlN2q
	Bvo2N6gvDVJzHM9xGyWIGXMGhZbOL/+VjCJ6cxZFDS6PWKnnULNqKS/dvUCwmp9Q
	d0Aa8kalUOcxcmMn8eSrRnQ9oW0NXkdWLpXb2fxUXvoozmGkv8PtcwpYTg9T8KjP
	ipFkxdFyhoQAH+PFqnGF/iqGPLBWPyjk+gzDZGIGyHuwpN/ic4poYw1w8nYD+7Nb
	NMO8+M4ijxhxTnrCOJ9c9QTuM50W39BxKgP/cPk8Fadw67jzQgGhZ7HI818Dn0sx
	XFVtNs+MBzWhx9pOA9q6dtCo+JRuQ0ha/23ZZHTSxA==
X-ME-Sender: <xms:86piZhimh-W6u84GcfLPS0URAZtmnh_xG2h1Hv_InA4hqH1zYtPS0Q>
    <xme:86piZmBkEdDjyyDgIsSIs02AJkyzVixS61axItD8IbhPZA9oY8e4RMi6DScqRpRCm
    WGM43udkohBcGdluw>
X-ME-Received: <xmr:86piZhFVdveA2yp26IysXQF3viK4uNbbAcootb75RdDQ3Xtx7Uj5LcU66f3k6KOcRAP8lkc27GRZuQVUSELek5NkFnxd3qBwp-AJXIlM_IKZCrEK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:86piZmTqXhz6DACCIZyhJ0LmmVVLgWOHNVC2bFUQ856taLkIoNKHNg>
    <xmx:86piZuxoc2N0SPLSLXZnxVc3BPmaug36iFsrVZAji_OKJHhFHBNSww>
    <xmx:86piZs5Q3uoIrrb7pmOYX2AmAnDSf1jYhOfH2jIdULKFtp-5UQxL3Q>
    <xmx:86piZjwNx1HyUtbeAyVFYsmABmMBjUAFh2dIjBpeXUM0BVbqISL-7g>
    <xmx:86piZouHfq6qnUpxYQQX0C2vGjd3sRPxjt2Vzm1B_5mNvVRSPtxC4VQc>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Jun 2024 02:38:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 64b2144f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 7 Jun 2024 06:38:41 +0000 (UTC)
Date: Fri, 7 Jun 2024 08:38:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v6 14/27] pretty: add casts for decoration option pointers
Message-ID: <02e79d030b38de571c65f33ac0fdb08b26114972.1717740366.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717740365.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tVb9JwzQ/8aZDMqx"
Content-Disposition: inline
In-Reply-To: <cover.1717740365.git.ps@pks.im>


--tVb9JwzQ/8aZDMqx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `struct decoration_options` have a prefix and suffix field which are
both non-constant, but we assign a constant pointer to them. This is
safe to do because we pass them to `format_decorations()`, which never
modifies these pointers, and then immediately discard the structure. Add
explicit casts to avoid compilation warnings with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pretty.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pretty.c b/pretty.c
index ec05db5655..1df9d635fb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -1584,8 +1584,8 @@ static size_t format_commit_one(struct strbuf *sb, /*=
 in UTF-8 */
 	case 'D':
 		{
 			const struct decoration_options opts =3D {
-				.prefix =3D "",
-				.suffix =3D ""
+				.prefix =3D (char *) "",
+				.suffix =3D (char *) "",
 			};
=20
 			format_decorations(sb, commit, c->auto_color, &opts);
--=20
2.45.2.436.gcd77e87115.dirty


--tVb9JwzQ/8aZDMqx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZiqu8ACgkQVbJhu7ck
PpTRxw/9GmWy5V0FM8K4W6l17DnslKC2DCXKh7Q1r03y6tblaDOhXwFksV16tqcW
qNdtnzfUTxMPDhIOWBcdpTgAUduAmnu+unQCsQLo5DsFlfWwzJSL5KAIdxKw1naL
kThI+LnYWpseJkYV0yWXuJVc+v1oP9VA7orARMnofeN8XxjlWBvqxPh1EQjd3/yJ
4anN5CHUkq/jlXq16xmvbkJ8rFGGsFS615WAbG6BXNNRXMXqh9pQG3ZWELxIaJHR
t8S1+xO22jhN3s+kSjgOdZnl6/TqUVeDSutRzrAyids/Pj62xnhUKDvPRBFJforZ
o7ghaFDaau9JLvnAVS29twRSxXTCUP6yvt4UwRnqg4T1g7NjG2RvncP7SlWogLrC
gF7Hz8+Pw5fzCgEL5OS5VLxzzPwWhCav81IhismxKy+mr04gsD2+6y3DNw3rONtj
5TdpDbcFtJ8tjJXb73e3+7ZKT/eJ4Yfm0s5MbALp5jW2lj2WylrEdhr5RJONc41s
iUD0kQWK5acT7fKybLFsg5CB8fkWwy7bNiOxj/d1cxoCCtnDqn8JoflAvFm/D6Ts
vd1dAHlbw4fZRyLwT47ZmngZn52TUSeMwarpSBc5Mcn23i1IX5ug9BE53HKJNMRA
DJ9ESvW62YUgZYW6LHB8u3N8wRDZXtKeGwijnIgEiJn3EeV3xCI=
=+FFt
-----END PGP SIGNATURE-----

--tVb9JwzQ/8aZDMqx--
