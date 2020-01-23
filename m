Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA9CC2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECAA24655
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 12:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eB0AdoBe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgAWM22 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 07:28:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34611 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgAWM2Z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 07:28:25 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so1766326wme.1
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 04:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2PIaZn0KayQC43WVBeYZByX/rsKSPSl2P8+lreCea30=;
        b=eB0AdoBeqtLbYDR089NLv5NgQjo4KbbJtmZYAPSET92Xy7kLKtflSB8I0r3T+EVDH0
         7syvSaTK3klgmOJWfTuuo1z3B91hKlps+ttY0CG3iaLfdCNVAJndzhRLh7RMO4bMcdYk
         UlqzKcgyc5rSzVMQmLHsNqKyIuOqtmJeJh6nVFOrK8y86bRrtqvaXzTpvzlo13wURAUC
         PyGujZxsuaB+hXl8tJKeWO/ACIVQMpSwYq6wZ2jjrf7nIlGrGl2fVeTapZ9sRmyTj5Jo
         AHG7Q+tWFyoUTMC+U+fkP+tlEdGSHG+rAn/QdisfUFwzhoa1AJVEWDu46HRXjiH01T77
         Z6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2PIaZn0KayQC43WVBeYZByX/rsKSPSl2P8+lreCea30=;
        b=DgoZHpz0fX039jrAPNNfwWKIawQSQRSrqLZims3Z246qz7oOIktyDrOb+c0XkIPuh6
         fxn67bJPOg6wUDs1tWf5V7c2sbTQwzm+XLXk1y5/UPXQtL0lWtKQZZLYDlY1DrB9o1aZ
         BAOcjlmZeI6DxC483jCdzRXrLReQKmf9TSQv1xP03Q7JUfENbzIsWF+8KFz3LpsmhKpq
         YZzIbVKXZy7at1DOkXGQwiw7mZgsK7e3kiK5L/jZl8KqxS44GJuP9LErbKA1fGTmx1wj
         CTrhtazH4mKJum+L4KGXAjMXQRZ5bGcgqcGmd3DiwGgsBXu1M0O8IFlO78F24ogGb6/e
         2w6g==
X-Gm-Message-State: APjAAAWS0GTtYk8RJIm3mpgbMbsDytQtW6kp8ZnMosYYZuxx7LC8QtSU
        SaltyyjKJF19v+vAOFyunAofE28j
X-Google-Smtp-Source: APXvYqzkBomktF/uAC2PmRax3283/gyeWqoK2QDNpbqcHP0linc65mU3tezm8Uw2ad9l645t5/3CCQ==
X-Received: by 2002:a7b:cd87:: with SMTP id y7mr4050997wmj.61.1579782503099;
        Thu, 23 Jan 2020 04:28:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm2728804wrx.71.2020.01.23.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 04:28:22 -0800 (PST)
Message-Id: <b7b063408f61abbbdf88b2dbf22e6274e75a31f8.1579782500.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.v3.git.1579782499.gitgitgadget@gmail.com>
References: <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
        <pull.529.v3.git.1579782499.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 23 Jan 2020 12:28:19 +0000
Subject: [PATCH v3 3/3] rebase -i: also avoid SHA-1 collisions with
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
