Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0ED6B1F829
	for <e@80x24.org>; Wed,  3 May 2017 18:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbdECSjy convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 3 May 2017 14:39:54 -0400
Received: from smtp2-g21.free.fr ([212.27.42.2]:15493 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751981AbdECSjw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 14:39:52 -0400
Received: from cayenne.localnet (unknown [IPv6:2a01:e35:2ef1:f910:5006:1621:c385:7777])
        by smtp2-g21.free.fr (Postfix) with ESMTPS id 96D7E2003F6;
        Wed,  3 May 2017 20:39:50 +0200 (CEST)
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] read-tree.c: rework UI when merging no trees
Date:   Wed, 03 May 2017 20:39:50 +0200
Message-ID: <3080937.1HJCWGH9Pz@cayenne>
User-Agent: KMail/5.2.3 (Linux/4.9.0-2-amd64; KDE/5.28.0; x86_64; ; )
In-Reply-To: <20170503170401.GA28740@aiede.svl.corp.google.com>
References: <20170503162931.30721-1-jn.avila@free.fr> <20170503162931.30721-3-jn.avila@free.fr> <20170503170401.GA28740@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="iso-8859-1"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mercredi 3 mai 2017, 10:04:01 CEST Jonathan Nieder a écrit :
> Hi,
> 
> Jean-Noel Avila wrote:
> > Subject: read-tree.c: rework UI when merging no trees
> 
> nit: this is about user-facing behavior, not an implementation detail,
> so the part before the colon can be the command that changed
> (read-tree:).
> 
> nit: the word "rework" is dangerous in a commit message in the same
> way as the word "fix" --- it stands for "make better", in a vague way
> that leaves the reader guessing about how.  Usually a more specific
> description can work better.
> 

In fact, this patch is two fold:

 * reword the question in the die() call. I realize now that when passed to 
die(), the string is prepended with "fatal:". That's an hint that the question 
does not require a reply, but  ruling out any doubt would be better.
 * rework the local logic which was inherited from history. This is 
functionally equivalent to the previous version, just cleaner.

> > The initial test was inherited from a previous commit, but it is no
> > longer needed, given the following switch case. Moreover, the question
> > sentence ending the program has been replace by an assertative one.
> > 
> > Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
> 
> This can have a simpler, short-and-sweet motivation:
> 
> 	read-tree -m: make error message for merging 0 trees less smart-alecky
> 
> 	"git read-tree -m" requires a tree argument to name the tree to be
> 	merged in.  Git uses a cutesy error message to say so and why:
> 
> 		$ git read-tree -m
> 		warning: read-tree: emptying the index with no arguments is deprecated;
> use --empty fatal: just how do you expect me to merge 0 trees?
> 		$ git read-tree -m --empty
> 		fatal: just how do you expect me to merge 0 trees?
> 
> 	When lucky, that could produce an ah-hah moment for the user, but it's
> 	more likely to irritate and distract them.
> 
> 	Instead, tell the user plainly that the tree argument is required. Also
> 	document this requirement in the git-read-tree(1) manpage where there is
> 	room to explain it in a more straightforward way.
> 

Thank you very much for this message! May I s-o-b you?

As hinted, I'll add the documentation part. ;-)

> Unfortunately both 'git read-tree -h' and 'git read-tree --help' say nothing
> about this.  Ideas for wording there?

Next pach series will propose this.

> 
> Thanks and hope that helps,
> Jonathan


