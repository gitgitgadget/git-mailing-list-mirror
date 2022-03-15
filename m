Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9D3C433F5
	for <git@archiver.kernel.org>; Tue, 15 Mar 2022 21:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351858AbiCOVKx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Mar 2022 17:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiCOVKw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Mar 2022 17:10:52 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DAE956233
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:39 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id l138-20020a628890000000b004f7cb47178cso325657pfd.12
        for <git@vger.kernel.org>; Tue, 15 Mar 2022 14:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=9t1/BNUE77HYP2XglXpb8jZe3XGU45Au+67WAcBazbE=;
        b=hEuEnSZgmJnkDLujLpbxp5q+lNewKIzaPsRo7umOk2qxeJyZLgdiPw8IUmJ7Lcv3oK
         uZOqyRxVZiW1jJtmWJbv0eNAeMPAhAdsJw9/M3rrANWBaca0YtVvlXq0eCQDl2KMIJJx
         FXK+s+MKyNFCyTlg9hKo+v9DoU2xhgzTqc7XbrIU9FdCOHG3Hw6ff/EvLj1bymdemBhe
         vblB6LWOuRo70WumIEILI+nA1idhcsZPs/m+eqntOirfv75zK31xpDvevqxXAQUgJQeq
         Qlq39/MpKgdefMpF1kXVANCnNUAhz6b8WVVZrepU1EMSJ4UarYhtaUCvVlrErE47Khdn
         jnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=9t1/BNUE77HYP2XglXpb8jZe3XGU45Au+67WAcBazbE=;
        b=aky2zjHUlQ4N3X5BJvZbbN6lxjTEHjm4IbmaORDynvAW3bcr17DisARv5h/0x4qGF/
         mQrCZhkUXe+Ie4PEFQDxYfYLj8Hk8elcUU8M1OUosZBh+Q4Ef0h6wbFKTfUKLKa9g633
         eoCBEQalBnlz+w1g0hQDXQecf2Mfd2N14P+dCuMyMFg/ymEYrfq/LYb8FrzNI1KmRTZV
         GmtK7gVpxU2AUBSBmlTjRH1AlqkdJOcJUd+e3bR/NZqUBhU+DGqhaxpjHXMAlrHNJ4i8
         WTByBnf7haTjO+QIgWhTd588gP8bx6UwTtEQ2cDxzdRHTxIxr9RKKjGovIjWAbpewv1c
         4+6A==
X-Gm-Message-State: AOAM532/txAU60yAm9Gauump7oS4mENByg87+63f84tbn52Jlc4zWrtM
        rKLxU4/Leu+0p0PWl5YlTBIKKETMJum+w2JGyiKn8L/yazMk1g2/1Lvd8IKas1i5hsf4IOs/fZd
        OpPAzFgnqFH6gP99oQ/3TbCHumyI1D9uWZ+eL8lzWLksneTp57ZPpKamWlegh7xU=
X-Google-Smtp-Source: ABdhPJzkSzillZ+sIChXWDI4XlD5VLi/z1xCvrmqbsy4MlRKrtfx4/OioENcnneZ6oYeLXC7pb4zrG6nAqRmaw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4c84:b0:1c6:573f:145d with SMTP
 id my4-20020a17090b4c8400b001c6573f145dmr1315115pjb.154.1647378578767; Tue,
 15 Mar 2022 14:09:38 -0700 (PDT)
Date:   Tue, 15 Mar 2022 14:09:19 -0700
In-Reply-To: <20220315210925.79289-1-chooglen@google.com>
Message-Id: <20220315210925.79289-2-chooglen@google.com>
Mime-Version: 1.0
References: <20220315210925.79289-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.723.g4982287a31-goog
Subject: [PATCH 1/7] submodule--helper: run update using child process struct
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We switch to using the run-command API function that takes a
'struct child process', since we are using a lot of the options. This
will also make it simple to switch over to using 'capture_command()'
when we start handling the output of the command completely in C.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index bef9ab22d4..95ef113d16 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2325,47 +2325,45 @@ static int fetch_in_submodule(const char *module_pa=
th, int depth, int quiet, str
=20
 static int run_update_command(struct update_data *ud, int subforce)
 {
-	struct strvec args =3D STRVEC_INIT;
-	struct strvec child_env =3D STRVEC_INIT;
+	struct child_process cp =3D CHILD_PROCESS_INIT;
 	char *oid =3D oid_to_hex(&ud->oid);
 	int must_die_on_failure =3D 0;
-	int git_cmd;
=20
 	switch (ud->update_strategy.type) {
 	case SM_UPDATE_CHECKOUT:
-		git_cmd =3D 1;
-		strvec_pushl(&args, "checkout", "-q", NULL);
+		cp.git_cmd =3D 1;
+		strvec_pushl(&cp.args, "checkout", "-q", NULL);
 		if (subforce)
-			strvec_push(&args, "-f");
+			strvec_push(&cp.args, "-f");
 		break;
 	case SM_UPDATE_REBASE:
-		git_cmd =3D 1;
-		strvec_push(&args, "rebase");
+		cp.git_cmd =3D 1;
+		strvec_push(&cp.args, "rebase");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure =3D 1;
 		break;
 	case SM_UPDATE_MERGE:
-		git_cmd =3D 1;
-		strvec_push(&args, "merge");
+		cp.git_cmd =3D 1;
+		strvec_push(&cp.args, "merge");
 		if (ud->quiet)
-			strvec_push(&args, "--quiet");
+			strvec_push(&cp.args, "--quiet");
 		must_die_on_failure =3D 1;
 		break;
 	case SM_UPDATE_COMMAND:
-		git_cmd =3D 0;
-		strvec_push(&args, ud->update_strategy.command);
+		cp.use_shell =3D 1;
+		strvec_push(&cp.args, ud->update_strategy.command);
 		must_die_on_failure =3D 1;
 		break;
 	default:
 		BUG("unexpected update strategy type: %s",
 		    submodule_strategy_to_string(&ud->update_strategy));
 	}
-	strvec_push(&args, oid);
+	strvec_push(&cp.args, oid);
=20
-	prepare_submodule_repo_env(&child_env);
-	if (run_command_v_opt_cd_env(args.v, git_cmd ? RUN_GIT_CMD : RUN_USING_SH=
ELL,
-				     ud->sm_path, child_env.v)) {
+	cp.dir =3D xstrdup(ud->sm_path);
+	prepare_submodule_repo_env(&cp.env_array);
+	if (run_command(&cp)) {
 		switch (ud->update_strategy.type) {
 		case SM_UPDATE_CHECKOUT:
 			printf(_("Unable to checkout '%s' in submodule path '%s'"),
--=20
2.33.GIT

