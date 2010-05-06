From: Eli Barzilay <eli@barzilay.org>
Subject: Preventing rebase confusion
Date: Thu, 6 May 2010 07:27:08 -0400
Message-ID: <19426.42892.542935.899298@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 06 13:27:19 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9zEa-0002ZV-EM
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 13:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757531Ab0EFL1K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 07:27:10 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:37480 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757477Ab0EFL1J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 07:27:09 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9zES-0007Kl-Io
	for git@vger.kernel.org; Thu, 06 May 2010 07:27:08 -0400
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146475>


Two suggestions (provided that I have the details right):

1. When I run `git rebase origin' I get helpful instructions when a
   conflict happens:

     When you have resolved this problem run "git rebase --continue".
     If you would prefer to skip this patch, instead run "git rebase --skip".
     To restore the original branch and stop rebasing run "git rebase --abort".

   It would be nice if the first line said something like

     When you have resolved this problem run "git add <file>" and then
     "git rebase --continue" (no need to commit).

   My guess is that this is something that confuses many people since
   everywhere conflicts are mentioned the instructions are to `add'
   and then to `commit'.

2. If I did get confused (which can still happen if I don't read the
   above addition) and commit the resolved files, I get this when I
   try `git rebase --continue':

     Applying: document the type of foo
     No changes - did you forget to use 'git add'?

   But of course there are no changes now...  So it would be nice if
   the text also said:

     If you've already committed then you can run "git rebase --skip"
     but your commit will then replace the original "...subject..."

   And/or maybe instructions for using reset to undo the commit and
   let rebase --continue do it.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
