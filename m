From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git svn rebase 
 =?utf-8?q?=E2=80=9Cout_of_memory=E2=80=9D_error_after_merging_two?=
 =?utf-8?q?_tracking?= branches
Date: Tue, 6 Dec 2011 18:56:52 +0100
Message-ID: <201112061856.52560.trast@student.ethz.ch>
References: <4EDE4589.9030601@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: Onsager <onsager@gmx.net>
X-From: git-owner@vger.kernel.org Tue Dec 06 18:57:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXzGS-00087l-1I
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 18:57:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752387Ab1LFR44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 12:56:56 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:36614 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365Ab1LFR4y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 12:56:54 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:56:51 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 6 Dec
 2011 18:56:52 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.3-1-desktop; KDE/4.6.5; x86_64; ; )
In-Reply-To: <4EDE4589.9030601@gmx.net>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186363>

Onsager wrote:
> @list
> 
> ... more detailed explanation on stackoverflow:
> 
> http://stackoverflow.com/questions/8398405/git-svn-rebase-out-of-memory-error-after-merging-two-tracking-branches
> 
> Is there something, I can do about this issue as a common user?

In this age of 5-second attention spans, I'm not sure you can expect
us to follow a link to an external site when a simple cut&paste job
would have sufficed, like so:

  I'm tracking two customer SVN branches with msysgit 1.7.7.1 (Win 7 64bit):

    SVN                Git

    trunk          --> master
    release_x_y_z  --> git-local-release_x_y_z 

  After a successful local merge of 'git-local-release_x_y_z' into
  'master' I'm running out of memory, when trying to synchronize the
  result with svn:

    mb@MMPEPA23 /c/git/MySoft (master)
    $ git svn rebase
    First, rewinding head to replay your work on top of it...
    Applying:
    fatal: Out of memory, realloc failed
    Repository lacks necessary blobs to fall back on 3-way merge.
    Cannot fall back to three-way merge.
    Patch failed at 0001

    When you have resolved this problem run "git rebase --continue".
    If you would prefer to skip this patch, instead run "git rebase --skip".
    To check out the original branch and stop rebasing run "git rebase --abort".

    rebase refs/remotes/git-svn: command returned error: 1 

  The .git/rebase-apply directory contains a few files ('patch', '0001')
  with more than 1GB size. What can I do in order to apply this patch?


First you should find out whether something went wrong with the patch
generation, or if that 1GB size is plausible.  Did your merge bring in
blobs that were that big?

Second, you could try with the -m option.  This will use a 3-way merge
to rebase, which avoids generating a full patch.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
