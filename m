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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F2CC432BE
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC80D6056C
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhHJS3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbhHJS3S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:29:18 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CF5C061799
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:28:55 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id w11-20020ac857cb0000b029024e7e455d67so11578747qta.16
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 11:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=687v8D5TYXa4xyKEui7hwtnSNbZL7ND1Y9SjR+Ep8vE=;
        b=AS+XUjbmFWf2snrmXnFGyTCTaOdZjOKu8tkWe1/3mJPkbafAvwL/rBLAt3ALoNlCgc
         3awEAtvOgUQADiaoukNBmW98h3cEPVXnl/AoS58FthDit1OTEHxoMsfkCYiIoGPO5khW
         udsg71URly0+ykrY1RbR+KFAQhdOyQse7Lo0JJaLY35RNbcCaT09gsHlMswqTejBUFTz
         +KsamxcpwXFoY0LGGXiG5KiGyrsZ3sw8XDLxnFyrRoPUiTPRthnHBAw3HRSLVO03NJ1f
         gpaMK2/GxUIksReVUYtYGiALuGttMj6+M7n8Z90ihvOe72/TCkOfC6Nb+paO7si6t9qG
         T0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=687v8D5TYXa4xyKEui7hwtnSNbZL7ND1Y9SjR+Ep8vE=;
        b=cI0oiiBKfdQMX4tH7F2gp8pm+Tr/lET1sYgDMYyn3ZVD6rwEcJM2p0sBEzbA8kx1vk
         ncW5c51tP52adHrVvsKEhIriZVZEkUiyn6SGaqXNhXAWhLBwcJu/Anr823exWofZ1C9i
         9HBew4wdfN69PyweU39gYk2uJFp6jOTBdrvvH5UiONCxQeXApQfhaTam/Sl++laK8se3
         XVBbLB5vazhlH1eCv7kk8U9IFe5oVj9hEQIRiE2Q+tsu+O7VPrfMF+9Kt4Rg4R1GlXoI
         cdiZSWqfwk55fm9LvANtxX3UdrRQHg10Aufmejw7iDAn5Qb4Ya54vnF5PtziJxgiArz2
         Eqzw==
X-Gm-Message-State: AOAM533vB2hoRVADB7+m834Iy7841wJ1Jzxrh1b5PAie9hQZSjbkzriA
        K0Z8FUiweG8Vc7lb5kq6142XRfBfh2nuXeOk+4fOWA0bC0tjjTjdFPt1S2cetc8QMWrtUKMMwcQ
        6dnAXy4jugB8Dx2srJF0nlO/avH7BGkl4Q6kix1SsqsouOG/VtovSIjhXr+38J7Sho5kA4ZVbfg
        NJ
X-Google-Smtp-Source: ABdhPJzhG1MMHubq7nA649QdnSkedd/15ELMV7ip29ktDMrTTEfghKFlfcilaC5F2gZLZlJSWhRKkeXvjQ6dTYFfRkxB
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:dad:: with SMTP id
 h13mr19357660qvh.9.1628620134658; Tue, 10 Aug 2021 11:28:54 -0700 (PDT)
Date:   Tue, 10 Aug 2021 11:28:40 -0700
In-Reply-To: <cover.1628618950.git.jonathantanmy@google.com>
Message-Id: <31e9b914c4bb500a98fbb14674c93a0d8ece47a2.1628618950.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1628618950.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH 2/7] grep: use submodule-ODB-as-alternate lazy-addition
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
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

