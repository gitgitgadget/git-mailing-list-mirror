From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Wed, 18 Oct 2006 15:00:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610181455570.3962@g5.osdl.org>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz>
 <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 00:01:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaJTL-0005xn-Cj
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 00:01:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423061AbWJRWBH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Oct 2006 18:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423063AbWJRWBH
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Oct 2006 18:01:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:30926 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423061AbWJRWBG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Oct 2006 18:01:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9IM0vaX019267
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 18 Oct 2006 15:00:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9IM0uId020046;
	Wed, 18 Oct 2006 15:00:57 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20061018214143.GF19194@spearce.org>
X-Spam-Status: No, hits=-0.97 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29286>



On Wed, 18 Oct 2006, Shawn Pearce wrote:
> 
> Actually there is a point to storing thin packs.  When I pull from
> a remote repo (or push to a remote repo) a huge number of objects
> and the target disk that is about to receive that huge number of
> loose objects is slooooooooow I would rather just store the thin
> pack then store the loose objects.
> 
> Ideally that thin pack would be repacked (along with the other
> existing packs) as quickly as possible into a self-contained pack.
> But that of course is unlikely to happen in practice; especially
> on a push.

I'm really nervous about keeping thin packs around. 

But a possibly good (and fairly simple) alternative would be to just 
create a non-thin pack on the receiving side. Right now we unpack into a 
lot of loose objects, but it should be possible to instead "unpack" into a 
non-thin pack.

In other words, we could easily still use the thin pack for communication, 
we'd just "fill it out" on the receiving side.

		Linus
