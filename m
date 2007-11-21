From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: t9106 failure, bisect weirdness
Date: Wed, 21 Nov 2007 05:08:27 +0100
Message-ID: <200711210508.27455.chriscool@tuxfamily.org>
References: <20071119230601.GA15624@net-ronin.org> <200711200552.27001.chriscool@tuxfamily.org> <20071120061314.GA21819@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: carbonated beverage <ramune@net-ronin.org>
X-From: git-owner@vger.kernel.org Wed Nov 21 05:02:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iugmt-0002d3-Ob
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 05:02:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752500AbXKUEBu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 20 Nov 2007 23:01:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752472AbXKUEBu
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Nov 2007 23:01:50 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:55577 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbXKUEBt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Nov 2007 23:01:49 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 1E7E71AB2B3;
	Wed, 21 Nov 2007 05:01:48 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id C62F91AB2AC;
	Wed, 21 Nov 2007 05:01:47 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <20071120061314.GA21819@net-ronin.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65589>

Le mardi 20 novembre 2007, carbonated beverage a =E9crit :
> > Could you try running the test twice when you bisect ?
> > This way bisecting should give you the real first bad commit.
>
> I re-ran it several times, and also manually -- there were times it'd
> succeed 6 times in a row before failing.  Weird.
>
> Finally, the bisect came down to:
>
>   ramune/lycaeum:git: git bisect good
>   c74d9acf20ba0c69bbd67c5b0bb3bd3c2349cebe is first bad commit
>   commit c74d9acf20ba0c69bbd67c5b0bb3bd3c2349cebe
>   Author: Eric Wong <normalperson@yhbt.net>
>   Date:   Mon Nov 5 03:21:47 2007 -0800
>
>       git-svn: fix dcommit clobbering when committing a series of dif=
fs

Thanks for having done that. Unfortunately I don't know this part of th=
e=20
code, so I cc'ed Eric.

> Modifying the failing t9106-git-svn-dcommit-clobber-series.sh test to
> add touch statements as so:
>
>   test x\"\`sed -n -e 4p < file\`\" =3D x4444 && touch '/tmp/eleven' =
&&
>   test x\"\`sed -n -e 7p < file\`\" =3D x7777 && touch '/tmp/twelve' =
&&
>   test x\"\`sed -n -e 58p < file\`\" =3D x5588 && touch '/tmp/thirtee=
n' &&
>   test x\"\`sed -n -e 61p < file\`\" =3D x6611
>
> Line 52 was the culprit:
>
>   test x\"\`sed -n -e 58p < file\`\" =3D x5588 &&

Ok thanks for doing that too.
Could you also look at the "file" when the test succeed and when it doe=
s not=20
and send us both versions and a diff between them (if it's not too big)=
=2E

Thanks in advance,
Christian.
