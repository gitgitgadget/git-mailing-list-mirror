From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 09:53:01 +0200
Organization: At home
Message-ID: <e085ka$ig9$1@sea.gmane.org>
References: <20060326014946.GB18185@pasky.or.cz> <7virq1sywj.fsf@assigned-by-dhcp.cox.net> <e06fl8$p9f$1@sea.gmane.org> <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org> <e06hts$1ne$1@sea.gmane.org> <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org> <e0827k$7tk$1@sea.gmane.org> <Pine.LNX.4.62.0603262337580.26865@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Mon Mar 27 10:04:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNmff-0007TO-1N
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 10:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbWC0IBs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 03:01:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750811AbWC0IBr
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 03:01:47 -0500
Received: from main.gmane.org ([80.91.229.2]:10887 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750813AbWC0IBr (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Mar 2006 03:01:47 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FNmbd-00067P-Re
	for git@vger.kernel.org; Mon, 27 Mar 2006 09:57:41 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Mar 2006 09:57:41 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Mar 2006 09:57:41 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18077>

David Lang wrote:

> On Mon, 27 Mar 2006, Jakub Narebski wrote:
> 
>> 2.) Caching the results of similarity algorithm/rename detection tool
>> (also Paul Jakma post), including remembering false positives and
>> undetected renames, for efficiency. Calculated automatically parts might
>> be throw-away.
> 
> this sounds like it could easily devolve into a O(n!) situation where you
> are cacheing how everything is related (or not related) to everything
> else. Paul was makeing the point that the purpose was to cache the data to
> eliminate the time needed to calculate it, but if you don't store all the
> results then you don't know if the result is not relavent, or unknown, so
> you need to calculate it again.

First of all, you only remember non-trivial relations (i.e. file.c is always
related to file.c). If the cache would be only for commits, it would be
O(c*p*n), where c is number of commits, p is percentage of contents moving
("renames") times percent of files changed in the commit, and n is the
number of files, probably O(c) practically. Even if we remember for all
(tree1,tree2) pairs it would be O(c^2). Additionally cache can be limited
in size (pruning oldest cache).  

-- 
Jakub Narebski
Warsaw, Poland
