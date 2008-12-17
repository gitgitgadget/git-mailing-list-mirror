From: Nicolas Pitre <nico@cam.org>
Subject: Re: git-clone --how-much-disk-space-will-this-cost-me? [--depth n]
Date: Wed, 17 Dec 2008 11:15:56 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812171104340.30035@xanadu.home>
References: <4946F4D9.8050803@gmx.ch> <87zlixvtu9.fsf@jidanni.org>
 <49470D65.40808@gmx.ch> <alpine.LFD.2.00.0812160039180.30035@xanadu.home>
 <20081217154407.GZ32487@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jean-Luc Herren <jlh@gmx.ch>, jidanni@jidanni.org,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Dec 17 17:17:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCz5V-0000qr-Em
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 17:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYLQQQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 11:16:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbYLQQQE
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 11:16:04 -0500
Received: from relais.videotron.ca ([24.201.245.36]:55593 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751229AbYLQQQD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 11:16:03 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KC100KA13T9C0C0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 17 Dec 2008 11:15:10 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <20081217154407.GZ32487@spearce.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103358>

On Wed, 17 Dec 2008, Shawn O. Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > The fact is, fundamentally, we don't know how many bytes to push when 
> > generating a pack to answer the clone request.  Sometimes we _could_ but 
> > not always.  It is therefore better to be consistent and let people know 
> > that there is simply no ETA.
> 
> Hmm.
> 
> What if on an initial clone (no "have" lines received) we sum up
> the sizes of the *.pack and all of the loose objects and sent
> that as an initial size estimate.  Its going to be the upper bound
> of the final pack that we send.  At worst it over-estimates on the
> size and download finishes faster.

It is a kludge.  It makes the system imprecise for little benefit. Once 
you start adding kludges like that into your system, people will always 
ask for more kludges, and in the end your system isn't as reliable.  We 
all know about some other operating system which was designed like that. 
I personally don't want to go there.

> Yea, a single stray binary of some *.mpg or *.iso accidentally
> added and then removed (and now unreachable) will vastly inflate
> the numbers.  In which case the repository owner will be encouraged
> to prune when people won't clone his estimated 8 GiB download,
> which is actually only 1 MiB.

And I consider any system doing such thing completely stupid.  Either 
you consistently know the information or you don't.  When you don't, it 
is best to not create expectations for the user.  And so far I think 
that 99.9% of git users are just fine with the progress display we 
currently provide.


Nicolas
