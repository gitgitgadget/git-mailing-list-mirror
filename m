From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Is it possible to have a file shared between branches?
Date: Mon, 12 Apr 2010 03:07:49 -0700 (PDT)
Message-ID: <m3ljctf0hs.fsf@localhost.localdomain>
References: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric LEBIGOT <Eric.Lebigot@normalesup.org>
X-From: git-owner@vger.kernel.org Mon Apr 12 12:08:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1GYg-0007zt-8i
	for gcvg-git-2@lo.gmane.org; Mon, 12 Apr 2010 12:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440Ab0DLKHx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Apr 2010 06:07:53 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:61544 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752282Ab0DLKHw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 06:07:52 -0400
Received: by bwz19 with SMTP id 19so2537bwz.21
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=ZMZ121oWdfmFyx8LUGzfjXTO8te3D5tpLLwD4N9omrs=;
        b=lPHk4zxMP9atrOHNokcYqwuObGvyTCPAUEjE8n7+yTg+Ngk6UcEKbED++eH+/La6M3
         r9wohtSusGJb8CifGjHbS9ot1RPhKkDO4F7EfZBg0uTN0/l8KNVUicr36Uyb1VgLFzDl
         J/lHupePotO1JBvBZe5IssvHf5gyJHqoFGGNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=AcFKLo7e1fIG9LkwTwTXxEK2+JH5rqPgpOe6apVxKejSO2v/OAcfHZObNqb0Zr6FRz
         iOB397hDmOrE3b3Yxs/MquL6wGFFpPO8wrjxMhcf/PqBmtJ0HgQEn9ZD8oxXhU9Q1iKN
         bIrDNKFRpJwAWFhMT00yxqki7xvIO3uNGV1Bo=
Received: by 10.103.48.12 with SMTP id a12mr1879310muk.14.1271066870420;
        Mon, 12 Apr 2010 03:07:50 -0700 (PDT)
Received: from localhost.localdomain (abvy192.neoplus.adsl.tpnet.pl [83.8.222.192])
        by mx.google.com with ESMTPS id s11sm16330947mue.41.2010.04.12.03.07.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 03:07:49 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o3CA7BIn023128;
	Mon, 12 Apr 2010 12:07:21 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o3CA6t0L023124;
	Mon, 12 Apr 2010 12:06:55 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <alpine.OSX.2.01.1004121058390.52293@kroll.spectro.jussieu.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144720>

Eric LEBIGOT <Eric.Lebigot@normalesup.org> writes:

> Is it possible for git to track a single file that would be shared
> accross branches?  Case in point: a to-do list file that describes
> what has to be done in all the branches; it can be convenient to put
> all the things that have to be done in a single, shared file, while
> keeping this to-do list in sync with the code (so that it lists what
> has been done, and what remains to be done).  Committing in a branch
> would in effect also commit the shared file in the other branches
> (another possibility may be to have in effect many "trees" in a single
> git directory, with a specific tree for the to-do list).
> 
> Is this something git can do?

Look how it is done in git.git repository.  If I remember it
correctly, Junio manages separate small repository inside
non-versioned Meta/ directory inside git.git checkout, which contains
TODO list and some scripts to help maintenance (e.g. to help generate
"What's in..." and "What's cooking..." emails).  

For distribution this repository is pushed into independent 'todo'
branch in git.git repository.  It doesn't share commits with other
"normal" branches, i.e. 'maint', 'master', 'next', 'pu'.

The 'todo' branch can be seen e.g. here:
  http://git.kernel.org/?p=git/git.git;a=shortlog;h=refs/heads/todo

The history of TODO file can be viewed e.g. here:
  http://git.kernel.org/?p=git/git.git;a=history;f=TODO;hb=refs/heads/todo

-- 
Jakub Narebski
Poland
ShadeHawk on #git
