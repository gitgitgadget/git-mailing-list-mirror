Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251EE2253FD
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002479; cv=none; b=n8ZLxMRNZwq3ePHgoHs2vegoY+fS0L5G5MSgcNmRRigOFPRGVriVBmobJqH5fM8IB4rv1mXj267FENGrREFan3JyW0xjk9dxsFKolLILrZbQdLyJLSkyRBLs/qajB6fvT0Uev8uY+pfUSlcOJhEwmPgw7Bpw5IwGioo2JlKowuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002479; c=relaxed/simple;
	bh=9A4lK9FBTwvjoyDzsxpbLftk53+IkZm5y9W0eEXHdgM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eK9pxFbDEesuL/QkmCITiXyVpzkGGQBUgaSWs7Y/zwMSVsA+1wi0UWswY6BvdQJX9xV+xTYu+OfwfZw/QYAKM8wW0rj3uRwyj/6+TRaDJQyhY5g1OcmZu4wU/Cjs0Owsyj5Sx/7vG1eescQSkLQfLB91yMTVi9M8iFkwCZl/5WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=EdGpUsz5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S2H7GMLq; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="EdGpUsz5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S2H7GMLq"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5B6B5EC1522;
	Thu, 31 Jul 2025 18:54:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 31 Jul 2025 18:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002477; x=
	1754088877; bh=qjANqv8MgNCk+GZcex1/hBWDJ8qOFjXlmvySWoz0DD4=; b=E
	dGpUsz5GU0GWrBrcFU+0fyGRViZvyEK3otPi1u7utHDLWHB6YqXulrG6YJRXad6p
	oTxrbtcY1I01b02Uj8B5d5ULguc12Zy2IJYUjR9P7iFIzIakXfheX/nK2p9TjaEF
	RZ3Qb5C12XeqyXBKcolA7vOZkTXvZO4SpkF9Y3UzT78R0WVJogpfsKV10jE6TjcT
	AOeGSsUbKjrzHmNwlUGdvvALnDjE5zatpXYqMAvBh7Q3PTrQ3GLegSbev3BiwcF8
	WrBzjeFC3BDkNAd1/gwxPDZCKzAWQrxCKWEEcfjabvtYT6a9jkK+tL9ZOD4lIa1V
	jgIgad+QbEc4hQ5C+8Obw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002477; x=1754088877; bh=qjANqv8MgNCk+GZcex1/hBWDJ8qO
	FjXlmvySWoz0DD4=; b=S2H7GMLqUAOsvLtb9QaqJcKFyZiHBG4JO/Kjw9y6pQOe
	ZyiQPVqjMFNuvV61WZEYWofR9bZAoy9Bi0ebldGIl66DtpIsFktCNG5dl8LSZqrQ
	rKIOZH0X4IJntBBIi7iFNmyV7zcgMaL1F4gGZ6tqmiQq8thEYEhFZg9iqW9c5/0W
	6/d0nXw3JSEwvOEvKVlmQlFyqBMUD90Nw9HV88lhL3xsrsqBpZSNcSoT+b3k0CG+
	j/x4WtPK+hR8WNthnhIddzgmHGKCAAFzKkcuQ+gVzLBSt4QyvazJxhImeY6u+/G6
	O3WLEtfgnp/65xlOPXFDGXZzgEIffsOOTgl4kTuv8w==
X-ME-Sender: <xms:LfSLaMCik2hcl5QHeTW6oDUhq6yIihH0rHjWZqd_SIhM1WQgbik_Lw>
    <xme:LfSLaMcU79t4tt9cBHeHdBUvrb107SSjIrM_jNlPfZwx5xUAWoQQ6HpwnsIhhP6dQ
    4kv9Knuh9IxCe4kEg>
X-ME-Received: <xmr:LfSLaHIgsRR-6MU2fgC38T1J9y6EM7fn2wNptX1QbDg7T5etiuWnXo1u9Y1LMa6JeMos95YFIkaZ-8hvoY3Cce8_pB5Pky7ivPI8Rws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:LfSLaPcnQVWX9C3Jcdt4MhrhshS1BjwLQo9Mon34V869tBADbhrTJA>
    <xmx:LfSLaO2g7rs3WhGRZBmF5_mrogLTTA3PkUAi0Tjvh0vuXu_2aI6jFg>
    <xmx:LfSLaIhqffvT01Tegi41xWHKY8EFIzO88TW1rhk96Vdh7jF5IBuChg>
    <xmx:LfSLaESU-htcoCt0DqxQQqwTUDuHCX4LcBncsfFUVNkOAkBAp4yxDQ>
    <xmx:LfSLaG9sAzMn3zR5dCWPTEbUwZQ1i4Jd5PgY-oFDHecH5vk8spYBWv8u>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 01/11] wt-status: avoid strbuf_split*()
Date: Thu, 31 Jul 2025 15:54:23 -0700
Message-ID: <20250731225433.4028872-2-gitster@pobox.com>
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

strbuf is a very good data structure to work with string data
without having to worry about running past the end of the string,
but strbuf_split() is a wrong API and an array of strbuf that the
function produces is a wrong thing to use in general.  You do not
edit these N strings split out of a single strbuf simultaneously.
Often it is much better off to split a string into string_list and
work with the resulting strings.

wt-status.c:abbrev_oid_in_line() takes one line of rebase todo list
(like "pick e813a0200a7121b97fec535f0d0b460b0a33356c title"), and
for instructions that has an object name as the second token on the
line, replace the object name with its unique abbreviation.  After
splitting these tokens out of a single line, no simultaneous edit on
any of these pieces of string that takes advantage of strbuf API
takes place.  The final string is composed with strbuf API, but
these split pieces are merely used as pieces of strings and there is
no need for them to be stored in individual strbuf.

Instead, split the line into a string_list, and compose the final
string using these pieces.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 wt-status.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/wt-status.c b/wt-status.c
index 454601afa1..a34dc144ee 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1351,8 +1351,8 @@ static int split_commit_in_progress(struct wt_status *s)
  */
 static void abbrev_oid_in_line(struct strbuf *line)
 {
-	struct strbuf **split;
-	int i;
+	struct string_list split = STRING_LIST_INIT_DUP;
+	struct object_id oid;
 
 	if (starts_with(line->buf, "exec ") ||
 	    starts_with(line->buf, "x ") ||
@@ -1360,26 +1360,15 @@ static void abbrev_oid_in_line(struct strbuf *line)
 	    starts_with(line->buf, "l "))
 		return;
 
-	split = strbuf_split_max(line, ' ', 3);
-	if (split[0] && split[1]) {
-		struct object_id oid;
-
-		/*
-		 * strbuf_split_max left a space. Trim it and re-add
-		 * it after abbreviation.
-		 */
-		strbuf_trim(split[1]);
-		if (!repo_get_oid(the_repository, split[1]->buf, &oid)) {
-			strbuf_reset(split[1]);
-			strbuf_add_unique_abbrev(split[1], &oid,
-						 DEFAULT_ABBREV);
-			strbuf_addch(split[1], ' ');
-			strbuf_reset(line);
-			for (i = 0; split[i]; i++)
-				strbuf_addbuf(line, split[i]);
-		}
+	if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
+	    !repo_get_oid(the_repository, split.items[1].string, &oid)) {
+		strbuf_reset(line);
+		strbuf_addf(line, "%s ", split.items[0].string);
+		strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
+		for (size_t i = 2; i < split.nr; i++)
+			strbuf_addf(line, " %s", split.items[i].string);
 	}
-	strbuf_list_free(split);
+	string_list_clear(&split, 0);
 }
 
 static int read_rebase_todolist(const char *fname, struct string_list *lines)
-- 
2.50.1-618-g45d530d26b

