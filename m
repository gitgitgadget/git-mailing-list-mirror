From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH] remote show: fix the -n option
Date: Mon, 09 Jun 2008 06:16:21 +0200
Message-ID: <484CAE95.3020008@free.fr>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <alpine.DEB.1.00.0806090212270.1783@racer> <484C901B.6000401@free.fr> <alpine.DEB.1.00.0806090330490.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 09 06:17:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5YoZ-0005jI-Lb
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 06:17:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750997AbYFIEQK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2008 00:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbYFIEQJ
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 00:16:09 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:35716 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750784AbYFIEQI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 00:16:08 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id B449512B6B6;
	Mon,  9 Jun 2008 06:16:05 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 6EB2812B6B0;
	Mon,  9 Jun 2008 06:16:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <alpine.DEB.1.00.0806090330490.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84359>

Johannes Schindelin a =E9crit :
>=20
> No, I think that the information about stale branches and if the bran=
ches=20
> are up-to-date is missing.  In that sense, it is not like "route -n" =
at=20
> all, which just skips one convenience step, but really a dry run, bec=
ause=20
> the result is different (as opposed to differently displayed).

Am I wrong if I say that dry run is for commands that modify something?=
 For
example there is no "diff --dry-run" probably because diff does not cha=
nge
anything. A dry run has no real meaning for diff.

This the same for "git remote show": it's a read-only command, it just =
display
a summary of the remote and does not modify anything. With -n, it just =
skips
the ls-remote (read-only) step and yes the result can be different, som=
e parts
can be missing. Exactly like "route -n", we skip the dns resolution, th=
e host
names are missing.

Now, if we talk about "prune", I completely agree. A --dry-run flag mak=
e sens.
But it's not the same thing than the "show -n" one. For what reason wou=
ld I
want to ask "prune" to skip the ls-remote step? What I would find more =
useful
is to make "prune" show what it is doing (like "update") and add a --dr=
y-run
option to say "just show me, but do not touch anything". And we can eve=
n add a
-p flag to "update" to say "prune at the same time".

> It is a too long line (way over 80 characters).  So yes, you should w=
rap=20
> after the NULL here.

Will fix. (my tabs were only 4 spaces long)

>> In fact, it seems that get_ref_states() always return 0 or just die =
when=20
>> an error occur. And that transport_get_remote_refs() never return if=
=20
>> something goes wrong.
>>
>> So, what about removing got_states and use !no_query instead ?
>=20
> Hrmpf.  I did not mean to die() there...

I don't understand. Is it ok or not?

Thanks for your comments,
Olivier.
