Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC3C281376
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203992; cv=none; b=RSki+qvAXhLPSdJyZYHx+UFrxm1Ir4kbS+kQvrUnFjbO1ETUwAEfFA4KlVMG6aHNGBZyOF423OMYk5eF5STAGi41PbNXfOLc8hv2X2WyeKFGVMwbC1mgexw7dP6mrUO9OEdIXSkZzEtncz5vsEcVpMlaC8YWO012+M91ZlR4mV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203992; c=relaxed/simple;
	bh=xuClHVqVI7l2CqhAweEYSiHm+YYY5qaVwFIG4H/hKbc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okAmpVISl3LIOIkDbs+5TcvD5uz/vLqaazSUPHanfChiHi8rGXbvVGk5g3JigeefQJMSfpHikIlOPN/3D9xxDo9PkabIcq1FXlC24Tm1QOtpB5Ce6vpOtSu59mWIUho5p4c/gsfLZvAY6o6JHH9xsHOGG1eGLuAYR5FMLnFTuZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j4IO5vHn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q1L1oALj; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j4IO5vHn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q1L1oALj"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 8DAF5EC1517;
	Sun,  3 Aug 2025 02:53:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 03 Aug 2025 02:53:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203989; x=
	1754290389; bh=boZWdz4QNNL0Szdx8L3eDOEmLc+p8yWvwGGgl0medNg=; b=j
	4IO5vHno4SUyIn0AajvTanxfh9QcKe7tm1MOvZIKhAKyCQgW289GTXt7Sog3bIz4
	Drf61kaFf+LJDJzhhcxAoLO/SL5xCBUUSN2sgP2Pgl2Bxk5r8le7Uzti7LEbLpeU
	LGGk0sV2sdW3+gvGPIEs47/O1f21TeNUXEVRyO+4UpQEp2+yiy1KxoOp9gYIPe/d
	W5GX0zK47W4vSwVwhQqECQxX1DWxgFYNdQ1OuTpGwQfZZ3q+wVL9D6a7sbxdH0i1
	CjltjS34VGY9sEP3Kyc8n0PLZ0Y/o9szlXnJyUToHfnRzTxW1pisjs7tY44xFcLO
	j75H/sC2+wEzLY0n40XHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203989; x=1754290389; bh=boZWdz4QNNL0Szdx8L3eDOEmLc+p
	8yWvwGGgl0medNg=; b=Q1L1oALjtklwnhzzhswEuS7VMza5R1r8OxAZgkzVixuB
	c61lcrHc/USk4pizQR4hSGAm2QDFotd7lRbD78tTjGPLVQFqKk0RZwU9dGXZlfAU
	nog9H1SDJGjRh9q897zpjYTiZZguUIdSEUw+6ecUP7lcxQFh9mlkmR3bePCWElvI
	1jz2AccgXQxv7GuJ9O6QNx6MkvzWcUfXcgVno25q2prW6+n0KDxPGS0tcq9UzJEQ
	en436YMvQBp0es5Cid7kJBbCRwiqDsOmc4D7uCJ0jar/hW1VKbSywJCahAQh2hQ0
	J8V2H2u4lxxaSx2r0XNGGcDI3JuJE93iDfHiiC2QzQ==
X-ME-Sender: <xms:VQePaHYL2plDq_3mG0xmnmM4lf2IVNv66e1sWz1LzNErE6k9dedCDQ>
    <xme:VQePaGnbM4ECsaRZw3TsBi0JJB-Cgq-AZy9_0SeAc8JBPxZjHk0wweUkbYP9qNei_
    TePk09EHnI569GCjw>
X-ME-Received: <xmr:VQePaLwK2xSWXYJFPEz13vOpwt7WH-aNmooGybCYC1pcHZli6LizOTCGR7kY8Od3w3YLgbNpWxAq9ZJO8SAvuNGVClYwXrGIkeYNfZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepgeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:VQePaMP3_oNNkAUq_np1IabELpTfstOYbq9rQ3Dx33YDXRwyWte7PQ>
    <xmx:VQePaHSbhGWbcjsyZ_2OCyLRC7_Dxkwk1gTYG8SmjKDdsPnVtDb4qg>
    <xmx:VQePaCYbpR_q1dbjYjHWRVa6MN8GfK37POeoFwAOfJhSUmY4_glapA>
    <xmx:VQePaM2qinyNggWppJGU5pwQr5sMJ0a-4_O7w-Ly-Nqq1ir7o64JmA>
    <xmx:VQePaB_6s1UNomcgUP8g9JCK6kuqbrwDWJ4uIWMVFfl8WHYuilJHihvC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 03/12] clean: do not use strbuf_split*() [part 1]
Date: Sat,  2 Aug 2025 23:52:55 -0700
Message-ID: <20250803065304.3325286-4-gitster@pobox.com>
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
2.50.1-633-g69dfdd50af

