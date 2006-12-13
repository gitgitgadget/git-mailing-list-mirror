X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Using git-bisect to find more than one breakage
Date: Wed, 13 Dec 2006 09:34:04 -0500
Message-ID: <20061213143404.GA24132@fieldses.org>
References: <6280325c0612112034x373c8022q909ca192a866cfcf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 15:14:16 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Greylist: delayed 2395 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 10:14:01 EST
Content-Disposition: inline
In-Reply-To: <6280325c0612112034x373c8022q909ca192a866cfcf@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34222>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuVoA-00049O-2U for gcvg-git@gmane.org; Wed, 13 Dec
 2006 16:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965000AbWLMPOE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 10:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWLMPOD
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 10:14:03 -0500
Received: from mail.fieldses.org ([66.93.2.214]:38059 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S964993AbWLMPOB (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 10:14:01 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GuVBM-0006Mv-Ug; Wed, 13 Dec 2006
 09:34:04 -0500
To: n0dalus <n0dalus+redhat@gmail.com>
Sender: git-owner@vger.kernel.org

On Tue, Dec 12, 2006 at 03:04:29PM +1030, n0dalus wrote:
> This is what I tried to do:
> - Make a branch ("working") at the bad commit
> - Commit a patch to undo the bug-causing change from that commit
> - Make a copy of the master branch
> - git-rebase working
> - (Then if that worked, use git-bisect to find the next breakage)
> 
> I expected git-rebase to just apply all the commits from the master
> onto my working branch, possibly stopping in the case of a conflict to
> the file I patched. Instead, it produces large conflicts with
> unrelated files, on the very first commit it tries to apply. I even
> get the conflicts if the commit I make before using git-rebase changes
> no files at all (just adding an empty file 'test').
> 
> Is there something wrong with my method here? Is there another way to do 
> this?
> 
> I am thinking for now I will just use git-bisect between the bad
> commit and master, and apply my changes to every bisection.

Yes, that's the way to do it.

The git-rebase command is intended for rebasing small pieces of purely
linear history; I don't believe it will work well (at all?) to rebase a
large chunk of kernel history.

