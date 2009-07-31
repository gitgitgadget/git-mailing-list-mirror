From: Jan Engelhardt <jengelh@medozas.de>
Subject: Have git-merge-base support multiple IDs
Date: Fri, 31 Jul 2009 17:51:25 +0200 (CEST)
Message-ID: <alpine.LSU.2.00.0907311745100.4901@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 31 17:51:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWuOO-0002Yg-04
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 17:51:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751953AbZGaPv1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 11:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbZGaPv1
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 11:51:27 -0400
Received: from sovereign.computergmbh.de ([85.214.69.204]:49526 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751862AbZGaPv1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 11:51:27 -0400
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 3FE6C38909; Fri, 31 Jul 2009 17:51:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 3AAE640A98F1
	for <git@vger.kernel.org>; Fri, 31 Jul 2009 17:51:25 +0200 (CEST)
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124572>

Hi,


I am using git merge-base as sort of a hack to determine where to start 
rebasing.
Suppose this is the commit log (git log --oneline), of course, all 
unpublished, which is why rebase comes in:

  98683793  Fix For faae2553
  3365a01b  Fix For ab80794f
  62943a23  Feature Baz
  ab80794f  Feature Bar
  faae2553  Feature Foo

To determine the rebase point (i.e. first commit in a series),
one can (ab)use git-merge-base:

  p=$(git merge-base ab80794f faae2553)
  git re -i ${p}^

And then reorder ab80794f, faae2553 to squash the fixes into the 
appropriate commits. This practice works well somewhat.
The twist is that merge-base in git 1.6.3.3 happens to ignore any 
further arguments following two IDs. In short:

  git merge-base A B C...

Only yields the merge-base of A and B, and ignores C...
Perhaps this missing feature could be added in a future version?
