Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78BEC1F87F
	for <e@80x24.org>; Wed, 21 Nov 2018 12:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbeKUXLN (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Nov 2018 18:11:13 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.35]:57880 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728428AbeKUXLN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Nov 2018 18:11:13 -0500
X-Greylist: delayed 11637 seconds by postgrey-1.27 at vger.kernel.org; Wed, 21 Nov 2018 18:11:13 EST
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1gPOjM-0005uB-5c
        for git@vger.kernel.org; Wed, 21 Nov 2018 10:23:32 +0100
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: pathspec: problems with too long command line
To:     git@vger.kernel.org
Message-ID: <c3be6eff-365b-96b8-16d2-0528612fc1fc@syntevo.com>
Date:   Wed, 21 Nov 2018 10:23:34 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 From our GUI client we are invoking git operations on a possibly large 
set of files. This may result in pathspecs which are exceeding the 
maximum command line length, especially on Windows [1] and OSX [2]. To 
workaround this problem we are currently splitting up such operations by 
invoking multiple git commands. This works well for some commands (like 
add), but doesn't work well for others (like commit).

A possible solution could be to add another patchspec magic word which 
will read paths from a file instead of command line. A similar approach 
can be found in Mercurial with its "listfile:" pattern [3].

Does that sound reasonable? If so, we should be able to provide a 
corresponding patch.

-Marc

[1] https://blogs.msdn.microsoft.com/oldnewthing/20031210-00/?p=41553/
[2] https://serverfault.com/questions/69430
[3] https://www.mercurial-scm.org/repo/hg/help/patterns


