From: Mike Hommey <mh@glandium.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sat, 11 Apr 2009 09:06:05 +0200
Message-ID: <20090411070605.GA29851@glandium.org>
References: <m3tz5023rq.fsf@localhost.localdomain> <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net> <alpine.LFD.2.00.0904102147590.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Robin H. Johnson" <robbat2@gentoo.org>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Apr 11 09:06:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsXIT-000692-Ue
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 09:06:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752776AbZDKHFE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 03:05:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752593AbZDKHFE
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 03:05:04 -0400
Received: from vuizook.err.no ([85.19.221.46]:43249 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750933AbZDKHFD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Apr 2009 03:05:03 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LsXGk-0001Tv-5Q; Sat, 11 Apr 2009 09:04:53 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LsXHx-0007op-3g; Sat, 11 Apr 2009 09:06:05 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904102147590.6741@xanadu.home>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116293>

On Fri, Apr 10, 2009 at 09:58:11PM -0400, Nicolas Pitre wrote:
> On Fri, 10 Apr 2009, Robin H. Johnson wrote:
> 
> > On Wed, Apr 08, 2009 at 12:52:54AM -0400, Nicolas Pitre wrote:
> > > > http://git.overlays.gentoo.org/gitweb/?p=exp/gentoo-x86.git;a=summary
> > > > At least that's what I cloned ;-) I hope it's the right one, but it fits
> > > > the description...
> > > OK.  FWIW, I repacked it with --window=250 --depth=250 and obtained a 
> > > 725MB pack file.  So that's about half the originally reported size.
> > The one problem with having the single large packfile is that Git
> > doesn't have a trivial way to resume downloading it when the git://
> > protocol is used.
> 
> Having multiple packs won't help the git:// protocol at all in that 
> regard.  In fact it'll just make it a bit harder on the server for all 
> cases, which has to generate a single pack for streaming anyway by using 
> multiple source ones and perform extra work in attempting delta 
> compression across pack boundaries.
> 
> > For our developers cursed with bad internet connections (a fair number
> > of firewalls that don't seem to respect keepalive properly), I suppose
> > I can probably just maintain a separate repo for their initial clones,
> > which leaves a large overall download, but more chances to resume.
> 
> I don't know much about git's http protocol implementation, but I guess 
> it should be able to resume the transfer of a pack file which might have 
> been interrupted in the middle?  If no then this should be considered.

It can.

Mike
