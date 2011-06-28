From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Tue, 28 Jun 2011 13:52:42 +0200
Message-ID: <1309261962.2497.413.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
	 <1309211460.2497.395.camel@Naugrim.eriador.com>  <4E0980D5.8040004@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jun 28 14:01:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbWz6-00042X-BE
	for gcvg-git-2@lo.gmane.org; Tue, 28 Jun 2011 14:01:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757456Ab1F1L4W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Jun 2011 07:56:22 -0400
Received: from mail6.surf-town.net ([212.97.132.46]:60638 "EHLO
	mailgw18.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755490Ab1F1Lx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jun 2011 07:53:28 -0400
Received: by mailgw18.surf-town.net (Postfix, from userid 65534)
	id A62B11A48E; Tue, 28 Jun 2011 13:53:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw18.surf-town.net (Postfix) with ESMTP id 79E3F1A55B;
	Tue, 28 Jun 2011 13:53:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw18.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw18.surf-town.net ([127.0.0.1])
	by localhost (mailgw18.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 6rk+3+-exjlg; Tue, 28 Jun 2011 13:53:21 +0200 (CEST)
Received: from [10.0.0.17] (AStrasbourg-753-1-48-227.w92-141.abo.wanadoo.fr [92.141.183.227])
	by mailgw18.surf-town.net (Postfix) with ESMTPSA id 1AA1B1A48E;
	Tue, 28 Jun 2011 13:53:18 +0200 (CEST)
In-Reply-To: <4E0980D5.8040004@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176397>

Le mardi 28 juin 2011 =C3=A0 09:20 +0200, Jens Lehmann a =C3=A9crit :
> Am 27.06.2011 23:51, schrieb henri GEIST:
> > Le lundi 27 juin 2011 =C3=A0 12:05 -0700, Junio C Hamano a =C3=A9cr=
it :
> >> Jens Lehmann <Jens.Lehmann@web.de> writes:
> >>
> >>> Am 27.06.2011 18:51, schrieb Junio C Hamano:
> >>>> One possible working tree organization may look like this:
> >>>>
> >>>> 	-+- lib1
> >>>>          +- project1/Makefile -- refers to ../lib1
> >>>>          +- project2/Makefile -- refers to ../lib1
> >>> ...
> >>>> An interesting point your situation raises is that there is no d=
irect way
> >>>> to express module dependencies in .gitmodules file right now, I =
think.
> >>>> Ideally you would want "submodule init project1" to infer automa=
tically
> >>>> that project1 needs lib1 and run "submodule init lib1" for you. =
My gut
> >>>> feeling is that it belongs to .gitmodules of the superproject
> >>>
> >>> That is where this is handled now, but having a submodule refer t=
o a
> >>> submodule outside of it as a dependency is an interesting thought=
=2E But
> >>> as that only matters at the moment you add project1 (and it won't=
 compile
> >>> because ../lib1 is missing, which can easily handled by: "oh, the=
n I have
> >>> to add lib1 as a submodule to the superproject too"), ...
> >>
> >> That is what I called "there is no direct way". Wouldn't it be nic=
er if
> >> the .gitmodules file in the superproject said something like
> >>
> >> 	[module "project one"]
> >> 		path =3D project1
> >>         	url =3D ...
> >>                 depends =3D lib1
> >> 	[module "lib1"]
> >>         	path =3D lib1
> >>                 url =3D ...
> >>
> >> and then "git submodule init project1" run by the end user implied=
 running
> >> also "git submodule init lib1"?
> >>
> >>
> >=20
> > This could be a way if .gitmodules can contain something like
> >=20
> > 	[module "project one"]
> > 		path =3D project1
> >         	url =3D ...
> >                 depends =3D lib1	"123456"
> > 	[module "project two"]
> > 		path =3D project2
> >         	url =3D ...
> >                 depends =3D lib1	"abcdef"
> > 	[module "lib1"]
> >         	path =3D lib1
> >                 url =3D ...
>=20
> But there is no need for that as "123456" and "abcdef" are already pr=
esent
> as the sha1 values for the gitlinks "lib1" and "lib2".
>=20

=46or what I understand of gitlinks reading the git source code it
effectively seem to be the functionality I am looking for.
It seem to be the pointer to the version of the module stored in the
index. Am I right ?

But I dont see a way to put 2 gitlinks pointing on 2 version of the sam=
e
submodule in the index of the superproject. And then specifying
gitlink_1 represent lib1 "123456" the dependency of project_1 and
gitlink_2 represent lib1 "abcdef" the dependency of project_2.

	Henri GEIST
