From: Johan Herland <johan@herland.net>
Subject: Re: 'git notes merge' implementation questions
Date: Thu, 22 Apr 2010 01:55:12 +0200
Message-ID: <201004220155.12747.johan@herland.net>
References: <201004210957.48138.johan@herland.net>
 <20100421171227.GA23794@progeny.tock>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 22 01:55:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O4jlN-0006S1-Su
	for gcvg-git-2@lo.gmane.org; Thu, 22 Apr 2010 01:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313Ab0DUXzS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Apr 2010 19:55:18 -0400
Received: from smtp.getmail.no ([84.208.15.66]:35093 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755386Ab0DUXzQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Apr 2010 19:55:16 -0400
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L19004EM3S3OBD0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Thu, 22 Apr 2010 01:55:15 +0200 (MEST)
Received: from alpha.localnet ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0L19007V63S14O20@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Thu, 22 Apr 2010 01:55:15 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.4.21.234817
User-Agent: KMail/1.13.2 (Linux/2.6.33-ARCH; KDE/4.4.2; x86_64; ; )
In-reply-to: <20100421171227.GA23794@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145476>

On Wednesday 21 April 2010, Jonathan Nieder wrote:
> Johan Herland wrote:
> > 2. Merging without a worktree
>=20
> Eh, I am not a fan.  I am thinking it might be better to use somethin=
g
> like contrib/workdir to make a temporary worktree with its own index
> and HEAD in .git/tmp-merge-notes and let the conflict resolvers work
> there.
>=20
> Advantages:
>=20
>  - easy to debug when something goes wrong
>  - merge driver can take other unmerged entries into account
>  - (if merging manually) the user is not at the mercy of the program.
>    Instead of being forced to consider the conflicts in the order git
>    wants, she can skip some and go back to them, look at how many
>    there are before deciding to start work, resolve some, reboot to
>    test a new kernel, resolve some more later, and visualize the
>    result.
>  - if the unmerged notes are very long, you might need a temporary
>    file anyway
>  - maybe some day a kind of rename detection could help cope with
>    situations like propagation of notes after a rebase
>=20
> Disadvantages:
>=20
>  - setting up a new git dir takes some time
>  - a checkout with all notes would be insanely huge.  So somehow one
>    has to find an appropriate subset to check out.
>=20
> >     Possible solution: Conflict resolvers:
> I think you can do an entirely in-index merge with =E2=80=98git read-=
tree=E2=80=99 and
> =E2=80=98git merge-index=E2=80=99.  If you forbid the per-file merge =
driver to fail
> then this sounds like exactly what you=E2=80=99re talking about.
>=20
> In my opinion in the case of popping up an editor this is a cruel
> thing to do, but in the other cases it=E2=80=99s a good place to star=
t.

Thanks, I'm definitely coming around to the idea that having the user f=
reely=20
resolve conflicts in a temporary worktree (that preferably contains onl=
y the=20
conflicting notes) is better than trying to resolve conflicts _without_=
 a=20
worktree.


=2E..Johan

--=20
Johan Herland, <johan@herland.net>
www.herland.net
