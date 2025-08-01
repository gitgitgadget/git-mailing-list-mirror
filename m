Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B22E22A4F8
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754085872; cv=none; b=duWfyPJwxA10gSc14q0GQsf+1dN6NDSZQwbTn/kXiKsm3wE02pBRTuPvk96PKSxZhtwoc0569kCPb5o633eS/JQTzThT3amvN/F2XIT6Pd80zdkE0fxMGCQyFlzBgNKDr9+zgXk07PNEEw5kKR2YM4vUeIkcTuoNcvCG0Qq3KD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754085872; c=relaxed/simple;
	bh=v61pbrkWDXsTRDeR9xB27rWEsdkv46lE9xyEbTS48Mk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LlTUEWpsQKkjkWOOR9npDhHdKjsGdFAtN9QShkZvYx79rDQmoNQEHLpkF2k/JiQYuuR/jEzfr2iWnHDaz9noodMqk2Ewh8TWnJp+wm0rNlrtfZnKvEPS2ZqLCcgzYOhBmpLb/s/l+qcpd/oRb5dZ2RQ2K2o2wlOHYlYBQmoWfdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TZJ/E5p9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gWL/BVdr; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZJ/E5p9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gWL/BVdr"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 58917140026F;
	Fri,  1 Aug 2025 18:04:30 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 01 Aug 2025 18:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1754085870; x=
	1754172270; bh=4ekq5MeQxwVLHyGPSjhbxRafORLV+y4FVXQOM+2y47Q=; b=T
	ZJ/E5p9Vs98FtciT0SB1AELFKJeyPTIv2WmLsY6RX03Y/SXMRXjCU4q+oO2R1Oxp
	IVgsuaAiltBqvFa2Q4iXRD25R+zNxWhhS5ncraIMWxO4g0kC5ruQ7HFEjE7AHYG1
	m0JZAJ/IsonqRBw104MqEDJsJgR5J2DgZyfMgKOskFlt9wkOlAPdt67wK/B7SOiB
	QQRtHS6hNhjZbyWyzWnT/Fs8N3vEgB15uJneQ9/G+ysp5hFe2N7voMYnUpbmnXU7
	LAFZSqikk+zsHP0RAAc1DBE2XMIAzF8n154Cb1H5Vr+IVKfJV0IK4hq7s6FGIvgs
	6ixbFMTLttbQly+Qg+Lxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1754085870; x=1754172270; bh=4ekq5MeQxwVLHyGPSjhbxRafORLV
	+y4FVXQOM+2y47Q=; b=gWL/BVdrwp+OYg8lmJIdKhfNQU4WQiZLbkq70gN0rBQF
	jL7hHmr1Q3DtiWtoC12/p7Z/mLxzwmXvQhP4nzzYlu35l8055kXf+ylZHQkxoaxy
	iKfhAP/ujn8EmEOnMhn5UVRdVltUycYCS8HcZP6ILh+M1sUs6ZXhDLrIkTNxeZwQ
	t+6egHU4rsmhP4OybaQK2w62CKxOKUDhM3vehVgEjs/JxOVAHJeSKrL5eTMGK6XV
	zBHQaATAjnm8HMiraevKtMKRbuqFJiYvYwBEFh3+AqkIgnfJYsdd6yyC4LwMP9KY
	nuU6GQf86nqbXeHnsf2v9Cd6mzMQcnOes1my/l5Drg==
X-ME-Sender: <xms:7jmNaE29nR-pYR-Wfxl-B0wHz9-4qVn0-n4A0LXg_w9jnaSKly76tA>
    <xme:7jmNaPS9gavqFegrJRmHm3VrAXMI1nmljZ5pvYHpojQxSFzECEnu1eFCSQHFhFJpn
    7dEMLonvoN1bJ4aiQ>
X-ME-Received: <xmr:7jmNaOthsXOzSSWB6elMBgSG_RBmJ1FUpMioJiGpNK25TVt9nqLg892WfBSLSLlMc9gWaKN7b7piNmM1qv6NNt4ov7YpRcWwODfp2PE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdegkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekredtre
    dttdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepleevieefieeuffeugefhveeugefgfe
    evvdefleevuedvfedvudefkeehtdeftdegnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:7jmNaMZQ6phix2glt_cZg6P71MN8HmlkTf5vHSScvr3joAw2GrCjKw>
    <xmx:7jmNaLszdmizF88thUZ_tvl24OohEnwX25ASkrLhnF9CxfjyH-xd8w>
    <xmx:7jmNaGG7xmIarSya6JUoTJov3NZN96iRD6Tu6FB9Tp8JNMtwTA_DbA>
    <xmx:7jmNaOzlNCiuMHREOaFxC1SvKHyJayUxxCfRODaEUCVurQ5BNnAJIw>
    <xmx:7jmNaHZjQFHnZBWJt9-q3SCzf7nN1iCJBKMym_nWmlwO7WKbQq_5QqIY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Aug 2025 18:04:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v3 3/7] string-list: unify string_list_split* functions
Date: Fri,  1 Aug 2025 15:04:19 -0700
Message-ID: <20250801220423.1230969-4-gitster@pobox.com>
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
2.50.1-633-g85c5610de3

