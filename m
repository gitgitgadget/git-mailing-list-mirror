From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git and GCC
Date: Thu, 06 Dec 2007 16:29:56 -0800 (PST)
Message-ID: <m3y7c7tkbs.fsf@roke.D-201>
References: <4aca3dc20712051947t5fbbb383ua1727c652eb25d7e@mail.gmail.com> 	<20071205.202047.58135920.davem@davemloft.net> 	<4aca3dc20712052032n521c344cla07a5df1f2c26cb8@mail.gmail.com> 	<20071205.204848.227521641.davem@davemloft.net> 	<4aca3dc20712052111o730f6fb6h7a329ee811a70f28@mail.gmail.com> 	<alpine.LFD.0.9999.0712052132450.13796@woody.linux-foundation.org> 	<1196968371.18340.30.camel@ld0161-tx32> 	<alpine.LFD.0.9999.0712061118050.13796@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>, Daniel Berlin <dberlin@dberlin.org>,         David Miller <davem@davemloft.net>,         Ismail Donmez <ismail@pardus.org.tr>, gcc@gcc.gnu.org,         git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: gcc-return-142781-gcc=m.gmane.org@gcc.gnu.org Fri Dec 07 01:30:32 2007
Return-path: <gcc-return-142781-gcc=m.gmane.org@gcc.gnu.org>
Envelope-to: gcc@gmane.org
Received: from sourceware.org ([209.132.176.174])
	by lo.gmane.org with smtp (Exim 4.50)
	id 1J0R6r-0005w1-2Q
	for gcc@gmane.org; Fri, 07 Dec 2007 01:30:29 +0100
Received: (qmail 19998 invoked by alias); 7 Dec 2007 00:30:10 -0000
Received: (qmail 19988 invoked by uid 22791); 7 Dec 2007 00:30:09 -0000
X-Spam-Check-By: sourceware.org
Received: from mu-out-0910.google.com (HELO mu-out-0910.google.com) (209.85.134.184)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Fri, 07 Dec 2007 00:30:02 +0000
Received: by mu-out-0910.google.com with SMTP id g7so185971muf         for <gcc@gcc.gnu.org>; Thu, 06 Dec 2007 16:29:59 -0800 (PST)
Received: by 10.86.73.17 with SMTP id v17mr1602193fga.1196987398463;         Thu, 06 Dec 2007 16:29:58 -0800 (PST)
Received: from roke.D-201 ( [83.8.224.19])         by mx.google.com with ESMTPS id e8sm650568muf.2007.12.06.16.29.55         (version=TLSv1/SSLv3 cipher=OTHER);         Thu, 06 Dec 2007 16:29:56 -0800 (PST)
Received: from roke (localhost.localdomain [127.0.0.1]) 	by roke.D-201 (8.13.4/8.13.4) with ESMTP id lB70XWtI030316; 	Fri, 7 Dec 2007 01:33:33 +0100
Received: (from jnareb@localhost) 	by roke (8.13.4/8.13.4/Submit) id lB70XRuY030313; 	Fri, 7 Dec 2007 01:33:27 +0100
In-Reply-To: <alpine.LFD.0.9999.0712061118050.13796@woody.linux-foundation.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Mailing-List: contact gcc-help@gcc.gnu.org; run by ezmlm
Precedence: bulk
List-Id: <gcc.gcc.gnu.org>
List-Unsubscribe: <mailto:gcc-unsubscribe-gcc=m.gmane.org@gcc.gnu.org>
List-Archive: <http://gcc.gnu.org/ml/gcc/>
List-Post: <mailto:gcc@gcc.gnu.org>
List-Help: <http://gcc.gnu.org/ml/>
Sender: gcc-owner@gcc.gnu.org
Delivered-To: mailing list gcc@gcc.gnu.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67359>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 6 Dec 2007, Jon Loeliger wrote:

>> I guess one question I posit is, would it be more accurate
>> to think of this as a "delta net" in a weighted graph rather
>> than a "delta chain"?
> 
> It's certainly not a simple chain, it's more of a set of acyclic directed 
> graphs in the object list. And yes, it's weigted by the size of the delta 
> between objects, and the optimization problem is kind of akin to finding 
> the smallest spanning tree (well, forest - since you do *not* want to 
> create one large graph, you also want to make the individual trees shallow 
> enough that you don't have excessive delta depth).
> 
> There are good algorithms for finding minimum spanning trees, but this one 
> is complicated by the fact that the biggest cost (by far!) is the 
> calculation of the weights itself. So rather than really worry about 
> finding the minimal tree/forest, the code needs to worry about not having 
> to even calculate all the weights!
> 
> (That, btw, is a common theme. A lot of git is about traversing graphs, 
> like the revision graph. And most of the trivial graph problems all assume 
> that you have the whole graph, but since the "whole graph" is the whole 
> history of the repository, those algorithms are totally worthless, since 
> they are fundamentally much too expensive - if we have to generate the 
> whole history, we're already screwed for a big project. So things like 
> revision graph calculation, the main performance issue is to avoid having 
> to even *look* at parts of the graph that we don't need to see!)

Hmmm...

I think that these two problems (find minimal spanning forest with
limited depth and traverse graph) with the additional constraint to
avoid calculating weights / avoid calculating whole graph would be
a good problem to present at CompSci course.

Just a thought...
-- 
Jakub Narebski
Poland
ShadeHawk on #git
