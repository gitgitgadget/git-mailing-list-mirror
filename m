From: "Vladimir Panteleev" <thecybershadow@gmail.com>
Subject: Commit annotations (editable commit messages)
Date: Sat, 13 Feb 2010 00:32:55 +0200
Message-ID: <op.u71cw50km02fvl@cybershadow.mshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 23:35:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng46W-0000Dk-EN
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 23:35:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755964Ab0BLWfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 17:35:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:50683 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755863Ab0BLWfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 17:35:07 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ng46M-00006Z-6f
	for git@vger.kernel.org; Fri, 12 Feb 2010 23:35:06 +0100
Received: from 89.28.117.31 ([89.28.117.31])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 23:35:06 +0100
Received: from thecybershadow by 89.28.117.31 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 12 Feb 2010 23:35:06 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: 89.28.117.31
User-Agent: Opera Mail/10.50 (Win32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139758>

You have to agree, being able to edit commit messages in a controlled  
(logged/versioned) fashion is pretty useful. Aside mundane corrections  
such as typos or undocumented changes, it makes it possible to document  
bugs and other unintended changes in the commit that they were introduced.  
This is possible in centralized VCSes and is implemented in Subversion  
(controlled by a server-side hook).

When I presented somewhere the idea of migrating from SVN to Git, I got an  
opinion that the inability to edit commit messages (without rewriting  
history) would be a show-stopper, so I began to wonder how would it be  
possible to implement versioned editable commit messages (or commit  
"annotations") in Git:
1) the repository has a separate, special branch that only contains text  
files named by the SHA-1 of the commit they are describing
2) commit annotations are created/edited by creating/editing the  
respective text files, either manually or using some utilities (e.g. "git  
edit-annotation <SHA-1>" could check out the file from the branch, open up  
an editor and commit it back)
3) setting up "git push/pull" to also push/pull the annotations branch
4) "git log" and related commands would also show the contents of the  
respective text files, if they exist

The first three seem trivial... I'm not sure how to approach 4) though.  
Would it be possible to hack git to add a commit message output  
preprocessor hook OSLT?

There's also the problem with rebasing. Aside hacks with copies or  
symlinks in the annotations branch, what would be the best way to have an  
annotation follow commits after they're rebased (and have a different  
SHA-1)? Perhaps tie them to some property unique to the commit  
(timestamp?)? Depending on how this idea (and git rebase) is implemented,  
it could also just copy over the then-current version of the annotation  
into the new commit message when rebasing the commit.

-- 
Best regards,
  Vladimir                            mailto:thecybershadow@gmail.com
