From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: merge result
Date: Sat, 10 Sep 2011 13:35:53 +0200
Message-ID: <vpqr53oeijq.fsf@bauges.imag.fr>
References: <CAPgpnMRrSmVrXD__jxv3uNrek8up+scHp+_Kj8+=HX8tfweWzQ@mail.gmail.com>
	<vpqmxed6fby.fsf@bauges.imag.fr>
	<CAPgpnMTMPQQPkS-gKLvUJNKLfMWuAT-oA3NCiSRFxu7PknYsnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Lynn Lin <lynn.xin.lin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 13:36:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2Lr5-0003eZ-2O
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 13:36:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759077Ab1IJLgA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 10 Sep 2011 07:36:00 -0400
Received: from mx2.imag.fr ([129.88.30.17]:35973 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758887Ab1IJLf7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 07:35:59 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p8ABYeKa028644
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Sat, 10 Sep 2011 13:34:40 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1R2Lqk-00019i-3t; Sat, 10 Sep 2011 13:35:54 +0200
In-Reply-To: <CAPgpnMTMPQQPkS-gKLvUJNKLfMWuAT-oA3NCiSRFxu7PknYsnA@mail.gmail.com>
	(Lynn Lin's message of "Sat, 10 Sep 2011 09:11:42 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Sat, 10 Sep 2011 13:34:41 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p8ABYeKa028644
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1316259283.24561@oCY4EZ9dF8STDG0lIEqxDw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181153>

Lynn Lin <lynn.xin.lin@gmail.com> writes:

>>> =A0 =A01->2->3-4>5 =A0 =A0 =A0 =A0Master
>>> =A0 =A0 =A0 =A0|
>>> =A0 =A0 =A0 =A04->6->7 =A0 =A0 =A0 =A0 =A0A
>>
>> A more accurate drawing would be
>>
>> =A0 =A01->2->3-4>5 =A0 =A0 =A0 =A0Master
>> =A0 =A0 =A0 =A0|
>> =A0 =A0 =A0 =A04'->6->7 =A0 =A0 =A0 =A0 =A0A
>>
>> and after merging, you'd get
>>
>> =A0 =A01->2->3-4>5-->8 =A0A, master
>> =A0 =A0 =A0 =A0| =A0 =A0 =A0 /
>> =A0 =A0 =A0 =A04'->6->7
>>
>> with 8 having both 4 and 4' as ancestors. There's nothing wrong with=
 it.
>> Git cannot remove either 4 or 4' without rewritting history, and "gi=
t
>> merge" does not rewrite history.
> so confused here.If 4' is just next 4 commit,how can the diff work? f=
or example
>
> 1->2->4->4'->6->...
>
>  diff 4 and 4' is a little confused,correct?

History is not linear. When you type "git log", you may think that 4 an=
d
4' follow each other, but try "gitk" or "git log --oneline --graph" to
see a better view of history.

It's possible to have several times the same change applied to multiple
branches (e.g. when doing cherry-picking), but having twice the same
change in a row is not really possible.

Suppose your commit 4 removes the line "foobar". Then, commits 1, 2 and
3 have the line "foobar" (think of commits as snapshots in history, not
as diff. 3 is a snapshot, and when you run "git show 3", it shows you
the diff from 2 to 3). Commits 4 and 4' don't have it anymore, and then
obviously 5, 6, 7 don't have it either. At the time of merge, Git will
notice that neither of the merges to commit have the line "foobar" and
the result 8 won't have it either.

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
