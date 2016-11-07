Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FB7F2021E
	for <e@80x24.org>; Mon,  7 Nov 2016 04:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751645AbcKGELn (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 23:11:43 -0500
Received: from ozlabs.org ([103.22.144.67]:46127 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751503AbcKGELm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 23:11:42 -0500
Received: by ozlabs.org (Postfix, from userid 1003)
        id 3tBzXX6WcXz9vG3; Mon,  7 Nov 2016 15:11:40 +1100 (AEDT)
Date:   Mon, 7 Nov 2016 15:11:38 +1100
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Markus Hitter <mah@jump-ing.de>
Cc:     Stefan Beller <sbeller@google.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: gitk: avoid obscene memory consumption
Message-ID: <20161107041138.rnlzyuacoezsfwif@oak.ozlabs.ibm.com>
References: <47c374cf-e6b9-8cd3-ee0d-d877e9e96a62@jump-ing.de>
 <CAGZ79kbavzGJ2sAcz5heg+BO+tZ=TgtrhxMH1-kqeJUpNNavyw@mail.gmail.com>
 <20161105110845.GA4039@fergus.ozlabs.ibm.com>
 <ff5bb36b-e30c-3998-100d-789b4b5e7249@jump-ing.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff5bb36b-e30c-3998-100d-789b4b5e7249@jump-ing.de>
User-Agent: NeoMutt/20161014 (1.7.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 06, 2016 at 11:28:37AM +0100, Markus Hitter wrote:
> 
> Thanks for the positive comments.
> 
> TBH, the more I think about the problem, the less I'm satisfied with the solution I provided. Including two reasons:
> 
> - The list of files affected to the right is still complete and clicking a file name further down results in nothing ... as if the file wasn't part of the diff.
> 
> - Local searches. Cutting off diffs makes them unreliable. Global searches still work, but actually viewing a search result in the skipped section is no longer possible.
> 
> So I'm watching out for better solutions. So far I can think of these:
> 
> - Storing only the actually viewed diff. It's an interactive tool, so there's no advantage in displaying the diff in 0.001 seconds over viewing it in 0.1 seconds. As far as I can see, Gitk currently stores every diff it gets a hold of forever.

It does?  That would be a bug. :)

> 
> - View the diff sparsely. Like rendering only the actually visible portion.
> 
> - Enhancing ctext. This reference diff has 28 million characters, so there should be a way to store this with color information in, let's say, 29 MB of memory.

Tcl uses Unicode internally, I believe, so 57MB, but yes.

Paul.
