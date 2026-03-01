Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C865133C53D
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 18:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772390793; cv=pass; b=o47cxHdNNWSfDqRaXyFWchebUHoP6eeAqvbKwpmZS0moEFWLHE+wP6XiHy4U7EKismM1Q4+KLL+MpuXYEjx13tXVFbsla8t6tgYW5bh4yirqoqJLkSaZXG/PCubpBDBnT9EkjCvoHTjyMTD9ZvqKpu2ossSIvql84W8H/iJzSn4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772390793; c=relaxed/simple;
	bh=H7wiKwujeyRtNmpPd5bSlqGfoIeR8XCvDVm0d0CxaYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZRW6G02J+/1Kd++giklY4y8by58PV31ommOXFNDaeG0HzmPoQO2DtpKyN8xgEqL0HbKGUzLIU4TMG+3ts1+Q4z7UUW7zJ1zhiW3qG5NCR856hcFJ7LdmlqaSzoB9yHi823dUGxQxhayTnVMhVA0JlppasXRjPLW0vLF58UeUlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Won1kJfW; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Won1kJfW"
ARC-Seal: i=1; a=rsa-sha256; t=1772390779; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YvhS1ZtdVGhMLLUmLiSjYXFOE9evWMOvxQFfi/BnypSkZZHkWlGGjOPmKeKoMhJD19hwuQq/rwU3VPxj/eCqAMNg5Fe7TcjRXzDeAZ6LI5KQi9NWP3DO/Lrlq0ov2yVWAZpNNWGjKmeplGf6vihxX957U/TBFpZqGfv2+w/inNs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1772390779; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DaTLxBMygYUYQ0Cg153846z3H74Hmol5iW2PtPfFy8o=; 
	b=dwV908uct3bdFeJxor13WXQVLIjASW4z3kZ31zdRngxKjHHeJFb0m4LKgAigwMpQSIY6Ovgrh7y77YRsLOEo+dhOMXyPgVIcHOSc8iogWU3WE+XpPi9lG72W2A5nkZGxw5+lGWTRc4arrxDirF0+0QZ1b9ZGqoJBCsnC9TmgzMQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1772390779;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=DaTLxBMygYUYQ0Cg153846z3H74Hmol5iW2PtPfFy8o=;
	b=Won1kJfWFmrS4jTzEtmE1B/lcdNyizIEudzh1L52qvCIMdnw8fBPui0DAjuirPdr
	XsyUmw6Y+WP/w/zDz75uSTexNjnbP6bDGgpIRoP2+/feM3VAN6TZs/e2ffhP+2BWKUu
	QzcTgkprsLAIlsjIYk2WToZOD1bXv0TFlMVnF33I=
Received: by mx.zohomail.com with SMTPS id 1772390777017714.1034104198936;
	Sun, 1 Mar 2026 10:46:17 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 09/12] hook: add -z option to "git hook list"
Date: Sun,  1 Mar 2026 20:44:57 +0200
Message-ID: <20260301184500.1488433-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260301184500.1488433-1-adrian.ratiu@collabora.com>
References: <20260204165126.1548805-1-adrian.ratiu@collabora.com>
 <20260301184500.1488433-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Add a NUL-terminate mode to git hook list, just in case hooks are
configured with weird characters like newlines in their names.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 Documentation/git-hook.adoc |  8 ++++++--
 builtin/hook.c              |  9 ++++++---
 t/t1800-hook.sh             | 13 +++++++++++++
 3 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-hook.adoc b/Documentation/git-hook.adoc
index 0eaf864c43..966388660a 100644
--- a/Documentation/git-hook.adoc
+++ b/Documentation/git-hook.adoc
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git hook' run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]
-'git hook' list <hook-name>
+'git hook' list [-z] <hook-name>
 
 DESCRIPTION
 -----------
@@ -113,9 +113,10 @@ Any positional arguments to the hook should be passed after a
 mandatory `--` (or `--end-of-options`, see linkgit:gitcli[7]). See
 linkgit:githooks[5] for arguments hooks might expect (if any).
 
-list::
+list [-z]::
 	Print a list of hooks which will be run on `<hook-name>` event. If no
 	hooks are configured for that event, print a warning and return 1.
+	Use `-z` to terminate output lines with NUL instead of newlines.
 
 OPTIONS
 -------
@@ -130,6 +131,9 @@ OPTIONS
 	tools that want to do a blind one-shot run of a hook that may
 	or may not be present.
 
+-z::
+	Terminate "list" output lines with NUL instead of newlines.
+
 WRAPPERS
 --------
 
diff --git a/builtin/hook.c b/builtin/hook.c
index 4e49afb4a1..542183795a 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -10,7 +10,7 @@
 #define BUILTIN_HOOK_RUN_USAGE \
 	N_("git hook run [--ignore-missing] [--to-stdin=<path>] <hook-name> [-- <hook-args>]")
 #define BUILTIN_HOOK_LIST_USAGE \
-	N_("git hook list <hook-name>")
+	N_("git hook list [-z] <hook-name>")
 
 static const char * const builtin_hook_usage[] = {
 	BUILTIN_HOOK_RUN_USAGE,
@@ -33,9 +33,12 @@ static int list(int argc, const char **argv, const char *prefix,
 	struct string_list *head;
 	struct string_list_item *item;
 	const char *hookname = NULL;
+	int line_terminator = '\n';
 	int ret = 0;
 
 	struct option list_options[] = {
+		OPT_SET_INT('z', NULL, &line_terminator,
+			    N_("use NUL as line terminator"), '\0'),
 		OPT_END(),
 	};
 
@@ -65,10 +68,10 @@ static int list(int argc, const char **argv, const char *prefix,
 
 		switch (h->kind) {
 		case HOOK_TRADITIONAL:
-			printf("%s\n", _("hook from hookdir"));
+			printf("%s%c", _("hook from hookdir"), line_terminator);
 			break;
 		case HOOK_CONFIGURED:
-			printf("%s\n", h->u.configured.friendly_name);
+			printf("%s%c", h->u.configured.friendly_name, line_terminator);
 			break;
 		default:
 			BUG("unknown hook kind");
diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 856555bce5..0a4b2a9978 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -60,6 +60,19 @@ test_expect_success 'git hook list: configured hook' '
 	test_cmp expect actual
 '
 
+test_expect_success 'git hook list: -z shows NUL-terminated output' '
+	test_hook test-hook <<-EOF &&
+	echo Test hook
+	EOF
+	test_config hook.myhook.command "echo Hello" &&
+	test_config hook.myhook.event test-hook --add &&
+
+	printf "myhookQhook from hookdirQ" >expect &&
+	git hook list -z test-hook >actual.raw &&
+	nul_to_q <actual.raw >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git hook run: nonexistent hook' '
 	cat >stderr.expect <<-\EOF &&
 	error: cannot find a hook named test-hook
-- 
2.52.0.732.gb351b5166d.dirty

