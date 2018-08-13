Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1A6A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbeHMTXw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 13 Aug 2018 15:23:52 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:40454 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728540AbeHMTXw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 15:23:52 -0400
X-Greylist: delayed 1095 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Aug 2018 15:23:51 EDT
Received: from [10.31.181.225] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1fpFc9-00023w-4H
        for git@vger.kernel.org; Mon, 13 Aug 2018 12:22:41 -0400
Date:   Mon, 13 Aug 2018 12:22:36 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20180813162236.GO732@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 10.31.181.225
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: wishlist: "--cached|--staged" to "git commit file(s)"
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git developers,

Following up on my quick question/discussion on IRC a few days
back:  Please consider adding --cached or --staged option for 

git commit file(s)

command.  ATM there is no non-interactive (via --patch/--interactive I
think it is possible) way to commit selected subset of staged files not
from the worktree (as it is done with "git commit file(s)") but from the
index.

Original usecase (I would be happy to elaborate):  committing specified
by user files in "direct" mode of git-annex, where it (via git annex
add) first converts files to the symlinks within index (they remain
original files within worktree), so we cannot use "git commit file(s)"
since then they would get committed disregarding their state in index.

But thinking about it I realized that it was quite a common use case to
me, that I typically stage all modified files whenever I reach "it is no
longer broken" stage, and then decide to commit that staged state in a
number of separate commits, and only then commit worktree state.

Current workaround as suggested on IRC is to 

- cp .git/index .git/index2
- GIT_INDEX_FILE=.git/index2 git reset files_not_to_be_committed
- GIT_INDEX_FILE=.git/index2 git commit
- rm .git/index2

or may be there is another (better) way?

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
