From: "Liam Healy" <lnp@healy.washington.dc.us>
Subject: Stitching together two split segments from svn
Date: Thu, 24 Jul 2008 19:33:09 -0400
Message-ID: <654935030807241633g763e622br4feb8b4e23ee64e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 25 01:35:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAKO-0004ba-Ld
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 01:34:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756869AbYGXXdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 19:33:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756854AbYGXXdc
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 19:33:32 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:15389 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756814AbYGXXd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 19:33:28 -0400
Received: by wr-out-0506.google.com with SMTP id 69so2031384wri.5
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 16:33:27 -0700 (PDT)
Received: by 10.100.41.15 with SMTP id o15mr1635001ano.48.1216942389276;
        Thu, 24 Jul 2008 16:33:09 -0700 (PDT)
Received: by 10.100.163.6 with HTTP; Thu, 24 Jul 2008 16:33:09 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 68d569e12ec03531
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89973>

Hi,

I have a project whose history is stored in two separate svn
repositories.  The first repository I kept privately during initial
development, the second started when I posted it publicly and does not
have the history of the first.  I am trying to reunite them under git.
 The development of the first was linear, so after using git svn, the
history looks like:

 a - b - ... - c - d = HEAD (old repository)

and the second has one branch "ffa":

(new repository)
 T - d - e - ... - f - g - h - ... - j   master
                      \
                       k - l - .... - m  ffa

Note that T is the "trunk" initial commit on the svn repo that has no
files.  The second commit d is identical to the HEAD of old, as
verified by git diff.
However, when I remote add these two into a single repository, they
show up as two detached chains, with no connection between them.  I
thought git rebase would reconnect them.  However, when I do that on
each branch (master and ffa), I get the following:

 a - b - ... - c - d - e - ... - f - g - h - ... - j   master
                      \
                       e - ... -f - g - k - l - .... - m  ffa

instead of what I would like

 a - b - ... - c - d - e - ... - f - g - h - ... - j   master
                                     \
                                      k - l - .... - m  ffa

That is to say, those commits from the new repository that have a
common history for the two branches are duplicated.  The commits are
listed separately and have different SHA IDs, but they are clearly the
same commits (same comments, same svn version number).  Is there any
way to do what I want?  Really, all I want to do is change the parent
of "e" to be the HEAD of the old repository.

Thank you.

Liam
