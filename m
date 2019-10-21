Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91D091F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 16:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbfJUQBG (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 12:01:06 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38309 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729525AbfJUQBE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 12:01:04 -0400
Received: by mail-wr1-f54.google.com with SMTP id v9so3371510wrq.5
        for <git@vger.kernel.org>; Mon, 21 Oct 2019 09:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZAxFthZOJG72sI+beMK3PooQleyIgaFV2D0hvrbKwbg=;
        b=Cb/eDi8fH9xdqyQ2SNwtJDb5wPOUzotsQSvcWRkZfZS9mSYBf/mKoPDgDKbb0EM/I4
         r69rqh2U+B8gD07/r7BYMl73nru6ZOAtlaSxRcxv65vDYKas8M6AhhGwAHo4OJPahPxB
         iVwvY0D5k0c/vXXaAVvXv5iBkLalFFgPHKMMGerELyKGrKP9BsyjRp21l+GWKQrHCy9o
         9T/8/vBmUzQrvzd7tqgYQxG26hH+BkEDSDu8uBj0N1aRDmblivegBobpCNRbX3pn1Ngv
         vF7KGOvmne4u+MCdOed6Rea3oilv/tBRNb38q28xm+bEdhXJPO4tr05/EZXLPcj8JjEZ
         tBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZAxFthZOJG72sI+beMK3PooQleyIgaFV2D0hvrbKwbg=;
        b=j5vGsqeMSASo5VTDBP7OZEWZO1pucGDc2zZzWTGSymPjGgwlajRM678Cq6sm7sDthE
         +L/t5+C5JLnjzF4qNJNrj9G7aTbXo8yfGuQM3DipmBlB00RTIvuGKIHZHrq6tNso6M1O
         3yIMaYMZABCC9eZ/VIHqzozeo2L7dSBoEbVT7lPdRw8+pjh2DW3SaNf5s6NGVGFpHSpm
         hDDk6DfYu55Sz1nuqTlCSlccrUQYpL9cmVDL0JVmnxYMRdYiynKYcnI0EgzR4bH+GQ6Z
         aWSIWmliXQFtWy4amc2dsq2obYkBTlHyAlntxpL+5l8y/OV+uy7WpbNko0G3nmofTuY8
         mbCA==
X-Gm-Message-State: APjAAAW1DnCiFPkh/Cwtr4s8K1rNmkl9gVM4SHKw4t1JH1WbVoaajSSq
        Wt9lD4bVf5bEGi90W+fa9Ps=
X-Google-Smtp-Source: APXvYqwxHxp+u+KmGPUhdJMBVpRcVFBjifm88vtJ0Imi7ZI5J+KuAgaaxb6yfcYxSF+EoRal8EbvwA==
X-Received: by 2002:adf:9f08:: with SMTP id l8mr19597973wrf.325.1571673659953;
        Mon, 21 Oct 2019 09:00:59 -0700 (PDT)
Received: from localhost.localdomain (x4db66cac.dyn.telefonica.de. [77.182.108.172])
        by smtp.gmail.com with ESMTPSA id u26sm16293196wrd.87.2019.10.21.09.00.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Oct 2019 09:00:58 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <novalis@novalis.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/5] path.c: clarify trie_find()'s in-code comment
Date:   Mon, 21 Oct 2019 18:00:40 +0200
Message-Id: <20191021160043.701-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.24.0.rc0.472.ga6f06c86b4
In-Reply-To: <20191021160043.701-1-szeder.dev@gmail.com>
References: <20191021160043.701-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A fairly long comment describes trie_find()'s behavior and shows
examples, but it's slightly incomplete/inaccurate.  Update this
comment to specify how trie_find() handles a negative return value
from the given match function.

Furthermore, update the list of examples to include not only two but
three levels of path components.  This makes the examples slightly
more complicated, but it can illustrate the behavior in more corner
cases.

Finally, basically everything refers to the data stored for a key as
"value", with two confusing exceptions:

  - The type definition of the match function calls its corresponding
    parameter 'data'.
    Rename that parameter to 'value'.  (check_common(), the only
    function of this type already calls it 'value').

  - The table of examples above trie_find() has a "val from node"
    column, which has nothing to do with the value stored in the trie:
    it's a "prefix of the key for which the trie contains a value"
    that led to that node.
    Rename that column header to "prefix to node".

Note that neither the original nor the updated description and
examples correspond 100% to the current implementation, because the
implementation is a bit buggy, but the comment describes the desired
behavior.  The bug will be fixed in the last patch of this series.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 path.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/path.c b/path.c
index e3da1f3c4e..4ac9a101f5 100644
--- a/path.c
+++ b/path.c
@@ -236,30 +236,41 @@ static void *add_to_trie(struct trie *root, const char *key, void *value)
 	return old;
 }
 
-typedef int (*match_fn)(const char *unmatched, void *data, void *baton);
+typedef int (*match_fn)(const char *unmatched, void *value, void *baton);
 
 /*
  * Search a trie for some key.  Find the longest /-or-\0-terminated
- * prefix of the key for which the trie contains a value.  Call fn
- * with the unmatched portion of the key and the found value, and
- * return its return value.  If there is no such prefix, return -1.
+ * prefix of the key for which the trie contains a value.  If there is
+ * no such prefix, return -1.  Otherwise call fn with the unmatched
+ * portion of the key and the found value.  If fn returns 0 or
+ * positive, then return its return value.  If fn returns negative,
+ * then call fn with the next-longest /-terminated prefix of the key
+ * (i.e. a parent directory) for which the trie contains a value, and
+ * handle its return value the same way.  If there is no shorter
+ * /-terminated prefix with a value left, then return the negative
+ * return value of the most recent fn invocation.
  *
  * The key is partially normalized: consecutive slashes are skipped.
  *
- * For example, consider the trie containing only [refs,
- * refs/worktree] (both with values).
- *
- * | key             | unmatched  | val from node | return value |
- * |-----------------|------------|---------------|--------------|
- * | a               | not called | n/a           | -1           |
- * | refs            | \0         | refs          | as per fn    |
- * | refs/           | /          | refs          | as per fn    |
- * | refs/w          | /w         | refs          | as per fn    |
- * | refs/worktree   | \0         | refs/worktree | as per fn    |
- * | refs/worktree/  | /          | refs/worktree | as per fn    |
- * | refs/worktree/a | /a         | refs/worktree | as per fn    |
- * |-----------------|------------|---------------|--------------|
+ * For example, consider the trie containing only [logs,
+ * logs/refs/bisect], both with values, but not logs/refs.
  *
+ * | key                | unmatched      | prefix to node   | return value |
+ * |--------------------|----------------|------------------|--------------|
+ * | a                  | not called     | n/a              | -1           |
+ * | logstore           | not called     | n/a              | -1           |
+ * | logs               | \0             | logs             | as per fn    |
+ * | logs/              | /              | logs             | as per fn    |
+ * | logs/refs          | /refs          | logs             | as per fn    |
+ * | logs/refs/         | /refs/         | logs             | as per fn    |
+ * | logs/refs/b        | /refs/b        | logs             | as per fn    |
+ * | logs/refs/bisected | /refs/bisected | logs             | as per fn    |
+ * | logs/refs/bisect   | \0             | logs/refs/bisect | as per fn    |
+ * | logs/refs/bisect/  | /              | logs/refs/bisect | as per fn    |
+ * | logs/refs/bisect/a | /a             | logs/refs/bisect | as per fn    |
+ * | (If fn in the previous line returns -1, then fn is called once more:) |
+ * | logs/refs/bisect/a | /refs/bisect/a | logs             | as per fn    |
+ * |--------------------|----------------|------------------|--------------|
  */
 static int trie_find(struct trie *root, const char *key, match_fn fn,
 		     void *baton)
-- 
2.24.0.rc0.472.ga6f06c86b4

