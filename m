Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418971F404
	for <e@80x24.org>; Wed, 28 Feb 2018 12:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeB1Mud (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 07:50:33 -0500
Received: from mail.aegee.org ([144.76.142.78]:49739 "EHLO mail.aegee.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752195AbeB1Muc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 07:50:32 -0500
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Wed, 28 Feb 2018 07:50:32 EST
Authentication-Results: aegeeserv.aegee.org; auth=pass (PLAIN) smtp.auth=didopalauzov
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.aegee.org w1SCkb6R017166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aegee.org; s=k4096;
        t=1519821998; i=dkim+MSA-tls@aegee.org; r=y;
        bh=Bcn+6gJkM0ypx2DQeSSbnCeErxuvhF+SumcXA2TPFvQ=;
        h=To:From:Subject:Date;
        b=c+gQiPNgPlNJEMRqGr43R6tHk8qKIdPWWQrtkNLYEUFg/0q58JozwX2DyIrfg1+Fq
         Rol3eXU0eN0PAkNtZNFfulEW/ejeSS8HQTP8L5nzzVllaTBRqIjbsnJvJvcPflLyqq
         AEOXKLhxzYLHnSKvAWl9VRv8zOxRyM6YcoWLaPKKZf7x+E/gPPSbx2CLzY/Ji6cmrF
         KEDfaA3hEEg4NzWfpJAI/TEHkGyGEMfQ/O5ABigeO3f3qt52NichSLgxEa2gBAXsRz
         i03WTk4RZaWHYd8OHvCTEqXncJAHbB2JwMYBFVGBJZgW2BIHbkGHTDShCC2XwlChL0
         x3tUPnlmFQ358kyfQsaIJwyVA+F0CEjbsIwFSIX4O0WE+qXUDdFt0z43MXCMusxplK
         ikdYB8THJaNJZspjSagySXwY7PbsgCJC/sHBHMTCM5ovtPqwbDU6VBlpfmRq/GkJP7
         a7EZ2+txm+LTfhdBeI03hj/vxJocOaDZffn3FKSXCAJsJlGPxb7WEKuJ3XObtJJlR6
         P9ORD2Tly6cHdXMTIdusr6IyVHwI1LxUOUEEl7ZwF+jmq/KDLDRKxfmLFknerO74C7
         msT5V8l5A1LZqAgNbw3H87HvUrNhS6l++y8+yt0jGl6TO8n3UdC7jZRPFXltyL11JX
         sqtyjR13E3tUjcZDziiWoXNI=
Authentication-Results: mail.aegee.org/w1SCkb6R017166; dkim=none
Received: from [10.128.8.92] (port-87-193-154-82.static.qsc.de [87.193.154.82])
        (authenticated bits=0)
        by mail.aegee.org (8.15.2/8.15.2) with ESMTPSA id w1SCkb6R017166
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 12:46:38 GMT
To:     git@vger.kernel.org
From:   =?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= 
        <dilyan.palauzov@aegee.org>
Subject: Worktree silently deleted on git fetch/gc/log
Message-ID: <aa98f187-4b1a-176d-2a1b-826c995776cd@aegee.org>
Date:   Wed, 28 Feb 2018 13:44:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.99.3 at mail.aegee.org
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

with git 2.16.2 I have two repositories:

A (branch master) and
B (branch g) which is a worktree of the first.

This has always forked fine until yesterday, when I did:

/git/B g>$ git fetch
remote: Counting objects: 29, done.
remote: Compressing objects: 100% (6/6), done.
remote: Total 29 (delta 19), reused 25 (delta 19), pack-reused 4
Unpacking objects: 100% (29/29), done.
 From https://...
    13e4c55a0..02655d5fb  g -> origin/g
    c37a3ca25..bc7888511  master -> origin/master
Auto packing the repository in background for optimum performance.
See "git help gc" for manual housekeeping.
/git/B g<>$ git log -p origin/g
fatal: Not a git repository: /git/A/.git/worktrees/B
/git/B$

Please note that on the second last prompt there is <>, so that git-prompt has found the neccessary information and this was this was later deleted - by 'gc' or 'log'.

I guess somebody who knows the code in detail can easily fix this.

What would be the procedure to restore the /git/A/.git/worktrees/B structure?

Kind regards
   Dilyan
