From: Miguel Bazdresch <monotone-01@thewizardstower.org>
Subject: Re: [PATCH] Add git-branches-script
Date: Wed, 17 Aug 2005 15:37:58 -0500
Message-ID: <20050817203758.GA1332@localhost.domain.invalid>
References: <20050815204430.GA77829@rossby.metr.ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-From: git-owner@vger.kernel.org Wed Aug 17 22:33:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5UZD-0006Pf-Qp
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 22:31:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751165AbVHQUbQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 16:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbVHQUbP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 16:31:15 -0400
Received: from relay02.pair.com ([209.68.5.16]:33032 "HELO relay02.pair.com")
	by vger.kernel.org with SMTP id S1751165AbVHQUbP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 16:31:15 -0400
Received: (qmail 88081 invoked from network); 17 Aug 2005 20:31:09 -0000
Received: from unknown (HELO localhost.localdomain) (unknown)
  by unknown with SMTP; 17 Aug 2005 20:31:09 -0000
X-pair-Authenticated: 201.133.152.175
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 790AC53B78; Wed, 17 Aug 2005 15:37:58 -0500 (CDT)
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050815204430.GA77829@rossby.metr.ou.edu>
User-Agent: Mutt/1.4.2.1i
X-Mailer: Mutt 1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

* Amos Waterland <apw@rossby.metr.ou.edu> [2005-08-16 00:48]:
> For people whose workflow involves switching back and forth between a
> lot of branches, it can be really helpful to be able to quickly tell
> which branch you are on and which ones are available.  This patch
> introduces a small script that when invoked as `git branches' prints a
> list of available branches with a star in front of the one you are on:
> 
>  $ cd linux-2.6/
>  $ git checkout -b ppc64-cleanups
>  $ git checkout -b ppc64-new-devel
>  $ git checkout -b ppc64-all-merge
>  $ git branches
>    master
>  * ppc64-all-merge
>    ppc64-cleanups
>    ppc64-new-devel

Some might find it useful to put Amos' script in a bash function and
then put the current branch in the prompt. What I did was to put this
function in my .bashrc:

gitbranch () {
	. git-sh-setup-script &&
	branch=$(basename $(readlink $GIT_DIR/HEAD)) &&
	echo -n "" $branch ""
}

Then I modified my bash prompt:

export PS1='\[\033[1;31m\]\j$(gitbranch)[\w]\$ \[\033[0m\]'
                            ^^^^^^^^^^^

Now, if my current dir is not a git repo, I have my regular prompt. As
soon as I cd into a git repo, I get the current branch in the prompt, as
follows:

0[~]$ cd gitrepo
0 master [~/gitrepo]$ git checkout branch1
0 branch1 [~/gitrepo]$ cd ..
0[~]$

-- 
Miguel Bazdresch
http://thewizardstower.org/
