From: Antony Male <antony.male@gmail.com>
Subject: Suggestion: git fetch <remote> <branch> to update remote-tracking
 branch
Date: Mon, 05 Mar 2012 16:45:53 +0000
Message-ID: <4F54EDC1.80608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 05 17:52:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4b8p-0006pg-2f
	for gcvg-git-2@plane.gmane.org; Mon, 05 Mar 2012 17:52:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab2CEQwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Mar 2012 11:52:01 -0500
Received: from woodbine.london.02.net ([87.194.255.145]:46760 "EHLO
	woodbine.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754106Ab2CEQwA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2012 11:52:00 -0500
X-Greylist: delayed 364 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Mar 2012 11:52:00 EST
Received: from [192.168.1.71] (87.194.161.58) by woodbine.london.02.net (8.5.140)
        id 4EEB6474051FE0A5 for git@vger.kernel.org; Mon, 5 Mar 2012 16:45:55 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192252>

Hi all,

First off, this is a very tentative suggestion.  It would result in a 
slight change to established behaviour, which I'm well aware could be a 
Bad Thing(tm).  However, I was encouraged by a number of people on #git 
to make it anyway, so here goes.

The issue is this: the two-argument form of 'git fetch' (e.g. 'git fetch 
<remote> <branch>') fetches the named ref into FETCH_HEAD, but does not 
update the related remote-tracking branch.  While this is intuitive 
behaviour when <remote> is a URL, we see a lot of git beginners 
attempting to run 'git fetch origin branch' and being confused when 
origin/branch isn't updated.  Similarly, 'git pull origin master' will, 
in a simple case, fast-forward the local master but not origin/master.

My suggestion, therefore, is to modify the behaviour of 'git fetch' such 
that 'git fetch <remote> <branch>' will update both FETCH_HEAD and the 
relevant remote-tracking branch, when <remote> is the name of a 
configured remote and <branch> contains only the src part of the 
refspec.  The behaviour would not change when <remote> was a URL or 
path, or when a <src>:<dst> refspec was used.

Of course, it would be desirable to be able to replicate the existing 
behaviour.  Currently, I don't have any good suggestions, although there 
may be an existing trick I'm missing.  Possible suggestions might be 
'git fetch <remote> <branch>:FETCH_HEAD' or 'git fetch <remote> 
<branch>:', or maybe a new flag?

What do people think?

Many thanks for your time and consideration,
Antony Male
