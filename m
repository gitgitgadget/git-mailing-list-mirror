Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD5B2DF12E
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378263; cv=none; b=lzKETNFD1SBVYMKuvshce5cHEYdnHd9gNpqoU/gAEnKbkfgAtNno8bXz53PSE+lj1g5eLs1r227Ko0JW6FQhbNueQozpQ22ZgbUeoCXqk8iCcH5pTqCEkzABbD/iyeuW34OyqSeLt8lrR3np7rwCJ3vxbfn/2ZeGHK6Ci9Q+Aoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378263; c=relaxed/simple;
	bh=YN1GNF4oOUgl+cLaUxosAn7GHbsvjy/tlsubER2sb4s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XuZbMrHeyEr2WGvALCmX3KZsoSGan3G/ULsa+BZnu7atLpF2TamBDp4cVcnXVbJA3aJRvw9Vo9VWe4PjRfFIhRmavx9ZwTrcQ+VQ7FWs4WXkp5Xui33W49adeG+ewJ2lPF9e4ogW3/KC7+i7SeL7qyML1dx5WY/vNmDW1htKXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VZO7xu4j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GLn8elJk; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VZO7xu4j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GLn8elJk"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 92E767A01EE;
	Wed,  5 Nov 2025 16:30:59 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 16:30:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378259; x=
	1762464659; bh=pRpW4mY+mP+bRxbjEVAS2tiAVjfQMTKDDPiIZ2p/3fE=; b=V
	ZO7xu4jDhPwW3u3eHEZlPY4CTW/xVtZkslA06iFunOZtUlUj1g26KNx/57FCK4Ga
	JjW5PBV8IfkST5KrznmP27LYlzXLQkVFv2lN397yoRCMaOb9GTTImWTzjgruDfei
	FdrKi/lAyBTQ8AXIhptHricvkN6bsXZjVzsiETNH5czHpy2qLzuiMdb4KFHd3msL
	0rhTEO3j+ERr4Dj5AX6D2H9fnrw7gBuvfursH5lTvaiQuBg3htvJzczxZ5+0ENZz
	JQpLf3S2G2z7J2UYL/lofPZA1FaeVaaOJxeHFOvOG6R3XvpH9pa0QaOu8Cp8QS8l
	hvHS2RVk5ZRmLttT709EA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378259; x=1762464659; bh=pRpW4mY+mP+bRxbjEVAS2tiAVjfQ
	MTKDDPiIZ2p/3fE=; b=GLn8elJkByfBcOKVhNnCX8aIfTlMss6bqQYNJj/uKFSO
	vJvTa+9o9ppdyF5R1OqWm8cyUPReA7JzH9C2UQG7gC4ugCtJaCGnH1Ols4mIoxkk
	xtrI9D/HCS4lHCzoseSON63zmUSuBpC1Pz/CJXzHW2qfbB12+DDW299BrDkAGbJv
	XVgrThSN+XDcyPl2yMmqpgMfrTvJa0wNLPyXbd9EMkjOujXWpmKEfldG4AsL4MWT
	ANkuLFKLBJyzhSy79XfO/jKkQ9dis4EzOZ5rE1hX4OtKk4Vu1OPneD953e3R9wce
	Nxz6ouXXXW9GoUj44abfFTBSGuzr1NsnWtfvbNb4Dw==
X-ME-Sender: <xms:E8ILaWxpoDfH0M169LGcBRwZA4nBNesWHhFwXfLl1I_DpknWLhF11A>
    <xme:E8ILaSfh3NlZZFsm9UhIIpLHDsqNCYxe3g1fT9zwIM63GfeeXcDYzlcY0OQ0hFHY3
    zeFwv3BNLZVq3elLKXuPmDe4BN0nOzeCPX8oqrw714sA45QjdVw2w>
X-ME-Received: <xmr:E8ILaaIwI78zPfE0u0COf_mquh4tZdPdvzhdDNMsTH57n3KxwFB0GVMRCTDQaGIswDXE7JmcUS00fvQQXd8dWJfAyOEaAVqV_8x0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:E8ILabG-yzoEXhpEfedZpqMFZPnYeUalcWYxli9kvx-qGCwldRpkYA>
    <xmx:E8ILacoi1_x4TOC-rZTkpurFLkAZDEz2wOMlLmiWYddC7TuSmaxKIQ>
    <xmx:E8ILacT-pwoYlwxXst-DbEO0UbiFUoLXv4OXlwmTAmzHDp2AHDTRCw>
    <xmx:E8ILaROJ7f5W0wnr1yrc0Rn-vX4aYSXPIvW-jrRM60em4x154ZTABg>
    <xmx:E8ILaRWLvm6LyYdiJ34buqAumuCMCbgZfhMoDScqV6JSrOSee7I3eDSM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:30:58 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 03/12] diff: correct suppress_blank_empty hack
Date: Wed,  5 Nov 2025 13:30:43 -0800
Message-ID: <20251105213052.1499224-4-gitster@pobox.com>
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
2.52.0-rc0-105-gc08128fbb6

