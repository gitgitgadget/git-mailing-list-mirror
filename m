Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 288FA201B3
	for <e@80x24.org>; Tue, 21 Feb 2017 05:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751326AbdBUFMQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 00:12:16 -0500
Received: from 5.itsy.de ([188.40.84.14]:46258 "EHLO 5.itsy.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751056AbdBUFLz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 00:11:55 -0500
Received: from [192.168.0.13] (84-72-0-73.dclient.hispeed.ch [84.72.0.73])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by 5.itsy.de (Postfix) with ESMTPSA id 31CC164491;
        Tue, 21 Feb 2017 06:11:52 +0100 (CET)
Subject: Re: url.<base>.insteadOf vs. submodules
To:     Jeff King <peff@peff.net>
References: <84fcb0bd-85dc-0142-dd58-47a04eaa7c2b@durchholz.org>
 <20170220090115.6kfzwl62opj4q7k7@sigill.intra.peff.net>
 <404d109f-e5a7-85a3-e64c-ab1b21c3045d@durchholz.org>
 <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
Cc:     git@vger.kernel.org
From:   Toolforger <toolforger@durchholz.org>
Message-ID: <28fb85d4-89cd-1f32-3063-2f48d8b935be@durchholz.org>
Date:   Tue, 21 Feb 2017 06:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20170220205243.lynnmxouwq7jelld@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.02.2017 21:52, Jeff King wrote:
 > I think if there is a doc bug, it is that the repo boundary between the
 > submodule and the super-project is not made more clear.

It's not mentioned anywhere I'm aware of, particularly not on the 
insteadOf docs.

 > That said, I do think it would be a useful feature for the super-project
 > to rewrite URLs before handing them off to the submodule. But I do not
 > really work on submodules nor use them myself, so there may be
 > complications.

Agreed.

 > I suppose you could argue that failing to rewrite violates the "any" in
 > the quoted text. It doesn't say when the rewriting occurs, but it is
 > essentially "when the URL is accessed". So the super-project feeds the
 > raw URL to the submodule `git clone`, which then applies any URL
 > rewriting.



 >>> but one workaround is to set the config in ~/.gitconfig.
 >>
 >> No can do - that's under version control.
 >> My personal setup does not belong there I think ;-)
 >
 > I'm not sure I understand. You have a project policy to use certain
 > URLs. But you, the user, want to override that. Why isn't the
 > user-specific config file the right place to put that?

Ah right, I mistook ~/ for "project root" instead of "home dir".
Sorry for the confusion.

 > (I think there _is_ a mismatch, in that the change is specific not just
 > to your user, but to the repo. So you would not want to rewrite other
 > references to the same URL in other repos.

Indeed, and that's actually a problem.

The setup I'm aiming for is
   github -> local bare repo -> local clones with worktrees

If I place insteadOf rules in ~/.gitconfig, I will be unable to pull 
from github to my local bare repos.
Mmm... I could try to undo the insteadOf configuration from ~/.gitconfig 
in the local bare repos. Not sure whether I have to redirect from the 
github URL to itself.

Downside is that I'll have to remember to modify ~/.gitconfig whenever 
the upstream project changes its dependencies. Or whenever I want to 
reorganize my local project directory structure.
It's not totally out of the window, but right now it does not seem very 
attractive to me, and it's certainly not a good solution for everyone.

Regards,
Jo
