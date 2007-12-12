From: David Miller <davem@davemloft.net>
Subject: Re: Something is broken in repack
Date: Wed, 12 Dec 2007 08:42:12 -0800 (PST)
Message-ID: <20071212.084212.02518392.davem@davemloft.net>
References: <alpine.LFD.0.99999.0712112057390.555@xanadu.home> 	<alpine.LFD.0.99999.0712120743040.555@xanadu.home> 	<alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: nico@cam.org, jonsmirl@gmail.com, gitster@pobox.com, gcc@gcc.gnu.org,  git@vger.kernel.org
To: torvalds@linux-foundation.org
X-From: gcc-return-142938-gcc=m.gmane.org@gcc.gnu.org Wed Dec 12 17:43:00 2007
Return-path: <gcc-return-142938-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J2UfY-0003CK-CL
	for gcc@gmane.org; Wed, 12 Dec 2007 17:42:48 +0100
Received: (qmail 12938 invoked by alias); 12 Dec 2007 16:42:28 -0000
Received: (qmail 12929 invoked by uid 22791); 12 Dec 2007 16:42:27 -0000
X-Spam-Check-By: sourceware.org
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net (HELO sunset.davemloft.net) (74.93.104.97)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 12 Dec 2007 16:42:15 +0000
Received: from localhost (localhost [127.0.0.1]) 	by sunset.davemloft.net (Postfix) with ESMTP id 9AE45C8C15B; 	Wed, 12 Dec 2007 08:42:12 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0712120826440.25032@woody.linux-foundation.org>
X-Mailer: Mew version 5.2 on Emacs 22.1 / Mule 5.0 (SAKAKI)
X-IsSubscribed: yes
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68073>

From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 12 Dec 2007 08:37:10 -0800 (PST)

> I'm not saying that particular case happens in git, I'm just saying that 
> it's not unheard of. And with the delta cache and the object lookup, it's 
> not at _all_ impossible that we hit the "allocate in one thread, free in 
> another" case!

One thing that supports these theories is that, while running
these large repacks, I notice that the RSS is roughly 2/3 of
the amount of virtual address space allocated.

I personally don't think it's unreasonable for GIT to have it's
own customized allocator at least for certain object types.
