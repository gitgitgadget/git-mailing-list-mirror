Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9E62F5316
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762984995; cv=none; b=o4IXQn9ftMneyvpzmu6hZb3e/vhwb468Bz/wBCfOqXHTipVoHxCFVsIymN8A/nazYDwG2xuqDt10YsqPDRZ9W/yDbiLZazokTtzfKskOazM2UlJoU9XUhLAG5/SwbSXvqUimS7JGsrngO/ghFMcW5JI2HUvNgldeBcADC878yxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762984995; c=relaxed/simple;
	bh=u+EKJAzaWP9mMFJxS7RAvYQ+y1l1iAXmITEj88XfioI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqZdJi2fQy6Ku2fH+52zVotx9T4jusyBfT8YfLFQv5bmc1Mu/E1pM/jiU6ru/AkCzmYFhTamwjKpS6POS89m5ELnPWscy/Ox9idDiZ6cVK7N4GE2kX1v4zww+Si1QP63mYHufhfM21C6SHK6OkpA8OjGJbME83uDMxtjT/BqViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MTxnfERh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BKI8mtlB; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MTxnfERh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BKI8mtlB"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 8954A1D000D0;
	Wed, 12 Nov 2025 17:03:12 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 12 Nov 2025 17:03:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762984992; x=
	1763071392; bh=w5WQ16YQ1IjSutundxi30zSY74WalbM3vZH/vWl689E=; b=M
	TxnfERhnc2z+OwMFSUo4XFIUEPWtq0+YZ/qGdQVcyzn31k4DiP4fDYrKpqVpjnPB
	YBm7Mcte+GbuY54YQCbssuX//qwOJX2VMXxFN+jtkR/xyyO0NQain0OQmp+zEKKk
	7Ls7T0+Hnbto+3TLXYqlkgox5iX2dy2rpJgADD7YiltsOsTMk5I3h0sL8KJjGJe0
	7WvRvGirfUdKHpK5O2GHKHvecAdHI6wwKt6CFZKvIs2zrWolgcNcKnFDnH0byrrA
	MvnDEqV7bfPWt0wYg6EyhiTYa4V15f5KfwLcQd6Du5115exme0QEPEgXfB69RgJo
	V7G0fTaPe+LLHKm8s4Zuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762984992; x=1763071392; bh=w5WQ16YQ1IjSutundxi30zSY74Wa
	lbM3vZH/vWl689E=; b=BKI8mtlBq0khB2qhUQ8PsQSH+/pWmk0JfJKaOs/DLS3e
	//xqa4QkJ1qF6Rjj2+Q3m9PIdSeGTnMrORnRDxnRz17OEWkfYTikqWf97igoLL+U
	OWS+u/xZZ1Wk2BpEmtCiCGCbrzD0d3kbRaS9S9gkCX2pQuktZXVZZ/cohjXkagfC
	GMR79fyLp9ZejI6CqVL+Z4er/BM/uWxtBJabULo8VR/lDkkhL8EOXoZOiKhwHWpF
	+sjAomql8Or/fii89yLyp4EwQD66QVDB1gjQ8GiMh0bnU+Kko2h4qgabx4uQZxlx
	4jV/noLnPg4YvqwFikiko4vW42UT67j+Mz1dhSd4aQ==
X-ME-Sender: <xms:IAQVaa0CdSdM7XSza0jRZmHM_53-diU20YuOPSsGYVedNPS9x_Yoyw>
    <xme:IAQVaTExSUOQLGuHWKL4wYuTxlaYXCoWylWFeGGhg4_Wis5Q6mmXzc9asjUmQxG6P
    h99_97yrVmuh900DAjSyFurCEhMe10rdMnK1_oRQ9klI8LgcX0Hvw>
X-ME-Received: <xmr:IAQVaQju0HP4bAkbtgrXZsVTBErJHFzAcHEDUQj0G_XNtJBwy6IuE3WKG2JBMAed9QWZ8bDwv-pkOm6lDsiF8gnApgeYFIQjXh1n>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdehvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepheenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:IAQVaW_SCo2tprww4t0tQrNwdRhjtUpEDbAAuZL0DjTRWuTvrQY-pA>
    <xmx:IAQVafrQxfC2M0Wt5uu3KyT29_GMV9u37NcHN70-vrL9efz_f7qBEg>
    <xmx:IAQVad-BCk63pjUHJ11Nai2ftwWrBeC0jR6NkI1RVmSfsQtTW9rqiA>
    <xmx:IAQVabVYUKIVNGZ7lZsSZxlkRVUQZYeW2RFmoXaX98whwPM6ExNRjg>
    <xmx:IAQVaWPrqahVamujoxWG_IaIE7QjZ7gyXbtQrWdtfmawffOULyRtVIqF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Nov 2025 17:03:11 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 07/12] diff: update the way rewrite diff handles incomplete lines
Date: Wed, 12 Nov 2025 14:02:53 -0800
Message-ID: <20251112220258.1009253-8-gitster@pobox.com>
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

The diff_symbol based output framework uses one DIFF_SYMBOL_* enum
value per the kind of output lines of "git diff", which corresponds
to one output line from the xdiff machinery used internally.  Most
notably, DIFF_SYMBOL_PLUS and DIFF_SYMBOL_MINUS that correspond to
"+" and "-" lines are designed to always take a complete line, even
if the output from xdiff machinery may produce "\ No newline at the
end of file" immediately after them.

But this is not true in the rewrite-diff codepath, which completely
bypasses the xdiff machinery.  Since the code path feeds the bytes
directly from the payload to the output routines, the output layer
has to deal with an incomplete line with DIFF_SYMBOL_PLUS and
DIFF_SYMBOL_MINUS, which never would see an incomplete line in the
normal code paths.  This lack of final newline is compensated by an
ugly hack for a fabricated DIFF_SYMBOL_NO_LF_EOF token to inject an
extra newline to the output to simulate output coming from the xdiff
machinery.

Revamp the way the complete-rewrite code path feeds the lines to the
output layer by treating the last line of the pre/post image when it
is an incomplete line specially.

This lets us remove the DIFF_SYMBOL_NO_LF_EOF hack and use the usual
DIFF_SYMBOL_CONTEXT_INCOMPLETE code path, which will later learn how
to handle whitespace errors.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/diff.c b/diff.c
index 44b86544b7..5c606409bb 100644
--- a/diff.c
+++ b/diff.c
@@ -797,7 +797,6 @@ enum diff_symbol {
 	DIFF_SYMBOL_CONTEXT_INCOMPLETE,
 	DIFF_SYMBOL_PLUS,
 	DIFF_SYMBOL_MINUS,
-	DIFF_SYMBOL_NO_LF_EOF,
 	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
@@ -1352,7 +1351,6 @@ static void emit_line_ws_markup(struct diff_options *o,
 static void emit_diff_symbol_from_struct(struct diff_options *o,
 					 struct emitted_diff_symbol *eds)
 {
-	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset, *set, *set_sign, *meta, *fraginfo;
 
 	enum diff_symbol s = eds->s;
@@ -1361,13 +1359,6 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 	unsigned flags = eds->flags;
 
 	switch (s) {
-	case DIFF_SYMBOL_NO_LF_EOF:
-		context = diff_get_color_opt(o, DIFF_CONTEXT);
-		reset = diff_get_color_opt(o, DIFF_RESET);
-		putc('\n', o->file);
-		emit_line_0(o, context, NULL, 0, reset, '\\',
-			    nneof, strlen(nneof));
-		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
 	case DIFF_SYMBOL_SUBMODULE_ERROR:
 	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
@@ -1786,22 +1777,38 @@ static void emit_rewrite_lines(struct emit_callback *ecbdata,
 	const char *endp = NULL;
 
 	while (0 < size) {
-		int len;
+		int len, plen;
+		char *pdata = NULL;
 
 		endp = memchr(data, '\n', size);
-		len = endp ? (endp - data + 1) : size;
+
+		if (endp) {
+			len = endp - data + 1;
+			plen = len;
+		} else {
+			len = size;
+			plen = len + 1;
+			pdata = xmalloc(plen + 2);
+			memcpy(pdata, data, len);
+			pdata[len] = '\n';
+			pdata[len + 1] = '\0';
+		}
 		if (prefix != '+') {
 			ecbdata->lno_in_preimage++;
-			emit_del_line(ecbdata, data, len);
+			emit_del_line(ecbdata, pdata ? pdata : data, plen);
 		} else {
 			ecbdata->lno_in_postimage++;
-			emit_add_line(ecbdata, data, len);
+			emit_add_line(ecbdata, pdata ? pdata : data, plen);
 		}
+		free(pdata);
 		size -= len;
 		data += len;
 	}
-	if (!endp)
-		emit_diff_symbol(ecbdata->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0, 0);
+	if (!endp) {
+		static const char nneof[] = "\\ No newline at end of file\n";
+		ecbdata->last_line_kind = prefix;
+		emit_incomplete_line_marker(ecbdata, nneof, sizeof(nneof) - 1);
+	}
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.52.0-rc2-441-g030905368a

