From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: q: faster way to integrate/merge lots of topic branches?
Date: Wed, 23 Jul 2008 11:04:07 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807231100310.4754@woody.linux-foundation.org>
References: <20080723130518.GA17462@elte.hu> <20080723135621.GJ22606@neumann> <20080723140441.GA9537@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: =?ISO-8859-15?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Jul 23 20:06:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLiiT-0002bT-Vs
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 20:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752909AbYGWSEe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 14:04:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752858AbYGWSEe
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 14:04:34 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37289 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752648AbYGWSEe (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Jul 2008 14:04:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6NI483D022906
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 23 Jul 2008 11:04:09 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m6NI47XX003919;
	Wed, 23 Jul 2008 11:04:07 -0700
In-Reply-To: <20080723140441.GA9537@elte.hu>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.399 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89726>



Ahh, missed that somebody already suggested it.

On Wed, 23 Jul 2008, Ingo Molnar wrote:
> 
> hm, it's very slow:
> 
>   $ time git branch --no-merged
>   [...]
> 
>   real    0m9.177s
>   user    0m9.027s
>   sys     0m0.129s
> 
> when running it on tip/master:
> 
>   http://people.redhat.com/mingo/tip.git/README

We can probably speed it up, but more importantly, even if we don't, it's 
slow _once_.

It's worth taking a 9s hit, if that means that you can then skip half of 
the merges entirely, and thus win half of the 53s cost. 

But I'll look if there's a way to cut it down from 9s. I suspect it has to 
traverse the whole history to make 100% sure that something isn't merged, 
but even that should be faster than 9s.

		Linus
