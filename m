Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D575281378
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 06:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754203952; cv=none; b=eN1Tv0lUwg3zD3sPjUvEaE0zALfW27X91DCuvCPF+dzqKtAPlyz/ipMS5geb6VmIk/7Nue193S08HSocnuRXEpm35rwy2jaC6MFHgJLD2Uz/QOdEQngpR6o5ry/x7CU0BWQhjuKoTYH+9eFPcqAIey+3to5cdPrVP/KgpjtGy44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754203952; c=relaxed/simple;
	bh=mZxYCUWkijB/5tlmV3E2T2WSGQQEjvz7xmOwbqBj+Wo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DvMuYMqlNsCuVoCEcFxoxEk+tC73B2qTnL6d4z0zncRvkPnyaLUbKJMZZnPIMSuIxGzy/yNQs+dI7wSPiKM5RaFzWv/Li32czqmpkQ1bEf2+uQ/UP8U3uKXtAhFMNsUd8DTMoJ1MpIwjGGKj1p6UUEf4yPp4q4OzbgVdCNOw8Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OgosucVs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aFEmSeIb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OgosucVs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aFEmSeIb"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7CA1B140032D;
	Sun,  3 Aug 2025 02:52:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 03 Aug 2025 02:52:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754203949; x=
	1754290349; bh=8efh7FrRdI+xu681br3w6qq7By7yJxd+4tJAwU0viHc=; b=O
	gosucVsmhvIjYWLVMef1GhnP2ZoDo4DstjEli26CZyJGFP/MZ1k5E5+PhR86ZIeh
	C1FE7QTnAmyfWm0l2blE0Xzd8AM4ra+fE2ArvmuxoIMco7SF+Z1c8kSMJGvNzfU3
	yNJHJ6uqJhFLrRN0Xh1o40UMhBoir3CXEh1sOkGFM7qeJXiyy2c/7zW48nnxXfq5
	tZbtuFBLFPylNxPJeyBgSRUMlQZ7Q2SCj75SPmDTH6ziXSggGOAzPqIRI4GWDKad
	1mrz5P+baOuTcioBqG+Y0sz7QMU8nz9xEwd6TCWgiyM9rTkTFL5UD30JDuuDIAHd
	yFnFIkJC/eDabymKiOA8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754203949; x=1754290349; bh=8efh7FrRdI+xu681br3w6qq7By7y
	Jxd+4tJAwU0viHc=; b=aFEmSeIbHpnI6UNxKz0z52RE5ArMGofIHWlondir5zVz
	aabPCWcds7ZPPYORXBaprYPbiaNq4xghTV3JESw+LZhOWpAHvKIEC1EQh2BJNi6k
	Eu3CFwYeaoBR6L+kQMgV3z6tuDejSRTAFrB0oievYR/NYXz1mn42blIAzERRjp+E
	IOwKWGReA6bV+c4HYZaiw3Lhb2zLoQV3MmDEPTwElR/JyqPNmRGMy5Quy+og9b7G
	VcCGJUDWr5mMSSp3f72xws+L/xevps8OAtl8oh2MpYBzL7c1a8gaNnfIjs0goUTO
	AoxEzofyX2z8ZPOgFCjg5ZtP9jTNNKl02BBfpFfr8g==
X-ME-Sender: <xms:LQePaIHFdLXJwkj6Atr14Gf6jvooTC51JlpsrRZ52o6hQDJHreeAcQ>
    <xme:LQePaBj0XlE5-9esZ4ACuvQwwMMdV_vKcrPBObZttHaSD_rfgT61__lwL01Padt7X
    xT9U3oVIAPcixoGAg>
X-ME-Received: <xmr:LQePaD_HtfJWOWyBFV4HQ5AFCH-r1t9iMACGz-0fPStTHgFQpWj6ZP-aYXTnTS5wk2cqijTGg3kwemxi8fLSZtSjTQ9hIJqVMYFoNWI>
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
X-ME-Proxy: <xmx:LQePaIrtQuKEsQXqls6Pf1Zy8-bq-YHLiGnPwrYDknTpfALEDooQ1A>
    <xmx:LQePaC8LubwHbzqYecf4LR0TjpW5Qv-1rT7uIi78rR1xYO4oYnCu1Q>
    <xmx:LQePaMWvvoeT0JoY42cBVz6zd14edEfe3HTDYIfwAatxtbMDL6ZUuA>
    <xmx:LQePaIDMia-_wfCg9IyDF1CHP3SvS0P1FKxp21ADJs0Aeqt8s9_BQQ>
    <xmx:LQePaKqVYz8P0IMRpZb7Qh3ofLFY0Ppl2yX33ryFDl3s6DcAzvg3cGL_>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Aug 2025 02:52:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v4 3/7] string-list: unify string_list_split* functions
Date: Sat,  2 Aug 2025 23:52:19 -0700
Message-ID: <20250803065223.3325111-4-gitster@pobox.com>
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

Thanks to the previous step, the only difference between these two
related functions is that string_list_split() works on a string
without modifying its contents (i.e. taking "const char *") and the
resulting pieces of strings are their own copies in a string list,
while string_list_split_in_place() works on a mutable string and the
resulting pieces of strings come from the original string.

Consolidate their implementations into a single helper function, and
make them a thin wrapper around it.  We can later add an extra flags
parameter to extend both of these functions by updating only the
internal helper function.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 string-list.c | 96 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 56 insertions(+), 40 deletions(-)

diff --git a/string-list.c b/string-list.c
index 2284a009cb..65b6ceb259 100644
--- a/string-list.c
+++ b/string-list.c
@@ -276,55 +276,71 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 	list->nr--;
 }
 
-int string_list_split(struct string_list *list, const char *string,
-		      const char *delim, int maxsplit)
+/*
+ * append a substring [p..end] to list; return number of things it
+ * appended to the list.
+ */
+static int append_one(struct string_list *list,
+		      const char *p, const char *end,
+		      int in_place)
+{
+	if (!end)
+		end = p + strlen(p);
+
+	if (in_place) {
+		*((char *)end) = '\0';
+		string_list_append(list, p);
+	} else {
+		string_list_append_nodup(list, xmemdupz(p, end - p));
+	}
+	return 1;
+}
+
+/*
+ * Unfortunately this cannot become a public interface, as _in_place()
+ * wants to have "const char *string" while the other variant wants to
+ * have "char *string" for type safety.
+ *
+ * This accepts "const char *string" to allow both wrappers to use it;
+ * it internally casts away the constness when in_place is true by
+ * taking advantage of strpbrk() that takes a "const char *" arg and
+ * returns "char *" pointer into that const string.  Yucky but works ;-).
+ */
+static int split_string(struct string_list *list, const char *string, const char *delim,
+			int maxsplit, int in_place)
 {
 	int count = 0;
-	const char *p = string, *end;
+	const char *p = string;
+
+	if (in_place && list->strdup_strings)
+		BUG("string_list_split_in_place() called with strdup_strings");
+	else if (!in_place && !list->strdup_strings)
+		BUG("string_list_split() called without strdup_strings");
 
-	if (!list->strdup_strings)
-		BUG("internal error in string_list_split(): "
-		    "list->strdup_strings must be set");
 	for (;;) {
-		count++;
-		if (maxsplit >= 0 && count > maxsplit) {
-			string_list_append(list, p);
-			return count;
-		}
-		end = strpbrk(p, delim);
-		if (end) {
-			string_list_append_nodup(list, xmemdupz(p, end - p));
-			p = end + 1;
-		} else {
-			string_list_append(list, p);
+		char *end;
+
+		if (0 <= maxsplit && maxsplit <= count)
+			end = NULL;
+		else
+			end = strpbrk(p, delim);
+
+		count += append_one(list, p, end, in_place);
+
+		if (!end)
 			return count;
-		}
+		p = end + 1;
 	}
 }
 
+int string_list_split(struct string_list *list, const char *string,
+		      const char *delim, int maxsplit)
+{
+	return split_string(list, string, delim, maxsplit, 0);
+}
+
 int string_list_split_in_place(struct string_list *list, char *string,
 			       const char *delim, int maxsplit)
 {
-	int count = 0;
-	char *p = string, *end;
-
-	if (list->strdup_strings)
-		BUG("internal error in string_list_split_in_place(): "
-		    "list->strdup_strings must not be set");
-	for (;;) {
-		count++;
-		if (maxsplit >= 0 && count > maxsplit) {
-			string_list_append(list, p);
-			return count;
-		}
-		end = strpbrk(p, delim);
-		if (end) {
-			*end = '\0';
-			string_list_append(list, p);
-			p = end + 1;
-		} else {
-			string_list_append(list, p);
-			return count;
-		}
-	}
+	return split_string(list, string, delim, maxsplit, 1);
 }
-- 
2.50.1-633-g69dfdd50af

