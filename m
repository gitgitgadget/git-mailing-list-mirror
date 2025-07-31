Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48C929E0E9
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947724; cv=none; b=QuMxpO1CO5AIbDl2FDqJxF9qwdkEZ56M5nwo49ULA8keHGv8bCxT4tdxTIr+4En9is/rE4kfS+uebOkZ9f80SXPewjFXsfwT0YXD3a/SlaG5R0R+Hg5iNBRypS3upARIb435NJVRzcRLnR4J88Yy6mxHuKvgxYhV9GhkqmPsWhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947724; c=relaxed/simple;
	bh=07z9Lm6Zpe5+48FOSACLcBcqqJF67RnNaBmDpHWQccU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tG8aV6rHdDaFXjuWxj1jFDKt0WLXDQ/OKOFpc8fksamvaMIUBmaWD4YDwdX/PYM5HBvkI9f2woVQqVEuzz2r5lE96ThM6RdZMXUw/3QMcRGoCk6yMbO9rbrMzN9KtxORGa5QIZMRvjRXlMFpbNIM0G0WqrRzmkdil878DpuPkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IPCajbvO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eA+v5o5L; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IPCajbvO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eA+v5o5L"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id E4A491D00E1C;
	Thu, 31 Jul 2025 03:42:01 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Thu, 31 Jul 2025 03:42:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753947721; x=
	1754034121; bh=P303FZR1pstaMBJWqCD9Zx+Njn+dDxd9bt8S9Af/ryg=; b=I
	PCajbvO5D0OWA+ZFVXx2Ao5KtllqqtFfWKJSS/ecTQbnZeev1IYbXJ6GiOYTs4NY
	lTlt3Ny7DOuCxgLnmCyUWctduK7UuGhSEpdCGAEhHsvWtfqHRqQXC8gvTKQhAxnC
	hGvU1i6sgTYguDuBFoGJloaCKwfMw4O/Y+6H9nPWKnbzxo0h7bKP8jBiWp2txSId
	Vlj2B1BR2ktlS+c4B3RuC1bHF692ihoRUromUIjc2sXlp3dk8Gwpt+KdkXzcjh+3
	hRqGl/Et/5+7vCKoAcG7Ihub3fCoVuIBc6/TJIhLRTNh8Ow6njlWxiNZgw505fCL
	cMSVWMhoK/RTkcMfGCDdA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753947721; x=1754034121; bh=P303FZR1pstaMBJWqCD9Zx+Njn+d
	Dxd9bt8S9Af/ryg=; b=eA+v5o5LWWRkUVTNJyD2Ohk3bJqQoJBMOVlO3VXiNjLT
	nqtlS5khLJeIGbffZybmLHcFU+Sv6Sz5C8G9sSFSThiNd1CuYb0DWzROWUvuSfpp
	3EEZtm3Ly+f8bhCt1nI1Uv4Z9SZXRdMUz/msn1YYO9zLo4wHkKFGEpVYQ+brIjAF
	G0wwp9bJpBLrWK5jCpFfJty6LdfKdrcZIN6GDXD7qp1DQabewfMexOX3wIAlIUJe
	0sQi1VeDiC3EhoF29jYyzHvE7N0EtrYhoKVU2BNQflmfMJEepwgj2Sk762zOas/W
	WDIs/nYT+D/bVK4jmtMePl0oCoE8Td2tIaXqN7WXBQ==
X-ME-Sender: <xms:SR6LaFeJLxkXNOtiNEms6-2Wi9Pifhu51JlrkLIqs1keAS8FfJAZQg>
    <xme:SR6LaDaaHrGyS1Mri7XJcFQ5H6H0-XNag19ctvjz70S-k8IWtWPub4KGHLAQMF-qk
    1id-i1Mq4ikOYALjQ>
X-ME-Received: <xmr:SR6LaAV2Ng63euldapR4Br4L3NGGZB7pS_3bMcEjIaWWPGqIAOuahJ18OjOHNiJ8gI2ktQ4Xe9PKkmN4ERYPJpskCxA4PHVibZygick>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:SR6LaNg7mweWEuy1zjFnLGD3ofvJHwRPjOL0MUGrFzAQiDb9H1oGow>
    <xmx:SR6LaGV2lM0L-ZR-ztrzeemzM0D17NzUKpI8B76ytW3EVUUaAY8kdQ>
    <xmx:SR6LaMPZRYGTmc5fQYlsNAsA6MEIf2x4reJaSuamOTat2s4MVuLKjw>
    <xmx:SR6LaKbh-Fc5Iv9x7cEkutRHm6ChCBA3WwrXRojJ1qCNOckTtz2jMA>
    <xmx:SR6LaID86kCDxcOTkjJD7PonYWqJHE_R-9KEz_ZpBXypeUgBt5ti0Txh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:42:01 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/9] clean: do not use strbuf_split*() [part 1]
Date: Thu, 31 Jul 2025 00:41:48 -0700
Message-ID: <20250731074154.2835370-4-gitster@pobox.com>
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

builtin/clean.c:parse_choice() is fed a single line of input, which
is space or comma separated list of tokens, and a list of menu
items.  It parses the tokens into number ranges (e.g. 1-3 that means
the first three items) or string prefix (e.g. 's' to choose the menu
item "(s)elect") that specify the elements in the menu item list,
and tells the caller which ones are chosen.

For parsing the input string, it uses strbuf_split() to split it
into bunch of strbufs.  Instead use string_list_split_in_place(),
for a few reasons.

 * strbuf_split() is a bad API function to use, that yields an array
   of strbuf that is a bad data structure to use in general.

 * string_list_split_in_place() allows you to split with "comma or
   space"; the current code has to preprocess the input string to
   replace comma with space because strbuf_split() does not allow
   this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/clean.c | 50 +++++++++++++++++++++++--------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 224551537e..708cd9344c 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -480,40 +480,36 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 			struct strbuf *input,
 			int **chosen)
 {
-	struct strbuf **choice_list, **ptr;
+	struct string_list choice = STRING_LIST_INIT_NODUP;
+	struct string_list_item *item;
 	int nr = 0;
 	int i;
 
-	if (is_single) {
-		choice_list = strbuf_split_max(input, '\n', 0);
-	} else {
-		char *p = input->buf;
-		do {
-			if (*p == ',')
-				*p = ' ';
-		} while (*p++);
-		choice_list = strbuf_split_max(input, ' ', 0);
-	}
+	string_list_split_in_place_f(&choice, input->buf,
+				     is_single ? "\n" : ", ", -1,
+				     STRING_LIST_SPLIT_TRIM);
 
-	for (ptr = choice_list; *ptr; ptr++) {
-		char *p;
-		int choose = 1;
+	for_each_string_list_item(item, &choice) {
+		const char *string;
+		int choose;
 		int bottom = 0, top = 0;
 		int is_range, is_number;
 
-		strbuf_trim(*ptr);
-		if (!(*ptr)->len)
+		string = item->string;
+		if (!*string)
 			continue;
 
 		/* Input that begins with '-'; unchoose */
-		if (*(*ptr)->buf == '-') {
+		if (string[0] == '-') {
 			choose = 0;
-			strbuf_remove((*ptr), 0, 1);
+			string++;
+		} else {
+			choose = 1;
 		}
 
 		is_range = 0;
 		is_number = 1;
-		for (p = (*ptr)->buf; *p; p++) {
+		for (const char *p = string; *p; p++) {
 			if ('-' == *p) {
 				if (!is_range) {
 					is_range = 1;
@@ -531,27 +527,27 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 		}
 
 		if (is_number) {
-			bottom = atoi((*ptr)->buf);
+			bottom = atoi(string);
 			top = bottom;
 		} else if (is_range) {
-			bottom = atoi((*ptr)->buf);
+			bottom = atoi(string);
 			/* a range can be specified like 5-7 or 5- */
-			if (!*(strchr((*ptr)->buf, '-') + 1))
+			if (!*(strchr(string, '-') + 1))
 				top = menu_stuff->nr;
 			else
-				top = atoi(strchr((*ptr)->buf, '-') + 1);
-		} else if (!strcmp((*ptr)->buf, "*")) {
+				top = atoi(strchr(string, '-') + 1);
+		} else if (!strcmp(string, "*")) {
 			bottom = 1;
 			top = menu_stuff->nr;
 		} else {
-			bottom = find_unique((*ptr)->buf, menu_stuff);
+			bottom = find_unique(string, menu_stuff);
 			top = bottom;
 		}
 
 		if (top <= 0 || bottom <= 0 || top > menu_stuff->nr || bottom > top ||
 		    (is_single && bottom != top)) {
 			clean_print_color(CLEAN_COLOR_ERROR);
-			printf(_("Huh (%s)?\n"), (*ptr)->buf);
+			printf(_("Huh (%s)?\n"), string);
 			clean_print_color(CLEAN_COLOR_RESET);
 			continue;
 		}
@@ -560,7 +556,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
 			(*chosen)[i-1] = choose;
 	}
 
-	strbuf_list_free(choice_list);
+	string_list_clear(&choice, 0);
 
 	for (i = 0; i < menu_stuff->nr; i++)
 		nr += (*chosen)[i];
-- 
2.50.1-612-g4756c59422

