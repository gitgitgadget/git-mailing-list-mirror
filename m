From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Re* ext3: fix ext3_dx_readdir hash collision handling -
 Regression
Date: Fri, 24 Oct 2008 15:26:46 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.0810241524350.3287@nehalem.linux-foundation.org>
References: <20081022093201.GA2227@gentoox2.trippelsdorf.de> <20081023032832.GE10369@mit.edu> <20081023063740.GA2438@gentoox2.trippelsdorf.de> <20081024000109.GD7842@mit.edu> <20081024042851.GA2360@gentoox2.trippelsdorf.de>
 <alpine.LFD.2.00.0810240853310.3287@nehalem.linux-foundation.org> <7vwsfx1wnb.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 25 00:28:12 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtV8c-0005BJ-E9
	for gcvg-git-2@gmane.org; Sat, 25 Oct 2008 00:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbYJXW05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Oct 2008 18:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755458AbYJXW05
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Oct 2008 18:26:57 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46941 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753669AbYJXW04 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Oct 2008 18:26:56 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9OMQkY1017964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Oct 2008 15:26:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9OMQkuB002807;
	Fri, 24 Oct 2008 15:26:46 -0700
In-Reply-To: <7vwsfx1wnb.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.443 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99075>



On Fri, 24 Oct 2008, Junio C Hamano wrote:
>
> Subject: allow readdir(3) to return the same entry twice

The thing is, this really is a kernel bug. We have even bisected it (and 
it hasn't hit any released kernel). The original reporter showed it with a 
simple "rm -r".

So it really isn't a git bug, even though I initially thought it might be, 
before I looked closer.

That said, the git patch may be worth it just because two *concurrent* 
invocations of "git clean" could then cause one (or both) to fail this 
way.

		Linus
