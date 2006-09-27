From: Jeff King <peff@peff.net>
Subject: Re: Notes on Using Git with Subprojects
Date: Wed, 27 Sep 2006 13:33:35 -0400
Message-ID: <20060927173335.GC2807@coredump.intra.peff.net>
References: <45196628.9010107@gmail.com> <Pine.LNX.4.64.0609261629160.9789@iabervon.org> <20060926213003.GA8177@spearce.org> <4519AACD.7020508@gmail.com> <20060927080652.GA8056@admingilde.org> <451AADC3.40201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Shawn Pearce <spearce@spearce.org>,
	Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 19:37:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSdI5-00006S-Rn
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 19:33:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030472AbWI0Rdi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 13:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030473AbWI0Rdi
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 13:33:38 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:58040 "HELO
	peff.net") by vger.kernel.org with SMTP id S1030472AbWI0Rdh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Sep 2006 13:33:37 -0400
Received: (qmail 21740 invoked from network); 27 Sep 2006 13:33:35 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 27 Sep 2006 13:33:35 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Sep 2006 13:33:35 -0400
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <451AADC3.40201@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27915>

On Wed, Sep 27, 2006 at 09:58:43AM -0700, A Large Angry SCM wrote:

> This means that modules are not separate, stand alone projects but, 
> rather, just a sub part of your bigger project. Very useful and 
> applicable in some situations but other situations want/need separate, 
> stand alone subprojects.

One thing that I believe some people have requested for subprojects is
to avoid downloading files/history for subprojects you're not interested
in.  I think this could be faciliated in this scheme by only cloning the
heads of the subprojects you're interested in (there would need to be
special machinery to handle this at the root level if we want to allow
making root commits without necessarily having all of the subprojects).

A first step to this would be an argument to git-clone to allow cloning
only a subset of refs.

> The problem I'm working on is how to deal with the sub parts of a larger 
> project when those sub parts are controlled by different entity. Silly 
> example: the kernel is controlled by Linus; glibc is controlled by the 
> GNU folks, gcc is controlled by some other GNU folks, the web server is 
> controlled by the Apache Foundation, the X server is controlled by Xorg, 
> etc.

The nice thing about this approach is that I believe the two systems
need only differ at clone time. Instead of creating a remotes file with
all of the subproject branches, you would just create multiple remotes
files. The root fetching porcelain needs to be smart enough to fetch all
remotes.

-Peff
