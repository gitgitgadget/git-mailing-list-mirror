Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66AA5C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 20:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345918AbiARUtu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 15:49:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233264AbiARUtt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 15:49:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F90C06161C
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 12:49:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 4-20020a250304000000b006137f4a9920so32446ybd.6
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 12:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=bP/WVwPsvmkHAObUgzg70UT98y1JR/bnM4TfSmTG1i8=;
        b=WCEHMDUEp52ohnaqTSI5AJiayk5HatPmVeBkXVuiFP36MhNFMJ+FolXrOOmIONJrhI
         iw9CjS+gfvJdE9SJC0v1nShx/XavVcXB2TFdrrAWQCjtE4/NBjH1i1PgOgZ1mP1BFxvv
         n8uubd1NiTXJnU/XYxRnWeNxhn8lg5HNdaaMfhaeSq/rVZD0pAueXfsv7OQpVrfn7mDJ
         yMtuN+MuOKSZY9pJQ/aFAUJn2xvBzeam9zCULlHZz7lWGLUFKX+11msgZYSUtPhT6Va8
         Z99FNleZFISsc9YfNY+P5AwgmV1ThNWCW4Zl1LTwFsIGXZliRW6vrCsveBGpUj+INcYg
         k+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=bP/WVwPsvmkHAObUgzg70UT98y1JR/bnM4TfSmTG1i8=;
        b=nhh4RjbWsWm1GB80xGbJfkF/kit6Abi6MuGrTQdX/JMIpPhB6AjhuBVmEw3ku7KWnW
         XiSpoBhkHoJLe/+Iho2SJ8DQQQ09HDs3Z0JVSXwL3RUwlh3NY3SnjHqStDnrs2mKjDiG
         sOfehcbTyl6M7P/+MJo9XCnnTY2eLpsHITyzBrbp+aHNy9IUU13BhpYlzm3mSaa8c4MW
         9HUfh3fCRhPjy8L1vNa/1vw5qxwsFucQJXKfBZzm3CUb2tZIu5MPVTxsHvBdPlwttLrG
         Ko6Ob8nY98Su4elH/cVgWpP4KlVGeC2+fv1EY3711C4ATZ6xJpbRBxCBY9Hnh7tfjzqk
         MKyw==
X-Gm-Message-State: AOAM530tK+LO+K8dH6KNGP8l+YHvDdW7mBAiNZbUvoptPXmtnyEH5w3K
        7WfQ32uxCgLsqImGIb09iGKDc8d4de+4NE/E9cDUdJ/ixUWMl61+hDXJYipOLCVzDX9vm3v+vFY
        OhQgSgfiXPCcJwxvw7L0V4sYsxErDQShpLryI/F1IUNQ980oRJjpN/4Gi3lSr3sw=
X-Google-Smtp-Source: ABdhPJz1Rs+Relx0YYVSJ1TfTNcTzV5hBQhVPyxcjB0xPOVNK+LBGtYI9gdVuy0UC/t4EY0ugCEfL9PphYT+Ug==
X-Received: from lunarfall.svl.corp.google.com ([2620:15c:2ce:200:f64c:bb69:f36f:3ee9])
 (user=steadmon job=sendgmr) by 2002:a05:6902:1202:: with SMTP id
 s2mr36320604ybu.320.1642538988756; Tue, 18 Jan 2022 12:49:48 -0800 (PST)
Date:   Tue, 18 Jan 2022 12:49:46 -0800
In-Reply-To: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
Message-Id: <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
Mime-Version: 1.0
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH] branch,checkout: fix --track usage strings
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As =C3=86var pointed out in [1], the use of PARSE_OPT_LITERAL_ARGHELP with =
a
list of allowed parameters is not recommended. Both git-branch and
git-checkout were changed in d311566 (branch: add flags and config to
inherit tracking, 2021-12-20) to use this discouraged combination for
their --track flags.

Fix this by removing PARSE_OPT_LITERAL_ARGHELP, and changing the arghelp
to simply be "mode". Users may discover allowed values in the manual
pages.

[1]: https://lore.kernel.org/git/220111.86a6g3yqf9.gmgdl@evledraar.gmail.co=
m/

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/branch.c   | 4 ++--
 builtin/checkout.c | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 2251e6a54f..0c8d8a8827 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -638,9 +638,9 @@ int cmd_branch(int argc, const char **argv, const char =
*prefix)
 		OPT__VERBOSE(&filter.verbose,
 			N_("show hash and subject, give twice for upstream branch")),
 		OPT__QUIET(&quiet, N_("suppress informational messages")),
-		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
+		OPT_CALLBACK_F('t', "track",  &track, N_("mode"),
 			N_("set branch tracking configuration"),
-			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+			PARSE_OPT_OPTARG,
 			parse_opt_tracking_mode),
 		OPT_SET_INT_F(0, "set-upstream", &track, N_("do not use"),
 			BRANCH_TRACK_OVERRIDE, PARSE_OPT_HIDDEN),
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 94814c37b4..6a5dd2a2a2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1549,9 +1549,9 @@ static struct option *add_common_switch_branch_option=
s(
 {
 	struct option options[] =3D {
 		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named co=
mmit")),
-		OPT_CALLBACK_F('t', "track",  &opts->track, "direct|inherit",
-			N_("set up tracking mode (see git-pull(1))"),
-			PARSE_OPT_OPTARG | PARSE_OPT_LITERAL_ARGHELP,
+		OPT_CALLBACK_F('t', "track",  &opts->track, N_("mode"),
+			N_("set branch tracking configuration"),
+			PARSE_OPT_OPTARG,
 			parse_opt_tracking_mode),
 		OPT__FORCE(&opts->force, N_("force checkout (throw away local modificati=
ons)"),
 			   PARSE_OPT_NOCOMPLETE),

base-commit: b56bd95bbc8f716cb8cbb5fdc18b9b0f00323c6a
--=20
2.34.1.703.g22d0c6ccf7-goog

