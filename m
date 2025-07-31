Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4EF27F166
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002483; cv=none; b=mVUhnhDjqf9QEYzgJgUxvjOD5YoOTz+xVxhdi6hRAzT+QV7EwpPbVOfYRnQGz8+cTAgwchWtnVT2UzOaLAziyakxOGob1WDNxKaPZ8ajST/aNt62yI7Fi+4UgA41SMqauQW02txqegnbqxDm1PkIhZHGnHcqoTjKi8wvN+5tDm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002483; c=relaxed/simple;
	bh=wwlDgXW8OiSBetZETggEOhAyZ/ZCWyAtCeBJoI9cL4M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ttWpFTvpL1Dv8Avdyfm0OW3dvP01tK3eU5HLn+BIDPThjcba80g4ygvBupo1iBuQlKrmXL0calMCQGhRzIyHDJbvQuz6rrgqowOUC7MBqmmltX7NiI+K+lgXQ1C5JrGEB5/PNKr1DM1XQ0pqsZmJ2Bm8y54TRoMCcF5uAzxDBUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HwFJMoVt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gUUSCJcY; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HwFJMoVt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gUUSCJcY"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 66F0CEC1560;
	Thu, 31 Jul 2025 18:54:41 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 31 Jul 2025 18:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002481; x=
	1754088881; bh=knsbDv6M1h8gObyLXTJJd0teKQtLXfcVgSVdyxz0Nas=; b=H
	wFJMoVtZcynny+yrl6FzB27jzEmOraHYufzMWUQLsp6QSJmVUB2J0R47JdNwragR
	CkNntg8CJ8AjHVcsBih+o2FvRp8ANVw7MlpDnqoApWu6oDOrNyRjEJSzudW7k+XB
	swUxjA97B3C7pIb1L+KhSBZxa9r8XSq4Xzi0jo5yvZmtRdKO/ojYXCx8MXYFF717
	WwVW01Z8wcMq0vZazA4ZJnitrHf1SUfNXmP+CQ9vEeALB4X7zSpyFB8a7JPq3fks
	bT5M+r4992yMdEwX4YGirJCxVfr1m5l1jzQNQj3j28xCwFvZ+FMos4dIqaCMNs+K
	MfbQBiWlrAPknpBmGFcrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002481; x=1754088881; bh=knsbDv6M1h8gObyLXTJJd0teKQtL
	XfcVgSVdyxz0Nas=; b=gUUSCJcYjBY7KRXWH63BnHE+gq3ETvA9s2xlkgdzwvlt
	ioB6Ajy2ZGVlzXYSjSuyHxy+5lT/K6Ym81QAVALVC5COt7M+k6acBQu+uPonf/nZ
	HKLWwMfcJj+e1DGg27ujLYjTY98YhqMmJqm2h2KiIjRFKjGvhc2VmFUtPcvbg30R
	D2cO1AXJ5hMY6eR9Oi6cWEnSg7OKq1PxI0asV+bPlBJQjgEp2XH3gTBx0385EEc7
	dG6oYyKT6ICDZrIZSBBT1j1ioBt2aRtB3tA1T1/Z07a9Zi9qXceoS/0kQgkDckgM
	yykRbW1Tmb/X89s3rC1aKREzidNFSdOL2Y775REuoA==
X-ME-Sender: <xms:MfSLaMgWWHMLxmd7AtOT1ZNQDpzwPohuhJeFYpJE_I-GUZDzwEVMmw>
    <xme:MfSLaFNZouU-Qk3kuZprhJvQtfmNG_e2DqKkWpMSOQS5HD2UsHFoXCRBI0K73lvNx
    H-wWwW9EaOl03-HgA>
X-ME-Received: <xmr:MfSLaF7jvhzZ9L_onop9DlAtfF1TLhCVOY1AQL6haCcvXrTS3IeJe3Wi2cbR7DylDCE9eg1p8fRVd1ZDMtdzmyzH_VLuTti_qkAq8e8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:MfSLaL3A-8XFEzOqPjjgNCTB7Ctb2oNIrXamXtA9KWJQpvQGgDROjw>
    <xmx:MfSLaObJLq2ajwP6yP1zo5E8NTNS9CxCRI7VkP_hlB1o7LWDduEqmw>
    <xmx:MfSLaLBN7TWUvMuEanoKghy3gH7KJOUipr4LBzDdcX2lO_SdeXs5Nw>
    <xmx:MfSLaI8r6Bkf9ZOxy4ECCmssnqM2C2774AC_EEr3edXVWo8v3Y__yA>
    <xmx:MfSLaHEWBPbfnh-z1d0znkpt6I60Nnms9ZRdfF4neoTzVLao3uK0msQS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:40 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 04/11] clean: do not use strbuf_split*() [part 2]
Date: Thu, 31 Jul 2025 15:54:26 -0700
Message-ID: <20250731225433.4028872-5-gitster@pobox.com>
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

builtin/clean.c:filter_by_patterns_cmd() interactively reads a line
that has exclude patterns from the user and splits the line into a
list of patterns.  It uses the strbuf_split() so that each split
piece can then trimmed.

There is no need to use strbuf anymore, thanks to the recent
enhancement to string_list_split*() family that allows us to trim
the pieces split into a string_list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 708cd9344c..56dabf7e03 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -674,12 +674,13 @@ static int filter_by_patterns_cmd(void)
 {
 	struct dir_struct dir = DIR_INIT;
 	struct strbuf confirm = STRBUF_INIT;
-	struct strbuf **ignore_list;
-	struct string_list_item *item;
 	struct pattern_list *pl;
 	int changed = -1, i;
 
 	for (;;) {
+		struct string_list ignore_list = STRING_LIST_INIT_NODUP;
+		struct string_list_item *item;
+
 		if (!del_list.nr)
 			break;
 
@@ -697,14 +698,15 @@ static int filter_by_patterns_cmd(void)
 			break;
 
 		pl = add_pattern_list(&dir, EXC_CMDL, "manual exclude");
-		ignore_list = strbuf_split_max(&confirm, ' ', 0);
 
-		for (i = 0; ignore_list[i]; i++) {
-			strbuf_trim(ignore_list[i]);
-			if (!ignore_list[i]->len)
-				continue;
+		string_list_split_in_place_f(&ignore_list, confirm.buf, " ", -1,
+					     STRING_LIST_SPLIT_TRIM);
 
-			add_pattern(ignore_list[i]->buf, "", 0, pl, -(i+1));
+		for (i = 0; i < ignore_list.nr; i++) {
+			item = &ignore_list.items[i];
+			if (!*item->string)
+				continue;
+			add_pattern(item->string, "", 0, pl, -(i+1));
 		}
 
 		changed = 0;
@@ -725,7 +727,7 @@ static int filter_by_patterns_cmd(void)
 			clean_print_color(CLEAN_COLOR_RESET);
 		}
 
-		strbuf_list_free(ignore_list);
+		string_list_clear(&ignore_list, 0);
 		dir_clear(&dir);
 	}
 
-- 
2.50.1-618-g45d530d26b

