Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41EFC1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 01:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeDKBHA (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 21:07:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39487 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751624AbeDKBG6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 21:06:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id c78so136975pfj.6
        for <git@vger.kernel.org>; Tue, 10 Apr 2018 18:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9cWysJSyKCKeijj/JUv9vQZhs+Og2rwo/+5LktYKbqI=;
        b=GfmD8fjeDM9kt2AZ/GSTwM858CGgXBIc6PzNHh28DZZQaU5Z3kX6Up4/+wy19gXoK1
         KZzy+zidPugQt++Dw67SqammO9Q12Av9lQTCudwn+EWVQsE8O9iQwqe0QjYBvCd4Xhvf
         IlclQLVxF+D1O1BXuAesU9f9824kJeSCMbhZm06SLMeu8qC4g7u87itjWy7xWCsShspb
         bExHEl0rL43hQ/KdOce3cTvclx+KloFHMfsqMgWlvcTQ/4T1KKN0je1XAORobBwdfLXu
         MW4YSwpsrM4Qye+FsjHxj5rQoJl4cFm9YnaMbg7USS3p+SZe854SRTXwZC/xfEyOWYCv
         bkyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9cWysJSyKCKeijj/JUv9vQZhs+Og2rwo/+5LktYKbqI=;
        b=A4Fh0TfWMe5rGKSR9GtAVaeJ19sDljkx4nqJJjSeU7LMe/Rr0RjcENOVhuJiQYljBd
         a+OfVc5E4InHtorUC3/kWXxkAuqwxvyREaOg8+arQKq6FQVJPBxESIBDGSQV+tJxCGeb
         3FgM+k4b2T4Wh5eFgzuIgNc37WyDDdC3gee+dBd7gEVMFXQJn+2YcrCV8Ufs1KfYc3mu
         wplzH6cE7CBd9XrPsYdxt8ahLTFDfND2pF0jM2rg4qhc+ky4P2bdNnMzuBkYqJyAAg5A
         svQQEbXje8m7vj3i4/Jfvbii+H6VRU17ChM0VL+T9LjgKoe/4Zk7NvHuqS5GIGKwbale
         RSFA==
X-Gm-Message-State: ALQs6tAlQBK45EX3OEIGffpNSSUU95pO5jE4MLloSwl2vEnwx18YIRAJ
        1/AIQavzzKXGSpMPEGFcUfxrFkZXVIQgKQ==
X-Google-Smtp-Source: AIpwx4/sZyh/19FH2/rktBH/x/h53qUfFSO+iOf2vqRp/FPIhuU40+ha0eB8wpIjWLSm3pi+PINchg==
X-Received: by 10.98.17.210 with SMTP id 79mr2175204pfr.65.1523408817365;
        Tue, 10 Apr 2018 18:06:57 -0700 (PDT)
Received: from localhost ([2601:602:9500:3a4f:1d0e:5efd:b490:f1b1])
        by smtp.gmail.com with ESMTPSA id h6sm6637469pgn.65.2018.04.10.18.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 18:06:55 -0700 (PDT)
Date:   Tue, 10 Apr 2018 18:06:54 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sunshine@sunshineco.com, peff@peff.net
Subject: [PATCH v8 0/2] builtin/config.c: support `--type=<type>` as
 preferred alias for `--type`
Message-ID: <20180411010654.GA28561@syl.local>
References: <20180328234719.595-1-me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328234719.595-1-me@ttaylorr.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Attached is the eighth re-roll of my series to add `--type=<type>` as
the preferred alternative for `--<type>`.

The main changes since v7 concern handling degenerate cases, such as:

  * git config --type=int --type=bool
  * git config --type=int --int

We have previously had discussion about whether we should (1) retain the
error in previous versions when confronted with multiple, conflicting
type specifiers, (2) ignore the error, in favor of making --<type> and
--type=<type> true synonyms, or (3) some combination of the two.

I have thought some more about my argument that it would be favorable to
make "--type=int" and "--int" behave in the same way, and I am no
longer convinced that my argument makes sense. It's based on the premise
that "--type=<type>" must _necessarily_ allow multiple invocations, such
as '--type=int --type=bool', and therefore "--int --bool" should be
updated to behave the same way.

We are not constrained to this behavior, so in v8, I have taught Git the
following:

  1. Allow multiple non-conflicting types, such as '--int --int',
     '--type=int --int', and '--int --type=int'.

  2. Disallow multiple conflicting types, such as '--int --bool',
     '--type=int --bool', and '--int --type=bool'.

  3. Allow conflicting types following --no-type, such as '--int
     --no-type --bool', '--type=int --no-type --bool', and '--int
     --no-type --type=bool'. Note that this does _not_ introduce options
     such as '--no-int' and whatnot.

This is accomplished by a new locally defined macro called
OPT_CALLBACK_VALUE, which allows us to reuse option_parse_type() to
handle --int as well, by sending it through as opt->defval.

I think that the above is the best-of-all-worlds choice, but I am
curious to hear everyone else's thoughts. Thanks in advance for your
review.


Thanks,
Taylor

Taylor Blau (2):
  builtin/config.c: treat type specifiers singularly
  builtin/config.c: support `--type=<type>` as preferred alias for
    `--type`

 Documentation/git-config.txt |  71 +++++++++++++-----------
 builtin/config.c             | 101 +++++++++++++++++++++++++----------
 t/t1300-repo-config.sh       |  63 ++++++++++++++++++++++
 3 files changed, 176 insertions(+), 59 deletions(-)

Inter-diff (since v7):

diff --git a/builtin/config.c b/builtin/config.c
index 5c8952a17c..7184c09582 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -61,28 +61,53 @@ static int show_origin;
 #define TYPE_PATH		4
 #define TYPE_EXPIRY_DATE	5

+#define OPT_CALLBACK_VALUE(s, l, h, f, i) \
+	{ OPTION_CALLBACK, (s), (l), NULL, NULL, (h), PARSE_OPT_NOARG | \
+	PARSE_OPT_NONEG, (f), (i) }
+
+static struct option builtin_config_options[];
+
 static int option_parse_type(const struct option *opt, const char *arg,
 			     int unset)
 {
-	int *type = opt->value;
-
 	if (unset) {
-		*type = 0;
+		type = 0;
 		return 0;
 	}

-	if (!strcmp(arg, "bool"))
-		*type = TYPE_BOOL;
-	else if (!strcmp(arg, "int"))
-		*type = TYPE_INT;
-	else if (!strcmp(arg, "bool-or-int"))
-		*type = TYPE_BOOL_OR_INT;
-	else if (!strcmp(arg, "path"))
-		*type = TYPE_PATH;
-	else if (!strcmp(arg, "expiry-date"))
-		*type = TYPE_EXPIRY_DATE;
-	else
-		die(_("unrecognized --type argument, %s"), arg);
+	/*
+	 * To support '--<type>' style flags, begin with new_type equal to
+	 * opt->defval.
+	 */
+	int new_type = opt->defval;
+	if (!new_type) {
+		if (!strcmp(arg, "bool"))
+			new_type = TYPE_BOOL;
+		else if (!strcmp(arg, "int"))
+			new_type = TYPE_INT;
+		else if (!strcmp(arg, "bool-or-int"))
+			new_type = TYPE_BOOL_OR_INT;
+		else if (!strcmp(arg, "path"))
+			new_type = TYPE_PATH;
+		else if (!strcmp(arg, "expiry-date"))
+			new_type = TYPE_EXPIRY_DATE;
+		else
+			die(_("unrecognized --type argument, %s"), arg);
+	}
+
+	if (type != 0 && type != new_type) {
+		/*
+		 * Complain when there is a new type not equal to the old type.
+		 * This allows for combinations like '--int --type=int' and
+		 * '--type=int --type=int', but disallows ones like '--type=bool
+		 * --int' and '--type=bool
+		 * --type=int'.
+		 */
+		error("only one type at a time.");
+		usage_with_options(builtin_config_usage,
+			builtin_config_options);
+	}
+	type = new_type;

 	return 0;
 }
@@ -110,12 +135,12 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
 	OPT_GROUP(N_("Type")),
-	OPT_CALLBACK('t', "type", &type, N_("type"), N_("value is given this type"), option_parse_type),
-	OPT_SET_INT(0, "bool", &type, N_("value is \"true\" or \"false\""), TYPE_BOOL),
-	OPT_SET_INT(0, "int", &type, N_("value is decimal number"), TYPE_INT),
-	OPT_SET_INT(0, "bool-or-int", &type, N_("value is --bool or --int"), TYPE_BOOL_OR_INT),
-	OPT_SET_INT(0, "path", &type, N_("value is a path (file or directory name)"), TYPE_PATH),
-	OPT_SET_INT(0, "expiry-date", &type, N_("value is an expiry date"), TYPE_EXPIRY_DATE),
+	OPT_CALLBACK('t', "type", NULL, "", N_("value is given this type"), option_parse_type),
+	OPT_CALLBACK_VALUE(0, "bool", N_("value is \"true\" or \"false\""), option_parse_type, TYPE_BOOL),
+	OPT_CALLBACK_VALUE(0, "int", N_("value is decimal number"), option_parse_type, TYPE_INT),
+	OPT_CALLBACK_VALUE(0, "bool-or-int", N_("value is --bool or --int"), option_parse_type, TYPE_BOOL_OR_INT),
+	OPT_CALLBACK_VALUE(0, "path", N_("value is a path (file or directory name)"), option_parse_type, TYPE_PATH),
+	OPT_CALLBACK_VALUE(0, "expiry-date", N_("value is an expiry date"), option_parse_type, TYPE_EXPIRY_DATE),
 	OPT_GROUP(N_("Other")),
 	OPT_BOOL('z', "null", &end_null, N_("terminate values with NUL byte")),
 	OPT_BOOL(0, "name-only", &omit_values, N_("show variable names only")),
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index f5ae80e9ae..e06af3d337 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1615,14 +1615,42 @@ cat >.git/config <<-\EOF &&
 [core]
 foo = true
 number = 10
+big = 1M
 EOF

-test_expect_success 'later legacy specifiers are given precedence' '
-	git config --bool --int core.number >actual &&
-	echo 10 >expect &&
+test_expect_success 'identical modern --type specifiers are allowed' '
+	git config --type=int --type=int core.big >actual &&
+	echo 1048576 >expect &&
 	test_cmp expect actual
 '

+test_expect_success 'identical legacy --type specifiers are allowed' '
+	git config --int --int core.big >actual &&
+	echo 1048576 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'identical mixed --type specifiers are allowed' '
+	git config --int --type=int core.big >actual &&
+	echo 1048576 >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'non-identical modern --type specifiers are not allowed' '
+	test_must_fail git config --type=int --type=bool core.big 2>error &&
+	test_i18ngrep "only one type at a time" error
+'
+
+test_expect_success 'non-identical legacy --type specifiers are not allowed' '
+	test_must_fail git config --int --bool core.big 2>error &&
+	test_i18ngrep "only one type at a time" error
+'
+
+test_expect_success 'non-identical mixed --type specifiers are not allowed' '
+	test_must_fail git config --type=int --bool core.big 2>error &&
+	test_i18ngrep "only one type at a time" error
+'
+
 test_expect_success '--type allows valid type specifiers' '
 	echo "true" >expect &&
 	git config --type=bool core.foo >actual &&
@@ -1635,6 +1663,12 @@ test_expect_success '--no-type unsets type specifiers' '
 	test_cmp expect actual
 '

+test_expect_success 'unset type specifiers may be reset to conflicting ones' '
+	echo 1048576 >expect &&
+	git config --type=bool --no-type --type=int core.big >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--type rejects unknown specifiers' '
 	test_must_fail git config --type=nonsense core.foo 2>error &&
 	test_i18ngrep "unrecognized --type argument" error
--
2.17.0
