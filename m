From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: How to push properly a la subversion
Date: Wed, 29 Jul 2009 23:50:44 +0400
Message-ID: <20090729195044.GA27178@dpotapov.dyndns.org>
References: <4A7095CE.8030307@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Stigler <matthieu.stigler@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 21:58:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWFI9-0007BI-TS
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 21:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbZG2T6Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 15:58:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751355AbZG2T6Q
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 15:58:16 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53964 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034AbZG2T6P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 15:58:15 -0400
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Wed, 29 Jul 2009 15:58:15 EDT
Received: by bwz19 with SMTP id 19so189392bwz.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 12:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7hEYJvDYEJrqSoy2Evx7xGAfRI/gP1Xqk2FVDYhxVBQ=;
        b=OZ4Yrz0f2EX1QIJLHFOJldbTIYUIO6FGg0WpkuK/2OJsZO6YvHakHu/GpDG9KWl5Gg
         NflosrYtM+W5ukd0V6qCCPLKKIwmI0B12XNlWEgPgHx6P+b7doH2q/jHhP/VOwWjQbQo
         nrZHq2yc1bqOepO2t1+YjqjBudH72T34s5wtg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=FXJEmBhak5iPpbi2N9l484SXSnCfiNm+JPMOAmeJbHlOxxAW/o7M56NW/k/uXepTXI
         V9xcCbyZ5o2AszUUQlbwcd7Sc6rGfkq5AXF0Vu/QSXUuzLmlTbcv510y3ny6FLWpiSkn
         VDk7J4rvORi3j6qtaqxKoGbpCJOtkda/Ph2Tg=
Received: by 10.204.67.70 with SMTP id q6mr142364bki.66.1248897081765;
        Wed, 29 Jul 2009 12:51:21 -0700 (PDT)
Received: from localhost (ppp85-140-124-177.pppoe.mtu-net.ru [85.140.124.177])
        by mx.google.com with ESMTPS id p17sm3615861fka.12.2009.07.29.12.51.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 12:51:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4A7095CE.8030307@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124383>

On Wed, Jul 29, 2009 at 08:32:46PM +0200, Matthieu Stigler wrote:
>
> I tried just by cloning A to B, changing/commiting B and the pushing to  
> A but: then on A the last log is integrated but I have this message with  
> gitk "local changes checked in to index but not commited", and those  
> local  changes are actually the version of A before the commit from B  
> :-( What I expected with svn mentality is that A is changed and 
> updated...

This is because git-push does not change your working tree. So, your
normally should never push to the branch that is currerently checked
out. (New versions of Git will warn you about that). As to having a
common/shared repo, it should be a "bare" repository.

>
> Should I enter a specifical push option? Or rather work on section  
> "Setting up a shared repository"? in  
> http://www.kernel.org/pub/software/scm/git/docs/gitcvs-migration.html ?
> I tried to do it entering:
>
> $ mkdir /pub/my-repo.git
> $ cd /pub/my-repo.git
> $ git --bare init --shared
> $ git --bare fetch /home/alice/myproject master:master
>
> but then I get also this message "local changes checked in to index but  
> not commited" and especially there are many git files appearing that we  
> would not want to see....

Strange... The above commands work perfectly for me.... And if you have
a bare repo then it should not have 'index'. So, the error does not make
much sense to me... Is it produced by gitk? Hmm, maybe some old version
of gitk did not work correctly with a bare repo... I dunno...

> And furthermore it seems there are complicated  
> permissions/ssh issues that I don't need (I'm doing for now only 
> locally).

I don't understand your troubles with permissions. Basically, there are
two options to setup a shared repo:
1. where every developer has each own account
2. a single account (but still each has each own ssh key)

The 'shared' option during init is necessary only for the first case to
make repository group writable. All users who can push to it should be
members of the group.

If you want to have a single system account for all users, you have two
options:
- gitosis
- ssh based authentification with forced command and then update hook
  if extra check is needed (see Documentation/howto/update-hook-example.txt)


Dmitry
