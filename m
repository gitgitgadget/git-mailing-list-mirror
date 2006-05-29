From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Automatically line wrap long commit messages.
Date: Mon, 29 May 2006 02:16:35 -0700
Message-ID: <7virnp8a30.fsf@assigned-by-dhcp.cox.net>
References: <20060529085738.GB29500@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 11:16:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkdrb-0005sn-Dx
	for gcvg-git@gmane.org; Mon, 29 May 2006 11:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWE2JQh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 05:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWE2JQh
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 05:16:37 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:6305 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750806AbWE2JQg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 May 2006 05:16:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060529091635.PUJL554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 May 2006 05:16:35 -0400
To: Shawn Pearce <spearce@spearce.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20940>

Shawn Pearce <spearce@spearce.org> writes:

> When using -m on the command line with git-commit it is not uncommon
> for a long commit message to be entered without line terminators.
> This creates commit objects whose messages are not readable in
> 'git log' as the line runs off the screen.
>
> So instead reformat log messages if they are supplied on the
> command line.
>
> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> ---
>  This one might cause some problems for people.

I am already moderately negative on multiple -m so in the light
of it this one looks totally unneeded.  You could do a number of
things:

	$ git commit -m 'This is my message.

	This is the first line of the message body.'
        $ cat >L <<EOF
        This is my message.

	This is the first line of the message body.'
	EOF
	$ git commit -F L
	$ fmt <<EOF
        This is my message.

	This is the first line of the message body.'
	EOF
	$ git commit -F L

We probably should allow "commit -F -" to read from the standard
input if we already don't, but that is about as far as I am
willing to go at this moment.
