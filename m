Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CAC377004
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007589; cv=pass; b=s3nKTtv80EqOu6vznPFY5Yju2MSLcZaWenJn1bFIsCa4/1TX7q11GBousj7Q8f8sPMt4Jl6SkzXSoYgAMklhqvTXhrV7Psx1Xvou19UmVphCcxeIMjfbcVM9DaC+CLn3ANBNW5lOXZkHcSMlbEUzb+kRhB4JDvLWzzPY69hupH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007589; c=relaxed/simple;
	bh=5Ummnl6XUBJ5PAC+6uVL/132q5cmJAmglCQi4sTlAkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=clFERPcRMLv+4iPxoOCTQyPFLkKzBizAF+osKtv5uqNwycIMCgK+QSbZo2opRNQrSAAcjHw6DENjBA9PhH9w8BgsQKKAk4IAsbEOXevWmaNUH9RlsQ2uOC8gPTRj6bWxmG6Fn+bc3yqx7oM7i0J8zeP1OYGqti1hEp4PB2a0P/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=dopPCDpR; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="dopPCDpR"
ARC-Seal: i=1; a=rsa-sha256; t=1774007576; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PkKlwQdLYFfYBcKCAtiFl4H9hqfqkuQ2RTfd9adQJlBVHx1zhXTicUcJCeuWa558JixEnygwJgulRCS4riTdI2IEYJYi2+bf0lJbrfvq+bNIHI597lBWSovcdL5yaJ/ddI62CDV43CEDbtEX5TpQmGKjbUB/Oo+nFFPY3mLepvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774007576; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=XcmoMin/leSGA6F7iBdwt1Hnu7SdY9iUpBQJuWO8kGs=; 
	b=l/0VrsFF0HhzVZpFObUKoPbS+G8U+Ik5kSOAIFTJPYb29kl3iNWGWr9DWaNOGNkBAV/a9oyzj6zremN4RrMIWRw+F2h1lQ9Ir31Lfn6gQvPuz9OcOk0V7sTvdzAYUv8dfvK2OVH/JwSYZFTrMXWeTQ1M/tVhfccU0gBGaWO1BYU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774007576;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=XcmoMin/leSGA6F7iBdwt1Hnu7SdY9iUpBQJuWO8kGs=;
	b=dopPCDpRV23E7di7+qx5oFpLqZ0tSmwPhcyrgqh46c/3C1h9slOPfuOCLyAWmod6
	PhtAyP3o2wDrhd7J7KqKncRhIGpwixGahl+7swBGdbI/ByaMC4fyyBa6VyuzsXX2d+W
	2YyHlGAfqZVUP1GtkGHFo8IetOs8l10TJXyTbxUk=
Received: by mx.zohomail.com with SMTPS id 177400757445324.142630720667853;
	Fri, 20 Mar 2026 04:52:54 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 03/10] hook: rename cb_data_free/alloc -> hook_data_free/alloc
Date: Fri, 20 Mar 2026 13:52:04 +0200
Message-ID: <20260320115211.177351-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260320115211.177351-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
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
index 349db729f6..afa8db21a0 100644
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
index 40823ebde7..94649218a1 100644
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

