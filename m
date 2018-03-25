Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E182A1F404
	for <e@80x24.org>; Sun, 25 Mar 2018 13:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753334AbeCYNqg (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Mar 2018 09:46:36 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33040 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752749AbeCYNqd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Mar 2018 09:46:33 -0400
Received: by mail-wm0-f68.google.com with SMTP id o23so1470365wmf.0
        for <git@vger.kernel.org>; Sun, 25 Mar 2018 06:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=bR8lEekXAEHxd0MWHjvN8+zwZvlkL4Ep04301IqDONg=;
        b=phPiwF0g6jJQvpWRDG+8WBCcQcn+vmYsLRAxRHwWwCMLVSYa7BTNNRaoy5No4gaFeR
         L7Dq5BXCYgExaCzziNpOHZUzE7Eu/l69cnsVXjup8uHzFFip/ijvj+PWEZGs5HdYK+zA
         tJq5LqwGLYvlU6wSLCY3R0iTo85/3WjoC5t0JWNY/gIt4kcYqwA/GKKqmYQJZYfh0aaa
         Snr1JKx7zXHVBbuvmCV623bGO1O70mVEmFNDGB5GDg9f10SI9nlBMpCYbMqj3mCFhPlx
         LSVjpJMkCwjHkEQ3Hzlm6BRqYjQSEZlzgFBON7dyhkei0yFyLruwtVq+9bdu1qx7vsYh
         M0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=bR8lEekXAEHxd0MWHjvN8+zwZvlkL4Ep04301IqDONg=;
        b=lfC9wlYtWhJ1y0jsUvkj6nwul1uv1rTfFkSwDmx2TurmtoI8p1iFZ8RlkePHMgSVUH
         9oIFQa3+k9ACADM0qJ1P+IkPhDnpBSUsiPxtpuBLimqnTTiP8SLC/rv+o5i48OeVY7Z3
         UaexLf2xnqrygbQHNaWvDc3yidThBR6m1w1UujWbvCAPSZwHAOY5JhI3xl0JcArCwqPT
         CJuoH7ix3AdQrEV8Ycy3zHCFg19DqZnJFrN/1GMK2i/IerV4G8Cu+SO+cAzrRpBq9auz
         czPkHC96ieRbvvopsswelCxUosOVxGjvGQdbMeqo8DvGvIBLeRDLf8XaeF7Dd9pZFn5S
         iu1g==
X-Gm-Message-State: AElRT7FcHCCSq+XWyHQq1/4/EpfRkaBkNS68o3IVZC/H6oOC5otZLW0J
        Fl3h+DFEbHjJxwXkSLvQqxaeX3ZE
X-Google-Smtp-Source: AG47ELvzDey39nb7upQBvUqCnrVUh87pJ2SWwhVIGw+ZDtAWUslN5vWgneeGiNdj3WaL7/3hX+svHw==
X-Received: by 10.28.131.134 with SMTP id f128mr12347130wmd.55.1521985591609;
        Sun, 25 Mar 2018 06:46:31 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id c14sm3972133wmi.28.2018.03.25.06.46.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 25 Mar 2018 06:46:30 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v5 2/6] worktree: be clearer when "add" dwim-ery kicks in
Date:   Sun, 25 Mar 2018 14:49:43 +0100
Message-Id: <20180325134947.25828-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.16.1.77.g8685934aa2
In-Reply-To: <20180325134947.25828-1-t.gummerer@gmail.com>
References: <20180317222219.4940-1-t.gummerer@gmail.com>
 <20180325134947.25828-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently there is no indication in the "git worktree add" output that
a new branch was created.  This would be especially useful information
in the case where the dwim of "git worktree add <path>" kicks in, as the
user didn't explicitly ask for a new branch, but we create one from
them.

Print some additional output showing that a branch was created and the
branch name to help the user.

This will also be useful in the next commit, which introduces a new kind
of dwim-ery of checking out the branch if it exists instead of refusing
to create a new worktree in that case, and where it's nice to tell the
user which kind of dwim-ery kicked in.

Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 builtin/worktree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 535734cc7f..a082230b6c 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -318,6 +318,9 @@ static int add_worktree(const char *path, const char *refname,
 	if (ret)
 		goto done;
 
+	if (opts->new_branch)
+		fprintf_ln(stderr, _("creating branch '%s'"), opts->new_branch);
+
 	fprintf(stderr, _("new worktree HEAD is now at %s"),
 		find_unique_abbrev(commit->object.oid.hash, DEFAULT_ABBREV));
 
-- 
2.16.1.77.g8685934aa2

