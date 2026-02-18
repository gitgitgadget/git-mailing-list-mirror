Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A249223DD6
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 22:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771453475; cv=pass; b=iThv6XGy8cbYHv187x48HPvlswgj9D6o062siS4Uh3gdi6lKio0Cz0wNqHm1civRV+5+vfnr54pad77jLiCU0GZIRWaZri2UTS6iV66QjbSLTJdyygFjsKv2v3OQK1KbIpgFUwv5AgMV3vZz1xG6VBtVs+ygwv6/SSEP/n4+Ix4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771453475; c=relaxed/simple;
	bh=vgyeFcOgfqJIlnJ39o+zg6wR/XXMJiZKbZGk5Ntc0Qs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/pHuewqqjsOIRTtgobO+F3aauiCUPlxaC/PM5kN77Y32HU7ge5iBVXCnQA7tsoYaj7tSiBNcxC4KAHYT+wyn9VCIPt4CLJ+5dY+3Vb04J5rWeTcrhxsGBicX12MGS/Dq+VQyuBbAQsa3m3LpHCR7zJ2l4AM03VMTOYsBswci1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=KQrDTsGD; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="KQrDTsGD"
ARC-Seal: i=1; a=rsa-sha256; t=1771453461; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Hd5PEiRNoKeyn4lczezO1qbUW46+S1IF/zwQlE+Rd35v8gSwfPp3r4JywCwO+ywM7YtKp2waTIeBzJt5N4HehOjQfWVpoRQ5AqfVy3NOpyxwFS8KirsbvZqqdYx2zhRGeTUcepoLij+nIS11PL3l0CPV9AcZxQOEEpt3CUxUZ4A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771453461; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ylU2Gb0B63/TrVQAqeNxFoQj1l8M7FZve0WqrfnQfxE=; 
	b=CUry51+SmFfqj+hg77cE+mH7WRn8qiMP709LAymLj0LPKFytYZ4dcfdv/ztVHpfz8hThEXl8euviIgjwEBkw+pmOouv5LO7wggH5nMWcJa0nJISZ7Xpu6CTYAUNQyFsSDBrVAYGLy1GfwUp0p31fP9WVOpSE3L0FyDbD43tRqqM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771453460;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ylU2Gb0B63/TrVQAqeNxFoQj1l8M7FZve0WqrfnQfxE=;
	b=KQrDTsGDQGqlmMp5MF4631n7dSrVGuLxbR4loyYL3eQSemEbf12hPuXrPmkAnXAV
	Pz/t9wWpIy3BKYXK+k3PEekt0rvDFvFgrhc1Irzoa8RdWZIo1CWHvM1HY7+wuY3PQzz
	3fYYAJnmysH27ZquG65a2sw+X4Cd5+5pk7XfyGrY=
Received: by mx.zohomail.com with SMTPS id 1771453460039171.598140563544;
	Wed, 18 Feb 2026 14:24:20 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 6/8] hook: allow event = "" to overwrite previous values
Date: Thu, 19 Feb 2026 00:23:50 +0200
Message-ID: <20260218222352.55393-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260218222352.55393-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260218222352.55393-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add the ability for empty events to clear previously set multivalue
variables, so the newly added "hook.*.event" behave like the other
multivalued keys.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  4 +++-
 hook.c                         | 29 +++++++++++++++++++----------
 t/t1800-hook.sh                | 12 ++++++++++++
 3 files changed, 34 insertions(+), 11 deletions(-)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 0cda4745a6..64e845a260 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -12,7 +12,9 @@ hook.<name>.event::
 	linkgit:githooks[5] for a complete list of hook events.) On the
 	specified event, the associated `hook.<name>.command` is executed.
 	This is a multi-valued key. To run `hook.<name>` on multiple
-	events, specify the key more than once. See linkgit:git-hook[1].
+	events, specify the key more than once. An empty value resets
+	the list of events, clearing any previously defined events for
+	`hook.<name>`. See linkgit:git-hook[1].
 
 hook.<name>.enabled::
 	Whether the hook `hook.<name>` is enabled. Defaults to `true`.
diff --git a/hook.c b/hook.c
index 35c24bf33d..fee0a7ab4f 100644
--- a/hook.c
+++ b/hook.c
@@ -147,18 +147,27 @@ static int hook_config_lookup_all(const char *key, const char *value,
 	hook_name = xmemdupz(name, name_len);
 
 	if (!strcmp(subkey, "event")) {
-		struct string_list *hooks =
-			strmap_get(&data->event_hooks, value);
+		if (!*value) {
+			/* Empty values reset previous events for this hook. */
+			struct hashmap_iter iter;
+			struct strmap_entry *e;
+
+			strmap_for_each_entry(&data->event_hooks, &iter, e)
+				unsorted_string_list_remove(e->value, hook_name);
+		} else {
+			struct string_list *hooks =
+				strmap_get(&data->event_hooks, value);
+
+			if (!hooks) {
+				hooks = xcalloc(1, sizeof(*hooks));
+				string_list_init_dup(hooks);
+				strmap_put(&data->event_hooks, value, hooks);
+			}
 
-		if (!hooks) {
-			hooks = xcalloc(1, sizeof(*hooks));
-			string_list_init_dup(hooks);
-			strmap_put(&data->event_hooks, value, hooks);
+			/* Re-insert if necessary to preserve last-seen order. */
+			unsorted_string_list_remove(hooks, hook_name);
+			string_list_append(hooks, hook_name);
 		}
-
-		/* Re-insert if necessary to preserve last-seen order. */
-		unsorted_string_list_remove(hooks, hook_name);
-		string_list_append(hooks, hook_name);
 	} else if (!strcmp(subkey, "command")) {
 		/* Store command overwriting the old value */
 		char *old = strmap_put(&data->commands, hook_name,
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 9797802735..fb6bc554b9 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -226,6 +226,18 @@ test_expect_success 'git hook list reorders on duplicate event declarations' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git hook list: empty event value resets events' '
+	setup_hooks &&
+
+	# ghi is configured for pre-commit; reset it with an empty value
+	test_config hook.ghi.event "" --add &&
+
+	# only def should remain for pre-commit
+	echo "def" >expected &&
+	git hook list pre-commit >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'hook can be configured for multiple events' '
 	setup_hooks &&
 
-- 
2.52.0.732.gb351b5166d.dirty

