From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Dynamic window size on repack?
Date: Sun, 8 Jul 2007 14:39:45 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707081437590.31544@woody.linux-foundation.org>
References: <20070708211606.GF4087@lavos.net>
 <alpine.LFD.0.999.0707081429500.31544@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sun Jul 08 23:40:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7eUS-0004Ji-MW
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 23:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111AbXGHVkV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 17:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757457AbXGHVkV
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 17:40:21 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35391 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757111AbXGHVkU (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Jul 2007 17:40:20 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l68Ldpm1010075
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 8 Jul 2007 14:39:52 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l68Ldj1r025701;
	Sun, 8 Jul 2007 14:39:45 -0700
In-Reply-To: <alpine.LFD.0.999.0707081429500.31544@woody.linux-foundation.org>
X-Spam-Status: No, hits=-3.142 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51925>



On Sun, 8 Jul 2007, Linus Torvalds wrote:
>
> In other words, just look at how the variables "struct unpacked *array" 
> (the whole window array) and the "struct unpacked *n" (the "next entry" in 
> the array using a simple circular queue using "idx") are accessed.

Side note: a limit based on object sizes is likely a much better way to 
handle the window than just a "number of objects" thing ever was. Doing 
the size in number of objects was easier, and is fine for source code that 
tends to have a reasonably normal distribution of sized, but yeah, if you 
have a few really big objects with lots of history, then it's likely the 
wrong thing to do just because it can get really expensive.

		Linus
