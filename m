From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: Darcs-git pulling from the Linux repo: a Linux
	VM question
Date: Wed, 27 Apr 2005 09:16:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504270910510.18901@ppc970.osdl.org>
References: <7i7jionz5q.fsf@lanthane.pps.jussieu.fr>
	<Pine.LNX.4.58.0504270823480.18901@ppc970.osdl.org>
	<7iu0lskyfb.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@darcs.net
X-From: darcs-devel-bounces@darcs.net Wed Apr 27 18:11:08 2005
Return-path: <darcs-devel-bounces@darcs.net>
Received: from www.abridgegame.org ([66.179.181.159] helo=abridgegame.org)
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQp6Y-0006KF-AE
	for gcvdd-darcs-devel@m.gmane.org; Wed, 27 Apr 2005 18:09:38 +0200
Received: from localhost ([127.0.0.1] helo=www.abridgegame.org)
	by abridgegame.org with esmtp (Exim 4.50)
	id 1DQpAz-0004JE-Aj; Wed, 27 Apr 2005 12:14:13 -0400
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by abridgegame.org with esmtp (Exim 4.50) id 1DQpAw-0004Iq-8M
	for darcs-devel@darcs.net; Wed, 27 Apr 2005 12:14:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3RGE5s4019732
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Apr 2005 09:14:06 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3RGE3Zd022859;
	Wed, 27 Apr 2005 09:14:04 -0700
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
In-Reply-To: <7iu0lskyfb.fsf@lanthane.pps.jussieu.fr>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
X-BeenThere: darcs-devel@darcs.net
X-Mailman-Version: 2.1.5
Precedence: list
List-Id: "List for darcs-related development discussion."
	<darcs-devel.darcs.net>
List-Unsubscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=unsubscribe>
List-Archive: <http://www.abridgegame.org/pipermail/darcs-devel>
List-Post: <mailto:darcs-devel@darcs.net>
List-Help: <mailto:darcs-devel-request@darcs.net?subject=help>
List-Subscribe: <http://www.abridgegame.org/cgi-bin/mailman/listinfo/darcs-devel>,
	<mailto:darcs-devel-request@darcs.net?subject=subscribe>
Sender: darcs-devel-bounces@darcs.net
Errors-To: darcs-devel-bounces@darcs.net



On Wed, 27 Apr 2005, Juliusz Chroboczek wrote:
> 
> Here we're speaking about the initial import.  Committed on 17 April
> 2005 by Linus Torvalds, with the comment ``Let it rip''.  220 MB of
> changed files in a single commit.  2 minutes real time just to read
> all the files, never mind doing anything useful with them.

I think you may well want to consider the initial commit special. In many 
ways it is - it has no parents etc, so even apart from the fact that the 
initial commit obviously tends to be a lot bigger than any other commit, 
it actually fundamnetally is _technically_ different too.

> To put it mildly, Darcs is not optimised for that sort of usage.

It shouldn't be. Make the initial one a special case, and import things 
file-by-file for that one special case.

Afterwards, you should be able to handle other commits as "diffs", and
then it's entirely reasonable to have the difference all in memory. If
somebody really does end up having a 220MB diff, and darcs sucks at it,
then at that point I don't think it's darcs' problem any more, it's the
project that you're trying to track that is doing something wrong..

So if you _just_ consider the initial git commit special (and it's easy to 
notice by just looking at the lack of parents), then you may not need to 
change darcs in the other cases.

And almost all SCM's consider the initial state a special case anyway. The 
fact that GIT doesn't is just a result of the strange way of representing 
data, which doesn't care. I don't think you should emulate git in that 
respect.

		Linus
