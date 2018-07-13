Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AC901F597
	for <e@80x24.org>; Mon, 16 Jul 2018 13:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbeGPN14 (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 09:27:56 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35977 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729854AbeGPN1z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 09:27:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id m19-v6so7474894pgv.3
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 06:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AdBtnREL8q8KusRMnxzPkr1jmNAcRFt286LLyMBu/OE=;
        b=Gi7ek/TST9yAeLBg5Z/vAW85AtE0RLHZII7W5ovWb2uMclDKvicbo9m6zriqxRUIFs
         BQZ09A8On6Ulth3qmlmA13BM4T+J/IGrixGs3S/7IKUU/bBp7726u0I94fvLemv4E+zO
         Z74na6A9AB3ePz/4oC0ddESRsiJiwI3pjwwT1+EFzhxhkkpgZkX7J7HH2aPKfjg9wPKW
         yL8wQ6tTkGndYnlR3sZ1z6fOC7p40Pi8EDVWAXYJDifJw7YaOBTIY0ADm8lvvrcY/q6y
         C/fSUVBkl7lNxoPHnRR5IFtm4xDIOf2+OllZYYUIvdmhaLKa97ufK0FIsun+4SUibwzu
         9l9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AdBtnREL8q8KusRMnxzPkr1jmNAcRFt286LLyMBu/OE=;
        b=pzY204Ny3oUs0CjX/S0/CQccTRDUdYfAo+9x782xmIdchIViEr7py+3F0A9s8VLNRW
         oO0sdsgUN5vzHTNy2DX1QI9odGwfAZGNwb/lX43w2B61ebpc5b7JLQBcRMu2VgG4KJ79
         kIdtGpRqUL9e9JbWMaxjtf2tKfzK4UbplDb1MqB4Ru7MML+U+c3b+eSVISaEdVS+vq4k
         TaIqRgXO4cb/Oe5xyUiNta6OPAwELMlp9H8Shj3tGb4sTF/hD1VfodYPQ25OConGFEqR
         uyaQ1js10Gdl5oFPBxSPccuOLULI2D8/YR3NmT7ZXg6dYyufX+NXVKz0WIeQKV0JR0nR
         exHw==
X-Gm-Message-State: AOUpUlEOL2dpVKTQN4+ugSxSZTDUisNwL6FDm6QBrNbVsMkRfETFEAfv
        1VvyZ3npUyrjyckCyYdpSOfLuw==
X-Google-Smtp-Source: AAOMgpeo2+kr7PljSyoc4zG8l6kxsE4FXUDNuz9GMqjpDjWRHgfAQhD/t2s3WoYoTisqUSHgTcAeaQ==
X-Received: by 2002:a62:ed5:: with SMTP id 82-v6mr18004231pfo.198.1531746034999;
        Mon, 16 Jul 2018 06:00:34 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.85])
        by smtp.gmail.com with ESMTPSA id j27-v6sm98279069pfe.48.2018.07.16.06.00.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jul 2018 06:00:34 -0700 (PDT)
Message-Id: <1fd45ef2b15524c18322183231608fe13a733506.1531746012.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.10.git.gitgitgadget@gmail.com>
References: <pull.10.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Jul 2018 14:37:32 -0400
Subject: [PATCH 14/16] commit-reach: replace ref_newer logic
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The ref_newer method is used by 'git push' to check if a force-push is
required. This method does not use any kind of cutoff when walking, so
in the case of a force-push will walk all reachable commits.

The is_descendant_of method already uses paint_down_to_common along with
cutoffs. By translating the ref_newer arguments into the commit and
commit_list required by is_descendant_of, we can have one fewer commit
walk and also improve our performance!

For a copy of the Linux repository, 'test-tool reach ref_newer' presents
the following improvements with the specified input. In the case that
ref_newer returns 1, there is no improvement. The improvement is in the
second case where ref_newer returns 0.

Input
-----
A:v4.9
B:v3.19

Before: 0.09 s
 After: 0.09 s

To test the negative case, add a new commit with parent v3.19,
regenerate the commit-graph, and then run with B pointing at that
commit.

Before: 0.43 s
 After: 0.09 s

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-reach.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/commit-reach.c b/commit-reach.c
index c5e89a2de..c58e50fbb 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -365,20 +365,11 @@ void reduce_heads_replace(struct commit_list **heads)
 	*heads = result;
 }
 
-static void unmark_and_free(struct commit_list *list, unsigned int mark)
-{
-	while (list) {
-		struct commit *commit = pop_commit(&list);
-		commit->object.flags &= ~mark;
-	}
-}
-
 int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 {
 	struct object *o;
 	struct commit *old_commit, *new_commit;
-	struct commit_list *list, *used;
-	int found = 0;
+	struct commit_list *old_commit_list = NULL;
 
 	/*
 	 * Both new_commit and old_commit must be commit-ish and new_commit is descendant of
@@ -399,19 +390,8 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 	if (parse_commit(new_commit) < 0)
 		return 0;
 
-	used = list = NULL;
-	commit_list_insert(new_commit, &list);
-	while (list) {
-		new_commit = pop_most_recent_commit(&list, TMP_MARK);
-		commit_list_insert(new_commit, &used);
-		if (new_commit == old_commit) {
-			found = 1;
-			break;
-		}
-	}
-	unmark_and_free(list, TMP_MARK);
-	unmark_and_free(used, TMP_MARK);
-	return found;
+	commit_list_insert(old_commit, &old_commit_list);
+	return is_descendant_of(new_commit, old_commit_list);
 }
 
 /*
-- 
gitgitgadget

