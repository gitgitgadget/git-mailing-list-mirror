Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5815822259E
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 22:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085870; cv=none; b=fQAZtawQmRiS3hQXhDB4v/kPi4OKeH6nNhdKFHLKZNALlo4m9F2S9oRZPHpVLKF6aO8WWO2i3aMFT13ZVdc/G2CvW81yKTd9NqSpEz/XVZZ6L6k+jjLBeSArKQngTDnBfRvvSflDdZ48ieihDKBzc474lQjS1h/2OEIulRaFu6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085870; c=relaxed/simple;
	bh=RkHfvjnOsJQI1ww8rG1+xyuS09HkcHhMaxiWpK/dYcg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeybk25GAxWY9SR0kYtZt2TMIK7cTR/pzjd8aaASn1dzw+fKmqg3qlDHyiUYjm5vlDJl01d+pnVKYh5SoSXHEyDHtvAQXtGZRqQQxqvu0yHZc9DqIGJSpkRidcY4vVoKhVvzGhLloV0rSFwOc99C+bp3no4E5u5/ETl193mR4Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Iw5RryPo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=K38JTd/d; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Iw5RryPo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K38JTd/d"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6DBF81400271;
	Fri,  1 Aug 2025 18:04:27 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 18:04:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754085867; x=
	1754172267; bh=JgdMqJ+tE4wrLw0v2lRPqZ1KQv4qJ2O3d5HbdX+dccc=; b=I
	w5RryPo1tiiotWe5u9IR8VEDM8h0CxguFzipqtoOFYJ3r+/38Yawk+yjoE0NA9uw
	ZXNpRtBm0jQW1eNc4Ar90c3qLBpwQtdNHaD4+RcqJHo65Ml5Un7s7paBf9qV1h4N
	nUF5SWCUxrQ8/MPggjoL0540V/THwOpnLSNjcYJA3v8lHLQS50Wj86Q5AaKTUzAf
	LTpDTyuLiNQu/gEe3bM+dtnm+HCbZ8amo4CNMZoDT8ns6p6klPIqYoRl9EARm944
	+eKqWCMZVM0734bDwAkUcSpE37sA+ee1BSiY5sTEJ3DGRvjwAGLdeZ3Ag2nfeWaU
	Zp8pEFpY7+96kF5O3+E1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754085867; x=1754172267; bh=JgdMqJ+tE4wrLw0v2lRPqZ1KQv4q
	J2O3d5HbdX+dccc=; b=K38JTd/dRr2Q9ksowVk7hW7pwpcSkWFUwYIqb0E+UQtt
	MqVeiCDZomm9hZiv3gP2K0+eBxppsmG9WxIdCXCIrjgKSecoWcGzon2d5xLYT9mz
	DmEDuhoLK/afqQHINKBRqPwho2aUixLoRJBT1nFS26kmwf1c5qBbzevlfaWhfB1V
	H6irggQ62q1ngiPYKRYNvihmrHaH2eatOnyOHvWc4bAvEkXNRJtb0MmFQS9xJUin
	nxppsCSthffqvY8qVG8M8z4lKlGKqdlHAmGV1chORxaWGGgg6Ubqh+W4lelPvxgI
	p8VWlScTOpSsGP2eSJIk4knJFYrUdik9YFQcIDWajg==
X-ME-Sender: <xms:6zmNaJOvDwmrIa2JwCPqUdIEk7pJyLQVGhZLGcaX2X9N2X6EhUq2QQ>
    <xme:6zmNaMLJOH0mb6s8RSJuf2Qa4PErON9ulj9qQqmlwEjOlS_onXYbD5XJgqNqAOVCZ
    PvbO0RtMOIKa035bg>
X-ME-Received: <xmr:6zmNaKF8JLnE2PdTucQYwGHkGZHnKbqJ9HlK1DJyZWte82g8Am3yRPnt0XWSpKWYDOeE9R9USzv3ynrMB6yyh8WU_HrGUzie9it05Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:6zmNaEQ0tAgTQq2nf-jD1LUctN4Y5I_nAWcP6cYFXziKAWZiDBjo5g>
    <xmx:6zmNaGFE91_jkll2eMWJxVvqWpoBSiKizoCkLGkxfs-I9bpGPdqD3w>
    <xmx:6zmNaA_2twa1E6-QUPNQN5LKocWb7b4JVlzkFTwQADFIQ88sVy4KAA>
    <xmx:6zmNaAI2C63LIJ_7bpC-QsRL_4nuxLXvYF1dGEuFomdZOBlVdLLkMQ>
    <xmx:6zmNaLzwZmHYCtheb0a9-zLpnMndcdHaFKAwkP4Wt8hnP5Uv2NLSWIl7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 18:04:26 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 1/7] string-list: report programming error with BUG
Date: Fri,  1 Aug 2025 15:04:17 -0700
Message-ID: <20250801220423.1230969-2-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g85c5610de3
In-Reply-To: <20250801220423.1230969-1-gitster@pobox.com>
References: <20250731224607.3942417-1-gitster@pobox.com>
 <20250801220423.1230969-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Passing a string list that has .strdup_strings bit unset to
string_list_split(), or one that has .strdup_strings bit set to
string_list_split_in_place(), is a programmer error.  Do not use
die() to abort the execution.  Use BUG() instead.

As a developer-facing message, the message string itself should
be a lot more concise, but let's keep the original one for now.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/string-list.c b/string-list.c
index 53faaa8420..0cb920e9b0 100644
--- a/string-list.c
+++ b/string-list.c
@@ -283,7 +283,7 @@ int string_list_split(struct string_list *list, const char *string,
 	const char *p = string, *end;
 
 	if (!list->strdup_strings)
-		die("internal error in string_list_split(): "
+		BUG("internal error in string_list_split(): "
 		    "list->strdup_strings must be set");
 	for (;;) {
 		count++;
@@ -309,7 +309,7 @@ int string_list_split_in_place(struct string_list *list, char *string,
 	char *p = string, *end;
 
 	if (list->strdup_strings)
-		die("internal error in string_list_split_in_place(): "
+		BUG("internal error in string_list_split_in_place(): "
 		    "list->strdup_strings must not be set");
 	for (;;) {
 		count++;
-- 
2.50.1-633-g85c5610de3

