From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Ramifications of a git-sh-setup outside the PATH
Date: Sat, 28 Jun 2008 14:01:21 +0200
Message-ID: <20080628120121.GB3489@steel.home>
References: <20080627140027.BIA12244@m4500-01.uchicago.edu>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@uchicago.edu>
X-From: git-owner@vger.kernel.org Sat Jun 28 14:02:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCZ8Y-0003i1-Tm
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 14:02:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561AbYF1MBY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 08:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbYF1MBY
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 08:01:24 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:39075 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750736AbYF1MBX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 08:01:23 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44jeZV
Received: from tigra.home (Fa959.f.strato-dslnet.de [195.4.169.89])
	by post.webmailer.de (fruni mo12) (RZmta 16.45)
	with ESMTP id N04c56k5S93VWj ; Sat, 28 Jun 2008 14:01:21 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 3CE93277BD;
	Sat, 28 Jun 2008 14:01:21 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 1B0EF56D2A; Sat, 28 Jun 2008 14:01:21 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080627140027.BIA12244@m4500-01.uchicago.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86713>

Jonathan Nieder, Fri, Jun 27, 2008 21:00:27 +0200:
> Hi gitsters,
> 
> I noticed in the release notes to Git 1.6.0 that dashed-form commands
> are moving to a libexecdir outside the PATH. I have been using Git
> with nd/dashless applied for about a month, and it does work well
> (thanks!). There was one little glitch: to use hg-fast-export.sh from
> fast-export.git (of repo.or.cz), I had to put git-sh-setup in the PATH.
> 
> I wanted to just change the ". git-sh-setup" line to ". git sh-setup",
> but of course that will not work. Am I missing something?

Try

    . "$(git --exec-path)/git-sh-setup"

"git-sh-setup" is not a command, but a Bourne Shell script you can use
in your scripts by including it. So ". git sh-setup" just tries to
_include_ file "git" (and will try $PATH and current directory) with
positional argument "sh-setup" (see man 1 bash, for example).
