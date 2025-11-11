Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B70219E8
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819506; cv=none; b=O4hXTqy2+TGs03Ea3I6XckwwWLRCBZaElD7qy26OldA3DrhhPrTilUO0BcGx7wOp9Yv1G0z+s9Ygw+Qnpv8UvrVcuwRs6tUV3GQc4G4s1N3qLWqS167RDEIzLuToBt6Bbxqu/ZC31Ht6ZOzuW7K9n1U8r1p4brfHGUkxG6Om00w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819506; c=relaxed/simple;
	bh=wmk0ROzwQ0Uqbx7BkvQmxZ5mm2zd9plfq5ICYdpy75k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aHeYeshPsoh9/6lfvoqUoL6/8VCFm4m+C44TAY6vHSF8JKbO/cckjFHyxfTGqA8EYVR1tLlDNlHueFmV2qnphmlnBWIXaWVFPfYZmWmQOeb0OlTw8SQr86jBVr3crk6PF4D1/mNfA2JGwjs/kegVCoJWD8I5/rqOKDiraGSZREM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RJwNG+Uc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=slHxsztH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RJwNG+Uc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="slHxsztH"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 859ED7A01A4;
	Mon, 10 Nov 2025 19:05:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 10 Nov 2025 19:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819503; x=
	1762905903; bh=+oB9rSY/DnMfCP3ebbOTEIHzdYJhpmzll5uZQ7EFB/E=; b=R
	JwNG+Uceje0S24gOxSzVJ2wHsLiVC19X4PfdPrOtnytib0NxvPzbvrhyVrPNmBYc
	sPJ8fqrN0wc7uAgJ98jG8J6CskotLTpCrQHI+rO8Ct+QxcR/U/nboW8IUZAZA/DS
	uZjedPSmDpAIR72c0PL2gamcLthMHtDy5tly2lku1gKqgej9NzasmWR7aqygNBLx
	F0ojXHkrRBNPASEA+5KNfV3KSwcTXQIDh5OBau4qpwYWOe8bMhT++gMvMAKx79/i
	p609uhtKiJu7Nki0EtQBU9HftfTPXPr50zQrdR1+gAKFBLlPmot18dB8f5EGKSfz
	8DSesf+03P3AEvR48MoLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819503; x=1762905903; bh=+oB9rSY/DnMfCP3ebbOTEIHzdYJh
	pmzll5uZQ7EFB/E=; b=slHxsztHaR+U4DsQ2/wk6gupETG497HDd6QEuiWNWato
	/EjmZ+UaolWq0qEaBzG0/+eEoypko1raqeIx9C9shAcONcKA8KYYb7AdatwWnbaR
	Dz7nwlaLB7ChdVcLRmmydDyuBtSxzukx4NlzIVhygHnQSjnKi45Y2W+XclAFyaI4
	1vKhJcvw32XD7dXiHXcBSHMhoLemVeJ38ENscz5fh7g341Bk3w9pk2zf2Vk9IoCH
	ViZ9i9eWfPoecJFBWK59c18gF85i85Blix0vJL82U6v+qXd4lo7pRvALPjPLHXM9
	tkYbBj5QRiFVHRYw8kFfoCru4G2lyH+tGy+Yjz/lTA==
X-ME-Sender: <xms:r30SaSt0rviSXb377Ldokeq_ALS8yi7Ez7VlmKCrMFUjMcWbrNsp3w>
    <xme:r30Sade33dhIK8B_MbdJtUrl2BzpGB4i_xlTZS7zT7HT39zS3R34BWjtl-kFQI9CM
    z-P6e1fLWimLy78NAqxlRNZLdYRe4vAP5Th7wvO9eTbRbtBpe9VpQ>
X-ME-Received: <xmr:r30SabZmD6p5zoTMYD-uzb9EfzJKjPSOYPFThwX2YsQVvDZaIauzBTOymK9dCb1oI5_slkQjQs4dN1cQ7k_Z2AE1zvnulaFiWypv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:r30SaYWIeOrlyE6zPItnzI3rQw921eQG-K2MZHs2_wS7j7o2dVVZQA>
    <xmx:r30SaVgcXDqd3_fozMFv0ue7D1WvvhutN10vqqbPFofaH6xrXEDx2Q>
    <xmx:r30SaeUMZ6nag5H7mTMgBG5Ubmk7MJJEQ2_z8YcsU14c7xSHRWRZxQ>
    <xmx:r30SaUPuJgtrFUBMqZHNVAhSxxYuGygWmjcXDEEpkZIHdxczN_-RxA>
    <xmx:r30SaeHzHxFeGdNuz4k3_dcWXZ9lDeyqyg2GeOTQC5WHSk-3fzB7E-AM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:05:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 05/12] diff: refactor output of incomplete line
Date: Mon, 10 Nov 2025 16:04:44 -0800
Message-ID: <20251111000451.2243195-6-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251111000451.2243195-1-gitster@pobox.com>
References: <20251105213052.1499224-1-gitster@pobox.com>
 <20251111000451.2243195-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a helper function that reacts to "\ No newline at the end of
file" in preparation for unifying the incomplete line handling in
the code path that handles xdiff output and the code path that
bypasses xdiff and produces complete rewrite patch.

Currently the output from the DIFF_SYMBOL_CONTEXT_INCOMPLETE case
still (ab)uses the same code as what is used for context lines, but
that would change in a later step where we introduce support for
incomplete line detection.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index e73320dfb1..8f1b4e6069 100644
--- a/diff.c
+++ b/diff.c
@@ -1379,6 +1379,10 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		emit_line(o, "", "", line, len);
 		break;
 	case DIFF_SYMBOL_CONTEXT_INCOMPLETE:
+		set = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, set, reset, line, len);
+		break;
 	case DIFF_SYMBOL_CONTEXT_MARKER:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -1668,6 +1672,13 @@ static void emit_context_line(struct emit_callback *ecbdata,
 	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT, line, len, flags);
 }
 
+static void emit_incomplete_line_marker(struct emit_callback *ecbdata,
+					const char *line, int len)
+{
+	emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
+			 line, len, 0);
+}
+
 static void emit_hunk_header(struct emit_callback *ecbdata,
 			     const char *line, int len)
 {
@@ -2442,8 +2453,7 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 			BUG("fn_out_consume: '\\No newline' after unknown line (%c)",
 			    ecbdata->last_line_kind);
 		}
-		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
-				 line, len, 0);
+		emit_incomplete_line_marker(ecbdata, line, len);
 		break;
 	default:
 		BUG("fn_out_consume: unknown line '%s'", line);
-- 
2.52.0-rc1-455-g30608eb744

