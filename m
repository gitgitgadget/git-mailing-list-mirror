From: Tim Olsen <tim@brooklynpenguin.com>
Subject: different git-merge behavior with regard to submodules in 1.6.2.4
 vs. 1.6.2.1
Date: Tue, 28 Apr 2009 13:36:59 -0400
Message-ID: <gt7err$3m4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 28 19:38:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyrG1-0000o7-M3
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 19:38:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760543AbZD1RhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 13:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759193AbZD1RhR
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 13:37:17 -0400
Received: from main.gmane.org ([80.91.229.2]:37184 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757891AbZD1RhP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 13:37:15 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LyrF3-0006XF-KM
	for git@vger.kernel.org; Tue, 28 Apr 2009 17:37:13 +0000
Received: from cyrus.limewire.com ([76.8.67.2])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 17:37:13 +0000
Received: from tim by cyrus.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 28 Apr 2009 17:37:13 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: cyrus.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117800>

Hello,

I noticed some weirdness lately when trying to merge branches in a
repository containing submodules.  I get the following behavior with git
1.6.2.4:

$ git merge origin/deployed
fatal: cannot read object 83055ffdddde60d41d9811aae77e78be50b329f8
'rubydav': It is a submodule!

Nothing in my history suggests that rubydav was at one point not a
submodule.

I looked at the 1.6.2.4 release notes and noticed the following:

  * "git-merge-recursive" was broken when a submodule entry was involved
in a criss-cross merge situation.

So then I downgraded to the last debian package of git which is 1.6.2.1.
 Now I get a result which is more approachable:

$ git merge origin/deployed
Auto-merging rubydav
CONFLICT (submodule): Merge conflict in rubydav - needs
167a344227c4745031d50a210869e6fb59a5ac03
Auto-merging server
CONFLICT (submodule): Merge conflict in server - needs
82a74ae791c8563ca65f29187d2fe5ebfbc167ea
Automatic merge failed; fix conflicts and then commit the result.

Both merges are from freshly checked out clones.

Is this a bug in 1.6.2.4?  Please let me know what other information I
can provide to help debug the problem.

Thanks,
Tim
