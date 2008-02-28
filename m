From: Kyle Rose <krose@krose.org>
Subject: cookbook question
Date: Thu, 28 Feb 2008 14:00:11 -0500
Message-ID: <47C704BB.2010707@krose.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 20:08:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUo7G-0001Qe-Uf
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 20:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752286AbYB1THu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 14:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752556AbYB1THu
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 14:07:50 -0500
Received: from kai.krose.org ([140.186.190.96]:51037 "EHLO mail.krose.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752236AbYB1THt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 14:07:49 -0500
X-Greylist: delayed 456 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Feb 2008 14:07:49 EST
Received: from [172.16.25.54] (fw01.cmbrmaks.akamai.com [80.67.64.10])
	by mail.krose.org (Postfix) with ESMTP id 4B3332AEC084
	for <git@vger.kernel.org>; Thu, 28 Feb 2008 14:00:12 -0500 (EST)
User-Agent: Thunderbird 2.0.0.9 (X11/20071229)
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75435>

In maintaining a postfix config that differs maybe 10% between two 
different machines, I have a "common" branch that has ???? in the fields 
that differ.  I realized after speaking with one of the git developers a 
few weeks ago that I really should be using git-rebase to fix up the 
machine-specific branches when I make a change to the common branch.  
Unfortunately, the merge history was screwed up enough such that doing

git rebase -s ours origin/common

replaced one machine-specific config with the other, which is not what I 
wanted.

In order to reset things to a state in which git-rebase would be useful, 
I did the following:

git diff origin/common >/tmp/diff
git reset --hard origin/common
patch -p1 </tmp/diff
git commit -a -m 'reintroduce changes'

which works fine, but is obviously not the right way to do this.  What 
*is* the right way to accomplish this?  Essentially, I'm trying to reset 
the rebase point such that git won't rewind earlier when trying to do 
subsequent rebases.

Kyle

