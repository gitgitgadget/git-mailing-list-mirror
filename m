From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] cg-pull to stop treating "master" specially, fix fetch_local for .git/HEAD
Date: Thu, 10 Nov 2005 20:24:30 +0100
Message-ID: <20051110192430.GS30496@pasky.or.cz>
References: <1124832796.23795.9.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 20:26:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaI2H-0004L1-EP
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 20:24:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbVKJTYe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 14:24:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbVKJTYe
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 14:24:34 -0500
Received: from w241.dkm.cz ([62.24.88.241]:20675 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751053AbVKJTYd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 14:24:33 -0500
Received: (qmail 20908 invoked by uid 2001); 10 Nov 2005 20:24:30 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
In-Reply-To: <1124832796.23795.9.camel@dv>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11507>

  Hello,

Dear diary, on Tue, Aug 23, 2005 at 11:33:16PM CEST, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> Local URL handling needs to be fixed to handle .git/HEAD properly, since
> it's a symlink in the upstream directory.  A new flag "-b" for fetch_*
> functions is introduced, meaning "dereference" (like in GNU cp).
> 
> @@ -205,6 +209,11 @@ fetch_local()
>  	[ "$1" = "-s" ] && shift
>  
>  	cp_flags_l="-vdpR"
> +	if [ "$1" = "-b" ]; then
> +		cp_flags_l="-vb" # Dereference symlinks
> +		shift
> +	fi
> +
>  	if [ "$1" = "-u" ]; then
>  		cp_flags_l="$cp_flags_l -fu$can_hardlink"
>  		suggest_hardlink=

  can you still remember why did you introduce this? In GNU cp
documentation, I can see just

       -b, --backup
              Make backups of files that are about to be overwritten or removed.

which doesn't make sense to me - -L dereferences symlinks.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
