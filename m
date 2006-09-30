From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 5/5] fetch: Clean output
Date: Fri, 29 Sep 2006 19:17:39 -0700
Message-ID: <7vpsdehzcs.fsf@assigned-by-dhcp.cox.net>
References: <87r6xu1rci.fsf@gmail.com> <8764f61r74.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 04:17:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTUQD-0005Hl-Hg
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 04:17:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWI3CRl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 29 Sep 2006 22:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbWI3CRl
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 22:17:41 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:11436 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S964863AbWI3CRk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 22:17:40 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060930021740.MLVF12581.fed1rmmtao02.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 22:17:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id USHb1V00b1kojtg0000000
	Fri, 29 Sep 2006 22:17:36 -0400
To: Santi =?iso-8859-1?Q?B=E9jar?= <sbejar@gmail.com>
In-Reply-To: <8764f61r74.fsf@gmail.com> (Santi =?iso-8859-1?Q?B=E9jar's?=
 message of "Fri, 29
	Sep 2006 20:08:15 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28137>

Santi B=E9jar <sbejar@gmail.com> writes:

> Do not show duplicated remote branch information and reformat the out=
put as:
>
> $ git fetch -v   # the committish lines for the -v.
> * refs/heads/origin: fast forward to remote branch 'master' of ../git=
/
>   1ad7a06..bc1a580
>   committish: bc1a580

I am not quite sure about this --- it is not obvious what these
two numbers represent anymore.  Also I think the last line
outlived its usefulness (99% of the time refs are committish, so
noting exception is good but otherwise it is not interesting).

I know you opted for minimum patch, but it might be a good time
to polish the wording a bit while we are touching the general
vicinity of the code.

How about saying something like:

 * refs/heads/origin: fast forward to remote branch 'master' of ../git/
   old..new =3D 1ad7a06..bc1a580

> * refs/heads/pu: does not fast forward to remote branch 'pu' of ../gi=
t/;
>   7c733a8...5faa935
>   not updating.
>   forcing update.
>   committish: 5faa935

This is even more confusing.  Perhaps we would want to have two
cases, depending on --force (and +).

 * refs/heads/pu: does not fast forward to remote branch 'pu' of ../git=
/;
   but forcing update anyway.  old...new =3D 7c733a8...5faa935

 * refs/heads/pu: does not fast forward to remote branch 'pu' of ../git=
/;
   not updating.  old...new =3D 7c733a8...5faa935
