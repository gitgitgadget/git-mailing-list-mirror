Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B4DE1F404
	for <e@80x24.org>; Thu,  5 Apr 2018 02:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751298AbeDEC7W (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Apr 2018 22:59:22 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33848 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750995AbeDEC7U (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Apr 2018 22:59:20 -0400
Received: by mail-pl0-f67.google.com with SMTP id u11-v6so17166264plq.1
        for <git@vger.kernel.org>; Wed, 04 Apr 2018 19:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hMPINq2sN2ZGhLppnZQ1WlLc0NaCX5rmXM64t/zhsOc=;
        b=R6gn/fQyrOrt527QOlrVlCaZ1qeq5f31fEUGwwXjL/2AzMRaIM4opRvQx+cS/gTjQc
         6quHE7BEPzuzAtrKvuBOsTaZWZoV9Tc0Bc3Cd5SC07z9XTJLA8JWQaDR1R8qoNo1/yvV
         IAFq8eaSq10O+y/CyoprYGaUUqrmS70p5rjjuuOaLsNIasL+q94u4fmIMbDBxGwdSPGY
         +HDkR3lL+TxuNU5xIWcVZVLFC06f1XSiaG7DNM+xF6ipAEQ9K5AJHL1KLZWrZLNwbSdi
         iNuseFB2CxQV1nngdid5hznWEbhJXu3RaIQ6rpCtBa9IVaXKQM/r7fKNy4XDeBz4d83N
         Og6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hMPINq2sN2ZGhLppnZQ1WlLc0NaCX5rmXM64t/zhsOc=;
        b=kycTY13mr/cvfLijC6Js/Uz5eHYc7AToanCH06cyI1fFUqMcd7F28OvwFL6n/cnKX2
         wCQgd2YHsf+uExlv+r+FiaGxv82rMnbrs7BTKX61uEKhQQf/dZV7CXSGiimOei8upWcF
         lYTK+tZifciAiJTqcToq0+yEY/94B3sv8rJHEArm2N0YJX9UWd2/8wic9+/kt8elSD7m
         V16LzO7sMX+LujElWI2knBlHQvgVh+Z2G98qPm3gPX2I9YvQQfYcCDD/arPzmKN55vON
         6Y0ZpxYV3F60cVUNYo03U1yq5MRIcIf+5MrtecxpI7kDROELiOusBJytVFn9VlWtQTgC
         dF0w==
X-Gm-Message-State: AElRT7EqEPjD16pE6Wg0fFednAS5dcK158YuipIqu6wGduCjlbAhFGWZ
        0gx+f1KSEvMFoS8Q1K8fvw+9fJq9MZBVVQ==
X-Google-Smtp-Source: AIpwx48dczIiA0lCweSJM349xub0w9J7uWtpEG33Agk0RC5AAcaTnoJ76U3TYBRzJ/6ViLsgNnZKyg==
X-Received: by 10.101.82.68 with SMTP id q4mr11887930pgp.120.1522897159086;
        Wed, 04 Apr 2018 19:59:19 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:dc75:c2ae:e99:b3d1])
        by smtp.gmail.com with ESMTPSA id k73sm11726987pgc.55.2018.04.04.19.59.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Apr 2018 19:59:18 -0700 (PDT)
Date:   Wed, 4 Apr 2018 19:59:17 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, sunshine@sunshineco.com
Subject: [PATCH v4 3/3] builtin/config: introduce `color` type specifier
Message-ID: <20180405025917.GD49902@syl.local>
References: <20180329011634.68582-1-me@ttaylorr.com>
 <cover.1522896713.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1522896713.git.me@ttaylorr.com>
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

For consistency, let's introduce `--color` and encourage `--type=color`,
`--default` together over `--get-color` alone.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-config.txt | 10 ++++++----
 builtin/config.c             | 21 +++++++++++++++++++++
 t/t1300-repo-config.sh       | 30 ++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 620492d1e..bde702d2e 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -38,10 +38,8 @@ existing values that match the regexp are updated or unset.  If
 you want to handle the lines that do *not* match the regex, just
 prepend a single exclamation mark in front (see also <<EXAMPLES>>).
 
-A type specifier may be given as an argument to `--type` to make 'git config'
-ensure that the variable(s) are of the given type and convert the value to the
-canonical form. If no type specifier is passed, no checks or transformations are
-performed on the value.
+`color`::
+    The value is taken as an ANSI color escape sequence.
 
 When reading, the values are read from the system, global and
 repository local configuration files by default, and options
@@ -177,6 +175,7 @@ Valid `<type>`'s include:
   ~/` from the command line to let your shell do the expansion.)
 - 'expiry-date': canonicalize by converting from a fixed or relative date-string
   to a timestamp. This specifier has no effect when setting the value.
+- 'color': canonicalize by converting to an ANSI color escape sequence.
 +
 
 --bool::
@@ -223,6 +222,9 @@ Valid `<type>`'s include:
 	output it as the ANSI color escape sequence to the standard
 	output.  The optional `default` parameter is used instead, if
 	there is no color configured for `name`.
++
+It is preferred to use `--type=color`, or `--type=color --default=[default]`
+instead of `--get-color`.
 
 -e::
 --edit::
diff --git a/builtin/config.c b/builtin/config.c
index 1328b568b..aa3fcabe9 100644
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
@@ -348,6 +356,19 @@ static char *normalize_value(const char *key, const char *value)
 		else
 			return xstrdup(v ? "true" : "false");
 	}
+	if (type == TYPE_COLOR) {
+		char v[COLOR_MAXLEN];
+		if (!git_config_color(v, key, value))
+			/*
+			 * The contents of `v` now contain an ANSI escape
+			 * sequence, not suitable for including within a
+			 * configuration file. Treat the above as a
+			 * "sanity-check", and return the given value, which we
+			 * know is representable as valid color code.
+			 */
+			return xstrdup(value);
+		die("cannot parse color '%s'", value);
+	}
 
 	die("BUG: cannot normalize type %d", type);
 }
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index b25ab7b9e..c630bdc77 100755
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
