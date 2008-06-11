From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Recovering from repository corruption
Date: Tue, 10 Jun 2008 18:39:51 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101836510.3101@woody.linux-foundation.org>
References: <6dbd4d000806101026m458513ecqa8141f509bad7602@mail.gmail.com> <m3abhtp42o.fsf@localhost.localdomain> <6dbd4d000806101238v2bb975abqd39916e45d4bf866@mail.gmail.com> <200806102159.02875.jnareb@gmail.com> <6dbd4d000806101303j4b2032ajc6e004e0a82e4db5@mail.gmail.com>
 <alpine.LFD.1.10.0806101317100.3101@woody.linux-foundation.org> <6dbd4d000806101328k1fc913f2ia55c3e44273ec5ad@mail.gmail.com> <alpine.LFD.1.10.0806101403080.3101@woody.linux-foundation.org> <6dbd4d000806101422j39709906x1b4b03b82b504e62@mail.gmail.com>
 <alpine.LFD.1.10.0806101431410.3101@woody.linux-foundation.org> <6dbd4d000806101509l516cf467me06fadee6ead0964@mail.gmail.com> <alpine.LFD.1.10.0806101518590.3101@woody.linux-foundation.org> <alpine.LFD.1.10.0806102026430.23110@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Denis Bueno <dbueno@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 11 03:40:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FKX-0000v4-3D
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 03:40:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753245AbYFKBj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 21:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753496AbYFKBj6
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 21:39:58 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40143 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753027AbYFKBj5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 21:39:57 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B1dqSh027678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 18:39:53 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B1dpSE007114;
	Tue, 10 Jun 2008 18:39:51 -0700
In-Reply-To: <alpine.LFD.1.10.0806102026430.23110@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.379 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84573>



On Tue, 10 Jun 2008, Nicolas Pitre wrote:
> 
> I think this only gives a false sense of security with a huge 
> performance cost.  If the machine crashes at the right moment, the 
> object will still be half written/fsync'd and you'll be in the same 
> situation again.

No you wouldn't.

We do the write and the fsync() of the write to a _temporary_ filename. We 
do the rename _after_ the fsync.

So you'd never have a half-written object file.

That said, I do agree that the bigger problem is that Denis' machine is 
simply so unreliable.

			Linus
