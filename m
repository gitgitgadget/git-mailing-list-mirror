From: "Jan =?UTF-8?B?S3LDvGdlcg==?=" <jk@jk.gs>
Subject: Deleting the "current" branch in remote bare repositories
Date: Sat, 7 Feb 2009 16:27:54 +0100
Message-ID: <20090207162754.5fb8b63f@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: obrien654j@gmail.com
To: Git ML <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Feb 07 16:37:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVpEy-0004BQ-E3
	for gcvg-git-2@gmane.org; Sat, 07 Feb 2009 16:37:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752766AbZBGPdA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Feb 2009 10:33:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZBGPdA
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Feb 2009 10:33:00 -0500
Received: from zoidberg.org ([88.198.6.61]:34768 "EHLO cthulhu.zoidberg.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199AbZBGPdA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Feb 2009 10:33:00 -0500
X-Greylist: delayed 301 seconds by postgrey-1.27 at vger.kernel.org; Sat, 07 Feb 2009 10:32:59 EST
Received: from perceptron (xdsl-78-34-175-56.netcologne.de [::ffff:78.34.175.56])
  (IDENT: unknown, AUTH: LOGIN jast, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by cthulhu.zoidberg.org with esmtp; Sat, 07 Feb 2009 16:28:40 +0100
  id 0042C5F7.498DA8A8.00004023
X-Mailer: Claws Mail 3.5.0 (GTK+ 2.14.4; i486-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108862>

Hi everyone,

recently on IRC we had a case where someone had accidentally deleted
the "current" branch (i.e. thing pointed to by HEAD) by using "git push
origin :master". This broke the remote HEAD as well as the local
refs/remotes/origin/HEAD. Not good. I think we want to make it harder
to get into this situation.

Personally, without being aware of any potential counterindications, I
think the best solution from a usability point of view would
be to have receive-pack reject deletions of what's currently in HEAD.
The question is, of course: how do we go about situations where someone
actually wants to delete the branch HEAD points at?

1. reject deletion and point out a command to change HEAD first (I
don't think we've got a command to do this remotely; do we want one?)

2. automatically change HEAD to something else if there's any other
branch (eww)

3. accept the deletion but warn the user that she just broke the
repository (especially eww because it also breaks the local tracking
ref)

Any smart ideas?
-Jan
