Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B141F516
	for <e@80x24.org>; Fri, 22 Jun 2018 12:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751378AbeFVMKL (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 08:10:11 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.14]:8366 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751335AbeFVMKK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 08:10:10 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Jun 2018 08:10:10 EDT
Received: from [91.113.179.170] (helo=[192.168.92.26])
        by smtprelay02.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <marc.strapetz@syntevo.com>)
        id 1fWKnS-00067Z-Hm
        for git@vger.kernel.org; Fri, 22 Jun 2018 14:04:10 +0200
From:   Marc Strapetz <marc.strapetz@syntevo.com>
Subject: Unexpected ignorecase=false behavior on Windows
To:     git@vger.kernel.org
Message-ID: <c5abdd45-a919-96f6-8560-5fd943069f5e@syntevo.com>
Date:   Fri, 22 Jun 2018 14:04:09 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWFyYy5zdHJhcGV0ekBzeW50ZXZvLmNvbQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, when creating following repository:

$ git init
$ echo "1" > file.txt
$ git add .
$ git commit -m "initial import"
$ ren file.txt File.txt
$ git config core.ignorecase false

Status results are:

$ git status --porcelain
?? File.txt

As on Unix, I would expect to see:

$ git status --porcelain
  D file.txt
?? File.txt

Is the Windows behavior intended? I'm asking, because e.g. JGit will 
report missing files, too, and I'm wondering what would be the correct 
way to resolve this discrepancy? (JGit does not have 
"ignorecase=true"-support at all, btw).

Tested with git version 2.17.1.windows.2

-Marc








