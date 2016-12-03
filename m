Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3821FBB0
	for <e@80x24.org>; Sat,  3 Dec 2016 07:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbcLCHtj (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Dec 2016 02:49:39 -0500
Received: from bsmtp.bon.at ([213.33.87.14]:12618 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751062AbcLCHti (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Dec 2016 02:49:38 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 3tW3805Jpcz5tlL;
        Sat,  3 Dec 2016 08:49:36 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id DC249140;
        Sat,  3 Dec 2016 08:49:35 +0100 (CET)
Subject: Re: git reset --hard should not irretrievably destroy new files
To:     Julian de Bhal <julian.debhal@gmail.com>
References: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
Cc:     git@vger.kernel.org
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <f2f8c7c9-cbe0-870d-3c13-fc928dd91dd1@kdbg.org>
Date:   Sat, 3 Dec 2016 08:49:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.0
MIME-Version: 1.0
In-Reply-To: <CAJZCeG1Eu+5DfaxavX_WGUCa+SY+yepDWZhPXxiFcV__h0xjrw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.12.2016 um 06:04 schrieb Julian de Bhal:
> If you `git add new_file; git reset --hard`, new_file is gone forever.

AFAIC, this is a feature ;-) I occasionally use it to remove a file when 
I already have git-gui in front of me. Then it's often less convenient 
to type the path in a shell, or to pointy-click around in a file browser.

> git add new_file

Because of this ...

> git add -p                       # also not necessary, but distracting
> git reset --hard                 # decided copy from backed up diff
> # boom. new_file is gone forever

... it is not. The file is still among the dangling blobs in the 
repository until you clean it up with 'git gc'. Use 'git fsck --lost-found':

--lost-found

     Write dangling objects into .git/lost-found/commit/ or 
.git/lost-found/other/, depending on type. If the object is a blob, the 
contents are written into the file, rather than its object name.

-- Hannes

