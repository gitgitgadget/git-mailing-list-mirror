From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Cache negative delta pairs
Date: Thu, 29 Jun 2006 14:30:11 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606291428150.12404@g5.osdl.org>
References: <20060628223744.GA24421@coredump.intra.peff.net>
 <7v4py4y7wo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606291053280.1213@localhost.localdomain>
 <20060629180011.GA4392@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291410420.1213@localhost.localdomain>
 <20060629185335.GA6704@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291458110.1213@localhost.localdomain>
 <20060629195201.GA10786@coredump.intra.peff.net>
 <Pine.LNX.4.64.0606291616480.1213@localhost.localdomain>
 <Pine.LNX.4.64.0606291352110.12404@g5.osdl.org>
 <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 29 23:30:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw45n-0007US-Cs
	for gcvg-git@gmane.org; Thu, 29 Jun 2006 23:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932716AbWF2Va2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 17:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932721AbWF2Va2
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 17:30:28 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49583 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932716AbWF2Va1 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Jun 2006 17:30:27 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5TLUCnW025328
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Jun 2006 14:30:13 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5TLUBhi010534;
	Thu, 29 Jun 2006 14:30:12 -0700
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0606291723060.1213@localhost.localdomain>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22909>



On Thu, 29 Jun 2006, Nicolas Pitre wrote:
>
> On Thu, 29 Jun 2006, Linus Torvalds wrote:
> 
> > Instead of having a separate cache, wouldn't it be much better to just 
> > take the hint from the previous pack-file?
> 
> DOH!  ;-)

Btw, I think this could do with a flag to turn it on/off (but probably 
default to on).

The advantage of this patch is that it should guarantee that if everything 
is already packed, a repack will basically keep the pack identical. 

However, that is obviously also the dis-advantage, since it means that 
repacking cannot improve packing. So adding a flag to say "please try to 
incrementally improve the pack" might well be worth it, even if this new 
behaviour would be the _default_.

Hmm? Jeff, does this work for your load?

		Linus
