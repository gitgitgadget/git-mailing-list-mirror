Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F8D20705
	for <e@80x24.org>; Thu,  7 Jul 2016 20:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753248AbcGGUsD (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 16:48:03 -0400
Received: from avasout05.plus.net ([84.93.230.250]:43324 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753044AbcGGUrt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 16:47:49 -0400
X-Greylist: delayed 459 seconds by postgrey-1.27 at vger.kernel.org; Thu, 07 Jul 2016 16:47:49 EDT
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id Fwg21t0042iA9hg01wg3EP; Thu, 07 Jul 2016 21:40:09 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=V/4/6qvi c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=kj9zAlcOel0A:10 a=cAmyUtKerLwA:10 a=dMx-NngESggTrVm4eVcA:9
Received: from charles by hashpling.plus.com with local (Exim 4.84_2)
	(envelope-from <charles@hashpling.org>)
	id 1bLG5a-00051F-Is; Thu, 07 Jul 2016 21:40:02 +0100
Date:	Thu, 7 Jul 2016 21:40:02 +0100
From:	Charles Bailey <charles@hashpling.org>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: What's cooking in git.git (Jul 2016, #02; Wed, 6)
Message-ID: <20160707204002.GA19138@hashpling.org>
References: <xmqqr3b6qwdt.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr3b6qwdt.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jul 06, 2016 at 02:39:26PM -0700, Junio C Hamano wrote:
> * nd/ita-cleanup (2016-07-01) 3 commits
>   (merged to 'next' on 2016-07-06 at f15aeba)
>  + grep: fix grepping for "intent to add" files
>  + t7810-grep.sh: fix a whitespace inconsistency
>  + t7810-grep.sh: fix duplicated test name
> 
>  Git does not know what the contents in the index should be for a
>  path added with "git add -N" yet, so "git grep --cached" should not
>  show hits (or show lack of hits, with -L) in such a path.  But we
>  did by mistake, which has been corrected.
> 
>  Will merge to 'master'.

I just wanted to clarify what was actually fixed. The actual bug that
was reported and fixed was the fact that 'git grep' (without --cached)
wasn't searching the contents of files in the working tree if the index
entry had the "intent to add" bit set.

My original proposed fix (reversion of the commit that introduced this
change) caused the re-introduction of behaviour where "i-to-a" files
would be reported with -L --cached which wasn't desired. I think because
we spent most of our energy and discussion on fixing this in a better
way we've lost the intent of the original patch.
