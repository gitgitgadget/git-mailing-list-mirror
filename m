Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B621C433FE
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 00:45:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiAMAph (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 19:45:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiAMApd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 19:45:33 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99362C061751
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:45:33 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y15-20020a17090a600f00b001b3501d9e7eso8689481pji.8
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 16:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IULwmi41sgvITPhBGZbBU9wMWB/m4c904MX2EfkXY3c=;
        b=ETy5QZh4OPVH7V0m2Z811yAfngxCl6ifjvJ4GARx6ycC6Wajs35pJliDojwI04ewZ/
         u4wQU+sUXYvG7yEdhAzinwUldRFdhz5djtj1LHAec0ZEaO6/b/PlzjqMA+p4y+M3DuC4
         XsOfHAucj5dKbeZhbl4DSgS/CraZq4fzooKRhRb4iWwYug9zxGfi1amdjPweQBkV+F8Y
         5Z8KNFpE4FcmOyXnCcZHeHAYX4DR0YxcWiYheaB0bZezmO8NKRAg3hWI5YHyF596kPTv
         9MmF1QoMEGjCIzVuSPHKlyFS3rbdGo9a78Nrz+R0QuSX64WxE0G8X2MOY9bwQ7prM7UH
         aRMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IULwmi41sgvITPhBGZbBU9wMWB/m4c904MX2EfkXY3c=;
        b=Yh6VNQ+Phwi5T2OvFvwUo7ObjAWkAZh/gOR8fwAWwX0niUX6201CZl0KJP/bbsyYFJ
         qzN+DjFsKVeynrtwyY1bt3ipLL5bkNlO8rxdfD/W1ECDLDJ5Xt6zhL3rNRO5LZJnK5PX
         zWBqOVfd/BtDuhIk8aJp1drnTUCUC/pIAEEF/eaKl44SmKiBpW86qXrnFlb7s5HWMw6X
         a1dkBt74ib6egth/92YKeQ0oi3TKWOI/RHzke9XyL05yKJ5nn9+E8jDFmqDj5rY82/qU
         sdePqhgio5zS2icwottuC14D1vQCtX5kqPQzepn+dWAX1Sh60CR/Ritqmf/3S/cL9ZWn
         kWNw==
X-Gm-Message-State: AOAM532/eRy+M0MPXkzggzI586OY03rMhG3wlomXgxwYApogXOrOE/6/
        /zPLJdZxlZt+jkj3rmsn0Q15hEjCXCsbBPQMqw7/V7XShtshZ1vBFFI7YwqWEMbR4iqE5NFM8/J
        6Kku46tLGckDb2/XFaKjQQAy64jXcYMmqI5VSZqe3aYrKs5EupMLUChJfMAT+f3g=
X-Google-Smtp-Source: ABdhPJy+nELFoI1z5VW0iWw79yGUyreepQFjVSdGC9OqRBxvBpWszoUEty/HIiSGn67msdMd3UQ3jXEuXxWfcw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a62:8c8e:0:b0:4c1:d0c9:a7a7 with SMTP id
 m136-20020a628c8e000000b004c1d0c9a7a7mr1904407pfd.54.1642034732949; Wed, 12
 Jan 2022 16:45:32 -0800 (PST)
Date:   Wed, 12 Jan 2022 16:45:01 -0800
In-Reply-To: <20220113004501.78822-1-chooglen@google.com>
Message-Id: <20220113004501.78822-4-chooglen@google.com>
Mime-Version: 1.0
References: <20211222001134.28933-1-chooglen@google.com> <20220113004501.78822-1-chooglen@google.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v4 3/3] fetch --negotiate-only: do not update submodules
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`git fetch --negotiate-only` is an implementation detail of push
negotiation and, unlike most `git fetch` invocations, does not actually
update the main repository. Thus it should not update submodules even
if submodule recursion is enabled.

This is not just slow, it is wrong e.g. push negotiation with
"submodule.recurse=true" will cause submodules to be updated because it
invokes `git fetch --negotiate-only`.

Fix this by disabling submodule recursion if --negotiate-only was given.
Since this makes --negotiate-only and --recurse-submodules incompatible,
check for this invalid combination and die.

This does not use the "goto cleanup" introduced in the previous commit
because we want to recurse through submodules whenever a ref is fetched,
and this can happen without introducing new objects.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/fetch-options.txt |  1 +
 builtin/fetch.c                 | 24 +++++++++++++++++++++++-
 t/t5516-fetch-push.sh           | 12 ++++++++++++
 t/t5702-protocol-v2.sh          | 12 ++++++++++++
 4 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index e967ff1874..f903683189 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -71,6 +71,7 @@ configuration variables documented in linkgit:git-config[1], and the
 	ancestors of the provided `--negotiation-tip=*` arguments,
 	which we have in common with the server.
 +
+This is incompatible with `--recurse-submodules=[yes|on-demand]`.
 Internally this is used to implement the `push.negotiate` option, see
 linkgit:git-config[1].
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7bbff5a029..8b8bde8809 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -76,6 +76,7 @@ static struct transport *gtransport;
 static struct transport *gsecondary;
 static const char *submodule_prefix = "";
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
 static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
 static int shown_url = 0;
 static struct refspec refmap = REFSPEC_INIT_FETCH;
@@ -167,7 +168,7 @@ static struct option builtin_fetch_options[] = {
 		 N_("prune remote-tracking branches no longer on remote")),
 	OPT_BOOL('P', "prune-tags", &prune_tags,
 		 N_("prune local tags no longer on remote and clobber changed tags")),
-	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
+	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
 		    N_("control recursive fetching of submodules"),
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
@@ -2014,6 +2015,27 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
+
+	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
+		recurse_submodules = recurse_submodules_cli;
+
+	if (negotiate_only) {
+		switch (recurse_submodules_cli) {
+		case RECURSE_SUBMODULES_OFF:
+		case RECURSE_SUBMODULES_DEFAULT: {
+			/*
+			 * --negotiate-only should never recurse into
+			 * submodules. Skip it by setting recurse_submodules to
+			 * RECURSE_SUBMODULES_OFF.
+			 */
+			recurse_submodules = RECURSE_SUBMODULES_OFF;
+			break;
+		}
+		default:
+			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
+		}
+	}
+
 	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
 		int *sfjc = submodule_fetch_jobs_config == -1
 			    ? &submodule_fetch_jobs_config : NULL;
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2f04cf9a1c..87881726ed 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -229,6 +229,18 @@ test_expect_success 'push with negotiation proceeds anyway even if negotiation f
 	test_i18ngrep "push negotiation failed" err
 '
 
+test_expect_success 'push with negotiation does not attempt to fetch submodules' '
+	mk_empty submodule_upstream &&
+	test_commit -C submodule_upstream submodule_commit &&
+	git submodule add ./submodule_upstream submodule &&
+	mk_empty testrepo &&
+	git push testrepo $the_first_commit:refs/remotes/origin/first_commit &&
+	test_commit -C testrepo unrelated_commit &&
+	git -C testrepo config receive.hideRefs refs/remotes/origin/first_commit &&
+	git -c submodule.recurse=true -c protocol.version=2 -c push.negotiate=1 push testrepo refs/heads/main:refs/remotes/origin/main 2>err &&
+	! grep "Fetching submodule" err
+'
+
 test_expect_success 'push without wildcard' '
 	mk_empty testrepo &&
 
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 710f33e2aa..1b9023d3f0 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -628,6 +628,18 @@ test_expect_success 'usage: --negotiate-only without --negotiation-tip' '
 	test_cmp err.expect err.actual
 '
 
+test_expect_success 'usage: --negotiate-only with --recurse-submodules' '
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

