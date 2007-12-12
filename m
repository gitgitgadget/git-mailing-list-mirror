From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Efficient retrieval of commit log info
Date: Wed, 12 Dec 2007 08:24:38 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712120819430.25032@woody.linux-foundation.org>
References: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Eirik Bj?rsn?s <eirbjo@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 12 17:25:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2UOw-0003CQ-0M
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 17:25:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755618AbXLLQZR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 11:25:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754956AbXLLQZQ
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 11:25:16 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:57995 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752677AbXLLQZP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Dec 2007 11:25:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBCGOcsu019593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Dec 2007 08:24:39 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lBCGOcNS018619;
	Wed, 12 Dec 2007 08:24:38 -0800
In-Reply-To: <34660cca0712120636w149e2a82h84609f8ac7c958a9@mail.gmail.com>
X-Spam-Status: No, hits=-2.414 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_23
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68069>



On Wed, 12 Dec 2007, Eirik Bj?rsn?s wrote:
> 
> Is it at all possible using the git network protocols to fetch just
> the commit log info, without transferring the contents?

>From a _protocol_ angle that's trivial (the git network protocol doesn't 
really care what it transfers, it just transfers objects), but no, we 
don't actually expose any capability like that. If you were to just want 
this privately, the quick hack is to just disable traversal of trees in 
builtin-pack-objects on the server side, but it sounds like you want to do 
this in general (not just with git and not just with a server you 
control), and if so, you're kind of screwed.

You could hack around it (very inefficiently) by parsing gitweb output, of 
course, but I bet that you'd probably get better performance just cloning 
the whole thing (which allows streaming, rather than trying to click 
through commits on gitweb)

		Linus
