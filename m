From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Do not print "log" and "shortlog" redundantly in commit view
Date: Sat, 7 Oct 2006 15:24:57 +0200
Message-ID: <20061007132457.GB20017@pasky.or.cz>
References: <eg51fi$7rs$2@sea.gmane.org> <20061006221603.50873.qmail@web31815.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 15:25:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWCAx-0002S9-J3
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 15:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750720AbWJGNY7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 09:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751777AbWJGNY7
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 09:24:59 -0400
Received: from w241.dkm.cz ([62.24.88.241]:14245 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750720AbWJGNY7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 09:24:59 -0400
Received: (qmail 24915 invoked by uid 2001); 7 Oct 2006 15:24:57 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061006221603.50873.qmail@web31815.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28481>

Dear diary, on Sat, Oct 07, 2006 at 12:16:03AM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> --- Jakub Narebski <jnareb@gmail.com> wrote:
> > Gaah, the whole cae1862a3b55b487731e9857f2213ac59d5646d commit
> > "gitweb: More per-view navigation bar links" is somewhat broken.
> > Up to this point we used top navigation bar for commit (hash base)
> > or whole project related links, while bottom part of navigation
> > bar for "formats" i.e. links related to current view (passing hash)
> > or for pagination.
> > 
> > So while "snapshot" link has it's place in top navigation bar
> > (but by modyfying git_print_page_nav subroutine, not by adding it
> > by hand), "history" for example IMHO doesn't; history link should be
> > present in the bottom part of navigation bar. Perhaps we could
> > reuse git_print_page_nav for formats, for example blob wiew would have
> >         blob | _blame_ | _history_ | _raw_ | _HEAD_
> > while tree view would have
> >         tree | _snapshot_ | _history_ | _HEAD_
> > (where _text_ indices link).  Perhaps _snapshot_ in tree view
> > shouldn't be repeated, although top one might mean snapshot of commitish,
> > bottom one snapshot of tree.
> 
> Only a single one: of committish please.

Then it will be impossible to get snapshot of any subtree (apart of
manually constructing the URL). Hmm, and it's a bug that we don't show
the snapshot link when listing tree entry in tree listing, I thought we
did in the past...?

I think we should make it more clear what each of the bars concerns,
perhaps doing some more significant redesign:

[summary] is redundant, you have this big project name link in the top
left corner. All the other navbar options concern commit, so why not
merge it with the awkward commit box below the navbars?

All the "views bar" options concern the currently selected object, so
why not merge it with the object "descriptor", that is the path?

Patches will follow up.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
