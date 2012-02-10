From: "Harald Heigl" <Harald@heigl-online.at>
Subject: AW: Project structure of .NET-Projects using git submodule or something different
Date: Fri, 10 Feb 2012 18:03:08 +0100
Message-ID: <003401cce815$dd907190$98b154b0$@heigl-online.at>
References: <002401cce069$75ecc1a0$61c644e0$@heigl-online.at> <4F29A0BE.8000803@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <git@vger.kernel.org>
To: <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 10 18:03:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvtsZ-0007Lx-Hq
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 18:03:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876Ab2BJRDT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 12:03:19 -0500
Received: from xserv02.internex.at ([85.124.51.102]:57226 "HELO
	xserv2.internex.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754722Ab2BJRDS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 12:03:18 -0500
X-PDA-ORIGIN: xserv2.internex.at
Received: (qmail 23890 invoked from network); 10 Feb 2012 17:03:08 -0000
Received: by simscan 1.4.0 ppid: 23873, pid: 23885, t: 0.1079s
         scanners: clamav: 0.97.3/m:54/d:14427
Received: from unknown (HELO setnbheh) (Harald@heigl-online.at@84.115.25.240)
  by xserv02.internex.at with SMTP; 10 Feb 2012 17:03:08 -0000
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQGEO7+ptvilZ+p+By5B5tRag0k/awHm5zMqlqqUlbCADeH0cA==
Content-Language: de-at
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190422>

Hi,

Just another question: What if your dependency is used in many projects=
?
=46or example if you use it in 10 projects it will be checked out 10 ti=
mes.
Well you could always do a push (and a pull in all other 9 projects to =
not
forget them).
Ok 10 projects is quite much, but I sometimes have 2-4 projects in para=
llel
which sometimes use the same dependencies. (And change them in the proj=
ects
on demand)
I've thought about checking out the dependency only once and do hardlin=
king,
I've also read about the "git clone --shared", but with both methods I =
would
loose the advantage of using submodule and on the other side I don't kn=
ow
exactly which problems could arise.

Could I just say that submodules would be checked out to a central loca=
tion
or are there better possibilities?
I don't mind the disk space, I just wonder how to keep track if you hav=
e
some projects all using the same dependencies.

Thanks,
Harald

> -----Urspr=FCngliche Nachricht-----
> Von: Harald Heigl [mailto:Harald@heigl-online.at]
> Gesendet: Mittwoch, 01. Februar 2012 22:07
> An: 'git@vger.kernel.org'
> Betreff: AW: Project structure of .NET-Projects using git submodule o=
r
> something different
>=20
> Hi, thanks for your answer!
>=20
> > -----Urspr=FCngliche Nachricht-----
> > Von: Jens Lehmann [mailto:Jens.Lehmann@web.de]
> > Gesendet: Mittwoch, 01. Februar 2012 21:30
> > An: Harald Heigl
> > Cc: git@vger.kernel.org
> > Betreff: Re: Project structure of .NET-Projects using git submodule=
 or
> > something different
> >
> > Am 31.01.2012 23:41, schrieb Harald Heigl:
> > > Let's assume following Project structure (Dependencies and
> > Subdependencies
> > > are submodules and submodules of the submodules)
> > > Project
> > > 	Dependency 1
> > > 		Dependency 2
> > > 		Dependency 3
> > > 	Dependency 4
> > > 	Dependency 2
> > >
> > >
> > > The problem is if I want to build them I need to build 2+3, then =
1, 4
and 2
> > > again and then the project. As you may see project 2 is a submodu=
le of
> > > dependency 1 and also of project. I don't feel comfortable with t=
his
> setup.
> > > What do you think?
> >
> > Hmm, we try to avoid that kind of setup as having checked out diffe=
rent
> > versions of the "Dependency 2" submodule could have rather surprisi=
ng
> > effects. We get along really well with "Dependency 2" only being pr=
esent
> > in the superproject and having "Dependency 1" reference that instea=
d of
> > having its own copy (So we have submodules which are depending on
> having
> > other submodules right next to them). Then the superproject is
> responsible
> > for tying it all together.
>=20
> I think you're right, my first thoughts were that if I start a new pr=
oject
I just
> "git submodule dependency1" and get all the required dependencies and
> the dependencies within the dependencies and so on ... .
> With your solution I "git submodule dependency1" and have to think ab=
out
> the dependencies it depends on. On the other hand we are just a small
> company and the number of submodules is not too big and the missing
> references in a new project would be easily identifiable, so ... .
>=20
> And if I want to checkout dependency 1 individually (for whatever rea=
son),
I
> could still do something like this:
> SuperDependency1 (with solution-File)
>            Dependency1 (as submodule)
>            Dependency2 (dependency of dependency1 - as submodule)
>            Dependency3 (dependency of dependency1 - as submodule)
>=20
> Thanks again, I see my concept causes some trouble ...
>=20
> Any other thoughts or other workflows with git or with tools build ar=
ound
> git?
>=20
> Thanks again,
> Harald
