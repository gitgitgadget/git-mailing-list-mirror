Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3768D34F48B
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849623; cv=none; b=N8cb8JCreOjMgYVq3UedHkjgmUNtI693gGi9aAQdtXyLwWES0yxu5xGzCspzL85DbAMf+0fiRAw5R0oCqh2+9+u2PKy2pDZ7HxmG4BfwUYvXaMPO1jYmGsdhg8uDvSOvhgwDQYinDpiUd6iNrVJL1QEaN8/59EHXlssKkx+Ljxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849623; c=relaxed/simple;
	bh=zXKst7PDEGA5hwlnqT25oVJB9pGvRvrTlHZ3DZT3I7Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=RAb9UFw4I8lBgUNzDmX9Fr8zr8ZcVXR8AZVQpYjgif5MRRucf7hEHXYs8nDlKtJvpHcmIWmKDNWDxGqowdAXAPSFjw9/REYDUO1hR3qKKHzNFe3G4CJRLVNZJ8n8Kb0fZEqNuZr2Sd4PmUgbLwB5qtXiAeit7/mdxbodZdURD8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YspZrAdG; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YspZrAdG"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-79801df3e42so51419767b3.0
        for <git@vger.kernel.org>; Mon, 23 Feb 2026 04:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771849621; x=1772454421; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZX+DOwwoKXqpCYS7Fm17hesncQxPwKshUhjWEJERco0=;
        b=YspZrAdGPO0kpxUT/x7EsEIpQMp4F/FAfjWy2DJm8QbDe460+oOF0anRttl3kWf4lN
         54mqtmqrH2KlMP1XyzOKE6eLd85YgdVViXeaYcSJ8PL93WK128+L6VQFFhqW2e3as6j+
         OYbPXdd0EErNM7yrAmekSBYRJNNxzsL+k+GAExd9CMY0/0Pff4UKtZWSKfVytLEX6/Uz
         0zjWaGlUM6lWc9deWjLBbgcHTlJl04idxenp9GhhFZTEk0KJf/zGyRVHUWKpE2fbNJaT
         HY175U33A9IUwLxOVD+rMvNDlTazb1HKw2CQfyqhx0WThYS2617e6TcfAcvDGe6gsBEg
         lwDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771849621; x=1772454421;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZX+DOwwoKXqpCYS7Fm17hesncQxPwKshUhjWEJERco0=;
        b=nsRmSq8E9jMcZ/WmyeaZCbd/PBwuDBc1mFuJzSzPDGnU29z5kNwDO1EZfTA+7+zBH1
         aDyRwasft5my4yAI5TU+ZzJ5QajamCzTwVitOga7/R/pyA8t5slWHQeJzcvibsrMAV9M
         H9nD4RJKNuNyWnficUupD/dx3o4TesaG1EuIx/ypb8yPa2k0N/0ilQJqr5PA44quuO5L
         Elrbtrlj+1cc6u9xc46TqC1GRirwzbUlQOjFcnm3xVhGvyJuDPiWq1QXUQd3YyltQw5Q
         oWNLbwmIS/WSSRxYcwB17U9vLFE0SFH/kkCun6LtP1g2XIgKBf1eOu7Y+yGiQ2AzJ5q8
         iSzg==
X-Gm-Message-State: AOJu0Yz0eMH+EexQgurzNcJILEo9eb2qMcE9+8nhZMTXYu/nD7gPKsxt
	fQ4ZcpcD6O9/ve8ylXOuQpHYDAz0anip7BsDoAsZ7cMSWBxF4pcfthISlq3XAQ==
X-Gm-Gg: ATEYQzz+xV0yK44xEbJ66XnGNc70wfsL+RrNGkbERa49IIPIT36JqyagrwrDnpcr/nW
	P6jidtDb6QX4isNwz8zpEZK9ERROhpCUdOp3WOq1BQ4Q80FVOFtJogwW81xmQ48meUfJRhtR8wV
	bTRhJTX5QsHMtMLK6q/2kWdbzfwjKYUe6N68/pTnkOWYYJ2AeeDXSlle2vmFnYVvvS91lPk6Uyk
	oubDoGYdWMZHGGPXGQbt1SqIKFu/6qGnZe1aLvd/iZ3pXTTS/g4f7LgYhSl3iGUiDd/BtlBhUsy
	OG4P44qc7EWen9+zXuKC8VFz6R4uqTOUNoB6LwpowcAK49AfT12ynB3LBsciyik5kYEXZBT0PNU
	vDj1vol7eDuFuJ+Cg83TZfNn5qrZ/mlwuCDZ/i8sFOv4lpoJFBvcxa9RnThtSEBoYAER2hs3y/4
	2a0GwSSth2SHMv2ZfRJ/Bu31s0ZA==
X-Received: by 2002:a05:690c:6f01:b0:792:7745:72fc with SMTP id 00721157ae682-79807cf7a6emr105532817b3.21.1771849620778;
        Mon, 23 Feb 2026 04:27:00 -0800 (PST)
Received: from [127.0.0.1] ([20.171.125.131])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982db94290sm31276087b3.1.2026.02.23.04.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 04:27:00 -0800 (PST)
Message-Id: <2b2a325b55a906cc8eba97f2020684f44c42bfc5.1771849615.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
References: <pull.2044.v2.git.1771026918.gitgitgadget@gmail.com>
	<pull.2044.v3.git.1771849615.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 23 Feb 2026 12:26:45 +0000
Subject: [PATCH v3 03/13] config: make 'git config list --type=<X>' work
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
Cc: gitster@pobox.com,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    Patrick Steinhardt <ps@pks.im>,
    Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

Previously, the --type=<X> argument to 'git config list' was ignored and
did nothing. Now, we add the use of format_config() to the
show_all_config() function so each key-value pair is attempted to be
parsed. This is our first use of the 'gently' parameter with a nonzero
value.

When listing multiple values, our initial settings for the output format
is different. Add a new init helper to specify the fact that keys should
be shown and also add the default delimiters as they were unset in some
cases.

Our intention is that if there is an error in parsing, then the row is
not output. This is necessary to avoid the caller needing to build their
own validator to understand the difference between valid, canonicalized
types and other raw string values. The raw values will always be
available to the user if they do not specify the --type=<X> option.

The current behavior is more complicated, including error messages on
bad parsing or potentially complete failure of the command.  We add
tests at this point that demonstrate the current behavior so we can
witness the fix in future changes that parse these values quietly and
gently.

This is a change in behavior! We are starting to respect an option that
was previously ignored, leading to potential user confusion. This is
probably still a good option, since the --type argument did not change
behavior at all previously, so users can get the behavior they expect by
removing the --type argument or adding the --no-type argument.

t1300-config.sh is updated with the current behavior of this formatting
logic to justify the upcoming refactoring of format_config() that will
incrementally fix some of these cases to be more user-friendly.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-config.adoc |  3 ++
 builtin/config.c              | 35 +++++++------
 t/t1300-config.sh             | 97 ++++++++++++++++++++++++++++++++++-
 3 files changed, 119 insertions(+), 16 deletions(-)

diff --git a/Documentation/git-config.adoc b/Documentation/git-config.adoc
index ac3b536a15..5300dd4c51 100644
--- a/Documentation/git-config.adoc
+++ b/Documentation/git-config.adoc
@@ -240,6 +240,9 @@ Valid `<type>`'s include:
   that the given value is canonicalize-able as an ANSI color, but it is written
   as-is.
 +
+If the command is in `list` mode, then the `--type <type>` argument will apply
+to each listed config value. If the value does not successfully parse in that
+format, then it will be omitted from the list.
 
 --bool::
 --int::
diff --git a/builtin/config.c b/builtin/config.c
index b4c4228311..4c4c791883 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -318,21 +318,12 @@ static int show_all_config(const char *key_, const char *value_,
 {
 	const struct config_display_options *opts = cb;
 	const struct key_value_info *kvi = ctx->kvi;
+	struct strbuf formatted = STRBUF_INIT;
 
-	if (opts->show_origin || opts->show_scope) {
-		struct strbuf buf = STRBUF_INIT;
-		if (opts->show_scope)
-			show_config_scope(opts, kvi, &buf);
-		if (opts->show_origin)
-			show_config_origin(opts, kvi, &buf);
-		/* Use fwrite as "buf" can contain \0's if "end_null" is set. */
-		fwrite(buf.buf, 1, buf.len, stdout);
-		strbuf_release(&buf);
-	}
-	if (!opts->omit_values && value_)
-		printf("%s%c%s%c", key_, opts->delim, value_, opts->term);
-	else
-		printf("%s%c", key_, opts->term);
+	if (format_config(opts, &formatted, key_, value_, kvi, 1) >= 0)
+		fwrite(formatted.buf, 1, formatted.len, stdout);
+
+	strbuf_release(&formatted);
 	return 0;
 }
 
@@ -872,6 +863,19 @@ static void display_options_init(struct config_display_options *opts)
 	}
 }
 
+static void display_options_init_list(struct config_display_options *opts)
+{
+	opts->show_keys = 1;
+
+	if (opts->end_nul) {
+		display_options_init(opts);
+	} else {
+		opts->term = '\n';
+		opts->delim = ' ';
+		opts->key_delim = '=';
+	}
+}
+
 static int cmd_config_list(int argc, const char **argv, const char *prefix,
 			   struct repository *repo UNUSED)
 {
@@ -890,7 +894,7 @@ static int cmd_config_list(int argc, const char **argv, const char *prefix,
 	check_argc(argc, 0, 0);
 
 	location_options_init(&location_opts, prefix);
-	display_options_init(&display_opts);
+	display_options_init_list(&display_opts);
 
 	setup_auto_pager("config", 1);
 
@@ -1321,6 +1325,7 @@ static int cmd_config_actions(int argc, const char **argv, const char *prefix)
 
 	if (actions == ACTION_LIST) {
 		check_argc(argc, 0, 0);
+		display_options_init_list(&display_opts);
 		if (config_with_options(show_all_config, &display_opts,
 					&location_opts.source, the_repository,
 					&location_opts.options) < 0) {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 9850fcd5b5..dc744c0bae 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -2459,9 +2459,15 @@ done
 
 cat >.git/config <<-\EOF &&
 [section]
-foo = true
+foo = True
 number = 10
 big = 1M
+path = ~/dir
+red = red
+blue = Blue
+date = Fri Jun 4 15:46:55 2010
+missing=:(optional)no-such-path
+exists=:(optional)expect
 EOF
 
 test_expect_success 'identical modern --type specifiers are allowed' '
@@ -2503,6 +2509,95 @@ test_expect_success 'unset type specifiers may be reset to conflicting ones' '
 	test_cmp_config 1048576 --type=bool --no-type --type=int section.big
 '
 
+test_expect_success 'list --type=int shows only canonicalizable int values' '
+	cat >expect <<-EOF &&
+	section.number=10
+	section.big=1048576
+	EOF
+
+	test_must_fail git config ${mode_prefix}list --type=int
+'
+
+test_expect_success 'list --type=bool shows only canonicalizable bool values' '
+	cat >expect <<-EOF &&
+	section.foo=true
+	section.number=true
+	section.big=true
+	EOF
+
+	test_must_fail git config ${mode_prefix}list --type=bool
+'
+
+test_expect_success 'list --type=bool-or-int shows only canonicalizable values' '
+	cat >expect <<-EOF &&
+	section.foo=true
+	section.number=10
+	section.big=1048576
+	EOF
+
+	test_must_fail git config ${mode_prefix}list --type=bool-or-int
+'
+
+test_expect_success 'list --type=path shows only canonicalizable path values' '
+	# TODO: handling of missing path is incorrect here.
+	cat >expect <<-EOF &&
+	section.foo=True
+	section.number=10
+	section.big=1M
+	section.path=$HOME/dir
+	section.red=red
+	section.blue=Blue
+	section.date=Fri Jun 4 15:46:55 2010
+	section.missing=section.exists=expect
+	EOF
+
+	git config ${mode_prefix}list --type=path >actual 2>err &&
+	test_cmp expect actual &&
+	test_must_be_empty err
+'
+
+test_expect_success 'list --type=expiry-date shows only canonicalizable dates' '
+	cat >expecterr <<-EOF &&
+	error: '\''True'\'' for '\''section.foo'\'' is not a valid timestamp
+	error: '\''~/dir'\'' for '\''section.path'\'' is not a valid timestamp
+	error: '\''red'\'' for '\''section.red'\'' is not a valid timestamp
+	error: '\''Blue'\'' for '\''section.blue'\'' is not a valid timestamp
+	error: '\'':(optional)no-such-path'\'' for '\''section.missing'\'' is not a valid timestamp
+	error: '\'':(optional)expect'\'' for '\''section.exists'\'' is not a valid timestamp
+	EOF
+
+	git config ${mode_prefix}list --type=expiry-date >actual 2>err &&
+
+	# section.number and section.big parse as relative dates that could
+	# have clock skew in their results.
+	test_grep section.big actual &&
+	test_grep section.number actual &&
+	test_grep "section.date=$(git config --type=expiry-date section.$key)" actual &&
+	test_cmp expecterr err
+'
+
+test_expect_success 'list --type=color shows only canonicalizable color values' '
+	cat >expect <<-EOF &&
+	section.number=<>
+	section.red=<RED>
+	section.blue=<BLUE>
+	EOF
+
+	cat >expecterr <<-EOF &&
+	error: invalid color value: True
+	error: invalid color value: 1M
+	error: invalid color value: ~/dir
+	error: invalid color value: Fri Jun 4 15:46:55 2010
+	error: invalid color value: :(optional)no-such-path
+	error: invalid color value: :(optional)expect
+	EOF
+
+	git config ${mode_prefix}list --type=color >actual.raw 2>err &&
+	test_decode_color <actual.raw >actual &&
+	test_cmp expect actual &&
+	test_cmp expecterr err
+'
+
 test_expect_success '--type rejects unknown specifiers' '
 	test_must_fail git config --type=nonsense section.foo 2>error &&
 	test_grep "unrecognized --type argument" error
-- 
gitgitgadget

