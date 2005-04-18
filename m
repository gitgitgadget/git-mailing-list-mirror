From: Petr Baudis <pasky@ucw.cz>
Subject: Re: optimize gitdiff-do script
Date: Mon, 18 Apr 2005 20:30:38 +0200
Message-ID: <20050418183038.GB5554@pasky.ji.cz>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com> <20050416232810.23430.78712.sendpatchset@sam.engr.sgi.com> <20050416234344.GQ19099@pasky.ji.cz> <20050416171009.0bedbab4.pj@sgi.com> <20050418082334.25359013.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 20:27:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNaxU-00019z-8p
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 20:26:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbVDRSav (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 14:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262160AbVDRSav
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 14:30:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33451 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262158AbVDRSaj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 18 Apr 2005 14:30:39 -0400
Received: (qmail 9672 invoked by uid 2001); 18 Apr 2005 18:30:38 -0000
To: Paul Jackson <pj@sgi.com>
Content-Disposition: inline
In-Reply-To: <20050418082334.25359013.pj@sgi.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, Apr 18, 2005 at 05:23:34PM CEST, I got a letter
where Paul Jackson <pj@sgi.com> told me that...
> Pasky,
> 
> Looks like a couple of questions I asked over the weekend
> got lost along the way.

Yes, sorry about that; I had a lot of mail traffic lately and I'm not so
used to it. ;-)

>  1) How do you want me to fix the indentation on my patch
>     to optimize gitdiff-do script:
> 	- forget my first patch and resend from scratch, or
> 	- a second patch restoring indentation, on top of my first one.

Resend from scratch, please.

I cannot guarantee I will look at it immediately, though. Optimizing is
nice, but gitdiff-do's speed is already usable and there are much more
pressing issues for git-pasky right now.

>  2) Would you be interested in a patch that used a more robust tmp
>     file creation, along the lines of replacing
> 
> 	    t=${TMPDIR:-/usr/tmp}/gitdiff.$$
> 	    trap 'set +f; rm -fr $t.?; trap 0; exit 0' 0 1 2 3 15
> 
>     with:
> 
> 	    tmp=${TMPDIR-/tmp}
> 	    tmp=$tmp/gitdiff-do.$RANDOM.$RANDOM.$RANDOM.$$
> 	    (umask 077 && mkdir $tmp) || {
> 		    echo "Could not create temporary directory! Exiting." 1>&2 
> 		    exit 1
> 	    }
> 	    trap 'rm -fr $tmp; trap 0; exit 0' 0 1 2 3 15
> 	    t=$tmp/tmp
> 
>     From the www.linuxsecurity.com link that Dave Jones provided, the
>     above $tmp directory is about as good as using mktemp, while
>     avoiding both dependency on mktemp options not everyone has.
> 
>  3) If interested in (2), would you want it instead of my previous mktemp
>     removal patch, or on top of it?

Instead of the previous patch. But what I said still holds - this can go
in only after we have a shell library sharing the common functions - I
don't want to have this horrid stuff in every file.

Actually, if you will make a mktemp shell function, no changes
whatsoever might be needed to the other scripts.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
