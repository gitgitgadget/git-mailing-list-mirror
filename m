From: Nicolas Pitre <nico@cam.org>
Subject: Re: git and time
Date: Wed, 27 Sep 2006 22:51:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609272232040.9349@xanadu.home>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 28 04:52:11 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSm0K-0003Dr-Oo
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 04:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965237AbWI1Cv5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 22:51:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965239AbWI1Cv5
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 22:51:57 -0400
Received: from relais.videotron.ca ([24.201.245.36]:18332 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S965237AbWI1Cv4
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 22:51:56 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J6A004YC7YJ8AO0@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 27 Sep 2006 22:51:55 -0400 (EDT)
In-reply-to: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
X-X-Sender: nico@xanadu.home
To: Matthew L Foster <mfoster167@yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27970>

On Wed, 27 Sep 2006, Matthew L Foster wrote:

> --- Theodore Tso <tytso@mit.edu> wrote:
> 
> > On Wed, Sep 27, 2006 at 05:12:41PM -0700, Matthew L Foster wrote:
> > > 
> > > Ignoring the separate issue of replication for a momment, can
> > > someone respond to my time integrity question about whether a future
> > > version of git could trust/prefer its local time rather than a
> > > remote/sub/parent (non replicated) git server's timestamp? 
> > 
> > No, it can't.  In order to do that it would have to change the commit,
> > and that would be rewriting history.
> 
> Perhaps the actual change itself should not contain a "commit time", 
> only "local commit time" should matter or be tracked locally (if time 
> is tracked/matters any). To repeat from a previous mail, I am not 
> saying timestamps (local or other) should be tracked in a git 
> distributed way, quite the opposite, local commit time should be 
> tracked locally.

What I think you want and what you should talk about is that you're 
interested into the "local appearance time" for a given commit and not 
"local commit time".  Using that terminology is probably much less 
confusing in the GIT world.

To do so you'll need a GIT command that doesn'T exist yet.  Let's call 
it git-local-arrival.  It could be defined as follows:

SYNOPSIS

	git-local-arrival <committish>

DESCRIPTION

	The command displays the time when given commit appeared in the 
	local repository.

Is that what you want?  That's certainly something _I_ would be 
interested in.  But such a command would have to do some commit graph 
walking, based on the recorded reflog data, (there is not much 
documentation about reflog unfortunately) to find out exactly when given 
commit actually was fetched into the local repository.  While that would 
be perfectly acceptable to use on your own machine, I don't think it 
would be a good idea to let gitweb use it due to the computing cost 
required.

But again that's something possible but for which there is currently no 
code.

[ thinking out loud: maybe git-rev-list could provide that local 
  appearance time quite easily though... ]


Nicolas
