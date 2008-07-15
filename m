From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: git stash save --keep-index
Date: Tue, 15 Jul 2008 16:26:15 +0200
Message-ID: <20080715142615.GI8224@neumann>
References: <bd6139dc0807150531k4f0a1a4yee2c8ec2b98ee39c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailinglist <git@vger.kernel.org>
To: Sverre Rabbelier <alturin@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 15 16:27:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIlUr-0003ir-T3
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 16:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbYGOO0S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jul 2008 10:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756595AbYGOO0S
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 10:26:18 -0400
Received: from francis.fzi.de ([141.21.7.5]:50336 "EHLO exchange.fzi.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756534AbYGOO0R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 10:26:17 -0400
Received: from [127.0.1.1] ([141.21.4.196]) by exchange.fzi.de with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 15 Jul 2008 16:26:14 +0200
Content-Disposition: inline
In-Reply-To: <bd6139dc0807150531k4f0a1a4yee2c8ec2b98ee39c@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-OriginalArrivalTime: 15 Jul 2008 14:26:14.0767 (UTC) FILETIME=[BCCDCFF0:01C8E686]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88558>

Hi Sverre,

On Tue, Jul 15, 2008 at 02:31:54PM +0200, Sverre Rabbelier wrote:
> <hack hack hack>
> $ git add # or -i / -p
> $ git stash save --keep-index
> <test if staged changes are ready to be commited>
> $ git commit
> $ git stash pop
> <lather, rinse, repeat>
>=20
> But what happens if in the testing phase you detect that the commit i=
s
> not ready yet, or even, some of the changes you staged should have
> been kept? It would make sense to 'undo' the stash the usual way:
> $ git stash pop
> But alas, it is not possible to apply on a dirty working directory, s=
o
> one has to resort to:
> $ git commit -m "tmp"
> $ git stash pop
> $ git reset HEAD^
If there are unstaged changes in the worktree, then yes, 'git stash
apply/pop' will error out complaining about dirty state.  However, if
there are changes in the index, but no unstaged changes in the
worktree, then apply/pop should work (assuming there are no conflicts,
of course).

So, you won't need that temporary commit, if you have not modified
anything or have added all changes to the index since 'git stash
save --keep-index'.

G=E1bor
