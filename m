From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] cvsserver: Make always-binary mode a config file option
Date: Thu, 01 Mar 2007 03:03:11 -0800
Message-ID: <7vhct5rztc.fsf@assigned-by-dhcp.cox.net>
References: <7v4ppedj3r.fsf@assigned-by-dhcp.cox.net>
	<200703010840.54377.andyparkins@gmail.com>
	<46a038f90703010113o256f19a2qb1c16f4c85e5bd1c@mail.gmail.com>
	<200703010941.20161.andyparkins@gmail.com>
	<7vk5y1uwhg.fsf@assigned-by-dhcp.cox.net>
	<7vr6s9th4f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Martin Langhoff" <martin.langhoff@gmail.com>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 12:03:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMj4S-0002wF-AR
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 12:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964962AbXCALDP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 06:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964944AbXCALDP
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 06:03:15 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50298 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964962AbXCALDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 06:03:13 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070301110312.SFBK24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 1 Mar 2007 06:03:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id VP3B1W00L1kojtg0000000; Thu, 01 Mar 2007 06:03:12 -0500
In-Reply-To: <7vr6s9th4f.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 01 Mar 2007 02:04:00 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41083>

Junio C Hamano <junkio@cox.net> writes:

> we should make two kinds of configuration.  Classification of
> paths is property of the project and does not depend on where
> the user uses the paths from the project:
> ...
> while how they are handled can be platform dependent.  On UNIX,
> you might have this in $HOME/.gitconfig:
>
> 	[handler "a/v"]
>         	pretty = "cmd xine %s" ; nb. there is no 'cmd' yet...
> 	[handler "text"]
> 		pretty = "pipe fmt -"
>
> while on another system, you might have:
>
> 	[handler "a/v"]
>         	pretty = "cmd mediaplayer %s"
> 	[handler "text"]
>                 conv_i = crlf
>                 conv_o = crlf

Once we separate out the handler section, we can introduce more
useful variables in it (not the "pretty", whose sole purpose was
to have fun and serve as a demonstration).  Obvious ones are:

	; takes temporary files old, mine, his and writes the
        ; result in another
	merge = "cmd external-merge-command %s %s %s %s"

	; takes two temporary files
        diff = "cmd external-diff-command %s %s"
