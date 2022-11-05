Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDC2C4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiKERJC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230082AbiKERId (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:33 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA8E0F2
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:28 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d20so6493893plr.10
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pe36tpdSj8UCmr24ubM4gc9ZGVKCE3Zo+tTI3crhQrM=;
        b=SkXI2ckxW6T3Nu8xWORXxkNM4fAz7OCZLpdwmXFL0Nq61cQcGRupXIM3a4rXCT87/C
         O4e2WA4V6He7DwW+j4I3RlnQ4rGSZcRRED494jZfbUd6OZDoThP84hsLFE0rjK4cJH+c
         DMQUzSMzmX5KNLlCZs6uq7XaRuvI4PsmRn2jTRSZ7BFM1MJJkF/dtjpDMgS0/LEeJPNQ
         oaAX5txQdLYczD0UDmZqB0OR6PLbq8JbRsrTFZpDD5cwvaDjdxfmxXLkn0mZmYWxvaLP
         8RvYREXf6cidnCDfVCUvNpxhAJnqiIXkB6QQgMKN9XZXq1f96B+EQxVcBWLrVmFwFkI9
         qCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pe36tpdSj8UCmr24ubM4gc9ZGVKCE3Zo+tTI3crhQrM=;
        b=gX9/sEHqzCULweSsQbY5q/CYqluCtfEWZwK575/5WPqlYo0ijadZhwahvi6o9evDLf
         +XYhoonTK0u3CFP1Y7rVUfxT6adN8rtrvFVqU+4thmm50H7nyyMduvuTTxPyDimk3qCv
         rQThpUiMhqLQ8HrLaf6Zpd8oZEGYfHg9MAp31NeTf6EINNG6dXdGriezRKcqdl91uQlm
         zHO1aaJmDiykJWHyutRv5c2He6jAzkp6wtCuT4N9hIsHXXYN5lpWRNBPbm6yDvYL546g
         lMX4PgmuO+bh/xLwzL2qLi3+aPLCL34Wz+4K8dCeQSMKtYINxzN2vTtVTCKT0SCVXxQh
         JrRw==
X-Gm-Message-State: ACrzQf14Gf/n7zzfvm9bAffbhApCwoKpXwxMcuPLtIK2R7qDOLymxlWf
        Ya2tVPNCu1UVyxTmTSwSioYj1KzG+h8=
X-Google-Smtp-Source: AMsMyM4xELppCuDzl1IWOaBLFkC//hdvqAhPd2WkJ9nGK2U3Gp4oSBrE1lGuR7CZXNEVVe0Ntte3wQ==
X-Received: by 2002:a17:902:e154:b0:186:f0d5:1ac0 with SMTP id d20-20020a170902e15400b00186f0d51ac0mr40823649pla.15.1667668107281;
        Sat, 05 Nov 2022 10:08:27 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:26 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/13] bisect--helper: log: allow arbitrary number of arguments
Date:   Sun,  6 Nov 2022 00:07:43 +0700
Message-Id: <3b13350977c5f8bc934805e908b57792ce1a9a4e.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later change, we would like to turn bisect into a builtin by
renaming bisect--helper.

However, there's an oddity that "git bisect log" accepts any number of
arguments and it will just ignore them all.

Let's prepare for the next step by ignoring any arguments passed to
"git bisect--helper log"

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 4 +---
 git-bisect.sh            | 2 --
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d645fe89dc..e61ce6556c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1349,10 +1349,8 @@ static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
 	return res;
 }
 
-static int cmd_bisect__log(int argc, const char **argv UNUSED, const char *prefix UNUSED)
+static int cmd_bisect__log(int argc UNUSED, const char **argv UNUSED, const char *prefix UNUSED)
 {
-	if (argc)
-		return error(_("'%s' requires 0 arguments"), "git bisect log");
 	return bisect_log();
 }
 
diff --git a/git-bisect.sh b/git-bisect.sh
index 9f6c8cc093..f95b8103a9 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -57,8 +57,6 @@ case "$#" in
 	case "$cmd" in
 	help)
 		git bisect -h ;;
-	log)
-		git bisect--helper log || exit ;;
 	*)
 		git bisect--helper "$cmd" "$@" ;;
 	esac
-- 
2.38.1.157.gedabe22e0a

