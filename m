Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6332239E75
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017702; cv=pass; b=Eb7LH0cqj/av6lmf7XbYc2H0lr4ig0EZNSPDTecWDCekPgcwwHK40Qm/KACPRaATw13U+siubUdCeFrmiydGYFknl/mtS0WW139TGtkD02Hv7pxow7qjLNDlt0uDBU3otWmsXhB+isiiww/ijKs/p0RrTEdYRA/AHvheyJwWiV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017702; c=relaxed/simple;
	bh=F3ggDObc7U/DOVE2LfBG/vqvbcvAaUEp8F3Z9PDv8yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sI4nWOnQeIeUbABSjVS/oh0fvmKB6jNlk3MsX1F9ayCnv1I6E4YwcCd/NGg8C2ZzgmmQ6h+LnIc01h83eEnM9/xVjf5DFhvHqYxyzEq7iz7qmVYJPHCB4coRSGxr8akN5Y2Sopdc+M+n15WIjnJhoaiKTGYGOlE1aGvbUj84NHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=eMnToNWY; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="eMnToNWY"
ARC-Seal: i=1; a=rsa-sha256; t=1773017689; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=as3vjtxGe3/3cCMWnVgrbJFpWRclSaNL08h/jV/EUD+FoZ8fDY6jJsGkikJyElRRCgFy+Ad8Hm1xsh0Fexjz9byHsh5qBSXJeY3IhHbLbFKHhqXH+uOS/mhpTIE48TUVFXfSMqUx9zJFI0Q6EVWx+bW5rdAL11Jk9TNRD/YNf04=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773017689; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fMq2GvLqBIjGYyar2EmgXCFhQUgpB/kBMSXwocgXIkA=; 
	b=WqNlRzJpvQ1k7VfaTo4q1wUMbh20NyhZ23D8QEcmRsES3P+ecdNXbjQvl0CC4l7yJOPBkVlsg+SAE1MYzcDdfzHRVPEhE63TxVkIYQnbs1nS0W0tP7UpB67EK9xksMQXf/tsthin2JTYg8bwalcLA33kRWa+8Ez3ohH8BuYZqew=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773017689;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=fMq2GvLqBIjGYyar2EmgXCFhQUgpB/kBMSXwocgXIkA=;
	b=eMnToNWYP6fJN6f5g1qi8wi4E00VR5ERySRkTF+bL6CEOsmlWL5WsysIt8WW1yJp
	hWnTrKiBIMS+dLMaoN16tHuAze1MaQPmHozlm+RxqlibDziunJdKfsvi5gjfZRAtH9a
	9Sx6wCCb3tmJY/ondFE5/d5xwYXoJfYefpcfowoM=
Received: by mx.zohomail.com with SMTPS id 1773017686755875.8505287622519;
	Sun, 8 Mar 2026 17:54:46 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 06/10] hook: make consistent use of friendly-name in docs
Date: Mon,  9 Mar 2026 02:54:12 +0200
Message-ID: <20260309005416.2760030-7-adrian.ratiu@collabora.com>
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

Both `name` and `friendly-name` is being used. Standardize on
`friendly-name` for consistency since name is rather generic,
even when used in the hooks namespace.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc | 30 +++++++++++++++---------------
 Documentation/git-hook.adoc    |  6 +++---
 hook.c                         |  2 +-
 hook.h                         |  2 +-
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 64e845a260..9e78f26439 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -1,23 +1,23 @@
-hook.<name>.command::
-	The command to execute for `hook.<name>`. `<name>` is a unique
-	"friendly" name that identifies this hook. (The hook events that
-	trigger the command are configured with `hook.<name>.event`.) The
-	value can be an executable path or a shell oneliner. If more than
-	one value is specified for the same `<name>`, only the last value
-	parsed is used. See linkgit:git-hook[1].
+hook.<friendly-name>.command::
+	The command to execute for `hook.<friendly-name>`. `<friendly-name>`
+	is a unique name that identifies this hook. The hook events that
+	trigger the command are configured with `hook.<friendly-name>.event`.
+	The value can be an executable path or a shell oneliner. If more than
+	one value is specified for the same `<friendly-name>`, only the last
+	value parsed is used. See linkgit:git-hook[1].
 
-hook.<name>.event::
-	The hook events that trigger `hook.<name>`. The value is the name
-	of a hook event, like "pre-commit" or "update". (See
+hook.<friendly-name>.event::
+	The hook events that trigger `hook.<friendly-name>`. The value is the
+	name of a hook event, like "pre-commit" or "update". (See
 	linkgit:githooks[5] for a complete list of hook events.) On the
-	specified event, the associated `hook.<name>.command` is executed.
-	This is a multi-valued key. To run `hook.<name>` on multiple
+	specified event, the associated `hook.<friendly-name>.command` is executed.
+	This is a multi-valued key. To run `hook.<friendly-name>` on multiple
 	events, specify the key more than once. An empty value resets
 	the list of events, clearing any previously defined events for
-	`hook.<name>`. See linkgit:git-hook[1].
+	`hook.<friendly-name>`. See linkgit:git-hook[1].
 
-hook.<name>.enabled::
-	Whether the hook `hook.<name>` is enabled. Defaults to `true`.
+hook.<friendly-name>.enabled::
+	Whether the hook `hook.<friendly-name>` is enabled. Defaults to `true`.
 	Set to `false` to disable the hook without removing its
 	configuration. This is particularly useful when a hook is defined
 	in a system or global config file and needs to be disabled for a
diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 12d2701b52..966388660a 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -44,7 +44,7 @@ event`), and then `~/bin/spellchecker` will have a chance to check your commit
 message (during the `commit-msg` hook event).
 
 Commands are run in the order Git encounters their associated
-`hook.<name>.event` configs during the configuration parse (see
+`hook.<friendly-name>.event` configs during the configuration parse (see
 linkgit:git-config[1]). Although multiple `hook.linter.event` configs can be
 added, only one `hook.linter.command` event is valid - Git uses "last-one-wins"
 to determine which command to run.
@@ -76,10 +76,10 @@ first start `~/bin/linter --cpp20` and second start `~/bin/leak-detector`. It
 would evaluate the output of each when deciding whether to proceed with the
 commit.
 
-For a full list of hook events which you can set your `hook.<name>.event` to,
+For a full list of hook events which you can set your `hook.<friendly-name>.event` to,
 and how hooks are invoked during those events, see linkgit:githooks[5].
 
-Git will ignore any `hook.<name>.event` that specifies an event it doesn't
+Git will ignore any `hook.<friendly-name>.event` that specifies an event it doesn't
 recognize. This is intended so that tools which wrap Git can use the hook
 infrastructure to run their own hooks; see "WRAPPERS" for more guidance.
 
diff --git a/hook.c b/hook.c
index f6bb1999ae..7f89ae9cc2 100644
--- a/hook.c
+++ b/hook.c
@@ -116,7 +116,7 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
  * Callback struct to collect all hook.* keys in a single config pass.
  * commands: friendly-name to command map.
  * event_hooks: event-name to list of friendly-names map.
- * disabled_hooks: set of friendly-names with hook.name.enabled = false.
+ * disabled_hooks: set of friendly-names with hook.<friendly-name>.enabled = false.
  */
 struct hook_all_config_cb {
 	struct strmap commands;
diff --git a/hook.h b/hook.h
index 168c6495a4..49b40d949b 100644
--- a/hook.h
+++ b/hook.h
@@ -14,7 +14,7 @@ typedef void *(*hook_data_alloc_fn)(void *init_ctx);
  * Represents a hook command to be run.
  * Hooks can be:
  * 1. "traditional" (found in the hooks directory)
- * 2. "configured" (defined in Git's configuration via hook.<name>.event).
+ * 2. "configured" (defined in Git's configuration via hook.<friendly-name>.event).
  * The 'kind' field determines which part of the union 'u' is valid.
  */
 struct hook {
-- 
2.52.0.732.gb351b5166d.dirty

