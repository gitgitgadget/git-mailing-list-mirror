Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE130C433EF
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiCCA6u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbiCCA6l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:41 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0D01520DA
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:57:56 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id p21-20020a631e55000000b00372d919267cso1909323pgm.1
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=gflS6XqN2dPNnSYpN0VO97t7AhA7GLgTGLUTgI03exQ=;
        b=cFbfzwX6vstgE4GbbhiKe3An6rpCInnSwJtabL2rVITfw21jrsUu6RLdIBPelM1OQZ
         oYOMqqkZ4oofsNxqc0RsG3fCF3Qyptk1rWZdzeqts12gZ27z/j+bwts+wfYqYF/crMFb
         CBMuS9lDoAqvRcC8C6NkdMPxBHnyIVlIm21E3zt+Fbo9EhcSa2Mu1JC7VehCRTSBlyNe
         PxmeK2r9OiaKcjmD+3Z13foHqdr4NedvRMjzTxefJ/fZFH3nVLpCJBpcEk0Vz5cdZSQP
         R9arnF4D0YL78f8Hz0SBpXSt7CL1Ov+t2gePWjWfj8ziI4PiUKb+6kKYtoJpACcLMpcv
         PRrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=gflS6XqN2dPNnSYpN0VO97t7AhA7GLgTGLUTgI03exQ=;
        b=XrlIVWu7RejSmH2xLUB/yXseLMwia5CLzOjlLrYLC9fdByL4Las+A5xPUYp5ZKvPgT
         WdQV+GN1KzmrU6Hd4K+NVm/aSBQnAqFxBdwmvFwsPQKqktVIzXAgj6TaYz+9qDDYFZ7Z
         x/sA2D39/BsS+Tb9Gv3sHzlMWxiO1EWpL8uvGOUd110WSUMPwIAaJe3795h7AV+b6Wd0
         +7zxJ54M2NxxetVq4GwXB2627+tl5+5Hk4jnd/cPGFPDxbmdxWdaJ557JuGz5xrkJv/F
         93ctdmUXifbUagq+CHi0OQl9HerbAfVXep/SZwfvngVp3Oc5HUC7ACvxABJIbC1n+SH/
         iyKg==
X-Gm-Message-State: AOAM531V2FwBh+VMwtVqTC+BYQuMBQ7PuHaEmHwZ9Ap77RTiWSyaVmg1
        RlUT/4Hods9vJg7qxVXeR2zuAF4jCempFOuxjrt5LjgbwtZ88V5UJtITGejb6z4AJaLeFLXIKxP
        NG5K+nhw+9pOh3te647R9xHHBJnwBLVGLby1dWwpv+iaeeHuMpZNMtsGefqdsBk4=
X-Google-Smtp-Source: ABdhPJzvv3Mh+jXDba8YxO9vXJg/mKBQ12VZ4cWYuyz+EFuwEB95n8pQLZIzZ4mOhbpiG87/iwyF90+hr65NMw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:a40f:b0:14b:61:b19e with SMTP id
 p15-20020a170902a40f00b0014b0061b19emr33404777plq.20.1646269075605; Wed, 02
 Mar 2022 16:57:55 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:21 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-8-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 07/13] submodule--helper: don't use bitfield indirection
 for parse_options()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
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

