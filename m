From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Remove empty ref directories that prevent creating a ref.
Date: Sun, 24 Sep 2006 13:46:09 -0700
Message-ID: <7vy7s96lim.fsf@assigned-by-dhcp.cox.net>
References: <20060924223317.caf467a3.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 24 22:46:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRarf-0004yf-97
	for gcvg-git@gmane.org; Sun, 24 Sep 2006 22:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085AbWIXUqM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Sep 2006 16:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWIXUqM
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Sep 2006 16:46:12 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:56503 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932085AbWIXUqL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Sep 2006 16:46:11 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060924204610.XERS21457.fed1rmmtao07.cox.net@fed1rmimpo02.cox.net>;
          Sun, 24 Sep 2006 16:46:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id SLmC1V00C1kojtg0000000
	Sun, 24 Sep 2006 16:46:12 -0400
To: Christian Couder <chriscool@tuxfamily.org>
In-Reply-To: <20060924223317.caf467a3.chriscool@tuxfamily.org> (Christian
	Couder's message of "Sun, 24 Sep 2006 22:33:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27695>

Christian Couder <chriscool@tuxfamily.org> writes:

> +if [ -d "$GIT_DIR/refs/heads/$branchname" ]
> +then
> +	for refdir in `find "$GIT_DIR/refs/heads/$branchname" -type d | sort -r`
> +	do
> +		rmdir "$refdir" || \
> +		    die "Could not delete '$refdir', " \
> +		    "there may still be a ref there."
> +	done
> +fi

I do not think this loop is safe when $GIT_DIR contains any $IFS
character.
