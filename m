From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: combine git repo historically
Date: Sun, 11 Oct 2009 15:43:39 +0200
Message-ID: <200910111543.39327.chriscool@tuxfamily.org>
References: <20091009012254.GA3980@debian.b2j> <m31vlagvtw.fsf@localhost.localdomain> <200910111507.06926.j.sixt@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, bill lam <cbill.lam@gmail.com>,
	git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Sun Oct 11 15:43:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mwyhr-0006Iz-Ha
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 15:43:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZJKNmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 09:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753310AbZJKNmd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 09:42:33 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36135 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753308AbZJKNmd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 09:42:33 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F0CA68180BA;
	Sun, 11 Oct 2009 15:41:49 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D1B908180F0;
	Sun, 11 Oct 2009 15:41:46 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <200910111507.06926.j.sixt@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129925>

On Sunday 11 October 2009, Johannes Sixt wrote:
> On Sonntag, 11. Oktober 2009, Jakub Narebski wrote:
> > Christian Couder <chriscool@tuxfamily.org> writes:
> > > $ git checkout -b repo1-branch1 remote/repo1/branch1
> > > $ git checkout N -- .
> > > $ export GIT_AUTHOR_NAME=<author name of commit N>
> > > $ export GIT_AUTHOR_EMAIL=<author email of commit N>
> > > $ export GIT_AUTHOR_DATE=<date of commit N>
> > > $ git commit -a
>
> This would not preserver the committer, but in particular the committer
> date is rather important for history traversal. You really don't want to
> change it. I used a much more elaborate pipleine involving
> git-commit-tree because I
>
> did not think about this simple procedure:
> >  $ git cat-file commit N > COMMIT_N
> >[ $ edit COMMIT_N  ]
> >  $ git hash-object -t commit -w COMMIT_N
>
> Thanks for this tip, Jakub.
>
> Christian, one thing that worries me is that 'git cat-file commit foo'
> returns the replacement (bar) instead of the original (foo). Is it
> intended? 

Yes it is intended. "git replace" was designed so that the original objects 
are not replaced only when reachability traversal (prune, pack transfer and 
fsck) wants to read the commit. See:

http://article.gmane.org/gmane.comp.version-control.git/104776/

> There is no way to retrieve the original commit using plumbing 
> unless the replacement is removed. Am I right?

I think you are right, but a flag could be easily added to some commands to 
retreive original objects. Or you can remove the replacement, retrieve the 
object and then put back the replacement.

Best regards,
Christian.
