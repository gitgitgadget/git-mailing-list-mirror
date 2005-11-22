From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: auto-packing on kernel.org? please?
Date: Tue, 22 Nov 2005 09:05:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511220904040.13959@g5.osdl.org>
References: <Pine.LNX.4.64.0510131113490.15297@g5.osdl.org> 
 <20051121190151.GA2568@hpsvcnb.fc.hp.com>  <Pine.LNX.4.64.0511211110480.13959@g5.osdl.org>
  <4382AC11.5090209@citi.umich.edu>  <Pine.LNX.4.64.0511212134330.13959@g5.osdl.org>
 <b0943d9e0511220613h5978a600l@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Chuck Lever <cel@citi.umich.edu>, Carl Baldwin <cnb@fc.hp.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 22 18:16:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eebh8-0001nQ-Tt
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 18:12:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbVKVRMZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 12:12:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965020AbVKVRMY
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 12:12:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:41932 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965019AbVKVRMW (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 12:12:22 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAMH5mnO029968
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 22 Nov 2005 09:05:49 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAMH5iXE016460;
	Tue, 22 Nov 2005 09:05:45 -0800
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0511220613h5978a600l@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12556>



On Tue, 22 Nov 2005, Catalin Marinas wrote:
>
> > The preferred way would be to just list the references somewhere under
> > .git/refs/stgit, in which case fsck and repack should pick them up
> > automatically (so clearly stgit doesn't do that right now ;).
> 
> I thought about adding .git/refs/patches/<branch>/* files
> corresponding to the every StGIT patch. Are the above git commands
> looking at all depths in the .git/refs/ directory?

Yes. Or at least they're supposed to. If they are not, it's a bug 
regardless, and we'll fix it.

> The 'git repack -a' command would include the applied patches in the
> newly created pack but leave out the unapplied ones. It would be even
> better to leave all of them out since the StGIT patches are frequently
> changed but an independent mechanism for this would complicate GIT -
> 'git repack' shouldn't pack any of the objects found in
> .git/refs/patches/, even if they are reachable via .git/refs/heads/*
> (and maybe call the patches directory something like
> .git/refs/unpackable or volatile).

If we have some default location (and .git/refs/patches/ sounds good), we 
can make git do the right thing - find them for git-fsck-objects, and 
ignore them for git-repack.

		Linus
