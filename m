From: henri GEIST <henri.geist@flying-robots.com>
Subject: Re: tracking submodules out of main directory.
Date: Thu, 04 Aug 2011 00:41:38 +0200
Message-ID: <1312411298.3261.1041.camel@Naugrim.eriador.com>
References: <1311932377.3734.182.camel@Naugrim.eriador.com>
	 <4E34122B.5020509@web.de> <1312062927.3261.334.camel@Naugrim.eriador.com>
	 <4E370107.3050002@web.de> <1312287584.3261.798.camel@Naugrim.eriador.com>
	 <4E384510.1070803@web.de> <20110803062536.GB33203@book.hvoigt.net>
	 <1312374382.3261.913.camel@Naugrim.eriador.com>
	 <7v8vractdw.fsf@alter.siamese.dyndns.org> <4E399C62.30604@web.de>
	 <20110803214530.GA34347@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Aug 04 00:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qok5F-0000Z6-F3
	for gcvg-git-2@lo.gmane.org; Thu, 04 Aug 2011 00:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755829Ab1HCWid convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 18:38:33 -0400
Received: from mail7.surf-town.net ([212.97.132.47]:39122 "EHLO
	mailgw6.surf-town.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755744Ab1HCWic (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 18:38:32 -0400
Received: by mailgw6.surf-town.net (Postfix, from userid 65534)
	id 265245F98F; Thu,  4 Aug 2011 00:38:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by mailgw6.surf-town.net (Postfix) with ESMTP id E5DCF5F734;
	Thu,  4 Aug 2011 00:38:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mailgw6.surf-town.net
X-Spam-Flag: NO
X-Spam-Score: -1.44
X-Spam-Level: 
X-Spam-Status: No, score=-1.44 tagged_above=-999 required=7
	tests=[ALL_TRUSTED=-1.44] autolearn=disabled
Received: from mailgw6.surf-town.net ([127.0.0.1])
	by localhost (mailgw6.surf-town.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id QOo83dJa-o7u; Thu,  4 Aug 2011 00:38:24 +0200 (CEST)
Received: from [192.168.0.6] (se167-1-82-242-149-125.fbx.proxad.net [82.242.149.125])
	by mailgw6.surf-town.net (Postfix) with ESMTPSA id 184695F98F;
	Thu,  4 Aug 2011 00:38:18 +0200 (CEST)
In-Reply-To: <20110803214530.GA34347@book.hvoigt.net>
X-Mailer: Evolution 2.30.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178642>

Le mercredi 03 ao=C3=BBt 2011 =C3=A0 23:45 +0200, Heiko Voigt a =C3=A9c=
rit :
> Hi,
>=20
> On Wed, Aug 03, 2011 at 09:07:14PM +0200, Jens Lehmann wrote:
> > Am 03.08.2011 19:11, schrieb Junio C Hamano:
> > But the superproject is still the place to say: I know these versio=
ns of
> > all submodules work together, so I commit their gitlinks here. But =
this
> > scheme enables submodules to give hints to help the superproject's =
user.
> >=20
> > > I also suspect that allowing each submodule to know and demand sp=
ecific
> > > versions of other submodules will lead to inconsistencies. Which =
version
> > > of submodule C would you demand to have when submodule A wants ve=
rsion C0
> > > and submodule B wants version C1 of it?
> >=20
> > Right, in the discussion so far it seemed like henri seems to be th=
e only
> > user who is wanting an exact match, and he says he needs to see the=
se
> > inconsistencies. But I think he can modify the "version xxx or newe=
r" to
> > his needs without imposing these inconsistencies on users (like me)=
 who
> > don't want to see them.
>=20
> And I imagine if a submodule has such hints we could add a command sa=
y
>=20
> 	git submodule resolve-dependencies
>=20
> which could resolve such "I need a version newer than" hints given by=
 a
> submodule to help the user to update a submodule in the superproject.
>=20
> Disclaimer: I think we need to think about all the implications such =
a
> scheme introduces very carefully. The picture is still a bit blurry f=
or
> me.
>=20

As I see it if you want a command like
"git submodule resolve-dependencies"

  - the process need to decide if it will chose te lower version above
    all requierments or directly the head.
  - if one or more say I want exactly this version and it is not
    satisfied we need at least a warning.
  - We need to issue an error if all the required version can not be
    found in the same branch.

	Henri
