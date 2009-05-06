From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Thu, 7 May 2009 09:07:00 +1000
Message-ID: <fcaeb9bf0905061607n51457fa3x3a198c61911d0228@mail.gmail.com>
References: <20090506055913.GA9701@dektop> <4A01320A.2050600@viscovery.net> 
	<fcaeb9bf0905052357v6773cbf5i12795c1866a80783@mail.gmail.com> 
	<loom.20090506T091628-717@post.gmane.org> <alpine.DEB.1.00.0905061137300.14230@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 07 01:07:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1qDM-0001oG-AO
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 01:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756514AbZEFXHW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 May 2009 19:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756075AbZEFXHV
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 19:07:21 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:46079 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755768AbZEFXHU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 May 2009 19:07:20 -0400
Received: by gxk10 with SMTP id 10so745751gxk.13
        for <git@vger.kernel.org>; Wed, 06 May 2009 16:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dIZgNFpGtpMSVzlO7pbbqjRxpIrBByx17SgZnpi1Jxo=;
        b=m2vDH0Om1MXTczxjkMk2Q+z2zu3KINSuSgfgM1aOUsZd3Q+EF7m6RQtlODEWUpLSMD
         sJkKQNozzY7ersG5Cj53BHcUZGekvRq57SWkgoQraImhVxPtSqOzlmRJEQFkh9VSyrIT
         LriMpZ7DgGDgyHNIPghrUcPLY5XaI5NVOytC4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z5EHvYNW/Gbl5b7vyAUkjxntomjpeCq+QcxkjLWlNJ4Vdyv25WKk30j3nZ7JjQZg6D
         U6n53YOSA+HrCXO/0C8o0EVA2WAmDDyt9VdXmq3aP73G5JrIlRzIjL9+150F+F4DruCZ
         WFKJk8A6K3iVNwrAk5J6uC51CxbAePQB2YRCk=
Received: by 10.100.120.15 with SMTP id s15mr3937930anc.86.1241651240274; Wed, 
	06 May 2009 16:07:20 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0905061137300.14230@intel-tinevez-2-302>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118405>

On Wed, May 6, 2009 at 7:38 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 6 May 2009, Ralf Wildenhues wrote:
>
>> Nguyen Thai Ngoc Duy writes:
>> > On Wed, May 6, 2009 at 4:45 PM, Johannes Sixt wrote:
>> > > Nguyen Thai Ngoc Duy schrieb:
>> > >> =C2=A0 =C2=A0 =C2=A0 # normalize path:
>> > >> =C2=A0 =C2=A0 =C2=A0 # multiple //; leading ./; /./; /../; trai=
ling /
>> > >> =C2=A0 =C2=A0 =C2=A0 path=3D$(printf '%s/\n' "$path" |
>> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -e '
>> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s|//*|/|g
>> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s|^\(\./\)*||
>> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s|/\./|/|g
>> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 :start
>> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s|\([^/]*\)/\.\./||
>> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 tstart
>> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 s|/*$||
>> > >> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ')
>>
>> > It says nothing. The result of "printf '%s\n' ./foo/bar | sed -e b=
lah"
>> > is just wrong, (i.e. "./" remains). I stripped down to "sed -e
>> > 's|^\(\./\)*||'", does not work. Probably due to \( \) pair. Skimm=
ed
>> > through sed manpage, seems no mention of bracket grouping.
>>
>> Quoting 'info Autoconf "Limitation of Usual Tools"':
>>
>> =C2=A0 =C2=A0 =C2=A0Some `sed' implementations, e.g., Solaris, restr=
ict the special
>> =C2=A0 =C2=A0 =C2=A0role of the asterisk to one-character regular ex=
pressions. =C2=A0This
>> =C2=A0 =C2=A0 =C2=A0may lead to unexpected behavior:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ echo '1*23*4' | /usr/bin/sed 's=
/\(.\)*/x/g'
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x2x4
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $ echo '1*23*4' | /usr/xpg4/bin/s=
ed 's/\(.\)*/x/g'
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 x
>>
>> You can work around it in this case with
>> =C2=A0 :again
>> =C2=A0 s|^\./||
>> =C2=A0 t again
>>
>> BTW, you should put a space between t and the label (but not between
>> : and label), POSIX requires that and some sed versions expect it.
>
> Maybe the time is better spent on turning submodule into a builtin, b=
efore
> it gets even larger, and before we have to jump through even more hoo=
ps
> because of shell compatibility issues?

Totally agree. git-submodule is the second largest shell script.
Better do it now or it will take git-rebase--interactive position as
the biggest one.
--=20
Duy
