Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144D3C32772
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 14:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245494AbiHROBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245694AbiHROAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 10:00:42 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986906F57D
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:00:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d5so866697wms.5
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 07:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=tOaSnzMg9n9y2/S6tQ/g1Ze5+8F25k2Q/Fyk327HsgI=;
        b=b2+xmyXPed/t6Cm6we4H0yiksChNYwcYHuUqdUFKyGp0y3xnsV5J70pfmt+/3FoJeF
         esScR2+3+S3/+UJ2Gbm2/ksIDagaFW0zVfjB0sADB8Ss+ij4NRVOfLT4PnZJ+zknKJ9e
         9/kQ79TsEWYm7+1JxK3Y8F4hnLIuJp1ER91SIUf0E1QP0NORUgTaOq/T/gGtDCIkrSbA
         nHhKIEPivcObuUUeBCXk5EweoZv3ZVtV180mwJrGJ3+hksRA9wDAQj3fRFiaE2G1OZ9F
         xJQmIkzSzo6uv1zm5grBATOGlTjKnuePeHX/s4tHhT0cuwwQxqtUAclRDx0jAlvKMM9D
         yiHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=tOaSnzMg9n9y2/S6tQ/g1Ze5+8F25k2Q/Fyk327HsgI=;
        b=ljfA5L47j2boPl7YqKGxTLUzCeisAeA7ItOWKakVVCYMKAUkX97rNkB1uUBNgpGKZK
         JGmSRcc5p36ssoFBN9PPauTeocZEayipYC7uC8XimnuymHqaX/vdCPa31W3ipWW5gBnw
         6KrKuFDIbvV/Mlrrhs1gXoY72cO6/ZFKanQ8/riONZClPCrKO73LKdWJcYZ+k9GfSXDq
         RklLd59XQI5vaPFPeeP+R2dRBDw6JDUzhYJeCOvw7GKPu8pwoHYBQGskmTQ9mzGb0ZJz
         QdYpy6w9CXvzBHbcr483fu5OiLdD+Hh6shN76ZVyepGVLNkD3WzeM11EZpEQH+tHboV5
         M7yQ==
X-Gm-Message-State: ACgBeo3r0/K0cuiiKvjPya+YvIYEGGGOmkkJE+40Tv5VHKfKInUCsloU
        c6QEZe29HvLgZTm17xRjiEUs8sw5T+o=
X-Google-Smtp-Source: AA6agR50c3L4b7A51WzgM9PeWDus4GuwvCvl2V9amoPFtf+xYYiaNw4jRyhSoZ8cxHD5eqIt+RuoXg==
X-Received: by 2002:a05:600c:1d16:b0:3a6:1fa1:41f7 with SMTP id l22-20020a05600c1d1600b003a61fa141f7mr2800373wms.103.1660831233443;
        Thu, 18 Aug 2022 07:00:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m19-20020a05600c461300b003a550be861bsm2187015wmo.27.2022.08.18.07.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 07:00:32 -0700 (PDT)
Message-Id: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
From:   "Sergei Krivonos via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 14:00:29 +0000
Subject: [PATCH 0/2] Make rebase.autostash default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sergei Krivonos <sergeikrivonos@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergio (2):
  Make rebase.autostash default
  Add Eclipse project settings files to .gitignore

 .gitignore                      | 2 ++
 Documentation/config/rebase.txt | 2 +-
 builtin/pull.c                  | 2 +-
 config.c                        | 8 ++++++++
 config.h                        | 8 ++++++++
 5 files changed, 20 insertions(+), 2 deletions(-)


base-commit: c50926e1f48891e2671e1830dbcd2912a4563450
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1307%2Fohhmm%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1307/ohhmm/master-v1
Pull-Request: https://github.com/git/git/pull/1307
-- 
gitgitgadget
