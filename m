Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8636DC433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69D7D60EE9
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 05:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237629AbhJMFVD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 01:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237681AbhJMFUv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 01:20:51 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D671C061753
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:46 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e7so1202045pgk.2
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 22:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xZOdQLpEk2PWV9JQZWLLZ8CfzQ7SFN1Htnxm6qlEU7w=;
        b=GCHygXMdH7/CDXCHxFq6vSBpKksb97j8/Mx/vfy8QMbCf+aJvsu1zeaQoXCishp2o7
         AxVoqKliWNOe+ekIvE8sdz+vK2cvjT47ohet9nf7dxaaORGs8rm0EmkGlo5f9GTktaE8
         hMxqp9ulqXa+mBdFcRYSuk5uBDHGDB6GANJLaAZl0MzCejFvURLwLdICFy4XSPLz5CYV
         KwyOGsk/dbgnEhyjQywlrGvoGjgy6SWgVyF6YHbLAhnVOwp5yzbnXy9s+wP+kLgP7zom
         PnGbftS+bfZBYgjasl8KtuX1Ko+b6IgHWxZKz+YAKgiqzam9IJ1vz5+FRJ8/7muaNg0/
         9rUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xZOdQLpEk2PWV9JQZWLLZ8CfzQ7SFN1Htnxm6qlEU7w=;
        b=eaWONkDNa0PSUhiF5z8dR8Hl8/QerwZb9HjQMaeO9KehtKBE2d5z9wKkoP1hs+ANAA
         +eeDlNU2HCKZWFaFPvsN/pIkPSO5qzBCzXsELB2+X/LtusPKtiMJKYfOoHJYuWwODQLp
         RkIVrqQuF1uTykphbk/8vvqLWGnL+/GSjYIWmYfrsrxdQxrCxIKU4Rg7H7m0yhEFjfzl
         DsSWvBxSxcKjE4RUmaC40Hx/ons7zWeQhK0SBZ6eb0yc0NkCKnYnOHpMa+qSFRJTiWoS
         2bKrt+24RLG/zISEzP0Lw2QwzjrNjSUaa+Z8iSe5cvuGpy6xC19a9U8/EQl5ZIHI3/ay
         97Gg==
X-Gm-Message-State: AOAM532lmgxcr/WOed2VBf7zKM/Yuwl+tuBn4k4AuW79M6vYwAKXTjYS
        ck1L8MebCEv/Lcn/XVwbuy4=
X-Google-Smtp-Source: ABdhPJzyRadvtN1cSJDmcqR+RfE1b2ZDXitFGuVoam8zapP01R66LcabR/Jb8I8wGEZVFimA+yhBag==
X-Received: by 2002:a63:3389:: with SMTP id z131mr12507614pgz.469.1634102326083;
        Tue, 12 Oct 2021 22:18:46 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.111])
        by smtp.gmail.com with ESMTPSA id 12sm12481197pfz.133.2021.10.12.22.18.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Oct 2021 22:18:45 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com
Subject: [PATCH v3 4/9] submodule--helper: refactor get_submodule_displaypath()
Date:   Wed, 13 Oct 2021 10:48:00 +0530
Message-Id: <20211013051805.45662-5-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211013051805.45662-1-raykar.ath@gmail.com>
References: <20210916103241.62376-1-raykar.ath@gmail.com>
 <20211013051805.45662-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index f60db966ea..5b4f1dbcbd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -261,11 +261,8 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefix)
+static char *do_get_submodule_displaypath(const char *path, const char *prefix, const char *super_prefix)
 {
-	const char *super_prefix = get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -281,6 +278,13 @@ static char *get_submodule_displaypath(const char *path, const char *prefix)
 	}
 }
 
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb = STRBUF_INIT;
-- 
2.32.0

