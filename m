Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 942A3EB64DC
	for <git@archiver.kernel.org>; Sat, 15 Jul 2023 04:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjGOEhF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Jul 2023 00:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGOEhD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Jul 2023 00:37:03 -0400
X-Greylist: delayed 614 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 21:37:01 PDT
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB45B30E5
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 21:37:01 -0700 (PDT)
Received: from [192.168.5.3] (c-73-202-23-161.hsd1.ca.comcast.net [73.202.23.161])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 36F4Qlc6012285
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 21:26:47 -0700 (PDT)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-202-23-161.hsd1.ca.comcast.net [73.202.23.161] claimed to be [192.168.5.3]
Message-ID: <fe3c68d5-124e-5a87-881a-21ad8e492f76@tsoft.com>
Date:   Fri, 14 Jul 2023 21:26:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: Pressing Ctrl-C during 'git checkout <branch-name>' messes up the
 repository
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It stops in some intermediate state, and git still says that it is on 
the main branch, but 'git checkout' deletes files that were added only 
in the main branch,

'git reset --hard HEAD' fixes the main branch, bit now it is impossible 
to switch to the other branch because it says that "some files would be 
overwritten", which shouldn't be the case.


All operations should be atomic.

When the user presses Ctrl-C, the correct action would be to cleanly 
return to the initial branch.


git-2.41.0


Thanks,

Yuri


