Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08EEC433FE
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96A906124F
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 23:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347467AbhI2XIX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 19:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347475AbhI2XIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 19:08:17 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DA5C06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:36 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id ke16-20020a056214301000b003828c7cfd7bso9407502qvb.8
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 16:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=nEK0YW4RyngRwSrhB2/a1MiORL8rUO3dHHdC1i3zZNE=;
        b=LqlObyyNXxFE64whyGFDu5Xpi/2ok0hmmsSLK0BA6KJgZOv8hC/DpPzDkzXk/FXTyE
         VTeV6PoFS3nFNXhudKhZEeScKbaafiH4qT8G3BgfQJWwFJK7PSpRS+CXlg+sNCmM3uZo
         qxvcCGxwD4Iiqe6IeUWwmFLlKETuSv/NRsC3lIk3ZxdAXfrIYusz7O6SRISBq6y02kgG
         x8Rm74lhvaj4uucfr4dwiCvarafF0NE9fTj2Wrxvzb1Dpt4kRVWzGNUohLeUYDmVPglQ
         Y+GgAENrBdTBh67I3vdMG/1E7R++IU20hqcBBa+VViDTvZnrv8H8Ys30hKdJXdRC36IN
         hTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=nEK0YW4RyngRwSrhB2/a1MiORL8rUO3dHHdC1i3zZNE=;
        b=oZwo+2W6SMSHSecTvS10IupxfwHLPYSbNj8LphXWPCQ+80BhgnLsQdSjxduf1olWoL
         3nuk8Ba7mssKmAlqf0GCvzFniYg2UNeQnoIqZ+gmGC8jhdaIPwI6wJyEWVoyS1gWm5nG
         k9zI8or0vOjuOmIjw2qwqJXNOAfLUAvgYJBu/3tJBGg7YyLmJMHUKz1PMihP8z0tiiwb
         ic0AhffAxgOwz+g6BwiYAc4mzLTnCmAmOjtsANdzUWjQQH78lkwM8pf98MvWiP7wBM60
         IQHltG1hcSLwEI5IlLoFyrIQHhJXk8id5qvfXOAGLvyUJj7XT+cGHc8Gecq62u1mWW6W
         gWsA==
X-Gm-Message-State: AOAM533kKbKO76Jb80Km6oxw6dq3PbadKVJUGsodJBtwr6iB+2Wxohby
        3JWtHcVJI9wEip7im6WSbmnuCI4IrEBA84h+PEWcBo0VFSio9iICW4t+MNqD7xo9surjOQVZ4NZ
        FRf7wMxaW6+7GCENhCkmYLhHuC1LBV0yj8F4a4EQA++16OfJ184+MH8NJESTYBpgyGAQyJnVAfp
        ug
X-Google-Smtp-Source: ABdhPJzl7B74h7yn6xkfLbjH+2QGmou+pGfKSwQBQJfF7sh/hV/VuUrfSN3wR3nEAesj4j3FEcWfrMhWZcuoCj9Kq+T3
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a0c:b38d:: with SMTP id
 t13mr895043qve.24.1632956795173; Wed, 29 Sep 2021 16:06:35 -0700 (PDT)
Date:   Wed, 29 Sep 2021 16:06:21 -0700
In-Reply-To: <cover.1632956589.git.jonathantanmy@google.com>
Message-Id: <0200f1880b7d92dcee0ef1d011bdc654bc3b4f0d.1632956589.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com> <cover.1632956589.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v3 5/7] object-file: only register submodule ODB if needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a35e03dee0 ("submodule: lazily add submodule ODBs as alternates",
2021-09-08), Git was taught to add all known submodule ODBs as
alternates when attempting to read an object that doesn't exist, as a
fallback for when a submodule object is read as if it were in
the_repository. However, this behavior wasn't restricted to happen only
when reading from the_repository. Fix this.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 object-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index be4f94ecf3..2b988b7c36 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1614,7 +1614,8 @@ static int do_oid_object_info_extended(struct repository *r,
 				break;
 		}
 
-		if (register_all_submodule_odb_as_alternates())
+		if (r == the_repository &&
+		    register_all_submodule_odb_as_alternates())
 			/* We added some alternates; retry */
 			continue;
 
-- 
2.33.0.685.g46640cef36-goog

