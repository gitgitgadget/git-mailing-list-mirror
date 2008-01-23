From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: I'm a total push-over..
Date: Wed, 23 Jan 2008 12:15:58 +0300
Message-ID: <20080123091558.GP14871@dpotapov.dyndns.org>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org> <4796FBB6.9080609@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Jan 23 10:16:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHbij-0004aW-Cu
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 10:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751433AbYAWJQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 04:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbYAWJQB
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 04:16:01 -0500
Received: from smtp05.mtu.ru ([62.5.255.52]:61311 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751043AbYAWJQA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 04:16:00 -0500
Received: from smtp05.mtu.ru (localhost [127.0.0.1])
	by smtp05.mtu.ru (Postfix) with ESMTP id 06E3FA2A4C9;
	Wed, 23 Jan 2008 12:15:58 +0300 (MSK)
Received: from dpotapov.dyndns.org (ppp85-141-188-241.pppoe.mtu-net.ru [85.141.188.241])
	by smtp05.mtu.ru (Postfix) with ESMTP id 9D8C1A2A084;
	Wed, 23 Jan 2008 12:15:58 +0300 (MSK)
Received: from dpotapov by dpotapov.dyndns.org with local (Exim 4.63)
	(envelope-from <dpotapov@gmail.com>)
	id 1JHbiA-0007Bu-GM; Wed, 23 Jan 2008 12:15:58 +0300
Content-Disposition: inline
In-Reply-To: <4796FBB6.9080609@op5.se>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-DCC-STREAM-Metrics: smtp05.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71526>

On Wed, Jan 23, 2008 at 09:32:54AM +0100, Andreas Ericsson wrote:
> 
> The FNV hash would be better (pasted below), but I doubt
> anyone will ever care, and there will be larger differences
> between architectures with this one than the lt_git hash (well,
> a function's gotta have a name).

Actually, Bob Jenkins' lookup3 hash is twice faster in my tests
than FNV, and also it is much less likely to have any collision.

The description and some comparision with other hash can be found here:
http://burtleburtle.net/bob/hash/doobs.html
http://burtleburtle.net/bob/c/lookup3.c

Perhaps, the second choice is Paul Hsieh's hash.
http://www.azillionmonkeys.com/qed/hash.html

Note: Paul Hsieh provides the table where he compares his hash
with others. There is also the program he used. I ran his program
on my computer, advantage of his over others was not so big on
my computer. Moreover, his test includes an old version of Bob
Jenkins' hash. The new version -- lookup3, which I mentione above,
has about the same speed as Paul Hsieh's hash (with -O2) or even
12% faster when I used -O3 -march=athlon-xp.

Also, Bob Jenkins' hash is better for non-x86 architectures. So,
I believe it is the best hash for today.

Dmitry
