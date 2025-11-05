Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D362E0406
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378268; cv=none; b=Em92JhLhAy4tMu0xeJn9ILqX13WDfHWAadbWipx6tmjHpfVVUC0AQ0WQpMYMwXFxSNMUK/CffbS4qihMGYSCchwDuzsjSQ5kZJZAiuZwXahbQR6FkbIcHhjZDtLogCTcafy5TPSDFoV1fHhPeR6O03sRq1RDf7DAIQedTiHmNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378268; c=relaxed/simple;
	bh=pc9/eVop/KP2kELQT4/ln7czprZme+xyf3/ppjmgwyc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOaPYojFqriDZKixh2okk3oR2QcFMxyGT6aF4jWrq6e2SELtCm/4HRSKjpSqAkYXlqXo/ru2EDQNW3JW2rRtk9WCUO2a4ghBbEkVE9XHCXM1zzIAU4dr1FkEDn20I/MYASREd+m7kB4M0IesYR/2qbaEYN2mvCkfWta40i+4z88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cfy3gZQA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zpnUOB/C; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cfy3gZQA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zpnUOB/C"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CB9D27A020C;
	Wed,  5 Nov 2025 16:31:04 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 05 Nov 2025 16:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378264; x=
	1762464664; bh=JJ8nZ1dnvpVAurNSu28L7xtFcJ73do+IHDdl4lyqVg8=; b=c
	fy3gZQAm4gxNIGuXv9n67TLzYPVImGyfVzN+daWKK5TTip+6TDOE+eY6vUDHji/n
	1k8sDB57G2PA4i3tuPysHmhvsPJEHc2H7chmX3e3FmLXQTanOUqPhKfH4ONXfBCB
	BD7tNz+vZ6j2homNJ4T7QvKaEFgNoGKds7111o3QzjfPifAU5TzbTBaFqRsvWa3D
	nKeNo4azAtvIYiSmGRKstkp2hXxEoicJ+gwkY7Dn5UAxrX0DavhO5z8uAUFpvTrz
	Hkcpz/i8eiLwFcJzf1hdthbBIpcI7mBDVZeY8PD4dUo8E+nl53MuwgcppuBT+7un
	4VnqJjrovIfF2ww4i2qAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378264; x=1762464664; bh=JJ8nZ1dnvpVAurNSu28L7xtFcJ73
	do+IHDdl4lyqVg8=; b=zpnUOB/CG5ErAv2Zcu7tNI+U0QrdWjQXtYV0Z5+R4nUJ
	gW68aLRaMXnQwyj8EmGDqm1BKPDeGoWze+aZC78SWmK1hUYDL7zfsYCNS4O12vUF
	3/Insh0XtpzKppzW+gARmDD/hpo/2zvUdI1z11zB47jJSetytzaRX3SGDrnIpf4Q
	3wyALSbG776kF6f3lFLlaHTxvUZBYOjw3hs0/mKlldo0ITaNjPD336UuYeSKadL2
	EdwVr8lz8JIU4lHDUEXPPYGnl3vYNNYxAMelyHe4qDIBAD5q80Ta8K9Y8QfIVxpQ
	iNhc76/k4y7dW6vMza7PR664sJFJfg7y1DDoqY7xRA==
X-ME-Sender: <xms:GMILaUkm8jZPMIcoZAE2nwyyZJ6ByhxmUAMn4eF5iyDTJlqKaoxioA>
    <xme:GMILaZ2CX2XtW-h3sEMiSpWl69qI1gaursgwgqfeCD4yREmFn8fcZM0EMLMIcG6YX
    p_SNtqrlCsJqnQg9iJJoT6UlBE18rNQa-lyGYHuRRluHFiP_p7ogaM>
X-ME-Received: <xmr:GMILaQShCLz2O3wMa7aCcd3b3v9F4miqbEOW1f9OeLma1zLqI6jRIfE6NUzssllHicTDyyiIyPe7T2kze80dLRqKRgL3awZ2BoXD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:GMILabtv4N8wGly3Xg4VB5OjZv0HdtSXLwFteNofghfgPdk2EGNRlg>
    <xmx:GMILaVYSHAsdoyd3pwOo45npXK8ffbUbOsF7R42MTeBMewKb41Gewg>
    <xmx:GMILaQv-TAz4XjZ_zkj4mAS1s9u6YHbwfBJ6EpasVFdjuQ7S6ETk1Q>
    <xmx:GMILaXG_vgAwUY5ReNBH5-21Br2idsscq9NteGods2Z9vkpjqeMn6Q>
    <xmx:GMILaf8M7UzHhzfxHylUdEMT7-0A_oc1EHYJZoXpkKmAcj9Fg0EILiel>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 06/12] diff: call emit_callback ecbdata everywhere
Date: Wed,  5 Nov 2025 13:30:46 -0800
Message-ID: <20251105213052.1499224-7-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0-105-gc08128fbb6
In-Reply-To: <20251105213052.1499224-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Everybody else, except for emit_rewrite_lines(), calls the
emit_callback data ecbdata.  Make sure we call the same thing by
the same name for consistency.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index d388d318e4..347cd9c6e9 100644
--- a/diff.c
+++ b/diff.c
@@ -1780,7 +1780,7 @@ static void add_line_count(struct strbuf *out, int count)
 	}
 }
 
-static void emit_rewrite_lines(struct emit_callback *ecb,
+static void emit_rewrite_lines(struct emit_callback *ecbdata,
 			       int prefix, const char *data, int size)
 {
 	const char *endp = NULL;
@@ -1791,17 +1791,17 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		endp = memchr(data, '\n', size);
 		len = endp ? (endp - data + 1) : size;
 		if (prefix != '+') {
-			ecb->lno_in_preimage++;
-			emit_del_line(ecb, data, len);
+			ecbdata->lno_in_preimage++;
+			emit_del_line(ecbdata, data, len);
 		} else {
-			ecb->lno_in_postimage++;
-			emit_add_line(ecb, data, len);
+			ecbdata->lno_in_postimage++;
+			emit_add_line(ecbdata, data, len);
 		}
 		size -= len;
 		data += len;
 	}
 	if (!endp)
-		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
+		emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.52.0-rc0-105-gc08128fbb6

