From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 7 Jun 2013 22:44:30 +0200
Message-ID: <20130607204430.GD31625@goldbirke>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
 <20130607000006.GA25731@goldbirke>
 <CALkWK0=D7sHLgptWkFHma1FoS-zdifHqXnuuBKhkyuszgEJ0Xw@mail.gmail.com>
 <7v8v2lu5ks.fsf@alter.siamese.dyndns.org>
 <20130607191643.GA31625@goldbirke>
 <7vwqq5snzi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Ramkumar Ramachandra <artagnon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 22:44:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul3WW-00072F-JX
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 22:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756276Ab3FGUoc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 16:44:32 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:51433 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756177Ab3FGUob (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 16:44:31 -0400
Received: from localhost6.localdomain6 (g228010151.adsl.alicedsl.de [92.228.10.151])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0Lpzv9-1U8Qv320RT-00fODE; Fri, 07 Jun 2013 22:44:30 +0200
Content-Disposition: inline
In-Reply-To: <7vwqq5snzi.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:dsp0nu+1jLkN1XLZZNwkZ8Q6o7LOG00z4R1P0FTDewq
 IiYWZSM9RlWwXJj/p2+STaHdvyQ81HRN8WJKYmvT14dsIjDhwy
 lFDWegUT1jgzP2pSqhNCScwY9f0oPd4w72tHCpIdujGWnBvryA
 le4DZAIQf+pW+/OJKwtGLLP9/Fn1unlGiuSoYGrmOUeLIGfDlj
 F0WT74AO/OQf8ZvWr1gWGXNxCKcoRhDv3vF3a+W4EOx/aQwTIp
 cno+02mlKYR7p4U0NaMHVF4CKLWZ9Ix4zzp8+c8h04R4+eug2C
 maL+1sa/6tNKe4KMgPX+AlDbx9jueSQrZ8/8HFaAjg07Qkq5be
 ASqLcs02xLfOxXVTMOzRN0jk/uaVqwbLr6h9lzGps
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226705>

On Fri, Jun 07, 2013 at 12:46:25PM -0700, Junio C Hamano wrote:
> Thanks for a pointer.  I think what I was suggesting was slightly
> different in that I was hoping to see a single helper that knows to
> complete to object names (possibly including trees/blobs with the
> treeish:path notation), ranges, and pathnames (not treeish:path
> notation) until it sees a "--" and then complete only to pathnames.

We already got that except the completion of pathnames before "--",
and I don't know how that could be done properly for commands taking
both refs and paths.  Just consider

  git diff git.c
  git diff master git.c
  git diff master next git.c

We can't guess whether the user wants refs or paths when he first hits
tab after 'git diff ', not even after 'git diff master '.  I
definitely don't want to see refs and paths all mixed up.

As for the _single_ helper: I think it has some value that we have
different helper functions and we can indicate whether a certain git
command can take a ref or ref:path or ref1...ref2 or even
ref1..ref2:path by calling the appropriate helper function (however
badly it might have been named), even if all these functions happen to
boil down to a single implementation.


G=E1bor
