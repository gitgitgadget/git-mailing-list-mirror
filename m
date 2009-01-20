From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git fast-import problem converting from CVS with git 1.6.1 and
 cvs2svn 2.2.0
Date: Tue, 20 Jan 2009 15:29:08 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901201522250.19665@iabervon.org>
References: <63BEA5E623E09F4D92233FB12A9F794302BC6851@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Kelly F. Hickel" <kfh@mqsoftware.com>
X-From: git-owner@vger.kernel.org Tue Jan 20 21:30:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPNF3-00069B-E6
	for gcvg-git-2@gmane.org; Tue, 20 Jan 2009 21:30:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755616AbZATU3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 15:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754731AbZATU3L
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 15:29:11 -0500
Received: from iabervon.org ([66.92.72.58]:39625 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753359AbZATU3K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 15:29:10 -0500
Received: (qmail 11808 invoked by uid 1000); 20 Jan 2009 20:29:08 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 20 Jan 2009 20:29:08 -0000
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794302BC6851@emailmn.mqsoftware.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106520>

On Tue, 20 Jan 2009, Kelly F. Hickel wrote:

> Hello all,
> 
> Back in June I had done a test convert of our CVS repo using git 1.5.5.1
> and cvs2svn 2.2.0 that went reasonably well (although it takes nearly a
> week to finish!).  Recently I wanted to try again with the latest
> versions of git and cvs2svn.
> 
> When I get to the final stage (running git fast-import to build the
> converted repo), I get the following output:
> cat ../cvs2svn-tmp/git-blob.dat ../cvs2svn-tmp/git-dump.dat | git
> fast-import
> fatal: Unsupported command: '.
> fast-import: dumping crash report to .git/fast_import_crash_19097
> 
> The crash is 18MB and I'd rather not post it, but the only bits that
> seem somewhat interesting are:
> fast-import crash report:
>     fast-import process: 19097
>     parent process     : 19095
>     at Mon Jan 19 11:44:42 2009
> 
> fatal: Unsupported command: '.
> 
> Most Recent Commands Before Crash
> ---------------------------------
> (...)
>   reset refs/tags/T_9772
>   from :1000007127
>   reset refs/heads/TAG.FIXUP
>   
>   commit refs/heads/TAG.FIXUP
>   mark :1000007128
>   committer cvs2svn <cvs2svn> 1002043747 +0000
>   data 88
> * '.
> 
> 
> Has anyone got any ideas how to resolve this?

Can you find that part of the input? I wouldn't be too surprised if 
something were giving the wrong length in a data command, causing it to 
either eat another data command and end up in the data or to use 
not-quite-all of the data and end up near the end of the data.

	-Daniel
*This .sig left intentionally blank*
