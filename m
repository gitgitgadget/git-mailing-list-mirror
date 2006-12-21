From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] daemon.c blows up on OSX
Date: Wed, 20 Dec 2006 17:48:42 -0800
Message-ID: <7v64c63tol.fsf@assigned-by-dhcp.cox.net>
References: <7vmz5ib8eu.fsf@assigned-by-dhcp.cox.net>
	<86vek6z0k2.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201412250.3576@woody.osdl.org>
	<86irg6yzt1.fsf_-_@blue.stonehenge.com>
	<7vr6uu6w8e.fsf@assigned-by-dhcp.cox.net>
	<86ejquyz4v.fsf@blue.stonehenge.com>
	<86ac1iyyla.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201502090.3576@woody.osdl.org>
	<86wt4mximh.fsf@blue.stonehenge.com>
	<Pine.LNX.4.64.0612201524230.3576@woody.osdl.org>
	<caf068570612201636g75180138r223aef7c42f69a50@mail.gmail.com>
	<8664c6xdgi.fsf@blue.stonehenge.com>
	<24BF45E9-DD98-4609-9D65-B01EAA30CCA8@silverinsanity.com>
	<86psaevxo3.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Terje Sten Bjerkseth" <terje@bjerkseth.org>,
	"Linus Torvalds" <torvalds@osdl.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 02:48:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxD3B-0003AE-Gn
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 02:48:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161128AbWLUBso (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Dec 2006 20:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161129AbWLUBso
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Dec 2006 20:48:44 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35588 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161128AbWLUBso (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Dec 2006 20:48:44 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221014843.BTWW9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Dec 2006 20:48:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1Do11W0011kojtg0000000; Wed, 20 Dec 2006 20:48:01 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
In-Reply-To: <86psaevxo3.fsf@blue.stonehenge.com> (Randal L. Schwartz's
	message of "20 Dec 2006 17:35:08 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35004>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

>>> I tried the moral equivalent of that, and it failed to compile many
>>> other things then.  So that's not it.
> ...
> I did it with #if 0 / #end instead of the __APPLE_CC__ symbol.
> But, weirdly, now that I used the symbol, I get a good compile.
> ...
> Sorry for being objectionable earlier then.  I've attached the precise
> patch I used and works and verified.

Just to make sure... the attached looks exactly what Terje's
patch would have been before the whitespace damage.  Can I take
this as confirmation that the patch works for you and Terje?

I wonder what the earlier failure you got from "the moral
equivalent" was -- I hope it is not an indication that we have a
dependency bug in our Makefile somewhere.

Thanks.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index bc296b3..41fa7f6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -11,8 +11,10 @@
>  
>  #define ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
>  
> +#ifndef __APPLE_CC__
>  #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
>  #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
> +#endif
>  #define _GNU_SOURCE
>  #define _BSD_SOURCE
>  
> -- 
> 1.4.4.3.g9e3f8
