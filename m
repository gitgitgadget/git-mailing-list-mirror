From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 5 Dec 2007 22:19:00 +0100
Message-ID: <200712052219.00930.jnareb@gmail.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <200712051752.28667.jnareb@gmail.com> <52A4CC8B-EB11-4E3F-A3B6-06826F860E5D@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 22:19:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J01eW-0007vI-82
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 22:19:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbXLEVTL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 16:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751704AbXLEVTL
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 16:19:11 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:8233 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbXLEVTK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 16:19:10 -0500
Received: by nf-out-0910.google.com with SMTP id g13so3224317nfb
        for <git@vger.kernel.org>; Wed, 05 Dec 2007 13:19:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=A1XEVMKyTxW0Wr7k6F5/5CHpst7UxKtryDjpxqx/x1I=;
        b=CiP02km2vxzWT+zAkjmMVT7el7l7OISvduAxfbWZtHHsVNOC5aQ9VJOUkHHd6YqrNAnlcggV+d31hUVbVBN+9/JFHNlb/SiaFIETewecZ84iTBon66TVDIs8jFiPdv8vrkZJZb5KZJP/xWbkun/G6/U7lkCwgDFpfZBKvvp28vI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=qT3ep3XDhbpmP9dxH2exd1R8R9zZAgpuoXRydNX3XibIi04rq9YmK4UrUPc+viP0gBbuLvblIh7QS8QXMHe0Zf8W0nYLYdH1hwrXbTJKSaW/PMe7S5/UrKkEK7AndU9MnvhUFKSaurVY3eYIQvryWihAw19W4tDg1G2SEXam9Fw=
Received: by 10.78.206.9 with SMTP id d9mr1312950hug.1196889548450;
        Wed, 05 Dec 2007 13:19:08 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.243.182])
        by mx.google.com with ESMTPS id g8sm91399muf.2007.12.05.13.19.05
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Dec 2007 13:19:06 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <52A4CC8B-EB11-4E3F-A3B6-06826F860E5D@wincent.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67195>

Wincent Colaiuta wrote:
> El 5/12/2007, a las 17:52, Jakub Narebski escribi=F3:
>> On Wed, 5 December 2007, Wincent Colaiuta wrote:
>>>
>>> Before applying your patch:
>>>
>>>     CC utf8.o
>>> utf8.c: In function =91reencode_string=92:
>>> utf8.c:328: warning: passing argument 2 of =91iconv=92 from incompa=
tible
>>> pointer type
>>>     CC convert.o
>>>
>>> After applying your patch:
>>>
>>>     CC utf8.o
>>>     CC convert.o
>>
>> Do I understand correctly that above is excerpt from the output of t=
he
>> following sequence of commands before and after this patch applied?
>>
>>  $ make configure
>>  $ ./configure [options]
>>  $ make
>=20
> Yes, that's right, but with a "make clean" before anything else.
>=20
>> Do you have something like below in ./configure output?
>>
>>  configure: CHECKS for header files
>>  checking for old iconv()... yes
>=20
> This:
>=20
> configure: CHECKS for header files
> checking for old iconv()... no
>=20
>>> This on Darwin Kernel Version 9.1.0 (Mac OS X 10.5.1).
>>
>> Strange... in Makefile there is
>>
>>  ifeq ($(uname_S),Darwin)
>> 	NEEDS_SSL_WITH_CRYPTO =3D YesPlease
>> 	NEEDS_LIBICONV =3D YesPlease
>> 	OLD_ICONV =3D UnfortunatelyYes
>> 	NO_STRLCPY =3D YesPlease
>> 	NO_MEMMEM =3D YesPlease
>>  endif
>>
>> so the uname based guessing should set OLD_ICONV on Darwin...
>=20
> That happens *before* config.mak.autogen is included in the Makefile,=
 =20
> so it gets overridden.

Ahhh... now I understand. You have installed new iconv() on your
computer, and generic 'uname -s' (OS name) based guessing in Makefile
guesses wrongly that you need OLD_ICONV, while ./configure script
actually tests it and correctly decides to unset OLD_ICONV !


BTW. Perhaps it whould be written more explicitely:

+AC_COMPILE_IFELSE(OLDICONVTEST_SRC,
+       [AC_MSG_RESULT([no])
+       OLD_ICONV=3D],
+       [AC_MSG_RESULT([yes])
+       OLD_ICONV=3DYesPlease])


--=20
Jakub Narebski
Poland
