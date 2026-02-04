Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3A43093CD
	for <git@vger.kernel.org>; Wed,  4 Feb 2026 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770240189; cv=none; b=m1/7EonMVKBcmY6P8LkVRueZZx33jfJqobGvAx0Z73/9gyMd52MrAXg2uvpbVXkKCHZprpfG3spIQpvJzOCLxYQ2sQGklwyw56DWNgBvHwB63OjjWqtEnceulsZKJuVFpo6yBYaL8hdX5oI45/lNyiOJ+TCGWiOzD174wNNtock=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770240189; c=relaxed/simple;
	bh=i/KPo9MHmtoqXEtmU2IpBA19W74Ltv3CH7ITHCfaV4M=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oQ1HJ1sG6GbevHuCvVLvcCoF8yf8H4esV82K4yRxiOD7A5cKhzYepnXit/5iQmNJwBs7yGxDiEDx4izfCQ7KzVLs0FMlpJqxPTeeNVohHR9/HvD9HKBAr9fj464HSC7ginAEX3v4iBVHmsqYl5k1Xq6fiKIHS+illpO42hM8OWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DQS2WA4v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dOq0htKk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DQS2WA4v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dOq0htKk"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 99F5BEC0277;
	Wed,  4 Feb 2026 16:23:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 04 Feb 2026 16:23:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm2;
	 t=1770240188; x=1770326588; bh=g7xPOkCFk3sSf8ZmzMgvHEF/L26YMTaS
	W1yW60fq2XA=; b=DQS2WA4v0Fe7Pf3yTap9kkzv1sEfcOxQK5edq3MSnH5KbM+7
	77C7MtLj/9ieK3yK5BdgtpP7rna5Qk0cHIrln2Cgazd5mbkyvndgqgcc/vWU4tpg
	N3vvK+yF8FjaKFxBWCHjiUqFHaOrmTV+NDip+k/ETiCBJKIiPqOn971R3dsLEcCz
	QCiUbhFpdTcJodRfZmX0t2/1d/s/1O4Gcq8w9qkFpTk2JLpq/qSlfysx9sd02es8
	CQ7zhhFbTJtOgq2bGRjqlAiY/HnQE2z86yqW3665qQ4VF0WgOjy0iH2GFycZXV1Y
	XXRaQim/Ghm/AaKlV1K1SJwjP/6TtV2AG8lcwA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770240188; x=
	1770326588; bh=g7xPOkCFk3sSf8ZmzMgvHEF/L26YMTaSW1yW60fq2XA=; b=d
	Oq0htKkQG9GxC0WZQAFLUYBcAChrdGIhVjOSmQcGHQf6au7v4czBzCzBzqYDNJSh
	BTEIisbx85OXqfLb5UyR//Rv+8GQYo2TThRZbNARRJ4UX5dL73riPCy8S+M0iCIS
	Sept6fdfUZmu5azOM1dlNPrXu1fKFTXrudjodbbVFz43sPvHgBLc9POeVFxz26Jj
	a33AZIcfbSOmhNMyDZGW0jzUynl35GdAeVPH0HjBUIQETvJy4u2RjAim33atMdVA
	ksBwa5OrjYvYFr9+IdV7f06eXzPHOzsSnwKsVbHf+PBDm2LUqRH8k7CehVeaqtBK
	vuKJJePtwIWZN7FaZwbwg==
X-ME-Sender: <xms:vLiDaaucKA03FYWI2vU3Wrh6hMTNp4fhWSBPKoWeiavS6C6_OexMcg>
    <xme:vLiDaVf2Q6fCVgJcKIJsi5KGZCsM-TXXon-fJdxTREAB5BNbVwutaQ7uMnKPKdBSl
    gP59HZFkCOQRAMsO7O2bpwQqkPE5XFP0H5FE4wLKzNzZSfaJt8w-A>
X-ME-Received: <xmr:vLiDaTYDvwWcSZ7awELR38Ay17CrklYnFW7HwhycfTGw5D09xozKfZ3xROdgz66zJF1Cbpy5TPC8QMz4zvpXrSoLpSHNIAbh8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeefheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkfgggtgesthdtredttdertd
    enucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosgho
    gidrtghomheqnecuggftrfgrthhtvghrnhepledvfedtfedtkeefueevlefgleetieeuff
    ffkefhgfekveehkefhgfetjefhffegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hm
X-ME-Proxy: <xmx:vLiDaQUr2QDs6sTSsH0jijQNstTOQi3M7xiEbfmw7JpnqT2VwXd6rA>
    <xmx:vLiDadhMgGECYjOGHCRXOncWpB82t0agpR-AROHgNNECCRdLPgxnJA>
    <xmx:vLiDaWWzYo1OQ5u9l6eKFSIemDyW7JEXSmaj1DzLEyT5s1k3Wnb7iw>
    <xmx:vLiDacPS47Lcc5qBaUvPLvkUmkTbrk8nSSbAIPBEonxnDIhX328PRQ>
    <xmx:vLiDaWFcWGypQMxy9g9ARw68coZeaFhstdV-Q3I9od2aVzO-T0p2MuTu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Feb 2026 16:23:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] whitespace: symbolic links usually lack LF at the end
Date: Wed, 04 Feb 2026 13:23:06 -0800
Message-ID: <xmqqecn0nqyt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

For a patch that touches a symbolic link, it is perfectly normal
that the payload ends with "\ No newline at end of file".  The
checks introduced recently to detect incomplete lines (i.e., a text
file that lack the newline on its final line) should not trigger.

Disable the check early for symbolic links, both in "git apply"
and "git diff" and test them.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 apply.c                    |  5 +++++
 diff.c                     | 20 ++++++++++++++++++--
 t/t4015-diff-whitespace.sh | 13 +++++++++++++
 t/t4124-apply-ws-rule.sh   | 31 +++++++++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 3de4aa4d2e..581aafb8be 100644
--- a/apply.c
+++ b/apply.c
@@ -2193,6 +2193,11 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 		patch->ws_rule = whitespace_rule(state->repo->index,
 						 patch->old_name);
 
+	/* being an incomplete line is the norm for a symbolic link */
+	if ((patch->old_mode && S_ISLNK(patch->old_mode)) ||
+	    (patch->new_mode && S_ISLNK(patch->new_mode)))
+		patch->ws_rule &= ~WS_INCOMPLETE_LINE;
+
 	patchsize = parse_single_patch(state,
 				       buffer + offset + hdrsize,
 				       size - offset - hdrsize,
diff --git a/diff.c b/diff.c
index a68ddd2168..2b37432eed 100644
--- a/diff.c
+++ b/diff.c
@@ -1837,6 +1837,7 @@ static void emit_rewrite_diff(const char *name_a,
 	const char *a_prefix, *b_prefix;
 	char *data_one, *data_two;
 	size_t size_one, size_two;
+	unsigned ws_rule;
 	struct emit_callback ecbdata;
 	struct strbuf out = STRBUF_INIT;
 
@@ -1859,9 +1860,14 @@ static void emit_rewrite_diff(const char *name_a,
 	size_one = fill_textconv(o->repo, textconv_one, one, &data_one);
 	size_two = fill_textconv(o->repo, textconv_two, two, &data_two);
 
+	ws_rule = whitespace_rule(o->repo->index, name_b);
+	if ((DIFF_FILE_VALID(one) && S_ISLNK(one->mode)) ||
+	    (DIFF_FILE_VALID(two) && S_ISLNK(two->mode)))
+		ws_rule &= ~WS_INCOMPLETE_LINE;
+
 	memset(&ecbdata, 0, sizeof(ecbdata));
 	ecbdata.color_diff = o->use_color;
-	ecbdata.ws_rule = whitespace_rule(o->repo->index, name_b);
+	ecbdata.ws_rule = ws_rule;
 	ecbdata.opt = o;
 	if (ecbdata.ws_rule & WS_BLANK_AT_EOF) {
 		mmfile_t mf1, mf2;
@@ -3764,6 +3770,7 @@ static void builtin_diff(const char *name_a,
 		xpparam_t xpp;
 		xdemitconf_t xecfg;
 		struct emit_callback ecbdata;
+		unsigned ws_rule;
 		const struct userdiff_funcname *pe;
 
 		if (must_show_header) {
@@ -3775,6 +3782,11 @@ static void builtin_diff(const char *name_a,
 		mf1.size = fill_textconv(o->repo, textconv_one, one, &mf1.ptr);
 		mf2.size = fill_textconv(o->repo, textconv_two, two, &mf2.ptr);
 
+		ws_rule = whitespace_rule(o->repo->index, name_b);
+		if ((DIFF_FILE_VALID(one) && S_ISLNK(one->mode)) ||
+		    (DIFF_FILE_VALID(two) && S_ISLNK(two->mode)))
+			ws_rule &= ~WS_INCOMPLETE_LINE;
+
 		pe = diff_funcname_pattern(o, one);
 		if (!pe)
 			pe = diff_funcname_pattern(o, two);
@@ -3786,7 +3798,7 @@ static void builtin_diff(const char *name_a,
 			lbl[0] = NULL;
 		ecbdata.label_path = lbl;
 		ecbdata.color_diff = o->use_color;
-		ecbdata.ws_rule = whitespace_rule(o->repo->index, name_b);
+		ecbdata.ws_rule = ws_rule;
 		if (ecbdata.ws_rule & WS_BLANK_AT_EOF)
 			check_blank_at_eof(&mf1, &mf2, &ecbdata);
 		ecbdata.opt = o;
@@ -3993,6 +4005,10 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.ws_rule = whitespace_rule(o->repo->index, attr_path);
 	data.conflict_marker_size = ll_merge_marker_size(o->repo->index, attr_path);
 
+	if ((DIFF_FILE_VALID(one) && S_ISLNK(one->mode)) ||
+	    (DIFF_FILE_VALID(two) && S_ISLNK(two->mode)))
+		data.ws_rule &= ~WS_INCOMPLETE_LINE;
+
 	if (fill_mmfile(o->repo, &mf1, one) < 0 ||
 	    fill_mmfile(o->repo, &mf2, two) < 0)
 		die("unable to read files to diff");
diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 3c8eb02e4f..903128f1d2 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -90,6 +90,19 @@ test_expect_success "new incomplete line in post-image" '
 	git -c core.whitespace=incomplete diff -R --check x
 '
 
+test_expect_success SYMLINKS "incomplete-line error is disabled for symlinks" '
+	test_when_finished "git reset --hard" &&
+	test_when_finished "rm -f mylink" &&
+	ln -s one mylink &&
+	git add mylink &&
+	ln -s -f two mylink &&
+
+	git -c core.whitespace=incomplete diff mylink &&
+	git -c core.whitespace=incomplete diff -R mylink &&
+	git -c core.whitespace=incomplete diff --check mylink &&
+	git -c core.whitespace=incomplete diff -R --check mylink
+'
+
 test_expect_success "Ray Lehtiniemi's example" '
 	cat <<-\EOF >x &&
 	do {
diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 115a0f8579..f48d8bbf49 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -743,4 +743,35 @@ test_expect_success 'incomplete line modified at the end (error)' '
 	test_cmp sample target
 '
 
+test_expect_success "incomplete-line error is disabled for symlinks" '
+	test_when_finished "git reset" &&
+	test_when_finished "rm -f patch.txt" &&
+	oneblob=$(printf "one" | git hash-object --stdin -w -t blob) &&
+	twoblob=$(printf "two" | git hash-object --stdin -w -t blob) &&
+
+	git update-index --add --cacheinfo "120000,$oneblob,mylink" &&
+
+	oneshort=$(git rev-parse --short $oneblob) &&
+	twoshort=$(git rev-parse --short $twoblob) &&
+	cat >patch.txt <<-EOF &&
+	diff --git a/mylink b/mylink
+	index $oneshort..$twoshort 120000
+	--- a/mylink
+	+++ b/mylink
+	@@ -1 +1 @@
+	-one
+	\ No newline at end of file
+	+two
+	\ No newline at end of file
+	EOF
+
+	git -c core.whitespace=incomplete apply --cached --check patch.txt &&
+
+	git -c core.whitespace=incomplete apply --cached --whitespace=error \
+		patch.txt &&
+
+	git -c core.whitespace=incomplete apply --cached -R --whitespace=error \
+		patch.txt
+'
+
 test_done
-- 
2.53.0-169-ga09cd4eb64

