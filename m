From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: git-svn error "Unable to extract revision information from commit
	...~1"
Date: Tue, 26 Jun 2007 16:09:17 -0300
Message-ID: <1182884957.16012.31.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 21:11:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3GRs-0007lN-CG
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 21:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759520AbXFZTL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jun 2007 15:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759605AbXFZTL3
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jun 2007 15:11:29 -0400
Received: from sumo.dreamhost.com ([66.33.216.29]:48615 "EHLO
	sumo.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758429AbXFZTL2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2007 15:11:28 -0400
Received: from spunkymail-a1.g.dreamhost.com (sd-green-bigip-207.dreamhost.com [208.97.132.207])
	by sumo.dreamhost.com (Postfix) with ESMTP id B02191864CC
	for <git@vger.kernel.org>; Tue, 26 Jun 2007 12:11:27 -0700 (PDT)
Received: from [127.0.0.1] (20151126079.user.veloxzone.com.br [201.51.126.79])
	by spunkymail-a1.g.dreamhost.com (Postfix) with ESMTP id E0E1EFFCD1
	for <git@vger.kernel.org>; Tue, 26 Jun 2007 12:10:23 -0700 (PDT)
X-Mailer: Evolution 2.8.2.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50970>

First of all, before I state the problems I am running into, I must say
that I loved git. It is easy to setup, since there is no need to
initialize a server or repository, powerful, because one can branch and
merge as needed something that was harder in others. And on top of
everything it is very easy to follow up the history with gitk. :-)

But not everything are flowers in my git-life. I have to use svn to
commit upstream, in fact there are two different upstream svn servers. I
tryied to maintain both coordinates using two git-svn repositories. But
there are ocasions that the git-svn repository gets into a state that
dcommit simply does not work anymore. :-( 

The problem seem to be that when I merge the head with another branch
git-svn does not know where to follow to meet the "svn trunk". So what
happens it that I have a head that was merged from a side track
development (usually rooted on the other svn server) and then it goes to
the wrong side. 

for instance : 

o master (merge commit) 17696dc402da59f8eba0dcd60f15a66859cb0c2a
|\
| o remotes/trunk svn head c0691ffaa3a41c6b5c13aec5b06b64f6321efd35
| |
o | mine local modifications f1494e9bb4c237253587c1ffdc150394c6813100
| | 
...

...

When I try to use dcommit the command fails to find the coorect path to
make and send the diffs. I saw that svn-git user uses git-rev-list to
make this path, but look at the list this command gives me : 

17696dc402da59f8eba0dcd60f15a66859cb0c2a
f1494e9bb4c237253587c1ffdc150394c6813100
c0691ffaa3a41c6b5c13aec5b06b64f6321efd35

the problem is that the last element is not a git-svn commit and the
tool simply whants him to be son of a git-svn commit, this is the commit
that goes "f1494e9bb4c237253587c1ffdc150394c6813100", an it is not on
the last position as expected.

Got searchs for metadata in the wrong place and "boom" break... I don't
know how to rever into a sane state, nor how can I avoid to get into
this situatiom, since I havo not yet found a clear reason on how this
came to be. 
