From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: how to delete the entire history before a certain commit
Date: Mon, 03 May 2010 16:42:58 -0700 (PDT)
Message-ID: <m3k4rkft7k.fsf@localhost.localdomain>
References: <hrnidr$etm$1@dough.gmane.org>
	<m3ocgwfvw2.fsf@localhost.localdomain> <hrnl7o$nnf$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Gelonida <gelonida@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 04 01:43:11 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O95I6-0004Jl-Ux
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 01:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759935Ab0ECXnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 May 2010 19:43:05 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:49107 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759797Ab0ECXnB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 May 2010 19:43:01 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1300343fga.1
        for <git@vger.kernel.org>; Mon, 03 May 2010 16:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=Lc8af8W0aWacUmsCqGMcLGhDNaJ8y/KS8zIeD8OE0fE=;
        b=faTTS8oE4YfSeN+kTO6AX/MmTzO73z+5Gj9oApArtEvher8oyRsr4oFvGw6uF+y5cG
         gBKvgOjjFnwjOC3Tw59DoJST0p69CAMEfqV/aaUMeDqv1tAjz3UxW5siIknrqK30fFCf
         c2d8UX1yNjDNo3NayI6iOIO5HMxMziNLoafgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=JO2CW50EuJ7vSCKkvI70An+GKv6as0Lzucqu6Q8n93jQSkGfBjdWhB/o06tL3R9x72
         TqoaJUuM0ztydzT8WOZgP4wD1hjYTV+qqXO9oasiF20mgiW0NkUe1Se3PeABEptrvrDQ
         +mulWAw47hqNYCtnZnVc93gkRpDfEgbMNNIcg=
Received: by 10.87.47.23 with SMTP id z23mr11334142fgj.28.1272930179736;
        Mon, 03 May 2010 16:42:59 -0700 (PDT)
Received: from localhost.localdomain (abrz91.neoplus.adsl.tpnet.pl [83.8.119.91])
        by mx.google.com with ESMTPS id e3sm11608205fga.24.2010.05.03.16.42.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 03 May 2010 16:42:58 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o43NgYY6003159;
	Tue, 4 May 2010 01:42:44 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o43NgO5s003134;
	Tue, 4 May 2010 01:42:24 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <hrnl7o$nnf$1@dough.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146273>

Gelonida <gelonida@gmail.com> writes:
> Jakub Narebski wrote:
>> Gelonida <gelonida@gmail.com> writes:
>> 
>>> We have a git repository, whose size we want to reduce drastically due
>>> to frequent clone operations and a slow network connection.
>>  
>> Why frequent *clone* operations, instead of using "git fetch" or
>> equivalent ("git pull" which is fetch+merge, or "git remote update")?
> 
> The clone is part of the deployment process and would IIRC be equivalent
> to a 'svn export'
> Almost certainly one can also improve this, but this should probably
> discussed in another thread.
> 
> The sequence on some remote hosts is.
> - git clone tag dirname
> - rm -rf dirname/.git
> - tar cvfz dirname.tgz dirname
 
Why not simply (after enabling 'upload-archive' service in git-daemon
if you serve via git:// URL, and probably similar in the case of
SSH access management by gitosis or gitolite)

  $ git archive --remote=<repo> <tag>

(where <repo> is <dirname> in your example)?

>>> The idea is following:
>>>
>>> * archive the git repository just in case we really have to go back in
>>> history.
>>>
>>>
>>> create a new git repository, which shall only contain last month's activity.
>>>
>>> all changes before should be squashed together.
>>> It would be no problem if the very first commit remains unmodified.
>> 
>> If you want to simply _remove_ history before specified commit,
>> instead of squashing it, the best solution would be to use grafts to
>> cauterize (cut) history, check using [graphical] history viewer that
>> you cut it correctly, and then then use git-filter-branch to make this
>> cut permanent.
> 
> This sounds exactly as what I'd like to do.
> I used "git gui" => "Visualize All Branch History" y to choose a nice
> single cutoff point.
> I just didn't know how to apply the cut.

You can read about grafts in git-filter-branch(1) manpage, in
gitrepository-layout(5) git repository layout description, and in
gitglossary(7) a git glossary.

In short, each line in .git/info/grafts consist of sha1 id of object,
followed by space-separated list of its effective (grafted) parents.
So to cut history e.g. after commit a3eb250f996bf5e, you need to put
line containing only this SHA-1 in .git/info/grafts file, e.g.:

  $ git rev-parse --verify a3eb250f996bf5e >> .git/info/grafts
 
> So the command to look for is git-filter-branch, right ?
> I'll read the doc.


As you would see in git-filter-branch(1) documentation, simple

  $ git filter-branch --all

(no filter) would make history described by grafts permanent.

Note that this will be rewriting history, and you would make it (much)
harder on any contributor who based his/her work on commits from
before "rebase".
 
>> 
>> You can later use grafts or refs/replaces/ mechanism to join "current"
>> history with historical repository.
> 
> Probably we wont need this, but this sounds rather interesting and is
> good to know.

Grafts were for example used to fuse (join) current and historical
Linux kernel repositories, after Linux kernel moved from BitKeeper to
Git.

The 'git-replace' mechanism is meant as modern, transferable and safe
replacements for grafts file.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
