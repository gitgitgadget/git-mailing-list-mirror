From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Git - Pushing to a production website
Date: Sat, 10 Jan 2009 11:50:01 +0000 (UTC)
Organization: disorganised!
Message-ID: <slrngmh2r9.vur.sitaramc@sitaramc.homelinux.net>
References: <20090109222344.3539138a@family.dyweni.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 10 12:51:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLcNY-0005jS-6D
	for gcvg-git-2@gmane.org; Sat, 10 Jan 2009 12:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756151AbZAJLuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jan 2009 06:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756102AbZAJLuV
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jan 2009 06:50:21 -0500
Received: from main.gmane.org ([80.91.229.2]:54883 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755978AbZAJLuT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jan 2009 06:50:19 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LLcM0-0004VX-Pj
	for git@vger.kernel.org; Sat, 10 Jan 2009 11:50:12 +0000
Received: from atcmail.atc.tcs.co.in ([203.200.212.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 11:50:12 +0000
Received: from sitaramc by atcmail.atc.tcs.co.in with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 10 Jan 2009 11:50:12 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: atcmail.atc.tcs.co.in
User-Agent: slrn/0.9.9 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105099>

On 2009-01-10, <4jxDQ6FQee2H@dyweni.com> <4jxDQ6FQee2H@dyweni.com> wrote:

> Our company's website is stored in a GIT Repository.
>
> The repository is coded for our test server.  When we push updates to
> the production server, have manually run a script to patch several
> files to make the code work on the production server (i.e. port
> numbers, etc).
>
> I'd like to write a script to email me whenever someone changes files
> on the production server without checking those changes back into git
> (i.e. running 'git status | grep "nothing to commit" ...').

Shouldn't they change it in a sandbox and push it to prod
when it gets done instead of directly changing on prod?

> However, this approach get confused by the files patched to work
> correctly.
>
> Is there any way to 'save' those patched files so they don't get
> reported by 'git status', yet not mung up the git history every time
> we push out an update?

If you can enforce no changes directly to prod, you can have
the prod server's "master" branch be the one that QA or
whatever pushes to (no direct changes on prod).

You'd manually (one-time) create a branch called
prod_patches where you'd make just the changes needed (port
numbers etc as you said).

This would be the "checked out" branch.

On each push to master, a hook would just "cd wherever; git
rebase master"; the port changes would carry over.
