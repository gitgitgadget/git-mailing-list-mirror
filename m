From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [Newbie] How to *actually* get rid of remote tracking branch?
Date: Tue, 13 Nov 2007 15:53:52 +0100
Organization: At home
Message-ID: <fhcdpv$9u3$1@ger.gmane.org>
References: <874pfq9q8s.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 13 16:03:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrxId-0004jV-IH
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 16:03:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166AbXKMPDT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 10:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751799AbXKMPDT
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 10:03:19 -0500
Received: from main.gmane.org ([80.91.229.2]:42321 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750776AbXKMPDS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 10:03:18 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IrxDV-0001a1-27
	for git@vger.kernel.org; Tue, 13 Nov 2007 14:58:17 +0000
Received: from abvw125.neoplus.adsl.tpnet.pl ([83.8.220.125])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 14:58:17 +0000
Received: from jnareb by abvw125.neoplus.adsl.tpnet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 13 Nov 2007 14:58:17 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: abvw125.neoplus.adsl.tpnet.pl
Mail-Copies-To: Jakub Narebski <jnareb@gmail.com>
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64806>

[Cc: Sergei Organov <osv@javad.com>, git@vger.kernel.org]
Please CC git mailing list, git@vger.kernel.org

Sergei Organov wrote:

> Hello,
> 
> I want to get rid of origin/pu remote tracking branch. What do I do? I
> RTFM git-branch. What does it suggest?
> 
> git branch -d -r origin/pu
> 
> So far so good. However, it doesn't seem to work in practice:
 

> $ git branch -d -r origin/pu
> Deleted remote branch origin/pu.
> $ git remote show origin
> * remote origin
>   URL: git://git.kernel.org/pub/scm/git/git.git
>   Remote branch(es) merged with 'git pull' while on branch master
>     master
>   New remote branches (next fetch will store in remotes/origin)
>     pu
>   ^^^^^^^^^^^^^^^^^^^ What???  
>   Tracked remote branches
>     html maint man master next todo

Check out what do you have in .git/config file, in the [remote "origin"]
section. Most probably (if you cloned this repository using new enough git)
you have wildcard refspec there, which means that git would pick all new
branches when fetching / pulling from given repository. The wildcard
refspec is not documented adequately, so I'm not sure if adding

        fetch = !refs/heads/pu

would help, or do you have to replace wildcard refspec by explicit list of
branches you want to fetch.

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
