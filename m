From: Sean <seanlkml@sympatico.ca>
Subject: Re: git reset --hard not removing some files
Date: Thu, 1 Jun 2006 12:13:04 -0400
Message-ID: <BAYC1-PASMTP04B113F61282BAE465D7F0AE900@CEZ.ICE>
References: <20060601160052.GK14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 01 18:19:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FlptW-0007Y4-H5
	for gcvg-git@gmane.org; Thu, 01 Jun 2006 18:19:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030222AbWFAQTb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Jun 2006 12:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030217AbWFAQTb
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Jun 2006 12:19:31 -0400
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:36784 "EHLO
	BAYC1-PASMTP04.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1030222AbWFAQTb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Jun 2006 12:19:31 -0400
X-Originating-IP: [65.93.43.191]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([65.93.43.191]) by BAYC1-PASMTP04.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 1 Jun 2006 09:19:30 -0700
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 46CF4644C28;
	Thu,  1 Jun 2006 12:19:29 -0400 (EDT)
To: Martin Waitz <tali@admingilde.org>
Message-Id: <20060601121304.9bae1806.seanlkml@sympatico.ca>
In-Reply-To: <20060601160052.GK14325@admingilde.org>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.9.1; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 01 Jun 2006 16:19:30.0636 (UTC) FILETIME=[2950E0C0:01C68597]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 1 Jun 2006 18:00:52 +0200
Martin Waitz <tali@admingilde.org> wrote:

Removed your prompt just to make it a bit more readable:

> $ git branch
> * master
>   next
>   origin
>
> $ git checkout -b test
>
> $ git status
> # On branch refs/heads/test
> nothing to commit

The generated files "git-quiltimport" and "git-upload-tar" exist at
this point.  They are both untracked files and aren't listed because
they have entries in the .gitignore file.

> $ git reset --hard v1.3.3
>
> $ git status
> # On branch refs/heads/test
> #
> # Untracked files:
> #   (use "git add" to add to commit)
> #
> #       git-quiltimport
> #       git-upload-tar
> nothing to commit

Resetting to version 1.3.3 gets you an old version of the .gitignore
file which doesn't ignore these two untracked files.  Reset --hard
doesn't remove them because it only deals with tracked files.  Thus,
they show up in your status report.

> $ git reset --hard master
> $ git status
> # On branch refs/heads/test
> nothing to commit

Returning to the current version gets you an updated .gitignore and the
two files are no longer listed even though they still exist.

> $ git --version
> git version 1.3.3.g0825d

This is the expected behavior regardless of version.

Sean
