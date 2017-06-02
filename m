Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53B212027C
	for <e@80x24.org>; Fri,  2 Jun 2017 17:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751189AbdFBRT1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 13:19:27 -0400
Received: from renepasing.de ([5.9.148.133]:60267 "EHLO mail.renepasing.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751153AbdFBRT1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 13:19:27 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Jun 2017 13:19:27 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.renepasing.de (Postfix) with ESMTP id B11561001D7C
        for <git@vger.kernel.org>; Fri,  2 Jun 2017 19:12:38 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mail.renepasing.de
Received: from mail.renepasing.de ([127.0.0.1])
        by localhost (mail.renepasing.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 7Um1Ef3-Hkdp for <git@vger.kernel.org>;
        Fri,  2 Jun 2017 19:12:36 +0200 (CEST)
Received: from [IPv6:2a02:908:1064:9240:d62d:b5ff:fe75:dd57] (unknown [IPv6:2a02:908:1064:9240:d62d:b5ff:fe75:dd57])
        by mail.renepasing.de (Postfix) with ESMTPSA id 4B640100013F
        for <git@vger.kernel.org>; Fri,  2 Jun 2017 19:12:36 +0200 (CEST)
To:     git@vger.kernel.org
From:   Rene Pasing <rene@pasing.net>
Subject: Wrong gitattributes documentation?
Message-ID: <e7734a23-12b2-8f62-ab5c-c856d59e3010@pasing.net>
Date:   Fri, 2 Jun 2017 19:12:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have noticed a strange behaviour when using git-lfs.

If I understood correctly, git-lfs adds patterns to .gitattributes, for 
which git then calls lfs for any matches with this pattern.

The problem is, the documentation[1] says: "The rules how the pattern 
matches paths are the same as in .gitignore files; see gitignore[5].", 
so when I have a pattern like '/images/', it should match on all 
files+folders under /images, even the directory itself, right? Or when 
I'd use '/images/*', it should match on all files+folders under /images, 
right?

This does not seem to be the case. Nothing is done by lfs when using 
'/images/', and when using '/images/*', it only takes into account files 
which are directly in /images (so it doesnt take into account 
subdirectories).

The only solution to this (until now) is to use '/images/**/*', which 
seems to do exactly what I want (lfs gets executed for all files+folders 
under /images).

Is this expected behaviour? If yes, then the documentation of 
gitattributes seems incorrect to me. If not, can this be considered as a 
bug?

I found several complaints about this to git-lfs (or other projects 
relying on gitattributes), e.g. [2], but I didn't find anything about 
this regarding gitattributes itself.

Thanks for answers
Regards
Rene

PS: $ git --version
git version 2.1.4

[1] = https://git-scm.com/docs/gitattributes
[2] = https://github.com/git-lfs/git-lfs/issues/2068
