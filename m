Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942D2C433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350563AbiBHIkQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350595AbiBHIkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:12 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6A3C03FED2
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:07 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id iy10-20020a17090b16ca00b001b8a7ed5b2cso1113652pjb.7
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=1q5oLNtDReJ7p0+YX28Bu8psSH2hz+Z8tqtHbnD/3Rs=;
        b=N0L+4fZaQzxGZJFFUXkJe/7QcJ0ZwkeltEyAuEDBoA2YeLLA3l6j0eTqVA2FpAGvQK
         3m3c3WLYVA32A2cFe+TIiO8Al2WWT3SKxVSWWgOiTHiaB8KP/5UnOsHxPIjtdW/6aGXQ
         nRoDLtJxALolApmlYDKOGFpnMwDxftU3gL3Nd4ACXtBmq5oidcvcT8IsToUXUwwKdmbK
         4II6CLUCFOS7TKVveF4wAF63p3T9kSwuyADCGSABODc8z7GZ/yNACiPq3Y6l3N185X+v
         7750PghCae6C5zPvyfRtW/zBuB8PX+uwDWWqQ6NPLFvN41BFIKP7qFZfiLJUnGsfNxrd
         NtUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=1q5oLNtDReJ7p0+YX28Bu8psSH2hz+Z8tqtHbnD/3Rs=;
        b=0FkGjqSIQd7n8EGBsmbu9lueZ4ILlreVfmujPi/9opd6AB/Ff2u9Ts0h995fI8Y/oA
         5hF1SHHgobbZeBsNCOqV8RyrG5thRaq2pko6eKmPy0L+lXfWYH2RhMZ3y+1QffssN7eu
         0Pc3+mVDDn4HIp6AZx/8HkH3cTwOAik7Zmlf1QfeIsOP40JrWJkwxMkK0bqg++4IGxtC
         bHW9BB9Fg3d9dg9O1s2t75mlMvgOOPxd+LCdzE8lzACEvDvVdFpArszmAVJApmrf1BQT
         IHY4vqLQomrov/zQmL2yaSgCXWe+MNlmP/Cr+lyLfoxF/bm66p/J7gXZMlc/TcZCmJfB
         3bvA==
X-Gm-Message-State: AOAM530K9Y1wn5jh+ToMtHEGzfIWIpt29RJEoRCVfn+WBC+nktYUPqz+
        h4u2Iu2xWFVDRqV2HEWQLsuh24/W9eHEZVx+FcrYwBP4OXjIqanQ6bUpVrFSKEYbJxziYfAK8SJ
        wMMmjv+osaw2rfL4j7zdPdaTUcp1AO2aOht0Ax0K1Otb80CSSdhA73tLqq5tUZV0=
X-Google-Smtp-Source: ABdhPJy+2b2IXxcqMQn0AO/QPlMioH3xeS5W62GspCykCEn+GUdkE6d02H+V4NxXUXG1/5fiHNnyGddPn68QPA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7e0a:: with SMTP id
 b10mr3349567plm.17.1644309606470; Tue, 08 Feb 2022 00:40:06 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:40 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-5-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 04/16] submodule--helper: run update using child process struct
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
index 09cda67c1e..db71e6f4ec 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2344,47 +2344,45 @@ static int fetch_in_submodule(const char *module_pa=
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

