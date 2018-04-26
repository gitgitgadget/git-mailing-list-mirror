Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 964701F424
	for <e@80x24.org>; Thu, 26 Apr 2018 05:59:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeDZF6r (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 01:58:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:43955 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751528AbeDZF6m (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 01:58:42 -0400
Received: by mail-pf0-f195.google.com with SMTP id j11so17348189pff.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 22:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HKocjPobYXP3bOrs9t4g0HvyblvC5l4OVb4mr6nk4XA=;
        b=ykXFv1XMExlf/jf0VkD7+mpZgLsh7gH8h4noCRpM4zCAE8qUNl6GLW5Iwlg9hxe/Ed
         rePoJAJbh7Ae/PfTx1sQ+ykXKJHrU1/z2Zpe9+Z0jiI00JFaLtkl/Rmb89dZkY1HSuaN
         pmXm10EzBuAVRP8p2GhsAPTQ2OQ93zyl1ae/drUjRiLuHZOqPmT35m+v87VnPaWTCqfd
         7wcwsHLh25GzYJuxGj2gBVfHyYGb+sQPJbKZncvb2Wi1wT/ffOn4BW1jpNMxKZZ4OdA1
         u1ccn/A8bcNxlTFCjH/eMiK5b+tJlsFMBwVoH6I7wwBu8SHieyehTLXRt4suL/ndaFBr
         xsHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HKocjPobYXP3bOrs9t4g0HvyblvC5l4OVb4mr6nk4XA=;
        b=LYPYdUaqcOJQsPOosZPAgeaQuPIZMwEpPAA/6sk6sDIU8chuulk06UGolu0ByAIQlR
         IJAqIcePgwUFMs+MZSghlx9krsxIl5G9ArTbFXRTn2HEbYaVpFQBbguy/emxv/tln+sN
         mPNzJDZuAbjEEnTYz4OtHG1He9q0zY7S9r+QkPT98xIOGYodx9DQnIrYala5csA/GHB0
         v2M16K9kqfBfLDM6z9if/MLzPVVKfJu31AqVb6qOTq5um+fSZKVO7uS/ECHbikJAWS+3
         O1lwLZ4HnDO3hvqMxUy/geitlzN+abqfkE8LMkt4GATTScyIuBm5B4xhEZFV6o2HsjHH
         MQtQ==
X-Gm-Message-State: ALQs6tDfqdEAh26H0Xd4yWZSIvgFdkvjMdQ1S+AL8Y7owzh/kicQpdEC
        oZcTyG/0OVR5mXkyXBjFe0q/8H20hkY=
X-Google-Smtp-Source: AIpwx4/V1nskNhCIAt9CuFTdj6sTkUoJtfV0LPf8WkdLGPIM420LEVop7gCjr/ajozL8l2cXj5we5Q==
X-Received: by 2002:a17:902:8:: with SMTP id 8-v6mr31858331pla.287.1524722320991;
        Wed, 25 Apr 2018 22:58:40 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:b5ff:86d4:d359:c7bd])
        by smtp.gmail.com with ESMTPSA id d64sm34885893pfa.80.2018.04.25.22.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Apr 2018 22:58:40 -0700 (PDT)
Date:   Wed, 25 Apr 2018 22:58:39 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2 5/5] builtin/config: introduce `color` type specifier
Message-ID: <d9a737fde37e778c637de67e1215960f467c629d.1524722247.git.me@ttaylorr.com>
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
index c3adafd78a..18ddc78f42 100644
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
index 4f222a0ca9..bb62816bba 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,6 +61,7 @@ static int show_origin;
 #define TYPE_BOOL_OR_INT	3
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5
+#define TYPE_COLOR		6
 
 #define OPT_CALLBACK_VALUE(s, l, v, h, i) \
 	{ OPTION_CALLBACK, (s), (l), (v), NULL, (h), PARSE_OPT_NOARG | \
@@ -94,6 +95,8 @@ static int option_parse_type(const struct option *opt, const char *arg,
 			new_type = TYPE_PATH;
 		else if (!strcmp(arg, "expiry-date"))
 			new_type = TYPE_EXPIRY_DATE;
+		else if (!strcmp(arg, "color"))
+			new_type = TYPE_COLOR;
 		else
 			die(_("unrecognized --type argument, %s"), arg);
 	}
@@ -229,6 +232,11 @@ static int format_config(struct strbuf *buf, const char *key_, const char *value
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
@@ -374,6 +382,20 @@ static char *normalize_value(const char *key, const char *value)
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
index 1e3a1ace14..2acfd513f1 100755
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
