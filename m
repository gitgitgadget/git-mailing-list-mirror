Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780952857F8
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753944001; cv=none; b=i/n52v7uC/QTf0MSdgwzUNf6bSuY3OkIDhJqoAcVcwWiWHHex8LmlzMrfliDB9b2LwE7IY8EHPtJZcIlI9kZpUshR1XI8qtRWO7MB/NWXGX2bPl1x7i2Lhj1fv//idOdaDKSqgNcdOlKb2aYmvv3t/KTOowcHrFrpbTRz6kQ8zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753944001; c=relaxed/simple;
	bh=94B9k8ZxuJdDYFqOTFg0Id3CXTpcdD7+G5a/faQ5uDc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nzie2xEbRt3bdL0uW7gJGkOsImzIMqSXE7mX9As5+h+IJ5klog2zvGo/TimLD7YaOVuWW6bKKsxrDE4S7BjqTYg70Uytml3tdxXx/zJ2Ag2lNHQmqOCE1lCoPV8coqJdTowxFQpUXuioC2L2T7duKt5AYibwmSRKWAfEl90WHBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NNhEE+RC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dEIfR1Xq; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NNhEE+RC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dEIfR1Xq"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 7FFED1D008A0;
	Thu, 31 Jul 2025 02:39:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Thu, 31 Jul 2025 02:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753943998; x=
	1754030398; bh=a2Q3fg2yspS95xG7MLqBNcNB+bjhrZJgKCEyCj+sKWA=; b=N
	NhEE+RCm5rPLOvxN8UlzG8M5nPiNxe1mtqGJQUVAX158HG+Q520DAFzO5vB7hJQv
	4EEKYKjQoR40XXn7QX0Hhae5o6Y1ouQNMy3UB9W1CrKWmL80ht9ZgHMUZdRubEKN
	kLzH24QtQ4fFVpSfNn7ZVwBxjNouIm+KocaBzF+TObUGn5I5g/4YnkiDGw2mhdFN
	VUZVClXrIhvzso8hbUS8gFNKP2parfdwAn1Cka5gc6ptfamyK9QpVRaIopB2SA6W
	asNRJTY35rQmKHih/Lzq/Mrad8VT9fRcYcQjpdKqDmCS8d/V8R/hRh9wVsQTRRkT
	Cls0hPC+i5UA77hh/275g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753943998; x=1754030398; bh=a2Q3fg2yspS95xG7MLqBNcNB+bjh
	rZJgKCEyCj+sKWA=; b=dEIfR1XqOyz97eOvOfwfeE7kivXv235g9i5jExE9gJuT
	jC7CP2DnCdY0q71vL0wcECm71Pf0PGa7kqkbeNs/mbFydE0N8QKSXaHR26sGnP7Z
	wj2gT0IscO3XGyxD0qVW5y3izvfs5N29Y6OGdM0pLFdw+mw641rxzClR3vke+8Xo
	uxTWjFeziQdhoknVQH1sfUphNfifYVUaENm6InFbFiJU3+vTE8WlZT6sRAgmcFX0
	xTyAvDZMuuvZ/TniAp6b7QF24q6ccfOiygMwh7u5WKbkqbAbgWyUxie2SrXoYK8l
	9bhH5NSEI4/eY8WPJQy2Wok5+z6e14UNcDzBlUdk8A==
X-ME-Sender: <xms:vg-LaM_kgbxDA9IERsakNmwWH2utgaLSWDmYsx1hplmakjOZfrLRYA>
    <xme:vg-LaE5c_ZuuEM6DbGrIUGZQ1m5VttdaXkC8hx5Vpa1pr3EdyXNvUOPrn-DrxPTOS
    1RQ8vjfmxfjbV6kYQ>
X-ME-Received: <xmr:vg-LaD2qkO9Y0bPLqN0Mg1dTQUis7F9rr3H5TAG2hbfC8fTdWV0lNvjHYJKGU8-pr_fO_sfxjLWBbzPi7xTE6JJDJj_iaF-NR5X0Es8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepvdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:vg-LaLDHjbkmky6gfek0xeXur9e5gKKZvVw8AGXBehYio5Kkw0zMLg>
    <xmx:vg-LaF0Rnrb9ToiZg_OPZIKx8zN8V7re7zjs00iAfBkk1Gs5fDebGA>
    <xmx:vg-LaFulN0iAnOeiVbdDb-XisI4sEtt3u9q4p0su3nzL9PiQVpO_DQ>
    <xmx:vg-LaF4h98mR3cFKxZPGO_rgTdv58txj1zKOoUyZs7damgmoc_66uw>
    <xmx:vg-LaPhzqFoYZlteq7ON_CbVgMNmfJcI62weeiSQnGpriUqlh3OkoyFe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 02:39:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/5] string-list: optionally trim string pieces split by string_list_split()
Date: Wed, 30 Jul 2025 23:39:48 -0700
Message-ID: <20250731063949.1601669-5-gitster@pobox.com>
X-Mailer: git-send-email 2.50.1-612-g4756c59422
In-Reply-To: <20250731063949.1601669-1-gitster@pobox.com>
References: <20250731063949.1601669-1-gitster@pobox.com>
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
index 893e82be49..c6a3afb15a 100644
--- a/string-list.c
+++ b/string-list.c
@@ -278,11 +278,18 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 
 static void append_one(struct string_list *list,
 		       const char *p, const char *end,
-		       int in_place)
+		       int in_place, unsigned flags)
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
@@ -302,7 +309,7 @@ static void append_one(struct string_list *list,
  * returns "char *" pointer into that const string.  Yucky but works ;-).
  */
 static int split_string(struct string_list *list, const char *string, const char *delim,
-			int maxsplit, int in_place)
+			int maxsplit, int in_place, unsigned flags)
 {
 	int count = 0;
 	const char *p = string;
@@ -315,13 +322,19 @@ static int split_string(struct string_list *list, const char *string, const char
 	for (;;) {
 		char *end;
 
+		if (flags & STRING_LIST_SPLIT_TRIM) {
+			/* ltrim */
+			while (*p && isspace(*p))
+				p++;
+		}
+
 		count++;
 		if (maxsplit >= 0 && count > maxsplit)
 			end = NULL;
 		else
 			end = strpbrk(p, delim);
 
-		append_one(list, p, end, in_place);
+		append_one(list, p, end, in_place, flags);
 
 		if (!end)
 			return count;
@@ -332,11 +345,23 @@ static int split_string(struct string_list *list, const char *string, const char
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
2.50.1-612-g4756c59422

