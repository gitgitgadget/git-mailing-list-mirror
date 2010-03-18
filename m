From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: meaning of "-g" in git-describe output
Date: Wed, 17 Mar 2010 18:19:28 -0700 (PDT)
Message-ID: <alpine.LFD.2.00.1003171811420.18017@i5.linux-foundation.org>
References: <201003172320.45058.markus.heidelberg@web.de> <76718491003171614r2e8ce0e5r3e4799503194831c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 18 02:22:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ns4RI-0007Q2-9H
	for gcvg-git-2@lo.gmane.org; Thu, 18 Mar 2010 02:22:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754822Ab0CRBWP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Mar 2010 21:22:15 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34622 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754800Ab0CRBWO (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Mar 2010 21:22:14 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2I1MArw023791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 17 Mar 2010 18:22:11 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id o2I1M9F2027801;
	Wed, 17 Mar 2010 18:22:09 -0700
In-Reply-To: <76718491003171614r2e8ce0e5r3e4799503194831c@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.449 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142445>



On Wed, 17 Mar 2010, Jay Soffian wrote:
> 
> My guess, from 908e531 (Add a "git-describe" command, 2005-12-24), is
> that it's short for "git":

Indeed. I actually wanted to make it possible to use other SCM's, even if 
it's stupid. And git is not the only one that uses hashes for versioning, 
so the "g" prefix is there to allow others that use -hg or monotone or 
similar to work.

For the kernel, if you use mercurial, the kernel version prefix will be 
"hg", for example. For SVN, it will be "svn" (but the numbers won't be a 
hex number, they'll be the SVN revno). See 'scripts/setlocalversion' in 
the kernel tree for an example.

So 'git describe' tries to match this kind of "multi-SCM model", where you 
can describe versions of your software in an environment where people may 
well use different SCMs.

Of course, if you use "git describe", you'll always get the "g" thing, and 
it is entirely redundant within the settign of just git. But in a bigger 
setting, the point is that I can do this:

	[torvalds@i5 linux]$ git describe; uname -r
	v2.6.34-rc1-997-ga3d3203
	2.6.34-rc1-00959-gbca14dd

and they have basically the same format (not 100% identical, but the 
"-g<sha1>" part is similar - the SHA1's obviously don't match in this 
case, because the kernel I'm running is ~40 commits away from my current 
tip of tree, but you can see the pattern).

			Linus
