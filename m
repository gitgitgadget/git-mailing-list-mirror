Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C1C1865E5
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731321535; cv=none; b=BEc657u1o/xslr3kVjS/SjjnC5ndPdM6XqMcMqe33tNLcfGgBDED9lg2pKOvuYRWLY6TJGkVGLMVPsXg6HWwGZTPSLbE9oIActLAVUyj3KEVcz8LvjgUABUCJBNjRZjCvcL+XBgk5IgiPWE3WSm/FdcZp3rY3k7E0xELQEgmxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731321535; c=relaxed/simple;
	bh=ZX88ZI+VMC+xQ71eZMVlvY0QbRqdleoyhCHBZ82fdi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J8JWes43rYuPDioO3VcO6Z7wyKneQHELGe+WPu4kJFb5+0hcwqPMONp2j+KXHrd9wMspDDqmyO7g+2+2vvofJx3QNwUgybOmGct+zSgGsnH7rQ0y0FJOwsf7ivaCZZCZaYgvn4seQAb2hwBblK0OGLywJ2gvQ8XQwxDDW8gl8iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Dg7ZBNpN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UUcSdDMe; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Dg7ZBNpN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UUcSdDMe"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0DBF31140114;
	Mon, 11 Nov 2024 05:38:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 11 Nov 2024 05:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731321533;
	 x=1731407933; bh=zXcIttR+sShVfG/aI5oCQJZrOy86bcjQU00EI7nkT1o=; b=
	Dg7ZBNpNTMJiTOCnDOFwpzQEE3uNaiVi4mpii+B2f2m24OptEf/ioz05dIU+kdlQ
	7u1S0QfIqFQlmtfetxdJgzyT/3fTGCn4j8noxMeeaYm8TxSjzGHlTo/+z8jgO8Su
	msKRE72/JzxW7wjQo9eHr/SW1FaD9qk6TsPMsemTJ05jMj298jxLVl9mn/Ql6a+c
	ESXZH38grF2AryOiwJa3wosPUBecqhkFGRbgMkDgxNQWMje6jwi8NFeASz74kibY
	bFNJHXQujuR//H2KZ/oXMtKTAKEsa1r6Ln5B7IARGRIoeLfDn9G5ZucQtudl4QKD
	ETZK8EN4GEySGM5xs3RWDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731321533; x=
	1731407933; bh=zXcIttR+sShVfG/aI5oCQJZrOy86bcjQU00EI7nkT1o=; b=U
	UcSdDMeB310SEVjf1/+1EvtpAXDKsS4QiRBcE/2GlBezE4f7JuJdpEmRcIM5Walt
	G6HP2bFyKbyJln4bsguFwNkC2S1nHnvKVwHe7dxElT3Q0WfUm9Chk8hyp4EuyY4W
	CgtjsqvOJUqWWbmkc/rfKiAy8BHVElDFdcaFJFVjrMLeEMkz9vURWOErwWW+sJSp
	r2kNXMZTo8Gs1SRy4J6HxXw8lbbzOnF7UFsLpNJ99VxZnpLCPKuFT1Wjba9WtQ1J
	6B5SKtzv2yL1JMGJhjb0ZTjFwdsSOVQfAuq9Kv+O8DayFnVvUn6X7SXP63fyyuVe
	i6OApr4dDyKbcLQUpgD+w==
X-ME-Sender: <xms:vN4xZ54glSmLhlKwkM9KB02ODuhz9V-rvWO6_hkPIgS9I2LrRL_3vQ>
    <xme:vN4xZ27zag306h0PPLAeko9pN1Fz10n36KgS3qbdLMdaVdjfHhzKUZpZtwLrymUMi
    gTeVuGYNJxurQRtdw>
X-ME-Received: <xmr:vN4xZwfSBpJXFdiTsmfQ3tKGLAiFYBy6WLb2_EfTR98xqmjJC0eDNF_vLhik9twSQIVlLtpITDTSheFvXDYdfciGfXgoUA21jwZNZd2x1roV1-p6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehrjhhushhtohesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:vN4xZyIj8UL-eEDOAJFsOuQvun1i_7kzUhLjyeqJCG-S-Jg63DU2-Q>
    <xmx:vN4xZ9JF2EEgkTaLZXlDYHaVXJcs8z5WsuTmMvjYT83cg-7t0vv74Q>
    <xmx:vN4xZ7wCT1JmuP_wgkuua4gbk6gYWFMqlafkzuvrI5chzfSmc5KJWw>
    <xmx:vN4xZ5KjBgi6G_NukEiMxgWhH9pfz_BbFqa9IKIG8CLT-fwZhgqdOA>
    <xmx:vd4xZ0V7YxLfBLpc41xln7fR2gslQXcNLY20gNnyInnLGGYDpVevJQE9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 05:38:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id dc943081 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 11 Nov 2024 10:38:18 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 11 Nov 2024 11:38:36 +0100
Subject: [PATCH v2 07/27] bisect: fix various cases where we leak commit
 list items
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-b4-pks-leak-fixes-pt10-v2-7-6154bf91f0b0@pks.im>
References: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
In-Reply-To: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>
To: git@vger.kernel.org
Cc: =?utf-8?q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
X-Mailer: b4 0.14.2

There are various cases where we leak commit list items because we
evict items from the list, but don't free them. Plug those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c                    | 35 +++++++++++++++++++++++++++--------
 t/t6030-bisect-porcelain.sh |  1 +
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 12efcff2e3c1836ab6e63d36e4d42269fbcaeaab..0e804086cbf6a02d42bda98b62fb86daf099b82d 100644
--- a/bisect.c
+++ b/bisect.c
@@ -440,11 +440,19 @@ void find_bisection(struct commit_list **commit_list, int *reaches,
 			free_commit_list(list->next);
 			best = list;
 			best->next = NULL;
+		} else {
+			for (p = list; p != best; p = next) {
+				next = p->next;
+				free(p);
+			}
 		}
 		*reaches = weight(best);
+	} else {
+		free_commit_list(*commit_list);
 	}
-	free(weights);
 	*commit_list = best;
+
+	free(weights);
 	clear_commit_weight(&commit_weight);
 }
 
@@ -557,8 +565,11 @@ struct commit_list *filter_skipped(struct commit_list *list,
 			tried = &list->next;
 		} else {
 			if (!show_all) {
-				if (!skipped_first || !*skipped_first)
+				if (!skipped_first || !*skipped_first) {
+					free_commit_list(next);
+					free_commit_list(filtered);
 					return list;
+				}
 			} else if (skipped_first && !*skipped_first) {
 				/* This means we know it's not skipped */
 				*skipped_first = -1;
@@ -614,7 +625,7 @@ static int sqrti(int val)
 
 static struct commit_list *skip_away(struct commit_list *list, int count)
 {
-	struct commit_list *cur, *previous;
+	struct commit_list *cur, *previous, *result = list;
 	int prn, index, i;
 
 	prn = get_prn(count);
@@ -626,15 +637,23 @@ static struct commit_list *skip_away(struct commit_list *list, int count)
 	for (i = 0; cur; cur = cur->next, i++) {
 		if (i == index) {
 			if (!oideq(&cur->item->object.oid, current_bad_oid))
-				return cur;
-			if (previous)
-				return previous;
-			return list;
+				result = cur;
+			else if (previous)
+				result = previous;
+			else
+				result = list;
+			break;
 		}
 		previous = cur;
 	}
 
-	return list;
+	for (cur = list; cur != result; ) {
+		struct commit_list *next = cur->next;
+		free(cur);
+		cur = next;
+	}
+
+	return result;
 }
 
 static struct commit_list *managed_skipped(struct commit_list *list,
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index cdc02706404b34b17b29692d72d97fab7eba58b1..310affadebed321fcc93ee5bd785abf4ca013cc1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -9,6 +9,7 @@ exec </dev/null
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 add_line_into_file()

-- 
2.47.0.229.g8f8d6eee53.dirty

