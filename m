Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04D491FF40
	for <e@80x24.org>; Sat, 25 Jun 2016 07:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbcFYH3w (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 03:29:52 -0400
Received: from [104.236.5.163] ([104.236.5.163]:44150 "EHLO brennie.ca"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751166AbcFYH3w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 03:29:52 -0400
Received: from [192.168.1.38] (142-165-34-81.sktn.hsdb.sasknet.sk.ca [142.165.34.81])
	by brennie.ca (Postfix) with ESMTPSA id 38297400DC;
	Sat, 25 Jun 2016 01:29:50 -0600 (CST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] builtin/worktree.c: add option for setting worktree name
From:	Barret Rennie <barret@brennie.ca>
In-Reply-To: <576E2FA9.7070008@kdbg.org>
Date:	Sat, 25 Jun 2016 01:29:49 -0600
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, Michael Rappazzo <rappazzo@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <6FF436EC-65BE-472A-A347-1E0DCD7526AF@brennie.ca>
References: <20160625051548.95564-1-barret@brennie.ca> <576E2FA9.7070008@kdbg.org>
To:	Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

> What is "the name for the worktree"? Is it the directory where it lives in?
>Is it how it is listed with 'git worktree list'?

The name of the worktree is the name of the created directory in
`.git/worktrees`.

> How is --name different from the <path> argument?

Currently, if you run:
	
	git worktree add /my/worktree/checkout <branch>

you get a worktree "named" checkout, i.e., `.git/worktrees/checkout`. The
idea with this patch is to allow you use a more specific name when you would
otherwise have mulitiple worktrees of the form `checkout`, `checkout1`, etc.

That is, you could do

	git worktree add --name branch1 /worktrees/branch1/src branch1
	git worktree add --name branch2 /worktrees/branch2/src branch2
	git worktree add --name branch3 /worktrees/branch3/src branch3

and have `.git/worktrees/branch1`, `.git/worktrees/branch2` and
`.git/worktrees/branch3` instead of `.git/worktrees/src`,
`.git/worktrees/src1`, `.git/worktrees/src2`. That way, it becomes more clear
when poking inside `.git/worktrees` which directory points to which checkout.

Perhaps "worktree name" isn't the most clear nomenclature for this feature.
Would "worktree directory name" be better?
