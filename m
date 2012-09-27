From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH 4/3] completion: quote completions we find
Date: Fri, 28 Sep 2012 00:58:09 +0200
Message-ID: <20120927225809.GK10144@goldbirke>
References: <20120926214653.GA18628@sigill.intra.peff.net>
 <20120926215119.GC18653@sigill.intra.peff.net>
 <20120926215700.GB18628@sigill.intra.peff.net>
 <20120927214046.GJ10144@goldbirke>
 <7vy5jvnln5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 00:58:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THN2M-0004bE-J4
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 00:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756132Ab2I0W6U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Sep 2012 18:58:20 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52337 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882Ab2I0W6U (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 18:58:20 -0400
Received: from localhost6.localdomain6 (p5B1309F9.dip0.t-ipconnect.de [91.19.9.249])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0MgHFG-1T3XPg13Q6-00Nl1Y; Fri, 28 Sep 2012 00:58:10 +0200
Content-Disposition: inline
In-Reply-To: <7vy5jvnln5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:e01SnLYWDj2GiGSi0qEpRrvkHhUPDHvyCySYQV2luAA
 WU2ClehFTGdFQ+kRvRJp8V1JEQxZe6fyl/t+zsFkviChfZwC6l
 xwjmYnZ9Qmnco0sgYCd2Iaz6GwNSzjt47RfimsHAAPV+z1zWJN
 8ICA2TjMXRZVapWMr6NAlE/eFcuMzsx4N/V7Bn5kpY9XKvtX11
 y8Umjjq6f6VO8AhcLpSf7j4C+GYMEOcvGDheSlvrV8sgB3bCmm
 rClfGeDXRKVfTTrwbpUNi1Cbjyt6d2bP40fHTrkTHkjbHxxaSN
 BRPp6pXzpWDNbOKGKxGZQulim6/YV9eNf2h1SFDRuOjAYNPToN
 vczv+fiI8B454EXrQqX8aFmRKiX+YBOAg0KapmUZj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206529>

On Thu, Sep 27, 2012 at 03:31:10PM -0700, Junio C Hamano wrote:
> SZEDER G=E1bor <szeder@ira.uka.de> writes:
>=20
> > On Wed, Sep 26, 2012 at 05:57:00PM -0400, Jeff King wrote:
> >> +		COMPREPLY[$i]=3D"${COMPREPLY[$i]}$stripped"
> >
> > This reminded me to a mini-series collecting dust in my git repo,
> > which converts a few similar var=3D$var$something constructs to use=
 the
> > +=3D append operator instead.
>=20
> Is the benefit of rewriting it to var+=3D$something large enough to
> worry about the below?

That way we can get rid of a subshell in __gitcomp(), which means one
less fork() during every command or option completion for Windows
folks.  We can also get rid of two subshells during loading the
completion script.

And I would spare myself from a couple of merge conflicts, too ;)


> > Now, Bash supports this +=3D append operator since v3.1
> > (bash-3.1-alpha1, to be exact), which is around since July 2005, if=
 I
> > can trust the mtime at ftp://ftp.cwru.edu/pub/bash/.  MSysgit ships
> > v3.1 so it already supports this, too.  So, what is the oldest Bash
> > version we care about for completion?
