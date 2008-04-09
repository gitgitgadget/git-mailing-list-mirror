From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: git bisect on multiple cores
Date: Wed, 9 Apr 2008 10:27:00 +0200
Message-ID: <20080409082700.GA24195@diana.vm.bytemark.co.uk>
References: <dbbf25900804080358o6b1ada20pfb94f68f06a23f83@mail.gmail.com> <20080409071750.GA23211@diana.vm.bytemark.co.uk> <vpq63ure9j6.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: A B <gentosaker@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Apr 09 10:34:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjVl9-0001tt-Rd
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 10:34:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752296AbYDIIdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Apr 2008 04:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752141AbYDIIdk
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 04:33:40 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2318 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752296AbYDIIdj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 04:33:39 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JjVe0-0006JZ-00; Wed, 09 Apr 2008 09:27:00 +0100
Content-Disposition: inline
In-Reply-To: <vpq63ure9j6.fsf@bauges.imag.fr>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79087>

On 2008-04-09 10:07:25 +0200, Matthieu Moy wrote:

> Karl Hasselstr=F6m <kha@treskal.com> writes:
>
> > Adding parallelism to a binary search scales very badly -- I'd say
> > about logarithmically, but I haven't thought hard about it. If
> > it's possible to use the extra cores to speed up the build+test
> > cycle, that's vastly preferable.
>
> Probably logarithmically with the number of cores. But for
> reasonable machines, this number is relatively low, so the log is
> not so costly. For a binary search, using just 2 cores, you can try
> the next in the list in case of a "git bisect good" for example, and
> if the hypothesis is true, you've just gained a factor 2 (assuming
> it happens 50% of times, that should be a 50% speedup). Similarly,
> you should get a factor 2 with 3 cores.

Yeah. But to get a factor 3, you need 7 cores; and for 4, you need 15.
It goes downhill from there. If your build+test cycle is
parallelizable at all, I don't think you'll find those numbers hard to
beat.

(There's also the fact that testing several revisions at once assumes
that the whole build+test cycle is automated, or at least most of it.
Otherwise you need more people as well as more cores.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
