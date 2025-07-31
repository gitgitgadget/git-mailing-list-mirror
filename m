Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D24327F006
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754001978; cv=none; b=BVvIUVHCIWObh0SSvAgWMTLe57Bu8l1k4CE5tSiavsyUB2M2NweEuRwApqaQIRhfLV0Hd8nHoQLb41RoabFmIMbSWKEsUWvZTbyJIZzXPv/3NTWeus8HfCpqgo3w99sr8Pl0z8lL5qG3UegZypb0ycLhiaKHIZ5Z8A2qjYCDKbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754001978; c=relaxed/simple;
	bh=iAtvtro7QERZvydeKAfu8pD77qffB1J1hJgJz0/Z3yw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B6Ln/JXgvC1JfXEFMaQFTpQPeo87FU+Jkm2VoAUQov/r86Gzf6UYSXLEMVbtKyjwJBGHuHO7l8o5C6qjjromQ35Xea9IXrNaUvmqL+qusqps/0UjLEOwRyVu9OQCqFtz+hE47o6BQGosmZrgCn0n6m5cu7rNWv84aRTcO+UPBi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QdVZk2rk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MheGz9+g; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QdVZk2rk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MheGz9+g"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F9A2EC134A;
	Thu, 31 Jul 2025 18:46:13 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 31 Jul 2025 18:46:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754001973; x=
	1754088373; bh=rSaKJGxkJ0IOkvKObDHhwn9zcEOxU+/xfbhV6e0VcRI=; b=Q
	dVZk2rksyZ9ExRLoVMRXsiBrU1BW705anGo+Fry3m6CollruZ/Qv2OeWghtclF8S
	t3+XEf4LSSQGlA3tXBWhn5uXBiJox5WVMhKLdL37Ot2OBK1l/QM06BD/tMH0xQjo
	OtPOAke3Glmi6lHw65cCwMbiEdgW5jYQVYFMAxdOGEsEHZzqmsMPVxLChxqc8SSQ
	SykH2Qf0OtPrkRyapewIJAUi0p3ktKd0p2mzdC3a2IZtXbyLhAUs0X6VTsL3mAtF
	17q5XU5cHdYcrYzFglmS1ajh7z8cPPDzdJTXRv/iISnEVbZFvNk3Wn8TyTwhCGK7
	C63axnyiEXRfadA25LTQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754001973; x=1754088373; bh=rSaKJGxkJ0IOkvKObDHhwn9zcEOx
	U+/xfbhV6e0VcRI=; b=MheGz9+g0KiGV+7P09KJK1whrr7+Gu5F0vXxLorzAwwk
	/Mi2XVe6iZ430m3737rqp/A0F7AuNGln8TGDc0DgkpIAQTXgn4PbHisScr43sTF4
	uH9br/y+Y8P3/EU3+T9cpMwaNrlIEihpPEC/Vn/SjOsQpF+r8sEg81LovuJ0t4nT
	njWX64ApEj60In1J9/S7l+n5m53zARG+KOouMTZ6KtGaNqqz0gLKkpdWXamx2Nj5
	7JATPGxe46OluVOsCJxGM3EQgnfWbsnPDieRkfT+8RgVpQVwfbLMTptwmY6JeAZV
	7WW2OLn9l/NpYrASxCfYzRxbJfD1P+rb1PrIGtD0YA==
X-ME-Sender: <xms:NfKLaKSTd1asKBmNKnzrZ7tU2Qrjnk75lrJZPseuVXpYR0bM6-56IQ>
    <xme:NfKLaP8qCMe1vVi1w8GNX5JJ39doh86LGDkjOC5LLIhE5Og2XxcQqi9Kp8aOBeK8-
    uh_og3IYv-BF4IuiA>
X-ME-Received: <xmr:NfKLaJqxCQLQltv2o0yW-6oBj0O4nAThydoQ5g8Mj6-XelbJACiIJFV0vGH3CnksmdYGEQNOa2Sfq2GTBOYhRJ04MrJWHr7FGSSk8CM>
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
X-ME-Proxy: <xmx:NfKLaEl4b8PawWdcTx4Pv37TafVaK0yyvsioCrcIKAPP1OV1J1K_4Q>
    <xmx:NfKLaIK4ayseHTnCe8VfFmt3B-oiZecx8ySXsjGHe9JrYrXeFr04lA>
    <xmx:NfKLaBwOD_QqbSAXBkUFKUusVxbTcdBBEanRWTFkNVSzi3e1RztbwQ>
    <xmx:NfKLaIshuGzCg0gl2vL8FEYLmM9Lsc-R8rlEFsuUvBKpNZGIDOJkyw>
    <xmx:NfKLaE0xTw41WgImuqRZz-mWfkn3rWsyxokNYPhzuuAQh5xJqPrqGZdi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 31 Jul 2025 18:46:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 3/7] string-list: unify string_list_split* functions
Date: Thu, 31 Jul 2025 15:46:02 -0700
Message-ID: <20250731224607.3942417-4-gitster@pobox.com>
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
2.50.1-618-g45d530d26b

