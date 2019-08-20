Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 947381F461
	for <e@80x24.org>; Tue, 20 Aug 2019 17:46:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbfHTRq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 13:46:56 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:58599 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729827AbfHTRq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 13:46:56 -0400
Received: from localhost (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5DBBB240003;
        Tue, 20 Aug 2019 17:46:54 +0000 (UTC)
Date:   Tue, 20 Aug 2019 23:16:40 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Leam Hall <leamhall@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Only track built files for final output?
Message-ID: <20190820174640.n3elekpi6l4vwamp@localhost.localdomain>
References: <477295c5-f817-e32b-04fd-a41ddfbbac0a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <477295c5-f817-e32b-04fd-a41ddfbbac0a@gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/08/19 08:21AM, Leam Hall wrote:
> Hey all, a newbie could use some help.
> 
> We have some code that generates data files, and as a part of our build
> process those files are rebuilt to ensure things work. This causes an issue
> with branches and merging, as the data files change slightly and dealing
> with half a dozen merge conflicts, for files that are in an interim state,
> is frustrating. The catch is that when the code goes to the production
> state, those files must be in place and current.
> 
> We use a release branch, and then fork off that for each issue. Testing, and
> file creation, is a part of the pre-merge process. This is what causes the
> merge conflicts.
> 
> Right now my thought is to put the "final" versions of the files in some
> other directory, and put the interim file storage directory in .gitignore.
> Is there a better way to do this?
> 

My philosophy with Git is to only track files that I need to generate 
the final product. I never track the generated files, because I can 
always get to them via the tracked "source" files.

So for example, I was working on a simple parser in Flex and Bison. Flex 
and Bison take source files in their syntax, and generate a C file each 
that is then compiled and linked to get to the final binary. So instead 
of tracking the generated C files, I only tracked the source Flex and 
Bison files. My build system can always get me the generated files.

So in your case, what's wrong with just tracking the source files needed 
to generate the other files, and then when you want a release binary, 
just clone the repo, run your build system, and get the generated files?  
What benefit do you get by tracking the generated files?

-- 
Regards,
Pratyush Yadav
