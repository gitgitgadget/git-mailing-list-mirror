From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] unpack-trees.c: check return value of lstat()
Date: Sun, 06 Mar 2011 21:57:06 +0100
Message-ID: <vpqpqq4ge71.fsf@bauges.imag.fr>
References: <201103062013.52793.tboegi@web.de>
	<vpqfwr0hwu0.fsf@bauges.imag.fr> <4D73E577.1010604@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: drizzd@aon.at, git@vger.kernel.org
To: Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Mar 06 22:00:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PwL43-0004xc-Hn
	for gcvg-git-2@lo.gmane.org; Sun, 06 Mar 2011 22:00:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754499Ab1CFVAZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Mar 2011 16:00:25 -0500
Received: from imag.imag.fr ([129.88.30.1]:59443 "EHLO imag.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435Ab1CFVAY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2011 16:00:24 -0500
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by imag.imag.fr (8.13.8/8.13.8) with ESMTP id p26Kv6iR003807
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sun, 6 Mar 2011 21:57:06 +0100 (CET)
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1PwL0k-0003ze-C4; Sun, 06 Mar 2011 21:57:06 +0100
In-Reply-To: <4D73E577.1010604@web.de> ("Torsten =?iso-8859-1?Q?B=F6gersha?=
 =?iso-8859-1?Q?usen=22's?= message of
	"Sun, 06 Mar 2011 20:50:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (imag.imag.fr [129.88.30.1]); Sun, 06 Mar 2011 21:57:09 +0100 (CET)
X-IMAG-MailScanner-Information: Please contact MI2S MIM for more information
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168531>

Torsten B=F6gershausen <tboegi@web.de> writes:

> On 06.03.11 20:29, Matthieu Moy wrote:
>> Torsten B=F6gershausen <tboegi@web.de> writes:
>>=20
>>> +		if (!lstat(path, &st))
>>> +			return check_ok_to_remove(path, len, DT_UNKNOWN, NULL, &st,
>>> +			                          error_type, o);
>>>  	} else if (!lstat(ce->name, &st))
>>=20
>> What happens if lstat returns a non-0 value?
> The result of "st" is 100% garbage, and should not be passed to
> anybody.

With your code, you don't do a return, you'll reach the end of the
function without calling return, which is probably the worst thing you
could expect.

> v1.7.4 says:
> commit e39212ab08e8d37dda5d8fd32b54099fe01dbbdb
> Merge: 716958c 9e08273

You've cut the date:

commit e39212ab08e8d37dda5d8fd32b54099fe01dbbdb
Merge: 716958c 9e08273
Author: Junio C Hamano <gitster@pobox.com>
Date:   Wed Dec 22 14:40:26 2010 -0800

=3D> no big surprise that you don't see the bugfix from Jan 12th.

>> Anyway, this seems to have been fixed by a93e53018 (Wed Jan 12 20:28=
:09
>> 2011, unpack-trees: handle lstat failure for existing file) already.

Did you look at the content of this commit?

> (And I had to correct drizzd@aon.a -> drizzd@aon.at)

Yes, because you've mis-spelled it in the first place and I didn't fix
it ;-).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
