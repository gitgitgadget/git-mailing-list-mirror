Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16411F404
	for <e@80x24.org>; Tue, 10 Apr 2018 00:18:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeDJASn (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 20:18:43 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46392 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbeDJASh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 20:18:37 -0400
Received: by mail-pf0-f195.google.com with SMTP id h69so6756330pfe.13
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 17:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EHUPBdGgXUXtkCSKdGgg8A2RMQjlMuGzzmNJfoIyrXA=;
        b=uMixPXBnjhLV0SyPOCFdtHdq8z5vK2wDwyFVWF+x0anARAe9xadAqPAqKUDiWxP+Pt
         UPiIFiquEV2TtPVRb1HoUIvOsvcjfGaR6SUv6y5M3qSf7CoPNftTGu6wwljeTwpzXeYl
         0jItghqbQ9Pa9b/PO9lViAo9GXnvnA5HW5H26kvCqPS4dGXLsrPvury6qcnX95+IPsU2
         SJsf8z+ASTUc3pF0S3LmtPf82hxgTgpQ1MV4qDjB36N63glncm+BWkexrGbN8z0yR7+F
         9JkFhT+RoiUj5L7heVG5NTpw+XODWBw6Fohvgu/GNw/rEdkgJsRbjnxE/RavaWmcKm89
         ukVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EHUPBdGgXUXtkCSKdGgg8A2RMQjlMuGzzmNJfoIyrXA=;
        b=Q/zAOX+42t+5HYAEKB6m2hn9ZX7Zs+AWLfOECGs62uGBe61faOs1IYVbw3eLloyNJ2
         AYl59TtQybQiyFAWxoBYd1/p//sHvY+7Di4E6PMwqSSmwpCx5vS6lDQE5ChyHzDtl6qS
         knnpmYEPNMcy5njx6FibOvgQaFh6kpepm1Z3PXiuYmZJzSIwSCr0yvPMYFAXa294MGkN
         6EWC3m0i8B0bE5hH/b3ZCf/j0BS026XCJNAA65VkhwM/Kvfxdwx5jPN3AvapCzIi7Ods
         PvderJ2jTQzxkODNk7CGTf47C0uC1DwM/2EEBhgBeZ6CLtgtTGMv/saSJo6+8pkteQq3
         PT0w==
X-Gm-Message-State: ALQs6tCU+kPxmpt2k3vnn/hzgCRxCCTt+Bh6mg6XJo9yX/VYtWu/WGfC
        GbJoBvaRh0jSavfVwHbN8FqFPrznuIM=
X-Google-Smtp-Source: AIpwx49pQ2NAHVm2/pD097NQOt2IgTFabftasFY0u+px/TNeIQiWRJ6tuziLmyalsRk2mphgQBOb8A==
X-Received: by 10.98.236.220 with SMTP id e89mr796091pfm.173.1523319516477;
        Mon, 09 Apr 2018 17:18:36 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d66:22f3:ac1d:6007])
        by smtp.gmail.com with ESMTPSA id t11sm1960413pgn.94.2018.04.09.17.18.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 17:18:35 -0700 (PDT)
Date:   Mon, 9 Apr 2018 17:18:34 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v6 3/3] builtin/config: introduce `color` type specifier
Message-ID: <20180410001834.GE67209@syl.local>
References: <20180306021729.45813-1-me@ttaylorr.com>
 <cover.1523319159.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1523319159.git.me@ttaylorr.com>
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
 Documentation/git-config.txt |  6 ++++++
 builtin/config.c             | 22 ++++++++++++++++++++++
 t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 58 insertions(+)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index b644a44ae9..7c8365e377 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -177,6 +177,10 @@ Valid `<type>`'s include:
   ~/` from the command line to let your shell do the expansion.)
 - 'expiry-date': canonicalize by converting from a fixed or relative date-string
   to a timestamp. This specifier has no effect when setting the value.
+- 'color': When getting a value, canonicalize by converting to an ANSI color
+  escape sequence. When setting a value, a sanity-check is performed to ensure
+  that the given value is canonicalize-able as an ANSI color, but it is written
+  as-is.
 +
 
 --bool::
@@ -228,6 +232,8 @@ Valid `<type>`'s include:
 	output it as the ANSI color escape sequence to the standard
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
++
+`--type=color [--default=<default>]` is preferred over `--get-color`.
 
 -e::
 --edit::
diff --git a/builtin/config.c b/builtin/config.c
index 014e3a0d53..08016863ac 100644
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
 	else
 		die(_("unrecognized --type argument, %s"), arg);
 
@@ -202,6 +205,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
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
@@ -347,6 +355,20 @@ static char *normalize_value(const char *key, const char *value)
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
index f5ae80e9ae..c494733061 100755
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
