From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: hosting git on a nfs
Date: Fri, 14 Nov 2008 14:01:27 +0100
Message-ID: <491D76A7.9090809@drmicha.warpmail.net>
References: <200811121029.34841.thomas@koch.ro> <20081112173651.GA9127@linode.davidb.org> <alpine.LFD.2.00.0811120959050.3468@nehalem.linux-foundation.org> <loom.20081113T174625-994@post.gmane.org> <alpine.LFD.2.00.0811131214020.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131252040.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131518070.3468@nehalem.linux-foundation.org> <371xaQfxsMMQ-9LK24q-nhcS4loEggn8Cj3J1IzfMbzzYDGE6HKbQQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0811131630470.3468@nehalem.linux-foundation.org> <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	James Pickens <jepicken@gmail.com>,
	Bruce Fields <bfields@fieldses.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 14:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0yLU-0000hQ-T4
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 14:04:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751376AbYKNNBe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 08:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbYKNNBd
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 08:01:33 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54373 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289AbYKNNBd (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Nov 2008 08:01:33 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 259851B4E3C;
	Fri, 14 Nov 2008 08:01:30 -0500 (EST)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Fri, 14 Nov 2008 08:01:30 -0500
X-Sasl-enc: 4ifpM2ShTz/aKDx8j0KZD38VAbgH3chCTIWIoU8E9t+S 1226667689
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 201C3B535;
	Fri, 14 Nov 2008 08:01:29 -0500 (EST)
User-Agent: Thunderbird 2.0.0.17 (X11/20080914)
In-Reply-To: <alpine.LFD.2.00.0811131707090.3468@nehalem.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100970>

Linus Torvalds venit, vidit, dixit 14.11.2008 02:15:
> 
> On Thu, 13 Nov 2008, Linus Torvalds wrote:
>> I'll clean it up a bit and make a less hacky version. And I'll try to make 
>> it work for "git status" and friends too.
> 
> Ok, this is a no-longer-totally-hacky thing, which also adds support for 
> doing the same for "git status". I haven't actually done any timings, but 
> the preload algorithm is all the same. The interface is just a much more 
> natural one.
> 
> NOTE NOTE NOTE! It may not be totally hacky, but it's still not 
> "finished". There's a few more things to look at:

Doing nicely already. Over here, cold cache (i.e. sleep 70) "git status"
goes from 0.8s to around 0.4s. Nice. Hot cache goes from 0.18s to 0.23s.
This is really worthwhile if you hack for more than 60s between
diffs/stats ;)

This is already with the server doing some caching (first status was 8s
or so; hardly reproducible), which I can't control.

Michael
