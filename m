Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AF6335540
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771453472; cv=pass; b=i/eexpWMq/X42vxIQhe9LCMupY+0gvAYKxDwVyaNIT6slqPjALMpcIvOz3kvYqPW2TXvmg4tHQb2ezy8CKRjjYKYwFoFYQrh+GH8QwNVY5uWtETcbk7APzdE8hgIkHfniIHeC8e/xePHNKjHD3v5GDnQJJooldUwJo/a3Y0dE/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771453472; c=relaxed/simple;
	bh=khK4Gwl4jBGZP6m4dXDHrQ/DmuEJr36N9LgaE45/VGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jgDMyvBrmQ3ssrz+KfeA+Q/AcJ7mhQ/xvsg7QBReYwzLQncH7l7LuqeyI0QRvibL48q5zb+ClYFPohEdneZUoaq3c610NvOXwLxEvm2wsVH5ytBeXFEeCB6D0i1q9vgrf3dD90bqgLFrFEHwvBCgUTfEamjrekdglIvC8s3aUcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=bgCWqHI7; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="bgCWqHI7"
ARC-Seal: i=1; a=rsa-sha256; t=1771453458; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=iD71Go6D1Dw/USsms+rrAIbkY3CiaG3WOPmX0X7mYXmnlxJoTLWafoHauVZ9fDu8l2SnFDFaKNwQSbaQsFQEzPLiqiSZkGnoeBtwiP9IvIHojI0SWmCVHsR3Q7k64R/j6X/jMHPYczCguEsCW5JAI08OSRHWcW3u8KtGxxJ7XX8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1771453458; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=nm2RPhGOeTNZwPrzBp3tTAxmZnOTSqmHu0mHEjRwVck=; 
	b=RNmUIc6fLu3MWaNZmQqECkpfFAuk8uXEt/5KFVSRQLS/07XRgoAttJ/R2GwCSRq0uygfT74ckGHkBRJq+impsMaDXArJgwMNKUmyHqn/TOjWw3ZlNm//6hxBKklgRtTxeIvqDCPN0Kosq7qgJt6y1isY2O+mB2qXDLrX4l4dFbY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1771453458;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=nm2RPhGOeTNZwPrzBp3tTAxmZnOTSqmHu0mHEjRwVck=;
	b=bgCWqHI7QyA+RX9KP2LFkzhsYrIEwl32Wb1yeeeTEj2kK9fEFo8jZT6XS3I/mfWU
	Kt157v4TWd69tvTRmh6Q/3jyrmaOes3xMU4HPsEEaeoKTqm930Q1GueFvR6geZj9ug8
	1VaXlar4HvpoE56jhluJiifIQjEXmQ8GuI4kkbRU=
Received: by mx.zohomail.com with SMTPS id 1771453457780363.6274029243531;
	Wed, 18 Feb 2026 14:24:17 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 5/8] hook: allow disabling config hooks
Date: Thu, 19 Feb 2026 00:23:49 +0200
Message-ID: <20260218222352.55393-6-adrian.ratiu@collabora.com>
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

Hooks specified via configs are always enabled, however users
might want to disable them without removing from the config,
like locally disabling a global hook.

Add a hook.<name>.enabled config which defaults to true and
can be optionally set for each configured hook.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/config/hook.adoc |  7 +++++++
 hook.c                         | 20 ++++++++++++++++++++
 t/t1800-hook.sh                | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/config/hook.adoc b/Documentation/config/hook.adoc
index 9faafe3016..0cda4745a6 100644
--- a/Documentation/config/hook.adoc
+++ b/Documentation/config/hook.adoc
@@ -13,3 +13,10 @@ hook.<name>.event::
 	specified event, the associated `hook.<name>.command` is executed.
 	This is a multi-valued key. To run `hook.<name>` on multiple
 	events, specify the key more than once. See linkgit:git-hook[1].
+
+hook.<name>.enabled::
+	Whether the hook `hook.<name>` is enabled. Defaults to `true`.
+	Set to `false` to disable the hook without removing its
+	configuration. This is particularly useful when a hook is defined
+	in a system or global config file and needs to be disabled for a
+	specific repository. See linkgit:git-hook[1].
diff --git a/hook.c b/hook.c
index 8a9b405f76..35c24bf33d 100644
--- a/hook.c
+++ b/hook.c
@@ -164,6 +164,21 @@ static int hook_config_lookup_all(const char *key, const char *value,
 		char *old = strmap_put(&data->commands, hook_name,
 				       xstrdup(value));
 		free(old);
+	} else if (!strcmp(subkey, "enabled")) {
+		switch (git_parse_maybe_bool(value)) {
+		case 0: /* disabled */
+			if (!unsorted_string_list_lookup(&data->disabled_hooks,
+							 hook_name))
+				string_list_append(&data->disabled_hooks,
+						   hook_name);
+			break;
+		case 1: /* enabled: undo a prior disabled entry */
+			unsorted_string_list_remove(&data->disabled_hooks,
+						    hook_name);
+			break;
+		default:
+			break; /* ignore unrecognised values */
+		}
 	}
 
 	free(hook_name);
@@ -216,6 +231,11 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 			const char *hname = hook_names->items[i].string;
 			char *command;
 
+			/* filter out disabled hooks */
+			if (unsorted_string_list_lookup(&cb_data.disabled_hooks,
+							hname))
+				continue;
+
 			command = strmap_get(&cb_data.commands, hname);
 			if (!command)
 				die(_("'hook.%s.command' must be configured or "
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index f1048a5119..9797802735 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -318,6 +318,38 @@ test_expect_success 'rejects hooks with no commands configured' '
 	test_grep "hook.broken.command" actual
 '
 
+test_expect_success 'disabled hook is not run' '
+	test_config hook.skipped.event "test-hook" &&
+	test_config hook.skipped.command "echo \"Should not run\"" &&
+	test_config hook.skipped.enabled false &&
+
+	git hook run --ignore-missing test-hook 2>actual &&
+	test_must_be_empty actual
+'
+
+test_expect_success 'disabled hook does not appear in git hook list' '
+	test_config hook.active.event "pre-commit" &&
+	test_config hook.active.command "echo active" &&
+	test_config hook.inactive.event "pre-commit" &&
+	test_config hook.inactive.command "echo inactive" &&
+	test_config hook.inactive.enabled false &&
+
+	git hook list pre-commit >actual &&
+	test_grep "active" actual &&
+	test_grep ! "inactive" actual
+'
+
+test_expect_success 'globally disabled hook can be re-enabled locally' '
+	test_config_global hook.global-hook.event "test-hook" &&
+	test_config_global hook.global-hook.command "echo \"global-hook ran\"" &&
+	test_config_global hook.global-hook.enabled false &&
+	test_config hook.global-hook.enabled true &&
+
+	echo "global-hook ran" >expected &&
+	git hook run test-hook 2>actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'git hook run a hook with a bad shebang' '
 	test_when_finished "rm -rf bad-hooks" &&
 	mkdir bad-hooks &&
-- 
2.52.0.732.gb351b5166d.dirty

