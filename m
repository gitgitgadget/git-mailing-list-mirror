Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0D4C1F424
	for <e@80x24.org>; Fri,  6 Apr 2018 06:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752656AbeDFGaW (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 02:30:22 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45283 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeDFGaU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 02:30:20 -0400
Received: by mail-pl0-f66.google.com with SMTP id v18-v6so58116ply.12
        for <git@vger.kernel.org>; Thu, 05 Apr 2018 23:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0avXcX9mimgmcovROn7dhw2vxUv1wazi4iAwIqL/NT0=;
        b=nfvX6lymBsVh7Izy9LBZ4EgQkzP2sIpaCETO6CSmY/3OPP2hnguCUg2i8/Rrxq/vfu
         q0ZuYmWKAZy5VsMD4n026jyyA9bnwuUO+6doJeepQKjQP6D1Q8nPaMtCuKe882LpXXFM
         AR20HLbbo/w+FA/mREQKtifRhcEskr6gUEwmVr6jg9Mx3/FQExU5+YF9eIwtdZ3MJJzP
         vhWzC/dGuVHjgav8A26HnljIDrtKcTWMK4cYxTwnEbRUjQK1dLbpTorrCo0hnisefYih
         9DXBcDw/K0Xxm9K7VYk1FK/y7j1hxny04U/YUNAKRzZATMIOABYS9Cels/uWlMW7sEWg
         WfSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0avXcX9mimgmcovROn7dhw2vxUv1wazi4iAwIqL/NT0=;
        b=hjcNUzWWUyw59eCWENcpa4EW8A1pcQudOTwgnRLOOm9fToom/kqFyAdlH1jeBPXuEf
         hv9CJaid10uZN+kxUIJUK3nHqkaqeEc/+kVsWfU9H5fyEsl4xJYJKd8hxG5GRWVWGKwy
         13svpBNHFInnrDlSnvtsIEx4kmZhlKpqbC/dovbyXVGeE1lY4HeMpi324tai6qjpTi1K
         OvDaHx9Hh1d501RxZlo9n9FrZqr4A+O7/TzfZe5FKTtZ/sy9ic8RXGB7ioWbArjLQteU
         PK8Adir13tfzxKc4K90s6U17MBcw0Wv/ghpMf7D8Kr0BiqIBh2ZO88bm6B3dXDMzg7c4
         pXcQ==
X-Gm-Message-State: AElRT7G3t1MhkrmwlZuGDEexsLzSFDVSaRSGN1KXYk8hmIa+zjxTsopu
        YxvnGJLUNUTlffKetAJx3hEteb01mh0=
X-Google-Smtp-Source: AIpwx4+kCLQreWCZO4g0LC1ccYNCneavCF8bvzntexpeSkLFQZGWKkmWv4ccZcHzm6Cy9CSKUhPnIA==
X-Received: by 2002:a17:902:7784:: with SMTP id o4-v6mr20313656pll.163.1522996219872;
        Thu, 05 Apr 2018 23:30:19 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:3d01:699f:f606:da49])
        by smtp.gmail.com with ESMTPSA id c186sm11868339pfb.40.2018.04.05.23.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Apr 2018 23:30:18 -0700 (PDT)
Date:   Thu, 5 Apr 2018 23:30:17 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sunshine@sunshineco.com, gitster@pobox.com
Subject: [PATCH v5 3/3] builtin/config: introduce `color` type specifier
Message-ID: <20180406063017.GD662@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <cover.1522996150.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522996150.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As of this commit, the canonical way to retreive an ANSI-compatible
color escape sequence from a configuration file is with the
`--get-color` action.

This is to allow Git to "fall back" on a default value for the color
should the given section not exist in the specified configuration(s).

With the addition of `--default`, this is no longer needed since:

  $ git config --default red --type=color core.section

will be have exactly as:

  $ git config --get-color core.section red

For consistency, let's introduce `--type=color` and encourage its use
with `--default` together over `--get-color` alone.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt |  7 +++++++
 builtin/config.c             | 22 ++++++++++++++++++++++
 t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 28567f75a..b49366a56 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -180,6 +180,10 @@ Valid `<type>`'s include:
   ~/` from the command line to let your shell do the expansion.)
 - 'expiry-date': canonicalize by converting from a fixed or relative date-string
   to a timestamp. This specifier has no effect when setting the value.
+- 'color': When writing to a caller, canonicalize by converting to an ANSI color
+  escape sequence. When writing to the configuration file, a sanity-check is
+  performed to ensure that the given value is canonicalize-able as an ANSI
+  color, but it is written as-is.
 +
 
 --bool::
@@ -231,6 +235,9 @@ Valid `<type>`'s include:
 	output it as the ANSI color escape sequence to the standard
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
++
+It is preferred to use `--type=color`, or `--type=color [--default=<default>]`
+instead of `--get-color`.
 
 -e::
 --edit::
diff --git a/builtin/config.c b/builtin/config.c
index e8da4009e..77f8cc25f 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,6 +61,7 @@ static int show_origin;
 #define TYPE_BOOL_OR_INT	3
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5
+#define TYPE_COLOR		6
 
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
@@ -82,6 +83,8 @@ static int option_parse_type(const struct option *opt, const char *arg,
 		*type = TYPE_PATH;
 	else if (!strcmp(arg, "expiry-date"))
 		*type = TYPE_EXPIRY_DATE;
+	else if (!strcmp(arg, "color"))
+		*type = TYPE_COLOR;
 	else {
 		die(_("unrecognized --type argument, %s"), arg);
 		return 1;
@@ -203,6 +206,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
 			if (git_config_expiry_date(&t, key_, value_) < 0)
 				return -1;
 			strbuf_addf(buf, "%"PRItime, t);
+		} else if (type == TYPE_COLOR) {
+			char v[COLOR_MAXLEN];
+			if (git_config_color(v, key_, value_) < 0)
+				return -1;
+			strbuf_addstr(buf, v);
 		} else if (value_) {
 			strbuf_addstr(buf, value_);
 		} else {
@@ -348,6 +356,20 @@ static char *normalize_value(const char *key, const char *value)
 		else
 			return xstrdup(v ? "true" : "false");
 	}
+	if (type == TYPE_COLOR) {
+		char v[COLOR_MAXLEN];
+		if (git_config_color(v, key, value))
+			die("cannot parse color '%s'", value);
+
+		/*
+		 * The contents of `v` now contain an ANSI escape
+		 * sequence, not suitable for including within a
+		 * configuration file. Treat the above as a
+		 * "sanity-check", and return the given value, which we
+		 * know is representable as valid color code.
+		 */
+		return xstrdup(value);
+	}
 
 	die("BUG: cannot normalize type %d", type);
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f5ae80e9a..c49473306 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -931,6 +931,36 @@ test_expect_success 'get --expiry-date' '
 	test_must_fail git config --expiry-date date.invalid1
 '
 
+test_expect_success 'get --type=color' '
+	rm .git/config &&
+	git config foo.color "red" &&
+	git config --get --type=color foo.color >actual.raw &&
+	test_decode_color <actual.raw >actual &&
+	echo "<RED>" >expect &&
+	test_cmp expect actual
+'
+
+cat >expect << EOF
+[foo]
+	color = red
+EOF
+
+test_expect_success 'set --type=color' '
+	rm .git/config &&
+	git config --type=color foo.color "red" &&
+	test_cmp expect .git/config
+'
+
+test_expect_success 'get --type=color barfs on non-color' '
+	echo "[foo]bar=not-a-color" >.git/config &&
+	test_must_fail git config --get --type=color foo.bar
+'
+
+test_expect_success 'set --type=color barfs on non-color' '
+	test_must_fail git config --type=color foo.color "not-a-color" 2>error &&
+	test_i18ngrep "cannot parse color" error
+'
+
 cat > expect << EOF
 [quote]
 	leading = " test"
-- 
2.17.0
