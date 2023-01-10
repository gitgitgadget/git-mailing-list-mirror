Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D63AC54EBC
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 13:16:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238647AbjAJNQI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 08:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238524AbjAJNP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 08:15:29 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23274881B
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:28 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id ja17so8758070wmb.3
        for <git@vger.kernel.org>; Tue, 10 Jan 2023 05:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T6kIbfk9ffQmmT7q9M3iKH6tbpMv0HaJHtXL4461qpo=;
        b=jx7tCY6k5XqkLFTCcgx/1ilCtjEKGuVQW9T+c4jkkLvb0Ih1vCPma6sf1QO9/GLp3s
         Xoo7Hi947gGrACoRX6aXyIYOIcHdjh58VyIRJl0KjGPk1ii/Mmhce75WtX/MXHse+Nt9
         ZY46o9N6AYgyJZm78N3k6u/hvW1RwrY4BWAUborRLImOOmt+s4otQ91WlRfpVxHus6hu
         dYlpwSw2oi9skJsAxbaq8CBcXtBMbi/r2giPQojRJtqqJZi6J9R9aEKzHIjKepKgRpwV
         SqNUmgWTPingZjdbDfkaf2LwZ+y/w8ebPK7w8WTXZ3+ZjD4lakcE5TZanHiD3sGNp/mq
         VAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T6kIbfk9ffQmmT7q9M3iKH6tbpMv0HaJHtXL4461qpo=;
        b=Hfhfa+/4B/DofEGHIsE5ZJKV5Wtgh+q5J2SFRTnJhpK+lTAU3x6tGT4IjPu3K4DhKm
         YCsl81Lf1F54JRyKHeJ2+LL7+VGPZS7J1GDTR7TWREVU/m5t6tAVOSZhwt8ejbWNtJ6U
         tyNRA9i92aSiEe0jt2oIdJ9t4Q/iecAwqVwOHPOnrq0GJdmZGR2phOHtvJCuB5CUlsX6
         Nuth6k0DCEdkP+PhDm7Nlwk1hb2vzSou7m3TXoizs4ST9Bu6VprPs0DDR6gMOlJT3ver
         KpzIOd4EcdIGtcQtnZNQ+BaMf1u7oM4QCzV6vtMgakuJyGCRFn+9iu9NwTYnNsB215uE
         hvcA==
X-Gm-Message-State: AFqh2kqkq2VUKRuXlzDPWG+gP4NFvBLMC2mlsrBDtrIGdMfaZT2pqelx
        syeWKjRLajcSIxiM741ggukB9fZbfgs=
X-Google-Smtp-Source: AMrXdXtfzX8K+6Rd3HOiURk+SGFjUlG15OTUt5JxEy6UKEOUsg5NPKO2LJLnC0znCge0A5oET4hJTg==
X-Received: by 2002:a7b:c414:0:b0:3d6:ecc4:6279 with SMTP id k20-20020a7bc414000000b003d6ecc46279mr49831109wmi.27.1673356527307;
        Tue, 10 Jan 2023 05:15:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c511300b003d9862ec435sm2783709wms.20.2023.01.10.05.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 05:15:26 -0800 (PST)
Message-Id: <7eed8f353764774cc7335c51338db6cba14675aa.1673356522.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
References: <pull.1456.git.1673120359.gitgitgadget@gmail.com>
        <pull.1456.v2.git.1673356521.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 10 Jan 2023 13:15:21 +0000
Subject: [PATCH v2 5/5] git-rebase.txt: add a note about 'ORIG_HEAD' being
 overwritten
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Erik Cervin Edin <erik@cervined.in>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

'ORIG_HEAD' is written at the start of the rebase, but is not guaranteed
to still point to the original branch tip at the end of the rebase.

Indeed, using other commands that write 'ORIG_HEAD' during the rebase,
like splitting a commit using 'git reset HEAD^', will lead to 'ORIG_HEAD'
being overwritten. This causes confusion for some users [1].

Add a note about that in the 'Description' section, and mention the more
robust alternative of using the branch's reflog.

[1] https://lore.kernel.org/git/28ebf03b-e8bb-3769-556b-c9db17e43dbb@gmail.com/T/#m827179c5adcfb504d67f76d03c8e6942b55e5ed0

Reported-by: Erik Cervin Edin <erik@cervined.in>
Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/git-rebase.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f9675bd24e6..d811c1cf443 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -38,6 +38,13 @@ The current branch is reset to `<upstream>` or `<newbase>` if the
 `git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
 to point at the tip of the branch before the reset.
 
+[NOTE]
+`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
+at the end of the rebase if other commands that write that pseudo-ref
+(e.g. `git reset`) are used during the rebase. The previous branch tip,
+however, is accessible using the reflog of the current branch
+(i.e. `@{1}`, see linkgit:gitrevisions[7]).
+
 The commits that were previously saved into the temporary area are
 then reapplied to the current branch, one by one, in order. Note that
 any commits in `HEAD` which introduce the same textual changes as a commit
-- 
gitgitgadget
