Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59C881F424
	for <e@80x24.org>; Thu, 26 Apr 2018 05:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDZF6l (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 01:58:41 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:44686 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752876AbeDZF6h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 01:58:37 -0400
Received: by mail-pg0-f43.google.com with SMTP id 82so5237979pge.11
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 22:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SUebmHg9B5mXQg1ox1nnqWc4dFlxGIk9oZvGEXKPxt4=;
        b=wn2N+C79R2M+WcOUNqzYAM/zn3Km+ACTGTahIWN8X6aR3ypl/OnIU0II6AZwy2UDKw
         6Hjm0cBRxazPFFtOQB1rBIfBovJelZMEgbih+ChBEdktwQZTak1O7p+BDBXHl8NCBsFk
         Ms9jrqAAmy6/g2Y6t51PE6xBvJk4awuFePBO3C2jnYx8iJqWCMdVEKYsN0fHerBUCpHl
         1E3tQgjjkKo2O3GkbQHr4+egWWb/t+2Ou8MW02hrn+JJ9YwROdAn5ThYFCAveNPIFEWz
         Kf2JyU2HOauHHYJiJDmprxqh201JiAmPS0fvMJg+qp4pSg2uATx6gj+tJ0qHXGSOAHYG
         iAbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SUebmHg9B5mXQg1ox1nnqWc4dFlxGIk9oZvGEXKPxt4=;
        b=bi0aZK+FvtyRZl8ffhF+2S+OUEAlTRtgO3Ytauo0hnsoGlD4zdNKkaAax3EIuiVBj/
         XTNM1dahMql/diNv/9Tb4K2iaUCAwKVoHb78VVZyHs/wlIpPfsTJr3X7GUr57kcIq3bu
         NAYNIlZ8DQsFeiFkbYfwAcKFTe5kF9mT78yVN5JY4Qt1kdc81FV7UpHk09vSixMnUPc2
         iv9pSoL6+jRSI1tLwxDqAho+cZ0n+TswzGDgEDgY+hDfW4lsHGuu6LUSjTS59hCNATB5
         b9RZPvpPN802LEuuzL6IHQq8SL7DS1Hm69/PixtKmJBgUC1YpvUbuP4A2TgPL94Lt97t
         Bp7Q==
X-Gm-Message-State: ALQs6tBiLNBuxHJskb5s3AkjuUSUn/ovgulw+zldZlSXjYUtkNKIKSLv
        EQdFYz8eedK0iTOew0GgrbxU15kCizQ=
X-Google-Smtp-Source: AIpwx4/Bf5il2llbQpGC5V1LNO5qs/9DUQ06AUMuWeDR/wlObr+FwZqSvcKZM2Y/hi39CxIzonea0Q==
X-Received: by 10.99.121.129 with SMTP id u123mr17548420pgc.328.1524722316240;
        Wed, 25 Apr 2018 22:58:36 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:b5ff:86d4:d359:c7bd])
        by smtp.gmail.com with ESMTPSA id e87sm34279890pfl.65.2018.04.25.22.58.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 22:58:35 -0700 (PDT)
Date:   Wed, 25 Apr 2018 22:58:34 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 3/5] builtin/config: introduce `--default`
Message-ID: <52b4b8962ea8668c3d89e1549465128a25c7dfcb.1524722247.git.me@ttaylorr.com>
References: <cover.1524716420.git.me@ttaylorr.com>
 <cover.1524722247.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524722247.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For some use cases, callers of the `git-config(1)` builtin would like to
fallback to default values when the variable asked for does not exist.
In addition, users would like to use existing type specifiers to ensure
that values are parsed correctly when they do exist in the
configuration.

For example, to fetch a value without a type specifier and fallback to
`$fallback`, the following is required:

  $ git config core.foo || echo "$fallback"

This is fine for most values, but can be tricky for difficult-to-express
`$fallback`'s, like ANSI color codes.

This motivates `--get-color`, which is a one-off exception to the normal
type specifier rules wherein a user specifies both the configuration
variable and an optional fallback. Both are formatted according to their
type specifier, which eases the burden on the user to ensure that values
are correctly formatted.

This commit (and those following it in this series) aim to eventually
replace `--get-color` with a consistent alternative. By introducing
`--default`, we allow the `--get-color` action to be promoted to a
`--type=color` type specifier, retaining the "fallback" behavior via the
`--default` flag introduced in this commit.

For example, we aim to replace:

  $ git config --get-color variable [default] [...]

with:

  $ git config --default default --type=color variable [...]

Values filled by `--default` behave exactly as if they were present in
the affected configuration file; they will be parsed by type specifiers
without the knowledge that they are not themselves present in the
configuration.

Specifically, this means that the following will work:

  $ git config --int --default 1M does.not.exist
  1048576

In subsequent commits, we will offer `--type=color`, which (in
conjunction with `--default`) will be sufficient to replace
`--get-color`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt |  4 ++++
 builtin/config.c             | 18 ++++++++++++++++++
 t/t1310-config-default.sh    | 36 ++++++++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)
 create mode 100755 t/t1310-config-default.sh

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index b759009c75..c3adafd78a 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -240,6 +240,10 @@ Valid `<type>`'s include:
 	using `--file`, `--global`, etc) and `on` when searching all
 	config files.
 
+--default <value>::
+  When using `--get`, and the requested variable is not found, behave as if
+  <value> were the value assigned to the that variable.
+
 CONFIGURATION
 -------------
 `pager.config` is only respected when listing configuration, i.e., when
diff --git a/builtin/config.c b/builtin/config.c
index 9eda01615b..4f222a0ca9 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -26,6 +26,7 @@ static char term = '\n';
 static int use_global_config, use_system_config, use_local_config;
 static struct git_config_source given_config_source;
 static int actions, type;
+static char *default_value;
 static int end_null;
 static int respect_includes_opt = -1;
 static struct config_options config_options;
@@ -148,6 +149,7 @@ static struct option builtin_config_options[] = {
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
 	OPT_BOOL(0, "includes", &respect_includes_opt, N_("respect include directives on lookup")),
 	OPT_BOOL(0, "show-origin", &show_origin, N_("show origin of config (file, standard input, blob, command line)")),
+	OPT_STRING(0, "default", &default_value, N_("value"), N_("with --get, use default value when missing entry")),
 	OPT_END(),
 };
 
@@ -312,6 +314,16 @@ static int get_value(const char *key_, const char *regex_)
 	config_with_options(collect_config, &values,
 			    &given_config_source, &config_options);
 
+	if (!values.nr && default_value) {
+		struct strbuf *item;
+		ALLOC_GROW(values.items, values.nr + 1, values.alloc);
+		item = &values.items[values.nr++];
+		strbuf_init(item, 0);
+		if (format_config(item, key_, default_value) < 0)
+			die(_("failed to format default config value: %s"),
+				default_value);
+	}
+
 	ret = !values.nr;
 
 	for (i = 0; i < values.nr; i++) {
@@ -650,6 +662,12 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (default_value && !(actions & ACTION_GET)) {
+		error("--default is only applicable to --get");
+		usage_with_options(builtin_config_usage,
+			builtin_config_options);
+	}
+
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
 
diff --git a/t/t1310-config-default.sh b/t/t1310-config-default.sh
new file mode 100755
index 0000000000..6049d91708
--- /dev/null
+++ b/t/t1310-config-default.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description='Test git config in different settings (with --default)'
+
+. ./test-lib.sh
+
+test_expect_success 'uses --default when entry missing' '
+	echo quux >expect &&
+	git config -f config --default=quux core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'does not use --default when entry present' '
+	echo bar >expect &&
+	git -c core.foo=bar config --default=baz core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'canonicalizes --default with appropriate type' '
+	echo true >expect &&
+	git config -f config --default=yes --bool core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'dies when --default cannot be parsed' '
+	test_must_fail git config -f config --type=expiry-date --default=x --get \
+		not.a.section 2>error &&
+	test_i18ngrep "failed to format default config value" error
+'
+
+test_expect_success 'does not allow --default without --get' '
+	test_must_fail git config --default=quux --unset a.section >output 2>&1 &&
+	test_i18ngrep "\-\-default is only applicable to" output
+'
+
+test_done
-- 
2.17.0

