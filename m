From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: dmalloc and leaks in git
Date: Sun, 9 Dec 2007 12:57:02 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0712091251330.12046@woody.linux-foundation.org>
References: <9e4733910712081253t7cd43f87o6001f32fddc01565@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 21:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1TDN-0004y3-Lg
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 21:57:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751336AbXLIU5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 15:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbXLIU5G
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 15:57:06 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:44800 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751336AbXLIU5F (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Dec 2007 15:57:05 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB9Kv23r004676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 9 Dec 2007 12:57:03 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lB9Kv2O1001362;
	Sun, 9 Dec 2007 12:57:02 -0800
In-Reply-To: <9e4733910712081253t7cd43f87o6001f32fddc01565@mail.gmail.com>
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67661>



On Sat, 8 Dec 2007, Jon Smirl wrote:
> 
> But using dmalloc shows a pervasive problem, none of the git commands
> are cleaning up after themselves. For example I ran a simple command,
> git-status, and thousands of objects were not freed.

One thing to do is to use a better reporting tool.

For example, if you use

	valgrind --tool=massif --heap=yes ...

it will generate a postscript file with the allocation history as a graph 
of the different allocators in different colors etc. That would likely 
show where the big users come from..

		Linus
