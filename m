Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6D09C33CB3
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B425921D56
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 23:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTPJSm4P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730291AbgAQXiK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 18:38:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43782 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729798AbgAQXiI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 18:38:08 -0500
Received: by mail-wr1-f67.google.com with SMTP id d16so24264487wre.10
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 15:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2PIaZn0KayQC43WVBeYZByX/rsKSPSl2P8+lreCea30=;
        b=ZTPJSm4PQ/hhNZbJFmwsPib3gTRzO6HrGA70B5Ij4eDKvGewstvAvpQZbZBc280f6q
         sLOOkq4+PzTdp7C+bfJKckZvVIXJzfzEapO3oGIJUxKiBWEEmU/oLn/i+m3D56jHE/ie
         F89bnDXbc10zy0Q5WjdpTcwyrCMbEJI/RR3ovtC0JrveuvZucWpJT5SZ5/Rm5tYhUUdf
         Fcl0XmEolJQifa/eQ1z1LtgqR8F47hLE34ZBZFGBrh59KtE92mkuEIswJLywfdJpzOrQ
         cM4eDulU1+P4BF4Wda75LxLkmjVW8S+vZuzh6bbv7uyI/hukSL+yWQbxFJQnBHMQvRDf
         vw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=2PIaZn0KayQC43WVBeYZByX/rsKSPSl2P8+lreCea30=;
        b=c9V04E1aC89tWz7Z83YPGDYrN6Bo7ftNXXwvTbJz/0lwoZ3yabCxv7Vwg91Eh4+r/4
         cQ01DgsmM1grZOolmmVVKPGsgdRrLp9jzNE4asTWGKK9xzg1fn2q4gYk0fh2h1im/usk
         9VCbZhBpj8xiNDxlOMDjP6Cprs9o6AHhCH9M5/lw4lC7Ep7rioyQSQY9f5QGBr73kUIw
         kYJxX6BwZpMo3xPZ6Kyl6IUmhpFjTbfixS62v7yS+ElGz4pBJzrHKM5PqKbUqj5vHUk8
         vIG1AqttCdA+PzyF+5V42maSbxvtn5SCWJB37GyBK56LUf3k/kte5NTg05tFslDzyxol
         D4tg==
X-Gm-Message-State: APjAAAXzNi5qFatlVjfKHRe3cfhZFK0H2q7wh99HY9UWUsDH1MGRNlIb
        QUcNbwSHwEnfRAfLjyhcsCdNActH
X-Google-Smtp-Source: APXvYqwSNe2PYBIW1KBYvTbqFP87ABp33GZdyp29HQ8CTibChCjcdiKGYr0y9wM49bRQSazwTernCw==
X-Received: by 2002:adf:eb46:: with SMTP id u6mr5592299wrn.239.1579304287119;
        Fri, 17 Jan 2020 15:38:07 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k8sm36000206wrl.3.2020.01.17.15.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 15:38:06 -0800 (PST)
Message-Id: <486e9413a6b19d2695878fc19ffc49adabe3b00f.1579304283.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
References: <pull.529.git.1579209506.gitgitgadget@gmail.com>
        <pull.529.v2.git.1579304283.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 17 Jan 2020 23:38:03 +0000
Subject: [PATCH v2 3/3] rebase -i: also avoid SHA-1 collisions with
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
