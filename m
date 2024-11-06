Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE765202F6A
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730905849; cv=none; b=niSsNygvvSV8lNvxKY6ZKdP0a88cvLHeEtSp0WwAg4Bz2ictZcMO+22Q2keWdWEuq1s3pZyaP4O8uiasyNWLmAnmGoduZ3scnzsmhK7+Ej8g2eHrudjd8r0gtEoDNYBKfdZugEKVg24II+3eVibmmkSRJaIVA2PjIzeZYB0FRSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730905849; c=relaxed/simple;
	bh=o1qeqW/xR9okwKbqO5Y8U0+N+qSuCZqTepFL/3BiEEU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OwTY8Q+UKzjSlSvKQ/XyKCDk4Ra13RkZmFjAEGgjxfM8n8pr3StBHP9OQYkWnDbYns8t5O9u6fxNIPMO6z5vzDnWgD+MtH7fWdL7T0l6dlU8aJF1IAcIg9lpfH9OgqwoTmAT+I/mD/5p21xPPa0yUASQ/vPC/jA44ur4PcRlxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UE5H9Vke; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GTWwF+HG; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UE5H9Vke";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GTWwF+HG"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D4361140178
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 10:10:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 06 Nov 2024 10:10:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730905847; x=1730992247; bh=bu1+qmPUxs
	N0Uyawv4aWKwqo7z7aEpNjcU5R37LmFpg=; b=UE5H9Vkebot6nJxbJWR8yzpqcj
	p/LBahFZZ4YSjnKZcKkikuUkYGOqF7KzkmGlQCvVWnPLGpfxf5+ZVmEd6bEHjcXo
	KpYxwYnorFi8Mxlv7pFdVR0WVLRFLW/rWN0B5Bd0/9y2mANtEkhmtBMazegYzPLN
	nomA4Vrvq8nyFevJggVRCb/gZy2kk1mq6f5E69xT8iIvGQOaoKJiPW+lXyfRTRty
	HXzDpc8dnfnqdrNp7Fr3fp2fcg8PpnnzgJmFLi3vII/FFOkg0Wg4kjU2hTxEDIgx
	GmByvJ8Cf5kX6Irqb5U/JwSUNjnBze/GlIBcfFIP5EQ7+YtkRqbS/Tfg83Iw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730905847; x=1730992247; bh=bu1+qmPUxsN0Uyawv4aWKwqo7z7aEpNjcU5
	R37LmFpg=; b=GTWwF+HGwt+vLmwzXRuTsmOvuzuShkkETAUAiQZZptzkw/yO4Qg
	4weaiDtwE5dq+R8jVwCQpVbVv0GCkg2CM7dE+uQGVBmQkmu0bPUb80N9Xfqwb4f5
	G5JvQoCn6ImfqlZFQuGctBeP5m/7ZoxAuDxBRwUDYpmwTVsG+8SPBrFihHRSzCWg
	MIzc3BcF+7NYnDMi90Ta1zJN3iK0CCFk+pLqk75Lo8RKQKTXWO3r6BflW/wzH/os
	EVxr5fHO2yLYp9NPMi+KlvDSnx9FLbGzv0w7YACnfZ1HUXbRjqMOBlYO0eTXbH1h
	u0E1muhYtDhJDoVy/yrJ0aXR28inyr0uBGQ==
X-ME-Sender: <xms:94YrZ9F_dUpI_XAGcZ_Bo71B3ahXobY2tlelONcgVmUowmdutauBUg>
    <xme:94YrZyVOf59epsidjRomzRoOR4B1l9njOpVSwnNKVlYTedcNZG8rGthWwSccXTAuZ
    tQTK7Yw6O6SgO63Rg>
X-ME-Received: <xmr:94YrZ_Lb5WB2ksNUEcwGLvFfABR3P5yF6NqQaKjP0e2oZj80HIWmerYyazEpS6eZCeJI4qdVOo12gpiHMbyFLlRfWMsXrkQoakvPpSSaIB0vMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrtddvgdejudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukf
    hfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgr
    rhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpeehkeeffeeggedvge
    dvfeefheettddtffejuefflefggfehfeelffeljedvfeehieenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprh
    gtphhtthhopedupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:94YrZzF-damysWl0rhczE_VmJ0UvUDAWCGiuTZc1nFg8JMqfgOQCwg>
    <xmx:94YrZzWF1sWgT3B_Ro27MFhrFWngc5U0PLvER4oOA98NQiA9E9qGtg>
    <xmx:94YrZ-PxxjtOYoGwmagu1bnncGFjUEyofsmYhNr_wgQOXp-OiKKQrg>
    <xmx:94YrZy2B6HoL939M8ppF7zsdNqUTmVvMhvO0yK9X_sktkW5fWZtrjw>
    <xmx:94YrZ6e-8Zgy6s30hYybEyk4s2fxS5Tt-w6EklpvnbLHh54Akb__l_sp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 6 Nov 2024 10:10:46 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e3cbcced (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 6 Nov 2024 15:10:22 +0000 (UTC)
Date: Wed, 6 Nov 2024 16:10:39 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/26] bisect: fix various cases where we leak commit list
 items
Message-ID: <4f8f2aecf05c904f6f68f221e01e63395c7877ad.1730901926.git.ps@pks.im>
References: <cover.1730901926.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730901926.git.ps@pks.im>

There are various cases where we leak commit list items because we
evict items from the list, but don't free them. Plug those.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 bisect.c                    | 35 +++++++++++++++++++++++++++--------
 t/t6030-bisect-porcelain.sh |  1 +
 2 files changed, 28 insertions(+), 8 deletions(-)

diff --git a/bisect.c b/bisect.c
index 12efcff2e3c..518be70aa3f 100644
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
+				result =  list;
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
index cdc02706404..310affadebe 100755
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

