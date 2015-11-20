From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [BUG] gitk --all and git bisect visualize crash in non-english locale
Date: Fri, 20 Nov 2015 15:49:08 +0100
Message-ID: <vpqk2pchgkb.fsf@anie.imag.fr>
References: <vpqa8qbrwgc.fsf@anie.imag.fr>
	<1447883599.28206.1.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Paul Mackerras <paulus@samba.org>
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>
X-From: git-owner@vger.kernel.org Fri Nov 20 15:50:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zzn0H-0000zJ-0F
	for gcvg-git-2@plane.gmane.org; Fri, 20 Nov 2015 15:49:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760254AbbKTOt2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2015 09:49:28 -0500
Received: from mx1.imag.fr ([129.88.30.5]:46954 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbbKTOt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2015 09:49:26 -0500
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id tAKEn7gR012383
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 20 Nov 2015 15:49:07 +0100
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id tAKEn8sG014341;
	Fri, 20 Nov 2015 15:49:08 +0100
In-Reply-To: <1447883599.28206.1.camel@kaarsemaker.net> (Dennis Kaarsemaker's
	message of "Wed, 18 Nov 2015 22:53:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Fri, 20 Nov 2015 15:49:07 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: tAKEn7gR012383
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1448635751.95514@u0dyshYZ5EyUS3PNoJf/Ag
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281522>

Indeed. I should obviously have started by updating my master branch,
sorry for the noise.

Thanks,

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> Hi Matthieu,
>
> This has been reported quite a few times before. A fix is in master,
> see 482456a^2 and children.
>
> On wo, 2015-11-18 at 19:31 +0100, Matthieu Moy wrote:
>> Hi,
>>=20
>> I'm getting the following crash on recent gitk:
>>=20
>>   $ LANG=3Dfr_FR gitk --all
>>   Error in startup script: bad menu entry index "=C9diter la vue..."
>>       while executing
>>   ".bar.view entryconf [mca "Edit view..."] -state normal"
>>       invoked from within
>>   "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd
>> ne {}} {
>>       # create a view for the files/dirs specified on the command
>> line
>>       se..."
>>       (file "/home/moy/local/usr-jessie/bin/gitk" line 12442)
>>=20
>> It's linked to the locale:
>>=20
>>   $ LANG=3DC gitk --all
>>   # Just works
>>=20
>> but does not seem to be related to French in particular nor to the
>> accent:
>>=20
>>   $ LANG=3Des_ES gitk --all
>>   Error in startup script: bad menu entry index "Modificar vista..."
>>       while executing
>>   ".bar.view entryconf [mca "Edit view..."] -state normal"
>>       invoked from within
>>   "if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd
>> ne {}} {
>>       # create a view for the files/dirs specified on the command
>> line
>>       se..."
>>       (file "/home/moy/local/usr-jessie/bin/gitk" line 12442)
>>=20
>> It also works fine without --all.
>>=20
>> It bisects down to:
>>=20
>> commit d99b4b0de27a2bd654a40353b65883e368da6d06
>> Author: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>> Date:   Wed Sep 9 15:20:53 2015 +0200
>>=20
>>     gitk: Accelerators for the main menu
>>    =20
>>     This allows fast, keyboard-only usage of the menu (e.g. Alt+V, N
>> to open a
>>     new view).
>>    =20
>>     Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>>     Signed-off-by: Paul Mackerras <paulus@samba.org>
>>=20
>> I'm not fluent enough in Tcl to fix this myself, sorry ;-).
>>=20
>> Thanks,
>>=20

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
