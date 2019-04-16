Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EEE720248
	for <e@80x24.org>; Tue, 16 Apr 2019 18:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfDPSEI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Tue, 16 Apr 2019 14:04:08 -0400
Received: from relay02-outbound-protection.hex2013.com ([195.34.83.99]:55380
        "EHLO relay02-outbound-protection.hex2013.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728809AbfDPSEH (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 16 Apr 2019 14:04:07 -0400
Received: from DOX13BE05.hex2013.com (unknown [128.127.71.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay02-outbound-protection.hex2013.com (Postfix) with ESMTPS id B9BEC62D27
        for <git@vger.kernel.org>; Tue, 16 Apr 2019 20:04:05 +0200 (CEST)
Received: from DOX13BE05.hex2013.com (fc9a:3ec4:e134:1338::23) by
 DOX13BE05.hex2013.com (fc9a:3ec4:e134:1338::23) with Microsoft SMTP Server
 (TLS) id 15.0.1473.3; Tue, 16 Apr 2019 20:04:05 +0200
Received: from DOX13BE05.hex2013.com ([fe80::757c:305c:4234:5820]) by
 DOX13BE05.hex2013.com ([fe80::757c:305c:4234:5820%18]) with mapi id
 15.00.1473.003; Tue, 16 Apr 2019 20:04:05 +0200
From:   Christian Vetter <christian@rasenplanscher.info>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [BUG] git stash --keep-index undeletes file
Thread-Topic: [BUG] git stash --keep-index undeletes file
Thread-Index: AQHU9H604QsspfATS0uYjRCPVAT7YA==
Date:   Tue, 16 Apr 2019 18:04:05 +0000
Message-ID: <1555437849815.60450@rasenplanscher.info>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [128.127.69.93]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce
+ mkdir git-stash-test
+ cd git-stash-test
+ git init
+ touch file
+ git add file
+ git commit -m init
+ git rm file
+ git stash push --keep-index
 
 
Result: 
`git status` gives this output:
> On branch master
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
> 
>         deleted:    file
> 
> Untracked files:
>   (use "git add <file>..." to include in what will be committed)
> 
>         file
 
 
Expected: 
`git status` gives this output:
> On branch master
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
> 
>         deleted:    file
 
 
Verified on:
+ Windows 10, git version 2.21.0.windows.1 
+ Ubuntu 14.04, git version 2.21.0
