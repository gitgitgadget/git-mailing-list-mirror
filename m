From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: error out when given any good rev that is not an ancestor of the bad rev
Date: Tue, 1 Jul 2008 01:46:09 +0200
Message-ID: <200807010146.09206.chriscool@tuxfamily.org>
References: <20080701004211.ba9b89c9.chriscool@tuxfamily.org> <200807010116.30214.chriscool@tuxfamily.org> <7vprpyts7j.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 01:43:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDT1w-0002aS-LS
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 01:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753616AbYF3XmO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 19:42:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754452AbYF3XmO
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 19:42:14 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:34844 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbYF3XmN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jun 2008 19:42:13 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6A72D1AB2C1;
	Tue,  1 Jul 2008 01:42:12 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 0DDA91AB2BB;
	Tue,  1 Jul 2008 01:42:11 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vprpyts7j.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86968>

Le mardi 1 juillet 2008, Junio C Hamano a =C3=A9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > Le mardi 1 juillet 2008, Junio C Hamano a =C3=A9crit :
> >> Christian Couder <chriscool@tuxfamily.org> writes:
> >> > Before this patch "git bisect" doesn't really work when it is gi=
ven
> >> > some good revs that are siblings of the bad rev.
> >> >
> >> > For example if there is the following history:
> >> >
> >> > A-B-C-D
> >> >    \E-F
> >> >
> >> > and we launch "git bisect start D F" then only C and D will be
> >> > considered as possible first bad commit.
> >
> > I am assuming the first bad commit in the graph is A and it is fixe=
d by
> > F.
>
> Ah, I see your confusion here.  bisect is about finding regressions.
> "Older ones were good, and now there is a breakage.  Who broke it?"
>
> If F fixed it, that is already outside the bisection's scope.  The us=
er
> needs to know that by saying F is good, he is saying he knows everyth=
ing
> that leads to F is good.

Yes, but the fact is that the user may wrongly think that F is an ances=
tor=20
of D or he may not remember/know about the rule that saying "F is good"=
=20
means "everything from A to F is good". That's why this patch adds a sa=
fety=20
net by detecting end erroring out in this case.

Regards,
Christian.
