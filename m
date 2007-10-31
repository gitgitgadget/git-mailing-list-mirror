From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Newbie: report of first experience with git-rebase.
Date: Wed, 31 Oct 2007 20:57:02 +0100
Message-ID: <20071031195702.GB24332@atjola.homenet>
References: <87d4uv3wh1.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 20:57:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InJgq-0007M4-If
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 20:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbXJaT5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2007 15:57:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbXJaT5J
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 15:57:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:33529 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752486AbXJaT5G (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 15:57:06 -0400
Received: (qmail invoked by alias); 31 Oct 2007 19:57:03 -0000
Received: from i577B953D.versanet.de (EHLO localhost) [87.123.149.61]
  by mail.gmx.net (mp052) with SMTP; 31 Oct 2007 20:57:03 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19Py5JqeixP57BbDDM6JamVbdw4A2iO95E/Nrciry
	Z3+KNC0GOC5G9g
Content-Disposition: inline
In-Reply-To: <87d4uv3wh1.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62858>

On 2007.10.31 22:39:06 +0300, Sergei Organov wrote:
> Hello,
>=20
> I've made my first attempt at tracking my changes to upstream git
> repository using git-fetch/git-rebase workflow. I did three commits t=
o
> my master branch, and then upstream incorporated two of them in sligh=
tly
> modified form, so that some conflicts are to be expected. I did
> git-fetch followed by git-rebase, and finally have got the end result=
 I
> hoped for, but there were some confusion along the way. I think I'd p=
ost
> the log of the session here along with my thoughts so that an interes=
ted
> person could see how it works for a newbie (my thoughts and non-git
> actions at the time of rebasing are marked with 'me>' prefix):
>=20
> $ git fetch
> [...]
> $ git rebase origin
> First, rewinding head to replay your work on top of it...
> HEAD is now at 9c51414... Merge branch 'maint' into HEAD
>=20
> Applying Fix a typo.
>=20
> Wrote tree f5b2feefc021486eae9d2d84c69e0d6ead027a9d
> Committed: 983e907b1360c17c7ac925d6035d82cc7243f406
>=20
> Applying Use new syntax (-m option) for git-merge.
>=20
> error: patch failed: Documentation/core-tutorial.txt:878
> error: Documentation/core-tutorial.txt: patch does not apply
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> Auto-merged Documentation/core-tutorial.txt
> CONFLICT (content): Merge conflict in Documentation/core-tutorial.txt
> Failed to merge in the changes.
> Patch failed at 0002.
>=20
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --ski=
p".
> To restore the original branch and stop rebasing run "git rebase --ab=
ort".
>=20
> me> Nice, this conflict is expected.
> me> Editing Documentation/core-tutorial.txt to resolve the
> me> conflict... Conflict is resolved so that the working file matches
> me> upstream version.
>=20
> $ git rebase --continue
> You must edit all merge conflicts and then
> mark them as resolved using git add
>=20
> me> Nice helpful message, -- need to do git-add
>=20
> $ git add Documentation/core-tutorial.txt
> $ git rebase --continue
>=20
> Applying Use new syntax (-m option) for git-merge.
>=20
> No changes - did you forget to use 'git add'?
>=20
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --ski=
p".
> To restore the original branch and stop rebasing run "git rebase --ab=
ort".
>=20
> me> What?! I just did the git-add! Moreover, before I did git-add, th=
e
> me> error was different and helpful. Something went wrong?=20
> me> Well, it's unlikely, but maybe I made a mistake of not specifying
> me> the 'origin'?
>=20
> $ git rebase --continue origin
>=20
> Applying Use new syntax (-m option) for git-merge.
>=20
> No changes - did you forget to use 'git add'?
>=20
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --ski=
p".
> To restore the original branch and stop rebasing run "git rebase --ab=
ort".
>=20
> me> No luck :( A few seconds of thinking... Hmm... no-op patch, do I
> me> need to skip it? Let's try the --skip:
>=20
> $ git rebase --skip
>=20
> Applying Fix SYNOPSIS.
>=20
> error: patch failed: Documentation/git-merge.txt:10
> error: Documentation/git-merge.txt: patch does not apply
> Using index info to reconstruct a base tree...
> Falling back to patching base and 3-way merge...
> Auto-merged Documentation/git-merge.txt
> CONFLICT (content): Merge conflict in Documentation/git-merge.txt
> Failed to merge in the changes.
> Patch failed at 0003.
>=20
> When you have resolved this problem run "git rebase --continue".
> If you would prefer to skip this patch, instead run "git rebase --ski=
p".
> To restore the original branch and stop rebasing run "git rebase --ab=
ort".
>=20
> me> Aha, that's it! But why git didn't just skip the no-op patch

It wasn't a no-op patch. It had conflicts which you resolved to the
upstream version and _then_ you had a no-op.

> me> automatically? Well, anyway , now I have a new expected conflict,
> me> and I'm sure I just want to skip this patch, so let's try exactly
> me> that:
>=20
> $ git rebase --skip
> Dirty index: cannot apply patches (dirty: Documentation/git-merge.txt=
)
>=20
> me> No luck :( Well, let's go the long way, -- edit conflicting
> me> Documentation/git-merge.txt (so that it matches upstream),
>=20
> $ git add Documentation/git-merge.txt
> $ git rebase --skip
> Nothing to do.
>=20
> me> Well, I already knew this will work, but why should I edit the fi=
le
> me> and then git-add it just to skip the patch? Is there better way?
> me> Anyway, the "Nothing to do." above is slightly confusing, -- did =
it
> me> actually skip the patch? So let's check the result:

There seems to be some bug in rebase that makes it fail in this case.
Someone on #git also reported that --abort failed to reset his branch t=
o
the old head in a similar case, but I didn't manage to reproduce that
yet (well, I didn't try that hard), so I don't know if it's really a bu=
g
or a misuse by that guy.

Bj=F6rn
