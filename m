From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 17:25:44 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808141720250.3324@nehalem.linux-foundation.org>
References: <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home> <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
 <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org> <20080814233958.GA31225@atjola.homenet> <alpine.LFD.1.10.0808141656120.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Fri Aug 15 02:28:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTnAh-00018p-I2
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 02:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYHOA0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 20:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751961AbYHOA0t
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 20:26:49 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42968 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751670AbYHOA0t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 20:26:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7F0Pjgu000891
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 17:25:46 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7F0PibU005187;
	Thu, 14 Aug 2008 17:25:44 -0700
In-Reply-To: <alpine.LFD.1.10.0808141656120.3324@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92451>



On Thu, 14 Aug 2008, Linus Torvalds wrote:
> 
> I wonder how hard it would be to replace the whole table thing with our 
> generic hash.c hash thing. I'll take a look.

Ok, I did a quick version that didn't replace anything at all, and it 
doesn't look like there is room for that helping much. Yes, I can speed 
things up, but it didn't get much faster than just raising the delta cache 
to 1024 entries.

Admittedly my quick hack might have been fundamentally flawed, but it was 
such an ugly thing that I'm not even going to post it.

And the added memory footprint makes it unacceptable, so it's going to be 
limited by the cache size anyway, and not get a lot of hits in git 
rev-list, methinks.

		Linus
