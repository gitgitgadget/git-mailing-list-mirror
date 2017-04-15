Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8B2B1FA14
	for <e@80x24.org>; Sat, 15 Apr 2017 12:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbdDOM1E (ORCPT <rfc822;e@80x24.org>);
        Sat, 15 Apr 2017 08:27:04 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:18887 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752796AbdDOM1D (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Apr 2017 08:27:03 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3w4v0j6cbDz5tlB;
        Sat, 15 Apr 2017 14:27:01 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 723B51CFA;
        Sat, 15 Apr 2017 14:27:01 +0200 (CEST)
Subject: Re: Git allow to unconditionaly remove files on other developer host
To:     KES <kes-kes@yandex.ru>, git <git@vger.kernel.org>
References: <4747541492256174@web25g.yandex.ru>
Newsgroups: gmane.comp.version-control.git
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <c09e2447-a528-9da1-9936-9b0ebfdddd78@kdbg.org>
Date:   Sat, 15 Apr 2017 14:27:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <4747541492256174@web25g.yandex.ru>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.04.2017 um 13:36 schrieb KES:
> That curious, but git allow to unconditionally delete files on other developer host when he do `git pull`
>
> How to reproduce:
>
> 1. File should be ignored:
> echo "somefile" >> .gitignore
>
> 2. Add this ignored file into repository
> git add -f somefile
>
> 3. Push changes to origin
> git push
>
> 4. When other developer has also 'somefile' on his host and when he does
> git pull
>
> Content of hist local `somefile` file will be replaced by content pushed by first developer

This happens *only* if the other developers also have somefile mentioned 
in their .gitignore.

>
> EXPECTED: git should warn about that content will be replaced and do not pull/checkout until we force pull/checkout

If somefile is *not* mentioned in their .gitignore, the file is not 
removed and there is a warning.

Know that Git regards everything mentioned in .gitignore as dispensible; 
IOW, by mentioning a file in .gitignore you actually give permission to 
remove the file if necessary. Git does not have a feature to say "ignore 
this file, but it is precious".

-- Hannes

