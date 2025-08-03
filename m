Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B692571D7
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203989; cv=none; b=uLcdRD8RYpat7NuSdHaXFcsJfnyQboEVn1BXYSEH5EL9TRgdBb1LfV4C+ZDxbmNk0hp19pDdal8S0tvLm/KbszMcuMaO0z9dI7GG5Tv1Rh6G3+gemv7DISFmCxzpSh9ulyPDKJAcZXKdzxOFMkXNrpjlsMwBnF74IfdLuWdVXrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203989; c=relaxed/simple;
	bh=JAaxfg73jv2Y9sPnY85N0ypF2tdw1Y7/mnXDxSamRWQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/qpWkLMbaptePELoJMqg2WahTGWFhh7Cobd8oNlFrQCRsUonwJ4h+XsbcwUOcbJX1cDvBr2dV9OGmVrgHlfHQdM2Shp9YLe46AHCLn8Ol0+U1jrHh+uSlF1tENSeWTosxDQMeUnxQ9npDjKfU07vfOpAqiKqV2Mth4bnSoheAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MasMvBGm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FHz/w8Ok; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MasMvBGm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FHz/w8Ok"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E0FD1EC1517;
	Sun,  3 Aug 2025 02:53:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Sun, 03 Aug 2025 02:53:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203986; x=
	1754290386; bh=WX3fU6g0IlxnRHV4aS2ZRSVSbjcWXdG+BeTeWmQgqVM=; b=M
	asMvBGmpYycJwi6duS8ZKurV40fMMhEball4zVooYcK+WEFU4XlCf4AUMIh0zfhK
	wKJmA1OcT9zXRza49U2WgbvbINMzo5dHbtqC+96936Sbxii5pCxI0XGq2x3M4Nbm
	GVARCHo4S/RkoXPJMHlng6Y0xf4PEH8irFqfU1mF7tbNcQc5Gs82mjrmLDKH3e+A
	/mFprs/BVujGE5HW60beM01pSxeS0cMpk1F8sLMoOVIxuxA7/uLbRcHkXMntit7r
	O7TksgHGpOlh61oA/GPxH8Hhkg7lpuPIr9zwZ8BK4A8iW/gTFkziP8zqNU5/cF9K
	yxPNFwxDUh59t8W4hRymg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203986; x=1754290386; bh=WX3fU6g0IlxnRHV4aS2ZRSVSbjcW
	XdG+BeTeWmQgqVM=; b=FHz/w8OkrD6JvC7iKLcx8rnM/k95KXabJSTyLAF8NwbH
	RlaJDWlOrKL0qQAQxEU4b4iZHLWNCL5gA2dWoQFe2YSvBR44vjqhmJnwRtVlSDuz
	3J+Un0AGEDVUrZP4ajZj+yfmBq5QRXm4faUGs5LKDeysD7tKUzPr403SJnAnM2lh
	tPaip051Ek5lwqKjccaGpwpAxJYHc14ALlcvT6JS95/QA65Vw5ipS/+5Di+NJMIP
	xU9Uh019MaMtv0FpxtplBo+Ptv00PSfuvPAd0Qd2oJrL51tADdC3aiu6qyhc5gwE
	9L764xqyC+/Rplr2nt0sfjARzPUM/xuPGAA8K8icIg==
X-ME-Sender: <xms:UgePaKXyYcKlOwnzh71jpTyceUYJE0SOl7bisQwbe8uf6oihE03_Mg>
    <xme:UgePaGyEGb6e_MBKfo6_E0E1FSUbKAin1senLg1sEbeMehNUhVTuZHqKu2xTjqFF3
    2CLnQVnCNoS8cQCDw>
X-ME-Received: <xmr:UgePaAOzQMFX7T-ADlg1hflvKlSu-OqUITVXlIfZrfb4T3bXO8YgaoDJVioxJjI8a8b76WFaxS4z8ooEeSWOl2C68bG_RhGWkMZ1rlc>
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
X-ME-Proxy: <xmx:UgePaP5n6_MPG4WXfc4WeF8FkMBjwf7i1owT6vnmO6-NM4hkuuHwXA>
    <xmx:UgePaJNmaRrTJ7KFnzEB_K3RjscJD1I2ekC2YZINngrnZnd9oRu1EA>
    <xmx:UgePaFlxIdbH42MWWyarkR1SRG1nIR6noTytwCVjqg5wORFgMe1Nlw>
    <xmx:UgePaIQw8ZWNMUH4OjnMFM6bevA4bHZ-KvfkKZoCJceGy5fZSd_1Kg>
    <xmx:UgePaM4kwnwP9P5KPOFslmrZdlgCJDtRlX9eZP6sM5I9xxTrZ3Gj7Q1D>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:53:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 01/12] wt-status: avoid strbuf_split*()
Date: Sat,  2 Aug 2025 23:52:53 -0700
Message-ID: <20250803065304.3325286-2-gitster@pobox.com>
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
2.50.1-633-g69dfdd50af

