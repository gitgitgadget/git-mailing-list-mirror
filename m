From: Antti-Juhani Kaijanaho <antti-juhani@kaijanaho.info>
Subject: Re: Usage of isspace and friends
Date: Thu, 13 Oct 2005 11:29:28 +0300
Message-ID: <434E1AE8.9010509@kaijanaho.info>
References: <118833cc0510111840k715e1190l54ad65f821c77848@mail.gmail.com> <7vachd6hdx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Morten Welinder <mwelinder@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 13 10:31:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPyTA-0007q0-8c
	for gcvg-git@gmane.org; Thu, 13 Oct 2005 10:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751553AbVJMI3i convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 13 Oct 2005 04:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbVJMI3i
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Oct 2005 04:29:38 -0400
Received: from flowerpot.kaijanaho.info ([80.68.88.155]:4362 "EHLO
	flowerpot.kaijanaho.info") by vger.kernel.org with ESMTP
	id S1751553AbVJMI3h (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2005 04:29:37 -0400
Received: from [130.234.161.250] (dynamic-161-250.it.jyu.fi [::ffff:130.234.161.250])
  (AUTH: PLAIN gaia, TLS: TLSv1/SSLv3,256bits,AES256-SHA)
  by flowerpot.kaijanaho.info with esmtp; Thu, 13 Oct 2005 11:32:09 +0300
  id 00088005.434E1B89.00000D30
User-Agent: Debian Thunderbird 1.0.7 (X11/20051001)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vachd6hdx.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10066>

Junio C Hamano wrote:
> Morten Welinder <mwelinder@gmail.com> writes:
>>Since str[9] is of type char it should not be used as a argument to
>>isspace directly,
>>but rather be cast to unsigned char:
>>
>>    ... isspace((unsigned char)str[9]);
>=20
>=20
> Huh?  isspace is "int isspace(int)".  Presumably standard
> integral promotion rules applies here whether char is signed or
> unsigned, doesn't it?

Of course, but that's not the issue.  isspace treats its parameter as i=
f
it had been converted from unsigned char to int.  If char is signed,
=C3=AFsspace will mistreat those characters that have a negative value.
Then again, I don't think a space character, one that the C locale
regards as such, anyway, wiill ever have a negative value, so the issue
is rather academic.

> The snippet you quoted is from apply.c, and I would say what is
> more problematic is that we do not force C locale while parsing
> the diff

Quite true.  One reason I tend to avoid the standard is* functions in m=
y
own code.

--=20
Antti-Juhani
