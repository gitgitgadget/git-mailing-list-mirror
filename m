Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D48244679
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222187; cv=none; b=Ea1UzKIMxn6X6ty/2jSac6xVu6dYBvVanj8delNKsZlL2XpuwRGwT7YOZQt6SLgSZzwKFf9ORdKcL/aXnEviWK8dPKmMmQr8f0NchUy63V59sUJO3kVF9CTB/kIbbNVAsFYBOUcW5Dm5ROJQ1+qXb320Hc/UWuExyeOLDxRFcnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222187; c=relaxed/simple;
	bh=E5o4Av2Kfzl49niTLEbjLT6AOT8kKBJyQyShod5Fy/8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bupd0j8hxAUHqnq0vcGBXxizKP6KNrQ2ZUxgNvZwMBSIErkeE7tRPoXe3t4c7s4qhIIgUr2AxouWDocX+PUlmp3vX5QD7Qcb7m8Oi35LhmDheHCwTZ+9RCfa4q/9N7wWsKmqdddqn0dAfwoUt8krsxwJVF8F+dfL2PAzyX3ylC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TDydJvTq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fHzDmPty; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TDydJvTq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fHzDmPty"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 479727A0404;
	Mon,  3 Nov 2025 21:09:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Mon, 03 Nov 2025 21:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222185; x=
	1762308585; bh=zEnM2UjYNZnysKwh/p7gPlESvuxz/LRxf86YNhYzB7g=; b=T
	DydJvTqlGhaacRRxeoDrclZ2Mvb+F1Eeo8WdJkDlFLFPJsUCYKnMLZuVAjp3MLAB
	3NX/gKkGdg7wDeHGVSvyTc0OAHknItjVkyL4DfwczisEpURi6YRb+kuYlMuED9EC
	HYQOQfb+1lUfgVzW9vkYbvVqDFQ1Hgz5tZyDrnhVxhkj+QatphegLRMX2Vq3K9YU
	laa2sVxL/iQLMMFg9BhRKgLitzgeDga/9dN32OusAP2Q4tD31wRCh3RMISyR7i4e
	nD43TSy+zS5qTZ/vmxEtS41AJdhRHTD/GUKPs9aHNLWSCAM2m7F1adBJ6mi2rwmn
	/nla0n0EzWaJbn+a2Oz4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222185; x=1762308585; bh=zEnM2UjYNZnysKwh/p7gPlESvuxz
	/LRxf86YNhYzB7g=; b=fHzDmPtyHvbkmAAP7Nm/Ne++PniCaHL/27ZPFcugYXEv
	BZeWdOO9sCYeQIQxznLQuB55+LFIPa9mxO25yaZZWAIbSXHNgYK1NTB3VfihkKYq
	Ou37DzzFTky3ZuXGIqeSIgSOQDWO2Z5X6fNf5ddclyRBz7J4L5iax2lDpqaaBBdg
	t7UKhyWdxtYJJnwZ8370OGgxeiZXY5a4FRHyVUA6Q6LHZp1rsjJo1hYeB6+VpJ9x
	Q1VCWNJy/fQ0E/WLsjVM1NH5SgzP6ofjpRXvnME4AOyWlitO0cV1/xpovzPDK0Hv
	p1gim4aJLXm1iQk4ZGJB0/t+xaq/XskYg17ys23L+w==
X-ME-Sender: <xms:aGAJaVzljqCCd1w09ZiA49cjIQgSIfgqgZP4Ny5DJmM8HkR9as6nUQ>
    <xme:aGAJabTvS9DOwvpT0a6okNSqfjDtTH5Jd00uSOfvMIq-FExAG8SwJiNfrKVtiH4Mz
    BUvXHV90J5jx7Qb3TP0cPhKKPEqmxeDYH44EFwE6VGrdg_u4yroKg>
X-ME-Received: <xmr:aGAJac-96S-kOITJJWdfkckJ4y3VR11gr9B3cyj2x2SXSe86FkBJdkJ_CaWwJZ4HbpO1YdvwV8ibt1ZvBICXzKb34s0kb142STnl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeeljeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:aGAJaSoUvAsGBo48adRtoqeNhDZvNMkEy8nQs0PQ5hK2Wti5UJJzfA>
    <xmx:aGAJaZnPsOXCFouiTENjnQg8KboFH1Tc4W4MrRmyVdrTVksRXE8ZLw>
    <xmx:aGAJaZLFb1Ov3C4Jt25hjdd_n4XP4nZADTUAJDf2VrHCsCZDZR80oQ>
    <xmx:aGAJaez9RIzze58tTsaSXTb-cBfsEC197UCbgbBKPQ6DXfCGJTh_0g>
    <xmx:aWAJaZLRbab1W_4JdaSnYhpxeIY1z_RLjJ923ugsGO-uOH2V4B4anF-G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 08/12] apply: revamp the parsing of incomplete lines
Date: Mon,  3 Nov 2025 18:09:24 -0800
Message-ID: <20251104020928.582199-9-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0
In-Reply-To: <20251104020928.582199-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A patch file represents the incomplete line at the end of the file
with two lines, one that is the usual "context" with " " as the
first letter, "added" with "+" as the first letter, or "removed"
with "-" as the first letter that shows the content of the line,
plus an extra "\ No newline at the end of file" line that comes
immediately after it.

Ever since the apply machinery was written, the "git apply"
machinery parses "\ No newline at the end of file" line
independently, without even knowing what line the incomplete-ness
applies to, simply because it does not even remember what the
previous line was.

This poses a problem if we want to check and warn on an incomplete
line.  Revamp the code that parses a fragment, to actually drop the
'\n' at the end of the incoming patch file that terminates a line,
so that check_whitespace() calls made from the code path actually
sees an incomplete as incomplete.

Note that the result of this parsing is not directly used by the
code path that applies the patch.  apply_one_fragment() function
already checks if each of the patch text it handles is followed by a
line that begins with a backslash to drop the newline at the end of
the current line it is looking at.  In a sense, this patch harmonizes
the behaviour of the parsing side to what is already done in the
application side.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c | 70 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 21 deletions(-)

diff --git a/apply.c b/apply.c
index a2ceb3fb40..2b0f8bdab5 100644
--- a/apply.c
+++ b/apply.c
@@ -1670,6 +1670,35 @@ static void check_old_for_crlf(struct patch *patch, const char *line, int len)
 }
 
 
+/*
+ * Just saw a single line in a fragment.  If it is a part of this hunk
+ * that is a context " ", an added "+", or a removed "-" line, it may
+ * be followed by "\\ No newline..." to signal that the last "\n" on
+ * this line needs to be dropped.  Depending on locale settings when
+ * the patch was produced we don't know what this line would exactly
+ * say. The only thing we do know is that it begins with "\ ".
+ * Checking for 12 is just for sanity check; "\ No newline..." would
+ * be at least that long in any l10n.
+ *
+ * Return 0 if the line we saw is not followed by "\ No newline...",
+ * or length of that line.  The caller will use it to skip over the
+ * "\ No newline..." line.
+ */
+static int adjust_incomplete(const char *line, int len,
+			     unsigned long size)
+{
+	int nextlen;
+
+	if (*line != '\n' && *line != ' ' && *line != '+' && *line != '-')
+		return 0;
+	if (size - len < 12 || memcmp(line + len, "\\ ", 2))
+		return 0;
+	nextlen = linelen(line + len, size - len);
+	if (nextlen < 12)
+		return 0;
+	return nextlen;
+}
+
 /*
  * Parse a unified diff. Note that this really needs to parse each
  * fragment separately, since the only way to know the difference
@@ -1684,6 +1713,7 @@ static int parse_fragment(struct apply_state *state,
 {
 	int added, deleted;
 	int len = linelen(line, size), offset;
+	int skip_len = 0;
 	unsigned long oldlines, newlines;
 	unsigned long leading, trailing;
 
@@ -1710,6 +1740,22 @@ static int parse_fragment(struct apply_state *state,
 		len = linelen(line, size);
 		if (!len || line[len-1] != '\n')
 			return -1;
+
+		/*
+		 * For an incomplete line, skip_len counts the bytes
+		 * on "\\ No newline..." marker line that comes next
+		 * to the current line.
+		 *
+		 * Reduce "len" to drop the newline at the end of
+		 * line[], but add one to "skip_len", which will be
+		 * added back to "len" for the next iteration, to
+		 * compensate.
+		 */
+		skip_len = adjust_incomplete(line, len, size);
+		if (skip_len) {
+			len--;
+			skip_len++;
+		}
 		switch (*line) {
 		default:
 			return -1;
@@ -1745,20 +1791,10 @@ static int parse_fragment(struct apply_state *state,
 			newlines--;
 			trailing = 0;
 			break;
-
-		/*
-		 * We allow "\ No newline at end of file". Depending
-		 * on locale settings when the patch was produced we
-		 * don't know what this line looks like. The only
-		 * thing we do know is that it begins with "\ ".
-		 * Checking for 12 is just for sanity check -- any
-		 * l10n of "\ No newline..." is at least that long.
-		 */
-		case '\\':
-			if (len < 12 || memcmp(line, "\\ ", 2))
-				return -1;
-			break;
 		}
+
+		/* eat the "\\ No newline..." as well, if exists */
+		len += skip_len;
 	}
 	if (oldlines || newlines)
 		return -1;
@@ -1768,14 +1804,6 @@ static int parse_fragment(struct apply_state *state,
 	fragment->leading = leading;
 	fragment->trailing = trailing;
 
-	/*
-	 * If a fragment ends with an incomplete line, we failed to include
-	 * it in the above loop because we hit oldlines == newlines == 0
-	 * before seeing it.
-	 */
-	if (12 < size && !memcmp(line, "\\ ", 2))
-		offset += linelen(line, size);
-
 	patch->lines_added += added;
 	patch->lines_deleted += deleted;
 
-- 
2.52.0-rc0

