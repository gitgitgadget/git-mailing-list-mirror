Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E102C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6482E61159
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 16:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhIUQxG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 12:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbhIUQw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 12:52:57 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740A2C0613DE
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:28 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id e5-20020ac84905000000b002a69dc43859so54329060qtq.10
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=HFqLEkU1/Ra2gyePyQyr5P3z6Ttngf4Jb3XsJstas8Y=;
        b=ew2gNDem6FrwrOWzm4KPW/T3IkZZ5PvmgYFso5XXyQJ5sHL7HUHUIcaz68josgwn7E
         enUgX2p/bijqES0Hm5MePoIUdqRNW3kPe4nILC9iz73FgMI58KdB1WbctmWIJz4iSbVu
         zsfpoeZZvLWg8jWpd+DZ0MC+2MqefbKc58m4PZ4oSy6+5msd8ZKyTNuPnZDDuFYkIhR8
         jm3Jtv28U4ECRns/pkOEP1r4c4mQHuyU0854pXYRJQyUUvzh7wVobm26wW3CcCKCPccd
         8EWjCS0jgledftdQDJlDjOTffD3Ye1IsuKWW0lGn22VIvSNdqAekoJlChTGkg2n3yCBJ
         mpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=HFqLEkU1/Ra2gyePyQyr5P3z6Ttngf4Jb3XsJstas8Y=;
        b=7RZ9+qO1uDU6WjDHj+92NW/fdq+qmYIFu7gc06LoKkEKJzXeMsjtOuNy6W2O8H3Hau
         BRO9I9+QK4mD5cXRP2yvsaXGPxt3soKxLNewSsPbEEZvvKr2fr23PvLRU2nm87KnOcRR
         GtZ+yP4yOt4Uj+/xILcBDt9PnkLXgekSobRXJ60m4tYBldNKqZwRu+idDmoGXuzTGS7Y
         oBKuzuBo5o+OG1OJjJ9t+jnOwfNv0ekxh4kMJDNCz421VzNidcZJU7hSTVFjVX6yQ9RF
         O0OK2Yg6PCHBhwx+51eo0zwuaXjLj0JCOtEbrEl2NhkWaK6iBX1hhlCJHCZRkozBROg7
         H6sA==
X-Gm-Message-State: AOAM532kmxKDFMNsf3DLRz2DpaE9lFFT7xoBgsbquzbsSlxYTECvxVuq
        mLod4+1NhfXueugvFUSWMOMum/jO/+qwpM8zfKo7BjgDxpNYCUTbj2utFTNsgDNlXzwTDrU+iFO
        uh9c/DD/n05C3QOdSHUPoglfwc47jxmKnQCCWQMZ0bdQssnhwdWfObkCYgUiwslV8ylToSEY5+i
        II
X-Google-Smtp-Source: ABdhPJy+JB61oS30bYuT3Flr4VjS1UAMx9BFgFKTKvVJ0OaU/Y5K58vX0fF4nJWxag7r+H6ai9f3DGRGLOS3ZF+npi0Q
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:723:: with SMTP id
 c3mr32136692qvz.60.1632243087677; Tue, 21 Sep 2021 09:51:27 -0700 (PDT)
Date:   Tue, 21 Sep 2021 09:51:11 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <933c505de862ce11f522192745dad78dd8346b99.1632242495.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: [PATCH 9/9] submodule: trace adding submodule ODB as alternate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Submodule ODBs are never added as alternates during the execution of the
test suite, but there may be a rare interaction that the test suite does
not have coverage of. Add a trace message when this happens, so that
users who trace their commands can notice such occurrences.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 submodule.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/submodule.c b/submodule.c
index e9757376c2..77e76d3f9c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -207,6 +207,8 @@ int register_all_submodule_odb_as_alternates(void)
 		add_to_alternates_memory(added_submodule_odb_paths.items[i].string);
 	if (ret) {
 		string_list_clear(&added_submodule_odb_paths, 0);
+		trace2_data_intmax("submodule", the_repository,
+				   "register_all_submodule_odb_as_alternates/registered", ret);
 		if (git_env_bool("GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB", 0))
 			BUG("register_all_submodule_odb_as_alternates() called");
 	}
-- 
2.33.0.464.g1972c5931b-goog

