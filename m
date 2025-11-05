Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84952877E8
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378265; cv=none; b=I+6i8TANzRENPbHpAI+d2YiNz8UnWxviO3VVYtDyzXWQv04Mhu68x2kmucmAuFTsGg4We+FUqgZeGvrzGd+i/GmKSL58QerlRn3FyMEdQr9kWaIjSDcAVwUCi6MkRh+MFNNZ8limb2MHvhuag9Gx0YXOA+SS0MJ32bUiLRR74Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378265; c=relaxed/simple;
	bh=jAGnjnqjNEu+T97Hg4LKBVP4NMTmtUuuqBcxaHBeqL8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkoAmKXaQ0Bpsyostgau81wDRIGu1FBVp6xGqlPTGcGW5aGOTmL0PfUXOIkIB5nT3sXH/bYS+Poi3SGIOf+9zfoW5SsvMPsftrx5x1lfyWbdMdzCTQKsamXOFdLJvpT2PSuX9noRA2GqAKExv9iCG+51/1ueUwkmeBcV/yYI9fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K4NSWWWl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rQvW/Vsi; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K4NSWWWl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQvW/Vsi"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1B38B7A021B;
	Wed,  5 Nov 2025 16:31:03 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 05 Nov 2025 16:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378262; x=
	1762464662; bh=0vKYr2Avb97pgUl9VDGOTYRfBnbJyjjl7ikT/f4g0vA=; b=K
	4NSWWWl6o7UQ8Jf5HrGf+m82XVcQnjSGqi0qx/8CBmknOuyR42+UXJy7h96GiGpy
	tQXn9hwNH0Wz/rvKwvUNek+LoOY6o08/ka/w4F7ppROdkE1mFMGnuZZvHqkaS2Gx
	8RbARsLG8iDZDaJ51Q9hLDcgTYNT09j1XFU2GoTEkCEMOqzWXpXQhS0kV3GrvRtq
	p34MfB/U/rU0H7EcZk647BLEnN7jF/Sh0TpPgw7CT4tGlO+C7WVa3NaCrAdlJu4d
	KrrroLvm1+dBPTdf+AQTUmqEnwiR4ABXL9MQ9DOOjm+7TRBBQdMKJm9jM8S0pJ7M
	rx5/0fVpNLU5h1uqwJD/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378262; x=1762464662; bh=0vKYr2Avb97pgUl9VDGOTYRfBnbJ
	yjjl7ikT/f4g0vA=; b=rQvW/VsiYi/HvwZeIwYAp7/4PlmxJJG57/HI6iZc1t8O
	IDSmjo6xy5YQosmZDcR0g1AyJJRNzkjD+XatyIlezf+HwfwzZX8Wx2SzQHyvI9OT
	gAPsUu+EUp64zI2JR8IwVbri+6aFb+0g97buZBFe2Ss9S33hJJ1kswNHPIAvjyFF
	oKll2AZ1cm9f9Q6bzhEcVV06TtYvB7TIgJkVuJkFgJ3UMdpeJ/smoyzN3Wmd3aDo
	avtRkxA+s+oo+H9eKdVO2OBgxhzLAWM+GbIJ5ibAk71dYtp14POU8MmQz7QMMOEf
	vO8XcSnvpeb7CbzHYCEQlbj80QXWN4Tz3oBfGPW9rQ==
X-ME-Sender: <xms:FsILaeh0ok4BQtUILvDNZig2ZaFFtDo4EPkWp68pkX-zLF49F52jEQ>
    <xme:FsILaVDWpz7yWYPNPF-DmwWuAD9St58aQqBFhIou35kwXaD9qB00454xFRV1jJCOe
    APqQQ0YeHVFpwE1LmKeg7yV51mX-MZxnB1kNHiBomIwtYcz-7EV8A>
X-ME-Received: <xmr:FsILaTsWC541S347z0xwez70SYKHtzKRy2F1IjPY8cUIIZJv0t3d8J_2s1TiiZyy-VwstKJF-8pq3UJwDs0jnhUPp6F2LBORMcoX>
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
X-ME-Proxy: <xmx:FsILaSbC7xAn0CeMRtR-S1eS3no1h40BhStNMTubPQPgUrQhBLfAlw>
    <xmx:FsILaeVLUnfWVNFyVMGEUV1LV1vrina1jWEEJ9AuYhEBbQ9l2w35Uw>
    <xmx:FsILae757egh4oVuQoixLTe9eANVZ06X6j1yhsxn1xyhvOdvZ9c5ZQ>
    <xmx:FsILaRjx26J7fVVDOXvLM8rDIBK9tI5VO9ultnMBhkvft-Nkpe4DRA>
    <xmx:FsILaR4XHEL8I-5fHyv42FNKuuTbzehOI9zFVdTNsbgjDtbmW0XfPfNy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 05/12] diff: refactor output of incomplete line
Date: Wed,  5 Nov 2025 13:30:45 -0800
Message-ID: <20251105213052.1499224-6-gitster@pobox.com>
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

Create a helper function that reacts to "\ No newline at the end of
file" in preparation for unifying the incomplete line handling in
the code path that handles xdiff output and the code path that
bypasses xdiff and produces complete rewrite patch.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index e73320dfb1..d388d318e4 100644
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
 
+static void emit_incomplete_line(struct emit_callback *ecbdata,
+				 const char *line, int len)
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
+		emit_incomplete_line(ecbdata, line, len);
 		break;
 	default:
 		BUG("fn_out_consume: unknown line '%s'", line);
-- 
2.52.0-rc0-105-gc08128fbb6

