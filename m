Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 410831F424
	for <e@80x24.org>; Wed,  9 May 2018 02:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933592AbeEICNv (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 May 2018 22:13:51 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:34063 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932484AbeEICNq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 May 2018 22:13:46 -0400
Received: by mail-pl0-f66.google.com with SMTP id ay10-v6so3342081plb.1
        for <git@vger.kernel.org>; Tue, 08 May 2018 19:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vM8W9Z3ylReMAR36L0Q4pJAo89yjCrrgm0kOBm/eRkI=;
        b=v2yTpZz2bJFDZ7X59qVrXNkNC9uwCdvKQBfdYhSri5Upv96BcNuUvcvTvYmzAgPC8C
         s/IBOS9VaViFotay8NEpYe44+s3NSpP3B8E6hZQsml6mCeF8P4Nr27Gw7BcXOdlHW7yw
         N1QZ6ELvuix40LCWhUumZnbE4DW8e/7slChDXCqe4GVxh3WuZjoHp1UvUR+9tN8aqxp8
         r919KqCGEYykiWruoi+AqNileFtfguJOwWHBuz+vasrjmb2tRbFG8EHZRSYBGWnkiX6H
         gl3Q+ZQNOf7uyhZXswmLo7hLZk/d2bhwUpTvphxQaD8LV4TOUeiOD+HV14Jg1rVD/CdB
         Xh1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vM8W9Z3ylReMAR36L0Q4pJAo89yjCrrgm0kOBm/eRkI=;
        b=T19UoP4iNQrDxrN7mta/G5DV3wvzF8O/FZdmhPPrTeJ19tnR8j4wNvZUoKLtY8QANT
         1TzxiQi9IKMHBgptAuWkxH1UXxeAgz5zsGmbNR2IFw2hHqV9aFWfdD4/L6Zxinru+RPM
         8+JbYzFGbQIlB7A2CjjZmVd+aZw1yPfhV3EU/9rNS/pz+ougWJtmY7Z+cO91wnj/Qv2x
         8GHBow+6r4vQdAIcgosT60XLeiSuJRKsbHiMvv5r3vYIGseVr8gBQgpwfQoV3EmYDcNk
         4qruYWJqQrwEw3bzUCDbBIemmXpzPkjFsdRI41euB0nG+cfGcnyGEoBRVjwMBfe7BqJB
         81uA==
X-Gm-Message-State: ALKqPwflAGkOGYf12tL6R3Mk7jbt8cryypwvwibJFwIiinMoVG/erwXU
        mfv97R1RT9k9w6Ijo0eHxCeNaiXRN89TmQ==
X-Google-Smtp-Source: AB8JxZo4IsAinmAVkWxEgsdhSGgq8Rf0qMx9YGNDHfvnYKLDONA9V0FRv1NPL+GFTYUkX1iJ2T4w4g==
X-Received: by 2002:a17:902:9048:: with SMTP id w8-v6mr98485plz.34.1525832024918;
        Tue, 08 May 2018 19:13:44 -0700 (PDT)
Received: from localhost ([2601:602:9500:1120:d537:72d4:95b0:7812])
        by smtp.gmail.com with ESMTPSA id 69sm35762904pfh.33.2018.05.08.19.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 May 2018 19:13:43 -0700 (PDT)
Date:   Tue, 8 May 2018 19:13:43 -0700
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, l.s.r@web.de,
        martin.agren@gmail.com, pclouds@gmail.com, peff@peff.net,
        phillip.wood@talktalk.net, sunshine@sunshineco.com
Subject: [PATCH v5 7/7] contrib/git-jump/git-jump: jump to match column in
 addition to line
Message-ID: <0ab0a422fea29233fad37e6b8d57648f43db6b89.1525831201.git.me@ttaylorr.com>
References: <20180421034530.GB24606@syl.local>
 <cover.1525831201.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1525831201.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of 'git-grep(1)''s new option, '--column' in order to
teach Peff's 'git-jump' script how to jump to the correct column for any
given match.

'git-grep(1)''s output is in the correct format for Vim's jump list, so
no additional cleanup is necessary.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 contrib/git-jump/README   | 12 ++++++++++--
 contrib/git-jump/git-jump |  2 +-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/contrib/git-jump/README b/contrib/git-jump/README
index 4484bda410..2f618a7f97 100644
--- a/contrib/git-jump/README
+++ b/contrib/git-jump/README
@@ -25,6 +25,13 @@ git-jump will feed this to the editor:
 foo.c:2: printf("hello word!\n");
 -----------------------------------
 
+Or, when running 'git jump grep', column numbers will also be emitted,
+e.g. `git jump grep "hello"` would return:
+
+-----------------------------------
+foo.c:2:9: printf("hello word!\n");
+-----------------------------------
+
 Obviously this trivial case isn't that interesting; you could just open
 `foo.c` yourself. But when you have many changes scattered across a
 project, you can use the editor's support to "jump" from point to point.
@@ -35,7 +42,8 @@ Git-jump can generate four types of interesting lists:
 
   2. The beginning of any merge conflict markers.
 
-  3. Any grep matches.
+  3. Any grep matches, including the column of the first match on a
+     line.
 
   4. Any whitespace errors detected by `git diff --check`.
 
@@ -82,7 +90,7 @@ which does something similar to `git jump grep`. However, it is limited
 to positioning the cursor to the correct line in only the first file,
 leaving you to locate subsequent hits in that file or other files using
 the editor or pager. By contrast, git-jump provides the editor with a
-complete list of files and line numbers for each match.
+complete list of files, lines, and a column number for each match.
 
 
 Limitations
diff --git a/contrib/git-jump/git-jump b/contrib/git-jump/git-jump
index 80ab0590bc..931b0fe3a9 100755
--- a/contrib/git-jump/git-jump
+++ b/contrib/git-jump/git-jump
@@ -52,7 +52,7 @@ mode_merge() {
 # editor shows them to us in the status bar.
 mode_grep() {
 	cmd=$(git config jump.grepCmd)
-	test -n "$cmd" || cmd="git grep -n"
+	test -n "$cmd" || cmd="git grep -n --column"
 	$cmd "$@" |
 	perl -pe '
 	s/[ \t]+/ /g;
-- 
2.17.0
