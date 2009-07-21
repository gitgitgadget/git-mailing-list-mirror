From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: three-way diff performance problem
Date: Tue, 21 Jul 2009 11:16:32 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907211113260.19335@localhost.localdomain>
References: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 21 20:16:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTJtL-0008Uc-0X
	for gcvg-git-2@gmane.org; Tue, 21 Jul 2009 20:16:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753540AbZGUSQh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jul 2009 14:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbZGUSQg
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Jul 2009 14:16:36 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:55083 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751507AbZGUSQf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Jul 2009 14:16:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LIGX3X016510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 21 Jul 2009 11:16:34 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6LIGWkb005884;
	Tue, 21 Jul 2009 11:16:33 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907211038120.19335@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123682>



On Tue, 21 Jul 2009, Linus Torvalds wrote:
> 
> Now, being a git person, what does that say? Right: just check in the 
> working kernels as two branches under the same filename, then merge the 
> branches, and force the merge result to be the non-working kernel, and do 
> a three-way combined context diff! So I did exactly that.

Btw, I did it wrong, which is why it takes too long. Instead of making the 
result be the right dump-file, I made it be a bad one, so the diffs are 
much bigger than they should be. Which then makes the combined-merge diff 
take longer than necessary (with the O(n^2) thing).

Doing it _correctly_ actually made the three-way diff only take 45 
seconds, but sadly still left me with 22 thousand lines.

			Linus
