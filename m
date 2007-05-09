From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] Add a birdview-on-the-source-code section to the user manual
Date: Wed, 9 May 2007 14:32:05 +0200
Message-ID: <20070509123205.GN4489@pasky.or.cz>
References: <Pine.LNX.4.64.0705081709230.4167@racer.site> <20070509031803.GA27980@fieldses.org> <Pine.LNX.4.64.0705091414280.4167@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, kha@treskal.com,
	barkalow@iabervon.org, junio@cox.net, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 09 14:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HllL4-0000FY-Id
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbXEIMcK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:32:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755302AbXEIMcK
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:32:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41542 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751744AbXEIMcJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:32:09 -0400
Received: (qmail 16330 invoked by uid 2001); 9 May 2007 14:32:05 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0705091414280.4167@racer.site>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46703>

On Wed, May 09, 2007 at 02:19:03PM CEST, Johannes Schindelin wrote:
> diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
> index 2d58bb0..55934db 100644
> --- a/Documentation/user-manual.txt
> +++ b/Documentation/user-manual.txt
> @@ -3197,7 +3197,15 @@ basically _the_ header file which is included by _all_ of Git's C sources.
>  If you grasp the ideas in that initial commit (it is really small and you 
>  can get into it really fast, and it will help you recognize things in the 
>  much larger code base we have now), you should go on skimming `cache.h`, 
> -`object.h` and `commit.h`.
> +`object.h` and `commit.h` in the current version.
> +
> +In the early days, Git (in the tradition of UNIX) was a bunch of programs 
> +which were extremely simple, and which you used in scripts, piping the 
> +output of one into another. This turned out to be good for initial 
> +development, since it was easier to test new things.  However, recently 
> +many of these parts have become builtins, and some of the core has been 
> +"libified", i.e. put into libgit.a for performance, portability reasons, 
> +and to avoid code duplication.
> 
>  By now, you know what the index is (and find the corresponding data 
>  structures in `cache.h`), and that there are just a couple of object types 

I disagree, especially with the past tense of the first half of the
paragraph. Git is _still_ a bunch of programs you use in scripts, piping
the output of one into another. Another point is that
implementation-wise many of the code is currently shared in an internal
library, etc.

I'd be a bit careful to talk about libgit.a so leisurely since it might
give the reader an impression that there really _is_ "the git library",
with API and everything, that they can use externally. Of course you
need to mention libgit.a, but I'd also mention that it is so far meant
only for internal git's use and has no solidified API.

> @@ -3300,8 +3321,10 @@ Two things are interesting here:
>  
>  - the variable `sha1` in the function signature of `get_sha1()` is `unsigned 
>    char *`, but is actually expected to be a pointer to `unsigned 
> -  char[20]`.  This variable will contain the big endian version of the 
> -  40-character hex string representation of the SHA-1.
> +  char[20]`.  This variable will contain the 160-bit SHA-1 of the given 
> +  commit.  Note that whenever a SHA-1 is passed as "unsigned char *", it 
> +  is the binary representation (big-endian), as opposed to the ASCII 
> +  representation in hex characters, which is passed as "char *".
>  
>  You will see both of these things throughout the code.

To be honest, I wouldn't even be *thinking* about the endianity of SHA-1
octet representation (you don't usually really deal with the hash as
with a number, so expecting to have it in native endianity is not very
natural; you just deal with it as with a data blob) and the
"(big-endian)" would only confuse me and get me thinking about "huh, do
they swap the bytes, or wait, they don't, ...?!".

But that's maybe just me.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
