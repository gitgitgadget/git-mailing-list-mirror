From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git rebase to move a batch of patches onto the current branch
Date: Fri, 25 Jul 2008 22:31:18 +0200
Message-ID: <20080725203118.GA28937@atjola.homenet>
References: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 25 22:32:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMTxe-0003s1-Ir
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 22:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbYGYUbW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jul 2008 16:31:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751237AbYGYUbW
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 16:31:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:39707 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750854AbYGYUbV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 16:31:21 -0400
Received: (qmail invoked by alias); 25 Jul 2008 20:31:19 -0000
Received: from i577BBE25.versanet.de (EHLO atjola.local) [87.123.190.37]
  by mail.gmx.net (mp023) with SMTP; 25 Jul 2008 22:31:19 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18pYbsLIrQpVToB9TMt6C1KIL44eeH8mfTc7/yF4/
	xvqRwKZYJjUeLO
Content-Disposition: inline
In-Reply-To: <32541b130807241257j7820a591if8ca01c66bbcd6b2@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90110>

On 2008.07.24 15:57:03 -0400, Avery Pennarun wrote:
> Hi,
>=20
> I often find myself being on a branch and wanting to do the equivalen=
t
> of a series of cherry-picks from another branch into the current one.
> Unfortunately, "git cherry-pick" only does one patch at a time (which
> is very tedious), and "git rebase", which is much less tedious to use=
,
> seems to specializing in applying your current branch on top of
> another branch, not the other way around.
>=20
> Currently I do something like this:
>=20
>       git checkout -b tmp branch_with_interesting_stuff~5
>       git rebase --onto mybranch branch_with_interesting_stuff~15
>       git branch -d mybranch
>       git branch -m tmp mybranch
>=20
> But it seems a little complex when what I *really* want to type is
> something like:
>=20
>       git cherry-pick
> branch_with_interesting_stuff~15..branch_with_interesting_stuff~5
>=20
> and have it give me a rebase-style UI in case of conflicts, etc.  And
> of course, even more bonus points if I can get "rebase -i"
> functionality.

=46or "rebase -i", this should do:

git checkout mybranch
git reset --hard interesting_stuff~5
git rebase -i --onto ORIG_HEAD interesting_stuff~5

Not as nice as the format-patch thing but at least it doesn't drop your
braches' reflog like your version, and it provides "rebase -i"
functionality.

Note that the ORIG_HEAD thing might require a recent git version, IIRC
there were some patches to make rebase correctly handle that.

Bj=F6rn
