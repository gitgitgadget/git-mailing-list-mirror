Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADE028313D
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203999; cv=none; b=lJLfls+ST5Egac1YGg2rhNP6ehXFAQGWXAgegEapT3sl4UXfGqHiSKj/pnuriq9y5rrRLlBPihj7ua3aQ+f3nRbNKxd88Cp5G55jeJS1Z7ns6xMFiQ8D7WHCgmj06CdCEI4h2Gv6CV4mXEpA5TOfrBmpZ3jTNU2tmhZiNaIV1P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203999; c=relaxed/simple;
	bh=r39B/ZeXaJH3fdQCiWQ9ydFTrV6naaKdCeI8dYQ2sn8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2612x7cBh0qk9lFIYgx9tUO7jM55BmKYfRS6BjfIf7g937QErm4qePOGdSdZyys+PUiJfKs82Q9wXhuLCAYWU9aWMalFuMBQ/JBxZe0nSmYHWRxWBDqF5M5xECu4XNZnBIvO39HvOOg92yqbV7lq1BsKeDysnactduRYaNNmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=W0BG6a6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NFc6ZnbP; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="W0BG6a6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NFc6ZnbP"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3AC13140032D;
	Sun,  3 Aug 2025 02:53:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Sun, 03 Aug 2025 02:53:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203996; x=
	1754290396; bh=wtRFP1IJ6RVKXuQV1YxDEew+UaTqAAnzZ3eir5yhf0A=; b=W
	0BG6a6SNqkFRn5n4qRCm4n+wAkxV1HlTSIHeIxHBhyQG1IPwFUvJCIMIy/iIW4zf
	2ynMwjX9x1geC1GktOHhL01kftxGuOv93smX/TNshhC49E/q1GzaAdQrlICRH2lf
	a1lSWSkCnOBvK501uEXl9VRINcxrRUduPQjq7QNXaG1iTXXwdNKsHIF5WcIFUD7z
	fYMPdY1N5wy7zlUpuIgcgpMQhCtzZxQCGbkrAul9Ab04s7FnxHOd2asDPn6Ccr/4
	tSs6bnUggbHCICPr+bWc7P3OnX/Euf+eoLMRGcrt0cE4GkYhkhUOTU4awoMnreCC
	2rWwqz2F1Vzfu1OQtckQw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203996; x=1754290396; bh=wtRFP1IJ6RVKXuQV1YxDEew+UaTq
	AAnzZ3eir5yhf0A=; b=NFc6ZnbPmx1rO4fEVsopoqKySfPli8xOV6oHi+PvRb6A
	LBePuYqQfxOXa9KH/nlozfLC2rgqRekHimslgO7rINadO6pGWobud00UOHfUh8Bb
	DMb6w7FZ/ykqlpwU0eWl1SZpu/6xOu86gYuwUKw66CSd0p9rZFFHlXJopeX/R/GN
	RTsXCiHcSJXQGhvELxc4iAE2NIpB/XGai7M1YdXBAkUEr/Ar5c3XifaCob5z7/w0
	6ifBW8393J695JKBWCadcVvnmfbq5/2O6Xei9S9L7cG+A1FFCahpWhnRXDYJQ7Um
	DybL2wK4Cl8gzgvzeo2L7iFafZQLQ/2A90pMDwavdw==
X-ME-Sender: <xms:XAePaCT1v0TwHHuRXdHLcvrhlA0yrfu_wwPyjIftS0xS7d0GR5B4fA>
    <xme:XAePaH-uciUIpGE29_1uJw4zw7bXefIjt-EESbVkgIzQT9-6A_iLM9FcMGU3Sp-UU
    t1xhf0rmJ7WEXK9GQ>
X-ME-Received: <xmr:XAePaBqviCGAp7qT81UA5EybCfYwiGQDy--NYxhqNV9QefkasxJHjZqvbiRbZhlfaYcl0RW9wlrbkii-zVyrBJr_ZdAL263gkZKSxuc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:XAePaMlnQvZ9O0HbaXEm50XFRltFyqGxkDB8EDjz5D3CGgkMteQSJg>
    <xmx:XAePaAKyaByBuRiRI2HM1ujI2Wn0VuF6D1wZbmeqhtVHb-ilD8P2rQ>
    <xmx:XAePaJxJ7tmcjo6gYLwvjYbkTHxGUQ62ZHUeFZBphHZJU5ldDoW1_g>
    <xmx:XAePaAt3Obbk7q3QPXXWomCKDnMmtLjN-Lam-ZQmoq_iRJu0_xczBQ>
    <xmx:XAePaM1S5guB8oNaG4FIEyj2scbnCF8OXZPO6KpopFLuEawg3tbtd9Xj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 08/12] config: do not use strbuf_split()
Date: Sat,  2 Aug 2025 23:53:00 -0700
Message-ID: <20250803065304.3325286-9-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065304.3325286-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065304.3325286-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing an old-style GIT_CONFIG_PARAMETERS environment
variable, the code parses key=value pairs by splitting them at '='
into an array of strbuf's.  As strbuf_split() leaves the delimiter
at the end of the split piece, the code has to manually trim it.

If we split with string_list_split(), that becomes unnecessary.
Retire the use of strbuf_split() from this code path.

Note that the max parameter of string_list_split() is of
an ergonomically iffy design---it specifies the maximum number of
times the function is allowed to split, which means that in order to
split a text into up to 2 pieces, you have to pass 1, not 2.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index 8a2d0b7916..1769f15ee3 100644
--- a/config.c
+++ b/config.c
@@ -638,31 +638,28 @@ int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
 	const char *value;
-	struct strbuf **pair;
+	struct string_list pair = STRING_LIST_INIT_DUP;
 	int ret;
 	struct key_value_info kvi = KVI_INIT;
 
 	kvi_from_param(&kvi);
 
-	pair = strbuf_split_str(text, '=', 2);
-	if (!pair[0])
+	string_list_split(&pair, text, "=", 1);
+	if (!pair.nr)
 		return error(_("bogus config parameter: %s"), text);
 
-	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=') {
-		strbuf_setlen(pair[0], pair[0]->len - 1);
-		value = pair[1] ? pair[1]->buf : "";
-	} else {
+	if (pair.nr == 1)
 		value = NULL;
-	}
+	else
+		value = pair.items[1].string;
 
-	strbuf_trim(pair[0]);
-	if (!pair[0]->len) {
-		strbuf_list_free(pair);
+	if (!*pair.items[0].string) {
+		string_list_clear(&pair, 0);
 		return error(_("bogus config parameter: %s"), text);
 	}
 
-	ret = config_parse_pair(pair[0]->buf, value, &kvi, fn, data);
-	strbuf_list_free(pair);
+	ret = config_parse_pair(pair.items[0].string, value, &kvi, fn, data);
+	string_list_clear(&pair, 0);
 	return ret;
 }
 
-- 
2.50.1-633-g69dfdd50af

