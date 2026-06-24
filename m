Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561BA2BDC1C
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 10:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782297436; cv=none; b=VROKSpeYgxinxgjzHU71laF19Pg/IVayimWRHQM4Rk1x14uMM+yasoiNG1Zu4seo/wBLavIfXK6vHphl933Xp3N92BZx2ghUi1q51F5fAT4Zcx2LTHTTYoVwwba7XpfHv7ho76b3ilew0rzmBQ4eKI8snPpcQfEcediUpJG06O0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782297436; c=relaxed/simple;
	bh=7LsvhsL2WRoliffsEJOLHkuB5qjm/eNRhmXg0RAN49M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dtVwHWlAIYGf4lQf0epXWIz+sM3t1G4NOkxn446wFATHOVy78jZr/7bZWS67wTbJJt7jkg24C4ea0+dgFCTmULhveUQ8swuYg15vgWVqu47XTMNZxQB2PDhiQ2TKXO6rnUtezzxJzMfRX/fcnMz+8uug3LR/Cw3RMTujgfPpNTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Nu4TrLfx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Kp7W2gYh; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Nu4TrLfx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kp7W2gYh"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9726A7A01CE;
	Wed, 24 Jun 2026 06:37:14 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 24 Jun 2026 06:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782297434;
	 x=1782383834; bh=4GJ/BjjMm1G6ehWPIefp1K/En033vFw+K2fnDmrgNPw=; b=
	Nu4TrLfxzWo3TktnI9OjgLHJCN7zCS9+v3LpgBWwFcqh3m9D6AbnoTEdk7IlfXc5
	2IG2PhNdzyKeJ5HOGaH+k929Q6cfybXEF8lVfKyqkC4gkRRqA/v6dws7ZzsjxlVy
	rslZyJX1QpMen19qrqWFsEbypgWfdyb54C+gSlBBt4wA1dW77ANNnA+iuNZGYlSJ
	ebngQR50JyNk1iPP98sZhWmTmved6Im9r8rYFZ7e4XEeMnVRCbRsvbD5cYawAyBF
	QQjbQYMqNLcYLXhdUOj4s6xj9bSjhE3OXSN0Kx13KFutDPzcuWlEPQeOSXLxaqql
	lNF1HYKB9b2aQfYPj2PLqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782297434; x=
	1782383834; bh=4GJ/BjjMm1G6ehWPIefp1K/En033vFw+K2fnDmrgNPw=; b=K
	p7W2gYhTPXrUYrr3S+PxZyCaw465qv7JmOvoFTcmy4iNUzzu54eKLuZuvqzY1z0+
	AucXNrrieuJCDWawS+sSy51uyi8ErLePGFsgmzaq7wSm7RBjsUpizzu13Mh6EpWa
	dLsbgY/TVQZ6FauNKoKRBP2TkYXoRSC5wmRfeK5njYjOZ1HM0QbDTKazqvJXCKMh
	Z+T2/VX4+hAKC0ePVn0Z1DLi26gawN2rbJ2b1bfX83O+8OIMosrC1mNUnoWYPExG
	lq26HhY6hochQgQWleu04X3Kv0hMi+cDFBqbd+3MTvPSkNzhfHe6nAZx862adj6Q
	GNXi4UK3HVGIzKycvEuaA==
X-ME-Sender: <xms:WrM7ajdeqLuhAz8eonjUm7DSPQuojs_LrPRuR9YIQyTtC-iq1EZgiQ>
    <xme:WrM7agp_22lAI4-UvFF8O8XGDYl7IksSw4I8k8pJTFbVgjKs7VPMit1u3rvg7h28G
    ul7UML8esEVVSCjHc9WcBZFTQrHHnov212FP6ravqEmPPDzkQmvUg>
X-ME-Received: <xmr:WrM7ap4bTkSF9MZ1p4-6M25j2rFK-5qtjxgsWC76nCfI5i_gksNDzUDVkK3mzc_bx9dh8lCCfmB267KUpXG-5h28tHRV-_ghQQNJI6t1>
X-ME-Proxy-Cause: dmFkZTF89yHWhEV3G+/SbV/s9WqF8Nbf5qEIE0SPyDXRWiqNBBDox7/HJ5JqzI+i4ozITX
    JfZl9utkD3GQeT5BEgZnmRGxeSAzxlyiFnXh8b7NmjZ5UT/+zH7U/SO1CBHzM+i2gh/4BR
    P17JI/DhzWvs75bT67f+u4VxCNXSEGw124pUilFbQuxOxxpdNKLiYHSUidMSN421/vhPUp
    9PBUwqo4/QIn3q/5zx5KmOPdYuFBlVcJm9M3IyODia3wZUY57jAOOaiSuXjjLqTEOek/ag
    Yc+soBQsykOn8F5yomszN3azr0KJfcRhMY9F9hZe5niP9cEpT3zKAIZNYVvhnOY9Exw+go
    fnc+HxmDW1LlyHYr1yZn987lFPC0Jn81zgz63zeyjUqeRZivfYvBJwF8w29+goAS+87cC2
    9E19UbG5hThu/Ar7+4yQqKJxN+9YTlOhVB9F+MsAaUtoc6BxqCtgFMbCmsepIlJrPBDprm
    VZ0NWN7dSvM6nVC9m0bgnYazLMd0nvua8JeT140erN7UU6hvvwNlBQ9+i4tYVmSypualYl
    hV7poG8BsZyVVzAQWXhp/jymywY27svJD6czC3SMU9PcBotzB0NcqY7XHzkdBx7TGtUN2K
    63cjhEEbytxMYvVw2IGszZo9CJoTWY+B02MM8RJQhgvlERxw52/8JeRRLJsQ
X-ME-Proxy: <xmx:WrM7auo5hKTgfwDXKlOkunTHDALZBBmxVuPCiq0eYdsG0dwa83InvA>
    <xmx:WrM7ajhgbpIsi4ft_I06qOO4irDzJfJY_IGRhIIivuXdqPpnQggOiQ>
    <xmx:WrM7agLJotHLKF8oFn6wVXzkJQISS6t41GiivksNZkulCY0vTekFMw>
    <xmx:WrM7arBrkvpXEuQqXjLKgYR1UxiGdcnQOkLGDjHAP8xC50uF8Y_ZzQ>
    <xmx:WrM7asSTpTh83N-xUv_5cqB9bmMrboKe4_ru8sN762KsXqrETpEC1RZ9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 06:37:13 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 234668cc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 10:37:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 24 Jun 2026 12:37:04 +0200
Subject: [PATCH v2 2/4] odb/source-packed: support flags when iterating an
 object prefix
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260624-pks-connected-generic-promisor-checks-v2-2-132d73ee47b9@pks.im>
References: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
In-Reply-To: <20260624-pks-connected-generic-promisor-checks-v2-0-132d73ee47b9@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.15.2

Callers of `odb_for_each_object()` can specify an optional object name
prefix so that we only yield objects that match it. This is incompatible
though with passing flags at the same time, as we don't yet know to
handle them.

Loosen this restriction by calling `should_exclude_pack()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-packed.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/odb/source-packed.c b/odb/source-packed.c
index 3afc4bf01f..6f31f0ff94 100644
--- a/odb/source-packed.c
+++ b/odb/source-packed.c
@@ -148,6 +148,7 @@ static int for_each_prefixed_object_in_midx(
 	const struct odb_for_each_object_options *opts,
 	struct odb_source_packed_for_each_object_wrapper_data *data)
 {
+	bool pack_errors = false;
 	int ret;
 
 	for (; m; m = m->base_midx) {
@@ -171,6 +172,20 @@ static int for_each_prefixed_object_in_midx(
 			const struct object_id *current = NULL;
 			struct object_id oid;
 
+			if (opts->flags) {
+				uint32_t pack_id = nth_midxed_pack_int_id(m, i);
+				struct packed_git *pack;
+
+				if (prepare_midx_pack(m, pack_id)) {
+					pack_errors = true;
+					continue;
+				}
+
+				pack = nth_midxed_pack(m, pack_id);
+				if (should_exclude_pack(pack, opts->flags))
+					continue;
+			}
+
 			current = nth_midxed_object_oid(&oid, m, i);
 
 			if (!match_hash(len, opts->prefix->hash, current->hash))
@@ -198,6 +213,8 @@ static int for_each_prefixed_object_in_midx(
 	ret = 0;
 
 out:
+	if (!ret && pack_errors)
+		ret = -1;
 	return ret;
 }
 
@@ -260,9 +277,6 @@ static int odb_source_packed_for_each_prefixed_object(
 	bool pack_errors = false;
 	int ret;
 
-	if (opts->flags)
-		BUG("flags unsupported");
-
 	store->skip_mru_updates = true;
 
 	m = get_multi_pack_index(store);
@@ -275,6 +289,8 @@ static int odb_source_packed_for_each_prefixed_object(
 	for (e = packfile_store_get_packs(store); e; e = e->next) {
 		if (e->pack->multi_pack_index)
 			continue;
+		if (should_exclude_pack(e->pack, opts->flags))
+			continue;
 
 		if (open_pack_index(e->pack)) {
 			pack_errors = true;

-- 
2.55.0.rc1.745.g43192e7977.dirty

