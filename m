Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC97927F00A
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001978; cv=none; b=feoZhjqVr31FgiX+FKoF/pBo6PBIkaxFD4sbJ3u+cKJP3c5F7er9l23edBgzxzhv4J7eZaU2/2tSyBUxfRuSYdzs17F7xBLVs/gjQ6dD7vslkUSZ6dNamoKI6lWfC+cgTBecdT0aEC/qPGs6NtvF2Td0dWXyZ/WjLcU+AUdx6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001978; c=relaxed/simple;
	bh=sPrSYwYKgS06RG5+B4/fKvsbNnWDRSv1AUgKy6Xf7IU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lwnq8boQ+dTyi/wJU6TEBCmOWE80yDopFKqUtXfoI88xG4QO3FGoIU21JLgij0pIq/B1tMtueCQxWbly6s4oigqyr7hDLdTzNAq6REKqjftmcyAPPUUBZtkUbnoq+sDpgfn2dH8UxiWbtoeWm6LtMtbl4nkoOMl6U+Es1+p0iSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JT1d3zT0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xx0PGTZU; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JT1d3zT0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xx0PGTZU"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id C7CC8EC16C5;
	Thu, 31 Jul 2025 18:46:14 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 31 Jul 2025 18:46:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754001974; x=
	1754088374; bh=wCFg8gF4tBwQ+3xGHBTrrY/OrvtJR+V622UKsl7Su+Y=; b=J
	T1d3zT06c82xEz0cp+gmaZ0axQ5BpgXBoD09gzeuiBIoorcXG8rLrgglRqUsgh04
	1i1yqzdacy9w64lp2GPMFlRLFc/9NrFFu330SWo1fSIlxsXtD4O56xZ1V22UDd9o
	OH+zvkwe8nGZJaNEjikc14MxziKmpa7xdNczmEUfZsGtteX8orYRtwUAL3UGvHLw
	GUAewOx185hF6hsqdjwATQsyfENPIS+V+EW6CSChwmIJfPCETr9KqY4idV0tQW+s
	np+Fyqv0loUDSkeL3PB1ZJjzo45K5VxQ+0pXt1BJrQ8qZ0SLJH0wBZOdPnT8GmqX
	1Z2VlXMpmw+LUpW/cqyuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754001974; x=1754088374; bh=wCFg8gF4tBwQ+3xGHBTrrY/OrvtJ
	R+V622UKsl7Su+Y=; b=Xx0PGTZUlMJh2/hrttvZnpMlxR5AM1aZwjLOVVTnAMeU
	n+k7eayb4Z5mIo0ymknpAtX3Di42fHUiWwmWLACJ5+6Q91wrkGWxeHZJS4rnVH8g
	1aQ/QSWzx+UUqc3ZFwSMhpqEoB0kTY5qPKzTySyh/Dnw4dbVIp+6SH9FTp7aUB74
	xzlrOD28KxME1PnR12fJCJsYd0Tu/tV2R6rRD6oqq3EggsvgH951Afbu8plLTN3H
	8f6hnaQeHJ3bodTrDhxnUKKfJQqObLvn2T+wzKkhO1ysqng6OwikLHb8dKHxdAVN
	VxnlFmCEdz+gHsljd4fjpgvvmxBV0ON7rnSW4H4vUg==
X-ME-Sender: <xms:NvKLaFdADzVWSpQngkYYsFPbXLc0TFtcsWeFrFeFcvsxRZAbFZ5CZg>
    <xme:NvKLaDaFyUEtKoTdgNm5y_9NeDOKrSMctmEmbV0e861Q0eZPxFT4zJz6-CXP6uCsz
    PTX9IjzJHQsoPnhKg>
X-ME-Received: <xmr:NvKLaAWFHtrEJA20glzx0l9OqDBLHzTJQbNXhiBcXAKSCEKPEfOtOfDGE3BU_AEEFc8lp3WC_ndQ5_ZR79XrRp9ibhGjTRIa4kkewgQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddvtdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:NvKLaNie4yqdGZ9KgbXTnVXFFHjU25F4rfj8clJzMef-LKArK-jBAA>
    <xmx:NvKLaGWdWCAvE0EUQRKAoVsjQNhI5ohmnMizTdS3veCHECVVlkYTtw>
    <xmx:NvKLaMN01O3Udeoy1nVQwZooxdn-Zn28UEY8yCmgHt1S_2fv0ysJsg>
    <xmx:NvKLaKbg8pMCoUaGnoNeDno14Ci7pLFYdu66VZdEdl8gLJQsYMkvzg>
    <xmx:NvKLaIAz8jH7ifgtCGEjyr_eKuGGWuxkM4f48e3x2GyzfKmvwhYhcyj4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:46:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 4/7] string-list: optionally trim string pieces split by string_list_split*()
Date: Thu, 31 Jul 2025 15:46:03 -0700
Message-ID: <20250731224607.3942417-5-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-618-g45d530d26b
In-Reply-To: <20250731224607.3942417-1-gitster@pobox.com>
References: <20250731063949.1601669-1-gitster@pobox.com>
 <20250731224607.3942417-1-gitster@pobox.com>
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
 string-list.h                | 10 ++++++
 t/unit-tests/u-string-list.c | 64 ++++++++++++++++++++++++++++++++++++
 3 files changed, 104 insertions(+), 5 deletions(-)

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
index 6c8650efde..ee9922af67 100644
--- a/string-list.h
+++ b/string-list.h
@@ -281,4 +281,14 @@ int string_list_split(struct string_list *list, const char *string,
  */
 int string_list_split_in_place(struct string_list *list, char *string,
 			       const char *delim, int maxsplit);
+
+/* trim() resulting string piece before adding it to the list */
+#define STRING_LIST_SPLIT_TRIM 01
+
+int string_list_split_f(struct string_list *, const char *string,
+			const char *delim, int maxsplit, unsigned flags);
+
+int string_list_split_in_place_f(struct string_list *, char *string,
+				 const char *delim, int maxsplit, unsigned flags);
+
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
2.50.1-618-g45d530d26b

