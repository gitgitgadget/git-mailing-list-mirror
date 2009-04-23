From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] bisect: remove Perl use by implementing "git bisect--helper --sq-quote"
Date: Thu, 23 Apr 2009 21:20:01 +0200
Message-ID: <200904232120.01300.chriscool@tuxfamily.org>
References: <20090422045524.3606.81842.chriscool@tuxfamily.org> <7veivl444b.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:23:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4Vk-0002V4-Pg
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753668AbZDWTVX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 15:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752884AbZDWTVW
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 15:21:22 -0400
Received: from smtp5-g21.free.fr ([212.27.42.5]:44153 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752242AbZDWTVW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 15:21:22 -0400
Received: from smtp5-g21.free.fr (localhost [127.0.0.1])
	by smtp5-g21.free.fr (Postfix) with ESMTP id AC361D4812E;
	Thu, 23 Apr 2009 21:21:14 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp5-g21.free.fr (Postfix) with ESMTP id B0DB8D480ED;
	Thu, 23 Apr 2009 21:21:11 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7veivl444b.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117370>

Le mercredi 22 avril 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > The sq() function in "git-bisect.sh" was the only place where Perl
> > was needed. This patch remove this use of Perl by implementing
> > a new "--sq-quote" option in "builtin-bisect--helper.c".
>
> Isn't it because only git-bisect.sh for whatever reason reimplements =
sq
> using Perl while original implementation in am used sed for more
> portability?

Well I saw that there was some work going to remove perl dependencies, =
so I=20
thought that I might help by removing the Perl dependency from=20
git-bisect.sh.

I didn't look at other places where sq is implemented otherwise. I just=
=20
checked other shell scripts where there is @@PERL@@.

> I would suspect, if it were 3 years ago, that any serious porcelain
> writers would have very much appreciated such a feature that gives sh=
ell
> programmers an easy access to a quoting function that allows a safe e=
val,
> and I would have strongly suggested that the feature to be implemente=
d in
> a more permanent place rather than in bisect--helper; perhaps a bette=
r
> place would be the kitchen-sink "rev-parse".

I did it in bisect--helper because I was working on it, and I wanted to=
 do=20
it in C because I am porting bisect stuff to C.

But now that you pointed that sq is also implemented in git-am.sh, I ag=
ree=20
that it would be perhaps better if it was implemented in something=20
like "rev-parse". And then it could be used both in "git-bisect.sh" and=
=20
in "git-am.sh".

> But given that nobody seems competent enough to do serious programmin=
g in
> shell these days, I am not sure if the choice between bisect--helper =
and
> rev-parse makes much of a difference ;-).

We never know, it might become trendy again ;-)

Best regards,
Christian.
