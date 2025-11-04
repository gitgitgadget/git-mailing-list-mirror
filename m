Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD4723EA8C
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222179; cv=none; b=StJSlKQHilvB0qLdC5w/hM+QUDsbiknC/ZJITtWxMiiauwwORcpWcUWXGNsty716JbkvKvLxovGOHYIqFJf6VtwoSR7eFK81m3dA7628ePC1dpqzaOLqV8juuJZet4c1vu2DsBT/slaaJLCFFWKO0blB34ThJFAooTF1jpHwP7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222179; c=relaxed/simple;
	bh=I0rQNIz+uuZ9cNAJYFfsxyi/W8m5PLsCxD0Cwbc+tbA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MGbnlroJDM4b9w/3CwAhjMeAvTmgamCeJELkOQC+36wdrpFP2RPpEEqv7j2a0QGdlZhZ4/rQRWmP1wIj4dWEChjOU0TcDDL8p2Vt1EuBq9y1zcTy6EhZiyDnsiDTNAiFRgzPxLce+g/C36C4j06lEZPlgNkCepcaiofa8ZvIoTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C8Nw+Wvm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dD7ch6nT; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C8Nw+Wvm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dD7ch6nT"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4FF437A03F4;
	Mon,  3 Nov 2025 21:09:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 03 Nov 2025 21:09:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222176; x=
	1762308576; bh=rySIY4znJCOJPumcfXgCt2I+ivGdc43HSStavpnxRhQ=; b=C
	8Nw+WvmK9uROOL/KMJyVQP8xl4KXu9TykKCeavFNMTSVGbvT+xUznmIW+OvIgWVe
	f/PVPA5HEUGD2S1spMxYiqx93yeGZC4aba7h2PeedSq/j/lqOrNhmpoQ78k357XD
	RsVyzPGv2qGUHXXwVFgcCBYng7Y71cWLwJPjhiOXqTPUzBS19uJ1LMJTmr12IKl0
	1p/75GnyhIu6RLJfS009DRbvpBrS3lLnOJi8jBTHPaF2WpDX5VE1fqoxXG8sAqnC
	ROW5xPuiscNdRGlXTrWZu0u/XSTX6w049ClwvUPr3PrYjr+BHEnuqNwCcKRFo+Oj
	KZcY9q5fqh0mBFyrHlv4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222176; x=1762308576; bh=rySIY4znJCOJPumcfXgCt2I+ivGd
	c43HSStavpnxRhQ=; b=dD7ch6nTjDbA1/NTLXPKZt1qMH/7RLMTcW/g+qD4ty2Y
	Q8We/R1PF2I3MC+egPdosV852jtkD6dQJMg5xEhT6MnGZcmUKo4gShbLipAiMFty
	8YuPs7+GgRzlcL0xYhZnaJb+UkDQbtE2hSMKysfrAng+BtgXs6ki4C44h9xHAYe9
	SYJltE/wsWmEq38EXA4NuwwdvgLpWS2K1Z+Yj4WMAS7+Rl4BmTLu/LLKm8TO+quC
	DJLqNk3RidE/Wd6O9vs+sqa97VnfglTG1+boj7h0mkaMBDtGt/UiXfFHcFMlWWKk
	N+WGj8nVchnr18xYkoq69i1SFlFznXkyc23KBp4N2Q==
X-ME-Sender: <xms:X2AJafbfQm3EyhxiUeeFarAhgyqSD10WaH9XQE76olabdAvqrQj48w>
    <xme:X2AJaUb_Cz6rj55h6b3aqFkoWsZ2pYpoceQ79gfE5hukHsgxRbHJlX_fbjS23XEiS
    sLAaOBRKa9cbfVMfHE354iJrvCbnkLBLuaGO0qQPtUDzKK-OXf6YQ>
X-ME-Received: <xmr:X2AJafmKRW90v17UB9-CDOkQh4EZl2Z4sUjqFx15dydoByZGfOoNAhNnk1DmcTD2O0x2So7kPMm4t5PNRva2LZjXp0_MXHs9g9MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:X2AJaQwr3g40vsXSQiQLw6RYs5Z5kEc7yeyoMcpNS9HGtD_ow0TC8w>
    <xmx:X2AJadOZG_D78bQQwqHbcmuN3Fqfuw80BkP5JD0V5uXTa95kUdmWCw>
    <xmx:X2AJaUT8D24J0P1Kz2BM4Gjlu-Pc4ywN6WDwUY0pXJRYDKalg1cy1w>
    <xmx:X2AJabYzuJuQLFV_EA41AJV0RtMAziJ1WMJ2oghTooY4Z045EjXD2A>
    <xmx:YGAJaSwhRWF9aSBNetqUFgBgVxEx-bfBPP0gVR2KT9TM_kz1p2j_xrr5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 03/12] diff: correct suppress_blank_empty hack
Date: Mon,  3 Nov 2025 18:09:19 -0800
Message-ID: <20251104020928.582199-4-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0
In-Reply-To: <20251104020928.582199-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The suppress-blank-empty feature abused the CONTEXT_INCOMPLETE
symbol that was meant to be used only for "\ No newline at the end
of file" code path.

The intent of the feature was to turn a context line we receive from
xdiff machinery (which always uses ' ' for context lines, even an
empty one) and spit it out as a truly empty line.

Perform such a conversion very locally at where a line from xdiff
that begins with ' ' is handled for output; there are many checks
before the control reaches such place that checks the first letter
of the diff output line to see if it is a context line, and having
to check for '\n' and treat it as a special case is error prone.

In order to catch similar hacks in the future, make sure the code
path that is meant for "\ No newline" case checks the first byte is
indeed a backslash.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/diff.c b/diff.c
index 9a24a0791c..b9ef8550cc 100644
--- a/diff.c
+++ b/diff.c
@@ -1321,6 +1321,11 @@ static void emit_line_ws_markup(struct diff_options *o,
 	const char *ws = NULL;
 	int sign = o->output_indicators[sign_index];
 
+	if (diff_suppress_blank_empty &&
+	    sign_index == OUTPUT_INDICATOR_CONTEXT &&
+	    len == 1 && line[0] == '\n')
+		sign = 0;
+
 	if (o->ws_error_highlight & ws_rule) {
 		ws = diff_get_color_opt(o, DIFF_WHITESPACE);
 		if (!*ws)
@@ -1498,15 +1503,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	case DIFF_SYMBOL_WORDS:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
-		/*
-		 * Skip the prefix character, if any.  With
-		 * diff_suppress_blank_empty, there may be
-		 * none.
-		 */
-		if (line[0] != '\n') {
-			line++;
-			len--;
-		}
+
+		/* Skip the prefix character */
+		line++; len--;
 		emit_line(o, context, reset, line, len);
 		break;
 	case DIFF_SYMBOL_FILEPAIR_PLUS:
@@ -2375,12 +2374,6 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
 
-	if (diff_suppress_blank_empty
-	    && len == 2 && line[0] == ' ' && line[1] == '\n') {
-		line[0] = '\n';
-		len = 1;
-	}
-
 	if (line[0] == '@') {
 		if (ecbdata->diff_words)
 			diff_words_flush(ecbdata);
@@ -2431,12 +2424,14 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 		ecbdata->lno_in_preimage++;
 		emit_context_line(ecbdata, line + 1, len - 1);
 		break;
-	default:
+	case '\\':
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
 		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
 				 line, len, 0);
 		break;
+	default:
+		BUG("fn_out_consume: unknown line '%s'", line);
 	}
 	return 0;
 }
-- 
2.52.0-rc0

