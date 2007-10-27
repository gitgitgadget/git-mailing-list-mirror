From: Sergei Organov <osv@javad.com>
Subject: git-show-branch doesn't work as advertised?
Date: Sat, 27 Oct 2007 17:26:26 +0400
Message-ID: <ffvea2$g2n$2@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 27 15:29:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlljG-0006O8-8w
	for gcvg-git-2@gmane.org; Sat, 27 Oct 2007 15:29:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753472AbXJ0N3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Oct 2007 09:29:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753193AbXJ0N3S
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Oct 2007 09:29:18 -0400
Received: from main.gmane.org ([80.91.229.2]:44718 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587AbXJ0N3R (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Oct 2007 09:29:17 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Illgw-0007um-BE
	for git@vger.kernel.org; Sat, 27 Oct 2007 13:27:06 +0000
Received: from 87.236.81.130 ([87.236.81.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 13:27:06 +0000
Received: from osv by 87.236.81.130 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 27 Oct 2007 13:27:06 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 87.236.81.130
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62493>

Hello,

I'm rather new to git. I'm reading Documentation/core-tutorial.txt from
git repository cloned yesterday [no, it's not the first git manual I
read], and I'm stuck at the example beginning at line 938 of the
tutorial:

------------------------------------------------
$ git show-branch --topo-order master mybranch
* [master] Merge work in mybranch
 ! [mybranch] Some work.
--
-  [master] Merge work in mybranch
*+ [mybranch] Some work.
------------------------------------------------

The problem is that even though the output of git matches the above
output (after I've replayed all the commands to this point), both the
state of the repo and the text below the example in the tutorial suggest
that one commit is missing from the output. In particular, the tutorial
says: "Three commits are shown along with their log messages." and
later "'master~1' is the first parent of 'master' branch head.", while
there are only 2 commits shown and there is no 'master~1' in the output.

The behavior is the same with git version 1.5.2.2 and 1.5.3.4.

For reference, from gitk output, the history looks like this:

.  [master]
.  o Merge work in mybranch
.  |\[mybranch]
.  | o Some work
.  | |
.  o | Some fun
.   \|
.    o Commit message
.    |
.    o Initial commit

Why "[master~1] Some fun." is not shown by git-show-branch?

Another issue. After above confusion I turned to the manual page and
decided to try --independent option, expecting an output similar to the
above, but missing all the common commits. However, to my surprise I've
got just:

$ git show-branch --topo-order --independent master mybranch
715ec06a744a801237c7233f3fb87ad583653c3a

instead. Nowhere the manual page says that this particular option
changes the format of the output so dramatically. And back to the first
issue, there is still only 1 commit shown, while it seems there should
be 2 of them, one from master, and one from mybranch.

-- 
Sergei.
