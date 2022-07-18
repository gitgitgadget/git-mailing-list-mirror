Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F674C43334
	for <git@archiver.kernel.org>; Mon, 18 Jul 2022 20:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiGRUqr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Jul 2022 16:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbiGRUqq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jul 2022 16:46:46 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6927669
        for <git@vger.kernel.org>; Mon, 18 Jul 2022 13:46:46 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 6E9233F4813;
        Mon, 18 Jul 2022 16:46:45 -0400 (EDT)
Received: from jeffhost-mbp.lan (unknown [74.205.145.90])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3DFF23F4808;
        Mon, 18 Jul 2022 16:46:45 -0400 (EDT)
Subject: Re: Possible git bug when working with Microsoft Mapped drives
To:     paul@kinzelman.com, git@vger.kernel.org
References: <f946c577-d3d6-212c-cec5-a6c63856b77d@kinzelman.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b5931787-3589-102f-cfeb-caeb8a07e149@jeffhostetler.com>
Date:   Mon, 18 Jul 2022 16:46:44 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <f946c577-d3d6-212c-cec5-a6c63856b77d@kinzelman.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.09 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/18/22 4:28 PM, Paul Kinzelman wrote:
> I'm using git version 2.37.1.windows.1 and Windows 10
> 
> I've got two systems which are miles apart and so are not on the same
> LAN, and I have connected them together using the ui.com VPN and M$
> RDP/TSclient. I mapped each system's C: drive to be accessed by the
> other system as Drive X: and I can transfer files back and forth
> initiated on each system.
> 
> I can also see all the repository files on the source system, including
> the tree of files under the .git directory. Note I had to unhide the
> .git folder so that I could see that folder from the other system.
> 
> However, when I run 'git clone' on one system to get the repository from
> the other system, git seems to think the repository on the other
> system is empty when it's not. As I said, I can even do a directory
> and see all the other files.
> 
> Any suggestions would be appreciated. Thanks!
> -Paul Kinzelman, Peralta NM
> 

I can't duplicate your setup, so I'll just speculate out loud
here.  I have to wonder if the "X:" drive letters are tricking
Git to thinking that the remote instance is actually local and
Git is trying to use some shortcuts. (For example, it might
hardlink them rather than copy them on Linux.)

So I'm wondering if "--no-local" or "--no-hardlinks" or using
a file URL rather than a pathname might make it behave differently.

Again, this is just a guess.

There are also some GIT_TRACE* environment variables that might
be helpful if the above doesn't help.

Jeff

https://git-scm.com/docs/git-clone

