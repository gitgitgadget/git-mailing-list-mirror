From: jeffpc@josefsipek.net (Josef "Jeff" Sipek)
Subject: Re: Git network protocol
Date: Mon, 14 Aug 2006 19:48:26 -0400
Message-ID: <20060814234826.GA21861@josefsipek.net>
References: <20060814062117.GC10476@josefsipek.net> <7vk65bg6na.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 01:48:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCmAi-00056F-In
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 01:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965072AbWHNXsi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 19:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932741AbWHNXsi
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 19:48:38 -0400
Received: from mrs.stonybrook.edu ([129.49.1.206]:34192 "EHLO
	mrs.stonybrook.edu") by vger.kernel.org with ESMTP id S932739AbWHNXsh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 19:48:37 -0400
Received: from relay2.stonybrook.edu (relay2 [172.30.255.14])
	by mrs.stonybrook.edu (8.13.6/8.13.6) with SMTP id k7ENmX1i010401;
	Mon, 14 Aug 2006 19:48:33 -0400 (EDT)
Received: from mailrelay.stonybrook.edu ([172.30.255.14])
 by relay2.stonybrook.edu (SMSSMTP 4.1.12.43) with SMTP id M2006081419483311143
 ; Mon, 14 Aug 2006 19:48:33 -0400
Received: from josefsipek.net (turing.ams.sunysb.edu [129.49.108.158])
	by mailrelay.stonybrook.edu (8.13.6/8.13.6) with ESMTP id k7ENmVSI010397;
	Mon, 14 Aug 2006 19:48:33 -0400 (EDT)
Received: by josefsipek.net (Postfix, from userid 1000)
	id E735F1C00DF0; Mon, 14 Aug 2006 19:48:26 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vk65bg6na.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25425>

On Sun, Aug 13, 2006 at 11:42:33PM -0700, Junio C Hamano wrote:
> jeffpc@josefsipek.net (Josef "Jeff" Sipek) writes:
> 
> > I'm trying to implement the git protocol, and I am having a bit of an issue
> > with the lack of information available about it (please correct me if I
> > missed some source of information.)
> 
> Documentation/technical/pack-protocol.txt

This is pretty much a vague example - or at least it feels vague if you
don't know the protocol. After reading the source, and your description, the
example makes a lot more sense.

> "git show 1bd8c8f0".

Neat.

> After that, the client and the server try to determine what
> commits the client has that are recent ancestors of "want"
> commits.  This exchange is done by client sending bunch of
> "have" to the server.  The server responds "ACK" (in the
> original protocol) to say "I've seen enough and know a common
> ancestor to use".  In multi-ack protocol (which is used in
> modern git, v0.99.9 and later), the server can respond "ACK
> continue" to say "I've seen enough on that branch so do not
> bother sending 'have's for its ancestors, but do keep sending
> from other branch."  If the server does not feel it saw enough,
> it does not send either.

So, if I understand this correctly, multi_ack allows for multiple branches
to be fetched using the same connection?

> The protocol streams; if you see an ACK from server it does not
> usually mean it is ACKing the last 'have' client has sent.

Yeah, makes sense. Doing things over lo does things like that - I'm not sure
why I didn't realize it earlier.

Thanks,
Josef "Jeff" Sipek.

-- 
Don't drink and derive. Alcohol and algebra don't mix.
