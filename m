From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: git bisect on multiple cores
Date: Wed, 9 Apr 2008 07:47:23 +0200
Message-ID: <200804090747.23596.chriscool@tuxfamily.org>
References: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com> <200804090629.29122.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "A B" <gentosaker@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 09 07:43:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjT5N-0002Vs-Gw
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 07:43:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbYDIFmF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 01:42:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751064AbYDIFmE
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 01:42:04 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:57992 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751009AbYDIFmD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Apr 2008 01:42:03 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 796521AB2E1;
	Wed,  9 Apr 2008 07:42:01 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 57A2B1AB2D0;
	Wed,  9 Apr 2008 07:42:01 +0200 (CEST)
User-Agent: KMail/1.9.7
In-Reply-To: <200804090629.29122.chriscool@tuxfamily.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79072>

Le mercredi 9 avril 2008, Christian Couder a =E9crit :
> Le mardi 8 avril 2008, A B a =E9crit :
> > git bisect is really cool. I use it for the first time.
> > Just a thought, if you have a multiple core computer, can't you mak=
e
> > git build new versions in the background while testing the previuos
> > version? Alright, if you build 2 versions, one of them will never b=
e
> > tested, but you will perhaps save some time by letting it build in =
the
> > background?
>
> Yes, you can do that.
>
> If you have cloned your repository twice (or more), then you can bise=
ct
> compile and test at the same time in your 3 repositories (or more if =
you
> really want).
>
> For example if bisecting in one repo asks you to test revision X, the=
n
> you can bisect and then build (and even maybe start testing) in anoth=
er
> repo assuming revision X is good, and in yet in another one assuming
> revision X is bad.
>
> (In the repo where you assume X is good you use:
>
> "git bisect start CURRENT-BAD X"
>
> and in the third one, where you assume X is bad, you use:
>
> "git bisect start X CURRENT-GOOD")

In fact, you have to give all the good revisions you have, not just the=
 last=20
one. So it should be=20

"git bisect start CURRENT-BAD X GOOD1 GOOD2 ..."

or

"git bisect start X GOOD1 GOOD2 ..."

instead of the above.

> When you know that X was good then you can kill the build or test
> processes and "git bisect reset" in the repository where you assumed
> wrongly X was bad. You can then assume something else with "git bisec=
t
> start B G" and build and test in this repo again.

Above also you must give all the good ones, so it is:

"git bisect start B G1 G2..."

> In the repo that told you X was good, then you need only to use "git
> bisect good" or "git bisect bad" without building and testing to assu=
me
> something about the revision that should be built and tested.

Regards,
Christian.
