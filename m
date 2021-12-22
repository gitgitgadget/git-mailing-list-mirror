Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44039C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 00:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbhLVALz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 19:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239036AbhLVALy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 19:11:54 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3060C061747
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 16:11:54 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id l6-20020a633e06000000b0034006440151so294818pga.23
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 16:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XHSrS/kaPjwKPsSMYQe+nrPRwX9vLd5MnW4hyX7se7I=;
        b=fGy4/siwJEyZo5dmyv0P4aVvJjE85AT7I3l6TTfwfTBjLN8JI7XsyS5QcPe8ykXfeu
         0Ug+zeAVWjkYQ0QCzCE63FqjP4bXaMP/Bjn25uM6IhXWoFQ8MykM8xPjETkuv7yUBdxv
         6Nwc0xsRr9es/quzB9CIbi6f+6M2RlSGIn1M10OGNzi3mvXVDzkxST7MwrASilf/lD95
         yyguazl7I7zdlGfv4wg6iMcs3wx5+hYKCdyFBJAba6pNQ2d0I3eQQIMP4n6dwDPp80TK
         dgCJQk2d018SBeRuKTfdjF6CvyMrSQkmfvncJ3BrpFMEo1/op8DEg7LObm+dpJiUM3Uc
         oIkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XHSrS/kaPjwKPsSMYQe+nrPRwX9vLd5MnW4hyX7se7I=;
        b=31PvvvYK8SPtMNPIigIr6owjf8TcwTkKJqS3Nh9wOMQdy2hHkGU28Z/rbfBrvNvlTw
         2/zo3TsKUGzwyKsL8ybs4c3XMYFYDouWRph7bkZHWy+pgJqd1AGwVc8JxsnYeI8ERghz
         +CWbFUMOVLQDzGoel1IFmwiDAaHp8y+1+5CkhIpHe/BXKD8WveSkbnFYOZoj2bwRpQG6
         GUjjSxXHXlbnyEcJ1ZPWAds7xxOgUnJZAFfxZWApxraBoYQ53joyVwH2js8iUp6ISNKB
         wDuTO35acJH2sjV/J7Wr8LY1FJVVQROwVrvXGARLrwdG2xUxkxuK/hS/W5OdmlFrrq39
         0cAg==
X-Gm-Message-State: AOAM530p7e/vGGi0hAi3qltTy3o2GzKUnMk/kf2Fa8kz8VJL2sjx1v3x
        NDJnitYvScr7k9TG6tsuNem46q7NzvCLvbzF0n0C0SKk63qQe5T+4eYuNn8cV2wIRUGhW936iAZ
        GzUaNIPA5rj2QM+dUWN0UZqqarCNSu1mdodY4dOTFizNtCNvvqDyHMCiTSZYmUDk=
X-Google-Smtp-Source: ABdhPJw7Tfq0R7oJ9qbn+4eqii5fXXjrG/VC4LQjsRszT/9MNVFwxU90//qVtohtNLINe6Qkn+1yrIITTeiLpA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:903:2348:b0:141:d60b:ee90 with SMTP
 id c8-20020a170903234800b00141d60bee90mr404571plh.15.1640131914028; Tue, 21
 Dec 2021 16:11:54 -0800 (PST)
Date:   Tue, 21 Dec 2021 16:11:34 -0800
In-Reply-To: <20211222001134.28933-1-chooglen@google.com>
Message-Id: <20211222001134.28933-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211217000235.68996-1-chooglen@google.com> <20211222001134.28933-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.307.g9b7440fafd-goog
Subject: [PATCH v3 3/3] builtin/fetch: die on --negotiate-only and --recurse-submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit ignores the value of --recurse-submodules if
--negotiate-only is given. Since non "no" values of --recurse-submodules
are not supported with --negotiate-only, make cmd_fetch() check for
this invalid combination and die.

This is unlikely to affect internal usage of --negotiate-only, but it
may be helpful for users. We may also want to discourage users from
using --negotiate-only altogether because it was not intended for them.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/fetch-options.txt |  1 +
 builtin/fetch.c                 | 24 ++++++++++++++++++------
 t/t5702-protocol-v2.sh          | 17 +++++++++++++++++
 3 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index e967ff1874..81a100d593 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -71,6 +71,7 @@ configuration variables documented in linkgit:git-config[1], and the
 	ancestors of the provided `--negotiation-tip=*` arguments,
 	which we have in common with the server.
 +
+This is incompatible with `--recurse-submodules[=yes|on-demand]`.
 Internally this is used to implement the `push.negotiate` option, see
 linkgit:git-config[1].
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 883bb1b10c..54f970130e 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -75,6 +75,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules_explicit = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
@@ -166,7 +167,7 @@ static struct option builtin_fetch_options[] = {
 		 N_("prune remote-tracking branches no longer on remote")),
 	OPT_BOOL('P', "prune-tags", &prune_tags,
 		 N_("prune local tags no longer on remote and clobber changed tags")),
-	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
+	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_explicit, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
@@ -1997,12 +1998,23 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
 
+	if (recurse_submodules_explicit != RECURSE_SUBMODULES_DEFAULT)
+		recurse_submodules = recurse_submodules_explicit;
+
 	if (negotiate_only) {
-		/*
-		 * --negotiate-only should never recurse into
-		 * submodules, so there is no need to read .gitmodules.
-		 */
-		recurse_submodules = RECURSE_SUBMODULES_OFF;
+		switch (recurse_submodules_explicit) {
+		case RECURSE_SUBMODULES_OFF:
+		case RECURSE_SUBMODULES_DEFAULT: {
+			/*
+			 * --negotiate-only should never recurse into
+			 * submodules, so there is no need to read .gitmodules.
+			 */
+			recurse_submodules = RECURSE_SUBMODULES_OFF;
+			break;
+		}
+		default:
+			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
+		}
 	}
 
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index d527cf6c49..d099c46499 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -628,6 +628,23 @@ test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
 	test_cmp err.expect err.actual
 '
 
+test_expect_success 'usage: --negotiate-only with --recurse-submodules' '
+	SERVER="server" &&
+	URI="file://$(pwd)/server" &&
+
+	setup_negotiate_only "$SERVER" "$URI" &&
+
+	cat >err.expect <<-\EOF &&
+	fatal: --negotiate-only and --recurse-submodules cannot be used together
+	EOF
+
+	test_must_fail git -c protocol.version=2 -C client fetch \
+		--negotiate-only \
+		--recurse-submodules \
+		origin 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
 test_expect_success 'file:// --negotiate-only' '
 	SERVER="server" &&
 	URI="file://$(pwd)/server" &&
-- 
2.33.GIT

