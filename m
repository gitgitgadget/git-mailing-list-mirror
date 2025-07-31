Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A036D27FD48
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002489; cv=none; b=oc0f4tPS6mOuvogZGwY0qPNBsjW5gyLXIQZo/z/ML90LMLXr6QQG5nef88lsJe0WwEkGpzD9J+THrcwQAKA9sJO0ClNdN7XWwd00bGDGXPV0UyW4TqfAaKU02Mw+drFoa3i8Qf8hANnZf00hIeN8f2liDxaExEUaFd8OOd9JJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002489; c=relaxed/simple;
	bh=0CbhHckTlIXMCXpz0rics0BGhRvWUjLa4M1sMbE0uJM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QoFkm7wITdoM8qwoBVpzZziA+z5L6qGJz521v/OWOFehT/OsbQL7rpuVVPtczdfJiDqIz3hfUXooXPeiNBUvNA2HNcbbXPKSYtQAr6HRJYDMzqws5yPj6WK4AlhcsuWgxDZJhZjOrvhKQxsVUZ88zh1uk80LZV4uJPw6tp3jwSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=h2rNEim9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XiHrxtjx; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="h2rNEim9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XiHrxtjx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D43F4140030F;
	Thu, 31 Jul 2025 18:54:46 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 31 Jul 2025 18:54:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002486; x=
	1754088886; bh=cmRmvGoj75PeuN98w7nJBHROyMJdS+qObWkyVr1oZz8=; b=h
	2rNEim97uD28FRw6YH3vLNVfm2vzTg6ob+warjzrV5Oa1DzV6f0yvEpyFrZrzHzJ
	vHg0BossmRFRfcC7LL007UYfPJeR1dalTlKKK5vyu+ehcGnXKR9SilJhDbailryV
	u98DducT7rlANK4san6ipW4DVBj7E9ypPvTNHAm2RyiXcFiEp1Ex2TA/Z7lStHTG
	j/2BSUVHe4MVLalfCZRDYC5zCib2HSKUzlaytOhkfUsSya9MSF8h81ZWtZSXYKMt
	weWlGT6x4yLfoI7ww/LjlhDmZD7f07ZdQNsvJWTvYj5lZmaBfVJM5hS+oZiLygzz
	mLsqiHIvd5KPeBHtx0XpA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002486; x=1754088886; bh=cmRmvGoj75PeuN98w7nJBHROyMJd
	S+qObWkyVr1oZz8=; b=XiHrxtjx/wmUYg/Mf5gnS97pG/tKmweSsd58fJAeyW5O
	ZNrqoOFllW4i4kIdhL/tHNabWadlzdIwQbOA+MGZAAtT/Q+X/t11J9FWZ+bF+OWs
	H5Lt5EErAy3BJSF9aSRTYSbCM2OHe++m5C9Or25g0Hc0so8nukH4ZIRU1KJ9ZtK/
	vpdHWHM/DCxDAfi0Qv+ZZ/vSnWD5SXNAQGsXUOvW1CODQTDMRgjZ8v4FyJigjxGs
	8o3bKxCX7bI4ceYpigjJ/i7e2bdvmvQfC/b0B5uCN8pXVemn6tly6bJG3MiOdIq5
	0lMO2zXeZCPkqp3WSD0Jy3Q2pd1/L+XhSaTpu/tvRw==
X-ME-Sender: <xms:NvSLaOIPM8ZkqnPgmO8AblXBHLhstWA5LoDoAlpiXZid4pOvTVXycA>
    <xme:NvSLaGXFoxhWFA3HS4Wbghns9d54jS1M7qeaytyqocZPwzwUPflI-wiT2geftNgOc
    Ew2aekd77MnGokfjA>
X-ME-Received: <xmr:NvSLaAgTClgJTXawp5qdA1ncK2VfB2GvOBMUM-W-jFrWvBGEOxpa_Y0cYEzXk0NiW-xPKhoFN6jdMiwPjQlyd8Sz7nULbpfuXyYFeX4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepfeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:NvSLaB_Iie7E-kuj3wGP_69K7Wq7lfWQhRiUhXR9u26_9xlybj5A5Q>
    <xmx:NvSLaKD6oVbh6tMYRxwRrKxjLyAKrpv16H-U2BdD5RY4FlL7CZu25g>
    <xmx:NvSLaOIoOBGKDvzIjwuUvw8UEg8grXMgNEYaUtiS5BBpMplz0D6egA>
    <xmx:NvSLaNlrzie7g_M6MInB8UzT5OT35Yd7wdk4Qw3mGHrJc3XVNFZF9A>
    <xmx:NvSLaIuk4_LxCjGbqyr5CL-tgMnYHPZOfPIPyCMeOxY_I0t-bcckrBj3>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 08/11] environment: do not use strbuf_split*()
Date: Thu, 31 Jul 2025 15:54:30 -0700
Message-ID: <20250731225433.4028872-9-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731225433.4028872-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

environment.c:get_git_namespace() learns the raw namespace from an
environment variable, splits it at "/", and appends them after
"refs/namespaces/"; the reason why it splits first is so that an
empty string resulting from double slashes can be omitted.

The split pieces do not need to be edited in any way, so an array of
strbufs is a wrong data structure to use.  Instead split into a
string list and use the pieces from there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 environment.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/environment.c b/environment.c
index 7c2480b22e..ab3ed08433 100644
--- a/environment.c
+++ b/environment.c
@@ -163,10 +163,10 @@ int have_git_dir(void)
 const char *get_git_namespace(void)
 {
 	static const char *namespace;
-
 	struct strbuf buf = STRBUF_INIT;
-	struct strbuf **components, **c;
 	const char *raw_namespace;
+	struct string_list components = STRING_LIST_INIT_DUP;
+	struct string_list_item *item;
 
 	if (namespace)
 		return namespace;
@@ -178,12 +178,17 @@ const char *get_git_namespace(void)
 	}
 
 	strbuf_addstr(&buf, raw_namespace);
-	components = strbuf_split(&buf, '/');
+
+	string_list_split(&components, buf.buf, "/", -1);
 	strbuf_reset(&buf);
-	for (c = components; *c; c++)
-		if (strcmp((*c)->buf, "/") != 0)
-			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
-	strbuf_list_free(components);
+
+	for_each_string_list_item(item, &components) {
+		if (item->string[0])
+			strbuf_addf(&buf, "refs/namespaces/%s/", item->string);
+	}
+	string_list_clear(&components, 0);
+
+	strbuf_trim_trailing_dir_sep(&buf);
 	if (check_refname_format(buf.buf, 0))
 		die(_("bad git namespace path \"%s\""), raw_namespace);
 	strbuf_addch(&buf, '/');
-- 
2.50.1-618-g45d530d26b

