Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AE72E0B6D
	for <git@vger.kernel.org>; Wed,  5 Nov 2025 21:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762378269; cv=none; b=tzBLws8pSIvITLu6aA5wlw4ZSNOk72pyKc7GGnK49536c0pUewvMmvXccdU1IOiDiaXbj04O1rDnaLgtdQx6CJwXWSlrQu9LJ62OpBJ8kUS2q/dAo3CHEfkvfnELEaLRd0nL1pddNfIr+n/TeqWC6cCqRWou1f52rGKD353BEFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762378269; c=relaxed/simple;
	bh=xsNSx6qxjWNTLAiMizM7BMMdnUU6IXScVTQTMHb6iI8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KYfSA1phedxeu0Yl4dNTkYWp66ynRYrjYIWZMjRjVrLHxbLYXU5ylNHiN2QfpSIVnBc6mg/sanQlbgScd1F1WaQHw/TgwtdBlKJaEZdpwNlZtLgpWSQ+eEjukyjimxnmavAVg9yl3LVrTMzMKuDGUdDOntJ6yr2YJrdcBnTU32k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Y/dBZ8dA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gr1mXbKw; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y/dBZ8dA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gr1mXbKw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 835D77A0027;
	Wed,  5 Nov 2025 16:31:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 05 Nov 2025 16:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762378266; x=
	1762464666; bh=uqS5eUzK8FuQFWi2WazXyTyET4wYN+tSYDTDbmUm5Oc=; b=Y
	/dBZ8dA8lIKm7k0zFqxj6P7UpNYFhFqqzMTNhoMq/yZHq3HltJJMRRM5qt7/JRqA
	2eMLForxNsHxvmejQ44c/l7LSmUqQVtTZhAPECJO2bH+Eo1ENAc7k9Oici8lEznA
	ie6AusIgWAs8M/3p6FRGhDlb9GszdCupCH+xVK77beK4ghr53vZ9atGa41WCMSIO
	QUMOan8lLwDDn71B8/cKwYuuZ9YN5yJ6TgQdeNxsotdluqixDftnKzSf+2bdCsGM
	q6q4mpDZvuPcGc+NnYqFOUBXet1r+Sy2qx46tsvYdmhZFzcrkJ3e93QI3Qr6mo50
	ENDHhyLdvD/G+QXQwGWKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762378266; x=1762464666; bh=uqS5eUzK8FuQFWi2WazXyTyET4wY
	N+tSYDTDbmUm5Oc=; b=gr1mXbKws2eXA7LadP2EBllIRd8qBDgrzi/jlIPe7Pnj
	kgaazSxylapPWhGUNd7iE3yy6pi71noQBjH++VcjPnscdKmVsJ3eaA6Hm7Xn88qc
	zUcKm+//x49mcpbuh7BhkDPWMK2WnxgNJmOZzxzGxMNoeGm9HSEVKciBpqspS/Ce
	9pP2RI6QhiYQtg06aplaDGa1B3nzj7/p9hD46vcu3jLRd9k6G5+usXCNr8BFCOGl
	Qmbwh675tUo+lu9p0cQgDzJxWXcf1xItmXHzMDNOa2JPRrPSxHkD67M/PZCkAeTc
	zw0kJ2tO4HQtclUinRrCTYM8ASArNUprP4zXYALMKQ==
X-ME-Sender: <xms:GsILaRZP2jx2C2C6_IxKuTaTBA2fV-XrIrjoMyvW1Ed7PhvRVs6mlQ>
    <xme:GsILaeYP3eDhCdVMTxpcfzWSpHSxvtsj9d3rDmRq84DZlwt1ZxI3d2T5i-BKwNc4D
    h2l0rktTD32snWejqde4NKdPEkwdeRY1cNj9LlL9WZO7AD29gbvbQ>
X-ME-Received: <xmr:GsILaRlfuaoi4jt3EK5pu6M9AVLTBnILgpd9r3Os63dkrhy8KhEbUbQRndKJ764Imd3pjI66eoMjZWBi6AGxZ-NAx8q6KOiVXFI_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddukeegleelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepheenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:GsILaaw8RL3jfStp_v5XzZLYWd6iKZ6UlXXcPNxuRCd7K1NYTQoujw>
    <xmx:GsILafPa5uRtlpE0tCQaggN9Yt32Z1I-wNKtUthKCGVFJbiQKGUH2A>
    <xmx:GsILaeR2nQ6Oa8QK9WcsZuWftKCgFuzGaP9byzijq7LsX2Orc9z5dA>
    <xmx:GsILadYpod-1aLgicxhP-QIMBjBj9tj-wWrv-O2F1vF8hJaSqGMK8g>
    <xmx:GsILaUyg4vEylaUm1qU8t2oRBwCH-Mn1LpsnxJd-mGH391vEW8WsJT_H>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 5 Nov 2025 16:31:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 07/12] diff: update the way rewrite diff handles incomplete lines
Date: Wed,  5 Nov 2025 13:30:47 -0800
Message-ID: <20251105213052.1499224-8-gitster@pobox.com>
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
 diff.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 347cd9c6e9..99298720f4 100644
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
@@ -1786,22 +1777,36 @@ static void emit_rewrite_lines(struct emit_callback *ecbdata,
 	const char *endp = NULL;
 
 	while (0 < size) {
-		int len;
+		int len, plen;
+		char *pdata = NULL;
 
 		endp = memchr(data, '\n', size);
 		len = endp ? (endp - data + 1) : size;
+		plen = len;
+
+		if (!endp) {
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
+		emit_incomplete_line(ecbdata, nneof, sizeof(nneof) - 1);
+	}
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.52.0-rc0-105-gc08128fbb6

