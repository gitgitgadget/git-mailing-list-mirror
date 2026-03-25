Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115B30F93D
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468561; cv=pass; b=ICrVNIsKjySW13HImh9CI2JT/hC07yp7fggmdZ830vYRE7eL3sRI0ePaxFYxNHnO/FnmeM/pXadBvrS+wQzskP5J9hHM7kMKq6ZTRtECA4Gpb+dNmLmbNhFm27D6r6zS/aHZDSbWuYGUWq4Qk330Ym7B0dDu8IwVRjOPfmNZZDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468561; c=relaxed/simple;
	bh=Eeu7QNb84T8xyRj1OvjcOy/AVWyPM/ndLVYhYCyAI4s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTe3/u/bRySXHMxuBVe7j+alG8tcM1QTvWJkb1Orkdnj1RqxI+gtxlv0jkexsZA0Rx6t2kndDszpw2LNwcDnRwYu42rVlRNVMIa04nEYxF0d/+Vm4dymT0DCMGOz9X63gXgD8QOcTTQEsbZbrNy7RcjqESBGYas/TWNVUfwoKSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=BhcwRnKb; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="BhcwRnKb"
ARC-Seal: i=1; a=rsa-sha256; t=1774468547; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XcHHR2F8h1vbRJrH4MW+B8T1aOrpGQjirAJBGabiYitwj1GzHyZ53nnrMnjT4SRchQMlWmBFpoP0uMZD7LD6A67NSjHOqFpVsOxTw5NltOJmTHrOdWZGyc5EXnA/dpN/lOZjzF3VvPEbIpc2hmhlXqyIfRV/4SkVt0KGlefDlXw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468547; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=i+P3dLtrBajoU0SNIMmpMUwCwQlG0gMlpfddi0sq2DU=; 
	b=hYdZYQ12Ort1S5VwU0uYWCL5nwzDBHscoQf9dRhy/y7Ow49PDfMSK2DwcDVsQNMQxTAtoZjsnCT658IuJU9x3UsG1t43/X8irgw7VZCL6ozTj2JD5IsVfP19qqQ7vjRfMMqyFoRtPfxhmTT94Mdg03MEniXfs/w4b1TsDiSd/f8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468547;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=i+P3dLtrBajoU0SNIMmpMUwCwQlG0gMlpfddi0sq2DU=;
	b=BhcwRnKbh+w5DnU/vGwGuFwd4fwRnL9PKgrBuCcaUOXZZjiDJZ21Jvdz6U5xjddD
	42b+WFAEWR6MBKInWMN+Kgv8ojAnPhGC4eyFfWye+oIvgq97cai4aItcesVQHurvvrY
	s+ws17I78LrQEo3eQ36mXi0ndKs2Q7n/gYRvkSrs=
Received: by mx.zohomail.com with SMTPS id 1774468546424276.2740872389321;
	Wed, 25 Mar 2026 12:55:46 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 04/12] hook: rename cb_data_free/alloc -> hook_data_free/alloc
Date: Wed, 25 Mar 2026 21:54:55 +0200
Message-ID: <20260325195503.1139418-5-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Rename the hook callback function types to use the hook prefix.

This is a style fix with no logic changes.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c |  4 ++--
 hook.h | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/hook.c b/hook.c
index 935237fc1d..4a0db5cfeb 100644
--- a/hook.c
+++ b/hook.c
@@ -52,7 +52,7 @@ const char *find_hook(struct repository *r, const char *name)
 	return path.buf;
 }
 
-static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
+static void hook_clear(struct hook *h, hook_data_free_fn cb_data_free)
 {
 	if (!h)
 		return;
@@ -70,7 +70,7 @@ static void hook_clear(struct hook *h, cb_data_free_fn cb_data_free)
 	free(h);
 }
 
-void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free)
+void hook_list_clear(struct string_list *hooks, hook_data_free_fn cb_data_free)
 {
 	struct string_list_item *item;
 
diff --git a/hook.h b/hook.h
index 1c447cbb6b..965794a5b8 100644
--- a/hook.h
+++ b/hook.h
@@ -43,8 +43,8 @@ struct hook {
 	void *feed_pipe_cb_data;
 };
 
-typedef void (*cb_data_free_fn)(void *data);
-typedef void *(*cb_data_alloc_fn)(void *init_ctx);
+typedef void (*hook_data_free_fn)(void *data);
+typedef void *(*hook_data_alloc_fn)(void *init_ctx);
 
 struct run_hooks_opt {
 	/* Environment vars to be set for each hook */
@@ -131,14 +131,14 @@ struct run_hooks_opt {
 	 *
 	 * The `feed_pipe_ctx` pointer can be used to pass initialization data.
 	 */
-	cb_data_alloc_fn feed_pipe_cb_data_alloc;
+	hook_data_alloc_fn feed_pipe_cb_data_alloc;
 
 	/**
 	 * Called to free the memory initialized by `feed_pipe_cb_data_alloc`.
 	 *
 	 * Must always be provided when `feed_pipe_cb_data_alloc` is provided.
 	 */
-	cb_data_free_fn feed_pipe_cb_data_free;
+	hook_data_free_fn feed_pipe_cb_data_free;
 };
 
 #define RUN_HOOKS_OPT_INIT { \
@@ -188,7 +188,7 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
  * Frees the memory allocated for the hook list, including the `struct hook`
  * items and their internal state.
  */
-void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
+void hook_list_clear(struct string_list *hooks, hook_data_free_fn cb_data_free);
 
 /**
  * Frees the hook configuration cache stored in `struct repository`.
-- 
2.52.0.732.gb351b5166d.dirty

