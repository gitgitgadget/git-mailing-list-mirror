From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Bug in .gitignore handling
Date: Wed, 26 Mar 2008 13:32:31 -0700 (PDT)
Message-ID: <alpine.LFD.1.00.0803261330280.2775@woody.linux-foundation.org>
References: <47EAABB6.30803@thorn.ws> <alpine.LFD.1.00.0803261324380.2775@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Tommy Thorn <tommy-git@thorn.ws>
X-From: git-owner@vger.kernel.org Wed Mar 26 21:34:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JecJv-0004h9-K2
	for gcvg-git-2@gmane.org; Wed, 26 Mar 2008 21:34:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604AbYCZUdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2008 16:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756650AbYCZUdV
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Mar 2008 16:33:21 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59370 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756410AbYCZUdV (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Mar 2008 16:33:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2QKWWVo007755
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Mar 2008 13:32:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m2QKWVWv000656;
	Wed, 26 Mar 2008 13:32:31 -0700
In-Reply-To: <alpine.LFD.1.00.0803261324380.2775@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.885 required=5 tests=AWL,BAYES_00,SUBJECT_FUZZY_TION
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78309>



On Wed, 26 Mar 2008, Linus Torvalds wrote:
> 
> Basically, a path with a slash in it is considered absolute, but if the 
> slash is at the end it will only match a directory.

Actually, to clarify: a path with a slash in it *anywhere*else* than at 
the end will be considered absolute. At the end it means "only match 
directories".

So 

	foo

will match any file or directory anywhere in the tree, while

	foo/

will match a directory called "foo" anywhere in the tree, and

	/foo

will match either a file or directory called "foo", but only at the root 
of the repository.

And no, I didn't test it, but that's how it should work, afaik.

		Linus
