From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: committing empty diffs
Date: Mon, 12 Feb 2007 12:10:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702121202480.8424@woody.linux-foundation.org>
References: <68948ca0702121149p4d87ae07jd3aa532a0df79156@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Don Zickus <dzickus@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 12 21:12:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGhWv-0000k4-GH
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 21:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965285AbXBLUKs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 15:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965279AbXBLUKs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 15:10:48 -0500
Received: from smtp.osdl.org ([65.172.181.24]:40777 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965285AbXBLUKr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 15:10:47 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1CKAjhB023460
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 12 Feb 2007 12:10:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1CKAiaZ009949;
	Mon, 12 Feb 2007 12:10:44 -0800
In-Reply-To: <68948ca0702121149p4d87ae07jd3aa532a0df79156@mail.gmail.com>
X-Spam-Status: No, hits=-0.427 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.117__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39430>



On Mon, 12 Feb 2007, Don Zickus wrote:
> 
> Considering git-commit doesn't allow this (probably for good reason),
> is it technically safe to do the following sequence of events?

Yes. There's nothing *technically* wrong with an empty commit. The reason 
"git commit" doesn't do it is that it's just almost always a mistake.

> tree=$(git-write-tree)  #basically the same tree HEAD points to
> commit=$(echo $IDEAS | git-commit-tree $tree -p HEAD)
> git-update-ref HEAD $commit HEAD

If you know ahead-of-time that the tree is HEAD, there's no reason to do 
the "git-write-tree". You can just use "HEAD^{tree}" instead (and in 
fact, I think git-commit-tree will happily just take HEAD directly).

And please give a log messages for "git-update-ref"

Please do make sure to do some of the other sanity checks that "git 
commit" does, though. It is a good idea to at least verify that the commit 
message isn't empty etc.

		Linus
