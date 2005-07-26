From: David Mansfield <david@cobite.com>
Subject: Re: [PATCH] git-cvsimport-script: parse multidigit revisions
Date: Tue, 26 Jul 2005 17:46:04 -0400
Message-ID: <42E6AF1C.9050606@cobite.com>
References: <20050712213531.GA10936@pc117b.liacs.nl> <20050713011818.GM9915@kiste.smurf.noris.de> <Pine.LNX.4.58.0507251544300.6074@g5.osdl.org> <20050725234257.GC5680@kiste.smurf.noris.de> <Pine.LNX.4.58.0507251922310.6074@g5.osdl.org> <Pine.LNX.4.58.0507252028220.6074@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Matthias Urlichs <smurf@smurf.noris.de>,
	Sven Verdoolaege <skimo@liacs.nl>,
	Git Mailing List <git@vger.kernel.org>,
	David Mansfield <cvsps@dm.cobite.com>
X-From: git-owner@vger.kernel.org Tue Jul 26 23:52:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DxXKx-0001JP-Rc
	for gcvg-git@gmane.org; Tue, 26 Jul 2005 23:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262139AbVGZVvH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Jul 2005 17:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbVGZVsq
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jul 2005 17:48:46 -0400
Received: from iris.cobite.com ([208.222.83.2]:17604 "EHLO
	email-pri.cobite.com") by vger.kernel.org with ESMTP
	id S262139AbVGZVqr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2005 17:46:47 -0400
Received: from localhost (iris.cobite.com [127.0.0.1])
	by email-pri.cobite.com (Postfix) with ESMTP
	id 0393F9854F; Tue, 26 Jul 2005 17:46:28 -0400 (EDT)
Received: from email-pri.cobite.com ([127.0.0.1])
 by localhost (iris.cobite.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 00621-03; Tue, 26 Jul 2005 17:46:27 -0400 (EDT)
Received: by email-pri.cobite.com (Postfix, from userid 45000)
	id CF19F985CB; Tue, 26 Jul 2005 17:46:27 -0400 (EDT)
Received: from [208.222.80.105] (gandalf.cobite.com [208.222.80.105])
	by email-pri.cobite.com (Postfix) with ESMTP
	id EBD369854F; Tue, 26 Jul 2005 17:46:23 -0400 (EDT)
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507252028220.6074@g5.osdl.org>
X-Virus-Scanned: by amavisd-new at cobite.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 25 Jul 2005, Linus Torvalds wrote:
> 
>>And they are in the wrong order, so "cvsimport" ends up committing the 
>>last one, which is the _empty_ one.
>>
>>Notice? We'll end up committing "COPYING 1.1" (the empty initial create)
>>even though we _should_ have committed "COPYING 1.2" (the actual thing
>>that BK committed).
> 
> 
> David, how about a patch like this to cvsps? My very very limited testing
> seems to say that it does the right thing..
> 
> It's very simple: if we are adding the same file twice to the same 
> PatchSet, we just look at the ordering of the revisions. If the revision 
> we're adding is older than the revision we already have, we just drop that 
> revision entirely. If it's the same, something is really wrong, and we add 
> it to the "collisions" list. And if it's newer, then we remove the old 
> revision for that file, and add the new one instead.
> 
> As far as I can tell, the old code really was broken, since it would
> happen to list different revisions in a random order when you had multiple
> changes to the same file in the same patchset. This one always selects the
> last one, which would seem to be the sane behaviour.
> 
> And this all seem to make "git cvsimport -p --bkcvs" do the right thing. 
> 

I've been 'off the web' for a few weeks on vacation.  I'll look at the 
context of the thread.  It 'smells' wierd to have to revisions in the 
same patchset at all, but I suppose you've all been through that before. 
  So let me catch up with this thread and get back to you...

David
