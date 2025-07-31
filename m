Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CB27EFF7
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002482; cv=none; b=L3j/395IdxNtBOkk9ShkFTPILUqgJbK6MrAEIGnT6EwFPRNsYcPW2ZYgVZciZJ3NjlYdlgJBnMODdbr/t92fT0IfRiIjMyLQio1XedufSzZKzdK109INHl9uyMK6XIj6xhcg8NEUCGrVPli9VcWSRQHvYNFhUFANtMDKNpKkrXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002482; c=relaxed/simple;
	bh=i7X+7atfZEeiSs3aVqVib9CuE8vMRlaiKlyhFNiiwwc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ24pBPT5pfsLMitrTjcHRNCL6I5MzqKPKJwr11unh7qPliP+rBNJ2z3/IRUxs2Uoddy0bOd22/eMxxaf9/Ql3Aup696TFv1KyY9WCODlwwTEpqUfdDfE/M9hPgfh0VTz/bmBqnZfEAHMSJ3DZAox+2BVzPVBbLW2qgv3g7PKYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RIZcasBH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DQL8ejb4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RIZcasBH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DQL8ejb4"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0692A14002DF;
	Thu, 31 Jul 2025 18:54:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 18:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002480; x=
	1754088880; bh=wXBoO/TKq1y5V+/2wZl5yloWPuu/v0Zvctr1PVtdHPY=; b=R
	IZcasBHjSbBTN5lQejv4H6bzcbfX6LYI+0Oh+B3M2YihWj/IeFEEmElbXAWA479F
	VSWcX/rOc0uWlCKHIUG9n8o5PkRlBRF8Y4TRNfYHTafx2V2fIKo8SHa8a9HekGgX
	WEDk2JxYJIOVv07vQEYEmnZhkROfHmseaYZCLPu9k0djUOUrZmvpFkxmblqHocz+
	JZUpOfcbxA3SkAX9VKDv/+m7yV+GhsB2prf+627A+ojqZur495aVR2DBtrRnD/zz
	TkPD8xv/9ZyZoF5RCVNeG+9bNZMM1aL3Gxp2ekXMKBPsLnnNyWUP1M3RQYoGgLRR
	R/HUajEbdPBlO7+UZSG9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002480; x=1754088880; bh=wXBoO/TKq1y5V+/2wZl5yloWPuu/
	v0Zvctr1PVtdHPY=; b=DQL8ejb4p56NSwAQRoZft0Er9Ac8aUxNtyZmoCjI7FqN
	7rmkCF2SLh8IiFwAUt03vovXxhxWfDM5FhJkegU3A85XBKxxdjksaSfxXX+7VXxk
	Rdk5hZ1Ajjq2GwSILovsHyiwqteZ+OAS2PT7EzaP8HeNnJAI+fwX2L1kk2eDK3j3
	dIkFaDTks52myBts9If7MU5BMurjt4hRVaG1n4H6CO848+Fd5LIliZyC69P0N6eE
	CYWMhH06jfsEKiH2Q88aM/bV7/Ni8SHzxcRdWLTZbOolqNPOCaRNoThu3IZ4Zjq1
	u3oD7Fi3YikYfMDZayrI+nwmRu5nc8ybS7dUSGtT9g==
X-ME-Sender: <xms:L_SLaPussx7ZrDc5o6Z8oYZb9ndw2LVrw37mCgKTSDJwsjFJDy0SDA>
    <xme:L_SLaAofl9Vgn-rNj47d_4vX9Cs_IICP7e-je5s2OTs0MLmd1W7XJSTZFJwGIkxN2
    pV7S4RC7zcQjIjUpw>
X-ME-Received: <xmr:L_SLaEl8TSiSgFkq4tkI5HnDFduuN2ZQEAT6qKfPXduKL5bGhffj-qLtyxBXK2KfFOE_qL8DskRujnziUjfxIaSS3jOd_gDOK1ZaP7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:L_SLaMz-uZFdky2tXkXC9oU85-skRxB1eHhBJDvm9iG7N2b9B76h_A>
    <xmx:L_SLaEmwxJB9AaI8gYQdCtP2dg9h7aTAk1gtCRJdJ4lv_ERy3XnIzA>
    <xmx:L_SLaNdXAQfLQilDzY7LlW8v3XezjAbs_NY7tnVn6YRktSvNGeH6iA>
    <xmx:L_SLaCqIg06GAKwk8yvSHoK2MhJk-C4VpDrRoRZxYdwiZYlMlPMI-w>
    <xmx:L_SLaCTCHcK45JBG6xg8b-hCXDaNOp1ouD1U4NBA9C94pUo-IR5I5hOf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 03/11] clean: do not use strbuf_split*() [part 1]
Date: Thu, 31 Jul 2025 15:54:25 -0700
Message-ID: <20250731225433.4028872-4-gitster@pobox.com>
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
2.50.1-618-g45d530d26b

