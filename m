From: Daniele Segato <daniele.bilug@gmail.com>
Subject: Re: Unable to checkout a particular SVN revision
Date: Sun, 29 Nov 2009 17:50:11 +0100
Message-ID: <1259513411.32532.22.camel@localhost>
References: <718EEBA2-FA4B-402D-B2FC-A8F14D79F6FF@entropy.ch>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Marc Liyanage <marc@entropy.ch>
X-From: git-owner@vger.kernel.org Sun Nov 29 17:50:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NEmyo-0006QT-K7
	for gcvg-git-2@lo.gmane.org; Sun, 29 Nov 2009 17:50:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276AbZK2QuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Nov 2009 11:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbZK2QuX
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Nov 2009 11:50:23 -0500
Received: from mail-ew0-f215.google.com ([209.85.219.215]:33430 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751416AbZK2QuW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Nov 2009 11:50:22 -0500
Received: by ewy7 with SMTP id 7so3569451ewy.28
        for <git@vger.kernel.org>; Sun, 29 Nov 2009 08:50:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=ka+2MZvk8ZLFlbP44Rn+0lZcMJXvq6BQHLoQt1p629Q=;
        b=BESlTkVnCXcdbWrMixl3WQXkITP0jWmv+7rD5OYChynbGg6/huLqSAk9tRlaUyVgfO
         6FWCZnh7aFP+iEkkUmFC6MNKaRtO3hOaQyAjGVq0waXYwZLnRSswb2UHtZD4wZjrL3Yo
         u9jWxQd4Oc8cAoI4P1VvlAJEKb9DHZE6MXbDE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=jO1DI3GibglGQe4zrSFn//+tX7H/LkC9o3VZqntwZG8B/k6MFKK8W26NLAwl0ddhyK
         rB3a0crzVFF4jxJMn0jonZfxrak4wMFyLktv/aNulzAv9pW6434FyDOHw3hhyEI2Auyu
         Ra8HIN3YaVhK9sTQg11BQme9xBt5ea5h33oDs=
Received: by 10.213.23.137 with SMTP id r9mr3526425ebb.34.1259513427348;
        Sun, 29 Nov 2009 08:50:27 -0800 (PST)
Received: from ?192.168.1.2? (host133-6-dynamic.50-82-r.retail.telecomitalia.it [82.50.6.133])
        by mx.google.com with ESMTPS id 5sm4136631eyf.8.2009.11.29.08.50.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Nov 2009 08:50:25 -0800 (PST)
In-Reply-To: <718EEBA2-FA4B-402D-B2FC-A8F14D79F6FF@entropy.ch>
X-Mailer: Evolution 2.26.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134024>

Il giorno ven, 27/11/2009 alle 18.05 -0800, Marc Liyanage ha scritto:
> I'm trying to clone a specific SVN revision with git-svn:
> 
>     git svn clone -r 12345 https://host/svn/foo/branches/bar xyz
> 
> but it doesn't check out any files, I see just this:
> 
>     Initialized empty Git repository in /Users/liyanage/Desktop/xyz/.git
> 
> If I try the same thing with SVN like this:
> 
>     svn co -r 12345 https://host/svn/foo/branches/bar xyz
>     
> then I get what I expect, it checks out all the files and "svn info" gives me this revision.
> 
> 
> I think it's because this particular revision wasn't committed on this branch, i.e. it doesn't show up in "svn log". If I try a revision that is listed in the log, it works as expected.
> 
> 
> Is there a way to make this work?


You had to understand the difference between a distributed version
control system (git) and a centralized version control system (svn).


On SVN there is a central repository and all user checkout a SINGLE
revision at a time, if they want to switch to another revision/branch
they had to update the local files communicating with the central
repository (can't work offline)


On Git you clone the ENTIRE history of a repository and you keep it
(all) locally. If you want to switch to another "revision" or branch you
can do it locally without interacting over network with a remote
repository, if you want to commit you can do it locally and the first
time you got connected to the network you can push your change to the
remote repository and pull others changes.

Git-SVN is a tool that allow you to interact with an SVN repository
using Git as client: the cool thing is that you get a lot of the
features of a distributed repository even if you are interacting with a
centralized one.
The bad news is that cloning the first time is really really slow: this
is because SVN has not been wrote to support distributed repository and
is not optimized to allow cloning of all the history.


to made thinks clearer:

SVN:

svn checkout -r <revision> <url> # this connect to <url> and download
that revision locally


GIT:

git svn clone <url> -T trunk -t tags -b branches # this connect to <url>
and start from revision 1 to the last cloning all the repository
(supposing you have a standard SVN structure with trunk/tags/branches)

this could keep a lot of time if it is a big repository (even days)

but when it is done you can checkout any revision:

git checkout <your-revision-commit>

git doesn't store the history as SVN do, revision numbers does NOT make
sense in a distributed environment... it just keep revision numbars
inside commits comments.. so you'll first had to search your revision
number into the git log history and then checkout the corresponding
commit.


Git is NOT another SVN client, is a completely different way of doing
versioning and you had to understand this and stop trying to use git as
you use svn until now
