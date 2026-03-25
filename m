Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F52E301472
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468571; cv=pass; b=SDOupbMUNOp0Fr6rePz+a07vNLQwhMm0nCGHh8TXyF5FL4Wv0GAo3MIBUlCZWjmwN6ueWATX8v3DGMnNILk1/5wm2tUawRx/puUZFRVtFTHJoKPDxLjfGb6poo/MdFuXR0xuPvXHu8/ojOiEA59s4lOeshiTu7+mTUAhSnm1cmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468571; c=relaxed/simple;
	bh=ohY0iZVPQZTUDjAoFMNfKKemrSCJkvDNIU/KmGo9tiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTYKDKwIx5aY1UrC2SBIpPpjEwNAQw/nLrKuVreRBVYIV9C4Ve5SvGrs3X8/mm/HhRTN2fwXGTWnIZ6GACN+drrLpNNWwu+m0P7Cjl/sjgN3H9CZEygPfu3tqNJwlCLfn62dU44MBDTLn54y/q0Iawv5sISKuqdf3pkqghcaIuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=gFl2t41I; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="gFl2t41I"
ARC-Seal: i=1; a=rsa-sha256; t=1774468558; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=TgJZ2/KfkFjwZxbvu8Je3Dren643oIVhAhnLYu4OSxclHwQfDEkMIc4LZRs/R+wfbPjRwl/fwBBCRJlj5BSEKeZEl1ZhXUKR6XAy+9KW2PNtJGvODpsh96rZO9K6MXE/KixAvQWx3KrVTaqAuBpOamS4LsWWXRxZu/ubFnx6M94=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468558; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F/pAqwoit8h7rznNgUNPZKX9v5f3ZPJzOFFNH1Z9MxU=; 
	b=PWdiNRb9MEzezptA2nOwYhbpyPyWD1+0fa3U3WSTR5HzHTdKOJHkgMj8dW+o6ATaMeWxsllXq5bFpNXa5ZTSffYlN6yQ5v5Y0Adb/z2iZbDsdGjtKVZOckWilqoXedH42Cnkn3uEY0+lqP4H+G1NcLkM24Mbi3gv+NfMXxOiChU=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468558;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=F/pAqwoit8h7rznNgUNPZKX9v5f3ZPJzOFFNH1Z9MxU=;
	b=gFl2t41Ij9q74jIoxPmpXJWpOrzJs+w9ujpB7I0jHY2ZQjCY+rzGLVTlUXTqhwCb
	uDfgkj7kPDEj8GGvM51nmK0IwYbSsLEOMBpAHUCEr2lVDIudMLd9u8Mvv9/x5lZiPd0
	aonah39VGOZwAzQofZxdyICLuF0abKXbis0cc+AI=
Received: by mx.zohomail.com with SMTPS id 1774468556569807.7204645441466;
	Wed, 25 Mar 2026 12:55:56 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 09/12] hook: introduce hook_config_cache_entry for per-hook data
Date: Wed, 25 Mar 2026 21:55:00 +0200
Message-ID: <20260325195503.1139418-10-adrian.ratiu@collabora.com>
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

Replace the bare `char *command` util pointer stored in each string_list
item with a heap-allocated `struct hook_config_cache_entry` that carries
that command string.

This is just a refactoring with no behavior changes, to give the cache
entry room to grow, so it can carry the additional hook metadata we'll
be adding in the following commits.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/hook.c b/hook.c
index dc0c3de667..54f99f4989 100644
--- a/hook.c
+++ b/hook.c
@@ -108,6 +108,15 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 	string_list_append(hook_list, hook_path)->util = h;
 }
 
+/*
+ * Cache entry stored as the .util pointer of string_list items inside the
+ * hook config cache. For now carries only the command for the hook. Next
+ * commits will add more data.
+ */
+struct hook_config_cache_entry {
+	char *command;
+};
+
 /*
  * Callback struct to collect all hook.* keys in a single config pass.
  * commands: friendly-name to command map.
@@ -202,7 +211,12 @@ void hook_cache_clear(struct strmap *cache)
 
 	strmap_for_each_entry(cache, &iter, e) {
 		struct string_list *hooks = e->value;
-		string_list_clear(hooks, 1); /* free util (command) pointers */
+		for (size_t i = 0; i < hooks->nr; i++) {
+			struct hook_config_cache_entry *entry = hooks->items[i].util;
+			free(entry->command);
+			free(entry);
+		}
+		string_list_clear(hooks, 0);
 		free(hooks);
 	}
 	strmap_clear(cache, 0);
@@ -232,6 +246,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 
 		for (size_t i = 0; i < hook_names->nr; i++) {
 			const char *hname = hook_names->items[i].string;
+			struct hook_config_cache_entry *entry;
 			char *command;
 
 			/* filter out disabled hooks */
@@ -245,9 +260,10 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 				      "'hook.%s.event' must be removed;"
 				      " aborting."), hname, hname);
 
-			/* util stores the command; owned by the cache. */
-			string_list_append(hooks, hname)->util =
-				xstrdup(command);
+			/* util stores a cache entry; owned by the cache. */
+			CALLOC_ARRAY(entry, 1);
+			entry->command = xstrdup(command);
+			string_list_append(hooks, hname)->util = entry;
 		}
 
 		strmap_put(cache, e->key, hooks);
@@ -309,7 +325,7 @@ static void list_hooks_add_configured(struct repository *r,
 	/* Iterate through configured hooks and initialize internal states */
 	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
 		const char *friendly_name = configured_hooks->items[i].string;
-		const char *command = configured_hooks->items[i].util;
+		struct hook_config_cache_entry *entry = configured_hooks->items[i].util;
 		struct hook *hook;
 
 		CALLOC_ARRAY(hook, 1);
@@ -327,7 +343,7 @@ static void list_hooks_add_configured(struct repository *r,
 
 		hook->kind = HOOK_CONFIGURED;
 		hook->u.configured.friendly_name = xstrdup(friendly_name);
-		hook->u.configured.command = xstrdup(command);
+		hook->u.configured.command = xstrdup(entry->command);
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
-- 
2.52.0.732.gb351b5166d.dirty

