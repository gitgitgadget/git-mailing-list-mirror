Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BA22E3E8
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 22:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085874; cv=none; b=kZfRbCsp9ImXPuixArP63OvoKd5UZLgi6EsvE6+/CESH1CQHaOJXknwmhq2uaxUFC5+8nE5F90PPz5wBhjpOfLe3qRdzz71/TTWCV6XIWU/CqijZYvgD3LnXunixwMsTuV06gVtWAi1dL0z0PYswkTdPzMKKtRqQi4iTDlbpjs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085874; c=relaxed/simple;
	bh=LgsbWtCEJVyZc3LEdfA5y06GAzERXMY2vE1GRbk/HtY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnHn5ygjJl4RceWy4dTOpPTWRvwZg/MEPTWaM/DoDgCtBLzbn4+ENwqcUFIBTHhkuh2t3arTtcWsUapNY/LVWbzPoc0qwqW0uWX1+Z9lU8VfzlXSmzgxEK/wVLR10E/Juesrva4+/q5eJgr6WX0kWpykHpsca2TxxAxrvL41fmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HqknTl6G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkByq5j2; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HqknTl6G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkByq5j2"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AA8E914001A4;
	Fri,  1 Aug 2025 18:04:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 01 Aug 2025 18:04:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754085871; x=
	1754172271; bh=aNp5cnrI1FZWKSbS+vaRS0sX5hVxb/93/tJbhuQhptM=; b=H
	qknTl6GATcecuWIoLGkLzmPkU+xym3Xgoh1zoHwl0fxDkDODRBuqecnSWexkC8De
	ixLor17BcpLpdVn/mTiW+8u3CXkEXnh0F6BV5RZbOdT9TP88gvB6ptFPkVkDMT0I
	uewH0eKZzh8VxLdgn6L+uvhOttC50vQ165siliRb4+WVtWcfi35TPWn/gYVaAG4G
	76Q+0xMIadZumV3ydNsWF4H971WIKDk+wIQZEmr903VwqHMlJMPl3uwDPGG2d5RJ
	7k4fIrzlcXWePa2Tvet+5+vhe+wV8B+ANcYQNupP3fnOF/PfsqIyO7XSNvwnyiRn
	Ku8ATh5uyNKJIiWFWMkJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754085871; x=1754172271; bh=aNp5cnrI1FZWKSbS+vaRS0sX5hVx
	b/93/tJbhuQhptM=; b=QkByq5j2JGxQ+TNzm6atZZCyqA+CLifhZHgE3yGBrm2O
	Hkh0tfB9goYgtak3BoZawx52SCfE6mKlNG44tORMYbJAMkBGfOhHvtbC8o3Z7G1k
	6E6qQmGRNM2FD8GnbZCNMNgx8+mCHga0X2oJ0Y6je7uaqVoXGkQpSSs6XoneRz7m
	TlocsxcxnGytyvMELuyTrV2zkhTQvrR1baZE5191Z3I6g4M7AhIuiWxDVUv4UDsq
	UIaJ1kGk+TRTIBvaTgcUymtTh5tH8VE2lUMtbrhgUNS/5k9H8v0LEzIOu3TMOrvu
	624sCAqT03QtooqCBbp4N8UOWBAqd2ElrLpJ5phmWg==
X-ME-Sender: <xms:7zmNaLQk8ts5lhDtzPKsO23ron7QbcTVtVCdsFnQ92Yp7RxhLcJkMg>
    <xme:7zmNaM9OTFV4yEqaQX2zuKXn14ndUHFvaieNrEoPGRGuj4rcgOc7rjLvEGCeSNpD3
    fPQVEKilJV_r4nmwA>
X-ME-Received: <xmr:7zmNaCrR-TDRBUpEcTBx-6nTA44FccbWy2BFlUx08E6sfbV1kIPdhB0_8RCpx8M_mqhQ1n10kpVbnRiwQ5XyeUe4qKY6yBEEatdiNVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:7zmNaJlIyHSTN5PIv8X97Id4lOeVoxX93ogl1vBLVFpdUTbenLAXiA>
    <xmx:7zmNaJJKJOMgDrEUN94FIUWjwSphGdt3vWsEOCekuzeFBcmQwijrng>
    <xmx:7zmNaOyen4ejNcMwIRpxuFfC3qZW7rLJiwbLLm7vRqPMnUq_4fMq5Q>
    <xmx:7zmNaBuqIAOBhjDupF-GnMvt2f736scHEjhDqcpNtcxJUgsUxRbhEQ>
    <xmx:7zmNaF2KN9AcU5WyNrOIEKAQs6-s5bybScB9-X97ZYYnOMVh-hDNS-gY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 18:04:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 4/7] string-list: optionally trim string pieces split by string_list_split*()
Date: Fri,  1 Aug 2025 15:04:20 -0700
Message-ID: <20250801220423.1230969-5-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g85c5610de3
In-Reply-To: <20250801220423.1230969-1-gitster@pobox.com>
References: <20250731224607.3942417-1-gitster@pobox.com>
 <20250801220423.1230969-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the unified split_string() to take an optional "flags" word,
and define the first flag STRING_LIST_SPLIT_TRIM to cause the split
pieces to be trimmed before they are placed in the string list.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c                | 35 +++++++++++++++++---
 string-list.h                | 12 +++++++
 t/unit-tests/u-string-list.c | 64 ++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+), 5 deletions(-)

diff --git a/string-list.c b/string-list.c
index 65b6ceb259..86a309f8fb 100644
--- a/string-list.c
+++ b/string-list.c
@@ -282,11 +282,18 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
  */
 static int append_one(struct string_list *list,
 		      const char *p, const char *end,
-		      int in_place)
+		      int in_place, unsigned flags)
 {
 	if (!end)
 		end = p + strlen(p);
 
+	if ((flags & STRING_LIST_SPLIT_TRIM)) {
+		/* rtrim */
+		for (; p < end; end--)
+			if (!isspace(end[-1]))
+				break;
+	}
+
 	if (in_place) {
 		*((char *)end) = '\0';
 		string_list_append(list, p);
@@ -307,7 +314,7 @@ static int append_one(struct string_list *list,
  * returns "char *" pointer into that const string.  Yucky but works ;-).
  */
 static int split_string(struct string_list *list, const char *string, const char *delim,
-			int maxsplit, int in_place)
+			int maxsplit, int in_place, unsigned flags)
 {
 	int count = 0;
 	const char *p = string;
@@ -320,12 +327,18 @@ static int split_string(struct string_list *list, const char *string, const char
 	for (;;) {
 		char *end;
 
+		if (flags & STRING_LIST_SPLIT_TRIM) {
+			/* ltrim */
+			while (*p && isspace(*p))
+				p++;
+		}
+
 		if (0 <= maxsplit && maxsplit <= count)
 			end = NULL;
 		else
 			end = strpbrk(p, delim);
 
-		count += append_one(list, p, end, in_place);
+		count += append_one(list, p, end, in_place, flags);
 
 		if (!end)
 			return count;
@@ -336,11 +349,23 @@ static int split_string(struct string_list *list, const char *string, const char
 int string_list_split(struct string_list *list, const char *string,
 		      const char *delim, int maxsplit)
 {
-	return split_string(list, string, delim, maxsplit, 0);
+	return split_string(list, string, delim, maxsplit, 0, 0);
 }
 
 int string_list_split_in_place(struct string_list *list, char *string,
 			       const char *delim, int maxsplit)
 {
-	return split_string(list, string, delim, maxsplit, 1);
+	return split_string(list, string, delim, maxsplit, 1, 0);
+}
+
+int string_list_split_f(struct string_list *list, const char *string,
+			const char *delim, int maxsplit, unsigned flags)
+{
+	return split_string(list, string, delim, maxsplit, 0, flags);
+}
+
+int string_list_split_in_place_f(struct string_list *list, char *string,
+			       const char *delim, int maxsplit, unsigned flags)
+{
+	return split_string(list, string, delim, maxsplit, 1, flags);
 }
diff --git a/string-list.h b/string-list.h
index 6c8650efde..87ccc5f1e6 100644
--- a/string-list.h
+++ b/string-list.h
@@ -281,4 +281,16 @@ int string_list_split(struct string_list *list, const char *string,
  */
 int string_list_split_in_place(struct string_list *list, char *string,
 			       const char *delim, int maxsplit);
+
+/* flag bits for split_f and split_in_place_f functions */
+enum {
+	/* trim() resulting string piece before adding it to the list */
+	STRING_LIST_SPLIT_TRIM = (1 << 0),
+};
+
+int string_list_split_f(struct string_list *, const char *string,
+			const char *delim, int maxsplit, unsigned flags);
+
+int string_list_split_in_place_f(struct string_list *, char *string,
+				 const char *delim, int maxsplit, unsigned flags);
 #endif /* STRING_LIST_H */
diff --git a/t/unit-tests/u-string-list.c b/t/unit-tests/u-string-list.c
index 150a5f505f..daa9307e45 100644
--- a/t/unit-tests/u-string-list.c
+++ b/t/unit-tests/u-string-list.c
@@ -63,6 +63,70 @@ static void t_string_list_split(const char *data, const char *delim, int maxspli
 	string_list_clear(&list, 0);
 }
 
+static void t_string_list_split_f(const char *data, const char *delim,
+				  int maxsplit, unsigned flags, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
+	va_list ap;
+	int len;
+
+	va_start(ap, flags);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_clear(&list, 0);
+	len = string_list_split_f(&list, data, delim, maxsplit, flags);
+	cl_assert_equal_i(len, expected_strings.nr);
+	t_string_list_equal(&list, &expected_strings);
+
+	string_list_clear(&expected_strings, 0);
+	string_list_clear(&list, 0);
+}
+
+void test_string_list__split_f(void)
+{
+	t_string_list_split_f("::foo:bar:baz:", ":", -1, 0,
+			      "", "", "foo", "bar", "baz", "", NULL);
+	t_string_list_split_f(" foo:bar : baz", ":", -1, STRING_LIST_SPLIT_TRIM,
+			      "foo", "bar", "baz", NULL);
+	t_string_list_split_f("  a  b c  ", " ", 1, STRING_LIST_SPLIT_TRIM,
+			      "a", "b c", NULL);
+}
+
+static void t_string_list_split_in_place_f(const char *data_, const char *delim,
+					   int maxsplit, unsigned flags, ...)
+{
+	struct string_list expected_strings = STRING_LIST_INIT_DUP;
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	char *data = xstrdup(data_);
+	va_list ap;
+	int len;
+
+	va_start(ap, flags);
+	t_vcreate_string_list_dup(&expected_strings, 0, ap);
+	va_end(ap);
+
+	string_list_clear(&list, 0);
+	len = string_list_split_in_place_f(&list, data, delim, maxsplit, flags);
+	cl_assert_equal_i(len, expected_strings.nr);
+	t_string_list_equal(&list, &expected_strings);
+
+	free(data);
+	string_list_clear(&expected_strings, 0);
+	string_list_clear(&list, 0);
+}
+
+void test_string_list__split_in_place_f(void)
+{
+	t_string_list_split_in_place_f("::foo:bar:baz:", ":", -1, 0,
+				       "", "", "foo", "bar", "baz", "", NULL);
+	t_string_list_split_in_place_f(" foo:bar : baz", ":", -1, STRING_LIST_SPLIT_TRIM,
+				       "foo", "bar", "baz", NULL);
+	t_string_list_split_in_place_f("  a  b c  ", " ", 1, STRING_LIST_SPLIT_TRIM,
+				       "a", "b c", NULL);
+}
+
 void test_string_list__split(void)
 {
 	t_string_list_split("foo:bar:baz", ":", -1, "foo", "bar", "baz", NULL);
-- 
2.50.1-633-g85c5610de3

