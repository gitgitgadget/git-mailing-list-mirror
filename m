Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B58219E8
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762819510; cv=none; b=kAvmrjJHszz633OI+cR/qOLTULGo/FHZ8KfIvafX9UwxcCijE8RkZleGTYFsB+rjcTfXsw+JKbRMlZxzgVeEBJb2fubVZGxrJpowZq7iZXBbSPfMLP5FtULZO6Fv8MNPSna07/LGeXeaFPwwzH8qOsLLP2XKw+UmbvJmCNXhNx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762819510; c=relaxed/simple;
	bh=2FqA/PTxd9Cftvc/IOgCqhUYLc/mHqQ0qLHJ6/y44s8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Vxlww+fYsG5IWCVcvW1KIvr+FzIzYJ/carBPlzKiImSIGLZ2BIIkCBI/v92BkBFqABRHKjTxaIfmwBqQFqH8UWHk9E/CdnI+y4VM4P6Ct72qkK2E/bdxPwsLBoT8LmXBBJ7uAotHhEwRz98Ba0gaz41/uBx5XSJ/Y2pkkA5JRGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=btmnsVVv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PxnUOhxY; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="btmnsVVv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PxnUOhxY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E016D7A019B;
	Mon, 10 Nov 2025 19:05:06 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Mon, 10 Nov 2025 19:05:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762819506; x=
	1762905906; bh=qDkYBk16jQOdQH9eqwIAoipmaItTMaAQ1AALkxusntw=; b=b
	tmnsVVvaWWmDoORgib4Rs4GsS9aMLGV2QfblAlaFOvIyBOBRuhhk4m8VAUxeRvZO
	5Zm9Di2jAa/0DvSB1vchh2QV8vypynVPpfFmVdrKuyxxDQ6gZLJou/lBq+iqq2At
	k7g85lLI9otWskXbhrYs/5YlA6bnlWcfkECrLb3++xS4GhLXKm2h6X0DZo2Dz3AI
	M5VIXCL6FzmBFpZawYYWhT/gKuT/ukHLmmPAtH5YJBWRi5I6EbOZOKFqnwu658XS
	i1OaimK5oQXONadggJlfiSuorNZlrMCpAn5i0dWyf7WaOzPqur5po6cg9Ox+EMdA
	niWSq9HML2Iw3jrzZADXg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762819506; x=1762905906; bh=qDkYBk16jQOdQH9eqwIAoipmaItT
	MaAQ1AALkxusntw=; b=PxnUOhxYsLcbQw7jXFmDgfVYNUItSsto7i/4gD9y0Ahd
	JTn7jpW92k9AmheyJ+rT8pD7khKBJW7mpZM1Cpo0jsIzQG6RCCMGz8JSeXAjWE9Z
	Hw1sWl8LFhav0HpJOVl79uofVNQKdYZjPP+MOZApnYu/+PQ9sV8HacoSpmnqCiV4
	yAIdmSvIm1tRZsqBraVL590eeQnvLhNtPZSWs1Q/bSTQahvKllS6dfcVjrFaratJ
	bt44C0ltBFvvzA/AwByfAZ65oJ+D1+zmvelR4sh/m5ro26U5A2kDzgaqflknbh6C
	rla7auONcwdX1sxglZF87b1nfBVfzffqs28Rt6lbgA==
X-ME-Sender: <xms:sn0Saf_dVysXMef0nfJeaVp46LftSVH4kdkqpqsSRWzw_5eRCUvkgw>
    <xme:sn0SaRs_hAcFCaFPsM0ow8uE5zO_54teA9XQGaHIi9pFiVDSLj66lHclL7AOQG56k
    Ye8_xo6-xvvsIO8An-706XHx0yej_MHWaVJZMTuEvvzVDHMDw8xog>
X-ME-Received: <xmr:sn0SaaoWLs8xQo9vTsVp85omorRr_lfwvDJwATdYbfe2TkwwkeZWMdCQGlRZr_qmtzFp17HedwltbGsDELQBH6W-nhBJgc3AqNUG>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduleeljedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepvdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:sn0SaWmrjhdJjWFo_Xmfx6h6lYA73tFxpPRVhr0jKysfYj68M3684w>
    <xmx:sn0SaWzPUTI76hMNA80EESIUU51uLQWNfPkcemR1JTmPc4eVV-zwUQ>
    <xmx:sn0SaWlEWGqRW3_6EOg7HNafSKi9GvJu7UwdoasMHjO2lmwhsTUw7Q>
    <xmx:sn0SaXcpbI-7jsS1CwZOwkR6sop9ghbFVBqNRhtKRMXgVVLpijdicQ>
    <xmx:sn0SabXXBhYfo39-6zgN_RuQ-7WtTpxMG91C3Y2dSHrUYBO_0glQ6ZSN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Nov 2025 19:05:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 07/12] diff: update the way rewrite diff handles incomplete lines
Date: Mon, 10 Nov 2025 16:04:46 -0800
Message-ID: <20251111000451.2243195-8-gitster@pobox.com>
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
index 67071136a4..c3fb3015d6 100644
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
2.52.0-rc1-455-g30608eb744

