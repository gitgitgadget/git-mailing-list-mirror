Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8FE218E99
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001978; cv=none; b=EwtLOlOclGrwUvb/PctL79Bh4I53S8pULbj18bkdgPvIm8qwazaqpHwmjEhXxZH0ieilQA86mrvm6AsN1275CUg7cecYJ1gWE1BFCMFtfevyvN1iqJBxdxyq3BZ71e1SGz9ITPKK0lFzHzJdJtMBacwZil+90wDChCwR9PKkEJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001978; c=relaxed/simple;
	bh=tEHkEm1SjugisAQLTvpXln2SuG19ZTPlQyg4QmnauvY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obZyqfSR3bZtzahdxgttt1vwmsoj2aSM7jZ0kWMBf6BetQEowmgNUWoxAgzlzOcm9To5BGRjPq6XLw31ZwNtdthiEeWIc2duxkjS4LsfgXCW+l1HulFw0f1GIbDFdumnlJe51s5pf3tZbMOZeObYXXZYy0POW2fpD6RdBHTQT+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QbJFG8HK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DyMgkYQG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QbJFG8HK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DyMgkYQG"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 37773EC1292;
	Thu, 31 Jul 2025 18:46:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 31 Jul 2025 18:46:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754001976; x=
	1754088376; bh=FicbRMQcXu4tWUrupXRf1h4RXWFc0PCY8skUcQyG1nA=; b=Q
	bJFG8HKhsbzlKIVtY+Ii1TSkXSPQvP6GeM5XEw7VBprCM6n2d6fwruSGxKiUGsEV
	3n0UuMqtBT7bkw2TukGFQrmGWtqvgwdI5OHDfHFOB9XRjbg5Bg8MSxtoQ0s8whRe
	7Vw8iC68zb5uAkFSx2k5Y65mGgOxxQvs6h8uiKnxgBnQUtdbmCet5LuGhww1i8Vo
	19nJch4893zXO0RuqAv+yVkVDiAop5JQUQkgzX5ZUoRKacJxGIU2veCiYwv7jcxS
	vU6uRxhLmnRjwEe/qJVcRYqGrwdCRBqhvVYQGFyyEprZE9hT2dAn1rzm7EfQz71V
	xgmN8HZ4I4s7izxABXtgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754001976; x=1754088376; bh=FicbRMQcXu4tWUrupXRf1h4RXWFc
	0PCY8skUcQyG1nA=; b=DyMgkYQGkYAjhOMBn8XaeVM+RsNEElyrRbdGh2tjqh7J
	Fb6us3k1U6XBfTY8AWXSVs0bOHYsj77i5/lADZLlzaaLi6hPch6clJo4OFZFpogj
	FJFSLt71Dpp30yluYor61ix+IL2+GmFzK15GuXoP9u7v7YYJqnOohRhauOG/VKQH
	r4eWR1hs4e1pGxL5OyE1/vwyiEGU5uZTwYwtx+0RWpJ2zCndJqJ3Kd50kqDAzzxh
	iNsUqLcgjhI8wOkmveLy5nqtA5jmfPbih3CI9cZe7bi2wsCxDW6wTRzOqNYvwuBm
	mLpo4ZsU3w99i42+/oTTQuE8TQCXMEiL6eSgwsOhJA==
X-ME-Sender: <xms:OPKLaK6sPJ3xjo6IUaM3Jsu2XdNykzqiwXtaFFLhnu_CYfrThCsiqw>
    <xme:OPKLaEHQqr62Vwu58r6_IOUq1UNn1C1RC5xj4Q4DGV3MMEBAvXjifIkPrMAMFRpWL
    iVNwKfDYbxdcjSYCA>
X-ME-Received: <xmr:OPKLaLRamydTL5MX6-U2bT_1mseSlL5lDrmR3o_9OJzMiCIyswVE4b5k-rZN1zWyTrHPEYl9pkwT59T6fl6YigsZukJF-9sEwnqILWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:OPKLaFvUWRCw2XiZ7ElI819WdeBvPmOziaGGmkqnaoWn8-hDVZOmTg>
    <xmx:OPKLaCwYhfYTi_POEW7uJ63WDLFTisxjM4SWZHaW-gGv93tkHywQHA>
    <xmx:OPKLaH6Fh9bTZRGyQuXTqBa0I0g7GnL2wWFvbjBYghL619L2oQA3wg>
    <xmx:OPKLaEUCnR-lERtgSBLGK-4Te4eA0i0vH81PVLAoJXt9Cei8PnigQA>
    <xmx:OPKLaFeX1y_NE45rekIJgTJWncTmSaPhxp2kFOAtEIofSh2LRWTU8iha>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:46:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 5/7] diff: simplify parsing of diff.colormovedws
Date: Thu, 31 Jul 2025 15:46:04 -0700
Message-ID: <20250731224607.3942417-6-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731224607.3942417-1-gitster@pobox.com>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The code to parse this configuration variable, whose value is a
comma separated known tokens like "ignore-space-change" and
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
2.50.1-618-g45d530d26b

