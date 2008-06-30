From: Jan Wielemaker <J.Wielemaker@uva.nl>
Subject: Re: Corruption: empty refs/heads in otherwise filled repo: cannot clone?
Date: Mon, 30 Jun 2008 12:30:38 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200806301230.38980.J.Wielemaker@uva.nl>
References: <200806301149.18115.J.Wielemaker@uva.nl> <m3r6afgrme.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 12:31:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDGfh-0000yX-Hd
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 12:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755296AbYF3Kal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 06:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754706AbYF3Kal
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 06:30:41 -0400
Received: from korteweg.uva.nl ([146.50.98.70]:20082 "EHLO korteweg.uva.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753703AbYF3Kak (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 06:30:40 -0400
Received: from gollem.science.uva.nl ([146.50.26.20]) by korteweg.uva.nl with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 30 Jun 2008 12:30:39 +0200
User-Agent: KMail/1.9.5
In-Reply-To: <m3r6afgrme.fsf@localhost.localdomain>
Content-Disposition: inline
X-OriginalArrivalTime: 30 Jun 2008 10:30:39.0136 (UTC) FILETIME=[571D7200:01C8DA9C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86902>

Hi Jakub,

Thanks for the quick reply.  Info:

On Monday 30 June 2008 12:10, Jakub Narebski wrote:
> Jan Wielemaker <J.Wielemaker@uva.nl> writes:
> > I'm a bit puzzled. I have a bare repository, somehow without any files
> > in refs/heads.
>
> Do you have .git/packed-refs file? How do you have gc.packrefs set

Its a bare repo, so I'll forget the .git.  Yes, I have that file and
it contains nice references,  I checked a few by hand, and they have
the same SHA1 as the files I copied.

> ("git config --get gc.packrefs")? What are the git version on the

This gives no output, so I guess the answer is 'no'.  Is that wrong?
This is indeed the case (config):

----------------------------------------------------------------
[core]
        repositoryformatversion = 0
        filemode = true
        bare = true
        sharedrepository = 1
[gitcvs]
        enabled = 1
        logfile = /home/git/pl.git/cvs.log
        allbinary = 1
----------------------------------------------------------------

> clients that have trouble accessing repository, and what protocol
> (transport merhod) do they use: "file", http(s)/ftp, git, ssh?

I could reproduce the problem using the same git that maintains the bare
repository, which started as git-1.5.3.4 and is now 1.5.6.rc3. It
reproduces both using local file access and ssh. Other people have a
variety of versions. I know of concrete problems using the stable 1.5.5
over ssh.

The problem that I can't even clone is indeed after running a git-gc.

So, now I have all branch head refs double (in packed-refs and in
refs/heads). That explains ar least where they come from, but it fails
to explain why doing exactly the same using the same git on the same
repo as two users yields a different result. Of course, besides the
desire to understand how his works, I'm mostly interested in how to fix
this :-)

	Thanks --- Jan
