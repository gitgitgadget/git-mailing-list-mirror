From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: mod-times (was: keyword expansion)
Date: Mon, 25 Apr 2005 17:34:59 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504251732410.18901@ppc970.osdl.org>
References: <200504251756.j3PHuSh01362@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 02:28:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQDvo-0000hz-JX
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 02:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVDZAdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Apr 2005 20:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261231AbVDZAdI
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Apr 2005 20:33:08 -0400
Received: from fire.osdl.org ([65.172.181.4]:53740 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261225AbVDZAdF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Apr 2005 20:33:05 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3Q0X0s4017761
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 25 Apr 2005 17:33:01 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3Q0WxIB017130;
	Mon, 25 Apr 2005 17:32:59 -0700
To: tony.luck@intel.com
In-Reply-To: <200504251756.j3PHuSh01362@unix-os.sc.intel.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 25 Apr 2005 tony.luck@intel.com wrote:
> 
> One way to do this would be to rip on some of the core fundamentals of GIT
> and store the time that an object was created inside the object. E.g.
> 
>    blob size secs-since-1970 ...

You really don't want that.

The thing is, somebody doing a "touch" on a file should _not_ cause that 
tree to be committed as a new tree.

Trying to save mtime in a git archive is about a million times worse than 
saving the whole "mode" information, and there we already ended up cutting 
it down to just one bit, exactly because it was horrible not to.

So this is not about git formats, this is about it just not being 
practical to do. Git simply isn't a good thing to store mtime in.

			Linus
