From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is there a way to diff between a local repository and a remote one?
Date: Sun, 29 Jun 2008 05:38:00 -0700 (PDT)
Message-ID: <m38wwoifi7.fsf@localhost.localdomain>
References: <ce513bcc0806290429r1982fbf2i4c9a8258bc8db3c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Erez Zilber" <erezzi.list@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 14:39:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCwBK-0001r4-U7
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 14:39:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753989AbYF2MiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 08:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753465AbYF2MiF
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 08:38:05 -0400
Received: from qb-out-0506.google.com ([72.14.204.236]:21845 "EHLO
	qb-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbYF2MiD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 08:38:03 -0400
Received: by qb-out-0506.google.com with SMTP id d8so2815182qbc.37
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 05:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=/qwNO6Sj7KGmP6EwAOHlgXgXxdebYFiQmjXav62A59M=;
        b=pazNxmM0aWlOP/c+txzEFQx7lqvlNpcp+GQ2lHwN+kvvSWFv4D+INNlXB7gD1qU5q1
         DMrlCB4MzzEgSvI7+/9z+Wd6/96JtsmYT2NDCYYg2YvRvXMQVdm27mwraPfAfOQfgGUX
         5mCjHSIfQhUKHCEDaib66q3sA7SbSMdBQr9cY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=ZxR5PqkmyXf6iTs++1L3SRvePcS+2qgoNL7mK8w0gDmZy3StwPQPsJlCJZ+n5cnXW3
         ynz5+DM4D1q5s3wpC34Wy50G5zBPqAcQILCdZzpS8jcvBQhyZETLuLOrKajeEIXakw8F
         y6pgxdi8ooOAGrRLSL3xTNlAIeJc7FbxWgv5U=
Received: by 10.67.92.4 with SMTP id u4mr3178187ugl.75.1214743081665;
        Sun, 29 Jun 2008 05:38:01 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.214.210])
        by mx.google.com with ESMTPS id 5sm931177ugc.38.2008.06.29.05.37.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 05:38:00 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m5TCbWvw010764;
	Sun, 29 Jun 2008 14:37:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m5TCbL9r010758;
	Sun, 29 Jun 2008 14:37:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <ce513bcc0806290429r1982fbf2i4c9a8258bc8db3c@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86798>

"Erez Zilber" <erezzi.list@gmail.com> writes:

> Is there a way to diff between a local repository and a remote one?
>
> I could clone the remote repository and use Linux's diff, but I prefer
> to do it the right way (if possible).

There is no way to do this remotely; you have to download either
snapshot (tarball) of remote repository (either from gitweb interface
or other web interface if snapshot feature is enabled, or using 
"git archive --remote=<repo> <version>" (where <version> might be "HEAD")
if it is enabled on remote), or fetch / shallow fetch / shallow clone
of repository.

If local repository you want to diff is related to remote repository,
the simplest way would be to fetch (or shallow fetch) the repository
you want to compare into your repository, either using

  $ git remote add -f <nick> <URL>
  $ git diff HEAD <nick> #; or <nick>/HEAD, or <nick>/master

or

  $ git fetch --no-tags <URL> <branch> #; you can add --depth=1
  $ git diff HEAD FETCH_HEAD

(of course all above being in local repository; you can replace HEAD
by local revision you want to compare)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
