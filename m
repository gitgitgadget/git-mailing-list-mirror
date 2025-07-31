Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3262E567
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753943999; cv=none; b=PmHZquAqC+2Un049MzVdkx2FW18aEA8AIjWE1iUTjLoP+0HmXJ+kqviUWUMSMjtlhiNvsp3Href8viHwSzOgCq+15T08K4UwaGIwIP6wAJG80Q6l15od4YFgz7cyh0fDrQbY5JqYf7hhVCCZb6Pqe4rDzXQrhieHHRoxxxXjlIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753943999; c=relaxed/simple;
	bh=GVyU1cqTLUuno01vO+oGiJdbb670zeiYd8ukqKc09Sg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WcyqP3FM6dFFNUYDh3+1nkwrxQwIbA0wWoJhhMfNrc7GqKRQhW7JxuFH09hsDxMuriy6t/8IA0PPb23lR/t8N/cTtG3/2hv+5G2cIevbE5WuU8zPMcV0NzWHlmY3jJFDgjMf2LL+PhU0CuHTmcCc72hlGzXhcSAQXSk7B4cbEMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=a89OhYDk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Sbo2TAKS; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="a89OhYDk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Sbo2TAKS"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E74D47A097E;
	Thu, 31 Jul 2025 02:39:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 31 Jul 2025 02:39:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1753943996; x=
	1754030396; bh=1UIHyI/D/+kLovWiP3Z8oJLsf/XDE8nsSfcDoioV2QI=; b=a
	89OhYDkNMZ9FTi9IH+g212RRbwZHJ+0QdIddU5XUobLPg7QoYKNm2T667RVVZ3pM
	CKAzpNo6d6mpPMpAzpnmf1BJXc6umMJTIiS2IOyyvPg6Cs+mRbxT9ja5lr/hkFhK
	JjHjy56NpeLtyKcjhFrxIttg69tu6vOpKpak/YAaLpdvPpGiCsEC+iTImHo2WuLC
	IBo8+mSpYNTiNfBwHoMExmBnjv1X6NMpJjek+rwpeDjh8kCrpOa1z0LVz4/zr0xA
	hN5rAm/L1RJVNZ4b4DTU0F3YoYM8HAbzMxPiElkqGHKNzq/20X6soy+h6f4aEL5S
	oaE6DOLXK4CzPBflsyqZw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1753943996; x=1754030396; bh=1UIHyI/D/+kLovWiP3Z8oJLsf/XD
	E8nsSfcDoioV2QI=; b=Sbo2TAKSqx1huukM5UWnr7zXmAJ6BWrH2YweTWlSwFTu
	54owfjpcAsoXv0mU+aBlrRgKwAbFZxs9C+4qiaTgAOpWt+kebm7zKwLtwmKSEWdh
	SkcHLCRgnSbueTWmB6aM5vFMkIYJQ5o8lHLFN/JBkzt4/GF2IcR11bd2Eu0/1gJR
	OkTmTckDdglufF6NAbZdjw3nq7jFfoZFSdAE/MNONP3tZ5KqP6k2bqKmZg66RLCB
	LzV2Zh4gXVxzfi1n3iWCgA2q8yKeT/QTSxyYobuX6QOKY6RgFtWY0cJzS5rofj0N
	tVJpKhjl8eYINP+8ay94rBzrQl9YP2XPuVxd/1yh4g==
X-ME-Sender: <xms:vA-LaOSnYKR4uWxcRpKOwxHbX3xW9LRTy2-EbfVm-B6QYVJ9uxJbeQ>
    <xme:vA-LaD9Kd4ZVa9Pc6s30WjFyYwr-e8ZnYBIJNBm6T3d4tiFOzjHP7xKrGvrwjr5CV
    TYcFypfIyX6uyHUFw>
X-ME-Received: <xmr:vA-LaNp_bamunsiZ8HJ1AWfgDMbyCTfRv69SN4cbHtlLixNxFsuDPqyn3xHxUuRX_Q06BVAfCqmJMxkaFDkbrL-kYIHbI_WFjh5VQ2o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutddtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:vA-LaInJO1ffw8K-Q4VXWt9cie3C3je6lYUJ1JXZ_us3Hwu4ZAFtoQ>
    <xmx:vA-LaMLQaREaKP2FZIKeQhGeWKNGhf0EeV0ICvozamkeI0OQ8IdROA>
    <xmx:vA-LaFzhCAYZYqClHvCd7naeeHSNtQsQHzcdZA1SFA9GhVdD2KyJEg>
    <xmx:vA-LaMuT4sYB06CZwFOaCvoc4ttzyAYQtK9U1yOaWMJg1pJA1z6iEQ>
    <xmx:vA-LaI1ll8UIw-l6FcniWdFJYyxxeeYSbiPuCeqrEaDCzbI3vKkzPv7Q>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 02:39:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 3/5] string-list: unify string_list_split* functions
Date: Wed, 30 Jul 2025 23:39:47 -0700
Message-ID: <20250731063949.1601669-4-gitster@pobox.com>
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
 string-list.c | 90 +++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 39 deletions(-)

diff --git a/string-list.c b/string-list.c
index 2284a009cb..893e82be49 100644
--- a/string-list.c
+++ b/string-list.c
@@ -276,55 +276,67 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 	list->nr--;
 }
 
-int string_list_split(struct string_list *list, const char *string,
-		      const char *delim, int maxsplit)
+static void append_one(struct string_list *list,
+		       const char *p, const char *end,
+		       int in_place)
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
+		char *end;
+
 		count++;
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
+		if (maxsplit >= 0 && count > maxsplit)
+			end = NULL;
+		else
+			end = strpbrk(p, delim);
+
+		append_one(list, p, end, in_place);
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
2.50.1-612-g4756c59422

