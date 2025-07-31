Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60E8C27FD4A
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002488; cv=none; b=hTbgCpN8KsmxQgVlL+bBo7Dznb0nOxxmxmnNXNQDY0vO1uNSeAnIrYYe07fxIj21usIsZvNZXoeVYpRyQQp8gaQ40zjUlcEIpL8BLlFDoIKXeEdCBZNu7JYUn2I+RQ0ulbRt53G2DgfcXoDmRb8ggoW9McQb+bC7M4Vco+4+a80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002488; c=relaxed/simple;
	bh=iI1ianl5ZHuhJGAq6msi2LhDQDYaXL95eGwgfA6ZF1Y=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CaFQA7uev039Gtfev2H1AnaC7J89SeoO9Qb3WeS87OTGfb4oExU4vzhpPlx+0mqnqxWy6NNBLqzwC3jJ9RNMWm1HtGymM4lT6sr10Irira/pN5E+G63hyXVzT/53cV3UxS6YMtKWZuCDLra0TNHeID43E+6aJ9Lxg0KdhgkEMEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aet9oJUF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mXDYW22k; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aet9oJUF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mXDYW22k"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7E83E14002DF;
	Thu, 31 Jul 2025 18:54:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Thu, 31 Jul 2025 18:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754002485; x=
	1754088885; bh=/bGtrlMcpJ/K8A/4Ha5wke7hFdCbcarohyrPjXI3ShE=; b=a
	et9oJUFR3D4RaPmPoKhpj+iyC9x+DDjJDACkt6OVSQ4iV03XsYUF7w+c6DMgCk1H
	HI115gN8Ey5fUdlSUtfYhBNNT5Yq9K0X91vlhVB5kN2O4Ff3hZz5y9N8u4jXWnkO
	x4SgsnZKVPX+/D6BwVTxk3vajCtezTx2S+Tjpfk1LG1p5koOpQTsmWJotx+axQf0
	b+R4yf+WfHSXbNN5HZYlLaj9xpe0L74QKbc7o4cxAortg+CHCSayJfxwDY2FBHQD
	Scf9lLTYQfytZM5wM4ekyqcUo94QhfTO7IP66eMWe3lT7LFetkT3+7vx0gNzvZZi
	X9JntNnWnqbZsFCnPjCPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754002485; x=1754088885; bh=/bGtrlMcpJ/K8A/4Ha5wke7hFdCb
	carohyrPjXI3ShE=; b=mXDYW22kGeRlNNKxWnDS8MU/7/00GR9aN/n7pCTmGh6s
	VIFDtytAkwWhniNj3qh/cZ0al7e+VkY4ln2z0kyIjaGg7u31aHXYum/ZpzDip/Qk
	FmSuIl2oTmJ2VRjMhUblNcvkOcvPvUNHCXHWO17/a53kLJxnTNcDlpZNS0mW5O8l
	BXbWvvT7pvfYOeCSGpq57EMR5V+AjYpl4s3uZC2vVh675vM31lPQJgcwh3JVwYe+
	NdYAJ7NmRhLDQfKhOG+mlnM7CW3dzWHdnYYFQBiWupK2apJ9lK2cbliE+n+mz9TD
	z/R/74MGd3NYDtAcbtvvGmZnA7qb1fKhwe6G8pdmHg==
X-ME-Sender: <xms:NfSLaOltm6wj4b1RGZkaJHHCxPPgS5j7gLEYRTsasERrDFa1hfERnA>
    <xme:NfSLaGAYArjFj2OKIZAZsKvs4bvPJsr86gxB9rfhp_YKoeRVUHYwGMtr0nQpONTI-
    cXse8FGXdRORt84fg>
X-ME-Received: <xmr:NfSLaOfpJBsoJnJfblnngGDiyHiANhC8-VbkPzZt887XqmD9d2BKSeZMiBu8Zc4mFNTIU0zoF3M1gaFFsz_W6bq9EARIwLIb3g3x5Y4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:NfSLaBKfl5VwJN70FfJ-9Z0ElH4Y6cKAK6lVyrUfOtwHq_nO_TbW5Q>
    <xmx:NfSLaBfSqMj2vRIjrpkxGL84QNTbRXBaDNgGrTM6q7NiiEGAJv4pDQ>
    <xmx:NfSLaI3QapfAFmnwtQUjQxEoYQcWIvgUrtLuFZ8oJpZ_X1F463a5zg>
    <xmx:NfSLaKhxp6mPcEW7q-mCitIVriaLoGReJKvL2eDtRaFTqxFJCJzrLg>
    <xmx:NfSLaBKSTsdpkK5PY9n70r7SLJzaC0Li2-zqT5PNPcAnasTEbBw_BsH->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:54:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 07/11] config: do not use strbuf_split()
Date: Thu, 31 Jul 2025 15:54:29 -0700
Message-ID: <20250731225433.4028872-8-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731225433.4028872-1-gitster@pobox.com>
References: <20250731074154.2835370-1-gitster@pobox.com>
 <20250731225433.4028872-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When parsing an old-style GIT_CONFIG_PARAMETERS environment
variable, the code parses key=value pairs by splitting them at '='
into an array of strbuf's.  As strbuf_split() leaves the delimiter
at the end of the split piece, the code has to manually trim it.

If we split with string_list_split(), that becomes unnecessary.
Retire the use of strbuf_split() from this code path.

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
2.50.1-618-g45d530d26b

