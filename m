From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Bisect: add checks at the beginning of "git bisect run".
Date: Mon, 26 Mar 2007 22:28:13 -0700
Message-ID: <7vzm5zs1aq.fsf@assigned-by-dhcp.cox.net>
References: <20070327064957.34dad72a.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Mar 27 07:28:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HW4EG-0008OI-BJ
	for gcvg-git@gmane.org; Tue, 27 Mar 2007 07:28:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753221AbXC0F2P (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Mar 2007 01:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753293AbXC0F2P
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Mar 2007 01:28:15 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64733 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbXC0F2O (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2007 01:28:14 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070327052815.ZJWO1606.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 27 Mar 2007 01:28:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id fhUD1W00J1kojtg0000000; Tue, 27 Mar 2007 01:28:13 -0400
In-Reply-To: <20070327064957.34dad72a.chriscool@tuxfamily.org> (Christian
	Couder's message of "Tue, 27 Mar 2007 06:49:57 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43228>

Christian Couder <chriscool@tuxfamily.org> writes:

> diff --git a/git-bisect.sh b/git-bisect.sh
> index fda1712..57d6754 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -223,6 +223,14 @@ bisect_replay () {
>  }
>  
>  bisect_run () {
> +    # Check that we have everything to run correctly.
> +    test -d "$GIT_DIR/refs/bisect" || {
> +	echo >&2 'You need to start by "git bisect start".'
> +	echo >&2 'And then by "git bisect bad" and "git bisect good".'
> +	exit 1
> +    }
> +    bisect_next_check fail
> +

I think you shouldn't need the first "test -d blah"; doesn't
"bisect_next_check fail" already give that message?

>      while true
>      do
>        echo "running $@"
> -- 
> 1.5.1.rc2.2.gcc08
