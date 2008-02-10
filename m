From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Alternative approach to the git config NULL value checking
 patches..
Date: Sun, 10 Feb 2008 15:36:43 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802101532070.2920@woody.linux-foundation.org>
References: <alpine.LFD.1.00.0802101225110.2896@woody.linux-foundation.org> <7vir0wfqrz.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0802101406560.2896@woody.linux-foundation.org> <7vbq6oe98y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 11 00:38:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOLl5-0002ej-Fj
	for gcvg-git-2@gmane.org; Mon, 11 Feb 2008 00:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753364AbYBJXiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Feb 2008 18:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752923AbYBJXiH
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 18:38:07 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41155 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752789AbYBJXiG (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Feb 2008 18:38:06 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1ANahYd018770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 10 Feb 2008 15:36:45 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1ANahXM019359;
	Sun, 10 Feb 2008 15:36:43 -0800
In-Reply-To: <7vbq6oe98y.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.725 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73436>



On Sun, 10 Feb 2008, Junio C Hamano wrote:
> >
> > And this is different from checking against NULL exactly how?
> 
> Exactly.  My answer to your question is: "It is not different
> from checking against NULL at all."

Of course it is.

Not using NULL means that things like

	strcmp()
	atoi()
	..

all work and automatically get the right answer and don't need to care.

Take a look at the NULL-compare patches. 90% of them are just noise.

Yes, the 10% that actually *cares* will look exactly the same (the 
difference being comparing against NULL or config_true), but all the stuff 
that compares against a special string can just ignore the fact that the 
special truth value will never ever match that string.

		Linus
