Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295D62BD11
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819513; cv=none; b=kX+UEGEoXXrX2HzAZelcQnyxZgMQ2kNkSha6M8O/kLZRNT+IFGDLZ0u7V+CAJpkHR6pzwG1FXN8QDhegNdiLC/xoDl8gYdybUNFqir8/nfIYEcwaDl2jQRLgRIPq9xG2B7GSSUUY22l+xv+v6PF8QeWg+HawteHap6ga0OsxVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819513; c=relaxed/simple;
	bh=RQIQxXQo+R/pP8QJybUaecB1QutVPFlJfHaxm2VI6Wg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozJt9ixU5p4grSMtF3YZYSi1lVwx+qOXPMlgIujxFxrHeZ1T6B2CKwMg025wPIBhppp5gzr71SrV0xpAnn5r/pVvCrwCptddAziRj++wQpHfGyIbFm4TDpTbb3MWDSY2OgC+yNFQ4xegqWJBMNziE98k0iF6kc24CzZ/5rJqRvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hB8TR1RF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a+xG5X7S; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hB8TR1RF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a+xG5X7S"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9C0351D00195;
	Mon, 10 Nov 2025 19:05:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 19:05:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819508; x=
	1762905908; bh=M/kmjt5C+d0lzJKSmoX5XzRP189/PqQqgVCK5ejXN6U=; b=h
	B8TR1RFP50xlZnIHp69mLGbKFv8Okfu/G2UX/skqczXHF9r8zOZIDIL4MWc1DrEx
	+3DOd3H8CXapgn+zm7hDqTFiU8HzVyirCDHGMh51WnaxD6oAZ+dZmeoFrDabDIvn
	6vPYOaPTkwK4c55i0sEMwf1agNZeDagfc+DVLhWh7cv4pAMCPXGRu2yIWR9eNADD
	K3yrCX5ZjY2I6SOxdPd9VWJkx8CLBBrc2Uy+DaAfOj0zs2T7x5EvKYkt69HZDwwk
	mtwrtk9AWzupcDE7KiNsO1SVpkpdr5KAs7D2bHL+c9yITckQlcOkJ5TOfMmu9MPy
	TcpKztPi7q6V9q2ApDWJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819508; x=1762905908; bh=M/kmjt5C+d0lzJKSmoX5XzRP189/
	PqQqgVCK5ejXN6U=; b=a+xG5X7SCFums0Av+HBiBGQb2IEJstdWLa5Py/QlHvOT
	+kDX7f6nUxFzCyJMTMXbjdqbKH0js4n5tbUXCz61Kr0sfd0mfc0wcugzX7Ow1rG2
	iHlsB2YexWakexX6DF7EEQIbPWz7Qt8ZrhuW5L/USysiOR9rjzkigta+VU6yDi1c
	/O5UCxhH6IEOxZOi+w/UYeGVrA7mQnxgwA0uAYE7Y1Y6ERJR1gCIL4V+XdaSGiqr
	tQGh3McP2As+Nv2MI9Bwv6Me5C9T2UUaXlnNfnu1pModCSQ1gD8k9492qc5iigfJ
	4Ma1dxFa0eM1suassC/YVJgFQu8Fp8nELmTInKzpCQ==
X-ME-Sender: <xms:tH0Sabp-Bg7eOJ7caqqqxr3-JZG96t-TK2zyIpdcOxj_hdv4r9Vw_w>
    <xme:tH0SabqwqsY7tpD2_AwTXcsB_HM4P4JKoluM51LN5qd9IPfB73r6p_jo8liqHoC_h
    aMl_zv6QE4GaPqdruRrAvv2_2r-Buex47sVNSaNOpZJc2B_jl6M>
X-ME-Received: <xmr:tH0SaV1RNV1TYB7g45b6oUdvyR5mk5UjkXfZJ7VaYra6t4JbrJjrHk1LaLB_ZDWZvgwR310iuhQaKkU2kx9g0vcc5UjMU8AXvADm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepheenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:tH0SaaB7Y2b9DiLUkroHUNx1RnzscczsqDy0kZuCLX3engZPirISgQ>
    <xmx:tH0Sadfgs5o8455jEuVYSKsZV_E6UP8tyajqR_BI-kjC_xeBGaRRfA>
    <xmx:tH0SafjQY9BlQ5BuUj9n98kGm7Qpy2ITr-bfl1GLFZDygLlHqdfTOA>
    <xmx:tH0SaVp8c_gLOgqINaNHygNj2ArH3rir_ffAGySk7DJtUgfb2YPu8w>
    <xmx:tH0SafBxs0-cWO0QKtnlhtIM9c8GPhzsGjtQ8r_MJQgU0foZ9sJo1518>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:05:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 08/12] apply: revamp the parsing of incomplete lines
Date: Mon, 10 Nov 2025 16:04:47 -0800
Message-ID: <20251111000451.2243195-9-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc1-455-g30608eb744
In-Reply-To: <20251111000451.2243195-1-gitster@pobox.com>
References: <20251105213052.1499224-1-gitster@pobox.com>
 <20251111000451.2243195-1-gitster@pobox.com>
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
2.52.0-rc1-455-g30608eb744

