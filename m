From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git packs
Date: Fri, 9 Nov 2007 22:53:24 -0800 (PST)
Message-ID: <alpine.LFD.0.999.0711092244080.15101@woody.linux-foundation.org>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com>
 <alpine.LFD.0.9999.0711100011150.21255@xanadu.home>
 <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com>
 <alpine.LFD.0.999.0711092211250.15101@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: bob <kranki@mac.com>
X-From: git-owner@vger.kernel.org Sat Nov 10 07:53:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqkE2-00043Y-LZ
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 07:53:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751354AbXKJGxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 01:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751341AbXKJGxb
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 01:53:31 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:54378 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751204AbXKJGxa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 10 Nov 2007 01:53:30 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAA6rRbM025515
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 9 Nov 2007 22:53:28 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAA6rQoO027006;
	Fri, 9 Nov 2007 22:53:26 -0800
In-Reply-To: <alpine.LFD.0.999.0711092211250.15101@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.739 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64312>



On Fri, 9 Nov 2007, Linus Torvalds wrote:
> 
> That said, I have worked with a 3GB pack-file (one of the KDE trial 
> repos). That worked fine. But git does tend to want a *lot* of memory for 
> really big repositories, so I suspect that if you actually work with 2GB+ 
> pack-files, you'll be wanting a 64-bit environment just because you'll be 
> wanting more than 2GB of physical RAM in order to be able to access it 
> efficiently.

Just double-checked. Yes, sirree. You definitely want 4GB+ if you are 
cloning a 3GB git pack-file. The "git-pack-objects" phase not only is 
going to walk all over the pack-file, it's going to add its own memory 
footprint on top of that just keeping track of all the objects.

So I doubt 2GB+ pack-files are all that practical on 32-bit hosts. At 
least not with the kind of performance behaviour *I* would accept.

(Of course, since git packs things pretty damn well, it would need to be a 
really really big project to be a 2GB+ pack-file, or just contain a lot of 
generally large non-deltable binary data file - one scenario where git 
definitely doesn't work wonderfully well, although I doubt many other 
SCM's do either..)

			Linus
