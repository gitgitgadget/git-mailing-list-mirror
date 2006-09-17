From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb fix validating pg (page) parameter
Date: Sun, 17 Sep 2006 14:21:16 -0700
Message-ID: <7vlkoi2nqr.fsf@assigned-by-dhcp.cox.net>
References: <20060917115245.GA15658@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 17 23:21:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GP44o-0005sD-F0
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 23:21:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965107AbWIQVVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Sep 2006 17:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965111AbWIQVVT
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Sep 2006 17:21:19 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4551 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965107AbWIQVVT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Sep 2006 17:21:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060917212118.KOI2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Sun, 17 Sep 2006 17:21:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PZM61V0031kojtg0000000
	Sun, 17 Sep 2006 17:21:06 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <20060917115245.GA15658@moooo.ath.cx> (Matthias Lederhofer's
	message of "Sun, 17 Sep 2006 13:52:45 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27206>

Matthias Lederhofer <matled@gmx.net> writes:

> Currently it is possible to give any string ending with a number as
> page.  -1 for example is quite bad (error log shows probably 100
> warnings).
>
> @@ -259,7 +259,7 @@ if (defined $hash_parent_base) {
>  
>  our $page = $cgi->param('pg');
>  if (defined $page) {
> -	if ($page =~ m/[^0-9]$/) {
> +	if ($page =~ m/[^0-9]/) {
>  		die_error(undef, "Invalid page parameter");
>  	}
>  }

Are we complaining if $page is not a validly formatted number
here?  If so why not

	unless ($page =~ /^\d+$/ && 1 <= $page) {
        	barf(...);
	}

???
