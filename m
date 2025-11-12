Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9452EBB9C
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984988; cv=none; b=Y7JGF1HqGs4a1VJcMJj+32PaoqNexOplq+Z8z8KH1YdNCZxAZvyp7eOMuRhTz3ouT2qTBhBXhQJoXyDHJCThi0KagaEsP6jPYSO2mxmZXkpuKwCwJk0v7zKEh4rUotjh+wujyIqGiyZYgVT/nbBAnpb54LBzhpfFFglCn6dMvt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984988; c=relaxed/simple;
	bh=xd9jwlEVE8YZX2aK01AsKP9I+68N2k0lRbGeCPPpuk0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hVBgIXl5l6w2pEEt+tqedUWBJDoZqogIYuq+cq/L8/DzsatAfbK3qLsupdPT6ZSbapBc5ts/wZIxfG2+DUzBBo1jsWtAgzqe/zBtkTOHoZeH/kIwdxe33JyPFqohl7F94yIfmpel0fk5kgkJAq1ZOZt7GJzFeXL0cDTtWThTW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kVT+cFpl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yI+35CI+; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kVT+cFpl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yI+35CI+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA7E27A00A9;
	Wed, 12 Nov 2025 17:03:05 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 17:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984985; x=
	1763071385; bh=05Izs8HOq4Wd21o0IyCSQJfV29066MkG6utzZPkpUfo=; b=k
	VT+cFplsR3pigs/UWnQvXcg3uHhDgSlZzIPf8foVCxmMfJVJ+vj0VTmGpun919aE
	v31F4CAcKmmuTer1HYXutJPoqRE0y8yMmDq0jOvnsdSR7XlaP0MEO2MaXO0iLvAJ
	JS31RV84QGw7ajKzVPqPXgTXPElu3vpD7oEeurH26hB4TwC596/G9TnrhuDiVuH0
	PjkB8kOGrwcsIc0sWLMduBOcKxYoQCaLDQNkym4LOmOm0jIe1T+CCkNXB5on3Nve
	0SZ4hU/Tc0ZKTuVp2jBbe/3tSs7S/OvnVUaf6eentLdihQGjLkCrNz5/Nmbs3JYR
	BmrM1BKcVuaPymkkJpBOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984985; x=1763071385; bh=05Izs8HOq4Wd21o0IyCSQJfV2906
	6MkG6utzZPkpUfo=; b=yI+35CI+xmMJuwUDaW6YW1dW9dWZqXHHnWs49gzC4u++
	241aH0O1twuYj9Uadf96Sn14UH/zyrep5IvCcwYsJ9//6NVNFehdy+6yDykuqLd8
	VGsMm29IaSt/spaAiEXZBPhRcWWsi2u9LFuI/ACOgixiwKWQBD+vlPv7+KyHKvTl
	OFrMbVKXLeIRaRWeSCEPM26YvQHFTMuaFMBUbAyHKGEVXx1Yrnldz7PYCXD2Kws9
	Rv/v4H+EDydSjQ/FtcSBzzRyC/p438P4ONLhxnBI3aoaBrw5uGvedZPIfUF7rrvH
	74TVmBOlSxS20BLH70B340u+7kLhu0E4SXsPB6Kc7w==
X-ME-Sender: <xms:GQQVadVZ_9dFLT2v_yVjwQTo4nKnfgmsCSS6T2hWnGmjvePAQB4EpA>
    <xme:GQQVaTk9XsEasIIpawAkZVpIsNyrmFo7W4GRqkPx9BVim0iiFSMibRKAUBEjEjuOn
    w-fQLnNgZflIg0Qk91YTKs_8ljPyt0yp_EN7jv0DZYWy7SYj-2TBw>
X-ME-Received: <xmr:GQQVaXA99hLnhGhApT05oTr9AoICIa_i1WdN-rZ91uz5QG05muq0HIGNvhwQaMgSAjh1bMNEtxI7PDw7ihmTvLAxbwH3pjQ8mQHm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:GQQVabcRJTnDtgue-mKpA3WG6S3Rj919QeZWVrUbmcOWlVbz3AH2GA>
    <xmx:GQQVaaJyLZNDnndfjf8HxiLtUPNjBSi7yROZWyytt8bmtqwy1RCaBg>
    <xmx:GQQVaWdGR0bE5x7UgNsdFzpw1h5C4pPwBQ0twXFxPSJTp7nqYEj0LQ>
    <xmx:GQQVaZ02IgoTVKj8HfaF7oPOQ3ElhxnV58eNOiOVgJDTNiqEgNayeg>
    <xmx:GQQVaYv2Nq2J_20XzRUipFy14tusxOo5mlyPmfCrqaCYuBYoxeLni4Nt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:04 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 03/12] diff: correct suppress_blank_empty hack
Date: Wed, 12 Nov 2025 14:02:49 -0800
Message-ID: <20251112220258.1009253-4-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
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
2.52.0-rc2-441-g030905368a

