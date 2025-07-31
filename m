Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D72989A2
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947726; cv=none; b=HvEuu15HHWs8R8jqmgZlkbpLG7FztblN0hNnglicCkfaW4NPTiwEWnbjR325eoOJLOMv2R4NJAVcfQEeXtnjCwLFFW7jrvsy9tCchSaGTRwJdqLPOaL1pUA6oTh5Rc/49COtdVZl/9R6Wet7RP5FsED4hmA41pTlE4oBdrmG6os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947726; c=relaxed/simple;
	bh=kdArzyccI8K9PBw9CZb/hsLUYJeaNMQ9WUsT6GvJsx0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S/jcx8baPgMpEzc92y5Nl0R6XVUrv/AtfLOW4JCSYCVgYyGPvjm0KcQgRu4NXh0VmIXPjtsRyqB6XVYCQzb3eLyfLrURfuyuQ3B652Drp5GIZfvacuTdY15GKTx3GD5dopZ3SSwmmAeSn0Aw3ICXuUqJF7VMjihBWMh8GZ6xV/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UPofIf08; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PDv7N9sS; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UPofIf08";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PDv7N9sS"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 904AC7A04FC;
	Thu, 31 Jul 2025 03:42:03 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 31 Jul 2025 03:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753947723; x=
	1754034123; bh=xu9Uysv9B6xdA6GdwyeTz98djQtfb1bWDrV9TERg764=; b=U
	PofIf08/swGQl8TciyuG7y1GkdvhXctFygUhhNcTSVhVj3AX2PQYn1KG/KBAlm1s
	3Tj0Df6xoq/W1Z8WKIEByY95e2zeYyqyQNsGzLIZJ58jNRbOD7eOah6lN568aHqB
	zKctcR3T8REN9dUnZ9yhVVfEtGZZ/RmUyEU2SJyDEH2E/CxBTQcJxGttdDOCwigj
	rAAR4yNq+1f8HZS4n1ISGIOF4ZFq04eNGFpLuuxXmmX8lnczyk/LH6MU94kMAztq
	r1DNgRbEMPpZMWT7yGv3vig0gaqsncibtQ88dIwjDsOpesDf8vqECK6+TLiPUlR0
	ls120XNuV+FwwHe6c+nug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753947723; x=1754034123; bh=xu9Uysv9B6xdA6GdwyeTz98djQtf
	b1bWDrV9TERg764=; b=PDv7N9sSf/JV8VBugAtMAVGjZiASauNB9FPPRNP67Yqk
	PF5J8tlawvuYmZOll+zZ4Ir5HGV6yJiLMfj/xXSbhEbA6M78BwjLbYRQowWR3wNX
	qQP/4K6pRzK8lOY2+n3U38XaWcR57UkTILBQZ01AkOEBIk9VHMiEQsMW13tkQJHi
	NJUDbbGUpWXbDDjM6l2PcdG6kCkcIUEwtnj1ipYFGdjogRQbNh5a2XP2rPd1dHGl
	Hq+1/Bk6IZQdtBmfM93fN129Uf1j56XMDzEsoHlhkTBNlbnH4clDKD3HY17M47L7
	BXk0C9KO9tqtWMmMnIazp+4P5nNxPO/TEbcKjPuxLg==
X-ME-Sender: <xms:Sx6LaFu-VbmP3ZXfOU4fJvdllOOlwQbMjtt6K8Pxl59j1VNVSWwymQ>
    <xme:Sx6LaOrEtIxr13US693N2BrZuX-SkkJz7fgbQAS3cX5PjmSUCUDAVUI4p5QMhhJ2q
    2NrwR1I3IOWlVlwMA>
X-ME-Received: <xmr:Sx6LaKlcdO03v3GbipX30yJW0WPSwqnJt9faX8cKmv6rJ4NN7gnq7kuUwTxLA4xJlj9Zci806-27Xjix-0MVOZwSIpt_jFdWBp2KFL8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:Sx6LaKzHXYlGfiZUjhJuJHEc8tlaNtNhfUNXHqzzOy6g85-4Q5R0mg>
    <xmx:Sx6LaKl3epa2oOwJdaI5fnEt2zcXRFvthFyIz4xZsGTe1MiinkVyfg>
    <xmx:Sx6LaLd7B9O1tc6tD8G6-8eEYu-AvXWsqBH1ImdTSTusDtg_-_6gfA>
    <xmx:Sx6LaIoO3APSkYV4oQAWGrCDtVKtb8Nxa5YEiw-ooPM-tOEBfv7kvw>
    <xmx:Sx6LaIQDBC3WEBjTgRaqyUu8OFawuou7uzJBtrMvX3I9LnkQjDXQSFh1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:42:02 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/9] clean: do not use strbuf_split*() [part 2]
Date: Thu, 31 Jul 2025 00:41:49 -0700
Message-ID: <20250731074154.2835370-5-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
In-Reply-To: <20250731074154.2835370-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
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
2.50.1-612-g4756c59422

