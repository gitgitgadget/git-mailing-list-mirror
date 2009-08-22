From: Nicolas Pitre <nico@cam.org>
Subject: Re: Continue git clone after interruption
Date: Fri, 21 Aug 2009 20:59:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908212010440.6044@xanadu.home>
References: <1250509342.2885.13.camel@cf-48>
 <200908211207.38555.jnareb@gmail.com>
 <alpine.LFD.2.00.0908211614220.6044@xanadu.home>
 <200908212341.33324.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_lRFyLIE+lB0JKD2aiL2KNw)"
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 22 03:00:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Meexr-0000NZ-4M
	for gcvg-git-2@lo.gmane.org; Sat, 22 Aug 2009 03:00:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbZHVA77 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 20:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933004AbZHVA77
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 20:59:59 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39849 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932726AbZHVA76 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 20:59:58 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOR00ML56RUEXA0@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 21 Aug 2009 20:59:54 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <200908212341.33324.jnareb@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126776>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_lRFyLIE+lB0JKD2aiL2KNw)
Content-type: TEXT/PLAIN; charset=ISO-8859-15
Content-transfer-encoding: 8BIT

On Fri, 21 Aug 2009, Jakub Narebski wrote:

> On Fri, 21 Aug 2009, Nicolas Pitre wrote:
> > On Fri, 21 Aug 2009, Jakub Narebski wrote:
> >> On Thu, 20 Aug 2009, Nicolas Pitre wrote:
> >>> On Thu, 20 Aug 2009, Jakub Narebski wrote:
> 
> >>>> It is however only 2.5 MB out of 37 MB that are resumable, which is 7%
> >>>> (well, that of course depends on repository).  Not that much that is
> >>>> resumable.
> >>> 
> >>> Take the Linux kernel then.  It is more like 75 MB.
> >> 
> >> Ah... good example.
> >> 
> >> On the other hand Linux is fairly large project in terms of LoC, but
> >> it had its history cut when moving to Git, so the ratio of git-archive
> >> of HEAD to the size of packfile is overemphasized here.
> > 
> > That doesn't matter.  You still need that amount of data up front to do 
> > anything.  And I doubt people with slow links will want the full history 
> > anyway, regardless if it goes backward 4 years or 18 years back.
> 
> On the other hand unreliable link doesn't need to mean unreasonably
> slow link.

In my experience speed and reliability are more or less tied together.
And the slower is your link, the longer your transfer will last, the 
greater are the chances for you to have troubles.

> Hopefully GitTorrent / git-mirror-sync would finally come out of 
> vapourware and wouldn't share the fate of Duke Nukem Forever ;-),
> and we would have this as an alternative to clone large repositories.

Well... Maybe.

> Well, supposedly there is some code, and last year GSoC project at
> least shook the dust out of initial design and made it simplier, IIUC.

The BitTorrent protocol is a nifty thing (although I doubt the 
intertainment industry think so).  But its efficiency relies on the fact 
that many many people are expected to download the same stuff at the 
same time.  I have some doubts about the availability of the right 
conditions in the context of git for a BitTorrent-like protocol to work 
well in practice.  But this is Open Source and no one has to wait for me 
or anyone else to be convinced before attempting it and showing results 
to the world.

> >> This was plain text RFC for the Git Packfile Protocol, generated from
> >> rfc2629 XML sources at http://github.com/schacon/gitserver-rfc
> > 
> > I suggest you track it down and prod/propose a version for merging in 
> > the git repository.
> 
> Scott Chacon was (and is) CC-ed.

He might not have followed all our exchange so deeply in this thread 
though.  So maybe another thread with him in the To: field might be 
required to get his attention.

> I don't know if you remember mentioned discussion about pack protocol, 
> stemming from the fact that some of git (re)implementations (Dulwich,
> JGit) failed to implement it properly, where properly = same as 
> git-core, i.e. the original implementation in C... because there were
> not enough documentation.

Yes I followed the discussion.  I still think that, since that 
documentation exists now, that would be a good idea to have a copy 
included in the git sources.

> > The format I was envisioning is really simple:
> > 
> > First the size of the raw commit object data content in decimal, 
> > followed by a 0 byte, followed by the actual content of the commit 
> > object, followed by a 0 byte.  (Note: this could be the exact same 
> > content as the canonical commit object data with the "commit" prefix, 
> > but as all the rest are all blob content this would be redundant.)
> > 
> > Then, for each file:
> > 
> >  - The file mode in octal notation just as in tree objects
> >  - a space
> >  - the size of the file in decimal
> >  - a tab
> >  - the full path of the file
> >  - a 0 byte
> >  - the file content as found in the corresponding blob
> >  - a 0 byte
> > 
> > And finally some kind of marker to indicate the end of the stream.
> > 
> > Put the lot through zlib and you're done.
> 
> So you don't want to just tack commit object (as extended pax header,
> or a comment - if it is at all possible) to the existing 'tar' and
> 'zip' archive formats.  Probably better to design format from scratch.

As René Scharfe mentioned, the existing archive formats have limitations 
and complexities that we might simply avoid altogether by creating a 
simpler format that is more likely to never fail to faithfully reproduce 
a git revision content.  Maybe the git-fast-import format could do it 
even better, and maybe not.  That's an implementation detail that needs 
to be worked out once one is ready to get real with actual coding.


Nicolas

--Boundary_(ID_lRFyLIE+lB0JKD2aiL2KNw)--
