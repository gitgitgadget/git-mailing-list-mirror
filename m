Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE3C3F6C5F
	for <git@vger.kernel.org>; Mon, 17 Aug 2026 11:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964979; cv=none; b=lpLEcdOFsIJIKsXo8qSfNSs0iMbM51qINaz9YSly0gbEh+fjDPtUFl5mM4kC+R4gkM/Q4Hdd9x/nubrvGirCumWDKTEhgDfn9PCBVppUgC6jFWDLaE8MZODS0CUedotno6NbmB1HZ06U/RQ2D9NeNm5XtPVigidT4LmYQDUaaSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964979; c=relaxed/simple;
	bh=JdjxMVDm1ooXyBcAbCPs38Fu7bEsNyRWYPWaGB7tRYI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Em4nZbrlrU+FXG/ERCk3UB8xxL+bgnuSYZgbYBRVHJ2up2Mk9Sk+1Xasc2PTipMxhGkp8mnJttjeTTO/RH0IitcORESOoAYr4QMd+sGc03hgliSdCtP20xU562MMpoB4XHfeff+ZQvJ5o4hlczRkPL5OyC2gUgmms5K9NX8Qpv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GxA1eJH3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KAU3NjYv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GxA1eJH3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KAU3NjYv"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4B9A140008D;
	Mon, 17 Aug 2026 07:09:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 17 Aug 2026 07:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786964976;
	 x=1787051376; bh=u/uSGUWp3Uotsngln7IkbOEfrNXzIvr3AU6CeAIzhpw=; b=
	GxA1eJH30kz8eL+n6qPzVfYtWgLHhy+dT7pOnQ+Q57J+3Dao1FivOVw5IbQ3vXaZ
	nkn38JhbU26U7/Xu/3SzMJtiecwqzeejErzcPM98YdXh6cPyGnL2j5TTEZErCPeD
	C17xUR51LCgsSKkB+bMx7pYuVOMbHGI5RJgpiDas5mGqSntA0RfV763raVdGG+oL
	pFJgGI28knAfk4PIEQJri3ddxIg+L51jD6/EQUIpojp3Px4H2O8NTpd80sgtehgJ
	oOVMBk93V4SDWK0lMID4huiVQ/4dVwPgfJnK4M1ZpePuOAbPUn4LhaEf3flTuGqA
	olVLt8eOrNLLEZ9e+FszpQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786964976; x=
	1787051376; bh=u/uSGUWp3Uotsngln7IkbOEfrNXzIvr3AU6CeAIzhpw=; b=K
	AU3NjYvPda0mZGbSgdCbBOwCU7PmhS70yUorJFyGbDvWE1LiV9fQmw8IsoTynK7f
	l5jbWXk2fhe73eDLHIrIxedeR/1DHMn7dPoMamarHmn62WHakMV4pM1rNwUIQf7e
	tSwYv38LQlsZEE7d5QxX0qYzL0etRh9iHan7s+EJdE0IfSxDmF6sfS/4x1hHD3fn
	HAh8Zdh9tv0nMUwNvbH+C4w4jdoJ4GVeG984DdVJfrs0nWLpE6cgPJRfT//VSfE+
	ru+yj4FaF0IlPskjXEMieXcxbYlQEAk1gHTpjOxC9Tv7vjIJODJbBWZyxVzhRz4e
	4HHYBBE/3yoSdwTjr9jWw==
X-ME-Sender: <xms:8OuCak_f9XjFo_51ZtkSsYjLdj69rm0RNtXwexz_GCJrMVONDdS9RQ>
    <xme:8OuCajvPUyle1Buhg8ezOcbsJc9S-JRqlKd5vKiwI1eijkbQBBcXQ9EHGhmM41fVX
    94U4tZabsAx6xU2Txjpw18e3cHCFgL-avnMKBJ94kLc0jjEe6kS-g>
X-ME-Received: <xmr:8OuCavBLLIeVk1d60g84thU978Y453XBAUGWdPo2AwbdO4h-u7YoeM2rAwbmVw2mQerAjyzB4JGD2ft34eKLyLysPmP4_6UR6mbQVgrqcg>
X-ME-Proxy-Cause: dmFkZTEyzyhEK99/HzK5kLbwTZWbHYkLYwbv8ppMwn+iXQKuoumFOF/zN0G1CWwIgqXFNM
    8tMLbr9TSUnK+x5JVCTQ5jDmwJ/N34CxQZqyrTLnpC+qsrIpk4AxQhjFq1JJ26zTfx7Pr5
    pLrNZj82tBvAqRmO/ZI7V6V/3MoWpSHBBLncbdUWsJLx1j5tHMoSNtLrdRGpS9OsY1HKIv
    0FSG8U1OYctEBa8DoJd/XGm8j6F8Lte4gHDU3lfuIBGNkbgzrC0ePXNX/2C/lsh7nqBO8L
    HK/l6obEfsaBUw3fa8myheGKNORl02DTFNOk4775ER8a9Zs9brTSo/IITfSqIGdMHsk/pu
    Uce3yKGhW0xl7t5qZ2UgPCiTwHWYu1/GmTEM6BWxHxAuNLW9O3nb6kKMfnwt63YMTAzBCy
    O8mB1yf63e3fQSLuZQo6Q0LeB/jq6+kZP7vl23CETjPKF5BvzGpOJ3ZjKWfRcaoAMFA1wv
    ZpPe8NXJuh5sslApBL0CrWRi154dMFOYb+63YSM2V9dX+PP342Dlj3fq3N+VqXe1QzqyYE
    +7Aw1rg5tZ6glqG5oUyU6K4KxlBObzByOv4c86B35hI4oj6pGn7vGSVIE9i/EkH40JDruS
    ir4yGbP4hLoYMxDNYxTbqNAAmHXmtcOmsea1X3QS36Tbkmk2LxTN8s1xw/6A
X-ME-Proxy: <xmx:8OuCajUDdlR75gLrXPhCJhfd5TUOvkk3YMQsebV8U7BAkxX6XfmbPg>
    <xmx:8OuCalAxPpUltDjVet8S_8jOZf5eiB0JhwWN2CTpiyb_B3KfOg7f2w>
    <xmx:8OuCau8sH5DH5O5JGX8Tgs8L99q-Oo4P5LCvlyR4tM2dCZUxtRYRuw>
    <xmx:8OuCakHv45WBU1YAtfAiCvhRIo9tMhsrk1o9VtkBvTnlII-FkOUcgQ>
    <xmx:8OuCai_NdMEWs1ZUIBYSj9l8b_yOUM462jFwSVeChn9mNTwptmrsRFA_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Aug 2026 07:09:35 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1ee32d07 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Aug 2026 11:09:35 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Aug 2026 13:09:24 +0200
Subject: [PATCH v3 4/5] odb: drop `loaded_alternates` field
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260817-pks-odb-eagerly-prepare-alternates-v3-4-1115a7e02467@pks.im>
References: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
In-Reply-To: <20260817-pks-odb-eagerly-prepare-alternates-v3-0-1115a7e02467@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Jeff King <peff@peff.net>, 
 Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

The `struct object_database::loaded_alternates` field tells us whether
or not alternates have been loaded already. This field was useful before
the preceding commit as we were indeed lazy-loading alternates. But now
that we started to eagerly load them we can assume them to be loaded
after `odb_new()`, and hence the field does not serve any purpose
anymore.

Remove it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb.c | 9 +--------
 odb.h | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/odb.c b/odb.c
index d4917c3678..ada42f864b 100644
--- a/odb.c
+++ b/odb.c
@@ -245,8 +245,7 @@ void odb_add_to_alternates_file(struct object_database *odb,
 	int ret = odb_source_write_alternate(odb->sources, dir);
 	if (ret < 0)
 		die(NULL);
-	if (odb->loaded_alternates)
-		odb_add_alternate_recursively(odb, dir, 0);
+	odb_add_alternate_recursively(odb, dir, 0);
 }
 
 struct odb_source *odb_add_to_alternates_memory(struct object_database *odb,
@@ -510,16 +509,11 @@ static void odb_prepare_alternates(struct object_database *odb)
 {
 	struct strvec sources = STRVEC_INIT;
 
-	if (odb->loaded_alternates)
-		return;
-
 	parse_alternates(odb->alternate_db, PATH_SEP, NULL, &sources);
 	odb_source_read_alternates(odb->sources, &sources);
 	for (size_t i = 0; i < sources.nr; i++)
 		odb_add_alternate_recursively(odb, sources.v[i], 0);
 
-	odb->loaded_alternates = 1;
-
 	strvec_clear(&sources);
 }
 
@@ -1147,7 +1141,6 @@ void odb_prepare(struct object_database *o, enum odb_prepare_flags flags)
 	 * the lifetime of the process.
 	 */
 	if (flags & ODB_PREPARE_FLUSH_CACHES) {
-		o->loaded_alternates = 0;
 		odb_prepare_alternates(o);
 		o->object_count_valid = 0;
 	}
diff --git a/odb.h b/odb.h
index fbafee174b..aefb34213f 100644
--- a/odb.h
+++ b/odb.h
@@ -69,8 +69,6 @@ struct object_database {
 	 */
 	int source_paths_icase;
 
-	int loaded_alternates;
-
 	/*
 	 * A list of alternate object directories loaded from the environment;
 	 * this should not generally need to be accessed directly, but will

-- 
2.55.0.822.g20453c30eb.dirty

