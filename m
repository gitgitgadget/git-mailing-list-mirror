From: Charles O'Farrell <charleso@gmail.com>
Subject: Re: Import ClearCaase with history?
Date: Wed, 31 Mar 2010 12:16:09 +0000 (UTC)
Message-ID: <loom.20100331T135240-261@post.gmane.org>
References: <1270035189.2785.11.camel@chumley>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 31 14:20:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwwuE-0007mR-7a
	for gcvg-git-2@lo.gmane.org; Wed, 31 Mar 2010 14:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932686Ab0CaMUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Mar 2010 08:20:13 -0400
Received: from lo.gmane.org ([80.91.229.12]:52626 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932657Ab0CaMUL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Mar 2010 08:20:11 -0400
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Nwwtv-0007cm-UH
	for git@vger.kernel.org; Wed, 31 Mar 2010 14:20:07 +0200
Received: from 203-214-44-56.dyn.iinet.net.au ([203.214.44.56])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 14:20:03 +0200
Received: from charleso by 203-214-44-56.dyn.iinet.net.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 31 Mar 2010 14:20:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 203.214.44.56 (Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/533.3 (KHTML, like Gecko) Chrome/5.0.356.2 Safari/533.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143669>

Hi David,

> I've seen programs that purport to import Subversion (which is also
> good, as they also are using Subversion for other projects....) but do
> any such programs exist for Clearcase?
> 
> I know that, in theory, it would be possible to 
>   for all checkins to Clearcase
>      check out of Clearcase
>      check into git
>   done
> 
> but that would take an incredibly long time in practice, wouldn't it?

Well it certainly isn't lightning quick, but it's not 'incredibly' slow either. 

http://github.com/charleso/git-cc

It uses 'cleartool lshistory' to retrieve the changes to a given view, and then 
'cleartool get' to download the contents, which can then be added directly to 
Git. In practice this is reasonably quick, although it depends on the size of 
your history. I've seen it take a few hours to complete the first step with a 
medium sized VOB, but once that's complete it's (relatively) quick to fetch the 
actual files. Git-cc is actually a bridge, and can be reused in this way to 
retrieve new content after an initial import (which is much, much quicker). 
Changes can also be pushed back to Clearcase.

As a word of warning, given the way in which Clearcase works you're not 
technically retrieving the full and complete history; as such a thing is almost 
impossible to export from Clearcase. What you see is the history of all the 
_currently_ visible files in your _current_ view. So, for example, any files 
that have been deleted or moved are completely ignored in the lshistory output. 
If this is unacceptable the only other option would be to manually modify the 
config spec to include this missing elements and take 'snapshots' of the history 
over time.

It's by no means as good or as complete as git-svn; partly because Clearcase is 
so tricky and partly because I'm so lazy. I hope this helps in some way though.

Cheers,

Charles

PS. Take a look at the Git tools wiki page for some other alternatives.

https://git.wiki.kernel.org/index.php/Interfaces,_frontends,_and_tools
