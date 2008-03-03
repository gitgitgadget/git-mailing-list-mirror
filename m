From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git fetch: where are the downloaded objects stored?
Date: Mon, 03 Mar 2008 08:59:45 -0800 (PST)
Message-ID: <m3tzjnivzp.fsf@localhost.localdomain>
References: <4d8e3fd30803030440s7239c83cj8bf69401dd76bad@mail.gmail.com>
	<vpqskz82bm3.fsf@bauges.imag.fr>
	<4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Matthieu Moy" <Matthieu.Moy@imag.fr>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:00:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWE1k-0005zF-3U
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:00:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751628AbYCCQ7y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 11:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751389AbYCCQ7y
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 11:59:54 -0500
Received: from gv-out-0910.google.com ([216.239.58.187]:63210 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbYCCQ7x (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 11:59:53 -0500
Received: by gv-out-0910.google.com with SMTP id s4so90246gve.37
        for <git@vger.kernel.org>; Mon, 03 Mar 2008 08:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        bh=lokQkpWUHVhGR4mn6RBwwr+UmlwVM4bV3w8bdcOtWpk=;
        b=Cj8LdoxrJh/cz9Os85oXSVYPC1rQ042DQGmqjRLUaRytsWWDfjHqgo/A46RkP2P23bZDEnSpGSkiG8fpM7FMxWxCNJu42VmWhnaAhmbkG2Ebvi9ALZ362n4bUhe9QIHW6bDTnB+32aI0T/H731wbrD5eCtAE07iiGxbQVLChEvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to:message-id:lines:user-agent:mime-version:content-type:date;
        b=wDcnPZ+HpHRdKZ4FpVZHqIEopTLHdeBYqLujClcHbCEYGKAkfbfSl3RjnKkziz1lK6hVYY0GxTmNGAm6Jxs8y3ifPwX5sxEgfGuCWW1iSjtfH0kwaVO8XTt4vrykJq+XsLgSXC/w2Po01EPh46yt8yS+8MJo9fYlLrq5sXbuytA=
Received: by 10.114.76.1 with SMTP id y1mr300543waa.38.1204563587381;
        Mon, 03 Mar 2008 08:59:47 -0800 (PST)
Received: from localhost.localdomain ( [83.8.251.32])
        by mx.google.com with ESMTPS id k10sm528330nfh.17.2008.03.03.08.59.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Mar 2008 08:59:45 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m23GxtSt004108;
	Mon, 3 Mar 2008 17:59:56 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m23Gxs9f004105;
	Mon, 3 Mar 2008 17:59:54 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4d8e3fd30803030633nf6266d5qab0df4ba4c539e0b@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75944>

"Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:

> On Mon, Mar 3, 2008 at 2:14 PM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>> "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com> writes:
>>
>>> What is still not clear to me is where git is storing
>>> the objects downloaded during a git fetch operation.
>>
>>  git fetch downloads the objects to the object database, i.e.
>>  .git/objects/, usualy as a pack.

Downloading as individual objects ("exploded") or as a pack depends on
fetch.unpackLimit configuration.
 
>>  Now, just "having" the objects locally doesn't change much, an object
>>  starts being really interesting if you have a reference (typically, a
>>  branch) pointing to it. "git fetch" will update the remote references
>>  (for example, origin/master), but won't touch the working tree, and
>>  won't do any merge, fast-forward or not, to a local branch. So, most
>>  likely, "git fetch" will be followed by either a merge or a rebase.

What is important git-fetch _always_ stores what it fetched in
$GIT_DIR/FETCH_HEAD.

Then depending on configuration and command line options it updates
appropriate remote-tracking branches.  For example if you do one-shot
"git pull <remote> <branch>" git would not store fetched refs (heads)
in tracking branches: see git-fetch(1).
 
> Yes, your explanation perfectly match my understanding.
> 
> I was, and I'm still, confused by the following sentence in the git merge
> documentation:
>
>   "A merge is always between the current HEAD and one or more
>    remote branch heads"

This "remote" is here invalid. Merge can merge in any ref, not only
remote-tracking branches.  "git merge <branch>" would merge given
branch into current (HEAD) branch:

Before:

  1---2---3---4---5---6---7   <-- master <-- HEAD
               \
                \-A---B       <-- devel (or origin/master)

After "git merge devel"

  1---2---3---4---5---6---7---M   <-- master <-- HEAD
               \             /
                \-A---B-----/     <-- devel (or origin/master)

where 'M' is merge (multi-parent) commit.

> If I think to the following scenario:
> 
>  git fetch
>  git diff (to look at what I downloaded via git fetch)

Because you download _series_ of commits "git log" would be usually
more useful than "git diff".

You can use <branch>@{1} for position of branch before fetch, or even
ORIG_HEAD for position of HEAD branch before fetch (or pull).

>  git merge

I'm not sure if "git merge" without branch specified would work.
"git pull" should, so perhaps "git merge" would too.

"git pull" would merge 'first' branch, or branch specified in
branch/remote configuration.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
