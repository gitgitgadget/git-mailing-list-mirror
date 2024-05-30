Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75650132128
	for <git@vger.kernel.org>; Thu, 30 May 2024 12:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717073469; cv=none; b=atvKV+eRhDC9taCjcAIvudX4kpmS6DBTkC9w7C2umlMvI7vKaqdQ8Py8LfEAV+Q29FcrWqtWRgmltXv3TunTRP7zCee7qNF6AnLPamHIkI0bunFRudZ0kIEh5ZsZOh88MUeEPSkBWbOItKSdeumutCkYpAUbeOOQgSf97CLhObc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717073469; c=relaxed/simple;
	bh=7WXh5qZEd6sJI+aG2HXiuXB6RLRnOYPKuZqzvL74QGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JQ9f6qcyv6ltj+KEQga6Yc7gQoAkYXBIS5tP5iXO0L7owNQwgB7nxc5Pu0X+YtZBokikrDs5gAuF/RyGhKd3rP0ntJRP/fKtGlx9npaAYzKk94VRzYBSG3DrU+aXm6xjvBuznniHUhk6yTl83uVfmb/PjZzWlSJviLNuEI5S5eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JssT0eYu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Qok0d9dj; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JssT0eYu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Qok0d9dj"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8CF0E1140163;
	Thu, 30 May 2024 08:51:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 30 May 2024 08:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717073467; x=1717159867; bh=W+fW1IJyyU
	YToNGRQOEwN85VVbgv1qm0lcuwt9VH7zI=; b=JssT0eYubnh+MNdS8KjGv4TXQi
	6OiTG5BsfNNf147XzWO/QREE/eG7lz0GcxFEoN/ewVfnwNMt1COS6txQMsl00Amz
	OTGgsukovqydEMm3ofiyu571SSD4WkaTc/MShIyzUcl/wE2QD7D5hJ6WumItltrk
	RXUQfhDa4OoGKOuuk5+/GGz2Y1tjwlGqL0qKpiZCeYCUbBiDzSOqzVE0vfhNg12/
	naAy9oJNdBP6qFeoCiaH6tZbuGcY8HuEWQhBIFOrQI7fvh+86FzIcEvz7qG5NySn
	AYqKnNStSveOwBrUO02OTWQPsND2ZWTme1Ob7wQKpKKbNrHBuqWxJGVG+Rbw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717073467; x=1717159867; bh=W+fW1IJyyUYToNGRQOEwN85VVbgv
	1qm0lcuwt9VH7zI=; b=Qok0d9djr/qd3ZWFmii0aI9o3JvcRJeEHyiq347YmhWh
	Sd10pZrFo5kcfcRJKpPvBQGEzMQU/pElGlpgjY0CBL3aJ5apMnwEQEGxjx66jKWP
	oVPWtPHsHm9EO7WdFZT5/XTLNghWvLeN09gO82bD7O1nvUwlYNSm2kPXQRW1/2wp
	eG1NNxz3xmQ24V7jJujGoicuHCQx7f0dic3dWKbC8Xp5DSV4t10sHK/Xtul8Z5Bs
	TogtxaODZORBVbc+7gXvpEH8a1ByaUIhrxUEY4rALROytmoeGKah5d4xE6ezqr6x
	4CgEkUmZUbky+VmQuzuwI076mWVFjbq4p4GGL6l/Dw==
X-ME-Sender: <xms:O3ZYZg0kHV6SVcZKQyfapk083DiO6LRX7SHmYIyR8VR-Og1ZGqWP2Q>
    <xme:O3ZYZrEjvgosDILEo2BRCFX7bo4Pxb4cdG8fRL1X7O5wZ2_jP5VuDc1d_du6qOvHv
    W7vlnWjnykpMWZk4Q>
X-ME-Received: <xmr:O3ZYZo6QksMs1Wod4zAoeKcRJs9M6B3NqiJkRrptuSCCV94G9LPCNMc6yRy9QZOo5tjgp4EHlhKfUmUJDg9Q4HazuNrgJ-Yc13p15cnvRBHqD8QiEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:O3ZYZp2MEp-NslZrVuRpbRQx222HWeXdcovV1FCjwsUdFToIlax-hg>
    <xmx:O3ZYZjGxOmjDbF9AQ7GvzYtuCmz7FX_SXOGUvXv0JJHAIqdAguNJbA>
    <xmx:O3ZYZi8UQnRZQicNHwEgKhNVKhGa7m5uXTDzUsKIEC9Qm0Z45bx0AQ>
    <xmx:O3ZYZoljNq6IC0xPzU5Plu-cgoGdGdbVpaMaRXgSjZoMHBaroSk5LQ>
    <xmx:O3ZYZrAwgQh_kFwKlVgYfhxnq6YoXUUHTMVXH6_XxKQnBYtqpFYfI9JV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 May 2024 08:51:06 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5f7c0a98 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 30 May 2024 12:50:49 +0000 (UTC)
Date: Thu, 30 May 2024 14:51:03 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 07/19] line-log: always allocate the output prefix
Message-ID: <3da7df97a5f80d3ca2a4e2a597c11f6105b6a152.1717073346.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717073346.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dSIdhNx7+PHudjpd"
Content-Disposition: inline
In-Reply-To: <cover.1717073346.git.ps@pks.im>


--dSIdhNx7+PHudjpd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The returned string by `output_prefix()` is sometimes a string constant
and sometimes an allocated string. This has been fine until now because
we always leak the allocated strings, and thus we never tried to free
the string constant.

Fix the code to always return an allocated string and free the returned
value at all callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/line-log.c b/line-log.c
index d9bf2c8120..9a298209d0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -899,14 +899,12 @@ static void print_line(const char *prefix, char first,
=20
 static char *output_prefix(struct diff_options *opt)
 {
-	char *prefix =3D "";
-
 	if (opt->output_prefix) {
 		struct strbuf *sb =3D opt->output_prefix(opt, opt->output_prefix_data);
-		prefix =3D sb->buf;
+		return sb->buf;
+	} else {
+		return xstrdup("");
 	}
-
-	return prefix;
 }
=20
 static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data=
 *range)
@@ -927,7 +925,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, s=
truct line_log_data *rang
 	const char *c_context =3D diff_get_color(opt->use_color, DIFF_CONTEXT);
=20
 	if (!pair || !diff)
-		return;
+		goto out;
=20
 	if (pair->one->oid_valid)
 		fill_line_ends(rev->diffopt.repo, pair->one, &p_lines, &p_ends);
@@ -1002,8 +1000,10 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
 				   c_context, c_reset, opt->file);
 	}
=20
+out:
 	free(p_ends);
 	free(t_ends);
+	free(prefix);
 }
=20
 /*
@@ -1012,7 +1012,11 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *ra=
nge)
 {
-	fprintf(rev->diffopt.file, "%s\n", output_prefix(&rev->diffopt));
+	char *prefix =3D output_prefix(&rev->diffopt);
+
+	fprintf(rev->diffopt.file, "%s\n", prefix);
+	free(prefix);
+
 	while (range) {
 		dump_diff_hacky_one(rev, range);
 		range =3D range->next;
--=20
2.45.1.313.g3a57aa566a.dirty


--dSIdhNx7+PHudjpd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZYdjYACgkQVbJhu7ck
PpRI3Q//b7AZKsCn9dN1zWVMUFue1tlFQWUNxUGMljBiQ1BawOgLETqMpdQSqdLv
f6LsHu6e87NQPc/ZrclRYVAfk21sjoUSjdGXyhIHgykzTMSNNI74kQMNLECBcm2U
CpGZo+584D86aqA0F52+V+6ZozHcmNRQIuzTKoO/lDReLt+cV+1TkePSXQek4nAl
s4nZj1Xc/dtdMQ65qolGdH0xLteRU6WaoVwftjaE3Dl7O2oVkhGN4z1SDnXuX30e
gKyk/DIVKH2EvWBi4gwwoCIBzjrLffZp4xW3BKhMlJmZgbIhSjqN2AKgjAhiDMjP
KD80VM/P/aI2GIPe/a4Tif7S4N7uzsIuBJebMPbWu4tLS/BonoRekaI2QzhoMb2v
bm0KcTB3CEDJz64LoSYYew6Vk/wad7MojjdGJws/DREgNoOPkLOHEfiqbOcxcpOs
iHGZVdlIc5Kl08iYWmNGoeAfSXOAdN3FvC2VLrMeVDQNKVisHTmw9z3+FwZ30Wjr
yF5Vm5k7fo/gbN5TrfqBq2c8luVtoJVPLywe5KZEGCre98pLfrEJsNVXzcfHbe6S
DvCCbw/OSNWrUoqelJoSjY9gNfa6tR4qzdn5vOyFwJN6JdZ+9Fxb40APBCc3LOfc
e6WjiM/u5RZ6USfzDwk1QArSt2MIuXAYdmVJLDrwYjGTjQ9PzBM=
=qtou
-----END PGP SIGNATURE-----

--dSIdhNx7+PHudjpd--
