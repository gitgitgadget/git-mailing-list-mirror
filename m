From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: t9106 failure, bisect weirdness
Date: Tue, 20 Nov 2007 05:52:26 +0100
Message-ID: <200711200552.27001.chriscool@tuxfamily.org>
References: <20071119230601.GA15624@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: carbonated beverage <ramune@net-ronin.org>
X-From: git-owner@vger.kernel.org Tue Nov 20 05:46:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuKzu-0002iJ-HZ
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 05:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbXKTEpt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Nov 2007 23:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbXKTEpt
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 23:45:49 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:49159 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752269AbXKTEps convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Nov 2007 23:45:48 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 7DF4B1AB2BA;
	Tue, 20 Nov 2007 05:45:46 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 661B61AB2B2;
	Tue, 20 Nov 2007 05:45:46 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20071119230601.GA15624@net-ronin.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65524>

Le mardi 20 novembre 2007, carbonated beverage a =E9crit :
[...]
> I tried running the test manually and noticed something weird as well=
:
>
> ramune/lycaeum:t: sh t9106-git-svn-dcommit-clobber-series.sh
> *   ok 1: initialize repo
> *   ok 2: (supposedly) non-conflicting change from SVN
> *   ok 3: some unrelated changes to git
> *   ok 4: change file but in unrelated area
> * passed all 4 test(s)
> ramune/lycaeum:t:
> ramune/lycaeum:t: pwd
> /home/ramune/src/git/git/t
> ramune/lycaeum:t:
> ramune/lycaeum:t: sh t9106-git-svn-dcommit-clobber-series.sh
> *   ok 1: initialize repo
> *   ok 2: (supposedly) non-conflicting change from SVN
> *   ok 3: some unrelated changes to git
> * FAIL 4: change file but in unrelated area
>
>                 test x"`sed -n -e 4p < file`" =3D x4 &&
>                 test x"`sed -n -e 7p < file`" =3D x7 &&
>                 perl -i -p -e 's/^4$/4444/' file &&
>                 perl -i -p -e 's/^7$/7777/' file &&
>                 test x"`sed -n -e 4p < file`" =3D x4444 &&
>                 test x"`sed -n -e 7p < file`" =3D x7777 &&
>                 git commit -m '4 =3D> 4444, 7 =3D> 7777' file &&
>                 git svn dcommit &&
>                 svn up tmp &&
>                 cd tmp &&
>                         test x"`sed -n -e 4p < file`" =3D x4444 &&
>                         test x"`sed -n -e 7p < file`" =3D x7777 &&
>                         test x"`sed -n -e 58p < file`" =3D x5588 &&
>                         test x"`sed -n -e 61p < file`" =3D x6611
>
> * failed 1 among 4 test(s)
>
> So it succeeds once, then fails.
>
> /bin/sh is dash 0.5.3-7 from Debian.
>
> Any additional information needed?

Could you try running the test twice when you bisect ?
This way bisecting should give you the real first bad commit.=20

Could you also try to find the line that fails in the 4th test ?
=46or example you could replace all the trailing "&&" in this test with=
 a new=20
line that contains "echo $?".

Thanks in advance,
Christian.
