From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 2/2] [TopGit] Portability: Don't use alternation ("|")
	in sed regular expressions
Date: Thu, 12 Mar 2009 16:20:39 +0100
Message-ID: <20090312152039.GA15626@pengutronix.de>
References: <78BA729B-0026-45D0-96FC-330700519AAB@dartmouth.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
To: Brian Campbell <brian.p.campbell@dartmouth.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 16:29:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhmkF-0000yb-1Y
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 16:22:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756509AbZCLPUq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Mar 2009 11:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437AbZCLPUq
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 11:20:46 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58425 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696AbZCLPUp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 11:20:45 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lhmi9-0007hj-FA; Thu, 12 Mar 2009 16:20:41 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1Lhmi7-00044E-62; Thu, 12 Mar 2009 16:20:39 +0100
Content-Disposition: inline
In-Reply-To: <78BA729B-0026-45D0-96FC-330700519AAB@dartmouth.edu>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113076>

Hello Brian, hello Junio,

On Thu, Mar 12, 2009 at 11:00:00AM -0400, Brian Campbell wrote:
> On Mar 12, 2009, at 3:45 AM, Uwe Kleine-K=F6nig wrote:
>
>>> - You will be utterly confused by a local branch whose name is
>>>   "refs/top-bases/foo"
>> You mean a branch that has the full name refs/heads/refs/top-bases/=20
>> foo?
>> Well OK, valid concern.
>
> Yes, you're right, this is a problem.
>
>>> To fix these, you might want to do something like:
>>>
>>> 	if head_=3D$(git symbolic-ref HEAD)
Shouldn't git symbolic-ref -q HEAD be used here?

>>>        then
>>>                case "$head_" in
>>>                refs/heads/*)
>>>                        echo "${head_#refs/heads/}"
>>>                        ;;
>>>                refs/top-bases/*)
>>>                        echo "${head_#refs/top-bases/}"
>>>                        ;;
>>>                *)
>>>                        echo "$head_"
>>>                        ;;
>>>                esac
>>> 	else
>>>        	whatever you want to do on a detached HEAD
How do I  distinguish between a detached HEAD and another error?  I hav=
e
the feeling that git symbolic-ref -q HEAD should exit(0) with a detache=
d
HEAD.

>> Thanks Junio and Brian.
>>
>> Brian, do you update the series?
>
> Sure, I'll send an updated patch.
>
> I'm thinking that for the detached HEAD case, this function should di=
e =20
> with a message about not being on a valid branch, and then the call s=
ite=20
> in tg-summary that doesn't care about being on a valid branch should=20
> ignore the error and leave curname empty. Does that sound about right=
?=20
mmh, I would return "" and let the caller handle that.

> Also, has anyone considered writing a test suite for TopGit?
Yes, but I didn't found the time for that until now.  If you'd voluntee=
r
that would be very welcome.

IMHO we should reuse as much as possible from git.git.  For me even
requiring a git.git checkout to use its files would be OK.  I consider
that even better then duplicating the relevant files.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
Peiner Strasse 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-=
0    |
Amtsgericht Hildesheim, HRA 2686              | Fax:   +49-5121-206917-=
5555 |
