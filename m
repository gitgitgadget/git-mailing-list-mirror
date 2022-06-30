Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6363CC433EF
	for <git@archiver.kernel.org>; Thu, 30 Jun 2022 21:20:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237465AbiF3VUC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jun 2022 17:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237454AbiF3VTw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jun 2022 17:19:52 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F244D4ED
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v9so377474wrp.7
        for <git@vger.kernel.org>; Thu, 30 Jun 2022 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=QL4WIYymIluuBa3/EVgzUsNuZp6cgjTPXWiR0Ih1KWQ=;
        b=bI+qj4MV+x0IIUbaEqYyLxoijo202ox9iX5prJU0l3m7YODuUpFlmCa9/niFAvLuTf
         qQD9bjrJ6trUgcgU7IXFKs2hO6DhFylfb84Nkosln64luqx8O7FUnppdm+6MtVUre6Ee
         k2kX/q5PQ4sDDWe+bZaqiouW1f/I6WE4Y6y6TjhdUj11VrH5yQLehpeiIkJrC8cUdpbL
         vCB1UGwsVZrRDvY1YNVG2hwYLAKdsozCeeI6mf0tDeHuVTCwEKC0cPIjTzdWfhiQ0IfJ
         1RRBsr51yGYBZrGtdJ4Ppl/w5XXXqG4cScY6nhXMNVPEENpNtLzX0yb+rdDcSoNwV2GI
         RVNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=QL4WIYymIluuBa3/EVgzUsNuZp6cgjTPXWiR0Ih1KWQ=;
        b=6VUlsl7j6eABMoKIZ5ojuWnN+kkAFXUQ9J0t8cE6P1LDW0sa/gXBQ9/nigS78M8yT3
         FW2sJvZDmAZde0giolBpOhs/JxAdlDE0SbQoPn/U1RHBj0NPuvjTZskY78es1v6Axrr8
         Hj/vzSI2YCpWDDkZuXtV39G1Yq2CQa8aOEYxzsx4Moe5g/nG/1VZFKiQPkKi5UmMRjtT
         B0puPbE8spQ3vUI9NKPdT9+R4ncj0xx+7ZYIyQmVJBqLl6ezbcA6jxOcBzp74l5oC9dr
         aMxN/HgPkxzoH/mr7kFXCqKwb8d+kWQMzCtmOUZ9UHwXA2r4PN7WEOqj+g5lMgXRDpc0
         maEA==
X-Gm-Message-State: AJIora8xVy85OCyVC3n7nqperZb8Wu0JApU03jh5yFElITFsjYqixPUU
        0+kikNQtuM4uZODEmYTeXfDz8no0A7Y=
X-Google-Smtp-Source: AGRyM1t04s0UyPMu0+GKaM34Y7SNJs6tpdgi63eqq3ib0XQoeSxDQI9kLw7KkXyUfZdNk1Ro7NHO+w==
X-Received: by 2002:a05:6000:1a89:b0:21b:83a9:aa6f with SMTP id f9-20020a0560001a8900b0021b83a9aa6fmr10638370wry.33.1656623989294;
        Thu, 30 Jun 2022 14:19:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i8-20020a05600c354800b0039c4e2ff7cfsm4268681wmq.43.2022.06.30.14.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 14:19:48 -0700 (PDT)
Message-Id: <36d45163b6de05886c2c6feb2e626ce423b96b3b.1656623978.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
References: <pull.1282.git.git.1656372017.gitgitgadget@gmail.com>
        <pull.1282.v2.git.git.1656623978.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 30 Jun 2022 21:19:28 +0000
Subject: [PATCH v2 08/18] submodule--helper: report "submodule" as our name in
 some "-h" output
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=
 <avarab@gmail.com>

Change the user-facing "git submodule--helper" commands so that
they'll report their name as being "git submodule". To a user these
commands are internal implementation details, and it doesn't make
sense to emit usage about an internal helper when "git submodule" is
invoked with invalid options.

Before this we'd emit e.g.:

	$ git submodule absorbgitdirs --blah
	error: unknown option `blah'
	usage: git submodule--helper absorbgitdirs [<options>] [<path>...]
	[...]
And:

	$ git submodule set-url -- --
	usage: git submodule--helper set-url [--quiet] <path> <newurl>
	[...]

Now we'll start with "usage: git submodule [...]" in both of those
cases. This change does not alter the "list", "name", "clone",
"config" and "create-branch" commands, those are internal-only (as an
aside; their usage info should probably invoke BUG(...)). This only
changes the user-facing commands.

The "status", "deinit" and "update" commands are not included in this
change, because their usage information already used "submodule"
rather than "submodule--helper".

I don't think it's currently possible to emit some of this usage
information in practice, as git-submodule.sh will catch unknown
options, and e.g. it doesn't seem to be possible to get "add" to emit
its usage information from "submodule--helper".

Though that change may be superfluous now, it's also harmless, and
will allow us to eventually dispatch further into "git
submodule--helper" from git-submodule.sh, while emitting the correct
usage output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1a84ae8efd2..04d2620fce8 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -444,7 +444,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
 
@@ -582,7 +582,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper init [<options>] [<path>]"),
+		N_("git submodule init [<options>] [<path>]"),
 		NULL
 	};
 
@@ -1185,7 +1185,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper summary [<options>] [<commit>] [--] [<path>]"),
+		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
 		NULL
 	};
 
@@ -1349,7 +1349,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
+		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
 		NULL
 	};
 
@@ -2787,7 +2787,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
+		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -2892,7 +2892,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
+		N_("git submodule set-url [--quiet] <path> <newurl>"),
 		NULL
 	};
 
@@ -2931,8 +2931,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path>"),
-		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-d|--default) <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
 		NULL
 	};
 
@@ -3276,7 +3276,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const usage[] = {
-		N_("git submodule--helper add [<options>] [--] <repository> [<path>]"),
+		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
 	};
 
-- 
gitgitgadget

