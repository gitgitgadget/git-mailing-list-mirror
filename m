Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A07239E75
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017697; cv=pass; b=o9bOaJY22/Xmpgl5Uc8Y0+UtSMLLzwGSP7xeggSvjznxfO5zvWaoaZEoRZfgN9NR1ZWrbjafMvj+6v2SacISzBL7pP1cs5MkPy/jswb3CObhHLbrlsSZ8Hd8naAdU/T+fLC3mMN49EcEOFx3Qf4Z9pWi3aRrfpUdpfPvcoe3AWY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017697; c=relaxed/simple;
	bh=ZEkAbaHFn8TEtfastUMikdha1MFYIRMpUwPGQo+E8DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rcyIXL2R+AEs1XkR195CodkriRtI6fORUzCMu1J1E/I4fNJyWdPDCAySx1mJBfE5EiIOKslpDTyiOMpRBf2NpNhCxVwNFmxOOkxRdMJpEp4XZZ7jOGkbxgeoLXEZxtF+7He9eYPdsEYlJBiOI5o8hd4bhP5Z3QpgLFRowWAB1uk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=jFnNFbAN; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="jFnNFbAN"
ARC-Seal: i=1; a=rsa-sha256; t=1773017683; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=CBhQ8OusYkxsqetwJi91gjMCxzN5yg2E5UVS9Y6t2YOr1BkEywLnRRusixgv9JUmAfMHhbI8hGbTVdlcYCRdSXSpj7S1G+RNhLmdD8CH4QaGpvuwztM9d0Ok7+p4PP3xcg98ztn/o0Yq/vaa1+ORV45eMl9DZfSsM2lQnpvjacM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773017683; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wf8OQ7Fhn3KQgfxwuSocXQSnwlQHQpYJvNN6S/5HBr8=; 
	b=Q/J0/z5S5nnePDJi8bTRs8oAFmQrS6fMMJFUnCQX1vjA/Jv6AsmDnMzO8WrapxytrwtWyqYRcR9E90Fz4UzlLi+bXBul13LJaLaXTo9joEVuv5e820beiWM6aWhElrGAIXvdERbSZx5+4njpDNNZ6F4lZVVTmkk5Jwo72xGP/Bw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773017683;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=wf8OQ7Fhn3KQgfxwuSocXQSnwlQHQpYJvNN6S/5HBr8=;
	b=jFnNFbANZz2jGZwV4XS0F4AwDx0VmiB+OeQSkYbcq2Il1i/+am9XN2ctZwlGYo7A
	MRnOpwVQ3nL90MzjhpNZHmbe4Dr6iAeGh+UhUAlQRTmnFUpg1QwCIgR7ScpTaX9hgi5
	2vgC//Dp2A+sK/gXwlzQD1bj+fyQDCI0nzX3/ktg=
Received: by mx.zohomail.com with SMTPS id 1773017681315161.19448364514335;
	Sun, 8 Mar 2026 17:54:41 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 03/10] hook: rename cb_data_free/alloc -> hook_data_free/alloc
Date: Mon,  9 Mar 2026 02:54:09 +0200
Message-ID: <20260309005416.2760030-4-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
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
index c5a6788dd5..bc1c45b16d 100644
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
index e949f5d488..e514c1b45b 100644
--- a/hook.h
+++ b/hook.h
@@ -43,8 +43,8 @@ struct hook {
 	void *feed_pipe_cb_data;
 };
 
-typedef void (*cb_data_free_fn)(void *data);
-typedef void *(*cb_data_alloc_fn)(void *init_ctx);
+typedef void (*hook_data_free_fn)(void *data);
+typedef void *(*hook_data_alloc_fn)(void *init_ctx);
 
 struct run_hooks_opt
 {
@@ -132,14 +132,14 @@ struct run_hooks_opt
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
@@ -189,7 +189,7 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
  * Frees the memory allocated for the hook list, including the `struct hook`
  * items and their internal state.
  */
-void hook_list_clear(struct string_list *hooks, cb_data_free_fn cb_data_free);
+void hook_list_clear(struct string_list *hooks, hook_data_free_fn cb_data_free);
 
 /**
  * Frees the hook configuration cache stored in `struct repository`.
-- 
2.52.0.732.gb351b5166d.dirty

