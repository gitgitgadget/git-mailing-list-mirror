From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: msysgit, help: teach git help to open html from /doc/git/html/
Date: Sat, 11 Aug 2007 20:10:21 -0400
Message-ID: <fcaeb9bf0708111710m1eca7a82t71d471e40e84ef93@mail.gmail.com>
References: <51772B53-642F-4D52-9CF3-906A21FC0D6F@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Marius Storm-Olsen" <marius@trolltech.com>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 02:10:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IK12U-0004yW-Kb
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 02:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754143AbXHLAKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 11 Aug 2007 20:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbXHLAKX
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Aug 2007 20:10:23 -0400
Received: from an-out-0708.google.com ([209.85.132.251]:29170 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbXHLAKW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2007 20:10:22 -0400
Received: by an-out-0708.google.com with SMTP id d31so221760and
        for <git@vger.kernel.org>; Sat, 11 Aug 2007 17:10:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NbTzJHzQ9AEH7rEmmS1GeZ4zVMo4IoREtWOjUpy1UnFvpAOqB1fV/A48z/ixtKZC0jEBx/aLcYKdc8PSRGg7CUzyvxJJ8OFGfmid3W1cEQy0MFW+R4r6cHoCC90EKmVJdVb74ejhYugkbpkzWim+0Qs1SBY8RrdnlxqNNg8Dkd8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OpLhVX6Q/fMwoQXyPSc77pQv32/Ej/0YQP/BBgSf7uF+EAOQ7M64m2wi8k7IRL3UfQELnnNezgYpfYxFFN+Bj9bsBkC9DaXxA/RkA2Xfz5WkgnneLT4Sz8ZbSbNRD90Lv/wga2WtIyxpsZfWwNt/GhRdds10Rjo5JzwXEDUh8pY=
Received: by 10.100.144.11 with SMTP id r11mr4096134and.1186877421443;
        Sat, 11 Aug 2007 17:10:21 -0700 (PDT)
Received: by 10.100.198.17 with HTTP; Sat, 11 Aug 2007 17:10:21 -0700 (PDT)
In-Reply-To: <51772B53-642F-4D52-9CF3-906A21FC0D6F@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55652>

This reminds me a patch I made before:

http://thread.gmane.org/gmane.comp.version-control.git/49217/focus=49575

With a little modification you can use ShellExecute to open html if
there is no suitable program to open it. The last commit on
mingw.git's mob branch does that (not based on my mentioned patch
though).

On 8/11/07, Steffen Prohaska <prohaska@zib.de> wrote:
> I pushed the following patch to 4msysgit.git's mob branch
>
> [ I finally found the mob branch at
> ssh://mob@repo.or.cz/srv/git/git/mingw/4msysgit.git
> which apparently was one git too much for my brain. ]
>
>
> commit a9a42a347894edfbca33e48bed0fcd38ec334a35
>
>      help (msysgit): teach git help to open html from /doc/git/html/
>
>      Html pages will be opened using the default Windows application
>      configured for html. This code path is taken for msysgit (mingw).
>
>      It is assumed that html pages are installed at /doc/git/html.
>      This needs to be ensured by the msysgit superproject to make this
>      patch useful. html pages should be cloned from git.git's main
>      repo. This is the easiest way to get up-to-date documentation,
>      without requiring the complete tool chain to generate them
>      locally.
>
>      If html pages are not yet there, you can use the following
>      commands to get them:
>
>          mkdir -p /doc/git/html
>          cd /doc/git/html/
>          git init
>          git config remote.origin.url git://git.kernel.org/pub/scm/
> git/git.git
>          git config remote.origin.fetch refs/heads/html:refs/remotes/
> origin/html
>          git fetch
>          git checkout --track -b html origin/html
>
>      and update the html documentation with
>
>          git pull
>
> The superproject should be setup in /share/GitMe/setup-msysgit.sh to
> fetch the html pages as a submodule. But I don't understanding
> submodules good enough to do so.
>
> If you then type 'git help <command>' Firefox or Explorer or whatever
> you configured as your default html viewer will show you the git help.
> I think this is a good idea for Windows users.
>
>
> Junio,
> are you interested in such patches at this time. The patch doesn't
> interfere with the existing code, but clutters it with ifdefs.
>
>         Steffen
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Duy
