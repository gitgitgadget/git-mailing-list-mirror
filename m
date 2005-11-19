From: Franck <vagabon.xyz@gmail.com>
Subject: Re: [QUESTION] Access to a huge GIT repository.
Date: Sat, 19 Nov 2005 13:23:40 +0100
Message-ID: <cda58cb80511190423w1e46bf5bu@mail.gmail.com>
References: <cda58cb80511160424j1acac7c6j@mail.gmail.com>
	 <Pine.LNX.4.64.0511160837000.13959@g5.osdl.org>
	 <cda58cb80511170236p4a7e2baay@mail.gmail.com>
	 <Pine.LNX.4.64.0511170817480.13959@g5.osdl.org>
	 <cda58cb80511171347yef4f090g@mail.gmail.com>
	 <Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 13:24:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdRku-0005en-Nj
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 13:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbVKSMXm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 07:23:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbVKSMXm
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 07:23:42 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:43139 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751095AbVKSMXl convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2005 07:23:41 -0500
Received: by zproxy.gmail.com with SMTP id 14so410371nzn
        for <git@vger.kernel.org>; Sat, 19 Nov 2005 04:23:40 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CTgtY9ikkiitJ3JSMikQUZAVX0j+GtyOKGUp8QmhxW8iIZpCNsJt8yEfeubH87xSN6BMtv6SWak4tl+0c5ZUD1jCcAZKLEEvrEG7RM8emqqWD2y8aZqxLjDppOHPP5Wwiijb+Yu/UgPbqGjHHudg/dlw2bsgK7xrYEKM9BQrwvo=
Received: by 10.36.82.8 with SMTP id f8mr886835nzb;
        Sat, 19 Nov 2005 04:23:40 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Sat, 19 Nov 2005 04:23:40 -0800 (PST)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511171443000.13959@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12334>

2005/11/17, Linus Torvalds <torvalds@osdl.org>:
>
> > On Thu, 17 Nov 2005, Franck wrote:
> >
> > ok that's what I was trying to do by killing the parent object.  Now
> > when looking a the graph using gitk all old objects have been removed.
> > But I'm suprised because the git repository is the same size as it was
> > before pruning all old objects. Can you explain why ?
>
> make sure you re-pack if it was packed. "git prune" will not remove packs
> at all, so..
>

I just looked at git-prune script and it seems to remove unreachable
objects only in .git/objects/[0-9a-f][0-9a-f] directories, not in pack
files.

Then by running git-repack -a -d, I build a new small pack that
contains only latest objects, but then the script runs
git-redundant-pack script which erases the new small one since all its
objects are included in the old big one. Is that correct ? If so
git-redundant-pack script could return the oldest redundant ?

Thanks
--
               Franck
