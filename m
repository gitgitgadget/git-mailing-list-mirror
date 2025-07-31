Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F47A2BD000
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 07:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753947730; cv=none; b=laQhtilxfY5XoweMGr077xi7Y6CgHt2PS5MqemKu2ckrEr5nOUfwz0rj/xnv2ApEU9zwAl5ddHX/8fZcNXmzBjr+eYR/eFudPMTuI4BZBO5LaFvcAzxivE1pPamp2oYqfS0jhViRomKeJsWSCoYHbEd124BEBxjQtW9BlfaiLh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753947730; c=relaxed/simple;
	bh=f/MUIrtTKQeoYXcCq0XM/cIRz3dtTsfYQCl9nuvoiME=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c0gyeGFdZGITz3yh6fLQ7WJjIqdPqoZ/PTwqhY7maQCQGEDajhDvDFQa5Zw6fNnNORLsp7+vOQYxUgZ870fhUNWgGSkJMp30WfwdvtwsC5DH13SrVkUnPrewy6lZWXwAkvzpeIgtWQQ0I2Xdp62N6zdyoEBFVUESZT/DxRw4RhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=UAm2qZxW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lGcV64RG; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="UAm2qZxW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lGcV64RG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 719317A0095;
	Thu, 31 Jul 2025 03:42:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 31 Jul 2025 03:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753947728; x=
	1754034128; bh=yxPR2H6hCKVFQApPYKEhJAbmYOChwio2PMj0bT33nEM=; b=U
	Am2qZxWv87DN/EkplZnkZNJ1ZCuSqRK/JGKWtzl07W1Kz7rCKcexvdCzSi3wRxK/
	UJ00nB1Ba6XfU88zJ0qD6gQzg07VXvfme0QFiXX6WAtlCHv2wf/uxdIQbYURv46c
	ZiIlBbez8xvuKMiLG5+5CIDNR940yfHl5HeXtlf7NlabfUAhyiABWXOWR3fH9eOq
	Pds+GBRmQ7DJC+4si57QwzEIiGP9rBuBi9waYMrcMnJhHB85rJa7xY7ROIAcF0oh
	iuTTV/H+94iCnvrmYKRp3Z0dM/y+dQpnLh6YWphT/y0iIPF0n7lYKcUKVG2YBLFU
	66yieWvGV+BOrf+iAurAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753947728; x=1754034128; bh=yxPR2H6hCKVFQApPYKEhJAbmYOCh
	wio2PMj0bT33nEM=; b=lGcV64RG0p7ckoQ+L3znBf2zH4pJok+wfFfOAYOKuTUo
	uVBJ6Geo0meJglOqEB/XEj/7VVkcy7wRAngXy0myeATaVHRdiAhlvrMINv/MLHC5
	o3HMzRE5b3jBAtr5aGdDK6+rVkz/XTF3YDWRWd3L5rNTztfUFgZid+LtUBZdb0l9
	+m4x1sLa0iP6QIhBSCMZSYhl+z55Nl67sgH2CAtVpGQaFserTpoRE8FIQyL1kaVa
	R+e8lgMlXJ51FrrB2NSBmlUtFQfs5E3Z/9AyKNQFyEpmZV+23E5hiIquSeK8Ja9p
	73aMH/Kz4Eg4Qllr5ZZFPX3I9LA+kiYMo/Qb8JgtkA==
X-ME-Sender: <xms:UB6LaJHI2Kko0zJZzWxA6PA5MzamZuyzTfaj_GGo9NVzwaNifzTk6w>
    <xme:UB6LaOihdO0Lc0e5Zg5wt3jfobna_XvL7h5FF8s5geRwtxX4OCLlj6xKH7GAkfrxk
    BOPe-d-ok9gEqwAbQ>
X-ME-Received: <xmr:UB6LaM-o2X32vuI2eDutbiKRjYnYyBLUvz3yq1krR0h7BnuRR0M5e-oXsyY9BvzVPr-g9LV9aq9j47_8YGC8DVI52ZlgWS65-7_eVKI>
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
X-ME-Proxy: <xmx:UB6LaNpX8S3edwiPgZv9pBJNTT1D9A6GA23FQaxBU-9sxaLUwiwwFQ>
    <xmx:UB6LaD8vQAtjIJBD4o6kMyLxwUOEC2UsZ-IWe1KCJX_Y8bl1VUj6aA>
    <xmx:UB6LaJVqb4CMcsVIqlgk2RoCOYRIY5Tc3KmBaCe4IL0QJfNKvkjo7A>
    <xmx:UB6LaBA3YPJslVdEhtKzJ4Xy_GFU69uH62caCQBdz5vLHf-NjHiqcw>
    <xmx:UB6LaLpg1quv_f1owZSy6KN1symNFdhAwrRhAzzFCkz7QWMF7JjMkPcf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 03:42:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 7/9] config: do not use strbuf_split()
Date: Thu, 31 Jul 2025 00:41:52 -0700
Message-ID: <20250731074154.2835370-8-gitster@pobox.com>
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

When parsing an old-style GIT_CONFIG_PARAMETERS environment
variable, the code parses the key=value pair by spliting them at '='
into an array of strbuf's.  As strbuf_split() leafes the delimiter
at the end of the split piece, the code has to manually trim it.

If we split with string_list_split(), that becomes unnecessary.
Retire the use of strbuf_split().

Note that the max parameter of string_list_split() is of
an ergonomically iffy design---it specifies the maximum number of
times the function is allowed to split, which means that in order to
split a text into up to 2 pieces, you have to pass 1, not 2.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/config.c b/config.c
index 8a2d0b7916..1769f15ee3 100644
--- a/config.c
+++ b/config.c
@@ -638,31 +638,28 @@ int git_config_parse_parameter(const char *text,
 			       config_fn_t fn, void *data)
 {
 	const char *value;
-	struct strbuf **pair;
+	struct string_list pair = STRING_LIST_INIT_DUP;
 	int ret;
 	struct key_value_info kvi = KVI_INIT;
 
 	kvi_from_param(&kvi);
 
-	pair = strbuf_split_str(text, '=', 2);
-	if (!pair[0])
+	string_list_split(&pair, text, "=", 1);
+	if (!pair.nr)
 		return error(_("bogus config parameter: %s"), text);
 
-	if (pair[0]->len && pair[0]->buf[pair[0]->len - 1] == '=') {
-		strbuf_setlen(pair[0], pair[0]->len - 1);
-		value = pair[1] ? pair[1]->buf : "";
-	} else {
+	if (pair.nr == 1)
 		value = NULL;
-	}
+	else
+		value = pair.items[1].string;
 
-	strbuf_trim(pair[0]);
-	if (!pair[0]->len) {
-		strbuf_list_free(pair);
+	if (!*pair.items[0].string) {
+		string_list_clear(&pair, 0);
 		return error(_("bogus config parameter: %s"), text);
 	}
 
-	ret = config_parse_pair(pair[0]->buf, value, &kvi, fn, data);
-	strbuf_list_free(pair);
+	ret = config_parse_pair(pair.items[0].string, value, &kvi, fn, data);
+	string_list_clear(&pair, 0);
 	return ret;
 }
 
-- 
2.50.1-612-g4756c59422

