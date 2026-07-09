Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6F93EDE70
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 08:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783585770; cv=none; b=l5cX03SqdK04jMrEpYDigOoG5EFgXNJTgIJmXounmsIyWyet5FJH7FFPaLrNtijOd7x1JVioETlLiwkatvauZpV1IpyzswzYAgzu2kdkknOetilqojEYn6urtCFCXQbpX1yegtboGXpdLPmx6NsekY5OX+T50sPVbU76ktv40nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783585770; c=relaxed/simple;
	bh=oFFZvh4baTcnauVu/r3lpsMt0YkGBVzoY824cgCw0uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rV+3G7N1HYzcPHOeh/N4aXoNXH/mzyF4GcZb+fOIqbhrlAoc9cCddQqBDyf1dyySuFm7WwmvBSteINakTLPnOKEpGOOyOenTPJj2da2VxWtB4+CQwo0mpu3JjhGxUkU6O/ZfWkY2Gr8FYfy6Y0CCdH4W6ahQD05D1vEKIs56JCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=b5im2K1f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OZCIqjFm; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="b5im2K1f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OZCIqjFm"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id B83061D00067
	for <git@vger.kernel.org>; Thu,  9 Jul 2026 04:29:28 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 09 Jul 2026 04:29:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783585768;
	 x=1783672168; bh=Pion0wRNBZYzrMTph+J5j+B9JfFfqYb6Gi4OhBUXSug=; b=
	b5im2K1f2IGCtvy1mdSvJ0UKIub92/d2s+TMobLbequ8YMNaI40IKwExjN/4bl8l
	kEermOBhY5RxaBGhvWWg+OAhCP9O5ugm76C1+i2vWTmH7QwRxFhwkoi7sCy5U3CU
	80DWYrH8JVUU/Oyk4mD2S8x9SgiTDW413pnBVtaNDdOIxXd8YPWgiu1kFijVNjM3
	oj4ilPxaGhPINCRXdYJMg4PyqHMeW3pQoZRwYOXFTQt9ObQDkAELOhy2dOdDrn7i
	l0GEJoX8XBVYXbsmTfbjJ9a4GIgLqyK8fLnh2gVEOvthZrr8+it5VWHeQrs53DT6
	iDK28I3FKFKjjeX9XFXmoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783585768; x=
	1783672168; bh=Pion0wRNBZYzrMTph+J5j+B9JfFfqYb6Gi4OhBUXSug=; b=O
	ZCIqjFmIriQvsKMORfAE6PdURJI9s0KuVxLPGZ4hJYBXejLH5w8f3f3EnmGmch1Q
	ZLMiMzpn1POtO0MoMCD6/EfbhRACVZSNLvOpjHrcECLS3vwkpklWqeKn/bxrgKiz
	pG+/qCb/shF+z7HmqE/6IBTUmsUfQ60XHrjrplHmYYGN2XMGyF/Qryh4QU0B/K1O
	rK1fgRVvrY1ygKmYryTsDs7vO2TKXWAgcu4HCk5phgjMKgtmwIQ2NTB6MRSpUie/
	Zeb3fxmvb2e5ZG7XvZTn3UNN+GZLtRYPVf63CxaRR7UjJa3SBSbYkdiogr3cVqME
	buNl/KiNp3xE5SvDC+8ng==
X-ME-Sender: <xms:6FtPapW6eEg_SR0Rz4p1T_LgQ8a_nAkHV1b5k3kHc-QMaGvffJM6Zg>
    <xme:6FtPaghkBTFlwMjqR0fcY7Dzfh1jnPgW-a09jF4ndlJrF7yfG2Vg6bJ0ylF6o8orv
    FLTt1n1LXaqLWwZlQhwBOEYhHe6fj-HzoKA8LnFtOFrsD8bz94vDQ>
X-ME-Received: <xmr:6FtParAyrVoKpNGCOY-0vjXqxsRCyQcTPLIG73bVTJaWNatP00w9juEnD13PczyehEBK0hyV7GvmkVnCLuf_Tg5h_oS2NbAe8CnlUC6CXA>
X-ME-Proxy-Cause: dmFkZTGW/m2nYeHrM3uVZFDzPh/FVsTDRbKILxkD0mPsEQEx6NoCtq/bwFNXkWPXaSAkuD
    4p54uG5Uh5Dh6ZSxJytYQvLmlPcYNrob8TN6hVuww99rCMLLsaRIpUSiv/EiRTrjUbgClZ
    pf1TPvoa05iUVa5A3okWI4keg9uBepLNYr2RQWN0eoH8XQEhk9bReuTuJUYM/jasd0kux1
    ZOryW4/dTFeEiQKe67AJOKVAo2jxuKSEFahev71rHiXcEb2ezYl81dIyEw8ptzmLIBaD8P
    GRPWp4JiOWYBBwsLWKiWK/jamKWlkomhj3+ANtmAdtXXyp3uXB4PuEzihkbhugd5kTHnPF
    IJ0VMz6++qEn1O3dGFWEYmZBSsYKrgujmSwWQyuu9TyDPxz0Qyq7lfri4pVnPhYkNiYupo
    acTew1biE+35tuUdTorsAeoSWO9lvTFC/u0ny1uFHSRsMfIrM5GAxHs+cfUbe2sENpv0Oh
    xnWM0i3scEbAvgd2RzF9kyipnNNJw1TAuZ28Jr72r8nDL1EDE8hnIaKKj4ubBZbKV/aUSr
    KzGgLsjM1UGGLDVq14h+ikeZJcB6SBtvlhVonJn6V5Cy3GRBRlfWyLvru5B0Hx/4+E0weP
    4YN5Y/UWZjxrRw8ZEFJ7iL+m3Jwipr+ExE9sp+jvUlbskhOZhjLKdBxjteAA
X-ME-Proxy: <xmx:6FtPahc2_vk7RKaptXcDzSPhu65ouu6Qn68DeHbCx9Cx_ZglIFmOVA>
    <xmx:6FtPajenLkY-EO5EyQUqp3-csXiYS8tOkC5uld_sm57vadixxnrYyw>
    <xmx:6FtPaliJd2bbUXuPpPIX5PvD0NHPduYoe95QVK_BsiilVlHQ60N2PA>
    <xmx:6FtPavSTaQJJK_YoxBKDK6wFi0qKcvPJDpXs8hGnDN-qfw1aMLxp9w>
    <xmx:6FtPakk5WPrcSa7AvVF-emzIz78gZfDkimKEYAQQVDyhYXcnleWnA_E_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 9 Jul 2026 04:29:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 12d94d92 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 9 Jul 2026 08:29:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 09 Jul 2026 10:29:12 +0200
Subject: [PATCH 1/7] refs/packed: de-globalize handling of
 "core.packedRefsTimeout"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-pks-refs-wo-the-repository-v1-1-1ad6f27529c9@pks.im>
References: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
In-Reply-To: <20260709-pks-refs-wo-the-repository-v1-0-1ad6f27529c9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When locking the "packed-refs" file we allow the user to configure a
timeout for how long we try taking the lock. This is configurable via
"core.packedRefsTimeout", which we parse in `packed_refs_lock()`.

The parsed value is stored in function-static variables though, which of
course has the effect that we'll only ever use the timeout configured in
the first packed reference store that we see. Consequently, if we ever
were to handle stores from different repositories, then we'd use the
same configuration for both stores even if they diverge.

This is of course a somewhat theoretical concern -- we don't typically
handle multiple packed stores, and even if we did it's very unlikely
that the user has configured different timeout values for each of them.
But still, this is a code smell, and an unnecessary one, too.

Fix the issue by moving the value into `struct packed_ref_store` so that
it can be parsed per store.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/packed-backend.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 499cb55dfa..5c49c06493 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -162,6 +162,13 @@ struct packed_ref_store {
 	 * `packed_ref_store`) must not be freed.
 	 */
 	struct tempfile *tempfile;
+
+	/*
+	 * Timeout when taking the "packed-refs.lock" file. configurable via
+	 * "core.packedRefsTimeout".
+	 */
+	bool timeout_configured;
+	int timeout_value;
 };
 
 /*
@@ -1233,12 +1240,10 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	struct packed_ref_store *refs =
 		packed_downcast(ref_store, REF_STORE_WRITE | REF_STORE_MAIN,
 				"packed_refs_lock");
-	static int timeout_configured = 0;
-	static int timeout_value = 1000;
 
-	if (!timeout_configured) {
-		repo_config_get_int(the_repository, "core.packedrefstimeout", &timeout_value);
-		timeout_configured = 1;
+	if (!refs->timeout_configured) {
+		repo_config_get_int(ref_store->repo, "core.packedrefstimeout", &refs->timeout_value);
+		refs->timeout_configured = true;
 	}
 
 	/*
@@ -1249,7 +1254,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
 	if (hold_lock_file_for_update_timeout(
 			    &refs->lock,
 			    refs->path,
-			    flags, timeout_value) < 0) {
+			    flags, refs->timeout_value) < 0) {
 		unable_to_lock_message(refs->path, errno, err);
 		return -1;
 	}

-- 
2.55.0.175.ge4962bd3d5.dirty

