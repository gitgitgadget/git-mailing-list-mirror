Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1104F2BCF4C
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947727; cv=none; b=VwKMHnLaAw7lRGjVFBdVFPr7HhKoX4jmZToiOSm8GbNYUnZ97n1mOUmDJFRYi8e0AjeM18BBRSEx1O/xpc5qzVYFNjVlJH9xYD8TKcSlLIymMzTJthybRgyH1MXBpHO8zTDwcDuRnjgVU1uwUYPR5L7+7UY2RZ0k1qcRhtyOuRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947727; c=relaxed/simple;
	bh=JtUWvlksms5IH99Wxup1qfX6J8Xb8ST1c2QxHoVDqe4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCRVhrc45BZ9vI35KMPjc+RwUcXUjkXG65HiyL3wsuQ3elq2x9/HUvQyspMx0vu4qxtMwnPniEUC9Qj5LgekkhQ4htYpMS9XyzFwRg/zLE/DBO+BTzSeAAz1LQwcn1jlCN9AZBH1f2immEkHuPruoukiEQuIX8LrIPAxy6aQaoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JLeXhGLX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DeWu5+X5; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JLeXhGLX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DeWu5+X5"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 268D17A0095;
	Thu, 31 Jul 2025 03:42:05 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 31 Jul 2025 03:42:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753947725; x=
	1754034125; bh=gpE8qU97gLknwI5TMdfE4QqtwATsmR+GIpVvBC4u7CY=; b=J
	LeXhGLX+dR2uKRbXfW++OEjcGBR2UUNBh3p3OlLmMBiAg1P6ZLM0b69NLEDtgOvR
	UA+s/rkdcl0uJouaoCF13dp1k79AuXGxcDQkAfmF3PhM3Ga6OLc+2YIcqagmahlC
	EW4Oidu4TiFkW2KqfNY9xEYBTa0D6tCFAm4f9pycZBleAKO4ralsiSEKDf5Rqnwf
	/ueBH2twpCJjbXdMBJQ+nYgD19K5omlCBGaJzqrs6/ZtIhQMGWVWu5b/fy17Hq8q
	ZDyLgZ2L5BPlv0efVJCT9DZ0VJmAZMPH1UhC01LwVdj40lyFXJFnJUsbCWPG8uMX
	784qgMTDkiB7Bbc4ZcI8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753947725; x=1754034125; bh=gpE8qU97gLknwI5TMdfE4QqtwATs
	mR+GIpVvBC4u7CY=; b=DeWu5+X5L8Hq7Gtj24YLo27p1OcPbi278lFdtDtcstsb
	FnYw8nvDqA4mLNfSpYBfFhavb28080XKUlH4sdM8jJQF1gjyRm+2vLj3moBN9UPX
	v6udcVJz5FWrTROC04lX9zBz+4wjnUhrCP/wT196820u0OjzK9YE/gTs98fjPFsT
	tQW+qcY/KBcS9l4HZZFFnec201isx655scL/bCNidcNyqhe119RK4cM3XakW5eBA
	roTECjk+9exlEx/wrbpmtU4cSD+R9XT0E1RL9nmdSGM63JB0wJd8reoFODmjLpfl
	baR07LVNt7b8jBbI6XU228vpv/ESBS3fer9WuAIHNw==
X-ME-Sender: <xms:TB6LaOPy8TmwGPDFZf1_KMos8OtSC0l4MWgSqc7Mb4Ar4TWu0oR8Qw>
    <xme:TB6LaNJSyQO1wTJphN4N3R-An_K3vuoNrX5dfKfVx6A0_DaFfVdz5OsTiyqfkNiCh
    4daY17yLaw0NjVDrg>
X-ME-Received: <xmr:TB6LaHE4kxrBcaKprfcPzCGKey7KlHHm3LnJD7_ZlPWCLhfBtsuNAOnLNxvWmCUQDMpRrgWqb6MjJ3m5JMTbJeNrttN_Ejh9t0BhEjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:TB6LaNQLV4UuV5Olg07xFDqwbI5O-iC4TdwhiOb59g6ROI1r5wZVdQ>
    <xmx:TB6LaLFsuFdUszQNN9uHDrhu1bbfi-Qx9R2XJrLqZqKkkkK_yW9GqQ>
    <xmx:TB6LaB8A7pfs9rh8xKkJNXKVgA8sUgO32mOnLYL3ZcMcQVQP_G38yg>
    <xmx:TB6LaNLe1zRvmLopB-uAsp8IRKuUVUlVuTE02DFz2AmZvIN8IOFIlA>
    <xmx:TB6LaAwcvSErNHDan5IYK2ij-KxlcHXiuNcuXke2AYaI4NtW2sd3AGPd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:42:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 5/9] merge-tree: do not use strbuf_split*()
Date: Thu, 31 Jul 2025 00:41:50 -0700
Message-ID: <20250731074154.2835370-6-gitster@pobox.com>
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

When reading merge instructions from the standard input, the program
reads from the standard input, splits the line into tokens at
whitespace, and trims each of them before using.  We no longer need
to use strbuf just for trimming, as string_list_split*() family can
trim while splitting a string.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/merge-tree.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index cf8b06cadc..70235856d7 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -618,32 +618,34 @@ int cmd_merge_tree(int argc,
 			    "--merge-base", "--stdin");
 		line_termination = '\0';
 		while (strbuf_getline_lf(&buf, stdin) != EOF) {
-			struct strbuf **split;
+			struct string_list split = STRING_LIST_INIT_NODUP;
 			const char *input_merge_base = NULL;
 
-			split = strbuf_split(&buf, ' ');
-			if (!split[0] || !split[1])
+			string_list_split_in_place_f(&split, buf.buf, " ", -1,
+						     STRING_LIST_SPLIT_TRIM);
+
+			if (split.nr < 2)
 				die(_("malformed input line: '%s'."), buf.buf);
-			strbuf_rtrim(split[0]);
-			strbuf_rtrim(split[1]);
 
 			/* parse the merge-base */
-			if (!strcmp(split[1]->buf, "--")) {
-				input_merge_base = split[0]->buf;
+			if (!strcmp(split.items[1].string, "--")) {
+				input_merge_base = split.items[0].string;
 			}
 
-			if (input_merge_base && split[2] && split[3] && !split[4]) {
-				strbuf_rtrim(split[2]);
-				strbuf_rtrim(split[3]);
-				real_merge(&o, input_merge_base, split[2]->buf, split[3]->buf, prefix);
-			} else if (!input_merge_base && !split[2]) {
-				real_merge(&o, NULL, split[0]->buf, split[1]->buf, prefix);
+			if (input_merge_base && split.nr == 4) {
+				real_merge(&o, input_merge_base,
+					   split.items[2].string, split.items[3].string,
+					   prefix);
+			} else if (!input_merge_base && split.nr == 2) {
+				real_merge(&o, NULL,
+					   split.items[0].string, split.items[1].string,
+					   prefix);
 			} else {
 				die(_("malformed input line: '%s'."), buf.buf);
 			}
 			maybe_flush_or_die(stdout, "stdout");
 
-			strbuf_list_free(split);
+			string_list_clear(&split, 0);
 		}
 		strbuf_release(&buf);
 
-- 
2.50.1-612-g4756c59422

