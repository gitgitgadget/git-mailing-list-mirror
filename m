Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 220D1E95A8F
	for <git@archiver.kernel.org>; Sun,  8 Oct 2023 06:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344534AbjJHGqI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Oct 2023 02:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344491AbjJHGpn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2023 02:45:43 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CF3F1
        for <git@vger.kernel.org>; Sat,  7 Oct 2023 23:45:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406650da82bso31945205e9.3
        for <git@vger.kernel.org>; Sat, 07 Oct 2023 23:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696747539; x=1697352339; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oh2B5N6prv2AUj9d1pgoTg1kbK97Q4rA7Z994BaDASM=;
        b=Am7OyheXyc5Pg05lSl2zlgNn7g2Lg1T6V8MDfKYn5HNeXuIg4hRgcQcgzCvuwmmd4h
         ZKH9ul7/+NHHRiNR0gAW9bup/str4H+P7n76vcQ7wXL2WW1NcKfodAu8IyVFK/9/D2We
         QlXTT5nm7vNMYalLChy3cjrNRM2gp4ieWMvxNT1ra5rp/wvz5ro1IlerD6bW5UQdcF+A
         Z01d/o3Z3Drdl0fJBs/e4G401UOKNQUcqBvsOgt+4MFWPozrKiGTRQu3/bQpAEkQHajT
         bLcK09XuyJz1YnRQ9Q197w1OviDbhQvmgd5yMItSSCHjGuAedCC5eYyvWFOUiagy6hMp
         ZIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696747539; x=1697352339;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oh2B5N6prv2AUj9d1pgoTg1kbK97Q4rA7Z994BaDASM=;
        b=IHy2wTIOvyCCrUxHJidCQmUD16YCdFwgnxMkEvtU5w5Eqr1tEIUeZGZrgHUtb67074
         jb5nzBRk+BJx4eN5oVD1NnuejVgrrywO3JBrcb5ADujELu0RKiu7Wh/33erqE71GG1DL
         qTptzemp+AWO+bMN+wiCGeWfBq9epAlld8AoVZr6DE9fpc1MNkg8vNjaB64dwd4/cb9j
         gHGuNL3rs5cEvcAkOtSACHSgh3AdCeDhOW6SB9Ka9UElTYJiA1tijH22mYQxYVmCUsRk
         i6XtAnOTeIleOPx4lXUqm5aUXREXvkpTd0gckBSnvkrnFuBHo7et8Jf8IUEatMxwH0JP
         i3wA==
X-Gm-Message-State: AOJu0Yx0H7vUuzSkV8CBAv3ZtXBQcvd3mNY+aAgTQfur3/xpsB/Ja6g2
        BNeGCcMISMLBiR9i+m94oWYFQCeosiM=
X-Google-Smtp-Source: AGHT+IHUq2SFKjWUIe5Wv7PorzoqN9FMKuyOIWJBZsUloOwmtdOl2QjgNNrA+tM/INOwST2vgWtK9A==
X-Received: by 2002:a05:600c:2949:b0:405:82c0:d9d9 with SMTP id n9-20020a05600c294900b0040582c0d9d9mr11608586wmd.41.1696747539083;
        Sat, 07 Oct 2023 23:45:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6-20020adfed86000000b003279518f51dsm6052445wro.2.2023.10.07.23.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Oct 2023 23:45:38 -0700 (PDT)
Message-ID: <cf320e4f80fa7dc0ee37cee40b273ad6703c3a97.1696747529.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Oct 2023 06:45:15 +0000
Subject: [PATCH 13/25] documentation: whitespace is already generally plural
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Diff best viewed with --color-diff.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/config/apply.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/config/apply.txt b/Documentation/config/apply.txt
index 3f9ff19db6b..f9908e210a8 100644
--- a/Documentation/config/apply.txt
+++ b/Documentation/config/apply.txt
@@ -7,5 +7,5 @@ apply.ignoreWhitespace::
 	See linkgit:git-apply[1].
 
 apply.whitespace::
-	Tells 'git apply' how to handle whitespaces, in the same way
+	Tells 'git apply' how to handle whitespace, in the same way
 	as the `--whitespace` option. See linkgit:git-apply[1].
-- 
gitgitgadget

