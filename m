From: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/3] Fold get_merge_bases_clean() into get_merge_bases()
Date: Sun, 02 Jul 2006 22:59:07 +0200
Message-ID: <44A8339B.7070608@lsrfire.ath.cx>
References: <Pine.LNX.4.64.0606301927260.12404@g5.osdl.org>	<7vy7vedntn.fsf@assigned-by-dhcp.cox.net>	<Pine.LNX.4.64.0606302046230.12404@g5.osdl.org>	<20060701150926.GA25800@lsrfire.ath.cx>	<7vfyhldvd2.fsf@assigned-by-dhcp.cox.net>	<44A6CD1D.2000600@lsrfire.ath.cx>	<Pine.LNX.4.64.0607011301480.12404@g5.osdl.org>	<7vveqhccnk.fsf@assigned-by-dhcp.cox.net>	<7vpsgpccak.fsf@assigned-by-dhcp.cox.net>	<20060702094938.GA10944@lsrfire.ath.cx>	<Pine.LNX.4.64.0607020935460.12404@g5.osdl.org>	<44A8051D.6040605@lsrfire.ath.cx> <7vmzbr50b3.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 02 22:59:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx929-0005dJ-SF
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 22:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750830AbWGBU7K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 2 Jul 2006 16:59:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbWGBU7K
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 16:59:10 -0400
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:54241
	"EHLO neapel230.server4you.de") by vger.kernel.org with ESMTP
	id S1750830AbWGBU7J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 16:59:09 -0400
Received: from [10.0.1.3] (p508E49B6.dip.t-dialin.net [80.142.73.182])
	by neapel230.server4you.de (Postfix) with ESMTP id 8B62C1A025;
	Sun,  2 Jul 2006 22:59:08 +0200 (CEST)
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzbr50b3.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23118>

Junio C Hamano schrieb:
> Rene Scharfe <rene.scharfe@lsrfire.ath.cx> writes:
>=20
>>> I suspect the only way to fix that is to make "get_merge_bases()" n=
ot use=20
>>> UNINTERESTING at all, but instead just explicitly use something lik=
e
>> No and yes.  Patch 1 in the 3+1 series changes the flags used in
>> commit.c to not conflict with the ones in revision.h[*].  So we have=
 two
>> different UNINTERESTINGs, and get_merge_bases() doesn't mess up the
>> show/no-show markings.
>=20
> Gaah.  commit.c defines its own UNINTERESTING and you rely on
> not including revision.h which is ... gasp ... #$@#$!!!

You mean crap?  Yes, it is.  That's why I said we should centralize the
commit flags.  There are several duplicate names for different commit
flags in different files.  I couldn't come up with a clean solution, th=
ough.

I have an idea.  Would it help to gather a list of all commit object
flags from the different files?  And then we would come up with unique
names?  And then move the definition of all of them to commit.h?

Ren=E9
