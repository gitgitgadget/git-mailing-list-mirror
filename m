Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BC518595A
	for <git@vger.kernel.org>; Thu, 26 Sep 2024 11:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727351226; cv=none; b=hme9dJJjC+QH0V2mPzgbwmxRPCfd+QLkg1F3sEj9NvQ+Ujg+cvF7t1GdGaLsrbQGEj6ESi6d4glBeA1lsVn8j+GvhUzJTHMWxJvn+JBnaFi0Ix6FzlKh+F1lanDS7mXltF7GXlZgglUmGg/oDIhTyjuk/I3snnpUOVSuiY5WkOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727351226; c=relaxed/simple;
	bh=NOsy9tdQUwROSqcrQUqlxRXv0TXl/rFFQCCO9Es/jM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJxeZMeBGDFia8xlVIfuO4bqmA1T9nX1Rdve0XWJ0b1a6LAbXyZHVam66MEUf8Dk7bFhX+L3K0LbuNej+inyyNhxD6hFTSduqhMI/Aj5tFcZgCDABHCNdBVR2+ZbrEIgcunRRz/sl5TZopmQ0v+zwIN08mVbijwMvNTxduDBPJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QJdt087t; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FJ1fTfZW; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QJdt087t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FJ1fTfZW"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3A61511401B1;
	Thu, 26 Sep 2024 07:47:04 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Thu, 26 Sep 2024 07:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727351224; x=1727437624; bh=+yIf+MeiKV
	DJDQ4DQX3Z6wSOgEjdu97ZIaGbDzYOCXw=; b=QJdt087trGdvxbO1eInjuqrbyp
	gbqVHQsN0ZSa09SYqzy9KOJNfLfEHFi5kBgaJQRJJjzO5xSAkgFLMH9EqMcpSfUU
	t2frVwMWUFUHFERcB+/z9hxmEQqFYES/jXGQcQewt9Lop4sX1FpVautXpclV6nds
	veqOlvjxx75tilCPA8HS+E0r/25NLqeph0SFJKnAzv5RSkmwjb4xjHeBUFHvaJlx
	J8D83lGUpHQplDPvNvIqmlphHBDWVjqQFfBmyE8LL0+2/C0xrntlo9f1E9R9vYk7
	1kbVyyjWJossbiL1VgK7UeQlLSLYCXWk2DYMPRpPvCnW0uwbkb7jfsD1NR1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727351224; x=1727437624; bh=+yIf+MeiKVDJDQ4DQX3Z6wSOgEjd
	u97ZIaGbDzYOCXw=; b=FJ1fTfZWF/7/kt4J/y8Wkn0vdi8E67iLe59V01byqyJo
	Kae8K2oA4X54HkQU2iKqZ4hGOHMXt89xu0X3XUodWyzCJgQxikqNvpvhcSSlyBqq
	hu+iAyLsU+HP1dR+DNBRysTnqZfJHnvjCb3/qwh5CT0w3NCn/l8gxdkwo8vC5EbH
	GFt4ZCVIsivS14qjI6/nV3BIfSM3qebGls0pf2qH0A9wo20B6tv1WcmmybehL1rJ
	tW7wWDchyfiBcbXo0nFSJgWI1V5PgWqSuxUWui6iMTPh6ZaazdiILHgEsT8EIjIf
	m1e7wczG2UDm00rN9vxmN1EhMtjn2dWT5xxUAuYTnA==
X-ME-Sender: <xms:uEn1ZgcEu2L4NG1Le2kcRnq_tm0Nhr3FUqu0X6zSDle80zPUFdbrEQ>
    <xme:uEn1ZiMdqR92LMX8KseS2y9izyCA9L-N4o_WSO-bKJrqnOAxblm-buQvpMeqDedzy
    dw4KP_oSXiFput9tA>
X-ME-Received: <xmr:uEn1Zhgy05iDuT18v3QnvzpPEvdLrxvNNOeCJ3_IGAFfVhQXszCY_e1kvSBMjrcr6L70XG4kgDveuzVyj-Qdd65gSXhkQ5wg_X32f0bGvvCjMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddtjedggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthho
    sghlvghrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:uEn1Zl9Q8RMDJ5QlnIRQxiJ9g1DIwVk7iBGQedxZD9aM8tcbiLdngw>
    <xmx:uEn1ZstWzAEoxYalsPeBoSlgamQuw8vzqHGkYfpTT94hFcv3PY6UNg>
    <xmx:uEn1ZsHyBeg9hYz49aGCkvabeHYUrPlf3oUdYQduQ3BC6c-Q4YnBLw>
    <xmx:uEn1ZrNTK73yVrKkhhqFntiNB3K2PyBPotnjvhjnMWlcqYC7cnl87w>
    <xmx:uEn1ZoKPF3XcYiZkOQ49JCA4CxILIZaFchdkFf8DRR-CYPQhYf_pDrIG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Sep 2024 07:47:03 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 96eb85d4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 26 Sep 2024 11:46:25 +0000 (UTC)
Date: Thu, 26 Sep 2024 13:46:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 20/23] builtin/maintenance: fix leaking config string
Message-ID: <0a72fc83f797d0f0f753e54b8473740a041702ae.1727351062.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
 <cover.1727351062.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727351062.git.ps@pks.im>

When parsing the maintenance strategy from config we allocate a config
string, but do not free it after parsing it. Plug this leak by instead
using `git_config_get_string_tmp()`, which does not allocate any memory.

This leak is exposed by t7900, but plugging it alone does not make the
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 7dac971405..3acfa367ad 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1476,9 +1476,9 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 
 static void initialize_maintenance_strategy(void)
 {
-	char *config_str;
+	const char *config_str;
 
-	if (git_config_get_string("maintenance.strategy", &config_str))
+	if (git_config_get_string_tmp("maintenance.strategy", &config_str))
 		return;
 
 	if (!strcasecmp(config_str, "incremental")) {
-- 
2.46.2.852.g229c0bf0e5.dirty

