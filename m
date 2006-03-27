From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: Following renames
Date: Mon, 27 Mar 2006 13:19:02 +0200
Message-ID: <e5bfff550603270319w20796918wc8f8fe30a6c5627@mail.gmail.com>
References: <20060326014946.GB18185@pasky.or.cz>
	 <7virq1sywj.fsf@assigned-by-dhcp.cox.net> <e06fl8$p9f$1@sea.gmane.org>
	 <Pine.LNX.4.64.0603260843250.15714@g5.osdl.org>
	 <e06hts$1ne$1@sea.gmane.org>
	 <Pine.LNX.4.64.0603260947100.15714@g5.osdl.org>
	 <e5bfff550603261122m5e680c62ye1290f3e601e947e@mail.gmail.com>
	 <Pine.LNX.4.64.0603261422280.15714@g5.osdl.org>
	 <e5bfff550603262147t3aec8da6p6bf2a333e2d35f1d@mail.gmail.com>
	 <Pine.LNX.4.64.0603270005330.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 13:19:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNpkb-0002ek-9u
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 13:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbWC0LTF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 06:19:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbWC0LTE
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 06:19:04 -0500
Received: from wproxy.gmail.com ([64.233.184.227]:9883 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750886AbWC0LTE convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 06:19:04 -0500
Received: by wproxy.gmail.com with SMTP id i7so1452278wra
        for <git@vger.kernel.org>; Mon, 27 Mar 2006 03:19:03 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qk3b3rhkcImVMpQiTxzW4lvqfTLgwAg8SjBGp+/wnWMeMVDa2QFSaypiFMMLMrwOhza2P33ITFRpYdg6cI1tQ83s+T0JyeDEQEhLY915Tt8WuBwKlP1vmoF+UfJkLNBQwDwpiCY1ag3djHMpPtHUi4qn2A+8+UNbXdfpbGNVlMU=
Received: by 10.64.151.4 with SMTP id y4mr2269524qbd;
        Mon, 27 Mar 2006 03:19:02 -0800 (PST)
Received: by 10.65.163.13 with HTTP; Mon, 27 Mar 2006 03:19:02 -0800 (PST)
To: "Linus Torvalds" <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603270005330.15714@g5.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18079>

On 3/27/06, Linus Torvalds <torvalds@osdl.org> wrote:
>
>
> On Mon, 27 Mar 2006, Marco Costalba wrote:
> >
> > Historic Linux test (63428 revisions)
> >
> > File: drivers/net/tg3.c
> > Revisions that modify tg3.c : 292
> >
> > With qgit
> > 15s to retrieve file history (git-rev-list)
> > 19.5s to annotate (git-diff-tree -p, current GNU algorithm, not new faster one)
>
> .. and it does absolutely _nothing_ while it's doing that, does it?
>

yes, it's true.

> > $ time git-whatchanged HEAD drivers/net/tg3.c > /dev/null
> > 98.01user 2.44system 1:46.19elapsed 94%CPU (0avgtext+0avgdata 0maxresident)k
> > 0inputs+0outputs (797major+43033minor)pagefaults 0swaps
>
> In contrast, git-whatchanged will start outputting the recent changes
> immediately.
>
> And that's the point. Almost always, we're interested in the _recent_
> stuff. The fact that it takes longer to get the old history  is not very
> important. You generally don't ask "what changed in this file" for a file
> that hasn't changed in five years.
>

We could run git-rev-list with a time range specifier (changes of last
year as example) by default so to have fast results and run all time
history _only_  on request.

This perhaps could solve the fast output for recent revs problem, if
this is the problem.

I still think the problem with annotation is that you don't see
patches that _remove_ lines of code, you need the whole diff for this.

Marco
