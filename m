Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AA6C433EF
	for <git@archiver.kernel.org>; Wed, 20 Apr 2022 09:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377367AbiDTJ7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Apr 2022 05:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377358AbiDTJ7n (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Apr 2022 05:59:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AA438BF0
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:56:57 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so868482wmq.3
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 02:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Mc2YEAu3ezPc3vqrdQbG+5AlHxptS5xsMenkYldx7js=;
        b=Cxi4GznrAMCVUJB+Z5bTM4hd6AtOeRvSu6fmPQk1YK3DyoTOKEq7lhAht9IoFMRphr
         Bvta+8AK3oKCSc8r/ofrwcBjV3DsBO2wV8YCynuW1Qqe5RPyzs1B5QPAXlB1/d7NCvxf
         tSSj91NjCroAfc1rmfR3w2QobNHnAb0BzQQ0R/HO/WQIq2OS5sbDh0Qeutku5Yu/DxWy
         7aNYOnUbLTvfM+0s+F7etQD3di7Ljhb88Z5LaDLCUlu40i4pQVjEbTWvLcwtSV8kYCZe
         4NF8j2lHt9jmQD/52e3DLqSKAbcug937EvV3GPeYlqPFhqnlxzGVUp/ll+/edJLXPoKs
         HUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Mc2YEAu3ezPc3vqrdQbG+5AlHxptS5xsMenkYldx7js=;
        b=UJSAoBv/G6ljOEbKHX146IoDalC8Ck7PmL1Y/FtAPGFkqqAeM5/jlRaEFzP0BwQlJK
         ddeFrJq+PrQL8PB3Hpqqj1hzyw02SgkZryCBIZe2nz+0p6Okr1xrowQl+eED3xS7aV6M
         9K4gPh4B5ONr2IrHwrOQgbiWyVc0MJPCAX2HSj1/F531F+F6RlwWOgyyWk1cJdv6ARSn
         5X9gGdzllEwGRpJP+r/0LoxZq/3fqPCBg8CVRU7CNAlKdthro32/RTBueaodiCwe83Vk
         k/MUjyrPOopmdWmzUL4rGXZpjysCsZ7ojybRgRSVw0GGQPCY7qx8r54we5THliAQvQoY
         MbpQ==
X-Gm-Message-State: AOAM531kdIB6EykAYfWdbkTf3AkLg+MnXwQKNJXQ1ppEbJxCtJl/Htw4
        lQI2/gRdOE4XPuy4O+IPWB62+idj/eY=
X-Google-Smtp-Source: ABdhPJwN65a4F6bNFwdQvX0+R4ldXY1wsGRTFsq6QkyC38tL+dBb4fkO7U610L2LODA7tmoBXnxloA==
X-Received: by 2002:a05:600c:211:b0:38e:d0f2:8a3f with SMTP id 17-20020a05600c021100b0038ed0f28a3fmr2837960wmi.8.1650448615192;
        Wed, 20 Apr 2022 02:56:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a05600c4fcd00b00392951086efsm9462700wmq.34.2022.04.20.02.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 02:56:54 -0700 (PDT)
Message-Id: <a4320f2fcf35f180e1c585be4105194f1555a874.1650448612.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
        <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 20 Apr 2022 09:56:44 +0000
Subject: [PATCH v2 1/8] rebase --apply: remove duplicated code
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

When we are reattaching HEAD after a fast-forward we can use
move_to_original_branch() rather than open coding a copy of that
code. The old code appears to handle the case where the rebase is
started from a detached HEAD but in fact in that case there is nothing
to do as we have already updated HEAD.

Note that the removal of "strbuf_release(&msg)" is safe as there is an
identical call just above this hunk which can be seen by viewing the
diff with -U6.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index e942c300f8c..4832f16e675 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1782,19 +1782,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	 * If the onto is a proper descendant of the tip of the branch, then
 	 * we just fast-forwarded.
 	 */
-	strbuf_reset(&msg);
 	if (oideq(&merge_base, &options.orig_head)) {
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

