From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Stitching together two split segments from svn
Date: Thu, 24 Jul 2008 16:48:40 -0700 (PDT)
Message-ID: <m3ljzqvo6i.fsf@localhost.localdomain>
References: <654935030807241633g763e622br4feb8b4e23ee64e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Liam Healy" <lnp@healy.washington.dc.us>
X-From: git-owner@vger.kernel.org Fri Jul 25 01:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMAZA-0000JP-0k
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 01:49:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755121AbYGXXso (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jul 2008 19:48:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbYGXXso
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jul 2008 19:48:44 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:45894 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753382AbYGXXsn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jul 2008 19:48:43 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1193099nfc.21
        for <git@vger.kernel.org>; Thu, 24 Jul 2008 16:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=zeTzwxc8DiJXjbd/AJTBIUHx/89UQ2QGEc8T+9uZ0uM=;
        b=DkkYwlL2qhYU38oXzdF2e8RPDkwoiBj9ExW6WqgcjuQOa7IvFzF8PLdznCT9jY+yCQ
         S35nAZJuzg7B/0h8EQtekOyrx5owzGkWm9iUZjeNMupWik/kDUlohxw/u4ln7qXlimmy
         pZvyV0Apud2sBl1Ta4uEKKxVkV4M5j0w8a8Gg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=Jd2yFY/W6Of4GdL37Q11IujvG3lo+UovWav1MD+KUl3TMYRAmVkpOor/ptTT1YbLsA
         b+RtQmdC2uuxXwc/rc52UrYIvukDYj9f+F2iHWspq03BhHtcjGFQU4fRz+AqHqyuvtL5
         xuWc1xklN9/82FAyGCBTFZZXL/I1Ip8dXQpjU=
Received: by 10.210.21.6 with SMTP id 6mr1121469ebu.3.1216943321625;
        Thu, 24 Jul 2008 16:48:41 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.243.125])
        by mx.google.com with ESMTPS id y37sm14407210iky.8.2008.07.24.16.48.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 24 Jul 2008 16:48:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6ONmdH8008572;
	Fri, 25 Jul 2008 01:48:40 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6ONmc2P008569;
	Fri, 25 Jul 2008 01:48:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <654935030807241633g763e622br4feb8b4e23ee64e2@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89975>

"Liam Healy" <lnp@healy.washington.dc.us> writes:

> I have a project whose history is stored in two separate svn
> repositories.  The first repository I kept privately during initial
> development, the second started when I posted it publicly and does not
> have the history of the first.  I am trying to reunite them under git.
>  The development of the first was linear, so after using git svn, the
> history looks like:
> 
>  a - b - ... - c - d = HEAD (old repository)
> 
> and the second has one branch "ffa":
> 
> (new repository)
>  T - d - e - ... - f - g - h - ... - j   master
>                       \
>                        k - l - .... - m  ffa
> 
> Note that T is the "trunk" initial commit on the svn repo that has no
> files.  The second commit d is identical to the HEAD of old, as
> verified by git diff.
> However, when I remote add these two into a single repository, they
> show up as two detached chains, with no connection between them.  I
> thought git rebase would reconnect them.  However, when I do that on
> each branch (master and ffa), I get the following:
> 
>  a - b - ... - c - d - e - ... - f - g - h - ... - j   master
>                       \
>                        e - ... -f - g - k - l - .... - m  ffa
> 
> instead of what I would like
> 
>  a - b - ... - c - d - e - ... - f - g - h - ... - j   master
>                                      \
>                                       k - l - .... - m  ffa
> 
> That is to say, those commits from the new repository that have a
> common history for the two branches are duplicated.  The commits are
> listed separately and have different SHA IDs, but they are clearly the
> same commits (same comments, same svn version number).  Is there any
> way to do what I want?  Really, all I want to do is change the parent
> of "e" to be the HEAD of the old repository.

If this is initial import, and not published anywhere, the simplest (I
think) solution would be to use grafts file (.git/info/grafts) to
change parent of 'k' from 'g' in ffa to 'g' in master, by adding the
line with:

  <sha1 of 'k'> <sha1 of 'g' on master>

to .git/info/grafts.  Then examine history if everything is now all
right (for example using gitk), and if everything is O.K. run
git-filter-branch.

See documentation for details.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
