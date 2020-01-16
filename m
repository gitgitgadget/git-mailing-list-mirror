Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73218C33CB6
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46F1620728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 21:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oX/k3K6u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388762AbgAPVSd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:18:33 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35746 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729005AbgAPVSc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 16:18:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so5365728wmb.0
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 13:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2PIaZn0KayQC43WVBeYZByX/rsKSPSl2P8+lreCea30=;
        b=oX/k3K6ubfvZqRvIoPUv8MhzvKfpYvmWHsvB8eiFfUdXCRfsUvmcgRDzA5YFCEbO9U
         EBex9LaJEVyUViPRJU4QX6d9sLKnEdtgiDLuLwYo33d2bu00QXSBmZ9VOKay3HbGkjyu
         4FamOfXeZrVRzZ5XGFP7hLK6PUSrMASNBxjtpKzY2Pm5Sj8Qqe6GyjMMWHRqC6r5tpfR
         xeJq3Tmi3/eXWHxAeeZO89zJ82hFcQXd6wvhEq6LL04rlgxesF1qa1xExTtF5+CP4YRo
         O0Ozy+CWhbLY3QH4Ap7FhK8t//dm+hx0z1ylU22DBrFIHsklv/c+p67pDVEKme1pNRZh
         xmGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2PIaZn0KayQC43WVBeYZByX/rsKSPSl2P8+lreCea30=;
        b=nF+v7mmcrDM/MVe/Hv78baPZM5ueRo+/9CVxni5jgiBIO33au/gNGGrEgsnGXpityP
         NAIFAfFLfiiJJYBTJ0OEA9j5A4KdNofPzIGK7B5/DmJ/fksHUGaUigG0RHCAyGwzvHBy
         9iperJGXKUD7BaIL71JMARG6n2SABBzAdOoZ8pRE9JAK+bUwctKPbpSSJZM2a1EP0gHJ
         R36YSYPVcCf0rdBRWWHWAczBcwJ4DAN+E66xuLvkKfFzVNrr0GMpLqNidSddNatVFrZO
         zBhnJ7UW0PN3/TF4sVfUGQ7t8AnyWfKh0LhY5eQvRTklVLEBbThwziAEUM8wCUgG4Ck8
         lefw==
X-Gm-Message-State: APjAAAWGC9Z+lUJrBsR85wqm0ericvolnPh1c7y4Ht744EGuYtDGvb+r
        949SY8UOynO7N1WHqmaRwlNzNOtR
X-Google-Smtp-Source: APXvYqz2x936z0bmGKRFfeNuqeECJ1mk6KNTVHZXpV6RoZ8BzZVGbx3iaN8kvxHoV2eCtXuDxpb62g==
X-Received: by 2002:a1c:ded6:: with SMTP id v205mr1035457wmg.86.1579209510204;
        Thu, 16 Jan 2020 13:18:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u14sm30325342wrm.51.2020.01.16.13.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 13:18:29 -0800 (PST)
Message-Id: <e7d9ea8992461a16fb53efb1ab9a726530c1d315.1579209506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.git.1579209506.gitgitgadget@gmail.com>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 21:18:26 +0000
Subject: [PATCH 3/3] rebase -i: also avoid SHA-1 collisions with
 missingCommitsCheck
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Alban Gruin <alban.gruin@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `rebase.missingCommitsCheck` is in effect, we use the backup of the
todo list that was copied just before the user was allowed to edit it.

That backup is, of course, just as susceptible to the hash collision as
the todo list itself: a reworded commit could make a previously
unambiguous short commit ID ambiguous all of a sudden.

So let's not just copy the todo list, but let's instead write out the
backup with expanded commit IDs.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 rebase-interactive.c          | 8 +++++---
 t/t3404-rebase-interactive.sh | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/rebase-interactive.c b/rebase-interactive.c
index aa18ae82b7..1259adc8ea 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -104,9 +104,11 @@ int edit_todo_list(struct repository *r, struct todo_list *todo_list,
 				    -1, flags | TODO_LIST_SHORTEN_IDS | TODO_LIST_APPEND_TODO_HELP))
 		return error_errno(_("could not write '%s'"), todo_file);
 
-	if (initial && copy_file(rebase_path_todo_backup(), todo_file, 0666))
-		return error(_("could not copy '%s' to '%s'."), todo_file,
-			     rebase_path_todo_backup());
+	if (initial &&
+	    todo_list_write_to_file(r, todo_list, rebase_path_todo_backup(),
+				    shortrevisions, shortonto, -1,
+				    (flags | TODO_LIST_APPEND_TODO_HELP) & ~TODO_LIST_SHORTEN_IDS) < 0)
+		return error(_("could not write '%s'."), rebase_path_todo_backup());
 
 	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
 		return -2;
diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 1cc9f36bc7..b90ea0fe44 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1277,6 +1277,8 @@ test_expect_success SHA1 'short SHA-1 collide' '
 			.git/rebase-merge/git-rebase-todo.tmp &&
 		grep "^pick [0-9a-f]\{40\}" \
 			.git/rebase-merge/git-rebase-todo &&
+		grep "^pick [0-9a-f]\{40\}" \
+			.git/rebase-merge/git-rebase-todo.backup &&
 		git rebase --continue
 	) &&
 	collide2="$(git rev-parse HEAD~1 | cut -c 1-4)" &&
-- 
gitgitgadget
