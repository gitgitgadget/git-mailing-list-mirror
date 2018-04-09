Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39771F404
	for <e@80x24.org>; Mon,  9 Apr 2018 22:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752369AbeDIWrD (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 18:47:03 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33244 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752309AbeDIWrA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 18:47:00 -0400
Received: by mail-pf0-f195.google.com with SMTP id f15so6614212pfn.0
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 15:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w6I356x/LzDJ2x12XIA0xtlwWgLLwMy0K8RwMnT0VC0=;
        b=vkwEfp4tmTn2rMRGho8ZDVSb/FB7wS9lL15PTpDcvqJc9GQ9Cz8JMgUmFM7+WEDMhX
         Bd1ifM9CZ0FtQ/eFkBy1/cYUoLOIGCK5hr6MhyLPO0st7tne7zDMllTGLOY8GmGg1eNS
         pQ8r1oX3hUoSvEVB/rE4+qR8UP0DIhALPtrPrxjuNHAdP6EgolXv3mwSsXDWqbmfj35q
         rScxSzq9iaqNKDmC89CP94UdewD1OJc9eMQ7No9pAiIYhN4/PuQ8n4XRMt2L3pBh6fdJ
         ZKx9xr4UaVnJDy2DYrr1FlcGO8C3TYZ1ZhzItN8ogXL29SSNADsgB2Drqa0IeH1GvaIX
         n7YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w6I356x/LzDJ2x12XIA0xtlwWgLLwMy0K8RwMnT0VC0=;
        b=jMrQtR7m+dBiKqonVoRzUKUy2Sqslp/bnl5gm3bEOohTcXmBfyQ8Z4DHc0V4m3pSvn
         U1+u8fz5hnfdzVR6be+VXyjEO0xPyo7nkNQKPm5J0AyWbWaa6gqtRdBsV3Mg/G7rAv5b
         ay2YNcv9Zc6GKfoE6QoTkb0DARL97QTPZkEeEevvf8CcAIwHlrcxkMUc7lAiV0CvrAiH
         23t8TiunL8mq77eCp1TqvzgMMiEBSeti0DT1PwSOBrbzL9AJ+PdF81ZtkCq8CtkulrQB
         Ix1RxDlfu3wRJRQGWM9bcgtmH05woYwCVXrIMwo0CI8UacYd/iR9PgljjoqoWpyz5+PE
         cRBw==
X-Gm-Message-State: AElRT7Gs7dxdYe09WRKUUZqxj9sguIVHg2d6Cuw2ZuqZZpnqgFZM7Pyc
        ZTqkaRPvndNpKAqquCF4BTO1iiSQkpY=
X-Google-Smtp-Source: AIpwx48S5+y5+1NBzDjoU6HzaR60iSZeRP4YS4TOI/K5RwEpYJVQpSM4mVaj+xgxwkh/ShL+288JDg==
X-Received: by 10.99.143.30 with SMTP id n30mr27048898pgd.213.1523314019003;
        Mon, 09 Apr 2018 15:46:59 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id y69sm2325846pfb.52.2018.04.09.15.46.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 15:46:58 -0700 (PDT)
Date:   Mon, 9 Apr 2018 15:46:57 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, ericsunshine@sunshineco.com
Subject: [PATCH v7 2/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180409224657.GC34547@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
 <cover.1523313730.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1523313730.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git config` has long allowed the ability for callers to provide a 'type
specifier', which instructs `git config` to (1) ensure that incoming
values are satisfiable under that type, and (2) that outgoing values are
canonicalized under that type.

In another series, we propose to extend this functionality with
`--type=color` and `--default` to replace `--get-color`.

However, we traditionally use `--color` to mean "colorize this output",
instead of "this value should be treated as a color".

Currently, `git config` does not support this kind of colorization, but
we should be careful to avoid inhabiting this option too soon, so that
`git config` can support `--type=color` (in the traditional sense) in
the future, if that is desired.

In this patch, we support `--type=<int|bool|bool-or-int|...>` in
addition to `--int`, `--bool`, and etc. This allows the aforementioned
upcoming patch to support querying a color value with a default via
`--type=color --default=...`, without squandering `--color`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 71 ++++++++++++++++++++----------------
 builtin/config.c             | 27 ++++++++++++++
 t/t1300-repo-config.sh       | 18 +++++++++
 3 files changed, 84 insertions(+), 32 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index e09ed5d7d5..a1e3ffe750 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,13 +9,13 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] name [value [value_regex]]
-'git config' [<file-option>] [type] --add name value
-'git config' [<file-option>] [type] --replace-all name value [value_regex]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [type] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
-'git config' [<file-option>] [type] [-z|--null] --get-urlmatch name URL
+'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [--type=<type>] --add name value
+'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] --get-all name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
 'git config' [<file-option>] --unset name [value_regex]
 'git config' [<file-option>] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
@@ -38,12 +38,10 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
-The type specifier can be either `--int` or `--bool`, to make
-'git config' ensure that the variable(s) are of the given type and
-convert the value to the canonical form (simple decimal number for int,
-a "true" or "false" string for bool), or `--path`, which does some
-path expansion (see `--path` below).  If no type specifier is passed, no
-checks or transformations are performed on the value.
+The `--type=<type>` option instructs 'git config' to ensure that incoming and
+outgoing values are canonicalize-able under the given <type>.  If no
+`--type=<type>` is given, no canonicalization will be performed. Callers may
+unset an existing `--type` specifier with `--no-type`.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
@@ -160,30 +158,39 @@ See also <<FILES>>.
 --list::
 	List all variables set in config file, along with their values.
 
---bool::
-	'git config' will ensure that the output is "true" or "false"
+--type <type>::
+  'git config' will ensure that any input or output is valid under the given
+  type constraint(s), and will canonicalize outgoing values in `<type>`'s
+  canonical form.
++
+Valid `<type>`'s include:
++
+- 'bool': canonicalize values as either "true" or "false".
+- 'int': canonicalize values as simple decimal numbers. An optional suffix of
+  'k', 'm', or 'g' will cause the value to be multiplied by 1024, 1048576, or
+  1073741824 prior to output.
+- 'bool-or-int': canonicalize according to either 'bool' or 'int', as described
+  above.
+- 'path': canonicalize by adding a leading `~` to the value of `$HOME` and
+  `~user` to the home directory for the specified user. This specifier has no
+  effect when setting the value (but you can use `git config section.variable
+  ~/` from the command line to let your shell do the expansion.)
+- 'expiry-date': canonicalize by converting from a fixed or relative date-string
+  to a timestamp. This specifier has no effect when setting the value.
++
 
+--bool::
 --int::
-	'git config' will ensure that the output is a simple
-	decimal number.  An optional value suffix of 'k', 'm', or 'g'
-	in the config file will cause the value to be multiplied
-	by 1024, 1048576, or 1073741824 prior to output.
-
 --bool-or-int::
-	'git config' will ensure that the output matches the format of
-	either --bool or --int, as described above.
-
 --path::
-	`git config` will expand a leading `~` to the value of
-	`$HOME`, and `~user` to the home directory for the
-	specified user.  This option has no effect when setting the
-	value (but you can use `git config section.variable ~/`
-	from the command line to let your shell do the expansion).
-
 --expiry-date::
-	`git config` will ensure that the output is converted from
-	a fixed or relative date-string to a timestamp. This option
-	has no effect when setting the value.
+  Historical options for selecting a type specifier. Prefer instead `--type`,
+  (see: above).
+
+--no-type::
+  Un-sets the previously set type specifier (if one was previously set). This
+  option requests that 'git config' not canonicalize the retrieved variable.
+  `--no-type` has no effect without `--type=<type>` or `--<type>`.
 
 -z::
 --null::
diff --git a/builtin/config.c b/builtin/config.c
index 92fb8d56b1..5c8952a17c 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,6 +61,32 @@ static int show_origin;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5
 
+static int option_parse_type(const struct option *opt, const char *arg,
+			     int unset)
+{
+	int *type = opt->value;
+
+	if (unset) {
+		*type = 0;
+		return 0;
+	}
+
+	if (!strcmp(arg, "bool"))
+		*type = TYPE_BOOL;
+	else if (!strcmp(arg, "int"))
+		*type = TYPE_INT;
+	else if (!strcmp(arg, "bool-or-int"))
+		*type = TYPE_BOOL_OR_INT;
+	else if (!strcmp(arg, "path"))
+		*type = TYPE_PATH;
+	else if (!strcmp(arg, "expiry-date"))
+		*type = TYPE_EXPIRY_DATE;
+	else
+		die(_("unrecognized --type argument, %s"), arg);
+
+	return 0;
+}
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP(N_("Config file location")),
 	OPT_BOOL(0, "global", &use_global_config, N_("use global config file")),
@@ -84,6 +110,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
+	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
 	OPT_SET_INT(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
 	OPT_SET_INT(0, "int", &type, N_("value is decimal number"), TYPE_INT),
 	OPT_SET_INT(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 24de37d544..f5ae80e9ae 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1613,6 +1613,7 @@ test_expect_success '--local requires a repo' '
 
 cat >.git/config <<-\EOF &&
 [core]
+foo = true
 number = 10
 EOF
 
@@ -1622,4 +1623,21 @@ test_expect_success 'later legacy specifiers are given precedence' '
 	test_cmp expect actual
 '
 
+test_expect_success '--type allows valid type specifiers' '
+	echo "true" >expect &&
+	git config --type=bool core.foo >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--no-type unsets type specifiers' '
+	echo "10" >expect &&
+	git config --type=bool --no-type core.number >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--type rejects unknown specifiers' '
+	test_must_fail git config --type=nonsense core.foo 2>error &&
+	test_i18ngrep "unrecognized --type argument" error
+'
+
 test_done
-- 
2.17.0
