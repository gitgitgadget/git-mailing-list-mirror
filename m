From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git archive and trailing "/" in prefix
Date: Thu, 8 Oct 2009 13:35:25 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0910081329570.3432@localhost.localdomain>
References: <loom.20091008T172303-658@post.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 08 22:43:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MvzoM-0007UM-Ng
	for gcvg-git-2@lo.gmane.org; Thu, 08 Oct 2009 22:42:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760003AbZJHUgf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Oct 2009 16:36:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760017AbZJHUgf
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Oct 2009 16:36:35 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40182 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757141AbZJHUgf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Oct 2009 16:36:35 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n98KZPs5015064
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 8 Oct 2009 13:35:27 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n98KZPqt032677;
	Thu, 8 Oct 2009 13:35:25 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <loom.20091008T172303-658@post.gmane.org>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.463 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129715>



On Thu, 8 Oct 2009, Sergio Callegari wrote:
> 
> The git-archive man page indicates that if the --prefix option is passed to
> git-archive, it is compulsory to end the prefix with a "/"

Yeah, that part is intentional. And:

> As a matter of fact, the archiver behaves quite strangely if that slash is
> missing. Files in the root of the working dir are added to the archive with
> their own name modified by the prefix and the same happens for working dir
> sub-directories.

So far so good. But

> However, no file present in the sub-directories, nor sub-sub-directories 
> are added.

Ok, that is a bug. It's supposed to just add the prefix to everything, and 
it sounds like it's simply broken. I wonder how long it's been broken? 
Perhaps forever. 

> I would like to know if there some reason why a trailing "/" is not added
> automatically to the prefix when it is missing and the prefix is not empty.
> Would that break anything?

It really was meant to be useful to prefix things without forcing a 
directory structure. IOW, being able to use "--prefix=compat-" and just 
have everything unpack with their own names, but with the prefix.

Whether anybody uses that, and whether it's worth it, I can't say.

			Linus
