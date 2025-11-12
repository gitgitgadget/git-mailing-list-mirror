Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121132F1FCF
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984991; cv=none; b=lJiCueksi03gWUiwzYmNyUUH9HuEI6OVF+MXoYoxMBZa6cqiysSybAvHmLoZF+ndjlUzOIZ95unyjFcfzJk9mF0HrlvCKfm1Vnenbzc9R5P4nA4USJcfYU313Qmw997a2beJvqpeeDX4WID+Ym4fuoqDOpur3DK3Pgqh8fF2Wa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984991; c=relaxed/simple;
	bh=8+Fv4QNYTqXpGT1T+6a+T0tURDViSCcNY9GrZF+fRpM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PTxvOGKwP1uT0xq9svg44Ji1rAIfKxVc4VhtRxT4p7yVGsGtvHXo64dneHa8ijXUnek/biw8ejPU/YjTwWFg1mESyGRNURYfZZ8PknqBjHwYdBf0YU0xXotoX7vLFNQ0/QtKE6spOfaSVwzIoI3Cq66G10tGZHI06fidiUFod38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KuGahWkM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBV8msYr; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KuGahWkM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBV8msYr"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 2C5C51D000D0;
	Wed, 12 Nov 2025 17:03:09 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 17:03:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984989; x=
	1763071389; bh=BPZ6PoW5PpcBLLBd8FTZZ40aHxGImeEiSUbnDFQy8nQ=; b=K
	uGahWkMrb1cdwOe1jT7lfApqQV0k4VeKmaSkuZbOJ+fZDkXYAjA/lShswUkQzwej
	DHxExDwJCILLcz4PM/ZlyQ3y30YnVdoI5PkLVquKQSc0vOwvZ7nQ6b/JJ2FEHxx5
	bPc8PJHTPlSGianU8UENSlHUu+M12rdjt6RYmBNBo39is82VsBfUKCF047IkN8t0
	Bk4f/ySxdy5Cx2yaUzaadddXCuDvVNTdb7TiLfp5PMKxASK00gIpTWwLVtzXzERp
	8laAH1fNFSdxBBrokVaWPbKYj1FyjUM/qDJe1fvsfAZvVIOqnvmfgdYcbPtaVXhq
	rUWa0EDAsiCFirS7n0fOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984989; x=1763071389; bh=BPZ6PoW5PpcBLLBd8FTZZ40aHxGI
	meEiSUbnDFQy8nQ=; b=PBV8msYrT9xJd86W93f9dwBTmshzHpj/sz+IDLuBquph
	+L9YyHVdvI8SEpHnb+ljGhMUfJI50fjjV/szThpPiLfRwk51zMbG0uW7F4233Aj4
	9OP/gYy0pSpGZ1/ASFp13PX74jSRM50kMIk906MCAQQia2TPFBYjRne+fvcB7wgo
	ht5oGyIr4xODuU9oj8kGB0ST9xeiANS2VVHaq0T33ufsDgfP5wDsE5tluzDYGHzi
	GRXCoRlr9myuhhG+h0F6o7oDTeD2zICkW3cwPZzmH30XamcBaXhzZudRSF7N7AMM
	qfFNLYBnZ3cuU5gquifq6gtqKsqNbXoj/FheOP1s/Q==
X-ME-Sender: <xms:HAQVaWdZdWR1BD2JlqWyebaPtFAH4jG66BZd0B18C-EQr5vMg0FpYQ>
    <xme:HAQVaWM60cnFuJuiWCHtIZIyJFvDiI8MIip9ISXjbk_xttqY_k8HMVQ2PTCBNd-KF
    whiS0jYjCXsEPpkouuYuUMCDJ7Y8fabgMIgU4GK8hnj2Wv6-vU4Ag>
X-ME-Received: <xmr:HAQVaVLEF8qQOXizoux-3jXeRZ1hyNYhPHq4ZktnmBdf-Iu6EJ3tp-E_Roni0ewV6Zn0CP3BlIy2D3jvWuDh6i1iwkBgaKsxN3P8>
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
X-ME-Proxy: <xmx:HAQVafGL8qV76KnUwFVxPOOJ1CzbEZ8f9DCA9JOcaAlTBX25nH3yBA>
    <xmx:HAQVaVSZ8nt5thrmm9jyZlYF3W-ECViRFG8BQ85PgRd1dHTSxUMeDA>
    <xmx:HAQVaTGsFIvHI7HMN2HD43Xvr_HigsjIwQr78f5-fW4AafGYQc6WrA>
    <xmx:HAQVaZ8JQuEESLeC-tNRC4igGhvJHRAISRv87wKfSEMBA7Y7chVYPw>
    <xmx:HQQVaR0nznpuEFSLHsDRxOeyFp-rTpI-OqyguI8h12Tv1yNwQi561ed0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 05/12] diff: refactor output of incomplete line
Date: Wed, 12 Nov 2025 14:02:51 -0800
Message-ID: <20251112220258.1009253-6-gitster@pobox.com>
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

Create a helper function that reacts to "\ No newline at the end of
file" in preparation for unifying the incomplete line handling in
the code path that handles xdiff output and the code path that
bypasses xdiff and produces a complete-rewrite patch.

Currently the output from the DIFF_SYMBOL_CONTEXT_INCOMPLETE case
still (ab)uses the same code as what is used for context lines, but
that would change in a later step where we introduce support to treat
an incomplete line as a whitespace error.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index ff8fc91f88..7ee8620429 100644
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
@@ -2437,8 +2448,7 @@ static int fn_out_consume(void *priv, char *line, unsigned long len)
 			    ecbdata->last_line_kind);
 		}
 		ecbdata->lno_in_preimage++;
-		emit_diff_symbol(o, DIFF_SYMBOL_CONTEXT_INCOMPLETE,
-				 line, len, 0);
+		emit_incomplete_line_marker(ecbdata, line, len);
 		break;
 	default:
 		BUG("fn_out_consume: unknown line '%s'", line);
-- 
2.52.0-rc2-441-g030905368a

