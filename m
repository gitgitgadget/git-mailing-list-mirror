From: "Matthias Andree" <matthias.andree@gmx.de>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Fri, 15 May 2009 18:14:07 +0200
Message-ID: <op.utzbdtb91e62zd@merlin.emma.line.org>
References: <op.utv93sdo1e62zd@merlin.emma.line.org>
 <op.utwdsutn1e62zd@merlin.emma.line.org>
 <7v8wl01iev.fsf@alter.siamese.dyndns.org>
 <op.utwyczlf1e62zd@merlin.emma.line.org>
 <20090514182249.GA11919@sigill.intra.peff.net>
 <op.utxydvnu1e62zd@merlin.emma.line.org>
 <20090515020206.GA12451@coredump.intra.peff.net> <op.uty0pjb51e62zd@balu>
 <m34ovmlcve.fsf@localhost.localdomain> <4A0D8211.5010806@viscovery.net>
 <81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Jakub Narebski" <jnareb@gmail.com>, "Jeff King" <peff@peff.net>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org,
	"Brandon Casey" <casey@nrlssc.navy.mil>,
	"Sverre Rabbelier" <srabbelier@gmail.com>
To: "Alex Riesen" <raa.lkml@gmail.com>,
	"Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 15 18:14:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M503m-00004z-8I
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 18:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762275AbZEOQOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 May 2009 12:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758621AbZEOQOO
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 12:14:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:38136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755841AbZEOQON (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 12:14:13 -0400
Received: (qmail invoked by alias); 15 May 2009 16:14:10 -0000
Received: from e177186088.adsl.alicedsl.de (EHLO mandree.no-ip.org) [85.177.186.88]
  by mail.gmx.net (mp045) with SMTP; 15 May 2009 18:14:10 +0200
X-Authenticated: #428038
X-Provags-ID: V01U2FsdGVkX19yYs94WZhypiGGJ5/HxPH7N/CQLNr5WkuTUQbW0H
	L0LVzIHtv0kp2u
Received: from merlin.emma.line.org (localhost [127.0.0.1])
	by merlin.emma.line.org (Postfix) with ESMTP id B984F945D0;
	Fri, 15 May 2009 18:14:07 +0200 (CEST)
In-Reply-To: <81b0412b0905150851q232b3f6s95df89e72d4dc381@mail.gmail.com>
User-Agent: Opera Mail/9.64 (Linux)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119262>

Am 15.05.2009, 17:51 Uhr, schrieb Alex Riesen <raa.lkml@gmail.com>:

> 2009/5/15 Johannes Sixt <j.sixt@viscovery.net>:
>> Jakub Narebski schrieb:
>>> "Matthias Andree" <matthias.andree@gmx.de> writes:
>>>> =C2=A0 =C2=A0 =C2=A0commit <-- signed-by-- NIL (removed) <--signed=
-by-- tag1.
>>>
>>> THIS IS A FEATURE, NOT A BUG.
>>
>> Please stop it. Everone agrees about this.
>>
>> Matthias only wants a patch like below. Matthias, if you are serious=
 =20
>> about it, please pick this up and turn it into a proper submission. =
I =20
>> don't care enough.
>>
> ...
>> + =C2=A0 =C2=A0 =C2=A0 if ((tag_object =3D (struct tag *)parse_objec=
t(object)) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag_object->object.type =3D=3D =
OBJ_TAG &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tag_object->tag &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !strcmp(tag_object->tag, tag)) =
{
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("A tag cann=
ot tag itself. If you meant to tag the =20
>> commit");
>
> If it ever turned into submission, I'll always patch this out. It is =
=20
> stupid.

I seem to lack intermediate messages, probably queued somewhere, yet I'=
ll =20
respond already.

Moving a tag on top of itself is just stupid. The result of git -f does=
n't =20
properly match documentation IMO. There is no clear consensus if it's =20
"gone". It's gone from the refs/ namespace, but kept in the object spac=
e, =20
so there's a split meaning of "replace" or "delete" here.

Arguably, we already need to say -f once, but nothing prevents me from =
=20
using git tag -d first and then tag the dangling old_tag1 object to rev=
ive =20
it.

Nobody has shown valid reasons of existence for such tags, or valid =20
semantics, or use cases.

It's confusing =3D> usability problem =3D> let's put a warning there. I=
'm not =20
sure if "error()" is the right function to call here, since I don't hav=
e =20
the full patch to look at.

At any rate, a policy of obstruction is as invalid as anything.

--=20
Matthias Andree
