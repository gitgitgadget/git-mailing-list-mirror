Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9683AB273
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007595; cv=pass; b=sOmwBwX1I+a62afeqfST4eJxKA46yLVkT0AJ9Yf1E43ydZ1FLVU+Pk0XbheHN6O/slpjX/kWdQ2G7qU+VPPcGxEwtUeb7UGJSsCnVNr5+G+CELYgc3mlr3ZVYmgH8OK2EaDjFy05+6K8q6f59piSadHnwu6pgGDx5d09uCGDnGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007595; c=relaxed/simple;
	bh=0UiStwW6/LrFvE2Dsgv/ZcoReZcQqgDxssb8vGwXLiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAZKMICVA/WlpDyOc3S+pN05T62kgMWtoAKJsky/bBunpT0knVIFPmEgtkdZia0jaAvyla0fCPI1feaX6idmQTSPaP0ayWDQTY66BQgyFWqBsEgf9yIe+YSECMj34FLO+nUxuGM/yTCc1Kdw0kWaWiCoPz/I1urD76lO8IyFiCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=ILWaWB9g; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="ILWaWB9g"
ARC-Seal: i=1; a=rsa-sha256; t=1774007582; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ASd5930h3Ya4ExhLnxAeHbceps3tBjQMnWBX+YohGvQGb3n8h5bVTUtq8Lm+CTJbPg55+rDgoD192LJ+Db47w+poJ0IuxxZk7zv9sv1ouE3pf7UTcEQYHOoKkIY5B4PLsV+MLLzUoHBDsK1TkTI7f+skgLiZZQeIPe3BTR0qvQY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774007582; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3VgcBtk0d2kPFh20+1kWETITxnAwvjUgTkkT8pmRgQ8=; 
	b=I7hHYy0GNwJfD3h3L0HUWYM79YRwUQhEC3TkZLt4tgrOo95bd3mV5BbrMhUUgVUuZuTN8woP/7/YIDursjgwYk5Gs0+GMq7IjPaq1xZWtR65mpdVVlCZiMXHBn6EdFvhVyBi2IT3BfkGbLbtumQLB4/1A2X4Oy8n3+TI5ySRS0Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774007582;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=3VgcBtk0d2kPFh20+1kWETITxnAwvjUgTkkT8pmRgQ8=;
	b=ILWaWB9gonDN4XGf7pyVXQDj6zDab8NQp+aOeg97hLqlYgAuhpxp+DPSL7FKWvWM
	O1jfYWEgTW/ftsuFsYjr9+NqMGmyuFC7We2XWwm5A0LZRnnKNly5OD476ZhjFT5q7z/
	NXIgV97N9N7CzGFlreuqaPDmq57TukraG+33EAys=
Received: by mx.zohomail.com with SMTPS id 1774007580465746.7204102329529;
	Fri, 20 Mar 2026 04:53:00 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 06/10] hook: make consistent use of friendly-name in docs
Date: Fri, 20 Mar 2026 13:52:07 +0200
Message-ID: <20260320115211.177351-7-adrian.ratiu@collabora.com>
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
index 74f4701176..ad022821c1 100644
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

