From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 6/6] sparse: Fix mingw_main() argument number/type errors
Date: Mon, 29 Apr 2013 22:52:45 +0100
Message-ID: <517EEBAD.3090201@ramsay1.demon.co.uk>
References: <517C24D3.8080802@ramsay1.demon.co.uk> <517C6DEF.2050305@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Tue Apr 30 01:33:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxZH-0000Ck-H4
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557Ab3D2XdE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Apr 2013 19:33:04 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:51147 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932368Ab3D2XdB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:33:01 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 50D5C384084;
	Tue, 30 Apr 2013 00:33:00 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 80803384081;
	Tue, 30 Apr 2013 00:32:59 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;
	Tue, 30 Apr 2013 00:32:58 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <517C6DEF.2050305@lsrfire.ath.cx>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222881>

Ren=E9 Scharfe wrote:
> Am 27.04.2013 21:19, schrieb Ramsay Jones:
>> In order to suppress these warnings, since both of the main
>> functions need to be declared with the same prototype, we
>> change the declaration of the 9 main functions, thus:
>>
>>      int main(int argc, char **argv)
>=20
> Why not take the opposite direction with a patch like this?  It's qui=
ck
> and dirty and based on v1.8.1.msysgit.1, as that was the version I ha=
d
> lying around here, but you get the idea.

The main reason (99%) was patch size. I only noticed a "recent trend"
to declare the main() with a 'const char **argv' parameter because,
over the years, I've had to keep adding to this patch. (Having said
that, I suspect it has only been about four additions in four years).

The other 1% is simply that it just looks wrong! (yeah, this new
'const' thingamajig has it's uses, but still ... :-D ).

Just FYI, the C99 standard has this to say:

    c99 standard 5.1.2.2.1 "Program startup"

    The function called at program startup is named main. The
    implementation declares no prototype for this function. It
    shall be defined with a return type of int and with no
    parameters:

        int main(void) { /* ... */ }

    or with two parameters (referred to here as argc and argv,
    though any names may be used, as they are local to the
    function in which they are declared);

        int main(int argc, char *argv[]) { /* ... */ }

    or equivalent;^9 or in some other implementation-defined
    manner.

    [note 9: Thus, int can be replaced by a typedef name
    defined as int, or the type of argv can be written as
    char **argv, and so on.]

    ...

        - The parameters argc and argv and the strings pointed
        to by the argv array shall be modifiable by the program,
        and retain their last-stored values between program
        startup and program termination.


That "... or in some other implementation-defined manner." tends
to make this text somewhat weak!

ATB,
Ramsay Jones
