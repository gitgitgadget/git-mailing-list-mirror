From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Wed, 20 Sep 2006 22:08:28 -0700
Message-ID: <7v8xkderhv.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkoeds82.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210211570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 07:09:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQGoF-0007DL-NI
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 07:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbWIUFIa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 21 Sep 2006 01:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbWIUFIa
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 01:08:30 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:7360 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751227AbWIUFI3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Sep 2006 01:08:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921050828.FJIL6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 01:08:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qt8E1V00V1kojtg0000000
	Thu, 21 Sep 2006 01:08:15 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609210211570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 21 Sep 2006 02:17:22 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27450>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 20 Sep 2006, Junio C Hamano wrote:
>
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>=20
>> > 	No longer barfs on new refs, and tries all merge bases (even if I
>> > 	cannot come up with any scenario where there is more than one mer=
ge
>> > 	base in the case of a fast forward).
>>=20
>> Hmm.  If that is the case (and I think it is although I haven't
>> come up with a proof),
>
> From git-fetch.sh:
>
>             # Require fast-forward.
>             mb=3D$(git-merge-base "$local" "$2") &&
>...
> So we indeed assumed that git-merge-base returns the old commit in th=
e=20
> case of a fast-forward (git-merge-base returns just the first item of=
 the=20
> result of get_merge_bases()).

I think this was leftover from the days we na=EFvely assumed that
multiple bases does not matter, and probably needs updating.

> Note that I have no proof that this assumption is true. It might be w=
rong=20
> in this case:
>
>     X - a - b - c - Y
>   /           /
> o - d - e - f
>
> where X is the old commit, and Y is the new commit. But I am too tire=
d to=20
> test it right now.
