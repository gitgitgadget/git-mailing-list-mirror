Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 616781F406
	for <e@80x24.org>; Thu, 10 May 2018 14:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965619AbeEJOTt (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 10:19:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:45501 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965530AbeEJOTj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 10:19:39 -0400
Received: by mail-lf0-f65.google.com with SMTP id q2-v6so3199725lfc.12
        for <git@vger.kernel.org>; Thu, 10 May 2018 07:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=31EiQMTmkp16mkvIDIWtkaN972ZZ3JxSTYOcLzjJrT8=;
        b=YCmDgxuWI0q+51Jj62cZOREJKMPSWPhlpH3Ka6IOv/i90xyxD3j7VrbA6rf7fsxWrw
         CtlYmKo3JPX2FTFai7lkOdJ357b1aoKkLxPhWxlt13RiwmBErPDiehYK/c74uaGYnBci
         S/OvIbGLpxHrtFKfcp7qGPwXRYGJh+wvU+XsfLCdLW4iKhletTbY2GpiOqpV9KauKxS3
         jvVkUYAk4s9XbSMnO788886dLfQnaHWIdEMsy7GlFTLKI1n1bESaLni5IMNmOHf3Pcly
         +MwydIQugUH8i+puOxzidogCISOsX/QgazujOf28nlIlRVSuJJeB31Jp9pUCeM2/l7Yv
         TGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=31EiQMTmkp16mkvIDIWtkaN972ZZ3JxSTYOcLzjJrT8=;
        b=G+mDmbq5/f8PDJJAyVKMOYZ6Bo0pCSdBN0pMCarqts4S7D/Y2sqDv90GjDM5zwXLRZ
         +kG3UE0JMI9MySl5fShdUfIyIXBoOX1wcCXBh3xoHlFyGMHyvvU++Dp9A6YBu0EwnS2o
         jaq3Cx9SjmdZ379Jgd1Xj3WXDdIQwKefvkwAxMnMrGQiDRX4n/o3XQP16rV6usXWc7q/
         bVpq7oB+Av6eKOLeED2im6XjLOU6Sya8puM1jWcnN3Xle9xaE5a4zsoHM6V1DY5u8KdY
         0Wj4jKvV+QtA2m8kcNQR3kqB2Zr2ZFbYpXePK6b2J57zv9vaC7E/zjxwfUrkuf1DqOVd
         ftdg==
X-Gm-Message-State: ALKqPwdatS4BIH9EIfe+0GjuDqKjx3EevouaJXmosL+5GTsbBjqbj76y
        v3ptU0whoymgZgoJ1MxZHW3FZg==
X-Google-Smtp-Source: AB8JxZpIY+r3jLiRhZc89AL2mfGWj9LKFqbkYy7mLpi6MYIvrvNvvX/JP/NUJ1ndEbQNAeVEVJgQYA==
X-Received: by 2002:a2e:4185:: with SMTP id d5-v6mr1311139ljf.114.1525961977966;
        Thu, 10 May 2018 07:19:37 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g2-v6sm194296ljj.82.2018.05.10.07.19.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 May 2018 07:19:37 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 6/9] am: move advice.amWorkDir parsing back to advice.c
Date:   Thu, 10 May 2018 16:19:24 +0200
Message-Id: <20180510141927.23590-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.705.g3525833791
In-Reply-To: <20180510141927.23590-1-pclouds@gmail.com>
References: <20180510141927.23590-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only benefit from this move (apart from cleaner code) is that
advice.amWorkDir should now show up in `git help --config`. There
should be no regression since advice config is always read by the
git_default_config().

While at there, use advise() like other code. We now get "hint: "
prefix and the output is stderr instead of stdout (which is also the
reason for the test update because stderr is checked in a following
test and the extra advice can fail it).

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 advice.c              | 2 ++
 advice.h              | 1 +
 builtin/am.c          | 5 +----
 t/t4254-am-corrupt.sh | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/advice.c b/advice.c
index d8ea93637a..d300491a6f 100644
--- a/advice.c
+++ b/advice.c
@@ -16,6 +16,7 @@ int advice_implicit_identity = 1;
 int advice_detached_head = 1;
 int advice_set_upstream_failure = 1;
 int advice_object_name_warning = 1;
+int advice_amworkdir = 1;
 int advice_rm_hints = 1;
 int advice_add_embedded_repo = 1;
 int advice_ignored_hook = 1;
@@ -39,6 +40,7 @@ static struct {
 	{ "detachedHead", &advice_detached_head },
 	{ "setupStreamFailure", &advice_set_upstream_failure },
 	{ "objectNameWarning", &advice_object_name_warning },
+	{ "amWorkDir", &advice_amworkdir },
 	{ "rmHints", &advice_rm_hints },
 	{ "addEmbeddedRepo", &advice_add_embedded_repo },
 	{ "ignoredHook", &advice_ignored_hook },
diff --git a/advice.h b/advice.h
index 70568fa792..7555385aa5 100644
--- a/advice.h
+++ b/advice.h
@@ -17,6 +17,7 @@ extern int advice_implicit_identity;
 extern int advice_detached_head;
 extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
+extern int advice_amworkdir;
 extern int advice_rm_hints;
 extern int advice_add_embedded_repo;
 extern int advice_ignored_hook;
diff --git a/builtin/am.c b/builtin/am.c
index 9c82603f70..03e5870c62 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1827,15 +1827,12 @@ static void am_run(struct am_state *state, int resume)
 		}
 
 		if (apply_status) {
-			int advice_amworkdir = 1;
 
 			printf_ln(_("Patch failed at %s %.*s"), msgnum(state),
 				linelen(state->msg), state->msg);
 
-			git_config_get_bool("advice.amworkdir", &advice_amworkdir);
-
 			if (advice_amworkdir)
-				printf_ln(_("Use 'git am --show-current-patch' to see the failed patch"));
+				advise(_("Use 'git am --show-current-patch' to see the failed patch"));
 
 			die_user_resolve(state);
 		}
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 168739c721..fd3bdbfe2c 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -25,7 +25,7 @@ test_expect_success setup '
 #   fatal: unable to write file '(null)' mode 100644: Bad address
 # Also, it had the unwanted side-effect of deleting f.
 test_expect_success 'try to apply corrupted patch' '
-	test_must_fail git am bad-patch.diff 2>actual
+	test_must_fail git -c advice.amWorkDir=false am bad-patch.diff 2>actual
 '
 
 test_expect_success 'compare diagnostic; ensure file is still here' '
-- 
2.17.0.705.g3525833791

