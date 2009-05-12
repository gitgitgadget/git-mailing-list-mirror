From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Subject: Re: git fails with control characters in trunk directory name
Date: Tue, 12 May 2009 11:02:59 +0200
Message-ID: <200905121103.00432.Hugo.Mildenberger@namir.de>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <81b0412b0905112351l126a7c5bh902a7c7748d9a77a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 12 11:04:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3nu9-0006P5-Dm
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 11:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752758AbZELJD4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 05:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbZELJD4
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 05:03:56 -0400
Received: from mx02.qsc.de ([213.148.130.14]:33415 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007AbZELJDz convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 05:03:55 -0400
Received: from localhost (port-87-234-69-58.dynamic.qsc.de [87.234.69.58])
	by mx02.qsc.de (Postfix) with ESMTP id 50C4A16C0001
	for <git@vger.kernel.org>; Tue, 12 May 2009 11:03:55 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <81b0412b0905112351l126a7c5bh902a7c7748d9a77a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118884>

Hello Alex,

> 2009/5/11 Hugo Mildenberger <Hugo.Mildenberger@namir.de>:
> > Using the mouse to paste a git url from a website into a terminal s=
ession
> > in order to clone the repository, I recently managed to include inv=
isible
> > control characters into the git trunk directory name.
>
> Git has no "trunk". Not in CVS/CVN sense, at least
>
> > Consequently, I faced all sort of strange behaviour like git pull n=
ot
> > working (error 2), later on a kernel make which supposedly could no=
t
> > finding a rule to create the trunk directory and more such
> > inconsistencies.
> > I then reinstalled git, rcs and so on and also tried unsuccessfully
> > several git versions. The next morning I looked into the .git/confi=
g file
> > and recognized that the "url" key value within the [remote "origin"=
]
> > section contained some control characters: ^J and \n, as fas as I
> > remember.
>
> What platform are you on?
> Can you show your .git/config?
>
> > While this was almost entirely my fault, git could possibly apply a
> > filter, reject such a name or at least issue a warning.
>
> Maybe. Or maybe it can just work (well, assuming the user meant to
> use an url with character you considered "control").

I said it actually did not work well, independent from how anyone prefe=
rs to=20
classify characters. My platform is Gentoo-hardened with unicode suppor=
t and=20
an ext3 disk format . =C2=A0With "trunk directory" =C2=A0I meant the to=
p level=20
directory which is created when you run git clone on a remote url -- so=
rry=20
for still not being a native git speaker. I don't have the original set=
up=20
anymore. My _working_ ".git/config" is now:

[core]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0repositoryformatversion=
 =3D 0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0filemode =3D true
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0bare =3D false
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0logallrefupdates =3D tr=
ue
[remote "origin"]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0url =3D=20
git://git.kernel.org/pub/scm/linux/kernel/git/holtmann/bluetooth-testin=
g.git
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0fetch =3D +refs/heads/*=
:refs/remotes/origin/*
[branch "master"]
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0remote =3D origin
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0merge =3D refs/heads/ma=
ster

The remote url did contain something like "^J\n" at the end, as did the=
 top=20
level (the much derided "trunk") directory name on disk. I probably got=
 there=20
by puting the copied url within quotes on the command line, but today I=
'm =C2=A0
unsure exactly how I arrived there. However, old fashioned as I am, I s=
till=20
consider e.g. a linefeed to be a "control character", and inspite of yo=
ur=20
flashing git punditry I still consider this to be an issue.
