From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 03 Aug 2011 14:26:22 +0200
Message-ID: <1312374382.3261.913.camel@Naugrim.eriador.com>
References: <4E0A08AE.8090407@web.de>
	 <1311792580.2413.82.camel@Naugrim.eriador.com>
	 <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de>
	 <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de>
	 <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de>
	 <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de>
	 <20110803062536.GB33203@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Alexei Sholik <alcosholik@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 14:23:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoaTq-0001Ua-3X
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 14:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755560Ab1HCMXS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 08:23:18 -0400
Received: from mailgw1.surf-town.net ([212.97.132.64]:60037 "EHLO
	mailgw12.surf-town.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755015Ab1HCMXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 08:23:16 -0400
Received: by mailgw12.surf-town.net (Postfix, from userid 65534)
	id 10E4319B38A; Wed,  3 Aug 2011 14:23:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw12.surf-town.net (Postfix) with ESMTP id D17C819B37A;
	Wed,  3 Aug 2011 14:23:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw12.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw12.surf-town.net ([127.0.0.1])
	by localhost (mailgw12.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id ux3oPaAQkG7H; Wed,  3 Aug 2011 14:23:09 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw12.surf-town.net (Postfix) with ESMTPSA id 7FF5319B392;
	Wed,  3 Aug 2011 14:23:03 +0200 (CEST)
In-Reply-To: <20110803062536.GB33203@book.hvoigt.net>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178563>

Le mercredi 03 ao=C3=BBt 2011 =C3=A0 08:25 +0200, Heiko Voigt a =C3=A9c=
rit :
> Hi Henri,
>=20
> On Tue, Aug 02, 2011 at 08:42:24PM +0200, Jens Lehmann wrote:
> > Am 02.08.2011 14:19, schrieb henri GEIST:
> > > Le lundi 01 ao??t 2011 ?? 21:39 +0200, Jens Lehmann a ??crit :
> > >> Am 30.07.2011 23:55, schrieb henri GEIST:
> > >>> I can not see the difference with a gitlink.
> > >>
> > >> Then you can just use a config file for that, no? ;-)
> > >=20
> > > Off corse, I immediately start to work on it.
> >=20
> > I'm looking forward to that!
>=20
> Before hacking away please share some design information about this.
>=20

Ok this is what I intend to do.

I plan to use a config file containing lines like

"path_to_poited_repo   SHA1_of_intended_commit   URL_of_origin"

the URL part will not be required.

this file will be a list of pointer to other project.

I have plane to name the file ".gitdependencies" and put it at the root
of the current repository.


Then I will :

1) Adding to git-status the ability to scan this file and report :
   - if the repository pointed by the path does not exist
   - if the SHA1 of the current checkout of this repository mismatch.
   - if this repository content differ from its checkout.

2) Adding to git status the ability to say if the current checkout has
   the expected one in its ancestors.

3) Adding to git-add the ability to:
   - create/update this file when trying to add an external repository
   - giving up if it is not an external repository.
   - automatically add the dependency file as well.

4) Adding to git-rm the ability to:
   - remove lines in this file.
   - add the result to index.
   - maybe removing the complete file if it is empty.

5) Adding to git-reset the ability to:
   - reset those lines one by one.
   - adding the the file to the index.

I think I will do those steps as separate commits because they can work=
s
independently. it just need you to do the unimplemented step manually
until it is done.

That is a first proposal, all your comment will be appreciate.

> Another thing:
>=20
> It sounds like the workflow you want to achieve is similar to the one
> the android developers are using. They have a lot of submodules which
> need automatic updating.
>=20
> The last time I checked they used repo (similar tool to submodules)
> together with gerrit.
>=20
> AFAIR they wanted to switch to submodules and have gerrit automatical=
ly
> make the superproject commits for single submodule changes. Additiona=
lly
> if a change involves multiple submodules the developer should be able=
 to
> tie them together using a superproject commit.
>=20
> Have a look over there whether that workflow might help you?

I just add a quick look on the android web site and I did not understan=
d
what exactly repo do.

All there documentation only say how to install it and checkout android
but it dose not explain anything about repo itself.

I will search more info about it.

	Henri GEIST
