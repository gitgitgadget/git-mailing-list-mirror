Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD242DBF7C
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378270; cv=none; b=NFKpEFeAakxPpRhfEdOuRbbvgTrRXEsHlUwcj3COtvx3hKV+MyYsMXv+51FAc3agQ1+TSf64fRO06+B5njfj9xs9QRK9+qB718LulGplQ7TNyQXR/KVSY5bm5WMv1mAgSUf48jfoGmVnH9u24E61D2Fm9mEewLzsSSruCxCDw9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378270; c=relaxed/simple;
	bh=4H3y886KldybSIzjsY5O//v8cohrdDbziGDHZyzbzXc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvZIU+a1E953iEGGBy4dSAcdWo/932MDSE2wia2k2xexvNhIW51h4Y4Zv3kVWI0FnuwOisWDZBgbzVBBJtX+iAXtzAdgxxNHy9nGFEmmVsqnRwApSwRYHMSa54AzE2jn7WOHf5yvfdNNMgAPfEs249Oa6CiVrc9AuxpfngdVf1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nY/6RJlh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HWwy8dBu; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nY/6RJlh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HWwy8dBu"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4A0D97A00FE;
	Wed,  5 Nov 2025 16:31:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Wed, 05 Nov 2025 16:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378268; x=
	1762464668; bh=tR40HwRqBULuB8yti2DjazrplCZb3rzpSxKq/lMHOMI=; b=n
	Y/6RJlhgAtlkyYraU6r6tAkL1tgv6Cygk7tyniSI9sgmzt+aPPlcfly7aOtdpP16
	tsK/OjlO+Fi2phoM27TQvVBz3ojF8D4zNJpRMpfcz2Ifm3KBq7jaKdv+Y2OGZSMH
	KknetKykkMQ/pPXEAp0KowtI3h4GQluHeAitqe5O1/MRSZ2AZti1xiRDOJZNOKaT
	oez6ZQN7m4PKOSLC9SLvTxNPAfJimk4UzWIMAPpKj+TeNbGyOqMTQNfRlsGIbCuT
	25MFCGkyxfzKK7sr+I7CWHSuXdT49t5kDGx/pvNNN36fclwDkpElQArAqJa0UIb6
	4uRnR7XUd5S2RFFsRbXfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378268; x=1762464668; bh=tR40HwRqBULuB8yti2DjazrplCZb
	3rzpSxKq/lMHOMI=; b=HWwy8dBuc2bF2Jdwn0kyEM9SipWcdIsnYRxpGNup5U/F
	gIUfGiuT/dwaLNKfRvFVE2X3p3kF5mXEUErY4EngqjGDRPcNFzK1ZPQwo1wOnX3w
	79nAivrjxf6dH45gBqgfyqTnCEYrCkOf1BPdzMeDfpb1nRiSrGNvfx1W3+/BF3TA
	SdbrZhqbbNS/OT7vLMSZ3xI3AyhO2jAFtxVcrMhOLmdpg4IoR63TZlFDSZKPCpmk
	GIyiTlivxewW+IRBtMZgR/+3S9aTh2gGds9Jo57p19U+Jg6nIuqr8mF8UbCX3XWE
	d2EONorQDqrCChh5YH16Q/BRcvlzI7KMpLggonZmOw==
X-ME-Sender: <xms:G8ILaStBKw5Lht59mSHlJbmjLKMwb24fBNLJxf-Gw9v6cb30diRFfg>
    <xme:G8ILadcALxv5Z4qDs-xAVUrH4MacufeyFseUDu7zN83OCtnTvUwF0bZzBOKkM4qTB
    Wgwyemz2pkCEYXlmV4dELCDDdiJ-Ik7EvICYmD2Izck0YVjPbnXHg>
X-ME-Received: <xmr:G8ILabZ7QTq3uf6s0KuxxyMkiWC46C2gz_ypwxDT3zD56MnoK_pqKUQCEUIIzzDvo8BlXouCNj9tmNuWCz6pwUaCpRdlgGKIMgVW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:G8ILaYV5qapbSA86rPKRbC5n31x3aEbcrqcixZxz7lrH3QgpLlWjBA>
    <xmx:G8ILaVi5uDNCQDwHmcuZFCyRMDxC7Sbk8z63YCA4vRh5kXiOGgDmaA>
    <xmx:G8ILaeXl48ZeYiFPBCaB4OoRbr4_5IjLSl_9Ax8JDPmp_hhFxajmSw>
    <xmx:G8ILaUNTRdC-22ykkvnUy1tDeSy_AZk3RQNQpx5Sag2SU-dSApICTQ>
    <xmx:HMILaeFAB257raiY2VhRk05GiVku9ihHbTO88VzyIO0-4uoU3KYpCXWu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 08/12] apply: revamp the parsing of incomplete lines
Date: Wed,  5 Nov 2025 13:30:48 -0800
Message-ID: <20251105213052.1499224-9-gitster@pobox.com>
X-Mailer: git-send-email 2.52.0-rc0-105-gc08128fbb6
In-Reply-To: <20251105213052.1499224-1-gitster@pobox.com>
References: <20251104020928.582199-1-gitster@pobox.com>
 <20251105213052.1499224-1-gitster@pobox.com>
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
2.52.0-rc0-105-gc08128fbb6

