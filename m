Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBB9A201CF
	for <e@80x24.org>; Thu, 18 May 2017 23:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932671AbdERXXk (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 19:23:40 -0400
Received: from ozlabs.org ([103.22.144.67]:54665 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752741AbdERXXj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 19:23:39 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 3wTS151MWcz9s5L;
        Fri, 19 May 2017 09:23:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1495149817;
        bh=0eqNZcx4yge/p+Owq6q0Ghd5Q+b7ydbjgU7+2tfppJA=;
        h=Date:From:To:Cc:Subject:From;
        b=G7oovlQ3bYbJ77rmUvv3JDv00UZhdMAMJ6wbhL6dsgiU54+WkEtQWH9l8bk/vxqaC
         KXgBHdjT3Sxzb7IlToFRyPtIXWbBcOMHqcrMF4zELDdrhZrgdClU5cAjucfwXzFo0u
         Zj5w+p39f29syUtMhplDy5LQuaY6aPIf5lAsgN8mhHxXIfkidCoEN/aRWQGzlWMi4X
         z6Ija55eQEh60pKKfIBgmvCP7ATfI5XbJN32BAb0BxMUhqadihAuqxOdRIYpF/y20W
         nCQXqZaaYBoTfAdp7rGgo+7QVQXoooJ0WcSGz3DKHFv5u8v7f4UO83sSjomYWFMybA
         Ogl3GmjS5cZUg==
Date:   Fri, 19 May 2017 09:23:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing list <git@vger.kernel.org>
Subject: git merges of tags
Message-ID: <20170519092202.6b0f9a57@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

Just a reminder that if you are merging Linus' tree (or any tree
really) via a tag, git was changed some time ago so that merging a tag
will not do a fast forward (there is a good reason for this - I just
can't recall it ATM).  This is a problem when your current head of
branch has been merged into (e.g.) Linus' tree and then you do "git
merge <tag>" on a tag that is later than the merge point.  You end up
with an unnecessary merge commit rather than just fast forwarding.

To do the fast forward, try "git merge <tag>^{}" ... (unfortunately
doing "git merge --ff <tag>" also does not do a fast forward - it also
doesn't fail, it unexpectedly just creates a merge commit :-().
-- 
Cheers,
Stephen Rothwell
