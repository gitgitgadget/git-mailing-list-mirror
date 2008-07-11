From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cherry: cache patch-ids to avoid repeating work
Date: Fri, 11 Jul 2008 16:36:10 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807111635400.8950@racer>
References: <7f9d599f0807082053w4603d0bbgfead9127c33b78b5@mail.gmail.com>  <7vfxqjmyg2.fsf@gitster.siamese.dyndns.org>  <7f9d599f0807082226oee83bedrf13d254ae12be274@mail.gmail.com>  <7vprpnlglh.fsf@gitster.siamese.dyndns.org> 
 <7f9d599f0807092034n438f0976pf44d4c9305871087@mail.gmail.com>  <7f9d599f0807100709u778f0ab1y28776d7efb831b61@mail.gmail.com>  <alpine.DEB.1.00.0807101526380.18205@racer>  <7f9d599f0807100733s4435a9bga89749f2f6e10cf@mail.gmail.com>  <7v3amglxmb.fsf@gitster.siamese.dyndns.org>
 <7f9d599f0807110758y6c4ea7bepd726daf4fe5f074c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Fri Jul 11 17:37:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHKgL-0006qD-9S
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 17:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbYGKPgO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 11:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753287AbYGKPgO
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 11:36:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:33724 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752496AbYGKPgO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 11:36:14 -0400
Received: (qmail invoked by alias); 11 Jul 2008 15:36:12 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp025) with SMTP; 11 Jul 2008 17:36:12 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1812Gc8u381IDbFe/uBnF9WJNhQDummtC7eMJwXZ+
	LIM5YZiPazGUSO
X-X-Sender: gene099@racer
In-Reply-To: <7f9d599f0807110758y6c4ea7bepd726daf4fe5f074c@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88128>

Hi,

On Fri, 11 Jul 2008, Geoffrey Irving wrote:

> On Thu, Jul 10, 2008 at 11:54 PM, Junio C Hamano <gitster@pobox.com> wrote:
> > "Geoffrey Irving" <irving@naml.us> writes:
> >
> >>>> Oops: avoiding the infinite loop only requires reading expected O(1)
> >>>> entries on load, so I can fix that if you like.  It would only be all of
> >>>> them if it actually did detect the infinite loop.
> >>>
> >>> I have to admit that you lost me there.  AFAIR the patch-id cache is a
> >>> simple commit->patch_id store, right?  Then there should be no way to get
> >>> an infinite loop.
> >>
> >> If every entry is nonnull, find_helper loops forever.
> >
> > Isn't it sufficient to make this part check the condition as well?
> >
> > +       if (cache->count >= cache->size)
> > +       {
> > +               warning("%s is corrupt: count %"PRIu32" >= size %"PRIu32,
> > +                       filename, cache->count, cache->size);
> > +               goto empty;
> > +       }
> >
> > At runtime you keep the invariants that hashtable always has at most 3/4
> > full and whoever wrote the file you are reading must have honored that as
> > well, or there is something fishy going on.
> 
> Good point.  There's no reason not to check the 3/4 condition.  It isn't 
> sufficient to avoid the infinite loop, though, since we don't verify 
> that count is accurate.

Why so complicated?  I mean, you can count in that "infinite" loop 
yourself, no?

Ciao,
Dscho
