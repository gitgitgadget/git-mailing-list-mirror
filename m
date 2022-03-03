Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20EA9C433FE
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiCCA64 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiCCA6u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:50 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50616154D39
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:58:05 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id x17-20020a17090ab01100b001bbffb2c5f3so4322015pjq.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oh4NzP7o+omfUkI90fORdWBXZyrZR0psuZbukZiUY/E=;
        b=fIUbgsvN8Y6f+T6ySU7mXZNivy2Dahk388rDez4pWYs8cXoxtJtp/hj+dJ0RhQTTaa
         FSKPvwIkno75wsfU1klu8/wPepg3iwgidlyUeLHEqDrFQJgYApW3pFtC5b+ajY0maH64
         Ehnpg+mWh/ZT+65RmEkSugp2Gnd/nIug+yCL+wElxoVX3ifkq6ofAy12i7DVn35U1rnP
         qd4AY7kk+YeDipKE3sqbjdmRiO/2ZHIdt3UWYvBRt1rk5oY5mctfLuesrCE67TSdTXfp
         FqDVH/UhQAnq+25SSZ7stFs+BJz9OnlnRisDT9QPpeW+NLvroxip4vWP1mfP+rwLRfbf
         QbvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oh4NzP7o+omfUkI90fORdWBXZyrZR0psuZbukZiUY/E=;
        b=YVThtaEXDjK6cI9yKqAdrNLO3wry08tsMFftw3eQ0lX0HjX2GbrIuKYY82wOoQ+5/S
         r9ST4+HGi4CQGTVlbplPxWdxyppPtDkSYRYVQDmwQyBMzEy4pzHrp86skwdlIWFUFuqT
         Q2onf1632FWA3QuSj1TDE24EIjtA/DsGVwzsQl7jPd7UvqjZ7DDa2j3KzVVQe9pLkbWi
         7TGHOTOgqAymax/cDXDa6aIm9cOBT7MN8rvrMQXbLv8g6p/uqQc8ZtTIWEwviZ2iHdYt
         XBRVHTVQAHEWEQLIHkr2E5taTSWnsU+cWnqZ6yhdeKNrvzzz2e3ZWQsLj/fimwzWCzBP
         X3XA==
X-Gm-Message-State: AOAM531ulZ1Re6/ZNpkP3P/TLMMzhtKYCFjy/5gRDMxQ8/E5TFLulKyh
        9fiGSzrEtQs2zLCwJyZWl0hTPRO8br+s5bWZZAkzX6C0/w7mUNvSmys/i9ISSYT5zB3lnB4r4vq
        MKdl+D2ta4X0jN9O61DbM220V3TE3uHETIORjUn0+5QTpXfuvv7wg6TY8aZM/Slw=
X-Google-Smtp-Source: ABdhPJwp+bjwoMV4FRM5tqSELZQO51QdhhDSa2BVlQhlE9MZw5qtKbZ1fqu4nz4wzljd2fNoBe2SV1kOGwGSNg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4f43:b0:1bc:7e5c:e024 with SMTP
 id pj3-20020a17090b4f4300b001bc7e5ce024mr830929pjb.0.1646269084010; Wed, 02
 Mar 2022 16:58:04 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:25 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-12-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 11/13] submodule--helper update-clone: learn --init
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
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
index 69ada7f914..296ab80bf2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2000,6 +2000,7 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 
 	int max_jobs;
+	unsigned int init;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { \
 	.list = MODULE_LIST_INIT, \
@@ -2509,6 +2510,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	int ret;
 
 	struct option module_update_clone_options[] = {
+		OPT_BOOL(0, "init", &suc.init,
+			 N_("initialize uninitialized submodules before update")),
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
@@ -2567,6 +2570,29 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
+	if (suc.init) {
+		struct module_list list = MODULE_LIST_INIT;
+		struct init_cb info = INIT_CB_INIT;
+
+		if (module_list_compute(argc, argv, suc.prefix,
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
+		info.prefix = suc.prefix;
+		info.superprefix = suc.recursive_prefix;
+		if (suc.quiet)
+			info.flags |= OPT_QUIET;
+
+		for_each_listed_submodule(&list, init_submodule_cb, &info);
+	}
+
 	ret = update_submodules(&suc);
 	list_objects_filter_release(&filter_options);
 	return ret;
diff --git a/git-submodule.sh b/git-submodule.sh
index 23ebd90892..51be7c7f7e 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -361,14 +361,11 @@ cmd_update()
 		usage
 	fi
 
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

