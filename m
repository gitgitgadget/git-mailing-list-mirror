Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C328151E
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203953; cv=none; b=dTxolGjONxEZcVHi/UiPpF79J+DUAs+NKQjWYC2oxTjnNcbHix5uWQJJR7CcA2ThTpIIw2zlR0auq0KDH8at5glADyd5wuHed6dDq3NpujpZJFLPqavNhrFKyLYWN8OpmY3RqV9A0nEM2p0WXuzZTYe8QlVlKbS/eIn3dMN73Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203953; c=relaxed/simple;
	bh=XbeMvenZb14f8v9OTurylHswghwIsfDWJ4Hx/iTSkk8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDCy4nhJg/7ThV2iM3oe5l3LALHbeB6BwrFxz7B8KSwygjsbNGsPQsJggoepjENik3pRVbRAiU6m/xeJnJDnnDSCK0VVoOz7bw0FzDXHCzsIefJ3q5KgFFHBpV1+QFaUZe88CVLLweIhReACM4ZnKuc/0RsQotL76bf5M7Or0O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=chWW9dVC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CLNxNhYm; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="chWW9dVC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CLNxNhYm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 1D10B1400350;
	Sun,  3 Aug 2025 02:52:31 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Sun, 03 Aug 2025 02:52:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203951; x=
	1754290351; bh=4PRhPiJuPxeYt5U6dNVkSR1PC9rjdSR9BjCesEA+ys8=; b=c
	hWW9dVChTVI50qTVzRSfzHUi7ea796377m1+abl1vg+yNWbzFKcfTPqofeQH423k
	rYfVOwbcZLP+RzLgu+glmCzEgfEHl4mHqnw+/LNYS806W6/QUoJROkfqch7yZUiC
	FiQYd1Jk+NhEhSlvHjwpPgf2xLhpbcDh3nXqGqxwWOcxnoFhARi7O/uy7GowVnRR
	SyTrhL5iJ6I/9G1x66lD7v3yi6LL1+ztNTYzADGBpb0z2H5kRl5vXa4RHE7YO7si
	Y0b16Be/s7Riq6Dwp5YByVm7wujmYy5LiDtBaMJ1CREDGbHm1S5zxuvExJuZDRT1
	mAIG3YDRvseKeJO3dVs5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203951; x=1754290351; bh=4PRhPiJuPxeYt5U6dNVkSR1PC9rj
	dSR9BjCesEA+ys8=; b=CLNxNhYm8KqaFJ7zJrJnDAEuqhazH63kSqcHHCXo3obw
	Y861R1i3M41V8Cih9c+SU2chaLBjCAjXdgzy8s0nWFghkDq3RAUS1s25jQQi7FX+
	7EcqdfJskCQjV78/uIER576R2NhwysUOPZKxwLXoIbMy21QZWuo91h+IQZ2HzOGj
	bWdB8sVE53R5abAWqfaNOJ46LLqHEj4mFGbXICnWzdvBLYeS8WaP3JXBfeez+bQC
	1D1xUkZvoqTy5Pi9pp0eCoUCxC5AsrpMH1SszAxM33qzP+hrZrli1mM4/Dvc6gzB
	1oFHNXD2SHx8cOPiTgy9HPcndocWJYqCC9VGIjvtXg==
X-ME-Sender: <xms:LgePaIYXEF-fhUhqh8TCehol4qeiPdih-jZokGg17JpdUVmPbt5MOw>
    <xme:LgePaDlezQZGjpgGrIazZ-Ijg-tZOJY5yHOqtUsI4cBCtq2BUDpCkA6UdylCQ6S9Z
    Whph8gmiyAcswNR5A>
X-ME-Received: <xmr:LgePaEydftqHHdz1ef9xeXAe3g7MuOubQ_NDyDzFD-IeGCgxKvITkecR6kEVdqlrBW_9Pr-RP88gJDJfeojlKKBcD5_8AmyPi2O3zYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdekjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:LgePaBO_EZ384Ej4g33Mc8ZXe6NiBWAyS3tDyhKsr6EIr--92d48ug>
    <xmx:LgePaIRYVQ9HrYVqqbPLfqD6zzIjAL6u7dKIUyK3LZRhZFEArHf1xw>
    <xmx:LgePaPb6ISJ2xJnCG1Zw-iROfs6kfyVOUKMh7MrafzDZGRYESYvh8w>
    <xmx:LgePaF3WinAE4p3DGK-ItLizzZDfnXz1BSNeefb1CRcXuFFP60UsUQ>
    <xmx:LwePaC9OsbnR8vaNh8eyhOumDGYU38BBOnSo1QMYa3FwfHrO_zidzcQa>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:52:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 4/7] string-list: optionally trim string pieces split by string_list_split*()
Date: Sat,  2 Aug 2025 23:52:20 -0700
Message-ID: <20250803065223.3325111-5-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-633-g69dfdd50af
In-Reply-To: <20250803065223.3325111-1-gitster@pobox.com>
References: <20250801220423.1230969-1-gitster@pobox.com>
 <20250803065223.3325111-1-gitster@pobox.com>
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
 string-list.h                | 15 +++++++++
 t/unit-tests/u-string-list.c | 64 ++++++++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 5 deletions(-)

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
index 6c8650efde..40e148712d 100644
--- a/string-list.h
+++ b/string-list.h
@@ -281,4 +281,19 @@ int string_list_split(struct string_list *list, const char *string,
  */
 int string_list_split_in_place(struct string_list *list, char *string,
 			       const char *delim, int maxsplit);
+
+/* Flag bits for split_f and split_in_place_f functions */
+enum {
+	/*
+	 * trim whitespaces around resulting string piece before adding
+	 * it to the list
+	 */
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
2.50.1-633-g69dfdd50af

