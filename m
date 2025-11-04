Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2319723D7F4
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762222185; cv=none; b=lD3OxkceV2O3wWVhJFstecnt82CRLrP0ET/t60iXPpSX1j11WnKyWr4TDx5qSvY/+etKE1qMd22q6FsQKqZGsDjbdBBgcBSBWXb21E2xPgeyrsORgIyWY9TB2mbJanYKDZOGjcixdppdp65IoLb2IiyUkhLFg4OOetkY9aE/Hv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762222185; c=relaxed/simple;
	bh=C25e4YbG+43O7wCY9EiIiwdkiYV5Mndu8aQokxvIMto=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oh1WVYk3v7LdIr89KNAq5xkGFZq52cX7k3inh0i1p7SRkVNUdG53UQ1LC+VcD3lGNQABbBcF1D/Ouh9jOBTN1LbdwXpKg7OwP59SkaCiM73ukEBDbF4nhQ8qtNL4tzqhFQAOyCDE7nmV0E5+ZnvoWueLe/ZHVp2I1mdgwoyHgm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kn5pHNtF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bP1bkxDD; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kn5pHNtF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bP1bkxDD"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3AA0D7A03F6;
	Mon,  3 Nov 2025 21:09:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 03 Nov 2025 21:09:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1762222183; x=
	1762308583; bh=RencKmkzEoMYLExNre7EFnKVDU39puE0p/crOhYC0tc=; b=k
	n5pHNtFQwbWT5PAx3BQHg8sqXKIRRXBpVgyqafwpJ7Tlbdlv3VWaFFljILKhnSs2
	LnRqcHr9dj3rsUVaSuWqjNyXcrqI253ZqVg1wbX63P5QwB4o66CAE6N2sfc7cSIJ
	kUs70/IqRzlGB0AfJyYK1rjqkD/mT2vP/LJ9ePN+Iz2qPU6grrLyvWQibauepGa6
	LalI7PdDi8z1ALBtFGIppZCQf1si24vrmOUbsU/MupIefT9LB4uK0sNSS0SjWTLR
	kiYBk6F91iGzKsBSGYmDxo8VJmr2iTncbwpKYrUtEa8COKmMPoX0JitSzBAy0kqG
	JOf3DZUgsXM0UPh1zPtcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1762222183; x=1762308583; bh=RencKmkzEoMYLExNre7EFnKVDU39
	puE0p/crOhYC0tc=; b=bP1bkxDDoDDM2E3vLGCUT9D5YbGW7nYhDLeR7+8pegYW
	3zyIUEcKg/WdpCgov6GlDtCQX3TVEy+ng9yDeVWG72IKPVEST9yQM3gS9uyzERSl
	XgLu985eArNLCK8oXGJtCBtHpFv9LyfE6sIalLcn0LaiASjoR91j9NB/0Lt/zFk2
	ul7WeF/OBltqEK+wEHkkbFIRO5z2i4s52sGM4zNldur1mVlAlSYv3GF66S4Uihxv
	L25oz+WTs/IMi4S5F2wpW5u4swJaVg3ZnA09kUVlYYKPXRk3mV4IH3xHcw10H2bs
	X7P+sW5ZSaq4nzuh4LAiO+EU4GtxhDYhE6yUUdnBew==
X-ME-Sender: <xms:ZmAJacZ3g1yIEQLszGPUWkD9FWAFMSEwBUs5wUnLxoTdTIr6ST82xA>
    <xme:ZmAJadaCsXh6o0qJaxaC8Jnm3B77d2pbHE2DIYW_zI3NuPWIgkNnxecbC5oLc51Tj
    RWEOtipumNampAOIOMwzAV-P1QM8xzffufMKNHVaRa39pYUamJy_2I>
X-ME-Received: <xmr:ZmAJaUnvsUTVcC6chCWe8TS242y3hY_Aw4-NGHoNElioUH2lVsze83rmoOfuf8d-8FqKS1ppB_dzpqY5rIm26fB1yYgR6VBy7q6C>
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
X-ME-Proxy: <xmx:ZmAJaRzB5Ck3xGNK1ZBRPnbCh76EzxGs5mkceLmIGym7mtuKy3K1SA>
    <xmx:ZmAJaaPee5OgOgLpVtjO_DoA6olnp7VKqGSH2fcOKSqikYXe2FwtXQ>
    <xmx:ZmAJadQooEvGS3BsrFEisa6zwGV0ZwLP-ez5MVxMX9rJ21db0olmYg>
    <xmx:ZmAJaQaN5G6BEVKChfgt8Vr4cBDjlP8kCepJk5Dd4PIPsaTYImh39Q>
    <xmx:Z2AJafzgPaidmurYtRbVuOovtqvA7tgAgHgFb-WsslT-E56y-674RCgT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Nov 2025 21:09:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 07/12] diff: update the way rewrite diff handles incomplete lines
Date: Mon,  3 Nov 2025 18:09:23 -0800
Message-ID: <20251104020928.582199-8-gitster@pobox.com>
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
2.52.0-rc0

