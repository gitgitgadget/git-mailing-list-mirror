Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E703AA509
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007585; cv=pass; b=UAv73ZFf8aEfZATXgzV9IKAzLgdXj07T9ZsRcXwyQjEoJlX2+93kFo17IpU1y9Kg2lZ7HOtL+9CpDOaizZOstd9mKemmZaF48PC0GZ3JefYsikMSXhOu5x4DswPaQQSfnaVYDkUfHygwsplLK9vxNVpFjPd3z7ZVP2IK8+DzZio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007585; c=relaxed/simple;
	bh=Zcn2CKdEkZr7pu6Zw/ZYNpAwhqKc5pgawjIKyJG+ym0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=asx5NbrlR9MeAmO2nRwkRrRDp5Kz19yJ/mvBMR1r3Cm+B1c+KbYW0lOIbcHThNtzEzfeWrcuSCRvnBiC0oGrlHYHy1FJ+zMCW3mZL3sT8++iIKTaq/Rmhg7m3EvYaEcBO9GPXJmCp0nGtYTGSzCpWsTgWfqXHOTFzHgn/oM7q/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=aMIKnAB+; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="aMIKnAB+"
ARC-Seal: i=1; a=rsa-sha256; t=1774007572; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eRilIkZX+Ffv2XzBqC59Qupuz6F0DP8yplZ2/2oXHpP8jI7qlQeEXYg4FZwjkjzc/bbmPW4X7pIKk77uH7EE5Rb+dHGpGFGDawq5+JZ0y1KpbprHtfzEzlIqmLTJtP37Q85XCHJg4Z+nqgwZObzxWTp0vonb1WWBwcWVLJDJcw0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774007572; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ylQyW8f10P7D/2bQfgdjHvDVq8QGdzNNw++BwHDRR/g=; 
	b=mB9llGBEvSG3ts9fITC6qbNnzMYSpkbdHplQIUt9hSo/C276CMxyiRMzdy8G2Es6XHYxRl+bU9hD7nqtF7B5y2B35baGT4pkpDlQqFdn1vCj79h+rfAglbXqozRHbWlf/4rCoC6HWHgf3FjNeA42KHqlbLC3dsDiz45yLh4INuc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774007572;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ylQyW8f10P7D/2bQfgdjHvDVq8QGdzNNw++BwHDRR/g=;
	b=aMIKnAB+LCzHpJ5aNAYgCfPiOCLvSeDvz8Io2Wt4GCITv4UUcOn0OSDy9yXg5XKC
	GFJCN1qnZqN33knkntnBGRq55s8oxe0YH9dfzLU00v6xtutrBkDr71iZqN4kVETf3p2
	GBIS9Gx2SG66KZSoSTHsPWM6jqmIqn2BDhgQjtPg=
Received: by mx.zohomail.com with SMTPS id 1774007569630333.64581650310515;
	Fri, 20 Mar 2026 04:52:49 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 01/10] hook: move unsorted_string_list_remove() to string-list.[ch]
Date: Fri, 20 Mar 2026 13:52:02 +0200
Message-ID: <20260320115211.177351-2-adrian.ratiu@collabora.com>
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

Move the convenience wrapper from hook to string-list since
it's a more suitable place. Add a doc comment to the header.

Also add a free_util arg to make the function more generic
and make the API similar to other functions in string-list.h.
Update the existing call-sites.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c        | 14 +++-----------
 string-list.c |  9 +++++++++
 string-list.h |  8 ++++++++
 3 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/hook.c b/hook.c
index 2c8252b2c4..67cc9a66df 100644
--- a/hook.c
+++ b/hook.c
@@ -110,14 +110,6 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 	string_list_append(hook_list, hook_path)->util = h;
 }
 
-static void unsorted_string_list_remove(struct string_list *list,
-					const char *str)
-{
-	struct string_list_item *item = unsorted_string_list_lookup(list, str);
-	if (item)
-		unsorted_string_list_delete_item(list, item - list->items, 0);
-}
-
 /*
  * Callback struct to collect all hook.* keys in a single config pass.
  * commands: friendly-name to command map.
@@ -156,7 +148,7 @@ static int hook_config_lookup_all(const char *key, const char *value,
 			struct strmap_entry *e;
 
 			strmap_for_each_entry(&data->event_hooks, &iter, e)
-				unsorted_string_list_remove(e->value, hook_name);
+				unsorted_string_list_remove(e->value, hook_name, 0);
 		} else {
 			struct string_list *hooks =
 				strmap_get(&data->event_hooks, value);
@@ -168,7 +160,7 @@ static int hook_config_lookup_all(const char *key, const char *value,
 			}
 
 			/* Re-insert if necessary to preserve last-seen order. */
-			unsorted_string_list_remove(hooks, hook_name);
+			unsorted_string_list_remove(hooks, hook_name, 0);
 			string_list_append(hooks, hook_name);
 		}
 	} else if (!strcmp(subkey, "command")) {
@@ -186,7 +178,7 @@ static int hook_config_lookup_all(const char *key, const char *value,
 			break;
 		case 1: /* enabled: undo a prior disabled entry */
 			unsorted_string_list_remove(&data->disabled_hooks,
-						    hook_name);
+						    hook_name, 0);
 			break;
 		default:
 			break; /* ignore unrecognised values */
diff --git a/string-list.c b/string-list.c
index fffa2ad4b6..d260b873c8 100644
--- a/string-list.c
+++ b/string-list.c
@@ -281,6 +281,15 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
 	list->nr--;
 }
 
+void unsorted_string_list_remove(struct string_list *list, const char *str,
+				 int free_util)
+{
+	struct string_list_item *item = unsorted_string_list_lookup(list, str);
+	if (item)
+		unsorted_string_list_delete_item(list, item - list->items,
+						 free_util);
+}
+
 /*
  * append a substring [p..end] to list; return number of things it
  * appended to the list.
diff --git a/string-list.h b/string-list.h
index 3ad862a187..b86ee7c099 100644
--- a/string-list.h
+++ b/string-list.h
@@ -265,6 +265,14 @@ struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
  */
 void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
 
+/**
+ * Remove the first item matching `str` from an unsorted string_list.
+ * No-op if `str` is not found. If `free_util` is non-zero, the `util`
+ * pointer of the removed item is freed before deletion.
+ */
+void unsorted_string_list_remove(struct string_list *list, const char *str,
+				 int free_util);
+
 /**
  * Split string into substrings on characters in `delim` and append the
  * substrings to `list`.  The input string is not modified.
-- 
2.52.0.732.gb351b5166d.dirty

