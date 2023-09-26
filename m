Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD089E7E650
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 17:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjIZRGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 13:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjIZRGB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 13:06:01 -0400
X-Greylist: delayed 1081 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 26 Sep 2023 10:05:54 PDT
Received: from smtp.onerussian.com (washoe.dartmouth.edu [129.170.30.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F042B10E
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 10:05:54 -0700 (PDT)
Received: from c-73-69-87-143.hsd1.nh.comcast.net ([73.69.87.143] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <yoh@onerussian.com>)
        id 1qlBDz-00065x-Tc; Tue, 26 Sep 2023 12:47:52 -0400
Date:   Tue, 26 Sep 2023 12:47:51 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     Isaac To <isaac.chun.to@gmail.com>
Message-ID: <ZRMLNyHXoWOj6K-l@bilena>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-SA-Exim-Connect-IP: 73.69.87.143
X-SA-Exim-Rcpt-To: git@vger.kernel.org, isaac.chun.to@gmail.com
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: git-retry tool or git.retry config (built-in implementation)?
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Gurus,

In DataLad (https://datalad.org) we are doing lots of automated cloning,
fetching etc as part of our CI etc jobs.  Once in a while git operations
fail [see e.g. 1], and beg us to retry but we need to know when to
do so, and not do it upon every failed git invocation since some
failures could be legit (repository is gone). While looking how others
solve it we found
https://stackoverflow.com/questions/35014012/git-retry-if-http-request-failed
which pointed to tools like git-retry and later part of
https://chromium.googlesource.com/infra/infra/+/HEAD/go/src/infra/tools/git/retry_regexp.go
which serve as a collection of regexes to be on lookout for to retry.

Would that be the "best" strategy currently?  

As regex matching might eventually break whenever `git` changes
anything in the output messages, I wondered if there could be a more
robust internal implementation in git itself?  Similarly git-annex has
annex.retry config setting which sets the count of retries for
"retriable" operations.  

Do you think something like that could be implemented in git in some
foreseable future?

[1] https://github.com/datalad/datalad/issues/7485

Thank you in advance!
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
WWW:   http://www.linkedin.com/in/yarik        

