From: Michael J Gruber <michaeljgruber+gmane@fastmail.fm>
Subject: Re: Errors importing Apache Synapse SVN using Git
Date: Fri, 11 Jul 2008 13:54:55 +0200
Message-ID: <48774A0F.2070805@fastmail.fm>
References: <4875F5D6.9080906@wso2.com> <4875FA23.30603@wso2.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 11 13:56:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHHEX-0008LX-AZ
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 13:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754328AbYGKLzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 07:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752483AbYGKLzR
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 07:55:17 -0400
Received: from main.gmane.org ([80.91.229.2]:45036 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753301AbYGKLzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 07:55:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KHHDR-0000Pn-UB
	for git@vger.kernel.org; Fri, 11 Jul 2008 11:55:09 +0000
Received: from whitehead.math.tu-clausthal.de ([139.174.44.12])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 11:55:09 +0000
Received: from michaeljgruber+gmane by whitehead.math.tu-clausthal.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 11 Jul 2008 11:55:09 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: whitehead.math.tu-clausthal.de
User-Agent: Thunderbird 2.0.0.14 (X11/20080421)
In-Reply-To: <4875FA23.30603@wso2.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88108>

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

Okay, besides the zero offset, there seems to be big problem with the 
svn repo:

svn list -r 234478 http://svn.apache.org/repos/asf/synapse
branches/
site/
tags/
trunk/

svn list -r 234478 http://svn.apache.org/repos/asf|grep synapse

Right, nothing returned.

git-svn insists on using http://svn.apache.org/repos/asf as the base 
URL, which is basically correct, but doesn't work for this repo.

Even editing .git/config and .git/svn/metadata (after git svn init, 
befire the first fetch) to change the url doesn't help. git svn still 
uses .../asf. Is this as intended? cc'ing the git svn author.

Michael
