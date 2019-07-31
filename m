Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3AB601F731
	for <e@80x24.org>; Wed, 31 Jul 2019 15:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729317AbfGaP75 (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 11:59:57 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.103]:34168 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727370AbfGaP75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 11:59:57 -0400
X-Greylist: delayed 882 seconds by postgrey-1.27 at vger.kernel.org; Wed, 31 Jul 2019 11:59:56 EDT
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1hsqmu-00072f-HN
        for git@vger.kernel.org; Wed, 31 Jul 2019 17:45:12 +0200
To:     git@vger.kernel.org
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Subject: Support for --stdin-paths in commit, add, etc
Message-ID: <a38bc928-7ccd-e2d9-b89b-23298e9fa95d@syntevo.com>
Date:   Wed, 31 Jul 2019 17:45:12 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Hello,

This is a follow-up for previous discussion [1].

In our git UI, we sometimes run into OS commandline length limit when
trying to specify a list of pathspecs. For example, this happens when
user selects a large set of files and wants to commit them. As a
workaround, we split files and issue multiple git commands.

This has multiple disadvantages:
1) Some commands are a lot slower this way. For example, commit-amend
    can take 45 minutes instead of 30 seconds, because git will do a lot
    of unnecessary work.
2) The operation is no longer completed in one "transaction".
3) This makes our code more complicated.

Our suggestion is to change commands such as 'commit', 'add', etc to
also work with --stdin-paths. If a command already supports stdin for
any purpose, then trying to use both options will return an error.

We're ready to develop the necessary patches to make this possible.

[1] 
https://public-inbox.org/git/c3be6eff-365b-96b8-16d2-0528612fc1fc@syntevo.com/T/#u
