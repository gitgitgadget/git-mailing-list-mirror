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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85002C4320A
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EFDB60FC3
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 21:05:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhHMVF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 17:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbhHMVF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 17:05:58 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF03C061756
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:31 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id y26-20020ac87c9a0000b0290295092a93fcso7229757qtv.5
        for <git@vger.kernel.org>; Fri, 13 Aug 2021 14:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=687v8D5TYXa4xyKEui7hwtnSNbZL7ND1Y9SjR+Ep8vE=;
        b=DvlXMVbKuUv1Zg7Ld9B+KO80Xjsl3OAoUIxwYoeG+ymV51CwfNgEs1wL+5GxoYMUxh
         rQs2D0BTz56Uvn5FjuI9I9pE/4y8IRmyGmU4pJmZwlInjgSOzpPBi4IBIq7eut3IPqmz
         lBHbiWqywOfy92s5CXQl+uoXZB5/sGd7K5Xl2GA/iMEvuCIOYEqTKarT9nrHAp1iFfRQ
         RHzPtShNRpZmSKnGF+n4z0IEfIr8qZUdHcWFTUdPFgfXOr593cB2GQRihuNRVnMNze+O
         gjAdSO9EgXAbzMV3zBVGl+WhPFzKet+dkBOObf1gubPDtuYSVFgeDhCDBt1ua/8AsyNi
         ca2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=687v8D5TYXa4xyKEui7hwtnSNbZL7ND1Y9SjR+Ep8vE=;
        b=Z+VSUzd/mMHxcYL/w09BQk7qog4eRPCMgV50Nw3dg+jQTLEWRJAXpSg5KDu0Wlpken
         p1hLxIYKZdOFNn9g8m8CwBPLKowa40wwJaeqsPDR6vHzMKe63b0gMmcpG9RgyNjXBBZi
         T35nCK66F68hOrgHoeLph0YLFtBLdqea/EBq4IbyAjyxrhEmv2VG/2LmV2395cJdd3NW
         MojP92FeliigR5VLNWP9tBrYT+CgGIWyyAY2N675tGjefTHr9Wbi08yLN1S317+4QkC4
         ZA86OHKX9JNLymA4tZlLBVzXoWE78FIWmXZyZzjUY1FKsklXW/yNrj8uWokJYTea1c54
         r+Ng==
X-Gm-Message-State: AOAM533U1CIOLsFL1/nZ+AYMYze/PqOjbihQwfBtAeM1gR9imk69cdFi
        5b/lE+V0T3ze7wN/KkLdc27u+xl7aSN8jkdgLKjQsl3TbeUJfov87IV3fCupfJse6skxPJ98SBV
        0ZZ5KQ/Z9Zokg/8TDs9I6T84Zs8BIlF5iH9MPy9VvRyYqnm1gKrWwSYOEDHGloIj5iOTyTKRY4a
        8x
X-Google-Smtp-Source: ABdhPJy75BJyoXY35cm4B7VO8IDsHuRki18UojEoutDhKye3DcA0MEZuYKYcLjjHhwbfV3YrGSWEHzuHcD/tUkc93Ss3
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:2022:: with SMTP id
 2mr4530824qvf.38.1628888730623; Fri, 13 Aug 2021 14:05:30 -0700 (PDT)
Date:   Fri, 13 Aug 2021 14:05:17 -0700
In-Reply-To: <cover.1628888668.git.jonathantanmy@google.com>
Message-Id: <31e9b914c4bb500a98fbb14674c93a0d8ece47a2.1628888668.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com> <cover.1628888668.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v2 2/8] grep: use submodule-ODB-as-alternate lazy-addition
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, matheus.bernardino@usp.br,
        emilyshaffer@google.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, steadmon@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the parent commit, Git was taught to add submodule ODBs as alternates
lazily, but grep does not use this because it computes the path to add
directly, not going through add_submodule_odb(). Add an equivalent to
add_submodule_odb() that takes the exact ODB path and teach grep to use
it.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/grep.c | 2 +-
 submodule.c    | 5 +++++
 submodule.h    | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 7d2f8e5adb..87bcb934a2 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -450,7 +450,7 @@ static int grep_submodule(struct grep_opt *opt,
 	 * store is no longer global and instead is a member of the repository
 	 * object.
 	 */
-	add_to_alternates_memory(subrepo.objects->odb->path);
+	add_submodule_odb_by_path(subrepo.objects->odb->path);
 	obj_read_unlock();
 
 	memcpy(&subopt, opt, sizeof(subopt));
diff --git a/submodule.c b/submodule.c
index 8fde90e906..8de1aecaeb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -187,6 +187,11 @@ int add_submodule_odb(const char *path)
 	return ret;
 }
 
+void add_submodule_odb_by_path(const char *path)
+{
+	string_list_insert(&added_submodule_odb_paths, xstrdup(path));
+}
+
 int register_all_submodule_odb_as_alternates(void)
 {
 	int i;
diff --git a/submodule.h b/submodule.h
index c252784bc2..17a06cc43b 100644
--- a/submodule.h
+++ b/submodule.h
@@ -104,6 +104,7 @@ int bad_to_remove_submodule(const char *path, unsigned flags);
  * the_repository.
  */
 int add_submodule_odb(const char *path);
+void add_submodule_odb_by_path(const char *path);
 int register_all_submodule_odb_as_alternates(void);
 
 /*
-- 
2.33.0.rc1.237.g0d66db33f3-goog

