From: Peter Kirk <peter.kirk@gmx.de>
Subject: git svn rebase creates some commits with empty author, commiter and date fields
Date: Tue, 18 Nov 2008 11:21:14 +0100
Message-ID: <200811181121.18264.peter.kirk@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 18 11:22:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L2Nj9-0003Vc-N0
	for gcvg-git-2@gmane.org; Tue, 18 Nov 2008 11:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751712AbYKRKVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2008 05:21:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbYKRKVV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Nov 2008 05:21:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:52826 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751361AbYKRKVU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2008 05:21:20 -0500
Received: (qmail invoked by alias); 18 Nov 2008 10:21:17 -0000
Received: from p54ACA023.dip0.t-ipconnect.de (EHLO schizo.localnet) [84.172.160.35]
  by mail.gmx.net (mp034) with SMTP; 18 Nov 2008 11:21:17 +0100
X-Authenticated: #3744494
X-Provags-ID: V01U2FsdGVkX1+bNDEzYEubDFHgiGzfz0Rj2RN0285ZREU0F/V2Ga
	XLuHrl3l86kDwS
User-Agent: KMail/1.10.1 (Linux/2.6.27-7-generic; KDE/4.1.2; x86_64; ; )
Content-Disposition: inline
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101268>

Hi there,

I am using git version 1.6.0.3, which I compiled myself from sources on my 
linux/amd64 box which runns kubuntu 8.10.

Now, when I do "git svn clone" to retrieve the entire history from the svn 
server then everything works fine. Then I start working with this, commit some 
myself, and run "git svn rebase" frequently. What happens (and I don't see the 
pattern) is that *some* commits that are retrieved via "git svn rebase" are 
broken...they don't contain a valid author field, the date is at 1970 and, most 
importantly (for me) the commit message is empty except for the "git-svn-id:" 
line that "git svn" adds automatically. The diff is fine, and I can still use 
the checkout fine...but I cannot view the log-message/author/date of some 
commits, which becomes tiresome quickly.
The only way to "fix" these broken commits is to do a clean "git svn clone", 
but as new commits are pulled via "git svn rebase", my repository will again 
become polluted with broken commits.

When I run "git fsck" I get a line like this for every broken commit:

error in commit 94a0eb26b0843f6b4db28d24b41301bd295d0794: invalid 
author/committer line

When I run git show on one of the broken commits the output looks like so:
########### snip ###########
commit 420be3a37353e3f2a968a2a8686a7169b31b9c3e
Author: (no author) <(no author)@596c1c1d-4ad6-0310-94f8-b98c4e649a3b>
Date:   Thu Jan 1 00:00:00 1970 +0000
 
    git-svn-id: svn+ssh://hiddenhost@5681 596c1c1d-4ad6-0310-94f8-b98c4e649a3b
 
 
diff --git a/bla/foo.cpp b/bla/foo.cpp
...the correct diff output follows...
############# snap ##########

While trying to find a solution to my problem with google I stumbled accross an 
old thread from 2007, but it sounds similar to my problem so I will link it 
for reference: https://kerneltrap.org/mailarchive/git/2007/10/30/368150
Note that in that case the changesets themselves seemed to be empty though 
though, for me it is only "author+date+commit message". Also I don't 
(knowingly) have any "authors file" provided.

Thanks in advance for any help, and please ask if any info is missing,
Peter
