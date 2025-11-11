Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ECA434D39F
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819500; cv=none; b=razT1zm00C7ynCYFjYa82ASHsIN89/PyYL7kGlbf2Fe4G9ewqegpjYi5XNEJXDo9DxQDM776ndu9lU/IkplCiZ/BGOh18QcooZ/2qA96O7M0EdqI+pqGJsMfZfKB7oOO+jgdkmZXvpyQ1Affz0M8VWsr+gLAH9yvAzcHxLzEWog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819500; c=relaxed/simple;
	bh=k7rsgq5RLs2SDZrOgjVMlBYqoSAkAwoW5KrkbkRHEX0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NCIo40ufeJ5+ximmjJAY5uCBeIPiwCKWl3mVrPhakNNT4uzQLrwXQm04NTwpGT0lBwrQDzlwenp5Q+guykbZOXstXMyABbpiFNXRTCQ3D6JNzXE7X20H61PyElU048lpWK5k4J5KWGswdJoJTts7bDPYuzr3dkLLu0Ue92WE4kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IHAWvJeI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bDzwDvJh; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IHAWvJeI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bDzwDvJh"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B28F07A019B;
	Mon, 10 Nov 2025 19:04:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 10 Nov 2025 19:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819497; x=
	1762905897; bh=TWvwS41eIDcRkbqhekDJ1N0gbTf+qfPKxrMz1mHkcmw=; b=I
	HAWvJeI9f24xej4QzOiUnlqp2jL3a512uHeZM1qn27dzGw9rplLEh6qk5/mZ4p4B
	SKD9PbiV7IL9A7KR4m5p0xkq34nzqbineIyU3RzKkUbLjgeIZKcUIKXQA7YABSxE
	njZg/avb+A3GTEm8spWnzL+l0X+KZxmxd+S/VQonAzUZiIRPnLk6lvF7PbaaubBC
	Ss61Miny7UC3jctEzhBafF5PMZTnwuI62IL+c3utSPEsaQY7z4aClD5ygxQJ6Qno
	RkorJBckd5iisrfkrOhhkORikDbwqMjuZTSHNVWoRnAmznsEasxhh0EIV06rXqiE
	YsClPeW8aca2UOByRLMqw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819497; x=1762905897; bh=TWvwS41eIDcRkbqhekDJ1N0gbTf+
	qfPKxrMz1mHkcmw=; b=bDzwDvJhFYOBeG+u/bAfw6D0WaUBcIXj4IrSpNYEemzo
	kd8trOxa/7pjxu7S4zP92PK9kl+Nx569LIEflVNWfQ9+SZch19YP0wjjVXV6LZxv
	JAOu+89saqYAgbmMOgDvT4H2VxfW1iN9XviJn2zQS0cOYh84BuALT3aqRlRguLE+
	rLehs14O/ADz+XETmB4jyZX2UabeE/nThY7TejHqLgpmdfC5HJe5kOiUzqovbYEh
	xYcMoXiUB1dYwZtVo7ajNqiihWL+JM5Z8DL3BuFBYQRnHl+ddZ7CKr04UzAOqQf5
	SP2YciBeo7713KwKiS+YRffGWhhPOoWj5AHjPIAjHA==
X-ME-Sender: <xms:qX0SacgqKIp23Alw0EflNnrI_1AjzEs08hoviNkMvDLPWM60mWXwfQ>
    <xme:qX0SabCGfaIKIBSUOAmVvi2-DFBX5IQqD5b0zInwWVj-rt6CHB1S0Pb0F-ZPt4hpZ
    xuSFk55hWFOySmBUoenoEjRW3DCX9vEA3Gaq9HgjSwlEhm-suj-D_E>
X-ME-Received: <xmr:qX0SaRtv_fTy-f9g8PLEN3JmSvk4umSOOBJypopBjl7pKY0s0DSIEBJgk9oYDnIpG7nTBup0-gwS0Vs-1b2BnkG-HYD5pXIRXFFs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:qX0SaYbZeAAhHtEbDW2SKWget3UG43Dc9QpSLwL-e27YpnfdOMlm7Q>
    <xmx:qX0SacV_MWxeGyoa9S3Q9uwNPX3smG8FlM3A8naxp8HOn7IukKmKNg>
    <xmx:qX0SaU5QEsd_l6LufDVpu_F1lTXKHrh-WHfsJuIi9sRmGchwWbiGkw>
    <xmx:qX0Safj3br7aFw67zon6GXPJU7uJKAHa5hNqpQr-14lvYNI1d3x57A>
    <xmx:qX0Saf48EtMMbEmZzUtB4FjjBv_uuH8if74SEdoj7aNgvjRSTS_EatvJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:04:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 02/12] diff: emit_line_ws_markup() if/else style fix
Date: Mon, 10 Nov 2025 16:04:41 -0800
Message-ID: <20251111000451.2243195-3-gitster@pobox.com>
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
2.52.0-rc1-455-g30608eb744

