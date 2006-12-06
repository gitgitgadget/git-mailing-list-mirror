X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: [PATCH] cvs-migration document: make the need for "push" more obvious
Date: Wed, 6 Dec 2006 12:19:50 -0500
Message-ID: <20061206171950.GD1714@fieldses.org>
References: <4574AC9E.3040506@gmail.com> <4574BF70.8070100@lilypond.org> <45760545.2010801@gmail.com> <20061206.105251.144349770.wl@gnu.org> <Pine.LNX.4.63.0612061325320.28348@wbgn013.biozentrum.uni-wuerzburg.de> <4576D92A.80307@xs4all.nl> <20061206145802.GC1714@fieldses.org> <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 6 Dec 2006 17:20:20 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, gpermus@gmail.com,
	hanwen@lilypond.org, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612061613460.28348@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33496>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gs0RH-0005TK-EG for gcvg-git@gmane.org; Wed, 06 Dec
 2006 18:20:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936931AbWLFRUC (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 12:20:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936933AbWLFRUB
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 12:20:01 -0500
Received: from mail.fieldses.org ([66.93.2.214]:60054 "EHLO
 pickle.fieldses.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S936922AbWLFRUA (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec 2006
 12:20:00 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1Gs0Qw-0002ze-Bm; Wed, 06 Dec 2006
 12:19:50 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

On Wed, Dec 06, 2006 at 04:16:57PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 6 Dec 2006, J. Bruce Fields wrote:
> 
> > I'd rather leave that introduction as it is--just as a section that 
> > advertises the git features without trying to explain much.  And I'd 
> > rather not mention push until we have a chance to explain how to use it.
> 
> You talk like you'd have an eternity to explain Git. But that is not true.
> A developer, especially those whom Git is forced upon, have an attention 
> span shorter than their pub1c hair.

Definitely, I agree.  So that argues for locating the most import stuff
as close to start of the document as possible.  But obviously there's
lot of important stuff and you can't do that with everything, so you
also have to rely on keeping things organized so people can more easily
skip to the middle.

The rest of the introduction is all git marketing: why you should like
using git instead of cvs.  So someone skimming for the quickest possible
"how do I make changes?" stuff may skip it entirely.

The thing that might help such a skimmer the most, actually, would be
a more helpful title for the section that actually does have what
they're looking for.  And making sure that particular section has the
right stuff.  How about something like this?

--b.

cvs-migration: improved section titles, better push/commit explanation

Rename the section titles to make the "how-to" content of the section
obvious.  Also clarify that changes have to be commited before they can
be pushed.

---

 cvs-migration.txt |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/cvs-migration.txt b/Documentation/cvs-migration.txt
index 6812683..726b48d 100644
--- a/Documentation/cvs-migration.txt
+++ b/Documentation/cvs-migration.txt
@@ -76,8 +76,8 @@ variants of this model.
 With a small group, developers may just pull changes from each other's
 repositories without the need for a central maintainer.
 
-Emulating the CVS Development Model
------------------------------------
+Creating a Shared Repository
+----------------------------
 
 Start with an ordinary git working directory containing the project, and
 remove the checked-out files, keeping just the bare .git directory:
@@ -105,7 +105,10 @@ $ GIT_DIR=repo.git git repo-config core.
 Make sure committers have a umask of at most 027, so that the directories
 they create are writable and searchable by other group members.
 
-Suppose this repository is now set up in /pub/repo.git on the host
+Performing Development on a Shared Repository
+---------------------------------------------
+
+Suppose a repository is now set up in /pub/repo.git on the host
 foo.com.  Then as an individual committer you can clone the shared
 repository:
 
@@ -134,15 +137,17 @@ Pull: master:origin
 ------------
 ================================
 
-You can update the shared repository with your changes using:
+You can update the shared repository with your changes by first commiting
+your changes, and then using:
 
 ------------------------------------------------
 $ git push origin master
 ------------------------------------------------
 
-If someone else has updated the repository more recently, `git push`, like
-`cvs commit`, will complain, in which case you must pull any changes
-before attempting the push again.
+to "push" those commits to the shared repository.  If someone else has
+updated the repository more recently, `git push`, like `cvs commit`, will
+complain, in which case you must pull any changes before attempting the
+push again.
 
 In the `git push` command above we specify the name of the remote branch
