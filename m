From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH/RFC] autoconf: Add test for OLD_ICONV
Date: Wed, 5 Dec 2007 21:49:35 +0100
Message-ID: <52A4CC8B-EB11-4E3F-A3B6-06826F860E5D@wincent.com>
References: <7vd4u5l29v.fsf@gitster.siamese.dyndns.org> <1196869526-2197-1-git-send-email-jnareb@gmail.com> <ADB12552-AD67-4781-B194-AD15CA4A7B44@wincent.com> <200712051752.28667.jnareb@gmail.com>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=WINDOWS-1252;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 05 21:50:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J01CS-0004o9-KW
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 21:50:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbXLEUuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Dec 2007 15:50:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXLEUuJ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 15:50:09 -0500
Received: from wincent.com ([72.3.236.74]:38099 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751593AbXLEUuI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Dec 2007 15:50:08 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lB5KnalY032077;
	Wed, 5 Dec 2007 14:49:36 -0600
In-Reply-To: <200712051752.28667.jnareb@gmail.com>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67191>

El 5/12/2007, a las 17:52, Jakub Narebski escribi=F3:

> On Wed, 5 December 2007, Wincent Colaiuta wrote:
>>
>> Before applying your patch:
>>
>>     CC utf8.o
>> utf8.c: In function =91reencode_string=92:
>> utf8.c:328: warning: passing argument 2 of =91iconv=92 from incompat=
ible
>> pointer type
>>     CC convert.o
>>
>> After applying your patch:
>>
>>     CC utf8.o
>>     CC convert.o
>
> Do I understand correctly that above is excerpt from the output of th=
e
> following sequence of commands before and after this patch applied?
>
>  $ make configure
>  $ ./configure [options]
>  $ make

Yes, that's right, but with a "make clean" before anything else.

> Do you have something like below in ./configure output?
>
>  configure: CHECKS for header files
>  checking for old iconv()... yes

This:

configure: CHECKS for header files
checking for old iconv()... no

>> This on Darwin Kernel Version 9.1.0 (Mac OS X 10.5.1).
>
> Strange... in Makefile there is
>
>  ifeq ($(uname_S),Darwin)
> 	NEEDS_SSL_WITH_CRYPTO =3D YesPlease
> 	NEEDS_LIBICONV =3D YesPlease
> 	OLD_ICONV =3D UnfortunatelyYes
> 	NO_STRLCPY =3D YesPlease
> 	NO_MEMMEM =3D YesPlease
>  endif
>
> so the uname based guessing should set OLD_ICONV on Darwin...

That happens *before* config.mak.autogen is included in the Makefile, =20
so it gets overridden.

Cheers,
Wincent
