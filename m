Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFD3B20193
	for <e@80x24.org>; Wed, 26 Oct 2016 09:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754022AbcJZJMR (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 05:12:17 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:46358 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750833AbcJZJMM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 26 Oct 2016 05:12:12 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5FEEC204B0;
        Wed, 26 Oct 2016 05:11:16 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Wed, 26 Oct 2016 05:11:16 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :date:from:in-reply-to:message-id:references:subject:to
        :x-me-sender:x-me-sender:x-sasl-enc:x-sasl-enc; s=mesmtp; bh=L2S
        TuO/0/9lQJcsOGJfSSnubGpQ=; b=UcBMqqHHwc0aKf4IoSIs8rxQzkx9KNznrhJ
        fkpMi3AhP6XUUwgJAGZSJ2PuWYRMVqHT+HheNouZjXto0HhI/MK2GlhZdkVzsUf7
        7JJl+xoVdaH59dJCK/Pc5E9YAq9YxuEWhP6+IcC5zkf+WELv/TOfEfQv8M6FVTeC
        s7Fq8yd0=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:date:from:in-reply-to:message-id
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc
        :x-sasl-enc; s=smtpout; bh=L2STuO/0/9lQJcsOGJfSSnubGpQ=; b=mIb8X
        tuc08ekv7Q0KFX62WVP1cK9tvJUlGHTXN4uXcxgKYsWAy9Z3JH5YIkxlAkUAS5u0
        PM0DS6ss2ybQZaBrnfn4yGHft1l6pxqvFxvDxEwzZFFqFNHLC1mt9Ne1ke1dYlCn
        nli9pxZjftS8q3q9AlpaLL0eB8RgZccNDfRjko=
X-ME-Sender: <xms:NHMQWBmV569mSYjsMSd8YpcKvwuj70S28N-b1-o5U-Z6ntrY9CF7wQ>
X-Sasl-enc: TyJROh+DHqOt7n3qmiBS9PQ51LpNaCsSIe39azxtFP71 1477473075
Received: from localhost (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id EDAA9F29CD;
        Wed, 26 Oct 2016 05:11:15 -0400 (EDT)
From:   Michael J Gruber <git@drmicha.warpmail.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH] Documentation/git-diff: document git diff with 3+ commits
Date:   Wed, 26 Oct 2016 11:11:14 +0200
Message-Id: <07712c2c94670ca4d91ef78cd7d3602a8d36b0c1.1477472970.git.git@drmicha.warpmail.net>
X-Mailer: git-send-email 2.10.1.723.g0f00470
In-Reply-To: <CA+P7+xq1i8AtQ7i=1m_n9HTSL10kFUFBn8jvNcB_t_6Rh29u4w@mail.gmail.com>
References: <CA+P7+xq1i8AtQ7i=1m_n9HTSL10kFUFBn8jvNcB_t_6Rh29u4w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That one is difficult to discover but super useful, so document it:
Specifying 3 or more commits makes git diff switch to combined diff.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Notes:
    Note that we have the following now:
    
    'git diff A B' displays 'B minus A'
    'git diff A B C' displays 'A minus B' and 'A minus C'
    
    While I know why, that (the implicit '-R' seems unfortunate).
    
    (NB: One has to use '-c' if A is an actual merge commiti, it seems.)
    
    If M is a merge base for A and B, we have:
    
    'git diff A..B' equivalent to 'git diff A B'
    in contrast to 'git log A..B' listing commits between M and B only
    (without the commits between M and A unless they are "in" B).
    
    I would expect 'git diff M B' here.
    
    'git diff A...B' is equivalent to 'git diff M B'
    in contrast to 'git log A...B' listing commits between M and A (marked left)
    as well as commits between M and B (marked right).
    
    I would expect 'git diff -c -R M A B' here.
    
    Somehow the positive and negative ends of these ranges don't correspond well
    with thinking about diffs as differences between these ends.
    
    [I'm not exact with my use of "between" regarding boundary commits.]

 Documentation/git-diff.txt | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index bbab35fcaf..2047318a27 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -12,6 +12,7 @@ SYNOPSIS
 'git diff' [options] [<commit>] [--] [<path>...]
 'git diff' [options] --cached [<commit>] [--] [<path>...]
 'git diff' [options] <commit> <commit> [--] [<path>...]
+'git diff' [options] <commit> <commit> <commit> [<commit>...]
 'git diff' [options] <blob> <blob>
 'git diff' [options] [--no-index] [--] <path> <path>
 
@@ -75,9 +76,16 @@ two blob objects, or changes between two files on disk.
 	"git diff $(git-merge-base A B) B".  You can omit any one
 	of <commit>, which has the same effect as using HEAD instead.
 
+'git diff' [options] <commit> <commit> <commit> [<commit>...]::
+
+	This is to view a combined diff between the first <commit>
+	and the remaining ones, just like viewing a combined diff
+	for a merge commit (see below) where the first <commit>
+	is the merge commit and the remaining ones are the parents.
+
 Just in case if you are doing something exotic, it should be
 noted that all of the <commit> in the above description, except
-in the last two forms that use ".." notations, can be any
+in the two forms that use ".." notations, can be any
 <tree>.
 
 For a more complete list of ways to spell <commit>, see
-- 
2.10.1.723.g0f00470

