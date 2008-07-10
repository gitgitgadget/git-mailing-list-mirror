From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Errors importing Apache Synapse SVN using Git
Date: Thu, 10 Jul 2008 14:59:11 +0200
Message-ID: <g55130$n3i$1@ger.gmane.org>
References: <4875F5D6.9080906@wso2.com> <4875FA23.30603@wso2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 10 15:00:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGvl1-00015i-FS
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 15:00:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754144AbYGJM7Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 08:59:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751167AbYGJM7Z
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 08:59:25 -0400
Received: from main.gmane.org ([80.91.229.2]:48690 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754033AbYGJM7Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 08:59:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KGvk1-0004vd-O7
	for git@vger.kernel.org; Thu, 10 Jul 2008 12:59:21 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 12:59:21 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 10 Jul 2008 12:59:21 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <4875FA23.30603@wso2.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87971>

Asankha C. Perera venit, vidit, dixit 10.07.2008 14:01:
> Hi All
> 
> I am an Apache Synapse developer, and want to import the Synapse SVN 
> repo into Git, so that Ohloh can properly get the Synapse history 
> (http://www.ohloh.net/topics/1326?page=1#post_6287)
> 
> However, when I try the command: "git svn clone --trunk=trunk 
> --tags=tags --branches=branches http://svn.apache.org/repos/asf/synapse" 
> it seems to take forever, (or at least until the next network glitch), 
> and keeps filling up a file with just plain zeros ("0") : 
> ./.git/svn/trunk/.rev_db.13f79535-47bb-0310-9956-ffa450edef68
> 
> Can someone try the above command on the Synapse repo and tell me what I 
> can do to import from the SVN?

"svn log" takes forever on that repo, too. Current rev seems to be 
675546, and the synapse path does not exist in early revisions. Knowing 
the initial revision would help, then you could save "git svn" from 
having to comb through (supposedly) tens of thousands of irrelevant revs.

I just checked out trunk using svn 1.4.6, "svn log ." takes forever in 
the root dir. So the svn repo seems to be largely unusable, at least 
when accessed from svn 1.4.6 clients (the server is 1.5.0, I see).

Okay, I bisected it and got r234477 as the beginning of time for 
synapse. "svn log -r 234477:HEAD" is still painful.

You may want to fetch 1000 revs each or so from there each time.

Michael
