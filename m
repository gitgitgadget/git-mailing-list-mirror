From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 6 May 2009 11:38:16 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905061137300.14230@intel-tinevez-2-302>
References: <20090506055913.GA9701@dektop> <4A01320A.2050600@viscovery.net> <fcaeb9bf0905052357v6773cbf5i12795c1866a80783@mail.gmail.com> <loom.20090506T091628-717@post.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-760373717-1241602696=:14230"
Cc: git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 06 11:38:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1da5-00047I-4m
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 11:38:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758625AbZEFJiV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 05:38:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758214AbZEFJiU
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 05:38:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:35081 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757109AbZEFJiS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 05:38:18 -0400
Received: (qmail invoked by alias); 06 May 2009 09:38:16 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp061) with SMTP; 06 May 2009 11:38:16 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/dwJMVBwrdLNVFgUhTlBOBGTG5Pxa3Sp3+l7No5a
	3EebGIFMIQAd+r
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <loom.20090506T091628-717@post.gmane.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118335>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-760373717-1241602696=:14230
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 6 May 2009, Ralf Wildenhues wrote:

> Nguyen Thai Ngoc Duy writes:
> > On Wed, May 6, 2009 at 4:45 PM, Johannes Sixt wrote:
> > > Nguyen Thai Ngoc Duy schrieb:
> > >>       # normalize path:
> > >>       # multiple //; leading ./; /./; /../; trailing /
> > >>       path=$(printf '%s/\n' "$path" |
> > >>               sed -e '
> > >>                       s|//*|/|g
> > >>                       s|^\(\./\)*||
> > >>                       s|/\./|/|g
> > >>                       :start
> > >>                       s|\([^/]*\)/\.\./||
> > >>                       tstart
> > >>                       s|/*$||
> > >>               ')
> 
> > It says nothing. The result of "printf '%s\n' ./foo/bar | sed -e blah"
> > is just wrong, (i.e. "./" remains). I stripped down to "sed -e
> > 's|^\(\./\)*||'", does not work. Probably due to \( \) pair. Skimmed
> > through sed manpage, seems no mention of bracket grouping.
> 
> Quoting 'info Autoconf "Limitation of Usual Tools"':
> 
>      Some `sed' implementations, e.g., Solaris, restrict the special
>      role of the asterisk to one-character regular expressions.  This
>      may lead to unexpected behavior:
> 
>           $ echo '1*23*4' | /usr/bin/sed 's/\(.\)*/x/g'
>           x2x4
>           $ echo '1*23*4' | /usr/xpg4/bin/sed 's/\(.\)*/x/g'
>           x
> 
> You can work around it in this case with
>   :again
>   s|^\./||
>   t again
> 
> BTW, you should put a space between t and the label (but not between
> : and label), POSIX requires that and some sed versions expect it.

Maybe the time is better spent on turning submodule into a builtin, before 
it gets even larger, and before we have to jump through even more hoops 
because of shell compatibility issues?

Ciao,
Dscho

--8323329-760373717-1241602696=:14230--
