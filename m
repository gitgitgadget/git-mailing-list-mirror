From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Pretty date option for git tag?
Date: Mon, 18 May 2009 10:20:49 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905181015080.3301@localhost.localdomain>
References: <20090518151440.GA10536@andros.its.yale.edu> <4A118696.80902@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dloewenherz@gmail.com, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon May 18 19:21:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M66WM-0006AL-KV
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 19:21:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbZERRUy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 13:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbZERRUx
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 13:20:53 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42067 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750934AbZERRUw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 May 2009 13:20:52 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4IHKnOT003048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 18 May 2009 10:20:50 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4IHKn3f023865;
	Mon, 18 May 2009 10:20:49 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <4A118696.80902@drmicha.warpmail.net>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.466 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119459>



On Mon, 18 May 2009, Michael J Gruber wrote:
> 
> You might want to experiment with
> 
> git log --tags --simplify-by-decoration --pretty="format:%ai %s"
> 
> which may show a few more commits than just the tags but comes close to
> the output you envisage.

Ooh, evil. I like it.

It's a rather expensive operation, but it does have the really nice 
property that it will show the date of the commit the tag is pointing to, 
rather than necessarily the date of the tag itself (which is not 
well-defined unless the tag is signed).

As you mention, "--simplify-by-decoration" will show merges too (unless it 
can linearize the tag history), but you can work around that by making the 
format be "format:%ai %d" where that '%d' shows the decoration of the 
commit, rather than the commit summary. Now the merges that aren't tagged 
stand out very clearly.

Of course, the above will just work for commit tags. If you've tagged a 
tree or a blob, the above gives you bubkis.

			Linus
