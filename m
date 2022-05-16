Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E6FC433F5
	for <git@archiver.kernel.org>; Mon, 16 May 2022 08:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbiEPImA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 May 2022 04:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241894AbiEPIls (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 May 2022 04:41:48 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6CEBE08
        for <git@vger.kernel.org>; Mon, 16 May 2022 01:41:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso10462787wma.0
        for <git@vger.kernel.org>; Mon, 16 May 2022 01:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wCQQCcvP0n3ykZSOIi4JOHNiYGTGwQqdr1xKPrKbvHU=;
        b=Os3fpjo0BMqXPBnwSF6Y593q02dJtwfSgSUgOZAYHtFhfonPVV448EJDNSYH/p0G00
         QNbp2bOy7WsZfe+07Q2bYWSqsJsZHEAr9J5XLEaTMdUHIN5COyhB3KRqvGDjoaTcmw6C
         tt2EXljPY9Yof21ymm9mAUKq3LekXDDRz9/A4yZr74+p/2ZwQNCGp6rQElzC2qZGZ8o/
         zZRfrwauvczEyBqxR9fwwkk9X79TxMJVcodO5R9mKw8SAWmxMNxF1RbFuRg0fTGz1OL6
         PQ9mdeP5w1Bp3OJbUH+xbIZnYgrFzam5QpYhr7c41qOsbFzuxJck7lUV2KEivBLZTfsB
         DLeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wCQQCcvP0n3ykZSOIi4JOHNiYGTGwQqdr1xKPrKbvHU=;
        b=tGddKmdOSmcKPmwN3XYJ1fegU9vrf8Oj012LqCrI8N98THIM+UqPzVnBDr8dLFrFzs
         SLlPCLxlqRmMBIbz66hwXbaa7BCObOugNP4KGKEO1TwQoCPjVvdlMZ9JFBEGXMcpm7PD
         ExnTLxbpSLnqF2+dKcFNSH5M+Iy5EEKRA8XKrDZ3Ry18Er9aGo52h0ZIvfUntL3g9/qH
         T/gY30eHvVY0PhdxMqtBJ0NOhzoHwktZbKlQp29rf9uGi7c1rev8CpBY10+E2x6rcidQ
         IoHwYFntgCkcZzffp+MzKl1OQ3j19bPXTAG0D39kXy9+zIKRd/MkusbX4n8YwGxyYGRV
         dzGA==
X-Gm-Message-State: AOAM531qQu2+gDMQv7qOo1qKrdh0APloaZx/RCnR6gtnPnPSbitjN9Es
        7Oj03r5QkUtv0uBWQNPFsHupYLH9rpw=
X-Google-Smtp-Source: ABdhPJy2fd6FEgEpfZ6IddDpPc7Ekmhn9GDuXYymiWDtIIH2t4Ea2io7w+40l9CB9Wcm3rtawfE5+g==
X-Received: by 2002:a05:600c:c8:b0:395:a97c:c458 with SMTP id u8-20020a05600c00c800b00395a97cc458mr15559566wmm.119.1652690503262;
        Mon, 16 May 2022 01:41:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u4-20020a7bc044000000b003942a244ee2sm9378017wmc.39.2022.05.16.01.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 01:41:42 -0700 (PDT)
Message-Id: <pull.1266.v2.git.git.1652690501963.gitgitgadget@gmail.com>
In-Reply-To: <pull.1266.git.git.1652690275625.gitgitgadget@gmail.com>
References: <pull.1266.git.git.1652690275625.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 16 May 2022 08:41:41 +0000
Subject: [PATCH v2] fetch: limit shared symref check only for local branches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

This check was introduced in 8ee5d73137f (Fix fetch/pull when run without
--update-head-ok, 2008-10-13) in order to protect against replacing the ref
of the active branch by mistake, for example by running git fetch origin
master:master.

It was later extended in 8bc1f39f411 (fetch: protect branches checked out
in all worktrees, 2021-12-01) to scan all worktrees.

This operation is very expensive (takes about 30s in my repository) when
there are many tags or branches, and it is executed on every fetch, even if
no local heads are updated at all.

Limit it to protect only refs/heads/* to improve fetch performance.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    fetch: limit shared symref check only for local branches

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1266%2Forgads%2Ffetch-perf-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1266/orgads/fetch-perf-v2
Pull-Request: https://github.com/git/git/pull/1266

Range-diff vs v1:

 1:  5e86dc86d3d ! 1:  72bea90b26f fetch: limit shared symref check only for local branches
     @@ builtin/fetch.c: static void check_not_current_branch(struct ref *ref_map,
       	const struct worktree *wt;
       	for (; ref_map; ref_map = ref_map->next)
       		if (ref_map->peer_ref &&
     -+			starts_with(ref_map->peer_ref->name, "refs/heads/") &&
     ++		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
       		    (wt = find_shared_symref(worktrees, "HEAD",
       					     ref_map->peer_ref->name)) &&
       		    !wt->is_bare)


 builtin/fetch.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e3791f09ed5..eeee5ac8f15 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1440,6 +1440,7 @@ static void check_not_current_branch(struct ref *ref_map,
 	const struct worktree *wt;
 	for (; ref_map; ref_map = ref_map->next)
 		if (ref_map->peer_ref &&
+		    starts_with(ref_map->peer_ref->name, "refs/heads/") &&
 		    (wt = find_shared_symref(worktrees, "HEAD",
 					     ref_map->peer_ref->name)) &&
 		    !wt->is_bare)

base-commit: 277cf0bc36094f6dc4297d8c9cef79df045b735d
-- 
gitgitgadget
