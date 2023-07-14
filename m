Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2234C001B0
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 06:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjGNGBo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 02:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234552AbjGNGBl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 02:01:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A302B2D46
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:40 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so2512377e87.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 23:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689314499; x=1691906499;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgE7BCdrkdi3NO+bbFytp6LnhzOcx40qeHgu/9tv0lg=;
        b=YFqkUoblgoSiajWLoicZWNkoqHurAah+K/vxBHbtCXXxfOnnnUgWL6UeQZhsvu7/rM
         ZCoub2Mir9sbObRAyrQIXp0zWQQ1bm0o3qmQajC473sYkhmecQN/Tf2WGt1AH7qRd/87
         ANXWkZ+NhdWTwYEMtfJAconOvXFkrVsbaJ6FFCuRB1DgKlqZu5hTvOpXqtnvLMNHWY7L
         mbqoyo4ZlOKCXDj+08lvdzQLsKLEoRnIC4v238u2Se7x0HZUBoFG936RREg5YwixVpF3
         0lzsVbZd5QP2j15VOIG+OBaOMDiO7QyXvzRqoELm2tSRyQqMOMo/E8g98GqPnmdisZFO
         vDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689314499; x=1691906499;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgE7BCdrkdi3NO+bbFytp6LnhzOcx40qeHgu/9tv0lg=;
        b=PtvFYmvYHB4JeyfbeEECsmr07ohcWS0DsorwuDY9F0U+GUD4Av9Epzp48ZCYPVwNDX
         6TyZ5STABeksBcoWwVYlxZbuQhID8h2Ld9dz5Npeuf3qpLESmoIfr1e9JpX9YstU8HCC
         btRiSDwDni0w7cdL7mNTfiqk4aRF9Cxf+7SMkqDgFuzIBofySDM7AKAbf5li2j2vwt1k
         O0K8ARKN7L0FwhDbm0sicTG4bH+XrPckI/Iabb0O9p010NJhDWeNoseTH6KwCCOruHEt
         oZxXLe/xoav5+3UthLkZ0ty4obTTYAdMrPOgIxuAXsc63Codg6CaxNnA/yB6M4g5SBFk
         XUxw==
X-Gm-Message-State: ABy/qLaB4R+1xnRdxY2kwsG/yrYUTnyPVS8sgLFwe5XohMp7VniFIkn8
        i60H3dD0ijtYf/XvpuUvCc9btqSEKd8=
X-Google-Smtp-Source: APBJJlGRj0kqgKNEboNWNJspqRky8uvGUFkBtIY7HaKhKcPfNyDVdHBzpd8BgBUDVLZJo4C/HnbJFA==
X-Received: by 2002:a2e:9c93:0:b0:2b6:c16a:db06 with SMTP id x19-20020a2e9c93000000b002b6c16adb06mr3302417lji.39.1689314498678;
        Thu, 13 Jul 2023 23:01:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n23-20020a1c7217000000b003fc0505be19sm587713wmc.37.2023.07.13.23.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:01:38 -0700 (PDT)
Message-ID: <8d4b57a8704b658e5b4fd0d5e78a53e9bc327d22.1689314493.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
        <pull.1556.v2.git.1689314493.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Jul 2023 06:01:30 +0000
Subject: [PATCH v2 2/5] SubmittingPatches: discuss subsystems separately from
 git.git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The discussion around subsystems disrupts the flow of discussion in the
surrounding area, which only deals with starting points used for the
git.git project. So move this bullet point out to the end.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index b89678cedc3..7919a362e31 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -35,14 +35,14 @@ change is relevant to.
   to stabilize, you would have to rebase it (see the "depends on other
   topics" above).
 
-* Some parts of the system have dedicated maintainers with their own
-  repositories (see the section "Subsystems" below).  Changes to
-  these parts should be based on their trees.
-
 To find the tip of a topic branch, run `git log --first-parent
 master..seen` and look for the merge commit. The second parent of this
 commit is the tip of the topic branch.
 
+Finally, note that some parts of the system have dedicated maintainers
+with their own separate source code repositories (see the section
+"Subsystems" below).
+
 [[separate-commits]]
 === Make separate commits for logically separate changes.
 
-- 
gitgitgadget

