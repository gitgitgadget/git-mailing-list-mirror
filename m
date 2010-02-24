From: Pat Thoyts <patthoyts@googlemail.com>
Subject: Re: [msysGit] Re: [GIT GUI PATCH] git-gui: fix open explorer window 
	on Windows 7
Date: Wed, 24 Feb 2010 12:12:24 +0000
Message-ID: <a5b261831002240412x30490e25wbec74cdbc1d0ebd2@mail.gmail.com>
References: <20100223225243.GC11271@book.hvoigt.net>
	 <201002240114.11634.markus.heidelberg@web.de>
	 <cb7bb73a1002232222r354a2ec7l9ea4cfd1c101e8c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Markus Heidelberg <markus.heidelberg@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, msysGit Mailinglist <msysgit@googlegroups.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:12:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NkG6T-0006zu-Iu
	for gcvg-git-2@lo.gmane.org; Wed, 24 Feb 2010 13:12:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756277Ab0BXMM2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2010 07:12:28 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:53635 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756217Ab0BXMM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2010 07:12:27 -0500
Received: by wya21 with SMTP id 21so1144054wya.19
        for <git@vger.kernel.org>; Wed, 24 Feb 2010 04:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=us1TqhpXXzO7lxq9xqTvBHHHT2MDc2MNSlcp3Lx1hGo=;
        b=g8j8DYdWGDi9EBnbso2suOLhYlD2jD/Tukh7gzdTBGCX3Ko+suP8qkadofBqTF3jhC
         07C6nXFd9XyNTu7r5IqjbFUbMuCXV2KddDUjnBL4NtmiaNFS+pk0lFvvU8yOhDPYhO0g
         MSPIZ4Dt+OYj0tUytSuBM2a9yyIOddSSE4s8c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jFvGlsM65z46AK+mu0RtKYYaWe/ClUhVAzyFSBw792XqWqI9dktkmscne8SKNFXvqD
         t8HEsCykRV0uMlvFpFvzcqxWrNp3YBlK7hfby/v+1XevKT55hjEckFcCd8iLuzCCEeas
         xyOTHWdCQg55/BsMAJ9WDJz9DcbZdISXz1nWk=
Received: by 10.216.154.70 with SMTP id g48mr1633258wek.109.1267013544812; 
	Wed, 24 Feb 2010 04:12:24 -0800 (PST)
In-Reply-To: <cb7bb73a1002232222r354a2ec7l9ea4cfd1c101e8c6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140928>

On 24 February 2010 06:22, Giuseppe Bilotta <giuseppe.bilotta@gmail.com> wrote:

>+               set path [list [string map {/ \\} $path]]

No - Tcl provides [file nativename $path] for this purpose.

>
> The only issue with that would be that GIT_DIR and GIT_WORK_TREE are
> (re)inizialized
> from _gitdir and _gitworktree, so it would not be safe if git on
> Windows works better with unix-style rather than native paths. If git
> on windows handles native paths fine, it should be no problem.

Tcl internally uses unix type path separators but once you export this
path to the operating system you may need to ensure it is a native
path. Typically that means when calling [exec]. [open] is a tcl
command and will deal with a path variable in either style. The Tcl
exec man page has some notes on the compatibility issues.

Pat.
