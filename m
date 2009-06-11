From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Thu, 11 Jun 2009 06:02:54 +0200
Message-ID: <200906110602.54861.chriscool@tuxfamily.org>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org> <c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com> <7vtz2nlrfs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 06:03:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEbW2-00005e-KE
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 06:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762397AbZFKEC4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 11 Jun 2009 00:02:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762393AbZFKECy
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 00:02:54 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:37808 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762381AbZFKECx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jun 2009 00:02:53 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id F1EBED48015;
	Thu, 11 Jun 2009 06:02:46 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id D825FD4806E;
	Thu, 11 Jun 2009 06:02:43 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vtz2nlrfs.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121325>

Le Wednesday 10 June 2009, Junio C Hamano a =E9crit :
> Christian Couder <christian.couder@gmail.com> writes:
> > On Tue, Jun 9, 2009 at 10:37 PM, Junio C Hamano<gitster@pobox.com>=20
wrote:
> >> Christian Couder <christian.couder@gmail.com> writes:
> >>> My opinion is that we should not penalize all the people working =
on
> >>> "quite clean" projects and also people working on "not clean"
> >>> projects who are able to recover, on the pretence that there are
> >>> other people on these "not clean" projects who are not.
> >
> > ...
> > When I wrote "clean", I just mean with not too many untestable comm=
its.
>
> Ok, then the "opinion" in the above paragraph was simply stating the
> obvious: we should have a good "bisect skip".  I obviously agree with
> that ;-).
>
> In other words, you were not arguing against my observation that your
> algorithm would not be much better than randomly picking the next com=
mit
> when the best one is untestable, unless the history is linear.

I think my algorithm is better enough than a random one to be worth usi=
ng by=20
default. Like HPA says it's in practice like a random one with a bias.

That's because the "goodness" value is something that has a relationshi=
p=20
with the graph topology. The "goodness" value is some kind of distance =
from=20
either the good or the bad commits. The farther from the good and bad=20
commits the higher is the "goodness" value. And my algorithm tries to a=
void=20
commits with low "goodness" value because they should be those near the=
=20
good and bad commits and we know that those near the good and bad commi=
ts=20
wont give a lot of information.

> I guess=20
> that was what I was confused with.  I thought you were saying that we
> should give preferential treatment to people with linear history.
>
> > Ok. I started working on optionaly using a PRNG but I am not sure t=
hat
> > you will want to add another one.
>
> It may still make sense to replace, not add to, that "fixed alternati=
ng
> distance in goodness space" with a randomized one, for the reasons HP=
A
> stated, especially for avoiding to give a false impression that the m=
agic
> constants are picked for some reason.

But there _is_ a reason.

Best regards,
Christian.
