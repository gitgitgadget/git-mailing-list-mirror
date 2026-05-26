Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9272F7F0C
	for <git@vger.kernel.org>; Tue, 26 May 2026 19:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823292; cv=none; b=bVo3mduZMNn7v7bL5pDehgUJXnT8m0cQcAkR/aF0KJmuJlaS0pWSPodB40iYUmschmivAKyr6PmFS92CznArjfd+dKzKZ9b7NuMeHS5rkr/acvl9nTn3kTXmdm1W5EL5r7usyRYb8o9ndNU2EWGbXeMvjD8+K0ZdvRCpFobuNdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823292; c=relaxed/simple;
	bh=y7str5AjYcLtXGqQ/AnPx448LZvuUBkCCSYlDLzoxAw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=QDrdRnyWz3XSIlOkyB2Zwtx/cJIXzrh7WlLVDjiMfV61dXE21EplGVq8X0lTmuQmzX2uo2LfcAcR+euvzvxtKs8Y+fwP3n4a4sfup5XsgbloUpPa/1AvHk6FB0LohaYH36BbA4Qc7cAzn0iV19JfgxcymOT+3ai5Gu93HKFjLX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4vMAIKu; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4vMAIKu"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8bc3ef10cc4so147557216d6.1
        for <git@vger.kernel.org>; Tue, 26 May 2026 12:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779823289; x=1780428089; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6S+nrHuZvBVjayMeySDaoWhqpIjh8F7KEpFvkF6C0Y=;
        b=J4vMAIKuSi4VDBUDMMLq9F6gkbI24tywf7lrSH7w/lBWoon7p/e/fGirRkjen+IUap
         obS/mVTd74TK4MXbBzjDO1f2JthiCxm3Y+7o80F5SRzZbHRDRQxOgaZ+JsxlGfjdWoq2
         qw7qAV/E+A1hvoAi+f8UrLaOFOP6eJo1t0BusmvoHIlZAB9RAf/5FFNS3sj8oXsfEH5Q
         7YturGfqCpm3PhfBPEQANy31nzi+vzM/QZSTa2on244CfB2t+C6nTDtqT+TNorr89SP0
         tdBoWxeqETnwuQouZPz0n0U/IX+eS60jYfjr93UMrwG3IQDrhKg/PMV9klodn1eLD7Nw
         8GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779823289; x=1780428089;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+6S+nrHuZvBVjayMeySDaoWhqpIjh8F7KEpFvkF6C0Y=;
        b=hnyEs3yLux0Lu5iFizAXfjo1pZz+rawJr+d9K0UrovF/jhVcwFUTqrUNXbmhMNaP+T
         qVUFi5NdJVD9UYVvz4sMXPUIzPwoXKslcrZOpDAGL5g5gxhQkmFcIpFNVkxFvFq+M6+o
         t8DRLRMjQQhu2Eh/BpD4kCAR/NU9Aotv0wceMQGNBz7Oe8zOSQTX0R7tBVmJ1P1Yuo3x
         uJML+6ypDcegCWU7jAjflnpEkmDrKzkerli+hI0oXEKMpSQDi4XEZxOMqXh/FXNMEqsD
         LBpS6xUbsF9B77hsuXb6kP6+/OysN4MDw9sA8vrZEt213IAXveIevPRNigLdLZGLEoBo
         ZA6A==
X-Gm-Message-State: AOJu0Yykh0fdGTdDmy4KxPfXCCOg1cuToh8F1yvzrNjrEc0gjQwRYAla
	FNKg5zuq/CHhdev3y+FPHeOkXIwVw776CrrPaoFaRxZJQzgDraCNCxIQS5OO2g==
X-Gm-Gg: Acq92OElwhEIZa3ym6xHhFQ5zkukYFzr6ZbIOXynFrVdlkLKQFLh0v5I4Slg/MQng7M
	+Mc71odxuKNVzdugkIhl0lRXGrbZ/0XrMcvqvaz78ZZ2LTYZT5XCWnFfeClAYHSWuiV8bqNAq/X
	DbHUwjjp2M3jixbC5f7ELitqpvyq52gAQr+29Wv+R54bC5BUXG1R5DQRAmE26gBVVcDfCD1yYqM
	JEj0zEwyPmo3X6h8P5oZ0Ut9tHVHCxXsqYIR2ii7Xbspqi31zOVnP56PGxXnToDnNeYDH7fwaN0
	BzkRzZD42vPQM1zmyfj+MV85Jppo8tF2p5VjDMDzZogfDvbD/kzAXFD0OZv/5GdRlTyiOfYsRIs
	/8N7Ysyaq2ptfj3USlJrH6DeagUOuUczTyazsTi1Jh7wqKzr3X8rTQZ/pXzzT1ojEe9O6hMpPbw
	GNIpy+ODsy8x2XnBjjYLH9abs49Te1+LxFckQ=
X-Received: by 2002:ad4:5de8:0:b0:8bd:6baa:6aab with SMTP id 6a1803df08f44-8cc7b561177mr316036676d6.17.1779823289017;
        Tue, 26 May 2026 12:21:29 -0700 (PDT)
Received: from [127.0.0.1] ([20.57.47.229])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e0413sm165254796d6.31.2026.05.26.12.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 12:21:28 -0700 (PDT)
Message-Id: <pull.2302.v4.git.git.1779823288005.gitgitgadget@gmail.com>
In-Reply-To: <pull.2302.v3.git.git.1779697995418.gitgitgadget@gmail.com>
References: <pull.2302.v3.git.git.1779697995418.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 26 May 2026 19:21:27 +0000
Subject: [PATCH v4] config: improve diagnostic for "set" with missing value
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

"git config set pull.rebase=false" currently fails with "wrong
number of arguments", and the implicit form "git config
pull.rebase=false" fails with "invalid key". Neither points at
the real problem: the value is missing.

Report that directly, and when the argument has the shape
"<valid-key>=<value>", also suggest the split form:

    $ git config set pull.rebase=false
    error: missing value to set to the variable 'pull.rebase=false'
    hint: did you mean "git config set pull.rebase false"?

When the prefix before "=" is not a valid key, drop the hint:

    $ git config set foo=bar
    error: missing value to set to a variable with an invalid name 'foo=bar'

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    config: suggest the correct form when key contains "="
    
     * Skip the hint when the inferred value contains whitespace, so git
       config set pull.rebase=false "hello world" no longer suggests a
       malformed command.
     * Replace the inline actions == 0 check with a named actions_implicit
       flag, simplfied the code.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2302%2FHaraldNordgren%2Fconfig-hint-equals-key-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2302/HaraldNordgren/config-hint-equals-key-v4
Pull-Request: https://github.com/git/git/pull/2302

Range-diff vs v3:

 1:  6b9d66361d ! 1:  780b99409c config: suggest the correct form when key contains "=" in set context
     @@ Metadata
      Author: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## Commit message ##
     -    config: suggest the correct form when key contains "=" in set context
     +    config: improve diagnostic for "set" with missing value
      
     -    A user who types "git config pull.rebase=false" gets only "error:
     -    invalid key: pull.rebase=false" with no clue what went wrong.
     +    "git config set pull.rebase=false" currently fails with "wrong
     +    number of arguments", and the implicit form "git config
     +    pull.rebase=false" fails with "invalid key". Neither points at
     +    the real problem: the value is missing.
      
     -    Emit a "did you mean ..." hint suggesting the split form.  Restrict it
     -    to plausible-set contexts ("git config set", bare "git config <key>",
     -    and their 2-arg forms); explicit "get"/"unset" keep the existing error.
     +    Report that directly, and when the argument has the shape
     +    "<valid-key>=<value>", also suggest the split form:
      
     -    "=" is legal inside a subsection, so only fire when "=" lands after
     -    the last ".".  When the user supplied a separate value, use it in the
     -    suggestion instead of the suffix after "=":
     +        $ git config set pull.rebase=false
     +        error: missing value to set to the variable 'pull.rebase=false'
     +        hint: did you mean "git config set pull.rebase false"?
      
     -        $ git config set pull.rebase=false true
     -        error: invalid key: pull.rebase=false
     -        hint: did you mean "git config set pull.rebase true"?
     +    When the prefix before "=" is not a valid key, drop the hint:
     +
     +        $ git config set foo=bar
     +        error: missing value to set to a variable with an invalid name 'foo=bar'
      
     -    Signed-off-by: Harald Nordgren <harald.nordgren@kostdoktorn.se>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
       ## builtin/config.c ##
     @@ builtin/config.c: static void check_argc(int argc, int min, int max)
       	exit(129);
       }
       
     -+static void advise_setting_with_equals(const char *key, const char *value)
     ++static int is_valid_key(const char *key)
      +{
      +	const char *last_dot = strrchr(key, '.');
     -+	const char *eq;
      +
     -+	if (!last_dot)
     -+		return;
     -+	eq = strchr(last_dot + 1, '=');
     -+	if (!eq)
     -+		return;
     -+	if (!value)
     -+		value = eq + 1;
     -+	if (!*value || strpbrk(value, " \t\n"))
     -+		return;
     -+	advise(_("did you mean \"git config set %.*s %s\"?"),
     -+	       (int)(eq - key), key, value);
     ++	return last_dot && isalpha(last_dot[1]);
     ++}
     ++
     ++static NORETURN void die_missing_set_value(const char *arg)
     ++{
     ++	const char *last_dot = strrchr(arg, '.');
     ++	const char *eq = last_dot ? strchr(last_dot + 1, '=') : NULL;
     ++	char *prefix = eq ? xstrndup(arg, eq - arg) : NULL;
     ++
     ++	if (prefix && is_valid_key(prefix)) {
     ++		error(_("missing value to set to the variable '%s'"), arg);
     ++		advise(_("did you mean \"git config set %s %s\"?"),
     ++		       prefix, eq + 1);
     ++	} else if (is_valid_key(arg)) {
     ++		error(_("missing value to set to the variable '%s'"), arg);
     ++	} else {
     ++		error(_("missing value to set to a variable with an invalid name '%s'"),
     ++		      arg);
     ++	}
     ++	free(prefix);
     ++	exit(129);
      +}
      +
       static void show_config_origin(const struct config_display_options *opts,
     @@ builtin/config.c: static int cmd_config_set(int argc, const char **argv, const c
       
       	argc = parse_options(argc, argv, prefix, opts, builtin_config_set_usage,
       			     PARSE_OPT_STOP_AT_NON_OPTION);
     -+	if (argc == 1 && strchr(argv[0], '=')) {
     -+		error(_("wrong number of arguments, should be 2"));
     -+		advise_setting_with_equals(argv[0], NULL);
     -+		exit(129);
     -+	}
     ++	if (argc == 1)
     ++		die_missing_set_value(argv[0]);
       	check_argc(argc, 2, 2);
       
       	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
     -@@ builtin/config.c: static int cmd_config_set(int argc, const char **argv, const char *prefix,
     - 			error(_("cannot overwrite multiple values with a single value\n"
     - 			"       Use --value=<pattern>, --append or --all to change %s."), argv[0]);
     - 	}
     -+	if (ret == CONFIG_INVALID_KEY)
     -+		advise_setting_with_equals(argv[0], argv[1]);
     - 
     - 	location_options_release(&location_opts);
     - 	free(comment);
      @@ builtin/config.c: static int cmd_config_actions(int argc, const char **argv, const char *prefix)
       	};
       	char *value = NULL, *comment = NULL;
     @@ builtin/config.c: static int cmd_config_actions(int argc, const char **argv, con
       		case 1: actions = ACTION_GET; break;
       		case 2: actions = ACTION_SET; break;
      @@ builtin/config.c: static int cmd_config_actions(int argc, const char **argv, const char *prefix)
     - 		if (ret == CONFIG_NOTHING_SET)
     - 			error(_("cannot overwrite multiple values with a single value\n"
     - 			"       Use a regexp, --add or --replace-all to change %s."), argv[0]);
     -+		else if (ret == CONFIG_INVALID_KEY)
     -+			advise_setting_with_equals(argv[0], argv[1]);
     - 	}
     - 	else if (actions == ACTION_SET_ALL) {
     - 		check_write(&location_opts.source);
     -@@ builtin/config.c: static int cmd_config_actions(int argc, const char **argv, const char *prefix)
     - 		check_argc(argc, 1, 2);
     - 		ret = get_value(&location_opts, &display_opts, argv[0], argv[1],
     - 				0, flags);
     -+		if (ret == CONFIG_INVALID_KEY && actions_implicit)
     -+			advise_setting_with_equals(argv[0], NULL);
     - 	}
     - 	else if (actions == ACTION_GET_ALL) {
     - 		check_argc(argc, 1, 2);
     + 			error(_("no action specified"));
     + 			exit(129);
     + 		}
     ++	if (actions_implicit && argc == 1) {
     ++		const char *last_dot = strrchr(argv[0], '.');
     ++		if (last_dot && strchr(last_dot + 1, '='))
     ++			die_missing_set_value(argv[0]);
     ++	}
     + 	if (display_opts.omit_values &&
     + 	    !(actions == ACTION_LIST || actions == ACTION_GET_REGEXP)) {
     + 		error(_("--name-only is only applicable to --list or --get-regexp"));
      
       ## t/t1300-config.sh ##
      @@ t/t1300-config.sh: test_expect_success 'invalid key' '
       	test_must_fail git config inval.2key blabla
       '
       
     -+test_expect_success 'misplaced "=" in key: bare 1-arg form hints' '
     -+	test_must_fail git config pull.rebase=false 2>err &&
     -+	test_grep "invalid key: pull\\.rebase=false" err &&
     ++test_expect_success 'set with 1 arg of "key=value": valid key suggests split form' '
     ++	test_must_fail git config set pull.rebase=false 2>err &&
     ++	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
      +	test_grep "did you mean .git config set pull\\.rebase false." err
      +'
      +
     -+test_expect_success 'misplaced "=" in key: bare 2-arg form uses given value' '
     -+	test_must_fail git config pull.rebase=false true 2>err &&
     -+	test_grep "did you mean .git config set pull\\.rebase true." err
     -+'
     -+
     -+test_expect_success 'misplaced "=" in key: set subcommand uses given value' '
     -+	test_must_fail git config set pull.rebase=false true 2>err &&
     -+	test_grep "did you mean .git config set pull\\.rebase true." err
     -+'
     -+
     -+test_expect_success 'misplaced "=" in key: set with single arg hints' '
     -+	test_must_fail git config set pull.rebase=false 2>err &&
     -+	test_grep "wrong number of arguments" err &&
     ++test_expect_success 'set with 1 arg of "key=value": implicit form suggests split form' '
     ++	test_must_fail git config pull.rebase=false 2>err &&
     ++	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
      +	test_grep "did you mean .git config set pull\\.rebase false." err
      +'
      +
     -+test_expect_success 'misplaced "=" in key: explicit --get does not hint' '
     -+	test_must_fail git config --get pull.rebase=false 2>err &&
     -+	test_grep "invalid key: pull\\.rebase=false" err &&
     ++test_expect_success 'set with 1 arg of "key=value": invalid key does not suggest split form' '
     ++	test_must_fail git config set foo=bar 2>err &&
     ++	test_grep "missing value to set to a variable with an invalid name .foo=bar." err &&
      +	test_grep ! "did you mean" err
      +'
      +
     -+test_expect_success 'misplaced "=" in key: get subcommand does not hint' '
     -+	test_must_fail git config get pull.rebase=false 2>err &&
     ++test_expect_success 'set with 1 arg: variable name starting with digit is invalid' '
     ++	test_must_fail git config set foo.1bar=baz 2>err &&
     ++	test_grep "missing value to set to a variable with an invalid name .foo\\.1bar=baz." err &&
      +	test_grep ! "did you mean" err
      +'
      +
     -+test_expect_success 'misplaced "=" in key: unset subcommand does not hint' '
     -+	test_must_fail git config unset pull.rebase=false 2>err &&
     ++test_expect_success 'set with 1 arg of valid key reports missing value' '
     ++	test_must_fail git config set pull.rebase 2>err &&
     ++	test_grep "missing value to set to the variable .pull\\.rebase." err &&
      +	test_grep ! "did you mean" err
      +'
      +
     -+test_expect_success 'misplaced "=" in key: value with whitespace skips hint' '
     -+	test_must_fail git config set pull.rebase=false "hello world" 2>err &&
     -+	test_grep "invalid key: pull\\.rebase=false" err &&
     ++test_expect_success 'set with 2 args including "=" in invalid key does not suggest' '
     ++	test_must_fail git config set pull.rebase=false true 2>err &&
      +	test_grep ! "did you mean" err
      +'
      +
     -+test_expect_success '"=" inside subsection is valid, no hint' '
     ++test_expect_success '"=" inside subsection is valid' '
      +	test_when_finished "rm -f subsection.cfg" &&
     -+	git config set -f subsection.cfg foo.bar=baz.boo qux 2>err &&
     -+	test_grep ! "did you mean" err &&
     ++	git config set -f subsection.cfg foo.bar=baz.boo qux &&
      +	echo qux >expect &&
      +	git config get -f subsection.cfg foo.bar=baz.boo >actual &&
      +	test_cmp expect actual


 builtin/config.c  | 39 ++++++++++++++++++++++++++++++++++++++-
 t/t1300-config.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index cf4ba0f7cc..6fe2d85814 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -1,6 +1,7 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #include "builtin.h"
 #include "abspath.h"
+#include "advice.h"
 #include "config.h"
 #include "color.h"
 #include "date.h"
@@ -210,6 +211,33 @@ static void check_argc(int argc, int min, int max)
 	exit(129);
 }
 
+static int is_valid_key(const char *key)
+{
+	const char *last_dot = strrchr(key, '.');
+
+	return last_dot && isalpha(last_dot[1]);
+}
+
+static NORETURN void die_missing_set_value(const char *arg)
+{
+	const char *last_dot = strrchr(arg, '.');
+	const char *eq = last_dot ? strchr(last_dot + 1, '=') : NULL;
+	char *prefix = eq ? xstrndup(arg, eq - arg) : NULL;
+
+	if (prefix && is_valid_key(prefix)) {
+		error(_("missing value to set to the variable '%s'"), arg);
+		advise(_("did you mean \"git config set %s %s\"?"),
+		       prefix, eq + 1);
+	} else if (is_valid_key(arg)) {
+		error(_("missing value to set to the variable '%s'"), arg);
+	} else {
+		error(_("missing value to set to a variable with an invalid name '%s'"),
+		      arg);
+	}
+	free(prefix);
+	exit(129);
+}
+
 static void show_config_origin(const struct config_display_options *opts,
 			       const struct key_value_info *kvi,
 			       struct strbuf *buf)
@@ -1133,6 +1161,8 @@ static int cmd_config_set(int argc, const char **argv, const char *prefix,
 
 	argc = parse_options(argc, argv, prefix, opts, builtin_config_set_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
+	if (argc == 1)
+		die_missing_set_value(argv[0]);
 	check_argc(argc, 2, 2);
 
 	if ((flags & CONFIG_FLAGS_FIXED_VALUE) && !value_pattern)
@@ -1371,6 +1401,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 	};
 	char *value = NULL, *comment = NULL;
 	int ret = 0;
+	int actions_implicit;
 	struct key_value_info default_kvi = KVI_INIT;
 
 	argc = parse_options(argc, argv, prefix, opts,
@@ -1385,7 +1416,8 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 		exit(129);
 	}
 
-	if (actions == 0)
+	actions_implicit = (actions == 0);
+	if (actions_implicit)
 		switch (argc) {
 		case 1: actions = ACTION_GET; break;
 		case 2: actions = ACTION_SET; break;
@@ -1394,6 +1426,11 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 			error(_("no action specified"));
 			exit(129);
 		}
+	if (actions_implicit && argc == 1) {
+		const char *last_dot = strrchr(argv[0], '.');
+		if (last_dot && strchr(last_dot + 1, '='))
+			die_missing_set_value(argv[0]);
+	}
 	if (display_opts.omit_values &&
 	    !(actions == ACTION_LIST || actions == ACTION_GET_REGEXP)) {
 		error(_("--name-only is only applicable to --list or --get-regexp"));
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 11fc976f3a..4a8a381bd8 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -469,6 +469,49 @@ test_expect_success 'invalid key' '
 	test_must_fail git config inval.2key blabla
 '
 
+test_expect_success 'set with 1 arg of "key=value": valid key suggests split form' '
+	test_must_fail git config set pull.rebase=false 2>err &&
+	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
+	test_grep "did you mean .git config set pull\\.rebase false." err
+'
+
+test_expect_success 'set with 1 arg of "key=value": implicit form suggests split form' '
+	test_must_fail git config pull.rebase=false 2>err &&
+	test_grep "missing value to set to the variable .pull\\.rebase=false." err &&
+	test_grep "did you mean .git config set pull\\.rebase false." err
+'
+
+test_expect_success 'set with 1 arg of "key=value": invalid key does not suggest split form' '
+	test_must_fail git config set foo=bar 2>err &&
+	test_grep "missing value to set to a variable with an invalid name .foo=bar." err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'set with 1 arg: variable name starting with digit is invalid' '
+	test_must_fail git config set foo.1bar=baz 2>err &&
+	test_grep "missing value to set to a variable with an invalid name .foo\\.1bar=baz." err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'set with 1 arg of valid key reports missing value' '
+	test_must_fail git config set pull.rebase 2>err &&
+	test_grep "missing value to set to the variable .pull\\.rebase." err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success 'set with 2 args including "=" in invalid key does not suggest' '
+	test_must_fail git config set pull.rebase=false true 2>err &&
+	test_grep ! "did you mean" err
+'
+
+test_expect_success '"=" inside subsection is valid' '
+	test_when_finished "rm -f subsection.cfg" &&
+	git config set -f subsection.cfg foo.bar=baz.boo qux &&
+	echo qux >expect &&
+	git config get -f subsection.cfg foo.bar=baz.boo >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'correct key' '
 	git config 123456.a123 987
 '

base-commit: 56a4f3c3a221adf1df9b39da69b8a6890f803157
-- 
gitgitgadget
