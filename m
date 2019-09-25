Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 303451F463
	for <e@80x24.org>; Wed, 25 Sep 2019 10:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389759AbfIYK1E (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Sep 2019 06:27:04 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44741 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389749AbfIYK1E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Sep 2019 06:27:04 -0400
Received: by mail-pl1-f194.google.com with SMTP id q15so2209061pll.11
        for <git@vger.kernel.org>; Wed, 25 Sep 2019 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kRqPbY6Wtgye6Xoy5ANh/Wmd8w7n0jbN32VYrQyCLYU=;
        b=o0Q862KMyCRapHcj5eNkc3Ch676jdbDNTm+hHum5qGHYeBCk79vNso+54582mMebK1
         OByAapSuzNSNg0FTRh4+9LmHCTQJChnE5Xp3u+V4zwaGWUebXyJFGiEEnFiws7ksv7CO
         rNKd33nwwlcvLymzVj/OU0LtmuyxnfkC4suj+xUHtYUDbOjcqS5KvvNbk+qCnh1vgLwD
         FAQ4DNCrPVTcz43Q/PB7i4XJohTUfVIQ26koYiLR1ipUkh3muSMd6h/wDLJYhi2pvXrR
         MGffYhjrerWnpE2ZPEB5Y8oH1Fsd5Ea/q0GLOPp7BnNvL+WgAfJLp4TzEti6b9DQ/2GD
         muLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kRqPbY6Wtgye6Xoy5ANh/Wmd8w7n0jbN32VYrQyCLYU=;
        b=C7Vc8rGykwlTzjd7pJuv44JkviKiQQkMA7gIiyGCLhNNXeAxQUIwisn9VXasLl9e92
         j/6EGFsBTmqEKKVd5skWYxfUp+87U81K1adIMrVfaimwbBOwSd/IkTSs5tUKy8O4BbQg
         JMUS33OW3tDZnbHfg5EPte7DTTWM3G4pH5PGdQ1Num0bclIGr4LuYvNAx5q2BHSt9qSc
         Wr24VECv8wBAeaciOPHLTD1OuR0Ycv5fGkKFk1PjVaJ1kChkflE0D5mNaw5yroMXvdkR
         nHWsDPHc8syZyRyAGZpGjUk7IeGU2Ljl4KTddUO39J+4eyuFgSrcc/sFPjTypZvAH1p2
         6OEg==
X-Gm-Message-State: APjAAAWQ86VR2MGirj9Dl4BoQpDWp+sQP+hAy/uXjWF3J2WREsuS4Fld
        tP9ks2JtDdNAIY1swec1ZYXFro+h
X-Google-Smtp-Source: APXvYqwJVOoFMB9XISCmIhTmBvlLhWGWFSQe//i70F3oCgnPfWGQ3gGxD98grz/MAHrgP95rbcOxtA==
X-Received: by 2002:a17:902:6b47:: with SMTP id g7mr8360101plt.198.1569407223102;
        Wed, 25 Sep 2019 03:27:03 -0700 (PDT)
Received: from archbookpro.localdomain ([2601:646:280:1b30::6486])
        by smtp.gmail.com with ESMTPSA id a17sm5125224pfi.178.2019.09.25.03.27.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2019 03:27:02 -0700 (PDT)
Date:   Wed, 25 Sep 2019 03:27:01 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: [BUG/PATCH 1/5] test-lib: let test_merge() perform octopus merges
Message-ID: <e77af8cde5380c3ba43f074232a50a262ef79791.1569407150.git.liu.denton@gmail.com>
References: <cover.1569407150.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1569407150.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently test_merge() only allows developers to merge in one branch.
However, this restriction is artificial and there is no reason why it
needs to be this way.

Extend test_merge() to allow the specification of multiple branches so
that octopus merges can be performed.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/test-lib-functions.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 87bf3a2287..b299ecc326 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -228,9 +228,11 @@ test_commit () {
 # can be a tag pointing to the commit-to-merge.
 
 test_merge () {
+	label="$1" &&
+	shift &&
 	test_tick &&
-	git merge -m "$1" "$2" &&
-	git tag "$1"
+	git merge -m "$label" "$@" &&
+	git tag "$label"
 }
 
 # Efficiently create <nr> commits, each with a unique number (from 1 to <nr>
-- 
2.23.0.248.g3a9dd8fb08

