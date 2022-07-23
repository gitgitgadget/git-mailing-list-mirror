Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D41C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 01:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbiGWBxo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 21:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236696AbiGWBx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:29 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B7A681B11
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:28 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so3337693wmm.4
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RA0WtZbNa8m/DV3yDd285OCaS+dlQm7fxrD6oQ75olE=;
        b=CqHEYy6B6GUkgV6eiLDUxdEeEtKQATnhlrRcXk4npVjdm6VLsa/+KxIKDwcA+IjamQ
         mEFMjid/N6GtVbkbfcirhPlCm5b8JpRgXEJE8dZW/l4JROPpC0LUQPIaob80FYvC0kyz
         TWM0X1tW61uEBYS2YTMmBhjGGmOVDmGO/OxjpbMVGNM2iXN5AHh6xt0OEbgCKXVbEix/
         Rr+WSzJp3hQ9jwHaxdlsRlmTsjAh/QzOVTDE0Esgf2402NR3cNoUrnE7DQ36Y6mTUya+
         KpeizR60HUL4dRDPn1IxpVT0KgrDLcce3x74DczMcYnl5VUB5aNkATg88ye9LPVvWGiN
         Xdlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RA0WtZbNa8m/DV3yDd285OCaS+dlQm7fxrD6oQ75olE=;
        b=AltxxWJJbMilgYEhb+wmijwMdirj2CPci/7jM8NwzbtP7SwVaWlPziMxAp4tQRUAF+
         8+RS0QVfK8z3nDJ22cfxEH8RNH2XgS/hDmmkz2hJk7FRG6vH40OpLTLi7EDYR0P4FKZI
         PP5dRDR4NJ0q8OhRrynFOxbeTZZiIJBoj5SEjk5ZSq0TiAy/Av9hjNWiFukNcEEEtv1y
         /WhZE7Q5Ca0KMYM/T4C6+DugqCl5zcjsubiGNZA4bMU/d3txwKESFqKX6S2o9WjBmARs
         Wj0v9UUm6vSb/58YQyJ2WphHi65dQifoQ0UT7xQ09W050UugftgcJAwPDwr5LZz+U+lg
         UR7A==
X-Gm-Message-State: AJIora9ud7OOtKJ8LWslz0cVo+9KKRjzE33OgNorJM/B4ESJlp1TPSPs
        4nhp6AATa8Z/tHx2KCVW3wMn1pieros=
X-Google-Smtp-Source: AGRyM1u7IV7hfYxh4O1yYOAceGmcb7qjRB1CVgHauIXhrygLJjB+7SKGqMZWjE57ft0KA1TcsJpNOQ==
X-Received: by 2002:a05:600c:4304:b0:3a3:2e32:8a8f with SMTP id p4-20020a05600c430400b003a32e328a8fmr9534162wme.104.1658541206659;
        Fri, 22 Jul 2022 18:53:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h13-20020a5d548d000000b0021d8b1656dfsm5823836wrv.93.2022.07.22.18.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 18:53:26 -0700 (PDT)
Message-Id: <7f5c6884d685f2b007db56333ad3441e8bc22641.1658541198.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
References: <pull.1231.v4.git.1658466942.gitgitgadget@gmail.com>
        <pull.1231.v5.git.1658541198.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 23 Jul 2022 01:53:17 +0000
Subject: [PATCH v5 7/8] merge: ensure we can actually restore pre-merge state
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Merge strategies can:
  * succeed with a clean merge
  * succeed with a conflicted merge
  * fail to handle the given type of merge

If one is thinking in terms of automatic mergeability, they would use
the word "fail" instead of "succeed" for the second bullet, but I am
focusing here on ability of the merge strategy to handle the given
inputs, not on whether the given inputs are mergeable.  The third
category is about the merge strategy failing to know how to handle the
given data; examples include:

  * Passing more than 2 branches to 'recursive' or 'ort'
  * Passing 2 or fewer branches to 'octopus'
  * Trying to do more complicated merges with 'resolve' (I believe
    directory/file conflicts will cause it to bail.)
  * Octopus running into a merge conflict for any branch OTHER than
    the final one (see the "exit 2" codepath of commit 98efc8f3d8
    ("octopus: allow manual resolve on the last round.", 2006-01-13))

That final one is particularly interesting, because it shows that the
merge strategy can muck with the index and working tree, and THEN bail
and say "sorry, this strategy cannot handle this type of merge; use
something else".

Further, we do not currently expect the individual strategies to clean
up after themselves, but instead expect builtin/merge.c to do so.  For
it to be able to, it needs to save the state before trying the merge
strategy so it can have something to restore to.  Therefore, remove the
shortcut bypassing the save_state() call.

There is another bug on the restore_state() side of things, so no
testcase will be added until the next commit when we have addressed that
issue as well.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/merge.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index e0a3299e92e..3c4f415d87e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1682,12 +1682,12 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	 * tree in the index -- this means that the index must be in
 	 * sync with the head commit.  The strategies are responsible
 	 * to ensure this.
+	 *
+	 * Stash away the local changes so that we can try more than one
+	 * and/or recover from merge strategies bailing while leaving the
+	 * index and working tree polluted.
 	 */
-	if (use_strategies_nr == 1 ||
-	    /*
-	     * Stash away the local changes so that we can try more than one.
-	     */
-	    save_state(&stash))
+	if (save_state(&stash))
 		oidclr(&stash);
 
 	for (i = 0; !merge_was_ok && i < use_strategies_nr; i++) {
-- 
gitgitgadget

