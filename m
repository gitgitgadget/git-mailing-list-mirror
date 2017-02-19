Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BDCCE201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 21:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbdBSVUE (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 16:20:04 -0500
Received: from 5.itsy.de ([188.40.84.14]:47842 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751067AbdBSVUE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 16:20:04 -0500
X-Greylist: delayed 407 seconds by postgrey-1.27 at vger.kernel.org; Sun, 19 Feb 2017 16:20:04 EST
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 009E364491
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 22:12:28 +0100 (CET)
To:     git@vger.kernel.org
From:   Toolforger <toolforger@durchholz.org>
Subject: url.<base>.insteadOf vs. submodules
Message-ID: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
Date:   Sun, 19 Feb 2017 22:12:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I am trying to make url.<base>.insteadOf work on the URLs inside 
.gitmodules, but it won't work (applying it to the repo itself works 
fine, to the config setting seems to be fine).

I do not want to modify .gitmodules: It is maintained upstream.

I cannot simply reconfigure submodule.<module>.url: the Configure script 
(regularly called during each compile) does
   git submodule sync
   git submodule update --init
I could tell upstream to change these commands if I can make a good 
argument; for them, it is relevant that they can change the submodule 
URL inside .gitmodule and have it "just work" for everybody downstream.

My own use case is that I want to be able to work with various 
experimental local clones even if I do not have Internet access.
I'm all ears if there's a way to do this without using insteadOf.


Here are the relevant two lines from the output of "git config -l" 
(after "git submodule init"):

url./home/jo/Projekte/perl6/bare-repos.insteadof=https://github.com
submodule.3rdparty/dynasm.url=https://github.com/MoarVM/dynasm.git


Here is what "git submodule update" does:

Cloning into '3rdparty/dyncall'...
fatal: unable to access 'https://github.com/MoarVM/dyncall.git/': Could 
not resolve host: github.com
fatal: clone of 'https://github.com/MoarVM/dyncall.git' into submodule 
path '3rdparty/dyncall' failed


Any help appreciated!

Regards,
Jo
