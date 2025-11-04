Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D59023D7C5
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222177; cv=none; b=W31f8XL5ZIgbWS7hW0qaEhSteNKttpsicfwCMekjgb+hZlCYtPRF/ZGfnnNEw4i43q0XfXewH3jNFiR/kc76D8gJk6Hp7fv1TSQCnl5j/KHN+XkBQb8TE4A9PEnzVC7PpL9we1TWPBQ1h83qLWj1EmYbpbVotsb6iINDJBF7UtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222177; c=relaxed/simple;
	bh=6aw7hB+k77XgaXzpydpZuBBxLLqOmrN0oxjqzqfR/GU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U/0ot1n1dKqAGAeNIxWJvG81wxiXCDBO39JeFyKnIpogUb9XBlO4eAFC/n8PuImR0TdqutDBlJKSBklT/U55bCO6dZVxpTbyyBdVfl1Z1xLLNJRQEdVxibf0uypYbo+u0jz7XTQj3YGDCeSkxUxpqia3C5bmPSOtJ5q5cAopwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZfGOMSGq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HvuNZsFy; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZfGOMSGq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HvuNZsFy"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 86E881D003F6;
	Mon,  3 Nov 2025 21:09:34 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 03 Nov 2025 21:09:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222174; x=
	1762308574; bh=hz82DiQH5rhvOU3H2/32kYf3xbxf4LyswLmCKZO+Cd8=; b=Z
	fGOMSGq/JxAX7DlYmLttq1aRjDWFcPCxo3imnSvanW1D89WdG25PurGhGF6TmRSz
	mDNngqOcY3qb+lXwRtVMAlKnZAVYt5jvCiB0znutEM6rYcPgnzegA6/ZFr3lLEv7
	anrmoswOshlDwJuNIMB45RobittNKrESKcKjPqK3FvWYGrpIztN0N5Meqva33zaq
	r7I6QeReD9EhddH2ZV5fdMoKf/uSIcD4kR+3lViHhyz9fOV5UTb/ObW65C6KXaSW
	ZSxvQWcDhXFmgn0pmCMlzglzzaybAPIlwDD96tQvcpDZCRdHkyvKR5wc+tCW1aeq
	gcuAzlpsbczUwtyMep/8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222174; x=1762308574; bh=hz82DiQH5rhvOU3H2/32kYf3xbxf
	4LyswLmCKZO+Cd8=; b=HvuNZsFy7u9Xs0BglAcwpDzLO8GMxy+6iSIipB2qDK7V
	ESU5R5XYRQ71kAAR0WFfvSkNkWK43TkGzG99CME/ENr14HJrJt9+vD9YrS3nFQhn
	l9QFfRocoW4oZNajCywsOORiI2+ZJKpKnHgaGhHcZxM2apPXop5wwbto5CLKLzRd
	/EAoGmBVRcntrLq/88lWQhpgm9EQeCvQx8nSvpRlJnIiNCkLvS73CxuWUYCnuLOY
	mhr0H4KJ1nJyuGMgF4xDwI7jsKKLxq6BU8BP6Nt5ptULFjJLgSU+F37LZOVUEpgs
	0DpJuseXv1I5Jq9jBvYrl7WwVXTCXRUJdyCXgtWSeg==
X-ME-Sender: <xms:XmAJaSV3E0NZ8tnURzbuT2otvLwKxMuObx2dDbco2TuqHTuJXA-4Fg>
    <xme:XmAJaUmYBNGWbeu4shlz_amxD9AZynS09BFTakLZjm2FgdNxTcnv8MyAHBLOcoEhg
    dIzNGPXG0V-TWA-DRMGTLkjONXEEzT3xJG_q19PD2_HRNZSFKKEGjk>
X-ME-Received: <xmr:XmAJaUBjWwV9P4St9RBJ11VKB01WVLwFRdVSracNmB21H05Zqzne3NKeUCbclNKfeZiHA3h5iWVvEuvs6BqtlS2CGyliuXPUWrps>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:XmAJaUcL74n978BgqQweXmqA725LJnw7CeesSBF2ldpyPXsEuhXfxQ>
    <xmx:XmAJafIUJGCOaXlJT5kl2jpY_I0Nlx_tWu82QV5ixpWMNhnbGzTXyQ>
    <xmx:XmAJaXdC3iKHQw3Q5qgtviOq2i_mX-qkMg2Xy6F8LBcNSXKsk_36Iw>
    <xmx:XmAJaW3podtVYfDWmJdD8FsYdanPbSCuYDGRbFGIETs4T6soMsqPcA>
    <xmx:XmAJadv7s3cBpZhsoU0OmaF_bgRKIUAOohhPTrk5VegBpP4jMf4yPgR1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:33 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 02/12] diff: emit_line_ws_markup() if/else style fix
Date: Mon,  3 Nov 2025 18:09:18 -0800
Message-ID: <20251104020928.582199-3-gitster@pobox.com>
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
2.52.0-rc0

