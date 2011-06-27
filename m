From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 23:57:20 +0200
Message-ID: <1309211840.2497.401.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>  <4E08DCB1.3080503@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jun 27 23:58:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbJpT-0000Iw-DK
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 23:58:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754885Ab1F0VzG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 17:55:06 -0400
Received: from mail13.surf-town.net ([212.97.132.53]:40746 "EHLO
	mailgw7.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754059Ab1F0Vyu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 17:54:50 -0400
Received: by mailgw7.surf-town.net (Postfix, from userid 65534)
	id 3A28BEBC0F; Mon, 27 Jun 2011 23:54:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw7.surf-town.net (Postfix) with ESMTP id 18E13EBADF;
	Mon, 27 Jun 2011 23:54:49 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw7.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw7.surf-town.net ([127.0.0.1])
	by localhost (mailgw7.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id UYGHwtAoLjQK; Mon, 27 Jun 2011 23:54:43 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw7.surf-town.net (Postfix) with ESMTPSA id 7C9A9EBC0F;
	Mon, 27 Jun 2011 23:54:41 +0200 (CEST)
In-Reply-To: <4E08DCB1.3080503@web.de>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176374>

Le lundi 27 juin 2011 =C3=A0 21:40 +0200, Jens Lehmann a =C3=A9crit :
> Am 27.06.2011 21:05, schrieb Junio C Hamano:
> > Jens Lehmann <Jens.Lehmann@web.de> writes:
> >=20
> >> Am 27.06.2011 18:51, schrieb Junio C Hamano:
> >>> One possible working tree organization may look like this:
> >>>
> >>> 	-+- lib1
> >>>          +- project1/Makefile -- refers to ../lib1
> >>>          +- project2/Makefile -- refers to ../lib1
> >> ...
> >>> An interesting point your situation raises is that there is no di=
rect way
> >>> to express module dependencies in .gitmodules file right now, I t=
hink.
> >>> Ideally you would want "submodule init project1" to infer automat=
ically
> >>> that project1 needs lib1 and run "submodule init lib1" for you. M=
y gut
> >>> feeling is that it belongs to .gitmodules of the superproject
> >>
> >> That is where this is handled now, but having a submodule refer to=
 a
> >> submodule outside of it as a dependency is an interesting thought.=
 But
> >> as that only matters at the moment you add project1 (and it won't =
compile
> >> because ../lib1 is missing, which can easily handled by: "oh, then=
 I have
> >> to add lib1 as a submodule to the superproject too"), ...
> >=20
> > That is what I called "there is no direct way". Wouldn't it be nice=
r if
> > the .gitmodules file in the superproject said something like
> >=20
> > 	[module "project one"]
> > 		path =3D project1
> >         	url =3D ...
> >                 depends =3D lib1
> > 	[module "lib1"]
> >         	path =3D lib1
> >                 url =3D ...
> >=20
> > and then "git submodule init project1" run by the end user implied =
running
> > also "git submodule init lib1"?
>=20
> And if lib1 happens to have another dependency, that will be initiali=
zed
> too? That would make life much easier for users who only want certain
> submodules populated to work on, as they won't have to chase compile
> errors anymore until they found all necessary submodules ... very nic=
e.
>=20

That is right.
But could also be done with the .gitmodules in project1 containing

	[module "lib1"]
        	path =3D ../lib1
                url =3D ...

and making implicite if the module is describe in .gitmodules that
mean ./ depend on it.

	Henri GEIST
