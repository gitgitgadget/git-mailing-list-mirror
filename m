Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D44EC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 09:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiJLJfU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiJLJfR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 05:35:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69A533E3A
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:16 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r13so25349955wrj.11
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 02:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGrXmzqqST9iXNfjUV8b8UO/R2MiFaBpmcQ8GxkqVDg=;
        b=NlYY/gqw5TEoJUBuXS8ts7/hnYbjRqP6F0GlO/wJc3LsChfzpiIr4IH0ZidW8CEcHK
         blAZlQPhpfiMMhoBML8kaxDNPQIahEyzuPBMvTKbgQNUtfMRgdtAxz+6K8TFO8Zisjae
         XfcY2vUrhxMZQKpqS4MU8VaWaxg4T8x21Y0gOiPk7+yGrvewd2Ia8qhFdN1sRqN4eiLJ
         kjbi/5Tf8kfFy29y4JoM/MjD9mcPFd7aG3Gal/DlJkHpvzdirldpWJ4LgF5D1RJFBx1G
         FcfAHcBFBObV/2N5lXls0zrt/nqkwTRanVashdhR+LNr4UuK9vlb83Aov82yFDA7u7OQ
         xF5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGrXmzqqST9iXNfjUV8b8UO/R2MiFaBpmcQ8GxkqVDg=;
        b=hhAbaf3K++XLHe1dRkIf1QsDfgKLqR/Xfr53Qk+JJ2UQktfaXUfQS+LlK6xWLGWYbT
         zDifALwstlkVmJVsyb7VhnA5dBFkJCr8FHNKloUXHqZ9mzB15ykG2UUEoBoILgfo0KXF
         gibbHwPTKWpOAFIwpzSg3eEanqaI3rSaOj1ivWXho6NINO1rqewsFBmOnCOyiqvwLvwJ
         h76ntvzmWH5NJ2svHdn0LTfuqHo4JQmoaa2mvPGwOrzz6WXBak0Gs8V2PVPXPPLi8ui8
         9hk+LnOxhCVq/EcGjNACSqGnk6DzWLVuRMz0uD0NHBMnYTXOCoc5uoA7O+2V86yD0yDK
         1IVQ==
X-Gm-Message-State: ACrzQf3nDNT0eNI01wqqgIbXtQw2qp7xDhHnjUF/wRvgLwwC2TicPNqN
        lxI3xhl4EaPUryPesl6ugBd9Atiokrk=
X-Google-Smtp-Source: AMsMyM7rAFBnS013QxlwI90oP07HlrfPABGiHyAUBQ+Ie96M81RclqfGe2+5304LXGKZZiXovziUwA==
X-Received: by 2002:a5d:6111:0:b0:22e:5476:9659 with SMTP id v17-20020a5d6111000000b0022e54769659mr18185955wrt.711.1665567315128;
        Wed, 12 Oct 2022 02:35:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n2-20020a1ca402000000b003c5571c27a1sm1672449wme.32.2022.10.12.02.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Oct 2022 02:35:14 -0700 (PDT)
Message-Id: <a84cf971a753e294555ca8f2b7eaa4c75a8fa491.1665567312.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 09:35:05 +0000
Subject: [PATCH v3 1/8] rebase --apply: remove duplicated code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Use move_to_original_branch() when reattaching HEAD after a fast-forward
rather than open coding a copy of that code. move_to_original_branch()
does not call reset_head() if head_name is NULL but there should be no
user visible changes even though we currently call reset_head() in that
case. The reason for this is that the reset_head() call does not add a
message to the reflog because we're not changing the commit that HEAD
points to and so lock_ref_for_update() elides the update. When head_name
is not NULL then reset_head() behaves like "git symbolic-ref" and so the
reflog is updated.

Note that the removal of "strbuf_release(&msg)" is safe as there is an
identical call just above this hunk which can be seen by viewing the
diff with -U6.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index a2ca66b54be..51accb4fd61 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1808,19 +1808,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * If the onto is a proper descendant of the tip of the branch, then
 	 * we just fast-forwarded.
 	 */
-	strbuf_reset(&msg);
 	if (oideq(&branch_base, &options.orig_head->object.oid)) {
 		printf(_("Fast-forwarded %s to %s.\n"),
 			branch_name, options.onto_name);
-		strbuf_addf(&msg, "rebase finished: %s onto %s",
-			options.head_name ? options.head_name : "detached HEAD",
-			oid_to_hex(&options.onto->object.oid));
-		memset(&ropts, 0, sizeof(ropts));
-		ropts.branch = options.head_name;
-		ropts.flags = RESET_HEAD_REFS_ONLY;
-		ropts.head_msg = msg.buf;
-		reset_head(the_repository, &ropts);
-		strbuf_release(&msg);
+		move_to_original_branch(&options);
 		ret = finish_rebase(&options);
 		goto cleanup;
 	}
-- 
gitgitgadget

