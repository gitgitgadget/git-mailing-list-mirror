From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Request for detailed documentation of git pack protocol
Date: Wed, 3 Jun 2009 08:50:23 -0700
Message-ID: <20090603155023.GH3355@spearce.org>
References: <200905122329.15379.jnareb@gmail.com> <20090603144837.GE3355@spearce.org> <20090603150746.GF3355@spearce.org> <200906031739.49682.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 17:50:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBsjW-0001Fj-VS
	for gcvg-git-2@gmane.org; Wed, 03 Jun 2009 17:50:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755777AbZFCPuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2009 11:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbZFCPuW
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jun 2009 11:50:22 -0400
Received: from george.spearce.org ([209.20.77.23]:39165 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754689AbZFCPuV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2009 11:50:21 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 043FF381D1; Wed,  3 Jun 2009 15:50:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200906031739.49682.jnareb@gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120616>

Jakub Narebski <jnareb@gmail.com> wrote:
> On Wed, 3 Jun 2009, Shawn O. Pearce wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > 
> > Ok, I'm wrong.  It *doesn't* send the port.  The reason is obtuse,
> > but git_tcp_connect() clobbers the port number out of the host
> 
> What about git_proxy_connect()? Does it clobber port number either?

Dammit, not enough coffee.

We copy the string before the clobbering happens.  It *DOES* send
the port.  Either way, TCP or proxy.

JGit isn't compliant.  I'll send a patch soon.
 
> > name string, so that later when git_connect() sends this "host=%s",
> > only the host name is transmitted.
> 
> Hmmm... so does that mean that in the following fragment of deamon.c
> on branch is dead in practice?

No, its valid... I misread the client code.

> A question: do compliant implementation MUST not fail on receiving
> arguments it doesn't understand, e.g.:
> 
>    003bgit-upload-pack /project.git\0host=myserver.com\0user=me\0
> 
> or can it go hang the client, or silently fail?

My understanding is that a compliant server MUST accept and ignore
anything the client sends if it doesn't recognize it.

-- 
Shawn.
