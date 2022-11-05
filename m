Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13823C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiKERIx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiKERIb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA293BC99
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id g24so7572552plq.3
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDPvE8N2/f3Iv929/7ntbkq4gOoVespdtKK07OyREl8=;
        b=R+fDvxNMfjEuSul/rLCrFOEsSrJcDfu0CmXBPqvxegN5hLyLl2mP75MxkGgwp8JwY/
         kAHDXCzXLYFS4nt2Qsw4M7m7QhYl6SqADEEGi8uyNiNhGs5VBSvtowaWp3eV+XdTSYvw
         H5zZKZiAkY1nwbzF6K/m/sZ1lpAtDJwhlyvV71/t2RZhQGa7atSX/FW0il2BQF7ObAWQ
         Dl0+YG4G66Wgjkk9F0lR1dKbSrjbOt6VCxiGE0096pmqHErCisPsOtA0fUzw4LFaZfCt
         LKWvDE2xrv1+/OJ5vbdKJdn+4QJeuWyGVOehT8ulvf7/tadBLsoDskq5IXOurU4rG6D9
         GJKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDPvE8N2/f3Iv929/7ntbkq4gOoVespdtKK07OyREl8=;
        b=3JLLJQ1XhoU1suelehSA+Sbx4FDg+PBsJpoOawKlqvqR55DV7HK8LDSRnh79NqvPvW
         d9D3/eVmaKzeB2dHdlRmFIygXW2f55l38fZBAHXpIAasfFb+E85PilzusiyHCcDLquDQ
         ox05SQExdVzbInGTDUDPskfH8J83e/MXLJC+0/v5WfZslOkhzxM6lizdF9tS2qaU3m1U
         0nYA06/UO7nPSoImnUOQIOlPmPdiqDLaDcuoOgGtzZjCuM3UiOttzWeN6xuUr7ODMNx0
         O9oAOZiZTMKg8TGEVhf9RLvO5NWXQ9n4tuAni+UE08DqrznV1zFk0bYpclplv8rTn4V+
         jNbw==
X-Gm-Message-State: ACrzQf2pP/Z6qHT90CLCyB+JslG9OtyAcf+x98aUH7nKMFj2DCPmoXqT
        0plRc5F1lSXtN6EwyT77BpUZJk/jiFM=
X-Google-Smtp-Source: AMsMyM7Xtqa39TVTMuk52tjmduOXhjg67oCLmm+9fkm7ffBQhYEkmRLMHfNTGwVW73G/KasdsF/jOg==
X-Received: by 2002:a17:903:2446:b0:187:11c6:6a1b with SMTP id l6-20020a170903244600b0018711c66a1bmr35439143pls.39.1667668104671;
        Sat, 05 Nov 2022 10:08:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:24 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/13] bisect--helper: remove subcommand state
Date:   Sun,  6 Nov 2022 00:07:42 +0700
Message-Id: <8037667da0f3d9f91c8f2aa477e2e95fb7f0c24b.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In previous change, we've made 'state' optional, and replaced all of its
usage.

Let's remove it, now.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3c7a16355a..d645fe89dc 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1349,18 +1349,6 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	return res;
 }
 
-static int cmd_bisect__state(int argc, const char **argv, const char *prefix UNUSED)
-{
-	int res;
-	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
-
-	set_terms(&terms, "bad", "good");
-	get_terms(&terms);
-	res = bisect_state(&terms, argv, argc);
-	free_terms(&terms);
-	return res;
-}
-
 static int cmd_bisect__log(int argc, const char **argv UNUSED, const char *prefix UNUSED)
 {
 	if (argc)
@@ -1426,7 +1414,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		OPT_SUBCOMMAND("terms", &fn, cmd_bisect__terms),
 		OPT_SUBCOMMAND("start", &fn, cmd_bisect__start),
 		OPT_SUBCOMMAND("next", &fn, cmd_bisect__next),
-		OPT_SUBCOMMAND("state", &fn, cmd_bisect__state),
 		OPT_SUBCOMMAND("log", &fn, cmd_bisect__log),
 		OPT_SUBCOMMAND("replay", &fn, cmd_bisect__replay),
 		OPT_SUBCOMMAND("skip", &fn, cmd_bisect__skip),
-- 
2.38.1.157.gedabe22e0a

