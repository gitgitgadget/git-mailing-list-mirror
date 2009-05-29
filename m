From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: What is the mechanism of a git checkout?
Date: Fri, 29 May 2009 02:05:27 -0700 (PDT)
Message-ID: <m3hbz4b7ov.fsf@localhost.localdomain>
References: <23764024.post@talk.nabble.com>
	<slrnh1udov.6ls.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 29 11:05:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9y2A-0003st-Nz
	for gcvg-git-2@gmane.org; Fri, 29 May 2009 11:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757420AbZE2JF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2009 05:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757277AbZE2JF1
	(ORCPT <rfc822;git-outgoing>); Fri, 29 May 2009 05:05:27 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:55137 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756421AbZE2JF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2009 05:05:26 -0400
Received: by wa-out-1112.google.com with SMTP id j5so1233537wah.21
        for <git@vger.kernel.org>; Fri, 29 May 2009 02:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=CR5Syyyw8Yb0Ue18HQhFubbrgp1bvqxBJLpYgkregA0=;
        b=tX+IV4kXBOmGB4trwRKUL4OE3EwPUFPTRY6pST1FF2s9nOVkzFGiR/iPTAyazScAtl
         XkyPLFKu7hXa9cNMaSj9fTzCdR98c52yD5YuM26+6JQ/tkzcpIS+q45szG4xQgZwX0ZC
         L0QfHxzuoqoRLGplK/DgwEFofZMgrLAXOicwE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=PWVKmXroG7iKWvFF+wz5wMjqmjsbaXkzKMLOqNzbv3jAZoEjEROk6y0ECfDtRgCZAf
         +hEo2wB3APWAoJymrX4o77yVXrl3zzOjSLqrsL1TLRFK3jy+PejYmKcY4IGq1y4PZ6MS
         581izlO3/lNnQzp8rF5FBB6eOw7mzHBShcY2U=
Received: by 10.114.66.10 with SMTP id o10mr3565757waa.33.1243587928647;
        Fri, 29 May 2009 02:05:28 -0700 (PDT)
Received: from localhost.localdomain (abwe32.neoplus.adsl.tpnet.pl [83.8.228.32])
        by mx.google.com with ESMTPS id m17sm1581415waf.68.2009.05.29.02.05.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 29 May 2009 02:05:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4T95L3I010045;
	Fri, 29 May 2009 11:05:22 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4T95LeM010042;
	Fri, 29 May 2009 11:05:21 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <slrnh1udov.6ls.sitaramc@sitaramc.homelinux.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120262>

Sitaram Chamarty <sitaramc@gmail.com> writes:
> On 2009-05-28 15:21:59, mastermindxs <mastermindxs@gmail.com> wrote:
> >
> > does a git checkout pull the contents of a branch? how does it
> > physically separate files in your working directory from other
> > branches?
> >
> > The speed of which it works leads me to the logical conclusion
> > that the files in the working directory are all there for all
> > branches and git simply only shows you the files of the active
> > branch.
> >
> > Can anyone shed more light on the underlying mechanisms of git
> > checkout maybe even branch and merge as well?
> 
> I explain it as below when I get asked this question.  It's
> a simplified answer but largely correct, I believe.

[...]
>   - files that do show up in "git status" in the "before"
>     branch, are either modified or staged.
>     
>     - if the "before" branch version is the same as the
>       "after" branch version, that also is not touched.  In
>       the new branch, running "git status" will show you the
>       same files.
> 
>     - if the "before" branch version and the "after" branch
>       version are *not* the same, git would lose your local
>       (uncommitted) changes, so it refuses to do the
>       checkout and stays where it is.

In which case (there is file which is different in "before" and
"after", and which is modified in working area) you can ask git to try
to 'move' (merge) changes from "before" to "after" version of a file
with '-m' / --merge option, see git-checkout(1):

  git checkout -m after

-- 
Jakub Narebski
Poland
ShadeHawk on #git
