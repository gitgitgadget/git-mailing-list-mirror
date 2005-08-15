From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: gitweb - option to disable rename detection
Date: Mon, 15 Aug 2005 11:53:20 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508151140050.3553@g5.osdl.org>
References: <87d5ofoxvt.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 15 20:55:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E4k5h-0002OW-4C
	for gcvg-git@gmane.org; Mon, 15 Aug 2005 20:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbVHOSxi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Aug 2005 14:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVHOSxi
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Aug 2005 14:53:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:65176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964882AbVHOSxh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Aug 2005 14:53:37 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7FIrMjA016073
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 15 Aug 2005 11:53:22 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7FIrLL8005875;
	Mon, 15 Aug 2005 11:53:21 -0700
To: Yasushi SHOJI <yashi@atmark-techno.com>
In-Reply-To: <87d5ofoxvt.wl@mail2.atmark-techno.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.44__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 16 Aug 2005, Yasushi SHOJI wrote:
> 
> It seems to me that git-diff-tree needs huge memory if you try to diff
> on big change with rename detection enabled.
> 
> This isn't problem for sane project but if you create a repo with only
> major releases imports, git-diff-tree run by git_commit() eats system
> memory and die ;P

Instead of disabling it entirely, how about just having some limit on it?

The basic rename detection works very well for "normal" changes as you 
point out, but it very fundamentally is O(n^2) in number of files created 
and deleted, so we could instead just limit it and say "if we have tons of 
new/deleted files, disable it in the interest of CPU/memory usage".

			Linus
