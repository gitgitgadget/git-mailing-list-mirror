From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add pack.depth option to git-pack-objects and change
 default depth to 50
Date: Tue, 08 May 2007 14:46:35 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705081439140.24220@xanadu.home>
References: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
 <11786309073709-git-send-email-tytso@mit.edu>
 <11786309072612-git-send-email-tytso@mit.edu>
 <alpine.LFD.0.99.0705081136050.24220@xanadu.home>
 <20070508163044.GA15796@thunk.org>
 <Pine.LNX.4.64.0705081848330.4167@racer.site>
 <20070508180947.GB15796@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue May 08 20:47:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlUiJ-0002Jm-S0
	for gcvg-git@gmane.org; Tue, 08 May 2007 20:47:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754496AbXEHSqo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 14:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966694AbXEHSqn
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 14:46:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65095 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966222AbXEHSqj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 14:46:39 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR003.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHQ00JWCK5NY200@VL-MO-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 14:46:35 -0400 (EDT)
In-reply-to: <20070508180947.GB15796@thunk.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46607>

On Tue, 8 May 2007, Theodore Tso wrote:

> After all, if we just stop and think about how the delta caching
> works, and how the repacking algorithm works, it's pretty clear that
> there shouldn't be any scaling issues with increasing --depth, and
> that increasing --window is just going to be painful, and these should
> hold true regardless of the size of the repo.

The window size has absolutely no effect on the runtime pack access, 
except maybe for the increased number of deltas.  It is really a pack 
time cost.  The delta depth is the opposite: it has no effect on the 
packing time, but it has the potential to slow down runtime access.  But 
the delta base cache is apparently working really well to mitigate that 
cost, as long as it is big enough of course.


Nicolas
