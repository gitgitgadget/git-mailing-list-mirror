From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Mon, 27 Jun 2011 23:51:00 +0200
Message-ID: <1309211460.2497.395.camel@Naugrim.eriador.com>
References: <1309180056.2497.220.camel@Naugrim.eriador.com>
	 <7vvcvrxlol.fsf@alter.siamese.dyndns.org> <4E08C89E.5020109@web.de>
	 <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 27 23:50:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QbJgs-0003wF-FL
	for gcvg-git-2@lo.gmane.org; Mon, 27 Jun 2011 23:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754411Ab1F0VtX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Jun 2011 17:49:23 -0400
Received: from mail8.surf-town.net ([212.97.132.48]:54539 "EHLO
	mailgw14.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754033Ab1F0Vsg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2011 17:48:36 -0400
Received: by mailgw14.surf-town.net (Postfix, from userid 65534)
	id A41B83E1EA; Mon, 27 Jun 2011 23:48:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw14.surf-town.net (Postfix) with ESMTP id 7F9BB3E1EA;
	Mon, 27 Jun 2011 23:48:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw14.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw14.surf-town.net ([127.0.0.1])
	by localhost (mailgw14.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jMcnDw2n2LLY; Mon, 27 Jun 2011 23:48:28 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw14.surf-town.net (Postfix) with ESMTPSA id 0C3B83E0EA;
	Mon, 27 Jun 2011 23:48:25 +0200 (CEST)
In-Reply-To: <7vvcvrw0vn.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176373>

Le lundi 27 juin 2011 =C3=A0 12:05 -0700, Junio C Hamano a =C3=A9crit :
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>=20
> > Am 27.06.2011 18:51, schrieb Junio C Hamano:
> >> One possible working tree organization may look like this:
> >>=20
> >> 	-+- lib1
> >>          +- project1/Makefile -- refers to ../lib1
> >>          +- project2/Makefile -- refers to ../lib1
> > ...
> >> An interesting point your situation raises is that there is no dir=
ect way
> >> to express module dependencies in .gitmodules file right now, I th=
ink.
> >> Ideally you would want "submodule init project1" to infer automati=
cally
> >> that project1 needs lib1 and run "submodule init lib1" for you. My=
 gut
> >> feeling is that it belongs to .gitmodules of the superproject
> >
> > That is where this is handled now, but having a submodule refer to =
a
> > submodule outside of it as a dependency is an interesting thought. =
But
> > as that only matters at the moment you add project1 (and it won't c=
ompile
> > because ../lib1 is missing, which can easily handled by: "oh, then =
I have
> > to add lib1 as a submodule to the superproject too"), ...
>=20
> That is what I called "there is no direct way". Wouldn't it be nicer =
if
> the .gitmodules file in the superproject said something like
>=20
> 	[module "project one"]
> 		path =3D project1
>         	url =3D ...
>                 depends =3D lib1
> 	[module "lib1"]
>         	path =3D lib1
>                 url =3D ...
>=20
> and then "git submodule init project1" run by the end user implied ru=
nning
> also "git submodule init lib1"?
>=20
>=20

This could be a way if .gitmodules can contain something like

	[module "project one"]
		path =3D project1
        	url =3D ...
                depends =3D lib1	"123456"
	[module "project two"]
		path =3D project2
        	url =3D ...
                depends =3D lib1	"abcdef"
	[module "lib1"]
        	path =3D lib1
                url =3D ...



Henri GEIST
