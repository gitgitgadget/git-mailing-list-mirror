From: Petr Baudis <pasky@suse.cz>
Subject: Re: cygwin-latest: compile errors related to sockaddr_storage, dirent->d_type and dirent->d_ino
Date: Thu, 19 Jan 2006 14:00:09 +0100
Message-ID: <20060119130009.GA28365@pasky.or.cz>
References: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 19 13:59:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzZNN-0005NE-JE
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 13:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161157AbWASM6v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 07:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161186AbWASM6v
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 07:58:51 -0500
Received: from w241.dkm.cz ([62.24.88.241]:53433 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1161157AbWASM6u (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 07:58:50 -0500
Received: (qmail 22287 invoked by uid 2001); 19 Jan 2006 14:00:09 +0100
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0601180547q4a812c8xb632de6ab13a5e62@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14903>

I actually forgot to look at the patch.

Dear diary, on Wed, Jan 18, 2006 at 02:47:00PM CET, I got a letter
where Alex Riesen <raa.lkml@gmail.com> said that...
>  Makefile |    2 +-
>  daemon.c |    4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> 59379c380a6c2829c5614aadd4a5492abb8d14c8
> diff --git a/Makefile b/Makefile
> index f6d9e0a..5782e2a 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -342,7 +342,7 @@ ifdef NO_MMAP
>  	COMPAT_OBJS += compat/mmap.o
>  endif
>  ifdef NO_IPV6
> -	ALL_CFLAGS += -DNO_IPV6 -Dsockaddr_storage=sockaddr_in
> +	ALL_CFLAGS += -DNO_IPV6 -Dsockaddr_stg_git=sockaddr_in

  +else
  +	ALL_CFLAGS += -Dsockaddr_stg_git=sockaddr_storage

>  endif
>  
>  ifdef PPC_SHA1

  But of course when this goes on, soon the gcc commandline will get
really awfully ugly. This is why something _like_ autoconf is a good
thing - you can just detect if the system headers provide the type and
#define it only when they don't.

  Of course, inserting the #define to some .h file might work; I'm not
sure if any of the relevant socket routines is permitted to be a macro
which could expand to something - but even then, it's probably not very
likely that it would break stuff in practice.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
