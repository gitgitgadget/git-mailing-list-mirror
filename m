From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Thu, 10 Jul 2008 16:56:32 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807101655440.18205@racer>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>  <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>  <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>  <7vprpnlglh.fsf@gitster.siamese.dyndns.org> 
 <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com>  <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>  <alpine.DEB.1.00.0807101526380.18205@racer> <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Thu Jul 10 17:57:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGyWV-0007SG-BB
	for gcvg-git-2@gmane.org; Thu, 10 Jul 2008 17:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750848AbYGJP4h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 11:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbYGJP4g
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 11:56:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:50618 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750844AbYGJP4g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 11:56:36 -0400
Received: (qmail invoked by alias); 10 Jul 2008 15:56:34 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp047) with SMTP; 10 Jul 2008 17:56:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18fSM4/OagftPYJonkb98uS11o8SdBQ8XcFqgJY8a
	qEqF/wLp77vM3g
X-X-Sender: gene099@racer
In-Reply-To: <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87987>

Hi,

On Thu, 10 Jul 2008, Geoffrey Irving wrote:

> On Thu, Jul 10, 2008 at 7:28 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>
> > On Thu, 10 Jul 2008, Geoffrey Irving wrote:
> >
> >> On Wed, Jul 9, 2008 at 8:34 PM, Geoffrey Irving <irving@naml.us> wrote:
> >>
> >> > Note: there are at least two "holes" in this code.  First, it is 
> >> > impossible to verify the validity of the entries (this is 
> >> > impossible to fix).  Second, it is possible to write a malicious 
> >> > patch-id-cache file that causes git-cherry to go into an infinite 
> >> > loop.  Fixing the loop requires either traversing every entry on 
> >> > load (bad) or adding a second loop termination condition to 
> >> > find_helper.  Since looping forever is better than returning 
> >> > incorrect results, I figured fixing the weaker hole would just 
> >> > result in a false sense of security.
> >>
> >> Oops: avoiding the infinite loop only requires reading expected O(1) 
> >> entries on load, so I can fix that if you like.  It would only be all 
> >> of them if it actually did detect the infinite loop.
> >
> > I have to admit that you lost me there.  AFAIR the patch-id cache is a 
> > simple commit->patch_id store, right?  Then there should be no way to 
> > get an infinite loop.
> 
> If every entry is nonnull, find_helper loops forever.

Ah, that is because you did not use that part of my implementation.  My 
hash did not wrap.

> > Besides, this is a purely local cache, no?  Never to be transmitted...  
> > So not much chance of a malicious attack, except if you allow write 
> > access to your local repository, in which case you are endangered no 
> > matter what.
> 
> Yep, that's why it's only a hole in quotes, and why I didn't fix it.

Then it is not a hole.

Ciao,
Dscho
