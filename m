From: "Patrick Doyle" <wpdster@gmail.com>
Subject: git for subversion users
Date: Mon, 25 Jun 2007 15:48:32 -0400
Message-ID: <e2a1d0aa0706251248j1b8da150xbe19826bec15eed6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 25 21:48:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2uY7-0000J3-Ed
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 21:48:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753095AbXFYTse (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 15:48:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbXFYTse
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 15:48:34 -0400
Received: from wa-out-1112.google.com ([209.85.146.179]:25665 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753034AbXFYTsd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 15:48:33 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1959210wah
        for <git@vger.kernel.org>; Mon, 25 Jun 2007 12:48:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=aOT3JUpLjU0PdrWPUIUzwx1ccE8gtN1DOfs9gPDtT0lqaXvmhOczOhePRrrUAK+qRsr959SKDwg/yG95iJekMRFtfRe5FBZYOI4UnR1U9/D6EpSSX5QqmJ+Pqa7PFFaMzU7jXSDfxF77AbKTJQ1ML4Jby6eLNDk01KUnSAQ+MlY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ElyuXkVuAbmo/WSI8XF1HLXyznf+pIZqphp7cHXHdH5mgkG0YZ+SQSxwoPhF9QDb7aFEMLHwpW9mK/WI5DGelKhD5mZdDMRkcuCrPEKUN07m9TWFCD8/QNfu6FJc1qB0yaucpqWcNmrV5niKCWjIfAwYNKfjkZKYFYXBUgY0Fvg=
Received: by 10.114.196.1 with SMTP id t1mr5724317waf.1182800912372;
        Mon, 25 Jun 2007 12:48:32 -0700 (PDT)
Received: by 10.114.15.11 with HTTP; Mon, 25 Jun 2007 12:48:32 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50916>

Hello all,
I've read http://utsl.gen.nz/talks/git-svn/intro.html, "An
introduction to git-svn for Subversion/SVK users and deserters" and, I
guess I'm looking for a little more information.

It is possible that I am trying to use git and git-svn in a manner for
which they were not designed, so I appreciate any guidance that can be
provided.  Also, since I'm running FC6, I have git version 1.5.0.6
installed, instead of the 1.5.2.2 that I see on the home page.
Perhaps that could be my problem.

Anyway, we have a subversion server set up to track our internal
software development.  I would like to use git/git-svn so that I can
work offline, commit early and often, and occasionally synchronize to
our subversion baseline.  Finally, at least one of our subversion
repositories (my own personal one), is not set up in the traditional
svn://host/repo/{trunk,tags,branches} format.  It is organized as
svn://host/wpd/{project1,project2,project3}.  Since it's my own
personal playground, I don't need branches, and tend to remember tags
just be commit number.

That's the long, boring setup.  Now for the long boring question...

I started playing with a new project over the weekend, checkign in a
handful of commits in git, and now I want to import/export/push/pull
them to the subversion server.

Having read through the tutorial, I started with:

$ svn mkdir svn:///host/wpd/empty-project -m "Created empty project directory"
$ git-svn init svn:///host/wpd/empty-project
$ svn-git fetch

Now I have an empty directory into which I was hoping to "pull" my
changes from my weekend playground

$ git pull ~/playground/new-project
... (I get 7 new files, and, it looks like, their associated history)

Here's where I get stuck...
1) How can I remind myself of what I changed relative to what was in
the Subversion repository the last time I sync'd to it?  Under my
current model of operation, I come in after a weekend/night away, do
"svn status" and "svn diff" to remind myself what's changed, and
commit those changes with appropriate log messages.  I am hoping that
I can make the changes locally, commiting them with nice log messages
as I make the changes, and then "push" them to the subversion server
when convenient.

2) This is going to have some obvious problems when I work on other
projects shared with other developers.  We know how to address this
with Subversion (good communication, updating the working copy prior
to a commit, resolving the minor conflicts, etc...) what can I expect
when my local repository is git?

3) If I try to commit my change with:

$ git-svn dcommit

I get an error
Commit 0e3e....
has no parent commit, and therefore nothing to diff against.
You should be working from a repository originally created by git-svn

and that's where I get confused.  Is this a bug/feature of 1.5.0.2
that will disappear if I switched to 1.5.2.2?

Are there any other tips/resources for mixed mode operation
(centralized Subversion server, distributed git client(s))?

Thanks for any pointers.

--wpd
