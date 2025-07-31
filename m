Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBA429CB52
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947721; cv=none; b=OoekFBGuffIkfHOW0o7biWFiTkjmr8kMM4Cre7LNZNlbusyp+1zMWPNgjrLPwnFFwfQUrll/lR1fD5ocdg33V1lcnoIuISXmTRitluLa29FyXlbXGOROeVPr4OwyXi66UAU1j/m3MeSFBCC1oKhAibDUkIyEXF2fbKpcR8ThygU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947721; c=relaxed/simple;
	bh=MdlwLC+1c1Dns6qc0uuylDb6derkrQEu8US3hp1V820=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNtbr20vQGFEcYZHL7wUIVAOI4K/U+malnKXZSgZ0MXMFlzjT9CYsLUoj8gJbKFq8FcQFmhdFFvq0KQngaswuGElAVHLOhzjtii7q3vFysSXMo/XtitOfb1v2EGoj5FQnqfZaHbScoqwbuatCrRH7gKVuye/aIBXmnkcjYBNHg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GTwpvL6U; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MECNftIM; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GTwpvL6U";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MECNftIM"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8892A7A0B88;
	Thu, 31 Jul 2025 03:41:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Thu, 31 Jul 2025 03:41:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753947718; x=
	1754034118; bh=18oJ8p3NhzHsBdeD4SoKBzzzgjEhJOiwe3BWz99VnIc=; b=G
	TwpvL6Ur3i3bQurmbwt8wX/xaJvqM7r1CJnz8cObcb8OWZAup6VXKk4oK6JgSUHP
	HoHoACuvvkDOaX3LrnHKWAIY261WSnu5OeOM+F4H2SG+wVAKU60mNaLUIIaPW6Oi
	2mDLRkP6q1eTXIMfjkU+E7nEt8/OkVhT4eaNQ9aycgCIQu93D0oQXJhi7ZO/Nm6+
	VJ7t99K353YfJYeCweBOVjNZyoeA0fEcQxvbhu/FkRV02lZGk+k+4zc8SufhdGy6
	QUh+2kW6L7LPfZJgEdSC+6kT6paAywirQES3Vo/Q/e1QrQeIA3WjnjCNw86YAt2D
	52GZifND9XMMP1ZqK/YSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753947718; x=1754034118; bh=18oJ8p3NhzHsBdeD4SoKBzzzgjEh
	JOiwe3BWz99VnIc=; b=MECNftIMms9ytuIfiyVXEFT+i9t3zkQvpJS7D/vM6uIu
	u0xhsv/HsjeUSMYefzGw2bR0wCcJ6cI/OVBPHntO/AAduwtx+XhFQZQguX5KRWge
	h/1ykGPRR6JeRciY15wfgA29SPhpqeBAgxXx2kH6I+/1HRRBW8vzcMfn/JSUdS5S
	dItHIt16ZnTYLrNqvaAIan/ho4LxLHceJVYBOt3Bw99PqVUlCA72lrh6yxNr3eZM
	3A7t/i7IUWC5w6wSJYdf2QDWLoQK1dyfs+K1n/jWvv5rJZjlnrnTjycM7mzRq74Y
	69uRVj2Ba+KkchjlISPtYzR7L6UOaJZWVVjmCMjtrg==
X-ME-Sender: <xms:Rh6LaDEFndlXrExd5lHDsvmFXWJdSEOTLrDyFIjiLBbasKRp_KeHWA>
    <xme:Rh6LaAgy-jXsZR5ZNqWErWyTBTdGRCqgtsV9x_6g-T9s0cxWpiAmeuqqT3ty7Ncmh
    N02yg_xBF-mx8ySQw>
X-ME-Received: <xmr:Rh6LaG_GtPuVP8hI1Vm7dn1ni6o7yq4KInrhw_XE61HvGuaBHkbNICYEp5Y15qHdQcdBgHckdJ8cI1Nlmei_Dn19hfzM5y-RklEhT5s>
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
X-ME-Proxy: <xmx:Rh6LaPq0WrA4Rc-cUsmMbheEl0U6gIfDnhjNxOGBk6HoNI-FizP9FQ>
    <xmx:Rh6LaN-VR9W1fTx_9AyGY3hzifjH51tH34nZV-e8gX0wnsECAQ75hw>
    <xmx:Rh6LaLXcSYdBfzvsBkJL2wx4PL6qFBAEazDz1J3bWqABma5Sb7I9UA>
    <xmx:Rh6LaLCOaxX2WyNWtm_5LpjQDleXltepxMgp3h2BI0qSW4cIPnqc8Q>
    <xmx:Rh6LaFptlXIQXWQmt7vkMgegCqndpxeGXbweSWoEazkzP1B3kBERZVpn>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:41:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/9] wt-status: avoid strbuf_split*()
Date: Thu, 31 Jul 2025 00:41:46 -0700
Message-ID: <20250731074154.2835370-2-gitster@pobox.com>
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
2.50.1-612-g4756c59422

