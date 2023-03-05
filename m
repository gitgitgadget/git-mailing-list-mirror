Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 153F2C6FA8E
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 05:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjCEFIL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 00:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEFII (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 00:08:08 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E639CC2C
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 21:08:07 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id b20so3826795pfo.6
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 21:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677992886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TiqKXg7nuisFhpy5qsjj7aeQUCZntqFeaavElN3ASCs=;
        b=JimPhmjm1plM2ltb2QxWGAsHg8JUQOGPhzFKj8ZtCFv/wjhk52SQ/xokfaacUPHJ4x
         ZEXXSzS+JwIHr5uvhi8opX4rggdFnLpalozuGnkZZyAlCZk4h/aInF8PB94Yb52kE+L6
         b2X79JbGSHlDMgEUeYzaE5FVlRBFIxFQtX4ayJpg70TeDVj+6pc64qH13dKo93Z50Sqs
         pTjBUUVxdZJu2i1I6rlHSil43GN2KE8xgfZ581jcuXNq3yMDAwOLjvm/HMeHYgNnasBr
         MtVu5M9EPx1RCHZeqtTTV1+q/5U0GoL5R//f7Lm505iV27u1EYtlTflMdZ6iwVwDL5dx
         CmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677992886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TiqKXg7nuisFhpy5qsjj7aeQUCZntqFeaavElN3ASCs=;
        b=h37m4mkcxy4YnoCtty41h9JMki1kysuz6lsPSyF6x2Fwp7hduAt2nscXez0YMP/wNC
         Oye0FCCrW70xk2DMcST/JBb1fGoevvQrcUY+xL3PYBCXVI8bRnJuu/2+9qwEhBrLyQTN
         8Aijwv98QlKQoTXfHgXeutfDwbySZgHPHky7J6dTsngmcRKxuuIBM0+QKXuYfGNwhLIV
         VjqWdB0Olx6JYt142DuTnfRMKwib+qwX0frbIOfJTjJDbwowppeNtOyjesOYO6cRaYbe
         tPhBf+aKRC8m1SYlIx0pUGtE0AtS+nmZ7Dwpd8LAluSAO66JqkfYPvYbDHmiq5B1c4X9
         QPqQ==
X-Gm-Message-State: AO0yUKVu+4ylQTEJlLyrcZlJVFwYkGvy3pTrMtpQsAWmgy0aNDYOkhGq
        vD4ms+/w0oaFt964uCZ1dqB46bAlK/ctpA==
X-Google-Smtp-Source: AK7set8NYu2JV/QbNDrEnOy9DX1B1E2Wi7KC6Y1MimKWMfpj6vR+bx3dMgcFASFdaGUJ7MpYloFe+w==
X-Received: by 2002:aa7:953a:0:b0:5a9:cad5:b283 with SMTP id c26-20020aa7953a000000b005a9cad5b283mr6194192pfp.14.1677992886254;
        Sat, 04 Mar 2023 21:08:06 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b005dd975176c3sm3996769pfn.53.2023.03.04.21.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 21:08:05 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com, jonathantanmy@google.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v6 1/3] rebase: add documentation and test for --no-rebase-merges
Date:   Sat,  4 Mar 2023 22:07:07 -0700
Message-Id: <20230305050709.68736-2-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305050709.68736-1-alexhenrie24@gmail.com>
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
 <20230305050709.68736-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As far as I can tell, --no-rebase-merges has always worked, but has
never been documented. It is especially important to document it before
a rebase.rebaseMerges option is introduced so that users know how to
override the config option on the command line. It's also important to
clarify that --rebase-merges without an argument is not the same as
--no-rebase-merges and not passing --rebase-merges is not the same as
passing --rebase-merges=no-rebase-cousins.

A test case is necessary to make sure that --no-rebase-merges keeps
working after its code is refactored in the following patches of this
series. The test case is a little contrived: It's unlikely that a user
would type both --rebase-merges and --no-rebase-merges at the same time.
However, if an alias is defined which includes --rebase-merges, the user
might decide to add --no-rebase-merges to countermand that part of the
alias but leave alone other flags set by the alias.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/git-rebase.txt | 18 +++++++++++-------
 t/t3430-rebase-merges.sh     | 10 ++++++++++
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9a295bcee4..4e57a87624 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -529,20 +529,24 @@ See also INCOMPATIBLE OPTIONS below.
 
 -r::
 --rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
+--no-rebase-merges::
 	By default, a rebase will simply drop merge commits from the todo
 	list, and put the rebased commits into a single, linear branch.
 	With `--rebase-merges`, the rebase will instead try to preserve
 	the branching structure within the commits that are to be rebased,
 	by recreating the merge commits. Any resolved merge conflicts or
 	manual amendments in these merge commits will have to be
-	resolved/re-applied manually.
+	resolved/re-applied manually. `--no-rebase-merges` can be used to
+	countermand a previous `--rebase-merges`.
 +
-By default, or when `no-rebase-cousins` was specified, commits which do not
-have `<upstream>` as direct ancestor will keep their original branch point,
-i.e. commits that would be excluded by linkgit:git-log[1]'s
-`--ancestry-path` option will keep their original ancestry by default. If
-the `rebase-cousins` mode is turned on, such commits are instead rebased
-onto `<upstream>` (or `<onto>`, if specified).
+When rebasing merges, there are two modes: `rebase-cousins` and
+`no-rebase-cousins`. If the mode is not specified, it defaults to
+`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
+`<upstream>` as direct ancestor will keep their original branch point, i.e.
+commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
+option will keep their original ancestry by default. In `rebase-cousins` mode,
+such commits are instead rebased onto `<upstream>` (or `<onto>`, if
+specified).
 +
 It is currently only possible to recreate the merge commits using the
 `ort` merge strategy; different merge strategies can be used only via
diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
index fa2a06c19f..d46d9545f2 100755
--- a/t/t3430-rebase-merges.sh
+++ b/t/t3430-rebase-merges.sh
@@ -250,6 +250,16 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
 	EOF
 '
 
+test_expect_success '--no-rebase-merges countermands --rebase-merges' '
+	git checkout -b no-rebase-merges E &&
+	git rebase --rebase-merges --no-rebase-merges C &&
+	test_cmp_graph C.. <<-\EOF
+	* B
+	* D
+	o C
+	EOF
+'
+
 test_expect_success 'do not rebase cousins unless asked for' '
 	git checkout -b cousins main &&
 	before="$(git rev-parse --verify HEAD)" &&
-- 
2.39.2

