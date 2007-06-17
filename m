From: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
Subject: Re: StGIT vs. guilt: What's the difference?
Date: Sat, 16 Jun 2007 23:54:27 -0400
Message-ID: <20070617035426.GH7025@filer.fsl.cs.sunysb.edu>
References: <4671B96A.1080202@midwinter.com> <20070615030542.GA30110@diana.vm.bytemark.co.uk> <tnx1wgds1pv.fsf@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Steven Grimm <koreth@midwinter.com>,
	"'git'" <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 05:54:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hzlqb-0006yN-GQ
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 05:54:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758691AbXFQDyi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sat, 16 Jun 2007 23:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758683AbXFQDyh
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 23:54:37 -0400
Received: from filer.fsl.cs.sunysb.edu ([130.245.126.2]:59244 "EHLO
	filer.fsl.cs.sunysb.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758590AbXFQDyh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 23:54:37 -0400
Received: from filer.fsl.cs.sunysb.edu (localhost.localdomain [127.0.0.1])
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1) with ESMTP id l5H3sRS6021549;
	Sat, 16 Jun 2007 23:54:27 -0400
Received: (from jsipek@localhost)
	by filer.fsl.cs.sunysb.edu (8.12.11.20060308/8.13.1/Submit) id l5H3sR61021547;
	Sat, 16 Jun 2007 23:54:27 -0400
Content-Disposition: inline
In-Reply-To: <tnx1wgds1pv.fsf@arm.com>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50332>

On Fri, Jun 15, 2007 at 03:59:24PM +0100, Catalin Marinas wrote:
> Karl Hasselstr=F6m <kha@treskal.com> wrote:
> > On 2007-06-14 14:55:54 -0700, Steven Grimm wrote:
> >
> >> I've asked this on IRC a couple times and nobody seemed to have a
> >> good answer, so: These two tools seem like they are solving the sa=
me
> >> general problem using similar approaches. They are both under acti=
ve
> >> development. In what areas is each of them stronger than the other=
?
> >> Why would one choose to use one of them instead of the other?
> >
> > I have never had a close look at guilt, but from what I remember it
> > stores patches as plain old plaintext patches (corrections to this
> > statement welcome). StGIT uses git's object database.
=20
Sorry I missed this thread...

> I haven't tried quilt either but, if it uses plain text patches, the
> disadvantage might be the losing of the three-way merge when pushing =
a
> patch onto the stack. The solution is to remember which commit the
> patch applies to, switch the tree, apply the patch and merge with
> HEAD.
=20
Catalin: Perhaps a comparison table might be in order? This is most
definitely not the first time this question has been asked.

> Are the guilt patches accessible as commit objects at the top of the
> stack?

When you push a patch, you're doing:
=09
	git-apply && git-commit

When you pop a patch, you're doing:

	git-reset --hard HEAD^

So, once a patch is pushes, it is a separate commit in the git tree, an=
d one
can run any valid git command on it.

Now, of course the actual implementation is little bit more complex (e.=
g.,
using git-write-tree and git-commit-tree, as well as allowing to pop se=
veral
patches at the same time).

> StGIT might have some more features as it is older but I see a lot of
> development is going on with guilt.

I haven't looked at stgit in a number of months, but stgit most likely =
has
many features which make use of the extra metadata stored.

I'm trying to take the simpler approach - most of the time, the user ju=
st
want to push, refresh, and pop. With that said, there are plenty of use=
ful
commands (26 as of now).

> I would welcome such a discussion (so please keep me cc'ed) as we can
> share the experience with various issues.

Same here.

One additional thing. About four months ago, I've heard that stgit tend=
s to
blow up when you switch branches using git-checkout - guilt of course
doesn't :) My information may be outdated, so corrections are welcome.

Josef "Jeff" Sipek.

--=20
Hegh QaQ law'
quvHa'ghach QaQ puS
