From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] fast-export: ensure we traverse commits in topological
 order
Date: Wed, 11 Feb 2009 16:18:28 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902111618120.13279@intel-tinevez-2-302>
References: <1234332233-10017-1-git-send-email-newren@gmail.com> <1234332233-10017-2-git-send-email-newren@gmail.com> <alpine.DEB.1.00.0902111125410.10279@pacific.mpi-cbg.de> <e2b179460902110248m8055b3amdebcfc550438cff2@mail.gmail.com>
 <20090211135640.GA19600@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Elijah Newren <newren@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:20:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXGsY-0002G5-Tf
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 16:19:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755471AbZBKPSc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 10:18:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755446AbZBKPSc
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 10:18:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:40507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755282AbZBKPSb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 10:18:31 -0500
Received: (qmail invoked by alias); 11 Feb 2009 15:18:29 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 11 Feb 2009 16:18:29 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Yq5MeqOAYb5fdcts1JABfqliEWCN7ZomqC86zAZ
	ea2HexW/HiCLGF
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090211135640.GA19600@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109423>

Hi,

On Wed, 11 Feb 2009, Jeff King wrote:

> On Wed, Feb 11, 2009 at 10:48:18AM +0000, Mike Ralphson wrote:
> 
> > > On Tue, 10 Feb 2009, newren@gmail.com wrote:
> > > fast-export will only list as parents those commits which have already
> > > been traversed (making it appear as if merges have been squashed if not
> > > all parents have been traversed).  To avoid this silent squashing of
> > > merge commits, we request commits in topological order.
> > 
> > Any comparative timings? We don't need to rename this to 'git
> > reasonably-speedy-export'? 8-)
> 
> Hmm.
> 
> In git.git:
> 
>   $ time git fast-export --all --signed-tags=strip >/dev/null
>   real    1m6.013s
>   user    1m3.840s
>   sys     0m2.140s
> 
>   $ time git fast-export --all --signed-tags=strip --topo-order >/dev/null
>   real    0m49.018s
>   user    0m47.987s
>   sys     0m0.888s
> 
> I certainly didn't expect it to be _faster_.  More efficient use of the
> delta cache, maybe?

Or a warm against a cold cache?

Hides,
Dscho
