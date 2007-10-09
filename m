From: Bruno Haible <bruno@clisp.org>
Subject: Re: GNU-style ChangeLog merge driver for Git
Date: Tue, 9 Oct 2007 21:38:46 +0200
Message-ID: <200710092138.47147.bruno@clisp.org>
References: <200709301421.52192.bruno@clisp.org>
	<200710091403.26047.bruno@clisp.org>
	<BC06CC09-FD81-4153-AA54-A1A74250946B@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bug-gnulib@gnu.org, git list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org Tue Oct 09 21:39:18 2007
Return-path: <bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org>
Envelope-to: gnu-bug-gnulib@m.gmane.org
Received: from lists.gnu.org ([199.232.76.165])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfKv7-0008Iv-Fg
	for gnu-bug-gnulib@m.gmane.org; Tue, 09 Oct 2007 21:39:09 +0200
Received: from localhost ([127.0.0.1] helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43)
	id 1IfKv1-0005wR-Tr
	for gnu-bug-gnulib@m.gmane.org; Tue, 09 Oct 2007 15:39:03 -0400
Received: from mailman by lists.gnu.org with tmda-scanned (Exim 4.43)
	id 1IfKuv-0005wM-R9
	for bug-gnulib@gnu.org; Tue, 09 Oct 2007 15:38:57 -0400
Received: from exim by lists.gnu.org with spam-scanned (Exim 4.43)
	id 1IfKut-0005w2-Jv
	for bug-gnulib@gnu.org; Tue, 09 Oct 2007 15:38:56 -0400
Received: from [199.232.76.173] (helo=monty-python.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.43) id 1IfKut-0005vz-ET
	for bug-gnulib@gnu.org; Tue, 09 Oct 2007 15:38:55 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188])
	by monty-python.gnu.org with esmtp (Exim 4.60)
	(envelope-from <bruno@clisp.org>) id 1IfKus-0006Xq-Vt
	for bug-gnulib@gnu.org; Tue, 09 Oct 2007 15:38:55 -0400
Received: from linuix.haible.de ([81.210.217.73])
	by post.webmailer.de (klopstock mo28) (RZmta 13.4)
	with ESMTP id 303369j99GUG9S ; Tue, 9 Oct 2007 21:38:50 +0200 (MEST)
	(envelope-from: <bruno@clisp.org>)
User-Agent: KMail/1.5.4
In-Reply-To: <BC06CC09-FD81-4153-AA54-A1A74250946B@lrde.epita.fr>
Content-Disposition: inline
X-RZG-AUTH: gMysVb8JT2gB+rFDu0PuvnPihAP8oFdePhw95HsN8T+WAEY7QaSDm1JE
X-RZG-CLASS-ID: mo07
X-Detected-Kernel: Solaris 10 (beta)
X-BeenThere: bug-gnulib@gnu.org
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: Gnulib discussion list <bug-gnulib.gnu.org>
List-Unsubscribe: <http://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/pipermail/bug-gnulib>
List-Post: <mailto:bug-gnulib@gnu.org>
List-Help: <mailto:bug-gnulib-request@gnu.org?subject=help>
List-Subscribe: <http://lists.gnu.org/mailman/listinfo/bug-gnulib>,
	<mailto:bug-gnulib-request@gnu.org?subject=subscribe>
Sender: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Errors-To: bug-gnulib-bounces+gnu-bug-gnulib=m.gmane.org@gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60431>

Hello Benoit,

> Akim Demaille would also like it to squash the commits added by the  
> merge (the new commits in OTHERS):
> 
> YYYY-MM-DD  Author  <who@where.com>
> 
> 	Merge whatever:
> 
> 	YYYY-MM-DD  Someone Else  <foo@bar.com>
> 	Some change.
> 	* FileChanged.c: Whatever.
> 
> 	YYYY-MM-DD  Who Cares  <who@cares.com>
> 	Some other change.
> 	* OtherFile.c: Do it.
> 
> I thought this was mandated by the GNU Coding Standards but I  
> checked, it doesn't say anything about merges.  Would this sort of  
> strategy be useful to you?  Should it be default (or enabled by some  
> --squash option)?

This merge is occurring in a different situation:

The situation where we need ChangeLog merging most often is when a developer
has made changes on his own and pulls in the changes from the remote repository
(via "git stash; git pull; git stash apply").

The situation that Akim is describing is that he pulls changes from the
repository of Someone Else and Who Cares, and then pushes them into the
central repository, under his responsibility.

For the first situation, the non-remote ChangeLog entries should be moved
to the top, without modification or indentation.

For the second situation, three different styles are in use at GNU
(because they don't use "Signed-off" lines):

1) unmodified copying of the ChangeLog entries:

YYYY-MM-DD  Someone Else  <foo@bar.com>
	Some change.
	* FileChanged.c: Whatever.

YYYY-MM-DD  Who Cares  <who@cares.com>
	Some other change.
	* OtherFile.c: Do it.

2) copying with lieutenant's email address, like Akim described it:

YYYY-MM-DD  Lieu Tenant  <who@where.com>

	YYYY-MM-DD  Someone Else  <foo@bar.com>
	Some change.
	* FileChanged.c: Whatever.

	YYYY-MM-DD  Who Cares  <who@cares.com>
	Some other change.
	* OtherFile.c: Do it.

3) similar, but with indentation of the entire copied-in ChangeLog entries:

YYYY-MM-DD  Lieu Tenant  <who@where.com>

	YYYY-MM-DD  Someone Else  <foo@bar.com>
		Some change.
		* FileChanged.c: Whatever.

	YYYY-MM-DD  Who Cares  <who@cares.com>
		Some other change.
		* OtherFile.c: Do it.

First of all, your merge driver could try to guess whether we're in the
first or second situation (maybe by testing whether the names in the
ChangeLog entry match the [user]name from the git config).

Then, for the second situation, there can be some flag in the driver or in
the git config that describes which of the 3 styles to apply.

Bruno
