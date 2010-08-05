From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [BUG] git gui blame  fails for multi-word textconv filter
Date: Thu, 05 Aug 2010 23:58:42 +0100
Message-ID: <87iq3osm3h.fsf@fox.patthoyts.tk>
References: <20100804192525.GA13086@landau.phys.spbu.ru>
	<4C59FBD5.5090209@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kirill Smelkov <kirr@landau.phys.spbu.ru>, git@vger.kernel.org
To: =?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 06 01:13:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh9cd-0001bZ-NN
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 01:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758605Ab0HEXNG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Aug 2010 19:13:06 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:37208 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757837Ab0HEXNE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 19:13:04 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Oh9cN-0002sb-Nx; Fri, 06 Aug 2010 00:12:55 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Oh9Oe-0005LV-5C; Thu, 05 Aug 2010 23:58:44 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 53FD021EC3; Thu,  5 Aug 2010 23:58:43 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <4C59FBD5.5090209@ensimag.imag.fr> (=?iso-8859-1?Q?=22Cl=E9me?=
 =?iso-8859-1?Q?nt?= Poulain"'s message
	of "Thu, 05 Aug 2010 01:46:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152737>

Cl=A8=A6ment Poulain <clement.poulain@ensimag.imag.fr> writes:

>Le 04/08/2010 21:25, Kirill Smelkov a =A8=A6crit :
>> Hello,
>>
>> I use
>>
>>      [diff "astextplain"]
>>          textconv =3D run-mailcap --action=3Dcat
>>
>> in my ~/.gitconfig, and this works for git `git blame` because of 41=
a457
>> in git.git (textconv: use shell to run helper), but fails with git g=
ui:
>>
>>      $ git gui blame 21980.2--=A7=AA=A7=AE=A7=B3-=A7=AE=A7=B2231.doc
>>      Error in startup script: couldn't execute "run-mailcap --action=
=3Dcat": no such file or directory
>>   =20
>I wonder if spaces can be the reason of this. Looks like Tcl is
>looking for an executable called "run-mailcap --action=3Dcat", and
>doesn't distinguish path from options.

indeed. We passed a 2-element list and the first element is the
command. To permit this we need to append the pathname to the command
instead.
  open |[linsert $path 0 $cmd_plus_args_list]
is a safe way to do that.

I should have thought of that too and not just repos with spaces in the=
 path.

--=20
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
