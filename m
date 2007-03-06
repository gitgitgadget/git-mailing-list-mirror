From: Sergio Callegari <scallegari@arces.unibo.it>
Subject: git gc and git repack
Date: Tue, 6 Mar 2007 16:13:03 +0000 (UTC)
Message-ID: <loom.20070306T165455-693@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 06 17:13:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOcI7-0000BP-VR
	for gcvg-git@gmane.org; Tue, 06 Mar 2007 17:13:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965219AbXCFQNb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 11:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbXCFQNb
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 11:13:31 -0500
Received: from main.gmane.org ([80.91.229.2]:54237 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965219AbXCFQNa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 11:13:30 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1HOcHv-0007IN-F2
	for git@vger.kernel.org; Tue, 06 Mar 2007 17:13:19 +0100
Received: from st-a-2.ingfo.unibo.it ([137.204.201.23])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 17:13:19 +0100
Received: from scallegari by st-a-2.ingfo.unibo.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 06 Mar 2007 17:13:19 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 137.204.201.23 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.2) Gecko/20060601 Firefox/2.0.0.2 (Ubuntu-edgy))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41588>

Hi,

I am puzzled by a different behavior when doing housekeeping with git-gc and
git-repack:

On a repository I have, git gc gives:

Generating pack...
Done counting 75 objects.
Deltifying 75 objects.
 100% (75/75) done
Writing 75 objects.
 100% (75/75) done
Total 75 (delta 26), reused 68 (delta 26)
Pack pack-a989a4c4c7454874220cf502865ab9a28952499f created.
Removing unused objects 100%...
Done.

while git repack -a -d gives

Generating pack...
Done counting 143 objects.
Deltifying 143 objects.
 100% (143/143) done
Writing 143 objects.
 100% (143/143) done
Total 143 (delta 49), reused 120 (delta 31)
Pack pack-d17fd54437f04fbde34088909e31e95718e7b8c5 created.
Removing unused objects 100%...
Done.

Why is a different number of objects being considered in the two case, with git
repack considering more objects and producing a different pack? Also, the
package produced by repack turns out to be much larger than the one by git gc...
In any case, both packages turn out to be git-fsck clean...

I suspect, this has to to with my repository using alternates... (in fact git-gc
and git-repack start behaving identically if I pass the -l (local) option to
repack...  can anyone confirm that this is the only difference?

Also can anybody confirm whether git repack -a -d actually includes in the pack
also _all_ the "borrowed" objects? I.e. if it is in fact a way to convert a
repository that borrows objects into one that is self-standing?
