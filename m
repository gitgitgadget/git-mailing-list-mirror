From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: How to push properly a la subversion
Date: Thu, 30 Jul 2009 15:54:48 +0400
Message-ID: <20090730115448.GB27178@dpotapov.dyndns.org>
References: <4A7095CE.8030307@gmail.com> <20090729195044.GA27178@dpotapov.dyndns.org> <111060c20907300111u4345b1f1x784229c066fb3f88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, apenwarr@gmail.com
To: Matthieu Stigler <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 13:55:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWUEc-0002BQ-Hx
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 13:55:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbZG3Lzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2009 07:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752920AbZG3Lzd
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jul 2009 07:55:33 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:52395 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752686AbZG3Lzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2009 07:55:32 -0400
Received: by ewy10 with SMTP id 10so673074ewy.37
        for <git@vger.kernel.org>; Thu, 30 Jul 2009 04:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ssC1Nj0L+P00h8UA+Q91idxPXxObb+5+1tACCVuUuOc=;
        b=lupOypPOlkyiq2i5a90dJz1+pA2KFqyW5hBnBRaGF2LpFiczG6aDF/IZsooKKa8X02
         kuRG3tGsghqHnIfTjdW2lWiRSWZlJp0DErLEVw8JUYrvriTHHxnvB49c2Ase90lxpC/g
         37cIgWcz7VXr3F6h3U68dg4s5HcIMc30a2axw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=ZMWrBvjlsVjbbshygzSdMFgic6nATMOOq/QKY1s6gG8X5jfPmh62ZmQwNL41Ivnbr9
         4T1GypqL+scdokGDr2EskmKuUauFqCpiHDMROgeMv9VUbp0lY4mGMQv5aoGetfQaygOx
         GN3c/ETMfurvq1Zd3Arhp5m2efboNdqcYzk6s=
Received: by 10.210.119.5 with SMTP id r5mr1297871ebc.81.1248954931928;
        Thu, 30 Jul 2009 04:55:31 -0700 (PDT)
Received: from localhost ([91.78.51.135])
        by mx.google.com with ESMTPS id 28sm681532eye.14.2009.07.30.04.55.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Jul 2009 04:55:31 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <111060c20907300111u4345b1f1x784229c066fb3f88@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124459>

On Thu, Jul 30, 2009 at 10:11:43AM +0200, Matthieu Stigler wrote:
> 
> Furthermore, there are reluctant to install any new softwares
> and to use command line software,

Actually, gitk and 'git gui' are very nice... Well, I do prefer the
command line, but I still use gitk to see the history. There are
some other GUIs out there, but they should be installed separately.

> I used for now portable GIT on windows,
> which seems to have also ssh.

ssh client works fine on Windows, but I have never installed a shared
repo on Windows, which would require to install a ssh server. So, I
don't think I can help here.

> So I understood that I need to set-up a shared repo, thanks for your
> advices! Now do I really need all those permissions issues? What is the
> simplest way to deal with that?

If you want to have a shared repo then every developer should have the
write access to it and every file created by any developer should be
writable by other developers in the same group. To prevent any developer
from removing anything on the server, they should not have the normal
access to it but only through git-shell (i.e. git-shell should be
specified as the login shell). Now, it is often inconvinient to have
many special users accounts. So, you can use gitosis, which requires
only one user account and identified users by their SSH key. I heard
that some people set up it on Windows, but it was Cygwin version of Git.

As to the simplest way, it is probably to use a distributed workflow:
each developer has their own repo, which is writable for him/her and
readable for other developers. (You can easily to do with sharable
folders by assigning appropriate permissions, and you probably will not
need to deal with SSH at all). In this workflow, every group has each
own team leader or co-ordinator, who is responsible for integration
other people work. Then the repo of the team leader will becomes the
"official" repo of the project, but it is only social a convention and
not a technical one. Any developer can fetch from any repository (see
also git-remote). IMHO, the distributed workflow is far superior to
having everyone to push to the same repo.

In fact, as closer you emulate SVN workflow, more SVN issues, you will
pick up. For instance, 'svn commit' does two things: it creates a new
commit and propogate this changes to the server. In general, it is a
very bad thing to do, because you end up with a lot of work-in-progress
commits, which may be steps in the wrong direction, but they interfere
with other people work. With Git even using a central repo, you can do
better -- developers can push their work when they have finished.
Still, you may want to have some code review process. How are you going
to organize that? And then when someone works on some feature or have
some other work-in-porgress, you still want that this work will be
properly backed up (or at least, store more than in one place). So, you
naturally want to give every developer repo on that server where he/she
can push their work _before_ it is become part of the official history
of the project. And, finally, it is always good to have someone who
co-ordinates everyone's efforts, so intergation will be not randomly but
based on priorities and quality of one's work...


Dmitry
