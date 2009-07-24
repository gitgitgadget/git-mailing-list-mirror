From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Performance issue of 'git branch'
Date: Fri, 24 Jul 2009 15:59:17 -0700
Message-ID: <20090724225917.GA11191@spearce.org>
References: <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain> <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724225415.GC6832@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Jul 25 00:59:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTjb-0003qP-2I
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:59:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755154AbZGXW7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:59:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbZGXW7S
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:59:18 -0400
Received: from george.spearce.org ([209.20.77.23]:49063 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147AbZGXW7R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:59:17 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 00B4A381FE; Fri, 24 Jul 2009 22:59:17 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20090724225415.GC6832@mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123973>

Theodore Tso <tytso@mit.edu> wrote:
> On Fri, Jul 24, 2009 at 02:21:20PM -0700, Linus Torvalds wrote:
> > 
> > I wonder if there is some way to only load the crazy curl stuff when we 
> > actually want open a http: connection.
> 
> Well, we could use dlopen(), but I'm not sure that qualifies as a
> _sane_ solution --- especially given that there are approximately 15
> interfaces used by git, that we'd have to resolve using dlsym().

Yea, that's not sane.

Probably the better approach is to have git fetch and git push be a
different binary from main git, so we only pay the libcurl loading
overheads when we hit transport.

-- 
Shawn.
