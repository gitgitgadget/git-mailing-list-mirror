Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBA3B20401
	for <e@80x24.org>; Tue, 27 Jun 2017 14:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752691AbdF0Oe1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 10:34:27 -0400
Received: from ser-smtp-vm-1.dakosy.de ([195.244.0.87]:50242 "EHLO
        ser-smtp-vm-1.dakosy.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751508AbdF0OeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 10:34:18 -0400
Received: from [10.7.2.114] (helo=ser-smtpdak-vm-1.dakosy.de)
        by ser-smtp-vm-1.dakosy.de with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <neuling@dakosy.de>)
        id 1dPrZH-0003H1-MG
        for git@vger.kernel.org; Tue, 27 Jun 2017 16:34:15 +0200
Received: from daktales1.dakosy.de ([10.7.2.20])
        by ser-smtpdak-vm-1.dakosy.de with esmtp (Exim 4.82)
        (envelope-from <neuling@dakosy.de>)
        id 1dPrZH-0001PP-Fp
        for git@vger.kernel.org; Tue, 27 Jun 2017 16:34:15 +0200
To:     git@vger.kernel.org
MIME-Version: 1.0
Subject: Bug: Since Git 2.13.2 git rebase autostash doesn't use fast-forward (poor
 performance)
X-KeepSent: 6AC13578:F02B79FA-C125814C:004DD247;
 type=4; name=$KeepSent
Message-ID: <OF6AC13578.F02B79FA-ONC125814C.004DD247-C125814C.00500A93@dakosy.de>
From:   neuling@dakosy.de
Date:   Tue, 27 Jun 2017 16:34:15 +0200
Content-Type: text/plain; charset="US-ASCII"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, 

since the latest version 2.13.2 "git pull --rebase --autostash" doesn't 
use a fast forward if possible. 

My global git config contains "pull.rebase=preserve" and 
"rebase.autostash=true". My working directory is clean with no changes. 

When I use "git pull" git doesn't use a possible fast forward merge. If I 
remove "rebase.autostash" from my git config a fast forward merge will 
take place. 

If a fast forward merge is possible and the working directory is clean 
autostash should do nothing and the fast forward merge should happen. 

Is it also possible to implement autostash on fast forward merge that way 
to stash changes, do the fast forward merge and at least to apply the 
stashed changes?

Another problem is if "git pull rebase" without autostash can do a fast 
forward merge the rebase validation for changed files in my working 
directory will be done. 

I think in that case the fast forward merge validation should run. That 
would prevent the need to stash local changes if they do not affect files 
of the commits to fast forward from origin branch. 



Regards, 
Mattias

