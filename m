From: Nicolas Pitre <nico@cam.org>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 12:39:09 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0804291232130.23581@xanadu.home>
References: <200804281829.11866.henrikau@orakel.ntnu.no>
 <20080429124152.GB6160@dpotapov.dyndns.org> <481733A3.4010802@op5.se>
 <alpine.LFD.1.10.0804291132060.23581@xanadu.home>
 <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Andreas Ericsson <ae@op5.se>, Dmitry Potapov <dpotapov@gmail.com>,
	Henrik Austad <henrikau@orakel.ntnu.no>, git@vger.kernel.org
To: Geoffrey Irving <irving@naml.us>
X-From: git-owner@vger.kernel.org Tue Apr 29 18:40:20 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jqss5-0000cT-Mq
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 18:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607AbYD2QjN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 12:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753394AbYD2QjN
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 12:39:13 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13923 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753278AbYD2QjM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 12:39:12 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K0300B67I99GXX0@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 29 Apr 2008 12:39:11 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7f9d599f0804290859y6a579302m5db9f7f827b320a4@mail.gmail.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80703>

On Tue, 29 Apr 2008, Geoffrey Irving wrote:

> On Tue, Apr 29, 2008 at 8:42 AM, Nicolas Pitre <nico@cam.org> wrote:
> > On Tue, 29 Apr 2008, Andreas Ericsson wrote:
> >
> >  > But they won't, because it's impossible to add two objects with the same
> >  > SHA1 hash key to a git repository, since it will lazily re-use the
> >  > existing one. In practice, this means that in the case of an "innocent"
> >  > hash-collision, git will actually break by refusing to store the new
> >  > content.
> >
> >  I'd also like to point out that Git usually receive "untrusted" new
> >  objects via the Git protocol through 'git index-pack'.  If you look at
> >  sha1_object() in index-pack.c, you'll see that active verification
> >  against hash collision is performed, and the fetch will abruptly be
> >  aborted if ever that happens.
> >
> >  Yes, writing a test case for this was tricky.  :-)
> 
> Here's the standard scenario for a hash collision attack, with
> parties, A, B, and C:
> 
> 1. C, the malicious one, computes the standard two pdfs with matching
> sha1 hashes.
> 2. C sends the valid pdf to B through a git commit, and B signs it with a tag.
> 3. C grabs the signature, and then forwards the "signed" commit to A,
> but substitutes the invalid pdf with the same hash.
> 
> The fact that git will check for hash collisions within one repository
> is nice, but it doesn't significantly increase the security of git
> against hash collision attacks.

Sure.  But this is all complete handwaving until a practical collision 
can be demonstrated.  So far the demonstration hasn't happened, 
practical or not.


Nicolas
