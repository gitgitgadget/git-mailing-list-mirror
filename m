Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F402EA490
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984998; cv=none; b=Rbm5nPOIkfp8HEr65J/wSWIQVsjZLWLv0BiVnDGM4Cq/a5n1SWvDwsuU5KP1vdMo8kO31XFpr7yXx0mSpbOwjTUkk8zeE8iN4Y99SUAlns6sBB2QXPme/stx/U0TnQc/fc3O9gmY/plhPIlWXZzD7InWcAQUQXViNVdRCE5NxcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984998; c=relaxed/simple;
	bh=fecOGFWPpApUiF48QJ8bKjI3MGmf7gKT5mIXENlipBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQ4WhgDl7+SsCz5wkKAWYbbWxEZf680PxBhEAwOoeFsNZnOKGUfzNohdcC1upYfXSRQGMsTMUTNntznrlBUkdCp6oyUss0PZAEpYXKAYe2/TlDHEs0aQssL0O4sBpb1KX8V9l1XvhiVhdixHqOkTBB2Gda9fZtuwhZ37LLKn2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kJVVz0op; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j99ap0ZF; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kJVVz0op";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j99ap0ZF"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 4B9511D000F0;
	Wed, 12 Nov 2025 17:03:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Wed, 12 Nov 2025 17:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984994; x=
	1763071394; bh=fWEgDg3PL0WtNCdzEfk/dwP1xQmjt7s0nojHj2+klco=; b=k
	JVVz0opUke6Qzi3CmWOtjN88LogVChrSOzJhen2YeOLqH3tbT4cMIv51+zgykL6F
	ZnGIhJvHSa940prpA3RAVamvkPgps+OS85VGlWKm0JzqwB8SHZd+U5Y0qYmFNhrd
	F67P0FCBwCcr1Fq7fJ9/ovzDdno3AFynUet4EaOXamID985Q26crj0NuFutktLL6
	jcoPJq2iQV2PJRutgBdYWmvFmwnIul/+/89wuwzDfcU11SBRE/hcrs4hAVauN+yF
	q8dC0N27kpU7O+p5BzayqZqLhwNW2zj5hafv9c9aQQ/m6izfqNpGqneEX1pzk5r/
	A7LA+ab39eXShuCzfhTUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984994; x=1763071394; bh=fWEgDg3PL0WtNCdzEfk/dwP1xQmj
	t7s0nojHj2+klco=; b=j99ap0ZFcyf4RUglJBN4GIZtJ174O4BtetxIETksjHN2
	fRbsMrXQQhvtdPVJfdhFEQQScUsHCR6MxcnUlHBVvd5yPOg4oXf7juS+zmlvAfY8
	tyqPe7WmhOA3CA7+xFMSNCFvVJg7R4ihUQH2ATzYQRzBVtJ671u61+COuHSlfAO1
	eH12yTcsNVmgNlLECMqYSGhPXqxpBjfjGtGyd+/8azKRxSzCS2quUec+SSCk0hD+
	weiXdoDObug1myF8OMcK6clKu43/ahlcL0QWD1zSHSElyQKXKZRwPYlUyoexw48Z
	njoOJ8z5tKK4/vevEo/8wit1soRl2/6fBX35CLZmdw==
X-ME-Sender: <xms:IQQVaUHDVwuStSHd-5gfPH9JHy_ZmsWAfbeh8_BhBS_G9Oi6weUSlA>
    <xme:IQQVaTUoSuSWTaEU2-JYOFjvWrVdB9Xv7Jbrp2sV1ecOvh5Sh2r2z3ybetR6s545r
    77V2Q592gwp4k_VNsKNNpUcXF4Jcr3oPdY8jNBGtfqNaznwUd4OAaU>
X-ME-Received: <xmr:IQQVabyy1w6LyqKJeU9LAc3KN9wj9UXFFx_pE6ojX-DngfjUUfFKdwrS86PqdAApDVgBQTkPuNeBNvHvh-v8c02FqxuhgEFi3suB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepfeenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:IQQVaRNLlhEHgTmWvwHdgs3H3PviHViAU-oDvjrNQYPzhinBnrkPnw>
    <xmx:IQQVac6Gux0uFb0xRTBcpg025nj89llFJuRfRrg7E1VIQrYAKnlhqg>
    <xmx:IQQVaSNldasR-_AZnsp5YXCjtSgkWghLxkjPxBUQ13xKE-CZkqD9Ig>
    <xmx:IQQVaak0suvqxDT5dZvGQVMLWIAasYzQZVjFAni3Edw914e0YlZ5gg>
    <xmx:IgQVafeF_EWFVtW_Q5dv4EpwQPPUcoFiacMSOjoLFm26xDP7r03yPEL->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:13 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 08/12] apply: revamp the parsing of incomplete lines
Date: Wed, 12 Nov 2025 14:02:54 -0800
Message-ID: <20251112220258.1009253-9-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc2-441-g030905368a
In-Reply-To: <20251112220258.1009253-1-gitster@pobox.com>
References: <20251111000451.2243195-1-gitster@pobox.com>
 <20251112220258.1009253-1-gitster@pobox.com>
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
2.52.0-rc2-441-g030905368a

