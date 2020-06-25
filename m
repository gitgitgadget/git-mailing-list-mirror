Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C81C433DF
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6213D206BE
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 12:49:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5I3Q/xd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404840AbgFYMtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:49:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404830AbgFYMtO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 08:49:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0917BC061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:14 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id o2so5806235wmh.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 05:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YwmDkC6KWOkGoFDqvDEsZ4rzjef99/I/e3iXH4kN0Uc=;
        b=p5I3Q/xdyU/dXrn2Et9VMwPUYAGPYaQlAmUZDLUIGCYzRgbBCzhRBUB7P0JR1jtgNW
         omz5le87EbRYMYcVIWv7XR38qQMcVvqjJN6CxlGsbl4k8acA1A56uoCpMHnsayGFjmrw
         tAOjmjZ1noC0VhbN+xiC+Z2QKTpyukFhWGDgqYlIPQ4oHTwX6L2a2GZ339viTeee525v
         fOD/dN3chP/DIxJxpzog7iM/KDzJVDlTVNhQYspgvFvoexKr3w/janCC/1Z4W9XJmnM2
         jJUh6xFYaZzmgdRumSsX8E0SGPSv5v6iFLnpixZLwgcIGjKMyTgxyb2iqFARqUtXSt0G
         erHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YwmDkC6KWOkGoFDqvDEsZ4rzjef99/I/e3iXH4kN0Uc=;
        b=PdHujyuZdyaMwxooTmbIvOETJfpjTndjFqCNHgTDozZlBOC/WjxJFSmbdSwzfDyXB0
         WqpG8NaDYkkH3afJCK/QjDtNyCRKLfV7bqwsOo123atEYoUrj5GPRCezZl7KhZzPn70U
         fLnSo505+LzhSJqUDS53ZcH0gKJ4wYonExzDHgn/4hLzVWBciUkW5VJTC1o+pNJ16g4g
         eXhQJVtZiSdaWfHRgvZMhH3wQMmCKmomzPw14aihN9mWFru7pdQufNesXfkefU+t/46R
         fGhTBl2WdduDvHWdnzmkSflwtrYGYOyd2BFwomilmFqzuOAxdbWy9uo3Z+4vBe1INkJM
         lxZA==
X-Gm-Message-State: AOAM5335Sz3e+hQw2U2bx9HlwRWwbeOESokT6yFISQ9FjTdxMrNwFLzm
        JF2YfT8WwwleKp5XvMfZRT74Nso+
X-Google-Smtp-Source: ABdhPJxl+z2rlIerZqRlf4WxyQq45Ylss0OoVTYjebDJtVbYAfUY+dSSC6cAbLCKF8wf3ct7kJK1fg==
X-Received: by 2002:a7b:c1cc:: with SMTP id a12mr3329874wmj.112.1593089352595;
        Thu, 25 Jun 2020 05:49:12 -0700 (PDT)
Received: from ylate.lan (atoulouse-654-1-308-216.w86-199.abo.wanadoo.fr. [86.199.91.216])
        by smtp.googlemail.com with ESMTPSA id y16sm31563409wro.71.2020.06.25.05.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 05:49:12 -0700 (PDT)
From:   Alban Gruin <alban.gruin@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: [RFC PATCH v1 15/17] merge: use the "octopus" strategy without forking
Date:   Thu, 25 Jun 2020 14:19:51 +0200
Message-Id: <20200625121953.16991-16-alban.gruin@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625121953.16991-1-alban.gruin@gmail.com>
References: <20200625121953.16991-1-alban.gruin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This teaches `git merge' to invoke the "octopus" strategy with a
function call instead of forking.

Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
---
 builtin/merge.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index d50b4ad6ad..53f64ddb87 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -748,6 +748,9 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 	} else if (!strcmp(strategy, "resolve"))
 		return merge_strategies_resolve(the_repository, common,
 						head_arg, remoteheads);
+	else if (!strcmp(strategy, "octopus"))
+		return merge_strategies_octopus(the_repository, common,
+						head_arg, remoteheads);
 	else {
 		return try_merge_command(the_repository,
 					 strategy, xopts_nr, xopts,
-- 
2.27.0.139.gc9c318d6bf

