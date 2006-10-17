From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: VCS comparison table
Date: Mon, 16 Oct 2006 17:08:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610161704240.3962@g5.osdl.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com>
 <45340713.6000707@utoronto.ca> <Pine.LNX.4.64.0610161625370.3962@g5.osdl.org>
 <200610170155.10536.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Aaron Bentley <aaron.bentley@utoronto.ca>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 02:09:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZcW4-0007kj-NB
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 02:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422965AbWJQAJF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Oct 2006 20:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422966AbWJQAJF
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Oct 2006 20:09:05 -0400
Received: from smtp.osdl.org ([65.172.181.4]:39366 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422965AbWJQAJE (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Oct 2006 20:09:04 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9H08vaX001305
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 16 Oct 2006 17:08:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9H08uHT001335;
	Mon, 16 Oct 2006 17:08:56 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610170155.10536.jnareb@gmail.com>
X-Spam-Status: No, hits=-0.473 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29002>



On Tue, 17 Oct 2006, Jakub Narebski wrote:
> > rewrites the part of your working tree that actually changed, so switching 
> > is extremely efficient even with a large repo. 
> 
> Unless you have branch(es) with totally different contents, like git.git
> 'todo' branch.

Yes. I have to say, that's likely a fairly odd case, and I wouldn't be 
surprised if other VCS's don't support that mode of operation at _all_.

The fact that git branches can be independent of each other is very 
natural in the git world, but 

> > So there is seldom any real need or reason to actually have multiple 
> > checkouts. But it certainly _works_.
> 
> But without .git being either symlink, or .git/.gitdir "symref"-link,
> you have to remember what to ser GIT_DIR to, or parameter for --git-dir
> option.

I'd strongly suggest that people who do this should actually do

	git clone -l

instead of actually playing games with symlinking .git/ itself or using 
GIT_DIR. It means that the two checkouts get separate branch namespaces, 
but that's really what you'd want most of the time. 

You _can_ share the whole branch namespace and do the symlink of .git (or 
just set GIT_DIR - but that's pretty inconvenient), and it might end up 
being "closer" to what some other VCS would do. But the natural thing to 
do with git is to just share some of the objects through local "slaving" 
of the repositories, and consider them otherwise entirely independent.

		Linus
