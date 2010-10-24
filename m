From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH v2] make pack-objects a bit more resilient to repo
 corruption
Date: Sat, 23 Oct 2010 22:47:52 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010232237150.2764@xanadu.home>
References: <alpine.LFD.2.00.1010220037250.2764@xanadu.home>
 <20101022144600.GA5554@sigill.intra.peff.net>
 <alpine.LFD.2.00.1010221427390.2764@xanadu.home>
 <alpine.LFD.2.00.1010221606550.2764@xanadu.home>
 <AANLkTimy-ihrF1syWYe3T4W6-UHzCaj5Jud5rdFmv3D5@mail.gmail.com>
 <alpine.LFD.2.00.1010221714450.2764@xanadu.home>
 <30FC97D9-D9F2-4A08-8E69-4556DE204AA6@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sverre Rabbelier <srabbelier@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Sun Oct 24 05:03:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9qro-00082h-9b
	for gcvg-git-2@lo.gmane.org; Sun, 24 Oct 2010 05:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755692Ab0JXCry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Oct 2010 22:47:54 -0400
Received: from relais.videotron.ca ([24.201.245.36]:36797 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754837Ab0JXCrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Oct 2010 22:47:53 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LAR0003QX3L9O80@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Sat, 23 Oct 2010 22:47:46 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <30FC97D9-D9F2-4A08-8E69-4556DE204AA6@adacore.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159836>

On Sat, 23 Oct 2010, Geert Bosch wrote:

> 
> On Oct 22, 2010, at 17:19, Nicolas Pitre wrote:
> 
> >> On Fri, Oct 22, 2010 at 13:26, Nicolas Pitre <nico@fluxnic.net> wrote:
> >>> +                               static int warned = 0;
> >>> +                               if (!warned++)
> >>> +                                       warning("object %s cannot be read",
> >>> +                                               sha1_to_hex(src_entry->idx.sha1));
> >> 
> >> How does this handle multiple missing objects? Will it only warn for
> >> the first one?
> > 
> > Yes, only the first one, so you have a bone to chase if that ever 
> > happens to you.  And that's good enough IMHO.  Trying to warn for every 
> > missing object would require extra storage per object to remember if any 
> > particular object was warned for already, which is I think overkill for 
> > an extremely unlikely event.  Comprehensive reporting is the job of 
> > fsck.
> 
> Maybe add a ", run git fsck" to the message. Will still comfortably fit a line.

Maybe if this message ever gets printed often enough.  Let's see if 
someone will even report it before 2012, and be clueless about it. And 
to be consistent, you'd have to do the same throughout the code where 
this could be relevant.

Furthermore, if someone really need the additional clue, then I'm afraid 
that the current fsck output won't help at all except to confuse that 
person even more.

Better for people to ask for help on this list when things break due to 
corruptions if they can't figure it out on their own.


Nicolas
