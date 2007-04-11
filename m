From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 13/10] tests for various pack index features
Date: Wed, 11 Apr 2007 13:29:39 -0400 (EDT)
Message-ID: <alpine.LFD.0.98.0704111316290.28181@xanadu.home>
References: <alpine.LFD.0.98.0704101607390.28181@xanadu.home>
 <7vr6qrr51r.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.98.0704110850010.28181@xanadu.home>
 <20070411130932.GA17094@dspnet.fr.eu.org> <20070411145103.GP5436@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Olivier Galibert <galibert@pobox.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Apr 11 19:30:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbgdr-0002nb-OJ
	for gcvg-git@gmane.org; Wed, 11 Apr 2007 19:30:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbXDKR3l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 13:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753186AbXDKR3l
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 13:29:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35318 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbXDKR3k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 13:29:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JGC00GCSGLFJ890@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 11 Apr 2007 13:29:40 -0400 (EDT)
In-reply-to: <20070411145103.GP5436@spearce.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44245>

On Wed, 11 Apr 2007, Shawn O. Pearce wrote:

> Olivier Galibert <galibert@pobox.com> wrote:
> > On Wed, Apr 11, 2007 at 08:57:09AM -0400, Nicolas Pitre wrote:
> > > Hmmm what we need is a random data generator that always produces the 
> > > same thing.  I'll hack something to replace urandom.
> > 
> > Don't hack something, ues the standard reference, the Mersenne Twister.
> > 
> >   http://www.math.sci.hiroshima-u.ac.jp/~m-mat/MT/emt.html
> > 
> > PRNGs are the same as cryptosystems, it's very easy to hack up
> > something and get it very, very wrong.  And it's unnecessary, since
> > there are very good ones available.
> 
> Indeed.

Please don't get too excited.

We don't want a full fledged random number generator with a period of 
2^30000 that is faster than light and impossible to predict, etc, etc.

The _only_ thing we want is a convenient way to produce large files with 
garbage that is neither compressible nor deltifiable, but still 
reproducible.  And for that matter the Mersenne Twister algo is _way_ 
too heavy for our needs.

The one that I just implemented basically boils down to:

	while (count--) {
		next = next * 1103515245 + 12345;
		putchar((next >> 16) & 0xff);
	}

and that does the job perfectly well.


Nicolas
