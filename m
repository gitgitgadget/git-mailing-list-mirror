Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D87F41F404
	for <e@80x24.org>; Sat, 16 Dec 2017 09:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752251AbdLPJEL (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Dec 2017 04:04:11 -0500
Received: from mail-pl0-f47.google.com ([209.85.160.47]:44912 "EHLO
        mail-pl0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750850AbdLPJEF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Dec 2017 04:04:05 -0500
Received: by mail-pl0-f47.google.com with SMTP id n13so1864731plp.11
        for <git@vger.kernel.org>; Sat, 16 Dec 2017 01:04:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=zhcfJj5FmguSbV93t2b5JMPzYWs6rlI7dgUz9Y6ADlw=;
        b=S1KB8MlRmy73KdQcCeLkLJujpTb4MzbYhauihpbH3CuEwn8PK3DvDamBGq8ljkrPBl
         fcy+8TdTIceohPYR1xxi6pgCPP9tzPuFuvp20S0QCFYW35Bk88zQATironNGO//7ND/g
         P8wwdSmtgG9acmgJKteQ9E9aMv7bfGXDuBbc/puSQsxdBWsgyeh7VLxgOWKlKkRZpYHA
         MLHU0h7h6VpY97r/uPsmosOoO5Nje2Gec8VyM61jd0+EvyLVu7lLERUoLLpuWvh0rvAn
         hzt6zq6I/pyqxzaQaknaYl0ee6We4JV+zWqSJdvnG/nSAONp4ZIvi7l1EKNrdeGJmNZx
         bjQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=zhcfJj5FmguSbV93t2b5JMPzYWs6rlI7dgUz9Y6ADlw=;
        b=HbEeUklVxxdt0FLoJYUCrZsCdOMs5L8o+4FcodCsCSjdqZd+Q8LJ/ra867gJgXYLbf
         1cNoY4jqI5eodf1R+yUzNdqfbX9QEpRnwdZAiETIEwPIAcF/yLjOyfaZU7bjP1f2QhPQ
         WP2MYrIaatEvv/MBFi4SzcMVfQdBuptKvfyAX5dP9BcOFsDrzUxOJUv+mngx2IgTTBYP
         ZjusSJxz6/8+Oc+eWMbv6+xNQpjHDw5OwSEkSO89va/uvjE5wqtSbfWFxKtxzxlT+k2f
         mkUpD75fMEOqCG7/fvqgWOwfXettyRdko6qniFHpgttck8Q+wr4D0mNROtV8qGZOMmgb
         JKHQ==
X-Gm-Message-State: AKGB3mJ59/xj/oR0bNhbomw4uFvdzMBHnczPMt2JF8vhWXb2bjHQfBMW
        dyoAluI+Q1g6277pJ4lSfw+B+DsN
X-Google-Smtp-Source: ACJfBovEYu54Q3Ro5TvL4UN6GZgZDgVYBt6EUoRlnQIJhPARN4vjYMBpX5msyqw06o//HRErZReggw==
X-Received: by 10.159.207.136 with SMTP id z8mr16294468plo.223.1513415044013;
        Sat, 16 Dec 2017 01:04:04 -0800 (PST)
Received: from localhost.localdomain ([117.249.248.104])
        by smtp.gmail.com with ESMTPSA id u68sm15775852pfu.17.2017.12.16.01.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Dec 2017 01:04:03 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 0/3] rebase: give precise error messages
Date:   Sat, 16 Dec 2017 14:33:16 +0530
Message-Id: <20171216090319.11902-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c
In-Reply-To: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
References: <20171127172104.5796-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tip of the v4 of this patch can be found at [1]. It was a revamp
sent by Junio mostly touching [PATCH v2 1/3] of the series. I've updated
it a little to add in something of my taste ;-)

There's only one concern that still bothers me a little. With the current
code you would see the following,

    $ git rebase origin/maint 3013dff86
    Current branch 3013dff86 is up to date.

That doesn't look good, does it? How about we overcome the issue of
handling this case and the HEAD case done in 3/3 by simplifying the
message as shown in the following diff,

diff --git a/git-rebase.sh b/git-rebase.sh
index 0f379ba2b..4d5400034 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -601,11 +601,11 @@ then
                test -z "$switch_to" ||
                GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
                        git checkout -q "$switch_to" --
-               say "$(eval_gettext "Current branch \$branch_name is up to date.")"
+               say "$(eval_gettext "\$branch_name is up to date.")"
                finish_rebase
                exit 0
        else
-               say "$(eval_gettext "Current branch \$branch_name is up to date, rebase forced.")"
+               say "$(eval_gettext "\$branch_name is up to date, rebase forced.")"
        fi
 fi

I guess this one is much better than 3/3 of this series as it handles
any kind of case by making no assumptions.

Thoughts ??


Note: In case you're wondering where's v3 of this series, there wasn't
a v3 series but there was a v3 PATCH of 3/3 [2].

References:

[1]: <xmqq1sjxt3tz.fsf@gitster.mtv.corp.google.com>

[2]: <20171201060935.19749-1-kaartic.sivaraam@gmail.com>

Here's the interdiff between v4 and v5,

diff --git a/git-rebase.sh b/git-rebase.sh
index f3dd86443..fd72a35c6 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -518,7 +518,7 @@ case "$onto_name" in
 esac
 
 # If the branch to rebase is given, that is the branch we will rebase
-# $branch_name -- branch being rebased, or HEAD (already detached)
+# $branch_name -- branch/commit being rebased, or HEAD (already detached)
 # $orig_head -- commit object name of tip of the branch before rebasing
 # $head_name -- refs/heads/<that-branch> or "detached HEAD"
 switch_to=
@@ -602,7 +602,7 @@ then
                GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to" \
                        git checkout -q "$switch_to" --
                if test "$branch_name" = "HEAD" &&
-                        !(git symbolic-ref -q HEAD)
+                        ! git symbolic-ref -q HEAD
                then
                        say "$(eval_gettext "HEAD is up to date.")"
                else
@@ -612,7 +612,7 @@ then
                exit 0
        else
                if test "$branch_name" = "HEAD" &&
-                        !(git symbolic-ref -q HEAD)
+                        ! git symbolic-ref -q HEAD
                then
                        say "$(eval_gettext "HEAD is up to date, rebase forced.")"
                else



Kaartic Sivaraam (3):
  rebase: consistently use branch_name variable
  rebase: distinguish user input by quoting it
  rebase: rebasing can also be done when HEAD is detached

 git-rebase.sh | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

-- 
2.15.0.531.g2ccb3012c

