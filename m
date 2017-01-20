Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAA4720756
	for <e@80x24.org>; Fri, 20 Jan 2017 17:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751786AbdATRLm (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 12:11:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51828 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751342AbdATRLl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 12:11:41 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 27A57C04B320;
        Fri, 20 Jan 2017 17:11:30 +0000 (UTC)
Received: from localhost (ovpn-117-185.ams2.redhat.com [10.36.117.185])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v0KHBS3R022519;
        Fri, 20 Jan 2017 12:11:29 -0500
From:   Stefan Hajnoczi <stefanha@redhat.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, gitster@pobox.com,
        Brandon Williams <bmwill@google.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 0/2] grep: make output consistent with revision syntax
Date:   Fri, 20 Jan 2017 17:11:24 +0000
Message-Id: <20170120171126.16269-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 20 Jan 2017 17:11:30 +0000 (UTC)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:
 * Use obj->type instead of re-parsing name for delimiter
   (Followed Brandon's suggestion but named the variable 'delim' since that
   name is used in other places and 'del' is used for deletion.)
 * Add tests
 * Update Patch 1 commit description with a more relevant example
 * PATCH instead of RFC, now works with all documented git-rev-parse(1) syntax

git-grep(1)'s output is not consistent with git-rev-parse(1) revision syntax.

This means you cannot take "rev:path/to/file.c: foo();" output from git-grep(1)
and expect "git show rev:path/to/file.c" to work.  See the individual patches
for examples of command-lines that produce invalid output.

Stefan Hajnoczi (2):
  grep: only add delimiter if there isn't one already
  grep: use '/' delimiter for paths

 builtin/grep.c  |  8 +++++++-
 t/t7810-grep.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.9.3

