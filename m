Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.3 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B541F87F
	for <e@80x24.org>; Wed, 14 Nov 2018 00:14:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731161AbeKNKOm (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Nov 2018 05:14:42 -0500
Received: from mail-ua1-f73.google.com ([209.85.222.73]:49102 "EHLO
        mail-ua1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeKNKOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Nov 2018 05:14:42 -0500
Received: by mail-ua1-f73.google.com with SMTP id v10so3579428uaj.15
        for <git@vger.kernel.org>; Tue, 13 Nov 2018 16:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gP+CBAlQmPNn/yqMaToN/OK84ai7EoqZvg7PiVDbZCg=;
        b=Td28SZtw7va5hZYOtxYr4t848EOjTVprwVuwz5OiFMk0Vr/vDmhf8MIaZ/aWWHHX88
         PwqqpKlyIagbZzJg00lE/bb69oD7BA6v3RX7wjxUrj4svHwKBQEdz/Qxqxbmmx8bhH1I
         GEsqBPB6XYb4SqbinGo/ooEeixzrXmCzXaQZJqkPJVzusfZP09PWsssRRzyXYZBFcw6u
         veogSmoP6onRFveNTCl1LPDkGR7QVd9IUZTDC0mnPohFTGQqSBREACMdJzrI6x4vx0rV
         fAp0DWUHZT1yPRZ5qZJV/Odl5IWQOSwA3lGvgrKIvDr4fu/HmSP4Yu1DeNeJ3FV3/xlV
         1FJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gP+CBAlQmPNn/yqMaToN/OK84ai7EoqZvg7PiVDbZCg=;
        b=iMZrtYrY2uzY/+dJdxiNixOGQ2jVNRqD4Wj7S+UFfOYgaKJmGJHbQtlgSK1WhMU3Zl
         HAMe7XWUeR1zqRvcikKz/tT3OOx6OlQSBk+JpDbJis23oYEX8agDKPfFW1T6PYFlpXgn
         tWcRotADQuIX2MXy7glRaPuQdsgUCR9e7g3xsWFDaOlbunmi/rjpZGSx+KFqLDq6jobi
         8s89EWTKxuA+e1i3NARRSAbWgRR891k+h5n+/nAEUcPKO+XbIq46mIgPn8e+jEHBMvGs
         ciGdvK/YFAomg1pPNfItDEjM1oyXghwR+fPT/kTos+v9zxhvJXmuq2pHzOb6CIXXpjIL
         0FeA==
X-Gm-Message-State: AGRZ1gK0NeEcchSq89zdcoLSEFY6qe+cCXo/2FNuifwmWJwdpXpytaf3
        LhAqscn6WP3tcnah1lOMfXeTaqVZkwIW
X-Google-Smtp-Source: AJdET5czgAH+hJ3N/Cee2Y4HxQa6W64LF+2EChyNml+fJUX8MBb511qvswHu+3iiga25CctRRUG5WOc0vs+i
X-Received: by 2002:ab0:47c8:: with SMTP id w8mr3337822uac.24.1542154438903;
 Tue, 13 Nov 2018 16:13:58 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:12:54 -0800
In-Reply-To: <20181114001306.138053-1-sbeller@google.com>
Message-Id: <20181114001306.138053-12-sbeller@google.com>
Mime-Version: 1.0
References: <20181114001306.138053-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.1.1215.g8438c0b245-goog
Subject: [PATCH 11/23] commit-reach.c: allow get_merge_bases_many_0 to handle
 any repo
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit-reach.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index 81015830cb..b3b1f62aba 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -216,7 +216,8 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	return filled;
 }
 
-static struct commit_list *get_merge_bases_many_0(struct commit *one,
+static struct commit_list *get_merge_bases_many_0(struct repository *r,
+						  struct commit *one,
 						  int n,
 						  struct commit **twos,
 						  int cleanup)
@@ -226,7 +227,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(the_repository, one, n, twos);
+	result = merge_bases_many(r, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
@@ -249,7 +250,7 @@ static struct commit_list *get_merge_bases_many_0(struct commit *one,
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(the_repository, rslt, cnt);
+	cnt = remove_redundant(r, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
@@ -261,19 +262,19 @@ struct commit_list *get_merge_bases_many(struct commit *one,
 					 int n,
 					 struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 1);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 1);
 }
 
 struct commit_list *get_merge_bases_many_dirty(struct commit *one,
 					       int n,
 					       struct commit **twos)
 {
-	return get_merge_bases_many_0(one, n, twos, 0);
+	return get_merge_bases_many_0(the_repository, one, n, twos, 0);
 }
 
 struct commit_list *get_merge_bases(struct commit *one, struct commit *two)
 {
-	return get_merge_bases_many_0(one, 1, &two, 1);
+	return get_merge_bases_many_0(the_repository, one, 1, &two, 1);
 }
 
 /*
-- 
2.19.1.1215.g8438c0b245-goog

