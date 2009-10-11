From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: combine git repo historically
Date: Sun, 11 Oct 2009 15:07:06 +0200
Organization: Viscovery Software GmbH
Message-ID: <200910111507.06926.j.sixt@viscovery.net>
References: <20091009012254.GA3980@debian.b2j> <200910110436.52653.chriscool@tuxfamily.org> <m31vlagvtw.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: bill lam <cbill.lam@gmail.com>, git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Oct 11 15:16:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwyHr-00045L-L5
	for gcvg-git-2@lo.gmane.org; Sun, 11 Oct 2009 15:16:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757284AbZJKNO5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Oct 2009 09:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757188AbZJKNO5
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Oct 2009 09:14:57 -0400
Received: from [93.83.142.38] ([93.83.142.38]:52147 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754656AbZJKNO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Oct 2009 09:14:57 -0400
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Sun, 11 Oct 2009 09:14:56 EDT
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 332F719F5FA;
	Sun, 11 Oct 2009 15:07:07 +0200 (CEST)
User-Agent: KMail/1.9.10
In-Reply-To: <m31vlagvtw.fsf@localhost.localdomain>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129922>

On Sonntag, 11. Oktober 2009, Jakub Narebski wrote:
> Christian Couder <chriscool@tuxfamily.org> writes:
> > $ git checkout -b repo1-branch1 remote/repo1/branch1
> > $ git checkout N -- .
> > $ export GIT_AUTHOR_NAME=<author name of commit N>
> > $ export GIT_AUTHOR_EMAIL=<author email of commit N>
> > $ export GIT_AUTHOR_DATE=<date of commit N>
> > $ git commit -a

This would not preserver the committer, but in particular the committer date 
is rather important for history traversal. You really don't want to change 
it. I used a much more elaborate pipleine involving git-commit-tree because I 
did not think about this simple procedure:

>  $ git cat-file commit N > COMMIT_N
>[ $ edit COMMIT_N  ]
>  $ git hash-object -t commit -w COMMIT_N

Thanks for this tip, Jakub.

Christian, one thing that worries me is that 'git cat-file commit foo' returns 
the replacement (bar) instead of the original (foo). Is it intended? There is 
no way to retrieve the original commit using plumbing unless the replacement 
is removed. Am I right?

-- Hannes
