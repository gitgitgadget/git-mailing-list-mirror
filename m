From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH 3/3] git-p4: improve submit performance on new P4 servers
Date: Thu, 21 Jan 2010 22:59:24 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1001212242550.1726@xanadu.home>
References: <4B590808.6010206@naughtydog.com>
 <alpine.LFD.2.00.1001212147480.1726@xanadu.home>
 <4B591455.7050409@naughtydog.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Simon Hausmann <simon@lst.de>, Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 04:59:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYAgE-0002RL-04
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 04:59:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097Ab0AVD71 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 22:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752069Ab0AVD70
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 22:59:26 -0500
Received: from relais.videotron.ca ([24.201.245.36]:58907 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449Ab0AVD7Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 22:59:25 -0500
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KWM00DY9R30R2F0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 21 Jan 2010 22:59:25 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <4B591455.7050409@naughtydog.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137735>

On Thu, 21 Jan 2010, Pal-Kristian Engstad wrote:

> Nicolas Pitre wrote:
> > On Thu, 21 Jan 2010, Pal-Kristian Engstad wrote:
> > 
> >> Improve git-p4 submit performance on newer (from 2009.2) Perforce
> >> servers by changing "p4 diff -du" to "p4 diff -dub". This change is
> >> harmless since the output is only used for display purposes.
> >>
> >> Signed-off-by: Pal-Kristian Engstad <pal_engstad@naughtydog.com>
> > 
> > Why is the b flag impacting performance?
> 
> That's a very good question. The release notes say that they've been 
> changing how 'p4 diff -du' works, but the net effect of it all is that
> it stats all files in the whole working set. 

And so does git.

> For large projects, this
> takes forever. We say pauses of 3 minutes per submit...

This is abominable.

> > And even if for display purposes, why might you wish not to see 
> > differences in whitespace changes?
> 
> That's a good point, but what alternative is there?

Have the option of not seeing the diff in the submit template maybe?

I agree that P4 is slow. Painfully slow.  I even needed to make git-p4 
even slower by adding a time.sleep(1) in p4_build_cmd() otherwise the 
server would randomly drop the connection with the client when being 
contacted back to back.

I'm so glad Simon wrote this git-p4 nevertheless.  Makes working with P4 
almost enjoyable.


Nicolas
