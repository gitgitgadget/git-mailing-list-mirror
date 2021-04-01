Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E73C47065
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E43C061393
	for <git@archiver.kernel.org>; Thu,  1 Apr 2021 17:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbhDARnJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:43:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbhDARh5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Apr 2021 13:37:57 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F354C02D54A
        for <git@vger.kernel.org>; Thu,  1 Apr 2021 08:41:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v11so2259595wro.7
        for <git@vger.kernel.org>; Thu, 01 Apr 2021 08:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0wIqWvl3C7SoxxKv0Hgug46sR+HfmyuK7Ceh9eUHOwg=;
        b=kMRsp09fuTncNCjx195kTSOAEH2xXntP1iUGF22TQaz9lAjUWXzXqIR+idpAWEM4lw
         9/RypKJwvDRi5SCWKcWRyrpRtlhqY/tpYJX0GFo6SP46S3g/1ZcIrcL8saKXclyoOsMJ
         tyNS0jW4WJHNGK4sCWL74POa1+sSuDjNEqCe7ohBkPMb+/r5eZKkseLQJIHK+iaOHJgv
         ZZXPjhX6tX9Rd+GJnZ/4po4HfgN1A8O6zaK0nLfcuMz+bb/6+VrTnQ42KOP7WvWFPmh6
         lk4FboN0gABXyd1+D9n24AbE+7Q+MISEFiT0FcZ8Q2ZjC1MU4J3M3IHtpU5NM7ELMZSa
         ZI6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0wIqWvl3C7SoxxKv0Hgug46sR+HfmyuK7Ceh9eUHOwg=;
        b=kMfiojjLSAg3hErxQ7I3IIBgEQCov6ULwZ42shgLgyojI6mO9k+25bmJxCQ5PRJx+8
         2rHD1ut/dDGV56eNREjYYSzIZdCF2hqWaB9HuWtwUoO/oof367jWGS/PuPd8lIFzYsnb
         oK1VbsRlYhXr41EXXi5ptLMeKuktSUaoe2yEMNmiVZZNF8gSwKsEWdhW3spVJ7UFbhqZ
         xeu4JhMakQDflBupCJGXSZf3bYlVtuvttsAxw0OSBHeyEqJPZvbbjolElQA2buKaZYM9
         JVdQcxrYRH4HoT4s0PPYflqca18wZVCsbkOcrkK4Fk5gcIpZky9jdD/AWGL9NYTSS8Tg
         i2lw==
X-Gm-Message-State: AOAM53048RNYlsqu/JP8DqXP8vC3eGoz8WtxupOY51V5p+OHNzTtP6Ym
        NwSEKqua+S3rveTzLQ9oUPQy7XFGPtY=
X-Google-Smtp-Source: ABdhPJylMJAM8jj1iaPBsMbqGasc8Vc199VsS0rFgoNS7AaFRvICfgYF/pj8//6y0yHbRdh+ON+vmQ==
X-Received: by 2002:a5d:4105:: with SMTP id l5mr10895187wrp.105.1617291680406;
        Thu, 01 Apr 2021 08:41:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g11sm10229169wrw.89.2021.04.01.08.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 08:41:20 -0700 (PDT)
Message-Id: <d699ad597d2c40cd2c0fe8abbf75b5386d4cf0f2.1617291666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.git.1617291666.gitgitgadget@gmail.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Apr 2021 15:41:02 +0000
Subject: [PATCH 20/23] fsmonitor: force update index when fsmonitor token
 advances
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Set the `FSMONITOR_CHANGED` bit on `istate->cache_changed` when the
fsmonitor response contains a different token to ensure that the index
is written to disk.

Normally, when the fsmonitor response includes a tracked file, the
index is always updated.  Similarly, the index might be updated when
the response alters the untracked-cache (when enabled).  However, in
cases where neither of those cause the index to be considered changed,
the fsmonitor response is wasted.  And subsequent commands will
continue to make requests with the same token and if there have not
been any changes in the working directory, they will receive the same
response.

This was observed on Windows after a large checkout.  On Windows, the
kernel emits events for the files that are changed as they are
changed.  However, it might delay events for the containing
directories until the system is more idle (or someone scans the
directory (so it seems)).  The first status following a checkout would
get the list of files.  The subsequent status commands would get the
list of directories as the events trickled out.  But they would never
catch up because the token was not advanced because the index wasn't
updated.

This list of directories caused `wt_status_collect_untracked()` to
unnecessarily spend time actually scanning them during each command.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fsmonitor.c b/fsmonitor.c
index d7e18fc8cd47..8b544e31f29f 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -353,6 +353,16 @@ void refresh_fsmonitor(struct index_state *istate)
 	}
 	strbuf_release(&query_result);
 
+	/*
+	 * If the fsmonitor response and the subsequent scan of the disk
+	 * did not cause the in-memory index to be marked dirty, then force
+	 * it so that we advance the fsmonitor token in our extension, so
+	 * that future requests don't keep re-requesting the same range.
+	 */
+	if (istate->fsmonitor_last_update &&
+	    strcmp(istate->fsmonitor_last_update, last_update_token.buf))
+		istate->cache_changed |= FSMONITOR_CHANGED;
+
 	/* Now that we've updated istate, save the last_update_token */
 	FREE_AND_NULL(istate->fsmonitor_last_update);
 	istate->fsmonitor_last_update = strbuf_detach(&last_update_token, NULL);
-- 
gitgitgadget

