From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: How to update a cloned git repository
Date: Tue, 11 Sep 2012 18:45:38 +0200
Message-ID: <007301cd903c$e09c0050$a1d400f0$@schmitz-digital.de>
References: <k2n4v2$88t$1@ger.gmane.org> <vpq7gs0es4f.fsf@bauges.imag.fr> <006f01cd900e$fce59a60$f6b0cf20$@schmitz-digital.de> <7v627kk0re.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>,
	<git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 18:46:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBTbL-0002dh-7J
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 18:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758410Ab2IKQqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Sep 2012 12:46:06 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:65119 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756947Ab2IKQqF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Sep 2012 12:46:05 -0400
Received: from DualCore (dsdf-4db532aa.pool.mediaWays.net [77.181.50.170])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0M15IK-1TQw2i2RQW-00tDvZ; Tue, 11 Sep 2012 18:45:45 +0200
In-Reply-To: <7v627kk0re.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQKMBvoOU6gFyfWBzbsL0abxuS38eAGIfo3NAn/3ZEkCIAk3LpXXJlgw
Content-Language: de
X-Provags-ID: V02:K0:Ll3KDR2uWTukDjp26+17/xK5IydXq8DGj6PrCXsZDgy
 N1En4nmhgf5CTs3KL77tuhijU+EK0ZquXO5BLgGJS7jAoZEA4O
 l9adcKIgFwU1X/gD8+DIPMXGVClRGsyVRKJLfd0slBZw6dI0c7
 YpgKlYBHiphTT7einh7fofXftw7cDM6Q5hoKOmF7THLKbIcFyk
 vJN4hLd/x5MUWZD45uYWW3qQ+bLcHcY5XsJtVd38ssE5TxB2Mq
 GNANvPC7SWNHOFtp8GMRpK+KObW4GSzusLhLnT6dJ1LILQkE4u
 Jfs6jSHfTvERabPsbMLKuCuwv2K9X4i9lnkOrA0GcjP/CDAElL
 1rGy2RGOyRg0Epn1tq4wbBNZW8SS1dSiUclPB1l388ERe96KBi
 MJZvgTt/DAeWw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205248>



> -----Original Message-----
> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Tuesday, September 11, 2012 6:01 PM
> To: Joachim Schmitz
> Cc: 'Matthieu Moy'; git@vger.kernel.org
> Subject: Re: How to update a cloned git repository
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> >> From: Matthieu Moy [mailto:Matthieu.Moy@grenoble-inp.fr]
> >> ..
> >> Short answer: don't work on pu. Work on master unless you have a good
> >> reason not to.
> >
> > There are some changes in pu, that I need as the basis, namely my
> > setitimer patch and my 2nd mkdir patch, which haven't yet made it
> > into the master branch (and in the setitimer case not out of pu)
> 
> And that is not a good reason, either.
> 
> In general, it is a good habit to get into to base your changes on
> the oldest point release they may want to be used with.  For
> example, if you really wanted to, you could make sure your Tandem
> changes can be back-merged all the way down to v1.7.6 by forking

The first version I ever made available for NonStop is 1.5.12, so no reason for me to go back.
On the other hand I see nothing in my patches that would not easily backport to much older releases, as the code I touched is either
newly created by me (e.g. compat/mkdir.c) or pretty old (compar/win32/poll.c).

> your own branch from there, queuing your changes like mkdir, itimer
> on top.  And you develop and test your changes on that branch,
> without pulling from or rebasing it on top of my tree where random
> other things happen that won't affect you an iota.  A recent change
> to add the new "--set-upstream-to" option to "branch" command does
> not have any platform-specific bits, and for the purpose of the
> "port to Tandem" topic, keeping up to date with such a change in my
> tree is pointless, for example.  To make sure that the result is
> still usable with recent releases, you can create a throw-away merge
> between your work (that is forked from a stable base) and my tip
> every once in a while, test the result, and discard the throw-away
> merge when you are done.  Any breakage in your series you find in
> such an integration test is to be fixed on your branch, not on top
> of such a throw-away merge.
> 
> It might be the case that nobody cares if the resulting patches will
> not apply to and usable with 'master' or older integration branches,
> so in the particular case of "Tandem", choosing a stable fork point
> that is older than 'master' may not make much sense, though.

My goal here is that the next stable release has as much of my patches integrated as possible, so I have much less work when
porting, ideals just hitting 'make'...

So far my poll patches are still needed. And then, but not earlier, my plain NonStop specific ones (like a section in Makefile and
some adjustments in git-compat-utils.h) , these don't make much sense earlier.

Bye, Jojo
