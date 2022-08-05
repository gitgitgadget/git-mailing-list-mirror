Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D9CC00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241570AbiHER7j (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 13:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241589AbiHER7U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 13:59:20 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFC5785B7
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 10:59:05 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h13so4050677wrf.6
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=va2tEnY9O2zddWmKDi88vbP6X5+TL1vAPX6Jetcp6hQ=;
        b=TrYsbBTpFFHzsLIcoqY8E1IFXeNeUaurSITA8LBrYbnIK5bQNHFmQku9wH1AOlK2Q0
         mqqwbud45Z8WpYVlYMY94tnarnxaZ644THT9PLqwCMEuZWZeG6YJetPToj5v3F0UyilA
         eJPhqVbWeUOoV960eKsExNa96WoFa7KKRokZqUTvlOm4Xm1uM0aYcSThtiAsTZRf49vM
         HqMwcwH8dWoS9VjNHqeOQDiBsE6Ztk5OqKwB0cbFxyBO/QK5lTalb4YJlBDs3nOgN+Qp
         JPKJwmLN9CNdE9cGSKPTlTHXKZgxxJt/3bAhih8lp9cHPNRMGN3Q9OhQakF5+c4IdERW
         MCcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=va2tEnY9O2zddWmKDi88vbP6X5+TL1vAPX6Jetcp6hQ=;
        b=opU+EGZGWh4ZI7FOD4/djOPvVTQzdq2g6ha3PfANXEKT/1KsZ8iRaf6rxH9mTRWFT5
         Bcgv1aPdYYAJo2O5u89TFZhYOqOs3YbKbgcpuzvFOOm/G2NXZIPzw1uq3W4gTLzw4HxV
         BwWHGAOGHas99M7HDkK8k1RpFYOdTRVGMMhRbvhDLr0IqJQPNF+59Jp62fsgBLgpxB1+
         ZuRE4ViJb19HJpY4JrdcyagaTtFHoUc5uRlfkpqo2jE2+Gs5YtKCqSEjT09S14+LbB9t
         c5TvLtwVIV5AQocQJdDErgmSMqk0u2lRm3ZQBp8eLOvLfnKnhG2hVl4SuR4ygp5BF/2M
         5lrg==
X-Gm-Message-State: ACgBeo3u+JyGEeszsc30lia1TAi/2xW7+hbrd3SL2GVSbO3uaLb/HL31
        tNoHkdsdHkIU6nDW1Dd2mHiTm6AYvnE=
X-Google-Smtp-Source: AA6agR7U4LldLWGOfR/6S21BVGdTe0TBOZcq/5yqhcETQMj77cuz1DEZsA3knra6BhBAfECUauxziw==
X-Received: by 2002:a5d:6241:0:b0:21e:f97f:d0cb with SMTP id m1-20020a5d6241000000b0021ef97fd0cbmr5071194wrv.37.1659722343548;
        Fri, 05 Aug 2022 10:59:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u19-20020a05600c00d300b003a2fde6ef62sm5317188wmm.7.2022.08.05.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 10:59:02 -0700 (PDT)
Message-Id: <7ec2578b90a4e9f0e698bd29d7413e11df819253.1659722324.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
References: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
        <pull.1301.v3.git.1659722323.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Aug 2022 17:58:41 +0000
Subject: [PATCH v3 09/11] log: create log.initialDecorationSet=all
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The previous change introduced the --clear-decorations option for users
who do not want their decorations limited to a narrow set of ref
namespaces.

Add a config option that is equivalent to specifying --clear-decorations
by default.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/config/log.txt |  5 +++++
 Documentation/git-log.txt    |  4 +++-
 builtin/log.c                | 12 ++++++++++++
 t/t4202-log.sh               |  3 +++
 4 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/log.txt b/Documentation/config/log.txt
index 456eb07800c..5250ba45fb4 100644
--- a/Documentation/config/log.txt
+++ b/Documentation/config/log.txt
@@ -18,6 +18,11 @@ log.decorate::
 	names are shown. This is the same as the `--decorate` option
 	of the `git log`.
 
+log.initialDecorationSet::
+	By default, `git log` only shows decorations for certain known ref
+	namespaces. If 'all' is specified, then show all refs as
+	decorations.
+
 log.excludeDecoration::
 	Exclude the specified patterns from the log decorations. This is
 	similar to the `--decorate-refs-exclude` command-line option, but
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index f2ce16fba71..b1285aee3c2 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -59,7 +59,9 @@ used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
 --clear-decorations::
 	When specified, this option clears all previous `--decorate-refs`
 	or `--decorate-refs-exclude` options and relaxes the default
-	decoration filter to include all references.
+	decoration filter to include all references. This option is
+	assumed if the config value `log.initialDecorationSet` is set to
+	`all`.
 
 --source::
 	Print out the ref name given on the command line by which each
diff --git a/builtin/log.c b/builtin/log.c
index 7d35d1ecab1..2e2136020e5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -179,6 +179,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
 {
 	int i;
+	char *value = NULL;
 	struct string_list *include = decoration_filter->include_ref_pattern;
 	const struct string_list *config_exclude =
 			git_config_get_value_multi("log.excludeDecoration");
@@ -190,6 +191,17 @@ static void set_default_decoration_filter(struct decoration_filter *decoration_f
 					   item->string);
 	}
 
+	/*
+	 * By default, decorate_all is disabled. Enable it if
+	 * log.initialDecorationSet=all. Don't ever disable it by config,
+	 * since the command-line takes precedent.
+	 */
+	if (use_default_decoration_filter &&
+	    !git_config_get_string("log.initialdecorationset", &value) &&
+	    !strcmp("all", value))
+		use_default_decoration_filter = 0;
+	free(value);
+
 	if (!use_default_decoration_filter ||
 	    decoration_filter->exclude_ref_pattern->nr ||
 	    decoration_filter->include_ref_pattern->nr ||
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 90800feb0f1..4b2d642d34c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1090,6 +1090,9 @@ test_expect_success '--clear-decorations overrides defaults' '
 	EOF
 	git log --decorate=full --pretty="tformat:%f%d" \
 		--clear-decorations >actual &&
+	test_cmp expect.all actual &&
+	git -c log.initialDecorationSet=all log \
+		--decorate=full --pretty="tformat:%f%d" >actual &&
 	test_cmp expect.all actual
 '
 
-- 
gitgitgadget

