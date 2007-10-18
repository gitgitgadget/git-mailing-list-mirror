From: Steffen Prohaska <prohaska@zib.de>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 17:14:49 +0200
Message-ID: <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: joakim.tjernlund@transmode.se
X-From: git-owner@vger.kernel.org Thu Oct 18 17:13:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiX44-0004Va-Ou
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 17:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755313AbXJRPNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 11:13:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbXJRPNZ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 11:13:25 -0400
Received: from mailer.zib.de ([130.73.108.11]:53291 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753534AbXJRPNY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 11:13:24 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l9IFDJZW026404;
	Thu, 18 Oct 2007 17:13:20 +0200 (CEST)
Received: from [130.73.68.185] (cougar.zib.de [130.73.68.185])
	(authenticated bits=0)
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l9IFDJ0K008863
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Thu, 18 Oct 2007 17:13:19 +0200 (MEST)
In-Reply-To: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61536>


On Oct 18, 2007, at 4:50 PM, Joakim Tjernlund wrote:

>
> I thougth I could create a new branch on the server using:
>
> # > git push ssh://devsrv/var/git/os2kernel.git linus:refs/linus
> Warning: No xauth data; using fake authentication data for X11  
> forwarding.
> updating 'refs/linus' using 'refs/heads/linus'
>  from 0000000000000000000000000000000000000000
>  to bbf25010f1a6b761914430f5fca081ec8c7accd1
> Generating pack...
> Done counting 0 objects.
> Writing 0 objects...
> Total 0 (delta 0), reused 0 (delta 0)
> error: refusing to create funny ref 'refs/linus' locally
> ng refs/linus funny refname
> error: failed to push to 'ssh://devsrv/var/git/os2kernel.git'
>
> but that doesn't work. Am I doing this wrong?

Include 'heads' in your remote refspec:

    git push ssh://devsrv/var/git/os2kernel.git linus:refs/heads/linus

You may need to cleanup though. I'm not sure if the remote side
already created 'refs/linus'. The error message only indicates that
locally git refused to create the "funny refname". Pushing a refspec
with an empty local part should delete the "funny refname" on the
remote:

    git push ssh://devsrv/var/git/os2kernel.git :refs/linus

Did this solve your problem?

	Steffen
