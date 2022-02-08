Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB73DC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350702AbiBHIlF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238745AbiBHIkd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:33 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974EBC0401F6
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:32 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id y10-20020a17090a134a00b001b8b7e5983bso4586891pjf.6
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eDE9N2lSSvdsSpnLVK+ske7kG+FpFoWcwLzUChjaM1g=;
        b=hlN4Y1n/qfZlFF3G56c3tZhFh47wk/iXl0Yu/SaxsO1zMES1thiXv28z4T3qXHHdkr
         HlmA4ZoaATsf+LpIhYbVKtypqXIXHuaz3VvQRqZ5ELfI8ww/NE+bxlCBjsi5D+0yRr2B
         qUMi+rGEBQGxjjASqM6P0r+RxfflXoP24IlJM8s5pa6KUAIlDmY8EA6JKTyDx5Mg5pSY
         7p6krfpTw/muVU59yGd0U8Wn8MngHdElHncuHaPRkxl5S08A6aFbXaHGC8siIP3H6KSa
         fIHPT4GtD0P7m5tR5FYMchk9dL+UGX7tiRnn7abs3+oI2g/fiYLLymdcxc1rB8KXWjzh
         r8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eDE9N2lSSvdsSpnLVK+ske7kG+FpFoWcwLzUChjaM1g=;
        b=BbN0ZmX0R50+t/kBxHLxSfxuJ+rUTGI0q3K5rlSt5YQ70X9r82b1CR0GEG3epyo78A
         ID7nqcpDHzcbd9gt3QwgKkGVplctJkj2YRXkq/QFfc8i6FObWNHpbSKzBrZhal2L1b48
         6kGqIycw0FQ6hIxwiap1mzYjsfaNDTx7d5YDxbq30xX7Eax07p4r7C6df1+f2KcvHmGQ
         Y4gSLpranrwOzkZr3YRoe0AzbGQgd2Q22dgnSNZGYbSiIerOxAQPdN7c0UUwzPPVirnE
         o3nHhFsyw5qXFlGPdFCrs4nn16nOdPwmVvE2PiR/hywfcGKdagNlAN3AFP+8NrfGJ6tZ
         36oQ==
X-Gm-Message-State: AOAM531FsvTCXET7DAdcKcqeSDiJqphn6XxJ80xAAvYSW7R5aLmp4HDT
        ztP2A8+afv83W9Skwn2PcHeXolUKdUYXKK4nigKcNAQ/S/+D7GvJQq4UzsKs/Pm8atqGhd7w2w5
        ckiqDTboRJj/H6l+lqPTE+RqWKdv1gAF4c2xfZO50ceE3zuVuNVaNEQnLgcj7PJA=
X-Google-Smtp-Source: ABdhPJwy5mTjS9o9Fnaj2/KgRu292FklKNisFCq4OzCtIBvaw1ZO+q9dsRnWIYiCu42Xp0AmqBIC1Pr5Jp+yxw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4544:: with SMTP id
 r4mr163174pjm.186.1644309632029; Tue, 08 Feb 2022 00:40:32 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:50 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-15-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 14/16] submodule--helper update-clone: learn --init
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach "git submodule--helper update-clone" the --init flag and remove
the corresponding shell code.

When the `--init` flag is passed to the subcommand, we do not spawn a
new subprocess and call `submodule--helper init` on the submodule paths,
because the Git machinery is not able to pick up the configuration
changes introduced by that init call. So we instead run the
`init_submodule_cb()` callback over each submodule in the same process.

[1] https://lore.kernel.org/git/CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VHPGREmDVObA@mail.gmail.com/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 26 ++++++++++++++++++++++++++
 git-submodule.sh            |  9 +++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a05aea5cd6..5635f0c48b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1989,6 +1989,7 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 
 	int max_jobs;
+	unsigned int init;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { \
 	.list = MODULE_LIST_INIT, \
@@ -2483,6 +2484,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
 
 	struct option module_update_clone_options[] = {
+		OPT_BOOL(0, "init", &opt.init,
+			 N_("initialize uninitialized submodules before update")),
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
@@ -2536,6 +2539,29 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		opt.warn_if_uninitialized = 1;
 
+	if (opt.init) {
+		struct module_list list = MODULE_LIST_INIT;
+		struct init_cb info = INIT_CB_INIT;
+
+		if (module_list_compute(argc, argv, opt.prefix,
+					&pathspec, &list) < 0)
+			return 1;
+
+		/*
+		 * If there are no path args and submodule.active is set then,
+		 * by default, only initialize 'active' modules.
+		 */
+		if (!argc && git_config_get_value_multi("submodule.active"))
+			module_list_active(&list);
+
+		info.prefix = opt.prefix;
+		info.superprefix = opt.recursive_prefix;
+		if (opt.quiet)
+			info.flags |= OPT_QUIET;
+
+		for_each_listed_submodule(&list, init_submodule_cb, &info);
+	}
+
 	return update_submodules(&opt);
 }
 
diff --git a/git-submodule.sh b/git-submodule.sh
index aa9c898e1c..3ccf2388bf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -347,14 +347,11 @@ cmd_update()
 		shift
 	done
 
-	if test -n "$init"
-	then
-		cmd_init "--" "$@" || return
-	fi
-
 	{
-	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
+		${GIT_QUIET:+--quiet} \
 		${progress:+"--progress"} \
+		${init:+--init} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
-- 
2.33.GIT

