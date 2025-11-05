Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06C92C236D
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378260; cv=none; b=TsK3FzbSKwbT+2hRz8MK0YJiqi/5Isq1RlUflfaFxmo+AmYeEjl1mzP7bQz7y+nwfwxAaiOLWkO4n76qd8J8h2qZ44UdCvN2wDunO7tzkfhSBcrdbYDDY6icElUxXjvkMj89xoD9xbzQPRRKosPG5Yiq4Bv61v/5at39f9Fr1NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378260; c=relaxed/simple;
	bh=zjJW7+5cUIRsg4OOERwWsFOOBE3MC1mgwnAI0FBmv2k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XStMIu8t9Gyw9KVzJul1eCUcjWaDO8a8B/VZvDxpR8NHFmsjqXPsTrvFLKgypkxe6J5MFx/55IWjVdg4cYJat8nmXQ8Fs97mYX5eR3+GlJdCS8wY+QRSR3vXJtldjfoCYSBt4twXGHVDydPaNk+Rx4ZuFMRR034O3NmB0NPfGJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l9ap2njM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S6c78G7I; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l9ap2njM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S6c78G7I"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id CED861D00223;
	Wed,  5 Nov 2025 16:30:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 16:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378257; x=
	1762464657; bh=AA1kNlkOsJucTSyZ0sSlKxDkq9MyqnyuneuxzgY/41A=; b=l
	9ap2njM17mmGtIgasT9VfEJbrq9UWr7vOfzumxsJZEAnHQXpOHO5GGr4xgeh2e/L
	hWNxdzR82CEKD+t3eJOD3nrs73svMSxrL9aol2aLfbppKkTq+T4PcBHxbcNwwC07
	B6dq8d09vCiCbgbvydGk6m2i+fZZIr73UbDqEce+6w6Lhe/+DnviodiiHNrK23LI
	elyd80xE0QInXd4uC1+0hiLbx4d83zd9z6lwJdxVnwlTFCGe9LbZYC5zsyFV2gRn
	VGfCtjvkghuKCqGxrULLEkjgKDk7O4E6ZJ/QkPv3YScoSSE7SBzhQcA2ZhXUWE6C
	hfQ10l9pVFzRBarKrc4WA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378257; x=1762464657; bh=AA1kNlkOsJucTSyZ0sSlKxDkq9My
	qnyuneuxzgY/41A=; b=S6c78G7IzV7tAJcgFRB5mruMx6FGs7kXl2zeH3j48gZW
	6EWBFHL0FY22QHedgNj9YFoLnyPxNqZRZEuqEhmC36zA1yfonnvgeifUpml50Vhx
	oEiluukTCL4eaZQpS6YfaspLUy880jK9e7/sPUT8JsFEtfeQ5pX0gXABmib8qaeR
	DxqH1SJctzUgZ4BWP+5UwOeYFZFj5E9Rsq9U0dQblIyubh2tpNboQbieu92Vzfmo
	FqvweH1hrytm8/Ts7xdLgg38hY5k9nLCbKAvbn1OxaAVo01LHzBiB7hLaRXTWmT+
	iiE/HhGs+nOnXtR+2V37tHudfz/j6wNrOEdQ3xXt9A==
X-ME-Sender: <xms:EcILaYybuk7PboSd_cBP24CSdZcdQVNCx2TCuEuYarybphq9y1mAiw>
    <xme:EcILaSSi19IyuKWTW7OAH2XIDJgi60WnIyAt3q_I3YrNmhblM10v4oYCoAQ3VXq3t
    e_ZBAC16llAZ2wZRHCkXVt-upsxwKWh1r-FNg-5MuaRU2WkQhosDg>
X-ME-Received: <xmr:EcILaX9X9WZN1texBDV_Qiad1_d487OmmGEm0RTeSiTlc1JzFGeOS8F7pWTaES2Wgk_sb4LLf3O5SYOsHxAx3Web1hybVI7p0i-H>
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
X-ME-Proxy: <xmx:EcILaRqkADaDER6VeIVXKbxCSDiIC7FO_x7MzB7kHuuDh4Tw1Rttdg>
    <xmx:EcILacm4c09qLn24FjlfirG8gknWVJOmbZsbw_D0nPlVhDkM0fp9RA>
    <xmx:EcILaQIvLhG8ZdgNuKCUXdcVk1K9X6s86tg_q4b5QlrbHTNeCUtF5g>
    <xmx:EcILaZyCUrwut7S7YvYNXupNxZqsPLSrTQW20Ct2ne_U3sExL_NJmQ>
    <xmx:EcILacJfIF9FG-s4keYpCC3dwOxXouAfJe8na9sc9DDXOoJvvpbO5r2p>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:30:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 02/12] diff: emit_line_ws_markup() if/else style fix
Date: Wed,  5 Nov 2025 13:30:42 -0800
Message-ID: <20251105213052.1499224-3-gitster@pobox.com>
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

Apply the simple rule: if you need {} in one arm of the if/else
if/else... cascade, have {} in all of them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index 74261b332a..9a24a0791c 100644
--- a/diff.c
+++ b/diff.c
@@ -1327,14 +1327,14 @@ static void emit_line_ws_markup(struct diff_options *o,
 			ws = NULL;
 	}
 
-	if (!ws && !set_sign)
+	if (!ws && !set_sign) {
 		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
-	else if (!ws) {
+	} else if (!ws) {
 		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
-	} else if (blank_at_eof)
+	} else if (blank_at_eof) {
 		/* Blank line at EOF - paint '+' as well */
 		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
-	else {
+	} else {
 		/* Emit just the prefix, then the rest. */
 		emit_line_0(o, set_sign ? set_sign : set, NULL, !!set_sign, reset,
 			    sign, "", 0);
-- 
2.52.0-rc0-105-gc08128fbb6

