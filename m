Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868A6C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:14:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AD7D610D2
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240882AbhIMTPm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:15:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhIMTPh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:15:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12163C061574
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:14:19 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id c8-20020a7bc008000000b002e6e462e95fso161184wmb.2
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 12:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YiMMZ6wY7F8B7c4MG0cQh4JbKiT6VjBbKIzcVWU27ds=;
        b=I9G5y8JyP0C7SRozvCGM3COlkK17QOQjluQ89KAjYGd/8qG+igDq4DNDTptBuelji2
         y4nAJOSy+BtC9qSIhMUDyG3BWln4/JmUdxJaIWCcPTMMgQDQZG7qXjLe/KTI8+/qsjE4
         Q614M7OMD6iK6d3wDsufHCy/9UJfl33s5TxE6TZUFB5ill4+izyt11Zhj0mRe8FV9BH3
         K7pyHD06lVXAVmc3hIxkUvB724z2CG2WLEtjwVSIWr9Zz5gX8OQFwx5vsvU/FTtb3EmN
         m6hOh2JPSFF5THrzZpXemgn4MkHYPBmUYBmBv9aKJci3/rYy8YCuRVKZukow1esblzEs
         m9ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YiMMZ6wY7F8B7c4MG0cQh4JbKiT6VjBbKIzcVWU27ds=;
        b=JXWnrGBSdrXD85hMxXz73odQHXULIYE1d5CZDWF/EsdHa4RTiCHFY/5FyRXrI5WMMi
         KkQcZrsj3fj5umtm5i+C6pU/38lP+D1EZokO4vRY3BXtwJbkqoo2+EJCJB+fSy1Lue/U
         17wDGvf+iFQ1VhqO/8Uc4VmVNzzzW0SkaA8UfcnBG+NiMsTgp7PaRUIA6Id9mCMAfdp+
         Oifvxdw2Ri9yrGfq7oimrzGXXy3YMbaNaqOQnWIdAgPscImPLNZk14lWZeviSU849ZdZ
         6btOjh1rogNpyGeEUniHdPzWioQNFnepNs3PTh5+CdRGhJI37DSK4beIspp2HBiMNVWq
         LFcA==
X-Gm-Message-State: AOAM531wDIKbMN268orfSChYC+6bDlH0tGfE/zbMpFSpln2utUIaEghk
        Eo/G67CtICOC4OGYcOURpc6KT3H15uY=
X-Google-Smtp-Source: ABdhPJwvtL0At3bOoWiBZXCidEBy627o944x7JaF2rzKmes1ZvGmOiZnuNZq703PDelMZA1FT0p80w==
X-Received: by 2002:a1c:7310:: with SMTP id d16mr6817809wmb.30.1631560457692;
        Mon, 13 Sep 2021 12:14:17 -0700 (PDT)
Received: from ylate.lan (abayonne-651-1-48-114.w92-156.abo.wanadoo.fr. [92.156.201.114])
        by smtp.googlemail.com with ESMTPSA id l2sm7711919wmi.1.2021.09.13.12.14.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:14:17 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Alban Gruin <alban.gruin@gmail.com>
Subject: [PATCH v1] git-clone.txt: add the --recursive option
Date:   Mon, 13 Sep 2021 20:59:41 +0200
Message-Id: <20210913185941.6247-1-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the --recursive option, an alias of --recurse-submodule, to
git-clone's manual page.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
I found this out when a friend told me he could not remember how to
fetch submodules with git-clone, and when another one suggested
`--recurse-submodule'.  I checked the man page, and I was surprised to
find out that `--recursive' is not mentionned at all.

I did not modify the synopsis.  So, this alias, although shorter than
the "real" option, would still be somewhat hidden in the man page.

 Documentation/git-clone.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 3fe3810f1c..8a578252a0 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -270,6 +270,7 @@ branch. This is useful e.g. to maintain minimal clones of the default
 branch of some repository for search indexing.
 
 --recurse-submodules[=<pathspec>]::
+--recursive[=<pathspec>]::
 	After the clone is created, initialize and clone submodules
 	within based on the provided pathspec.  If no pathspec is
 	provided, all submodules are initialized and cloned.
-- 
2.30.2

