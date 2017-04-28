Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2AA0207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 14:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032519AbdD1ODb (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 10:03:31 -0400
Received: from mout.gmx.net ([212.227.15.15]:52238 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S938012AbdD1OD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 10:03:26 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LfSeH-1dsbWg3RxR-00p2Pt; Fri, 28
 Apr 2017 16:03:19 +0200
Date:   Fri, 28 Apr 2017 16:03:18 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>
Subject: [PATCH v2 13/25] setup_bare_git_dir(): help static analysis
In-Reply-To: <cover.1493387231.git.johannes.schindelin@gmx.de>
Message-ID: <e19e2bb59f9a81a59669385d5c69674808af8469.1493387231.git.johannes.schindelin@gmx.de>
References: <cover.1493237937.git.johannes.schindelin@gmx.de> <cover.1493387231.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zGMJF1NZiOyznLZMCLl3ysf7jVbiESybGMGX0NzCoURMW16zyvB
 MtKvQPJEJTRb0f3mEdEpmXgDNOs1MOAYuMxdfkWaD96znHk5nR1PPH6z+AK0y07UP61+QQU
 FmVpUo4To7UWsltOffIGGmdcrzRUCHpa774YwLNVpzG5fi8pQvF28UCv7ySDo3UJUwfO7hS
 2bPqQvrNaCacuWo2ijmKg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rVluSuYZ10s=:JFSjJQumI71g8IF1ZQhJFd
 /7/lZ4HXcLery9tJJE9NUIA9JSC21iXeGJhVacwSQucp6fBkEtQeGvQrnIDo2gucezfjOAVc0
 G04snRQoDVN93Y3R5cikZHmGnkSLwjtoHHZFEwz1OvyOUPmkcz9D3yY1Amz7Oa2EYDILrlZ67
 nrqyqySymtbhEs7f+phSk1J8Dj2JovRBwQluyZS1Lr+ie2/8cak4WMfp4BO36nQTU1xv3VmW3
 tl+5XI+34sjSKgegL9/351WXqW/sT/6qovGdDfEiWDfE0I2FCEC2YxIHNJ63jPsmKMOOpTJdd
 NfAfbdWwqLvN89on++GFfF03eoZY/khoiDF37ZZqEXh7hh3SedCk7IBO9ABqTyMnYvjqJtv+B
 98cE2KzKBg0zbcCge1JiY9TwrBZW7fk6Tw9MFImr21EqsIrS3Z0GqLhSeKyGzwUl8xP8tLO2/
 +lfHQiYNxem5gYnyzx6M+4fg64H/9+zCReWKftHJxllsV4FGv+Og2C5MmDEH4yAvCcvghFg3n
 jOo28WrIHcvlR4EH53mnKJNEzijdnFnYJFnCvDO8l+UQdyhYR3op42AOf2kS/98Jg1PbtWJAV
 ElYH/iy5cQL5hjRlgFDM3ntF48j7rwR1ck86ZNi2V7EwDTsb5X8ftzwvsy/7iF9BUDQtKC18l
 1t5m21aJVxAqPtsHdn4giH+Tz9zZB84r2VPxxoGgduq6HZiEHdt4E6FqZrGTDjwK27RbC0cF0
 1pvN7U6ZoD7nLGTiYPwwfDXHDyZJ/mwI64gIsMG+/auVbCd0S9N+xFPtelwPqOnvdWWwfEg1U
 te7dvd3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity reported a memory leak in this function. However, it can only
be called once, as setup_git_directory() changes global state and hence
is not reentrant.

Mark the variable as static to indicate that this is a singleton.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 0309c278218..0320a9ad14c 100644
--- a/setup.c
+++ b/setup.c
@@ -748,7 +748,7 @@ static const char *setup_bare_git_dir(struct strbuf *cwd, int offset,
 
 	/* --work-tree is set without --git-dir; use discovered one */
 	if (getenv(GIT_WORK_TREE_ENVIRONMENT) || git_work_tree_cfg) {
-		const char *gitdir;
+		static const char *gitdir;
 
 		gitdir = offset == cwd->len ? "." : xmemdupz(cwd->buf, offset);
 		if (chdir(cwd->buf))
-- 
2.12.2.windows.2.800.gede8f145e06


