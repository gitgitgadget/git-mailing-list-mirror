Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591322820A4
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203954; cv=none; b=ALnjkWJU9/VgR7uM//Bweg5s2AbVk2fwBLynWblz8+2h0GV1/FzMnPEOFS6IJgJHLLB4NH4oBZTh9hmerNdmgrz5yz5pBlrmXLRagHHfqdM9Q3ninNCARTboWbNF8Mj9R5+wC2zGP+NVxY0zxorkdeRUq0AELNxDZnPcAyfBRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203954; c=relaxed/simple;
	bh=JNT32GaPJXno4+nubr4qRZioskpoREu7au9ju0UpuR4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rip/i45HbM/5szJWwJxawLf9H0nee2f5K4tKLKRJeFHMoI9pgVOZcLRjWioAKZM6DNC6lrikpUJR2oVM26ukn++usmJ8k1MuapYGuJVGBYrRlti9ub4/knha5tAQ3cBxPuQumOkgGZ1QQ1idcccumOt4iMrIU1NGMLrPgtTwbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E9MGBrQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S067inA8; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E9MGBrQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S067inA8"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 90D90EC1275;
	Sun,  3 Aug 2025 02:52:32 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Sun, 03 Aug 2025 02:52:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203952; x=
	1754290352; bh=C2bbn95KiEEKaIJ0NfjSg8bhEELKIh+xNFO3xC4W9GM=; b=E
	9MGBrQXzWiB7FULPCInKMlQ7ZtVtnWtjh+3wwv8xvstdM35qgDotD/cTNaI/umzY
	6bXp0TFwPpdcC57mGl40XAbwv54btoZBJZ5uzDMHFepvyP00l2NK46mHXsoFWLXM
	NlMnyKMCRbc7cd90PJqTQL9GDSbho88G+yOCzcHFfwXBAwBQ6paH/i5Geik6joCb
	J27NxiOJ3K0YdZgxf8U8rtvTpbnOQa4gYD4eOBNmIQpVjhZEpSuQJuSCtPtknrHb
	4bczlauh9zdx8Z1hq6MgyPFFPbrPiOgWgkEA3bUqmJ1En/EbC7HfgIvZ5MLotF8T
	c2vc6Fom29k3WpRp83ShQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203952; x=1754290352; bh=C2bbn95KiEEKaIJ0NfjSg8bhEELK
	Ih+xNFO3xC4W9GM=; b=S067inA8hw12v8GcDE3Ux7yXVQGJtPKxn1vx4YOSNRZl
	yitmK4ox5uZN35K3k1nfaatveeLi7XrpnXfa0Z15Monvtg8B70l7q7ehtn7GWsVX
	h/T67lS+Jua373WKeyXKrYxW7NdNs8Rp/HWLB+fPY+9cUzky3WgKAQezquxoM4pv
	HWmAegBkQ+6g0dSjhCeWfmE2+buIPUWQcGDaG2vs9xK4FeC+NKFzTEY3LmKGdzOu
	4jlr5VNyni5YiBS7Zd8oM0+T5pVW2NzODI2jgmgaiXPOnuN6H2jZ39nizCYLoXKO
	p2cs/T9iJHTU3yduyktPguee8R+P7rWMmRyFF9152g==
X-ME-Sender: <xms:MAePaDdFzM-yamrY3uquD4HqCAbCSF7MbPGHeAcByEJJRBC6rtEk_w>
    <xme:MAePaJbYJbXqff9wguYnmGsKnSXxfv9i6-9FuEuUwQ26DW9rcQJH2mUWcjXKzchEr
    JLmH3uKHSlCgEJCTw>
X-ME-Received: <xmr:MAePaOVE1gfmlehMTWGt8kC5TfDgCEuDJb2haFew2eMzozKPzDSCXMWWhlvSiG0M81f_hXiioGNEY7pcYefemTeWKJ3Tlg0n9XNQ1cA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:MAePaDiRA9siALBRcv5JpOblWL2sH7UE4f8XZ3bchMuaQe2MsOzVSQ>
    <xmx:MAePaEUQNYLpmZJRN5lM0w6tc-4BAQgj_5vDJZZ9gMjm5s5SzhHAnw>
    <xmx:MAePaCOeZs4w69FGxqrpu11dEr8H2Ia3C3XfxnsGMi4dTNUDXj6SRg>
    <xmx:MAePaIa-2udgOQCukqdbd8TEIavQUvFNfTWvHFHGV_CkG5YvFi9oFg>
    <xmx:MAePaGAo8zIMhWgyJqBpXmJUswLqGVBenoxMFnaiozi4_RP0lA7wkD8O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:52:32 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 5/7] diff: simplify parsing of diff.colormovedws
Date: Sat,  2 Aug 2025 23:52:21 -0700
Message-ID: <20250803065223.3325111-6-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065223.3325111-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065223.3325111-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to parse this configuration variable, whose value is a
comma-separated list of known tokens like "ignore-space-change" and
"ignore-all-space", uses string_list_split() to split the value into
pieces, and then places each piece of string in a strbuf to trim,
before comparing the result with the list of known tokens.

Thanks to the previous steps, now string_list_split() can trim the
resulting pieces before it places them in the string list.  Use it
to simplify the code.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/diff.c b/diff.c
index a81949a422..70666ad2cd 100644
--- a/diff.c
+++ b/diff.c
@@ -327,29 +327,23 @@ static unsigned parse_color_moved_ws(const char *arg)
 	struct string_list l = STRING_LIST_INIT_DUP;
 	struct string_list_item *i;
 
-	string_list_split(&l, arg, ",", -1);
+	string_list_split_f(&l, arg, ",", -1, STRING_LIST_SPLIT_TRIM);
 
 	for_each_string_list_item(i, &l) {
-		struct strbuf sb = STRBUF_INIT;
-		strbuf_addstr(&sb, i->string);
-		strbuf_trim(&sb);
-
-		if (!strcmp(sb.buf, "no"))
+		if (!strcmp(i->string, "no"))
 			ret = 0;
-		else if (!strcmp(sb.buf, "ignore-space-change"))
+		else if (!strcmp(i->string, "ignore-space-change"))
 			ret |= XDF_IGNORE_WHITESPACE_CHANGE;
-		else if (!strcmp(sb.buf, "ignore-space-at-eol"))
+		else if (!strcmp(i->string, "ignore-space-at-eol"))
 			ret |= XDF_IGNORE_WHITESPACE_AT_EOL;
-		else if (!strcmp(sb.buf, "ignore-all-space"))
+		else if (!strcmp(i->string, "ignore-all-space"))
 			ret |= XDF_IGNORE_WHITESPACE;
-		else if (!strcmp(sb.buf, "allow-indentation-change"))
+		else if (!strcmp(i->string, "allow-indentation-change"))
 			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
 		else {
 			ret |= COLOR_MOVED_WS_ERROR;
-			error(_("unknown color-moved-ws mode '%s', possible values are 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"), sb.buf);
+			error(_("unknown color-moved-ws mode '%s', possible values are 'ignore-space-change', 'ignore-space-at-eol', 'ignore-all-space', 'allow-indentation-change'"), i->string);
 		}
-
-		strbuf_release(&sb);
 	}
 
 	if ((ret & COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE) &&
-- 
2.50.1-633-g69dfdd50af

