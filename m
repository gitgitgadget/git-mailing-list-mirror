Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46041F403
	for <e@80x24.org>; Mon, 18 Jun 2018 15:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932844AbeFRPzq (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 11:55:46 -0400
Received: from ikke.info ([178.21.113.177]:46882 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932630AbeFRPzq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 11:55:46 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 0630C4400C0; Mon, 18 Jun 2018 17:55:45 +0200 (CEST)
Date:   Mon, 18 Jun 2018 17:55:44 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     git@vger.kernel.org
Subject: Re: Adding nested repository with slash adds files instead of gitlink
Message-ID: <20180618155544.GB6958@alpha>
References: <20180618111919.GA10085@book.hvoigt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180618111919.GA10085@book.hvoigt.net>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 01:19:19PM +0200, Heiko Voigt wrote:

Now with cc to the mailing list.

> Hi,
> 
> I just discovered that when you have a slash at the end of a nested
> repository, the files contained in the repository get added instead of
> the gitlink.
> 
> I found this when I was adding a submodule and wanted to commit a small
> change before that. You get the slash by using tab autocompletion.
> 
> Here is a recipe to reproduce:
> 
> mkdir test
> cd test; git init
> touch a; git add a; git commit -m a
> mkdir ../test.git; (cd ../test.git; git init --bare)
> git remote add origin ../test.git
> git push origin master
> git submodule add ../test.git submodule
> git reset
> git add submodule/
> 
> Now instead of just submodule gitlink there is an entry for submodule/a
> in the index.
> 
> I just thought I put this out there. Will have a look if I find the time
> to cook up a proper testcase and investigate.
> 
> Cheers Heiko

This has been the case as far as I can remember, and is basically lore
in the #git irc channel).

This can also be reproduced by just cloning a repo inside another repo
and running `git add path/`.
