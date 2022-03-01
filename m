Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1003C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiCAEmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbiCAEmi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E98D70053
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:50 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id oj16-20020a17090b4d9000b001bc9dddd9easo7703933pjb.7
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=gflS6XqN2dPNnSYpN0VO97t7AhA7GLgTGLUTgI03exQ=;
        b=JpNcer/OssgycD0+xoOZnotgIWbVV/zeKBXkhCbzag8resMkn3OyoNTBKylVqWZvYN
         L1uGkPlz8A/oAIu/6zWfQUN3+C6/7BFR+IeSD5yGF2tEBrisRTVRgupanNRv9L+6zloa
         0HWUXhWq1XBK8sAvVeL/wCR+yEcoD0tevE7uCG3ALART/9XdHaBjshpa+VYkXcJfMGZk
         iIQx1OCIrDWbQMq46Z2btMHU0OegTCcuu6MKfIYs+nHnnwqAtbTdenXXjxrQnilFygP+
         iKSh/5pHupNJXp5npxSL9L94Lc63tEIv5zYUqqCqNddC5mQ59+svoHCo2dsWVK5+EFRk
         XIlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=gflS6XqN2dPNnSYpN0VO97t7AhA7GLgTGLUTgI03exQ=;
        b=CQsscwKp3S0t2laoic6Sp+YxXnV77WbxYro+hDEPUsK7YukdtS13s3gO1lSD2VA+/L
         8VxT/I2g43ilPQB8Cu/s5JyV9OusqrCSqr0MeT2E/tVd2bKRbtlNQMmArobxVKTIgCQs
         2bBF/F0i9a+nXBqbMZBSg7xeDKCA2YsbQsjjNKUv1458Pj/e12dRwmmvXbUx+2XprjfP
         hSd28jSHQMJaUOSOHBbzFm9JEkUd6z2qPG1se44bxFhmW+3adrVys8e7tCyWzznVrN8x
         G/FHVT2TPBmnyJCmplL19fLCGEWtB5amO+9CzvgqFos35hFG+4l1RrWM4M/3mC7pEajy
         kUsQ==
X-Gm-Message-State: AOAM5333Sm3Y3/Qn6f18CqMZlHqTJh+e9ZtrU92QVnNlVsAZItlpxdt0
        ZG3+Fye6+NdLIpUA1dXdzMk50S8aUuGORGcGjsxpoCCLS8scKIaXAJaQq28gnn/PeUypI64X/hb
        sCozONZa1uppDcRd7T8vQ/xzw0ceXe+I3o+eKMoxAFPj3PyKWNLpT9ZAA8BeeWps=
X-Google-Smtp-Source: ABdhPJyfiQ6HGGXIWZIaGzw0JWv3CXQGbPbmd3sCDOHG7a243yNlrJGi91EUc+WOn9CbDgl8o93KXXz1VOIPIw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:ab89:b0:1bc:71a7:f93a with SMTP
 id n9-20020a17090aab8900b001bc71a7f93amr19983941pjq.111.1646109710100; Mon,
 28 Feb 2022 20:41:50 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:26 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 07/13] submodule--helper: don't use bitfield indirection
 for parse_options()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Do away with the indirection of local variables added in
c51f8f94e5b (submodule--helper: run update procedures from C,
2021-08-24).

These were only needed because in C you can't get a pointer to a
single bit, so we were using intermediate variables instead.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index a58df3e007..3a96c35b86 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2023,10 +2023,10 @@ struct update_data {
 	struct object_id suboid;
 	struct submodule_update_strategy update_strategy;
 	int depth;
-	unsigned int force: 1;
-	unsigned int quiet: 1;
-	unsigned int nofetch: 1;
-	unsigned int just_cloned: 1;
+	unsigned int force;
+	unsigned int quiet;
+	unsigned int nofetch;
+	unsigned int just_cloned;
 };
 #define UPDATE_DATA_INIT { .update_strategy =3D SUBMODULE_UPDATE_STRATEGY_=
INIT }
=20
@@ -2578,16 +2578,17 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
=20
 static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
 {
-	int force =3D 0, quiet =3D 0, nofetch =3D 0, just_cloned =3D 0;
 	char *prefixed_path, *update =3D NULL;
 	struct update_data update_data =3D UPDATE_DATA_INIT;
=20
 	struct option options[] =3D {
-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&force, N_("force checkout updates"), 0),
-		OPT_BOOL('N', "no-fetch", &nofetch,
+		OPT__QUIET(&update_data.quiet,
+			   N_("suppress output for update by rebase or merge")),
+		OPT__FORCE(&update_data.force, N_("force checkout updates"),
+			   0),
+		OPT_BOOL('N', "no-fetch", &update_data.nofetch,
 			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &just_cloned,
+		OPT_BOOL(0, "just-cloned", &update_data.just_cloned,
 			 N_("overrides update mode in case the repository is a fresh clone")),
 		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch"=
)),
 		OPT_STRING(0, "prefix", &prefix,
@@ -2615,10 +2616,6 @@ static int run_update_procedure(int argc, const char=
 **argv, const char *prefix)
 	if (argc !=3D 1)
 		usage_with_options(usage, options);
=20
-	update_data.force =3D !!force;
-	update_data.quiet =3D !!quiet;
-	update_data.nofetch =3D !!nofetch;
-	update_data.just_cloned =3D !!just_cloned;
 	update_data.sm_path =3D argv[0];
=20
 	if (update_data.recursive_prefix)
--=20
2.33.GIT

