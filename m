From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git and GCC
Date: Thu, 6 Dec 2007 10:29:43 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712061024090.13796@woody.linux-foundation.org>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com>  <20071205.202047.58135920.davem@davemloft.net>  <4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com>  <20071205.204848.227521641.davem@davemloft.net>   <4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com>  <alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Miller <davem@davemloft.net>, ismail@pardus.org.tr, gcc@gcc.gnu.org,         git@vger.kernel.org
To: Daniel Berlin <dberlin@dberlin.org>
X-From: gcc-return-142756-gcc=m.gmane.org@gcc.gnu.org Thu Dec 06 19:30:17 2007
Return-path: <gcc-return-142756-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0LUG-0004YP-Ao
	for gcc@gmane.org; Thu, 06 Dec 2007 19:30:16 +0100
Received: (qmail 27207 invoked by alias); 6 Dec 2007 18:29:58 -0000
Received: (qmail 27189 invoked by uid 22791); 6 Dec 2007 18:29:57 -0000
X-Spam-Check-By: sourceware.org
Received: from smtp2.linux-foundation.org (HELO smtp2.linux-foundation.org) (207.189.120.14)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 06 Dec 2007 18:29:51 +0000
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55]) 	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6IThiE022682 	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO); 	Thu, 6 Dec 2007 10:29:44 -0800
Received: from localhost (localhost [127.0.0.1]) 	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB6IThNN005683; 	Thu, 6 Dec 2007 10:29:43 -0800
In-Reply-To: <4aca3dc20712061004g43f5902cw79bf633917d3ade9@mail.gmail.com>
X-MIMEDefang-Filter: lf$Revision: 1.188 $
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67314>



On Thu, 6 Dec 2007, Daniel Berlin wrote:
>
> I worked on Monotone and other systems that use object stores. for a 
> little while :) In particular, I believe GIT's original object store was 
> based on Monotone, IIRC.

Yes and no. 

Monotone does what git does for the blobs. But there is a big difference 
in how git then does it for everything else too, ie trees and history. 
Tree being in that object store in particular are very important, and one 
of the biggest deals for deltas (actually, for two reasons: most of the 
time they don't change AT ALL if some subdirectory gets no changes and you 
don't need any delta, and even when they do change, it's usually going to 
delta very well, since it's usually just a small part that changes).

> > And then it's going to take forever and a day (ie a "do it overnight"
> > thing). But the end result is that everybody downstream from that
> > repository will get much better packs, without having to spend any effort
> > on it themselves.
> 
> If your forever and a day is spent figuring out which deltas to use,
> you can reduce this significantly.

It's almost all about figuring out the delta. Which is why *not* using 
"-f" (or "--aggressive") is such a big deal for normal operation, because 
then you just skip it all.

		Linus
