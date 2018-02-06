Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB7AA1F404
	for <e@80x24.org>; Tue,  6 Feb 2018 00:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752362AbeBFA3K (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 19:29:10 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34406 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752314AbeBFA3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 19:29:05 -0500
Received: by mail-pg0-f65.google.com with SMTP id s73so193397pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 16:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0AWqKSqt7+fGFwea45pAnLh01Y+VmOVMKBiunOn2VFk=;
        b=Flsg8RPW3gf0I+GD6jjGtfACYp5CTgITzDkV/lZCUaQENpgAl4oeRvtrEJhmXXCZd7
         QcE/NTMjJlTbeWSZTwi4n3ghVL2q37UMHva+dJm9Z0iX720gNfZ5hyMbMWMBfv4yWQ46
         o+K2jH/tMTLgXhOSu1b/xgqBxgJaWzB41JXfoqVpKukSaf7uGrAUXM7jQMZthW8Ndvxn
         /9GSlcYkju/8ljSHrqkZ4rtg7E+tm6igzsm3pF+U8QUxYSGkxPMZ+py0CVbldosdAh5I
         VSgfRLBNtlFQIt+mbGVKtuvJ6g+1PQoUoy8WQ4057fNXG175FlLfqAKYnZWRSEixdb9j
         mKTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0AWqKSqt7+fGFwea45pAnLh01Y+VmOVMKBiunOn2VFk=;
        b=HSbM2ziWwPi4IkeffN+KHwf1ZgI2lHqYc/+SozeWVZngImBQJ3gAtY4bVB0cRFCe5p
         V9Aky8e51pO69QqKAz28AorAzPy+/9d22I6DzYJOsDP/3HNtRl/Sk9vhz3frSMbwoBAo
         n5DFGDtp/K1WOel6BMZFnN99Yp5LGiKh6iw3UAJrIQETzunIJVqw1/6hT/Sfn89cReIN
         sV4Ls2xS7Tdjnj0jc0t0hZlx873gCdaWJxKX9CxePKiwMvpEfejbI3Cen6L8ZrGOWOeQ
         aUkR3WetVwGVcpyNvo6CzGvdx/yu4x+vyDZ9IbGenqfb48fSmY0RpeqCC0eaudZoL44Q
         a3OA==
X-Gm-Message-State: APf1xPBTGmDKj6ZuFi0euIcrNpuJUUm+/t+8xHHv8DwmAIgbsM+nTVid
        iTUkZszq0TbrLcmRppgcOuC0d2tGaOo=
X-Google-Smtp-Source: AH8x226dVijqRxEvpC7wWunqMH+skfvL8eeVKjdLhd47qKuN431ENAHtS9nCRvyL3VsM9A1t5rYJ5g==
X-Received: by 10.98.204.132 with SMTP id j4mr544365pfk.161.1517876944916;
        Mon, 05 Feb 2018 16:29:04 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id 203sm15325061pfa.110.2018.02.05.16.29.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 16:29:04 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 170/194] commit: allow get_merge_bases_many_0 to handle arbitrary repositories
Date:   Mon,  5 Feb 2018 16:17:25 -0800
Message-Id: <20180206001749.218943-72-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
In-Reply-To: <20180206001749.218943-1-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
 <20180206001749.218943-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 commit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/commit.c b/commit.c
index a8f964c6f9..db03550d70 100644
--- a/commit.c
+++ b/commit.c
@@ -969,8 +969,8 @@ static int remove_redundant(struct repository *r, struct commit **array, int cnt
 	return filled;
 }
 
-#define get_merge_bases_many_0(r, o, n, t, c) get_merge_bases_many_0_##r(o, n, t, c)
-static struct commit_list *get_merge_bases_many_0_the_repository(struct commit *one,
+static struct commit_list *get_merge_bases_many_0(struct repository *r,
+						  struct commit *one,
 						  int n,
 						  struct commit **twos,
 						  int cleanup)
@@ -980,7 +980,7 @@ static struct commit_list *get_merge_bases_many_0_the_repository(struct commit *
 	struct commit_list *result;
 	int cnt, i;
 
-	result = merge_bases_many(the_repository, one, n, twos);
+	result = merge_bases_many(r, one, n, twos);
 	for (i = 0; i < n; i++) {
 		if (one == twos[i])
 			return result;
@@ -1003,7 +1003,7 @@ static struct commit_list *get_merge_bases_many_0_the_repository(struct commit *
 	clear_commit_marks(one, all_flags);
 	clear_commit_marks_many(n, twos, all_flags);
 
-	cnt = remove_redundant(the_repository, rslt, cnt);
+	cnt = remove_redundant(r, rslt, cnt);
 	result = NULL;
 	for (i = 0; i < cnt; i++)
 		commit_list_insert_by_date(rslt[i], &result);
-- 
2.15.1.433.g936d1b9894.dirty

