From: Junio C Hamano <junkio@cox.net>
Subject: Re: Creating attachments using git-format-patch
Date: Sun, 04 Mar 2007 13:33:09 -0800
Message-ID: <7vodn84ru2.fsf@assigned-by-dhcp.cox.net>
References: <loom.20070303T215950-974@post.gmane.org>
	<7vhct27xk2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0703032356050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vslcl7jxo.fsf@assigned-by-dhcp.cox.net>
	<7vmz2t7i1x.fsf@assigned-by-dhcp.cox.net>
	<45EB2294.9040702@issaris.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Panagiotis Issaris <takis.issaris@uhasselt.be>,
	git@vger.kernel.org
To: Panagiotis Issaris <takis@issaris.org>
X-From: git-owner@vger.kernel.org Sun Mar 04 22:33:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNyKR-0000ez-HG
	for gcvg-git@gmane.org; Sun, 04 Mar 2007 22:33:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917AbXCDVdL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Mar 2007 16:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752095AbXCDVdL
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Mar 2007 16:33:11 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:63601 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbXCDVdK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Mar 2007 16:33:10 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070304213310.BTBW2807.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Mar 2007 16:33:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id WlZ91W00C1kojtg0000000; Sun, 04 Mar 2007 16:33:09 -0500
In-Reply-To: <45EB2294.9040702@issaris.org> (Panagiotis Issaris's message of
	"Sun, 04 Mar 2007 20:48:36 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41370>

Panagiotis Issaris <takis@issaris.org> writes:

> The patch did not work for me in the sense that the patches still 
> appeared as inline text in both Mutt (1.5.13) and Thunderbird (2 beta 2).
>
> The email show up as being threaded in Mutt, but in Thunderbird they 
> still do not show up threaded.
> thread about git-format-patch attachments, so Thunderbird appears to 
> work alright).

If the patch below is needed, then I doubt you can honestly say
it appears to work...

> diff -u b/log-tree.c b/log-tree.c
> --- b/log-tree.c
> +++ b/log-tree.c
> @@ -186,7 +186,7 @@
>  			snprintf(subject_buffer, sizeof(subject_buffer) - 1,
>  				 "%s"
>  				 "MIME-Version: 1.0\n"
> -				 "Content-Type: multipart/mixed;\n"
> +				 "Content-Type: multipart/mixed;"
>  				 " boundary=\"%s%s\"\n"
>  				 "\n"
>  				 "This is a multi-part message in MIME "
> @@ -202,10 +202,10 @@
>  
>  			snprintf(buffer, sizeof(buffer) - 1,
>  				 "--%s%s\n"
> -				 "Content-Type: text/x-patch;\n"
> +				 "Content-Type: text/x-patch;"
>  				 " name=\"%s.diff\"\n"
>  				 "Content-Transfer-Encoding: 8bit\n"
> -				 "Content-Disposition: %s;\n"
> +				 "Content-Disposition: %s;"
>  				 " filename=\"%s.diff\"\n\n",
>  				 mime_boundary_leader, opt->mime_boundary,
>  				 sha1,

But if it helps some implementations of MIME decoder without
harming others, then I'd say why not.  I just wanted to make
sure it does not throw regression at others (for example by
making the physical line too long for them to grok).
